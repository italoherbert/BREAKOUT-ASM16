package burner;


import java.io.File;
import java.io.IOException;
import java.text.DecimalFormat;

import burner.lib.CMDUtil;

public class WriteInDevice {

	public static String DEVICE = "/dev/sdb";	
		
	private CMDUtil cmd = new CMDUtil(); 
	private ASMWriter asmWriter = new ASMWriter( cmd );
	
	public static void main( String[] args ) {
		WriteInDevice writer = new WriteInDevice();
		try {
			writer.getAsmWriter().build();
			writer.writeInDevice();
		} catch (IOException e) {
			System.err.println( e.getMessage() );
		}
	}
	
	public void writeInDevice() throws IOException {
		try {			
			File file = new File( DEVICE );
			boolean exists = file.exists();
			if( !exists )
				System.out.println( "Dispositivo não encontrado ou inacessível.");			
			System.out.println( "DISPOSITIVO = "+DEVICE );				
			
			if( exists ) {								
				float size = asmWriter.writeInDisk( DEVICE );											
				size /= 1024.0f;
				DecimalFormat format = new DecimalFormat( "0.00" );
				System.out.println( "Gravou. Tamanho do programa = "+format.format( size )+" KB(s)" ); 						
			}
		} catch (IOException e) {
			e.printStackTrace();
			throw new IOException( "Houve uma falha na gravação para o dispositivo" );
		}	
	}

	public ASMWriter getAsmWriter() {
		return asmWriter;
	}	
	
}
