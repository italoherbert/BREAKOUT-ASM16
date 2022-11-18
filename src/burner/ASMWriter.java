package burner;

import java.io.IOException;

import burner.lib.CMDUtil;

import sysimg.BinUtil;

public class ASMWriter {
	
	public static String ASM_DIR = "assembly/";
	public static String BIN_ASM_DIR = ASM_DIR+"bin/";

	public static String BOOT_NAME = "boot";
	public static String FLOPPY_BOOT_NAME = "floppyboot";
	public static String KERNEL_NAME = "kernel";
	public static String PROGRAM_NAME = "breakout";
	
	public static String BIN_EXT = ".bin";
	
	public static String MBR_BIN = BIN_ASM_DIR + BOOT_NAME + BIN_EXT;
	public static String FLOPPY_MBR_BIN = BIN_ASM_DIR + FLOPPY_BOOT_NAME + BIN_EXT;
	public static String KERNEL_BIN = BIN_ASM_DIR + KERNEL_NAME + BIN_EXT;
	public static String PROGRAM_BIN = BIN_ASM_DIR + PROGRAM_NAME + BIN_EXT;
	
	public static byte[] MBR_SIGN = { (byte)0x55, (byte)0xAA };
	
	private BinUtil binUtil = new BinUtil();
	private CMDUtil cmd;
	
	public ASMWriter( CMDUtil cmd ) {
		this.cmd = cmd;
	}
	
	public void build() throws IOException {
		cmd.exec( "assembly/buildall "+BOOT_NAME+" "+FLOPPY_BOOT_NAME+" "+KERNEL_NAME+" "+PROGRAM_NAME );
	}
	
	public long writeInFloppy( String imageOut ) throws IOException {
		return write( imageOut, FLOPPY_MBR_BIN );
	}
	
	public long writeInDisk( String imageOut ) throws IOException {
		return write( imageOut, MBR_BIN );
	}	
	
	private long write( String imageOut, String mbrbin ) throws IOException {
		//util.writeBinFile( DEVICE, KERNEL_BIN, 512 );
		//util.writeBinFile( DEVICE, PROGRAM_BIN, 32256 );
		//util.writeData( DEVICE, "ITALO HERBERT\0".getBytes(), 64512 );
		
		binUtil.writeBinFile( imageOut, mbrbin );
		binUtil.writeData( imageOut, MBR_SIGN, 510 );
		return binUtil.writeBinFile( imageOut, PROGRAM_BIN, 512 );											
	}		
	
}
