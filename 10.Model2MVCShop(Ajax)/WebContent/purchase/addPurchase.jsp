<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
    
<!DOCTYPE html>
<html>
<head>

<script src = "http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type = "text/javascript">

$(function(){
	
	$(".ct_btn01:contains('Ȯ��')").on("click", function(){
		self.location="/purchase/listPurchase";
	});
});

</script>
<title>Insert title here</title>
</head>

<body>

<form name="updatePurchase">

������ ���� ���Ű� �Ǿ����ϴ�.

<table border=1>
	<tr>
		<td>��ǰ��ȣ</td>
		<td>${purchase.purchaseProd.prodNo}</td>
	</tr>
	<tr>
		<td>�����ھ��̵�</td>
		<td>${purchase.buyer.userId}</td>
	</tr>
	<tr>
		<td>���Ź��</td>
		<td>
		    <c:if test="${!empty purchase.paymentOption}"> 
			<c:if test="${fn:trim(purchase.paymentOption)=='1'}"> ���ݱ��� </c:if> 
			<c:if test="${fn:trim(purchase.paymentOption)=='2'}"> �ſ뱸�� </c:if>	
			</c:if>	
		</td>
	</tr>
	<tr>
		<td>�������̸�</td>
		<td>${purchase.receiverName}</td>
	</tr>
	<tr>
		<td>�����ڿ���ó</td>
		<td>${purchase.receiverPhone}</td>
	</tr>
	<tr>
		<td>�������ּ�</td>
		<td>${purchase.dlvyAddr}</td>
	</tr>
		<tr>
		<td>���ſ�û����</td>
		<td>${purchase.dlvyRequest}</td>
	</tr>
	<tr>
		<td>����������</td>
		<td>${purchase.dlvyDate}</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td width="53%"></td>
		<td align="right">
		<table border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="17" height="23">
					<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
				</td>
				<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">Ȯ��</td>
				<td width="14" height="23">
					<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
				</td>
				</tr>
				</table>
				</td>
				</tr>
				</table>
</form>

</body>
</html>