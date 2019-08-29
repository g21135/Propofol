package kr.or.ddit.community.controller;

import java.util.List;
import java.util.Map;

import org.apache.http.client.HttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;


@Controller
public class RestTemplateEx {
	
	@RequestMapping(value="/RestTemplateEx", method = RequestMethod.GET, produces="application/xml;charset=UTF-8")
	@ResponseBody
	public String restTemplate(
			@RequestParam(value="keywords",required=false,defaultValue="")String keywords,
			@RequestParam(value="stock",required=false,defaultValue="")String stock,
			@RequestParam(value="loc_bcd",required=false,defaultValue="")String loc_bcd,
			@RequestParam(value="sjob_category",required=false,defaultValue="")String sjob_category,
			@RequestParam(value="edu_lv",required=false,defaultValue="")String edu_lv,
			@RequestParam(value="job_type",required=false,defaultValue="")String job_type
			){
		HttpComponentsClientHttpRequestFactory factory = new HttpComponentsClientHttpRequestFactory();
		factory.setReadTimeout(5000); // 읽기시간초과, ms 
		factory.setConnectTimeout(3000); // 연결시간초과, ms 
		HttpClient httpClient = HttpClientBuilder.create() 
				.setMaxConnTotal(100) // connection pool 적용 
				.setMaxConnPerRoute(5) // connection pool 적용
				.build();
		factory.setHttpClient(httpClient); // 동기실행에 사용될 HttpClient 세팅 
		RestTemplate restTemplate = new RestTemplate(factory); 
		
//		헤더추가
		HttpHeaders headers = new HttpHeaders();
		headers.set("Accept", MediaType.APPLICATION_XML_VALUE);
		
		
		HttpEntity entity = new HttpEntity(headers);
		String url = "https://oapi.saramin.co.kr/job-search?access-key=glQ8wsw79u3iAROPsFTgdehUHj94ejROwEADbVNDscuWwHRl7wXW&keywords="+keywords+"&stock="+stock +"&loc_mcd="+loc_bcd +"&job_category="+sjob_category+"&edu_lv="+edu_lv +"&job_type="+job_type+"&fields=posting-date"+'+'+"expiration-date&count=110";
		
		factory.setHttpClient(httpClient); // 동기실행에 사용될 HttpClient 세팅 
		
		ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.GET, entity, String.class);
		System.out.println(response.getBody());
//		RestTemplateVO result = response.getBody();
		return response.getBody();
	}
	
	
	@RequestMapping(value="/RestTemplateInturn", method = RequestMethod.GET, produces="application/xml;charset=UTF-8")
	@ResponseBody
	public String restTemplateInturn(){
		HttpComponentsClientHttpRequestFactory factory = new HttpComponentsClientHttpRequestFactory();
		factory.setReadTimeout(5000); // 읽기시간초과, ms 
		factory.setConnectTimeout(3000); // 연결시간초과, ms 
		HttpClient httpClient = HttpClientBuilder.create() 
				.setMaxConnTotal(100) // connection pool 적용 
				.setMaxConnPerRoute(5) // connection pool 적용
				.build();
		factory.setHttpClient(httpClient); // 동기실행에 사용될 HttpClient 세팅 
		RestTemplate restTemplate = new RestTemplate(factory); 
		
//		헤더추가 json 인지 xml인지
		HttpHeaders headers = new HttpHeaders();
		headers.set("Accept", MediaType.APPLICATION_XML_VALUE);
		
		HttpEntity entity = new HttpEntity(headers);
		String url = "http://oapi.saramin.co.kr/job-search?access-key=glQ8wsw79u3iAROPsFTgdehUHj94ejROwEADbVNDscuWwHRl7wXW&bbs_gb=0&job_type=4&edu_lv=&count=110&fields=posting-date"+'+'+"expiration-date";
		
		factory.setHttpClient(httpClient); // 동기실행에 사용될 HttpClient 세팅 
		
		ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.GET, entity, String.class);
		System.out.println(response.getBody());
		return response.getBody();
	}
	
	@RequestMapping(value="/RestTemplatetoday", method = RequestMethod.GET, produces="application/xml;charset=UTF-8")
	@ResponseBody
	public String restTemplatetoday(){
		HttpComponentsClientHttpRequestFactory factory = new HttpComponentsClientHttpRequestFactory();
		factory.setReadTimeout(5000); // 읽기시간초과, ms 
		factory.setConnectTimeout(3000); // 연결시간초과, ms 
		HttpClient httpClient = HttpClientBuilder.create() 
				.setMaxConnTotal(100) // connection pool 적용 
				.setMaxConnPerRoute(5) // connection pool 적용
				.build();
		factory.setHttpClient(httpClient); // 동기실행에 사용될 HttpClient 세팅 
		RestTemplate restTemplate = new RestTemplate(factory); 
		
//		헤더추가 json 인지 xml인지
		HttpHeaders headers = new HttpHeaders();
		headers.set("Accept", MediaType.APPLICATION_XML_VALUE);
		String url = "https://oapi.saramin.co.kr/job-search?access-key=glQ8wsw79u3iAROPsFTgdehUHj94ejROwEADbVNDscuWwHRl7wXW&bbs_gb=1&count=110&fields=posting-date"+'+'+"expiration-date";
		
		HttpEntity entity = new HttpEntity(headers);
		
		factory.setHttpClient(httpClient); // 동기실행에 사용될 HttpClient 세팅 
		
		ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.GET, entity, String.class);
		System.out.println(response.getBody());
		return response.getBody();
	}
	
}
