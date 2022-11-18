package test;

import java.text.DecimalFormat;

public class Test {

	public static void main(String[] args) {
		//test6();			
		System.out.println( Math.toDegrees( Float.intBitsToFloat( 0x40A799B6 ) ) );		
	}
	
	public static void test7() {
		float i = -0.4f;
		float atan1 = (float)Math.atan( i );
		float atan2 = atan( i );			
		
		System.out.print( flformat(i)+"  "+hex(i)+" --> "+hex( atan1 )+"  "+hex( atan2 ) ); 			
		System.out.println( "  "+ flformat( atan1 )+"  "+flformat( atan2 ) );		
	}
	
	public static void test6() {
		for( float i = -1; i <= 1; i+=0.2 ) {
			System.out.print( flformat(i)+"  "+hex(i)+" --> "+hex( (float)Math.atan( i ) )+"  "+hex( atan( i ) ) ); 			
			System.out.println( "  "+ flformat((float)Math.atan( i ))+"  "+flformat( atan( i ) ) ); 			
		}
	}
		
	public static void test5() {
		for( int i = 180; i <= 360; i+=30 ) {
			float ang = (float)Math.toRadians( i );
			float sin = sin( ang );
			float cos = cos( ang );
			System.out.println( i+"\t"+hex(sin)+"\t"+hex(cos) );
		}
	}
	
	public static void test4() {
		for( int i = -360; i <= 360; i+=30 ) {
			float angle = (float)Math.toRadians( i );
			float cos1 = (float)Math.cos( angle );
			float cos2 = cos( angle );
			System.out.println( "\t"+flformat(cos1)+"\t"+flformat(cos2) );
		}
	}
	
	public static void test3() {
		for( int i = -180; i <= 180; i+=30 ) {
			float angle = (float)Math.toRadians( i );
			float sen1 = (float)Math.sin( angle );
			float sen2 = sin( angle );
			System.out.println( "Seno( "+i+", "+hex(i)+" ) --> "+hex( sen1 )+"   "+hex( sen2 ) );
		}
	}
	
	public static void test2() {
		for( int i = -180; i < 180; i+=30 ) {
			float ang = (float)Math.toRadians( i );
			float sin = (float)Math.sin( ang );
			float cos = (float)Math.cos( ang );
			float sin2 = sin( ang );
			float cos2 = cos( ang );
			//System.out.println( hex(i)+" --> "+hex(ang)+"  "+( sin )+"  "+(sin2)+"  "+(cos)+"  "+(cos2) );
			System.out.println( flformat(sin)+"\t"+flformat(sin2)+"\t"+flformat(cos)+"\t"+flformat(cos2) );
		}
	}
	
	public static void test1() {
		for( int i = 0; i < 360; i+=30 ) {
			float angle = (float)i;
			float f = (float) Math.toRadians( angle );
			float sin = (float)Math.sin( f );
			System.out.println( "Rad( "+hex(i)+" ) --> "+hex( angle )+"   "+hex(f)+"   "+hex(sin) ); 
		}
	}
	
	public static String flformat( float f ) {
		if( f < 0 )
			return new DecimalFormat( "000.000000" ).format( f ); 
		return new DecimalFormat( " 000.000000" ).format( Math.abs( f ) ); 
	}
	
	public static float hextofl( int hex ) {
		return Float.intBitsToFloat( hex );
	}
	
	public static String hex( float f ) {
		int bits = Float.floatToIntBits( f );
		return hex( bits );
	}
	
	public static String hex( int bits ) {
		return Integer.toHexString( bits ).toUpperCase();
	}
	
	public static void prtIEEE754( float f ) {
		int bits = Float.floatToIntBits( f );
		String value = Integer.toBinaryString( bits );
		System.out.print( value.substring( 0, 1 )+"  " ); 
		System.out.print( value.substring( 1, 9 )+"  " ); 
		System.out.print( value.substring( 9, 12 )+" " ); 
		System.out.print( value.substring( 12, 16 )+" " ); 
		System.out.print( value.substring( 16, 20 )+" " ); 
		System.out.print( value.substring( 20, 24 )+" " ); 
		System.out.print( value.substring( 24, 28 )+" " ); 
		System.out.print( value.substring( 28, 32 )+" " ); 
	}
	
	public static float sin( float x ) {
		return sinorcos( x, 1 );
	}
	
	public static float cos( float x ) {
		return sinorcos( x, 0 );
	}
	
	public static float atan( float x ) {
		float atan = 0;
		for( int n = 0; n <= 3; n++ ) {
			float s = pow( -1, n );
			int e = 2*n + 1;
			float num = pow( x, e );
			float termo1 = (num / e);
			float termo = termo1 * s;
			atan += termo;
		}
		return atan;
	}
	
	public static float sinorcos( float x, int einc ) {		
		float[] norm = ( einc == 1 ? sinnorm( x ) : cosnorm( x ) );
		float angle = norm[0];
		float s = norm[1];
		float sin = 0;
		for( int n = 0; n <= 3; n++ )
			sin += ( pow( -1, n ) * pow( angle, 2*n + einc ) ) / fat( 2*n + einc );							
		return s * sin;
	}
				
	public static float pow( float x, int n ) {
		float p = 1;
		for( int i = 0; i < n; i++ )
			p *= x;
		return p;		
	}
	
	public static int fat( int n ) {
		int f = 1;
		for( int i = 2; i <= n; i++ )
			f *= i;		
		return f;
	}
	
	public static float[] sinnorm( float phi ) {		
		int f = (int)( ( Math.abs( (float)phi ) / (float)Math.PI ) );
		float theta = Math.abs(phi) - (((float)f)*((float)Math.PI));
			
		if( theta >= ((float)Math.PI)*.5f )						
			theta = ((float)Math.PI) - theta;
		
		int s = (int)( phi / (float)Math.abs( phi ) );
		if( s < 0 )
			f += 1;
		
		int s2 = 1;
		if( f % 2 == 1 )
			s2 = -1;
															
		return new float[] { theta, s2 };				
	}
	
	public static float[] cosnorm( float phi ) {
		int f = (int)( ( Math.abs( (float)phi ) / (float)Math.PI ) );
		float theta = Math.abs(phi) - (((float)f)*((float)Math.PI));
		
		boolean quadrante2 = theta >= ((float)Math.PI)*.5f; 
		if( quadrante2 )
			theta = ((float)Math.PI) - theta;
						
		float s = 1;
		if( f % 2 == 0 ) {
			if( quadrante2 )
				s = -1;			
		} else {
			if( !quadrante2 )
				s = -1;
		}
																					
		return new float[]{ theta, s };
	}
	
}
