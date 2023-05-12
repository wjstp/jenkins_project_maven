package com.example.cloudaiservice;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

@RestController
public class TransController {
    @PostMapping("/trans")
    public String encodingTrans(String msg, String lang)//text: 입력한 문장, lang: 나라별 기호
    {
        String jsonData="";
        String clientId = "o4u2p1o018";//애플리케이션 클라이언트 아이디값";
        String clientSecret = "wAePL1FFxtbxaFO5x86fHm428CDP75XNWj1bR9Wm";//애플리케이션 클라이언트 시크릿값";
        try {
            String text = URLEncoder.encode(msg, "UTF-8");
            String apiURL = "https://naveropenapi.apigw.ntruss.com/nmt/v1/translation";
            URL url = new URL(apiURL);
            HttpURLConnection con = (HttpURLConnection)url.openConnection();
            con.setRequestMethod("POST");
            con.setRequestProperty("X-NCP-APIGW-API-KEY-ID", clientId);
            con.setRequestProperty("X-NCP-APIGW-API-KEY", clientSecret);
            // post request
            String postParams = "source=auto&target="+lang+"&text=" + text;//내가 입력한 단어 코드를 반영해서 번역하게끔 코드 수정
            con.setDoOutput(true);
            DataOutputStream wr = new DataOutputStream(con.getOutputStream());
            wr.writeBytes(postParams);
            wr.flush();
            wr.close();
            int responseCode = con.getResponseCode();
            BufferedReader br;
            if(responseCode==200) { // 정상 호출
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            } else {  // 오류 발생
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }
            String inputLine;
            StringBuffer response = new StringBuffer();
            while ((inputLine = br.readLine()) != null) {
                response.append(inputLine);
            }
            br.close();
            System.out.println(response.toString());
            //번역할 데이터를 변수에 저장
            jsonData=response.toString();
        } catch (Exception e) {
            System.out.println(e);
        }

        return jsonData;
    }

}
