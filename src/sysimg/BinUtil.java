package sysimg;

import java.io.File;
import java.io.IOException;
import java.io.RandomAccessFile;

public class BinUtil {
	
	public final static int FULL_COUNT_MODE = -1;
	public final static int BS = 512;
	
	public boolean create( File newFile, long size ) throws BinException {
		try {
			boolean created = newFile.createNewFile();
			if( !created )
				return false;
			
			RandomAccessFile out = new RandomAccessFile( newFile, "rw" );

			byte[] buffer = new byte[ BS ];
			long count = size / BS;
			long lastbk = size % BS;
			for( long i = 0; i < count; i++ )
				out.write( buffer );			
			if( lastbk > 0 )
				out.write( buffer, 0, (int)lastbk );
			out.close();
			return true;
		} catch (IOException e) {
			throw new BinException( e );
		}
	}

	public void writeData( String outFile, byte[] bytes ) throws InputFNFBinException, OutputFIBinException, BinException {
		this.writeData( outFile, bytes, 0 );
	}
	
	public void writeData( String outFile, byte[] bytes, long seek ) throws InputFNFBinException, OutputFIBinException, BinException {
		if( outFile == null )
			throw new InputFNFBinException();
		File outputFile = new File( outFile ); 
		if( !outputFile.exists() )
			throw new OutputFNFBinException();
		
		try {
			RandomAccessFile out = new RandomAccessFile( outputFile, "rw" );
							
			out.seek( seek );
		
			int n = 0;
			while( n < bytes.length ) {
				int len = ( n+BS < bytes.length ? BS : bytes.length - n - 1 );				
				out.write( bytes, n, len );
				n += BS;
			}
			
			out.close();
		} catch (IOException e) {
			throw new BinException( e );
		}
	}

	public long writeBinFile( String outFile, String inFile ) throws InputFNFBinException, OutputFIBinException, BinException {
		return this.writeBinFile( outFile, inFile, 0 );
	}
	
	public long writeBinFile( String outFile, String inFile, long seek ) throws InputFNFBinException, OutputFIBinException, BinException {
		if( inFile == null )
			throw new InputFNFBinException();
		if( outFile == null )
			throw new InputFNFBinException();
		File inputFile = new File( inFile );
		File outputFile = new File( outFile ); 
		if( !inputFile.exists() )
			throw new InputFNFBinException();
		if( !outputFile.exists() )
			throw new OutputFNFBinException();
		
		long size = 0;
		
		try {
			RandomAccessFile in = new RandomAccessFile( inputFile, "r" );
			RandomAccessFile out = new RandomAccessFile( outputFile, "rw" );
							
			out.seek( seek );
			byte[] buffer = new byte[ BS ];
			int n = in.read( buffer );
			while( n > -1 ) {					
				out.write( buffer, 0, n );
				size += n;
				n = in.read( buffer );
			}
			
			in.close();
			out.close();
		} catch (IOException e) {
			throw new BinException( e );
		}		
		return size;
	}

}
