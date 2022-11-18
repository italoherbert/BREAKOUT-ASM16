package burner;


import java.io.File;
import java.io.IOException;
import java.text.DecimalFormat;

import burner.lib.CMDUtil;
import burner.lib.Emulator;

public class WriteInSystemIMG {

	public static String PENDRIVE_IMAGE = "pendrive.img";	
	public static String FLOPPY_IMAGE = "floppy.img";
	
	private CMDUtil cmd = new CMDUtil(); 
	private ASMWriter asmWriter = new ASMWriter( cmd );
	private Emulator emulator = new Emulator( cmd );
		
	public static void main( String[] args ) {
		WriteInSystemIMG writer = new WriteInSystemIMG();
		try {
			writer.getAsmWriter().build();
			writer.buildFloppyImage();
			writer.buildPendriveImage();
			writer.getEmulator().execInQEmu( PENDRIVE_IMAGE );	
		} catch (IOException e) {
			System.err.println( e.getMessage() );
		}
	}
		
	public void buildFloppyImage() throws IOException {
		try {			
			File file = new File( FLOPPY_IMAGE );
			boolean exists = file.exists();
			if( exists )
				file.delete();
			file.createNewFile();
			
			float size = asmWriter.writeInFloppy( FLOPPY_IMAGE );											
			size /= 1024.0f;
			DecimalFormat format = new DecimalFormat( "0.00" );
			System.out.println( "Tamanho do programa: "+format.format( size )+" KB(s)" ); 						
		} catch (IOException e) {
			throw new IOException( "Houve uma falha na gravação ou execução do sistema." );
		}	
	}
	
	public void buildPendriveImage() throws IOException {
		try {			
			File file = new File( PENDRIVE_IMAGE );
			boolean exists = file.exists();
			if( !exists )
				System.out.println( "Imagem de pendrive não criada.");			
			System.out.println( "Imagem de pendrive = "+PENDRIVE_IMAGE );				
			
			if( exists )								
				asmWriter.writeInDisk( PENDRIVE_IMAGE );			
		} catch (IOException e) {
			throw new IOException( "Houve uma falha na gravação ou execução do sistema." );
		}	
	}		
	
	public ASMWriter getAsmWriter() {
		return asmWriter;
	}

	public Emulator getEmulator() {
		return emulator;
	}
	
}
