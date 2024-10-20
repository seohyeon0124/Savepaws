<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../top.jsp"%> 
<%@ include file="admin_top.jsp"%>

<style>
 	#table{
 		margin: 0 auto;
 	}
</style>
<script>
	function check(){
		if($('input[name=catename]').val()==""){
			alert('카테고리명을 입력하세요');
			$('input[name=catename]').focus();
			return false;
		}
		if($('input[name=code]').val()==""){
			alert('카테고리코드를 입력하세요');
			$('input[name=code]').focus();
			return false; 
		}
	}
</script>

<form method="post" action="cateProc.jsp">
<table id="table">
<tr>
  <td>
	<div class="input-group mb-3">
	  <span class="input-group-text" id="inputGroup-sizing-default">카테고리 이름</span>
	  <input name="catename" type="text" class="form-control custom-width" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default">
	</div>
  </td>
</tr>
<tr>
  <td>
	<div class="input-group mb-3">
	  <span class="input-group-text" id="inputGroup-sizing-default">카테고리 코드</span>
	  <input name="catecode" type="text" class="form-control custom-width" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default">
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
    