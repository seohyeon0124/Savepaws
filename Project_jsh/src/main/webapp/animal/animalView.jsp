<%@page import="my.animal.RequestDao"%>
<%@page import="my.animal.AnimalBean"%>
<%@page import="my.animal.AnimalDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../top.jsp"%>
<%@ include file="animal_top.jsp"%>
 
<style>
	.table{
		width: 70%;
		margin-left: auto;
		margin-right: auto;
	}
	.table th, td {
		text-align: center;
	}
	td #red {
		text-decoration: none;
		color: red;
	}
	.btn-danger {
	    background-color: gold !important;
	    border-color: gold !important;
	}
</style>

<script type="text/javascript">
	function request(anum,cate,state,search){
		// alert(anum+","+cate+","+state+","+search);
		if(confirm("정말 신청하시겠습니까?")){
			//alert("yes");
			location.href = "aniRequest.jsp?anum="+anum+"&cate="+cate+"&state="+state+"&search="+search;
		} else{
			//alert("no");
			location.href = "animalView.jsp?anum="+anum+"&cate="+cate+"&state="+state+"&search="+search;
		}
	}
</script>

  <% 
  	String anum = request.getParameter("anum");
  	String cate = request.getParameter("cate");
  	String state = request.getParameter("state");
  	String search = request.getParameter("search");
  	System.out.println("cate : " + cate);
  	System.out.println("state : " + state);
  	System.out.println("search : " + search);
  	AnimalDao anidao = AnimalDao.getInstance();
  	AnimalBean ab = anidao.getAnimalByAnum(anum);
  %>

<table border=1 style="margin: auto; width: 1300px; min-height: 500px">
	<tr>
		<td style="padding: 50px;" align=center>

			<table class="table table-bordered">
			    <tr>
			    	<th class="table-dark" width=25%>번호</th>
			    	<td width=25%><%=ab.getAnum()%></td>
			    	<th class="table-dark" width=25%>카테고리</th>
			    	<td width=25%><%=ab.getCate()%></td>
			    </tr>
			    <tr>
			    	<th class="table-dark">종류</th>
			    	<td><%=ab.getKind()%></td>
			    	<th class="table-dark">나이</th>
			    	<td><%=ab.getAge()%></td>
			    </tr>
			    <tr>
			    	<th class="table-dark">색상</th>
			    	<td>
			    		<%
			    			if(ab.getColor()!=null){
			    				if(ab.getColor().contains("white")){%>○<%}
			    				if(ab.getColor().contains("gray")){%><font color="gray">●</font><%}
			    				if(ab.getColor().contains("black")){%>●<%}
			    				if(ab.getColor().contains("brown")){%><font color="#CC723D">●</font><%}
			    			} else{
			    		%>
			    			등록X
			    		<%
			    			}
			    		%>
			    	</td>
			    	<th class="table-dark">상태</th>
			    	<td><%=ab.getState()%></td>
			    </tr> 
			    <tr>
			    	<th class="table-dark align-middle">이미지</th>
			    	<td colspan=3><img src="<%=request.getContextPath()%>/images/<%=ab.getImg()%>" width=200></td>
			    </tr>
			    <tr>
			    	<th class="table-dark">발견장소</th>
			    	<td><%=ab.getPlace()%></td>
			    	<th class="table-dark align-middle" >구조일</th>
			    	<td class="align-middle"><%=ab.getDay()%></td>
			    </tr>
			    <tr>
			    	<th class="table-dark">소개</th>
			    	<td colspan=3><%=ab.getContent()%></td> 
			    </tr>
			</table>
							<%
			                	String no = String.valueOf(session.getAttribute("no"));
			                	MemberDao mdao = MemberDao.getInstance();
			                	String anilike = mdao.getAni(no,String.valueOf(ab.getAnum()));
			                	
			                	if(anilike!=null){
			                %>
			                	<button type="button" class="btn btn-danger" onclick="location.href='anilikeBtn.jsp?anum=<%=ab.getAnum()%>&cate=<%=cate%>&state=<%=state%>&search=<%=search%>&place=상세'">&nbsp;♥&nbsp;</button>
			                <%
			                	} else{
							%>	                		
			                	<button type="button" class="btn btn-outline-warning" onclick="location.href='anilikeBtn.jsp?anum=<%=ab.getAnum()%>&cate=<%=cate%>&state=<%=state%>&search=<%=search%>&place=상세'">관심</button>
			                <%
			                	}
			                	
			                	RequestDao rdao = RequestDao.getInstance();
			                	String reqState = rdao.getRequestByNo(no,String.valueOf(ab.getAnum()));
			                	if(reqState!=null){
			                %>	                	
			                  <button type="button" class="btn btn-success" onclick="request('<%=ab.getAnum()%>','<%=cate%>','<%=state%>','<%=search%>')"><%=reqState%></button>	                	
			                <%
			                	} else{
			                %>
			                  <button type="button" class="btn btn-outline-success" onclick="request('<%=ab.getAnum()%>','<%=cate%>','<%=state%>','<%=search%>')">신청</button>	                	
			                <%
			                	}
			                %>
			                
							<%
								String place = request.getParameter("place");
								if(place==null){
									place = "basic";
								}
								if(place.equals("관심동물")){
							%>
								<button type="button" class="btn btn-outline-dark" onclick="location.href='anilike.jsp'">돌아가기</button>
							<%
								} else if(place.equals("신청내역")){
							%>
								<button type="button" class="btn btn-outline-dark" onclick="location.href='aniRequestAll.jsp'">돌아가기</button>
							<%
								} else{
							%>
								<button type="button" class="btn btn-outline-dark" onclick="location.href='animal.jsp?cate=<%=cate%>&state=<%=state%>&search=<%=search%>'">돌아가기</button>
							<%
								}
							%>
		</td>
	</tr>
</table>

    
<%@ include file="../bottom.jsp"%>