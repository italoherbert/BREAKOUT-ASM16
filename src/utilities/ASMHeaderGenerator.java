package utilities;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintStream;
import java.util.StringTokenizer;


public class ASMHeaderGenerator {

	public static void main(String[] args) throws IOException {
		if( args.length < 3 || args.length > 5 ) {
			System.err.println( "Informe entre 3 e 5 parametros." );
			System.err.println( "Nº parametros informados="+args.length );
			System.exit( 0 );
		}
		
		int segment = integerValue( args[0] ); 
		int offset = integerValue( args[1] ); 
				
		String fileName = args[2];
		
		String fileInputPath = "";
		String fileOutputPath = "";		
		if( args.length > 3 ) {
			fileInputPath += args[3]+"/";
			fileOutputPath += ( args.length > 3 ? args[4] : args[3] ) + "/";			
		}
		fileInputPath += fileName + ".map";
		fileOutputPath += fileName + ".asmh";
		
		File fileInput = new File( fileInputPath );
		File fileOutput = new File( fileOutputPath );
		if( !fileInput.exists() ) {
			System.err.println( "Arquivo não encontrado: "+fileInput.getAbsolutePath() );
			System.exit( 0 );
		}		
			
		if( !fileOutput.exists() )
			fileOutput.createNewFile();
		InputStream in = new FileInputStream( fileInput );
		OutputStream out = new FileOutputStream( fileOutput );
		
		BufferedReader input = new BufferedReader( new InputStreamReader( in ) );									
		PrintStream writer = new PrintStream( out );
		
		writeBeginHeaderFile( writer, fileName, segment );
		
		String line = input.readLine();
		boolean found = false;
		while( !found && line != null ) {
			if( line.indexOf( "Section .data" ) > -1 )
				found = true;				
			line = input.readLine();
		}
		if( line != null )
			line = input.readLine();
		if( line != null )
			line = input.readLine();
		boolean end = false;
		while( !end && line != null ) {
			StringTokenizer tokenizer = new StringTokenizer( line );
			if( tokenizer.countTokens() == 3 ) {
				String realAddr = tokenizer.nextToken();
				tokenizer.nextToken();
				String label = tokenizer.nextToken();
				
				if( label.indexOf('.') == -1 ) {
					int addr = offset + Integer.parseInt( realAddr, 16 );
												
					writeProcHeader( writer, label, addr );
				}
				
				line = input.readLine();
			} else {
				end = true;
			}
		}
		
		writeEndHeaderFile( writer );
			
		in.close();
		out.close();	
				
		System.out.println( "Arquivo gerado: "+fileOutputPath );		
	}
	
	public static int integerValue( String param ) {
		int value = -1;
		String p = param;
		if( p.length() >= 2 ) {
			if( p.substring(0, 2).equals( "0x" ) ) {
				p = p.replace( "0x", "" );
				value = Integer.parseInt( p, 16 );
			}
		}
		if( value == -1 )
			value = Integer.parseInt( p );
		return value;
	}
	
	public static void writeBeginHeaderFile( PrintStream out, String fileName, int segment ) {
		String hconst = fileName.toUpperCase() + "_ASMH";		
		out.println( "%ifndef " + hconst );
		out.println( "\t%define " + hconst );
		out.println();
		out.println( "section .data" );
		out.println();
		writeProcHeader( out, fileName.toLowerCase()+"_segment", segment );
		out.println();
	}
	
	public static void writeProcHeader( PrintStream out, String label, int addr ) {
		String address = Integer.toHexString( addr ).toUpperCase();
		
		out.println( "\t" + label + ": equ 0x" + address );
	}
	
	public static void writeEndHeaderFile( PrintStream out ) {
		out.println();
		out.println( "%endif" );		
	}
	
}
