<%@page import="java.io.File"%>
<%@page import="my.animal.AnimalDao"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	
	//C:\JSP_jsh\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Project_jsh\admin\images
	String uploadDir = config.getServletContext().getRealPath("/images"); // 미리 만들어 놓기
	System.out.println(uploadDir);
	
	// MultipartRequest 객체 생성
	MultipartRequest mr = new MultipartRequest(
			request,
			uploadDir,
			1024*1024*10,
			"UTF-8",
			new DefaultFileRenamePolicy()
	);
	
	String configFolder = config.getServletContext().getRealPath("/images");
	File file = new File(configFolder,mr.getParameter("orimg"));
	if(mr.getOriginalFileName("img")!=null){		
		if(file.exists()) {
		    if(file.delete()){ 
		    	System.out.println("기존 이미지파일 삭제 성공");
		    }
		}
	}
	
	AnimalDao adao = AnimalDao.getInstance();  
	int cnt = adao.updateAnimal(mr); 
	String str;
	if(cnt>0){
		str = "동물 수정 성공";
	} else {
		str = "동물 수정 실패";
	}
%>
	<script>
		alert("<%=str%>");
		location.href = "animalView.jsp?anum=<%=mr.getParameter("anum")%>";
	</script>