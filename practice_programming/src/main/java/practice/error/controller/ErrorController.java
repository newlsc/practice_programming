package practice.error.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.NoHandlerFoundException;

@ControllerAdvice
public class ErrorController {
	
	private static final Logger logger = LoggerFactory.getLogger("ErrorController");

	@ExceptionHandler(Exception.class)
	public String exception(Exception ex) {
		logger.info("Exception : "+ex.getMessage());
		return "error/500_error";
	}
	
	@ExceptionHandler(NoHandlerFoundException.class)
	@ResponseStatus(HttpStatus.NOT_FOUND)
	public String handel404(NoHandlerFoundException ex) {
		logger.info("Exception : "+ex.getMessage());
		return "error/404_error";
	}
	
}
