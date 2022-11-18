package utilities;


import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.util.StringTokenizer;



public class TCBinBuilder {
	
	public static void main( String[] args ) throws IOException {
		if( args.length != 1 ) {
			System.err.println( "Eh preciso informar o nome do arquivo de entrada." );
			System.exit( 0 );
		}
		
		String fileName = args[0];
		
		File fileInput = new File( fileName+".txt" );
		File fileOutput = new File( fileName+".dat" );
		if ( fileOutput.exists() )
			fileOutput.delete();
		fileOutput.createNewFile();
	
		// tamanho (em bytes) do arquivo de entrada
		int filesize = fileSize( fileInput );
		
		InputStream in = new FileInputStream( fileInput );
		OutputStream out = new FileOutputStream( fileOutput );
								
		BufferedReader input = new BufferedReader( new InputStreamReader( in ) );									
		
		int ah = filesize >> 8;
		int al = filesize << 8;
		al >>= 8;		
						
		out.write( al );
		out.write( ah );
		
		int s1 = 0;
		int s2 = 0;
		int s3 = 0;
		
		String line = nextLine( input );
		if( line != null ) {
			StringTokenizer st = new StringTokenizer( line );
			s1 = Integer.parseInt( st.nextToken() );
			s2 = Integer.parseInt( st.nextToken() );
			s3 = Integer.parseInt( st.nextToken() );
			out.write( s1 );
			out.write( s2 );
			out.write( s3 );
		}
				
		line = nextLine( input );
		while( line != null ) {
			StringTokenizer tokenizer = new StringTokenizer( line );
			processValue( out, tokenizer, s1 );
			processValue( out, tokenizer, s2 );
			processValue( out, tokenizer, s3 );
			
			line = nextLine( input );
		}
			
		in.close();
		out.close();		
		
		System.out.println( "Arquivo gerado: "+fileName+".dat" );
	}
	
	public static void processValue( OutputStream out, StringTokenizer tokenizer, int valueSize ) throws IOException { 		
		String[] tokens = new String[ valueSize ];
		for( int i = 0; i < valueSize; i++ )
			tokens[i] = tokenizer.nextToken();
		
		for( int i = valueSize-1; i >= 0; i-- ) {
			int b = processToken( tokens[i] );
			out.write( b );
		}
	}
	
	public static int processToken( String token ) {
		int b = 0x00;
		if( token.toUpperCase().equals( "TRUE" ) ) {
			b = 0x01;
		} else if( token.toUpperCase().equals( "FALSE" ) ) {
			b = 0x00;
		} else if( token.toUpperCase().equals( "ABOVE" ) ) {
			b = 0x01;
		} else if( token.toUpperCase().equals( "BELOW" ) ) {
			b = 0x81;
		} else if( token.toUpperCase().equals( "EQUAL" ) ) {
			b = 0x00;
		} else {
			b = hexstrtoint( token );
		}
		return b;
	}	
	
	
	public static int hexstrtoint( String hex ) {
		int n = 0;
		for( int i = hex.length()-1; i >= 0; i-- ) {
			int b = (int)hex.charAt( i );
			b -= 48;
			if( b > 48 ) {
				b -= 49;
				b += 10;
			} else if( b > 16 ) {
				b -= 17;
				b += 10;
			}
			b *= Math.pow( 16, hex.length()-i-1 );
			n += b;
		}
		return n;
	}
	
	public static String nextLine( BufferedReader input ) throws IOException {
		String line = input.readLine();
		
		boolean next = true;		
		while ( next ) {
			if ( line != null )
				if( line.isEmpty() )
					line = input.readLine();
				else next = false;
			else next = false;
		}
		return line;
	} 
	
	public static int fileSize( File file ) throws IOException {
		int size = 2;		
		
		BufferedReader input = new BufferedReader( 
				new InputStreamReader(
						new FileInputStream( file ) ) );		
		String line = input.readLine();
		while( line != null ) {
			StringTokenizer tokenizer = new StringTokenizer( line );
			size += tokenizer.countTokens();			
			line = input.readLine();
		}		
		input.close();
		
		return size;
	}

}
