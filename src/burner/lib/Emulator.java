package burner.lib;

import java.io.IOException;

public class Emulator {
	
	public static String VBOX_VM_NAME = "MinhaVM";		

	private CMDUtil cmd;
	
	public Emulator(CMDUtil cmd) {
		this.cmd = cmd;
	}

	public void execInQEmu( String image ) throws IOException {
		cmd.exec( "qemu-system-i386 -no-reboot -sdl -soundhw pcspk "+image );
	}
	
	public void execInVBox() throws IOException {
		boolean ok = cmd.exec( "VBoxManage startvm "+VBOX_VM_NAME+" --type sdl", false );
		if( !ok )
			cmd.exec( "VBoxManage controlvm "+VBOX_VM_NAME+" reset" );	
	}
	
}
