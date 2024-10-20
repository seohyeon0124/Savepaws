<%@page import="my.store.StorecateBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="my.store.StorecateDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../top.jsp"%> 
<%@ include file="admin_top.jsp"%>

<style>
 	#table{
 		margin: 0 auto;
 	}
 	.font14{
 		font-size: 14px;
 	}
</style>
<script>
	function check(){
		if($('select[name=cate] option:selected').val()=="선택"){
			alert('카테고리를 선택하세요');
			$('select[name=cate]').focus();
			return false;
		}
		if($('input[name=name]').val()==""){
			alert('상품명을 입력하세요');
			$('input[name=name]').focus();
			return false;
		}
		if($('input[name=code]').val()==""){
			alert('상품코드를 입력하세요');
			$('input[name=code]').focus();
			return false;
		}
		if($('input[name=qty]').val()==""){
			alert('상품수량을 입력하세요');
			$('input[name=qty]').focus();
			return false;
		}
		if($('input[name=price]').val()==""){
			alert('상품가격을 입력하세요');
			$('input[name=price]').focus();
			return false;
		}
		if($('input[name=content]').val()==""){
			alert('상품소개를 입력하세요');
			$('input[name=content]').focus();
			return false;
		}
	}
</script>

<form method="post" action="storeProc.jsp" enctype="multipart/form-data">
<table id="table">
<tr>
  <td><br>
	<div class="input-group mb-2">
	  <label class="input-group-text" for="inputGroupSelect01">상품 카테고리</label>
	  <select name="cate" class="form-select custom-width" id="inputGroupSelect01">
	    <option value="선택" selected>선택</option>
	<%
		StorecateDao sdao = StorecateDao.getInstance();
		ArrayList<StorecateBean> cate = sdao.getAllStorecate(); 
		for(StorecateBean sb : cate){
	%>
		<option value="<%=sb.getCatecode()%>"><%=sb.getCatename()%>[<%=sb.getCatecode()%>]</option>
	<%
		}
	%>
	  </select>
	</div>
  </td>
</tr>
<tr>
  <td>
	<div class="input-group mb-2">
	  <span class="input-group-text" id="inputGroup-sizing-default">상품명</span>
	  <input name="name" type="text" class="form-control custom-width" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default">
	</div>
  </td>
</tr>
<tr>
  <td>
	<div class="input-group mb-2">
	  <span class="input-group-text" id="inputGroup-sizing-default">상품코드</span>
	  <input name="code" type="text" class="form-control custom-width" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default">
	</div>
  </td>
</tr>
<tr>
  <td>
	<div class="input-group mb-2">
      <label class="input-group-text" for="inputGroupFile01">이미지</label>
      <input name="img" type="file" class="form-control" id="inputGroupFile01">
    </div>
  </td>
</tr>
<tr>
  <td>
	<div class="input-group mb-2">
	  <span class="input-group-text" id="inputGroup-sizing-default">상품수량</span>
	  <input name="qty" type="text" class="form-control custom-width" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default">
	</div>
  </td>
</tr>
<tr>
  <td>
	<div class="input-group mb-2">
	  <span class="input-group-text" id="inputGroup-sizing-default">상품가격</span>
	  <input name="price" type="text" class="form-control custom-width" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default">
	</div>
  </td>
</tr>
<tr>
  <td>
	<div class="input-group mb-2">
	  <span class="input-group-text" id="inputGroup-sizing-default">상품소개</span>
	  <input name="content" type="text" class="form-control custom-width" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default">
	</div>
  </td>
</tr>
<tr>
  <td align=center>
    <br>
  	<button type="submit" class="btn btn-outline-dark" onclick="return check()">&nbsp;&nbsp;등록하기&nbsp;&nbsp;</button>
  </td>
</tr>
</table>
</form>
	
<%@ include file="admin_bottom.jsp"%>
<%@ include file="../bottom.jsp"%>    

    