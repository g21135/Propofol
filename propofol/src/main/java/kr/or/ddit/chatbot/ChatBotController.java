package kr.or.ddit.chatbot;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ibm.watson.developer_cloud.assistant.v1.Assistant;
import com.ibm.watson.developer_cloud.assistant.v1.model.InputData;
import com.ibm.watson.developer_cloud.assistant.v1.model.MessageOptions;
import com.ibm.watson.developer_cloud.assistant.v1.model.MessageResponse;
import com.ibm.watson.developer_cloud.service.security.IamOptions;

@Controller
@RequestMapping(value="/chatbot")
public class ChatBotController {
	
	static String iamApiKey = "mxgJIwwoERnK5a3F2fXJaSnWXtl1NQ5CFQFTX6UGaHiK";
	static String iamUrl = "https://gateway-syd.watsonplatform.net/assistant/api";
	static String assistantId = "fc121de1-d255-416c-b41f-164ee0e3a563";
	static String version = "2019-02-28";

	@PostMapping
	@ResponseBody
	public Map<String, Object> input(@RequestParam String inputText) {
		Map<String, Object> resultMap = new HashMap<>();
		IamOptions iamOptions = new IamOptions.Builder().apiKey(iamApiKey).build();
		Assistant service = new Assistant(version, iamOptions);
		InputData input = new InputData.Builder(inputText).build();
		MessageOptions options = new MessageOptions.Builder(assistantId).input(input).build();
		MessageResponse response = service.message(options).execute();
		System.out.println(response);
		List<String> message = response.getOutput().getText();
		resultMap.put("response", message);
		return resultMap;
	}
}
