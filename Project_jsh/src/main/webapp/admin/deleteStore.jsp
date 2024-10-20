<%@page import="my.store.StoreDao"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String snum = request.getParameter("snum");
	String img = request.getParameter("img");
	
	String configFolder = config.getServletContext().getRealPath("/images");
	File file = new File(configFolder,img);
	if(file.exists()) {
	    if(file.delete()){
	    	System.out.println("파일 삭제 성공");
	    }
	}

	String str;
	StoreDao adao = StoreDao.getInstance();
	int cnt = adao.deleteStore(snum);  
	if(cnt>0){
		str = "상품 삭제 성공"; 
	} else{
		str = "상품 삭제 실패";
	}
%>
    <script>
		alert('<%=str%>');
		location.href = "storeList.jsp";
	</script>