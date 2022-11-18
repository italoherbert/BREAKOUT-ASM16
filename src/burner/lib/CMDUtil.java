package burner.lib;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class CMDUtil {

	public boolean exec( String cmd ) throws IOException {
		return exec( cmd, true );
	}
	
	public boolean exec( String cmd, boolean showOutput ) throws IOException {
		boolean ok = true;
		if( showOutput )
			System.out.println( "CMD >> "+cmd );
		
		Runtime runtime = Runtime.getRuntime();
		Process p = runtime.exec( cmd );	
		
		BufferedReader outputReader = new BufferedReader( new InputStreamReader(  p.getInputStream() ) );
		BufferedReader errorReader = new BufferedReader( new InputStreamReader(  p.getErrorStream() ) );		
		String errorLine = errorReader.readLine();
		ok = (errorLine == null);
		
		if( showOutput ) {
			String outputLine = outputReader.readLine();
			while( outputLine != null ) {
				System.out.println( outputLine );
				outputLine = outputReader.readLine();
			}
		}
		outputReader.close();
		
		if( showOutput && !ok ) {
			System.out.println();
			while( errorLine != null ) {
				System.err.println( errorLine );
				errorLine = errorReader.readLine();
			}
			System.out.println();
		}
		errorReader.close();
		
		return ok;
	}
	
}
