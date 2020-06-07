<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>

<script src = "http://code.jquery.com/jquery-2.1.4.js"></script>
<script type="text/javascript">

$(function(){
	
$("#tranCode").on("change", function(){
	location.href=this.value;
})


$(".ct_btn01:contains('확인')").on("click", function(){
	self.location="/product/listProduct?menu=manage";
});


});

</script>

<title>Insert title here</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

</head>
<body>
<body bgcolor="#ffffff" text="#000000">
	<div style="width: 98%; margin-left: 10px;">
			<form name="deliveryForm" action="/purchase/deliveryProduct" method="post">
				<table width="100%" height="37" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td width="15" height="37"><img src="/images/ct_ttl_img01.gif" width="15" height="37" /></td>
						<td background="/images/ct_ttl_img02.gif" width="100%"
							style="padding-left: 10px;">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td width="93%" class="ct_ttl01">< ${product.prodName} > 주문 현황</td>
								</tr>
							</table>
						</td>
						<td width="12" height="37"><img src="/images/ct_ttl_img03.gif" width="12" height="37" /></td>
					</tr>
				</table>					

				<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
					<tr>
						<td class="ct_list_b" width="50">NO</td>
						<td class="ct_line02"></td>
						<td class="ct_list_b" width="100">주문 번호</td>
						<td class="ct_line02"></td>
						<td class="ct_list_b">주문자 아이디</td>
						<td class="ct_line02"></td>
						<td class="ct_list_b">주문 방법</td>
						<td class="ct_line02"></td>
						<td class="ct_list_b">주문자 이름</td>
						<td class="ct_line02"></td>
						<td class="ct_list_b">주문자 번호</td>
						<td class="ct_line02"></td>
						<td class="ct_list_b">배달 요청</td>
						<td class="ct_line02"></td>
						<td class="ct_list_b">주문 날짜</td>
						<td class="ct_line02"></td>
						<td class="ct_list_b">배송 희망 날짜</td>
						<td class="ct_line02"></td>
						<td class="ct_list_b"> </td>
						<td class="ct_line02"></td>
					</tr>
					<tr>
						<td colspan="30" bgcolor="808285" height="1"></td>
					</tr>
					<c:forEach var="delivery" items="${listDelivery}" varStatus="status">
						<tr class="ct_list_pop">
							<td align="center">${status.count}</td>
							<td></td>
							<td align="left">${delivery.tranNo}</td>
							<td></td>
							<td align="left">${delivery.buyer.userId}</td>
							<td></td>
							<td align="left"><c:if test="${fn:trim(delivery.paymentOption) == '1'}">현금구매</c:if><c:if test="${fn:trim(delivery.paymentOption) == '2'}">신용구매</c:if></td>
							<td></td>
							<td align="left">${delivery.receiverName}</td>
							<td></td>
							<td align="left">${delivery.receiverPhone}</td>
							<td></td>
							<td align="left">${delivery.dlvyRequest}</td>
							<td></td>
							<td align="left">${delivery.orderDate}</td>
							<td></td>
							<td align="left">${delivery.dlvyDate}</td>
							<td></td>
							<td align="center">
							<select id="tranCode"> 
							<option value="2"> </option> 
							<option value="/purchase/deliveryProduct?tranNo=${delivery.tranNo}&tranCode=${delivery.tranCode}&prodNo=${delivery.purchaseProd.prodNo}">배송하기</option> 
							</select></td>
							<td></td>
						</tr>					
						<tr>
							<td colspan="30" bgcolor="D6D7D6" height="1"></td>
						</tr>
					</c:forEach>
					</table>
				<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px; margin-right: 30px">
		<tr>
		<td width="53%"></td>
		<td align="right">
		<table border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="17" height="23">
					<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
				</td>
				<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">확인</td>
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