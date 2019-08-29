package kr.or.ddit.advice;

import java.util.Arrays;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.Signature;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 
 * Joinpoint : advice + tartget -> weaving되는 지점 및 시점에 대한 정보
 * Spring에서는 메서드 호출 joinpoint만 지원됨	
 * 
 * 스프링에서 advice종류
 * before : target메서드 실행 전
 * after : target메서드 실행 후
 * 	- after-thorwing : 에러가 발생할 시에만 
 *  - after-returning : 정상적으로 target메서드가 호출되면
 *  - after 무조건  : 
 *  - around : 
 *
 */
@Aspect //advice + pointcut
public class LoggingAdvice {
	
	@Pointcut("execution(* kr.or.ddit..service.*.*(..))")
	public void dummy() {};
	
	private Logger logger = LoggerFactory.getLogger(LoggingAdvice.class); 
	
	@Around("dummy()")
	public Object Around(ProceedingJoinPoint joinpoint) throws Throwable { 
		long startTime= System.currentTimeMillis();
		
		//모든 advice를 포괄하고 있는 녀석, 지금은 이친구 위주로 씀
		//around 하나가 나머지 advice를 포괄

		//--------------before--------------
		Object[] args = joinpoint.getArgs();
		//아귀먼트에 대한 정보
		
		Object target= joinpoint.getTarget();
		//target에 대한 정보 
		
		Signature signature = joinpoint.getSignature();
		//시그니처에 대한 정보
		
		String targetMethodName = signature.getName();//targetMethod name
		logger.info("{}.{}가 호출, {} 파라미터 전달",
				target.getClass().getSimpleName(), targetMethodName, Arrays.toString(args)
				);
		
		//--------------target을 직접 호출--------------
		Object retVal = joinpoint.proceed(args);
		
		//--------------after --------------
		long endTime = System.currentTimeMillis();
		logger.info("{}.{} 소요시간 {}ms, 반환데이터 : {}", target.getClass(), targetMethodName, (endTime-startTime),retVal);
		return retVal;
	}
}
