package sysimg;

import java.io.IOException;

public class BinException extends IOException {

	private static final long serialVersionUID = 1L;

	public BinException() {
		super();
	}

	public BinException(String message, Throwable cause) {
		super(message, cause);
	}

	public BinException(String message) {
		super(message);
	}

	public BinException(Throwable cause) {
		super(cause);
	}

	
}
