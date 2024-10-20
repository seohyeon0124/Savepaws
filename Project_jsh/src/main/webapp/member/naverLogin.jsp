<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.parser.JSONParser" %>

<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>네이버로그인</title>
</head>
<body>
<%
	String clientId = "MVkx5_4g4EYT1cvTJLMc";//애플리케이션 클라이언트 아이디값";
	String clientSecret = "aHBuaau0QO";//애플리케이션 클라이언트 시크릿값";
    String code = request.getParameter("code");
    String state = request.getParameter("state");
    String redirectURI = URLEncoder.encode("http://localhost:8080/Project_jsh/member/naverLogin.jsp", "UTF-8");
    String apiURL;
    apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&";
    apiURL += "client_id=" + clientId;
    apiURL += "&client_secret=" + clientSecret;
    apiURL += "&redirect_uri=" + redirectURI;
    apiURL += "&code=" + code;
    apiURL += "&state=" + state;
    String access_token = "";
    String token_type = "";
    System.out.println("apiURL="+apiURL);
    try {
        URL url = new URL(apiURL);
        HttpURLConnection con = (HttpURLConnection)url.openConnection();
        con.setRequestMethod("GET");
        int responseCode = con.getResponseCode();
        BufferedReader br;
        System.out.print("responseCode="+responseCode);
        if(responseCode==200) { // 정상 호출
            br = new BufferedReader(new InputStreamReader(con.getInputStream()));
        } else {  // 에러 발생
            br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
        }
        String inputLine;
        StringBuffer res = new StringBuffer();
        while ((inputLine = br.readLine()) != null) {
            res.append(inputLine);
        }
        br.close();
        if(responseCode==200) {
        	JSONParser parser = new JSONParser();
        	JSONObject json = (JSONObject) parser.parse(res.toString());
        	access_token = (String) json.get("access_token");
        	
            // 여기서부터 프로필 API 호출
            String header = "Bearer " + access_token; // Bearer 다음에 공백 추가
            url = new URL("https://openapi.naver.com/v1/nid/me");
            con = (HttpURLConnection)url.openConnection();
            con.setRequestMethod("GET");
            con.setRequestProperty("Authorization", header);
            responseCode = con.getResponseCode();
            BufferedReader br2;
            if(responseCode==200) {
                br2 = new BufferedReader(new InputStreamReader(con.getInputStream()));
            } else {
                br2 = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }
            StringBuffer res2 = new StringBuffer();
            while ((inputLine = br2.readLine()) != null) {
                res2.append(inputLine);
            }
            br2.close();
            // 여기서 `response` 변수에 사용자 정보가 JSON 형태로 저장됩니다.
            //out.println(res2.toString());
            
        	JSONObject json2 = (JSONObject) parser.parse(res2.toString());
            JSONObject res3 = (JSONObject) json2.get("response");
            String name = (String) res3.get("name");
            String gender = (String) res3.get("gender");
            String age = (String) res3.get("age");
            String phone = (String) res3.get("mobile");
            String email = (String) res3.get("email");
%>
			<form id="loginForm" action="loginProc.jsp" method="POST">
			        <input type="hidden" name="name" value="<%=name%>">
			        <input type="hidden" name="gender" value="<%=gender%>">
			        <input type="hidden" name="age" value="<%=age%>">
			        <input type="hidden" name="phone" value="<%=phone%>">
			        <input type="hidden" name="email" value="<%=email%>">
			        <input type="hidden" name="pw" value="naver">
			</form>
			<script type="text/javascript">
			        document.getElementById('loginForm').submit(); // Form을 자동으로 제출
			</script>
            
<%
        }
    } catch (Exception e) {
        System.out.println(e);
    }
%>

</body>
</html>
    