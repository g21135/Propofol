package kr.or.ddit.kakaoLogin.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;

import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClientBuilder;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import kr.or.ddit.exception.UserNotFoundException;
import kr.or.ddit.member.dao.IMemberDAO;
import kr.or.ddit.utils.SecurityUtils;
import kr.or.ddit.vo.MemberVO;

@Service
public class KakaoAPI {
	
	@Inject
	IMemberDAO memberDAO;
	
    public String getAccessToken (String authorize_code) {
        String access_Token = "";
        String refresh_Token = "";
        String reqURL = "https://kauth.kakao.com/oauth/token";
        
        try {
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            
            //    POST 요청을 위해 기본값이 false인 setDoOutput을 true로
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);
            
            //    POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
            StringBuilder sb = new StringBuilder();
            sb.append("grant_type=authorization_code");
            sb.append("&client_id=59b155def6f27f08bfa207c1585ff2a8");
            sb.append("&redirect_uri=http://localhost/kakao/kakaologin");
            sb.append("&code=" + authorize_code);
            bw.write(sb.toString());
            bw.flush();
            
            //    결과 코드가 200이라면 성공
            int responseCode = conn.getResponseCode();
            System.out.println("responseCode : " + responseCode);
 
            //    요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line = "";
            String result = "";
            
            while ((line = br.readLine()) != null) {
                result += line;
            }
            System.out.println("response body : " + result);
            
            //    Gson 라이브러리에 포함된 클래스로 JSON파싱 객체 생성
            JsonParser parser = new JsonParser();
            JsonElement element = parser.parse(result);
            
            access_Token = element.getAsJsonObject().get("access_token").getAsString();
            refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();
            
            System.out.println("access_token : " + access_Token);
            System.out.println("refresh_token : " + refresh_Token);
            
            br.close();
            bw.close();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } 
        
        return access_Token;
    }
    
    public HashMap<String, Object> getUserInfo (String access_Token) {
        
        //    요청하는 클라이언트마다 가진 정보가 다를 수 있기에 HashMap타입으로 선언
        HashMap<String, Object> userInfo = new HashMap<>();
        String reqURL = "https://kapi.kakao.com/v2/user/me";
        try {
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            
            //    요청에 필요한 Header에 포함될 내용
            conn.setRequestProperty("Authorization", "Bearer " + access_Token);
            
            int responseCode = conn.getResponseCode();
            System.out.println("responseCode : " + responseCode);
            
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            
            String line = "";
            String result = "";
            
            while ((line = br.readLine()) != null) {
                result += line;
            }
            System.out.println("response body : " + result);
            
            JsonParser parser = new JsonParser();
            JsonElement element = parser.parse(result);
            
            
            JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
            JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();
            
            String id = element.getAsJsonObject().get("id").getAsString();
            String nickname = properties.getAsJsonObject().get("nickname").getAsString();
            String email = kakao_account.getAsJsonObject().get("email").getAsString();
            
            String gender = null;
            if(kakao_account.getAsJsonObject().has("gender")){
            	gender = kakao_account.getAsJsonObject().get("gender").getAsString();
            }
            
            String birthday = null;
            if(kakao_account.getAsJsonObject().has("birthday")){
            	birthday = kakao_account.getAsJsonObject().get("birthday").getAsString();
            }
            
            String profile_image = null;
            if(properties.getAsJsonObject().has("profile_image")) {
            	profile_image = properties.getAsJsonObject().get("profile_image").getAsString();
            }
            
            userInfo.put("id", id);
            userInfo.put("nickname", nickname);
            userInfo.put("email", email);
            userInfo.put("birthday", birthday);
            userInfo.put("gender", gender);
            userInfo.put("profile_image", profile_image);
            
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        
        return userInfo;
    }
    
    public void kakaoLogout(String access_Token) {
        String reqURL = "https://kapi.kakao.com/v1/user/logout";
        String result = "";
        String line = "";
        try {
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Authorization", "Bearer " + access_Token);
            
            int responseCode = conn.getResponseCode();
            System.out.println("responseCode : " + responseCode);
            
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            
            while ((line = br.readLine()) != null) {
                result += line;
            }
            
            System.out.println(result);
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }  
    
	public MemberVO retrieveKakao(HashMap<String, Object> userInfo) throws NoSuchAlgorithmException {
		MemberVO member = memberDAO.selectMember((String) userInfo.get("id"));
		if (member == null) {
			// 회원가입 절차
			MemberVO insertMember = new MemberVO();
			insertMember.setMem_id((String) userInfo.get("id"));
			insertMember.setMem_pass(SecurityUtils.sha512((String) userInfo.get("id")));
			insertMember.setMem_name((String) userInfo.get("nickname"));
			insertMember.setMem_tel("소셜동의거부");
			insertMember.setLogin_type(1);

			if (StringUtils.isNotBlank((String) userInfo.get("email"))) {
				insertMember.setMem_mail((String) userInfo.get("email"));
			} else {
				insertMember.setMem_mail("소셜동의거부");
			}
			if (StringUtils.isNotBlank((String) userInfo.get("profile_image"))) {
				insertMember.setMem_image((String) userInfo.get("profile_image"));
			} else {
				insertMember.setMem_image("");
			}
			if (StringUtils.isNotBlank((String) userInfo.get("gender"))) {
				insertMember.setMem_gen(((String) userInfo.get("gender")).equals("female") ? "F" : "M");
			} else {
				insertMember.setMem_gen("N");
			}

			int cnt = memberDAO.insertMember(insertMember);
			if(cnt > 0) {
				member = insertMember;
			}
		}
		return member;
	}
}
    
