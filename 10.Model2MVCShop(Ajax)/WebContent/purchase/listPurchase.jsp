<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
    
<!DOCTYPE html>
<html>
<head>

<script src = "http://code.jquery.com/jquery-2.1.4.js"></script>
<script type="text/javascript">

function fncGetPurchaseList(currentPage) {
	$("#currentPage").val() = currentPage;
   	document.detailForm.submit();		
   	$("form").attr("method", "POST").attr("action", "/purchase/listPurchase").submit();
}

$(function(){
	
	$(".ct_list_pop:contains('물건도착')").on("click", function(){
		self.location="/purchase/updateTranCode?tranNo="+$("#tranNo").val();
	});
	
	$(".ct_list_pop:contains('후기쓰기')").on("click", function(){
		self.location="/purchase/reviewPurchaseView?tran_no="+$("#tranNo").val()+"&userId="+$("#userId").val();
	});
	
	$(".ct_list_pop td:nth-child(1)").on("click", function(){
			//self.location="/purchase/getPurchase?tranNo="+$(this).children().val();
		var tranNo = $(this).children().val();
		var tran = "purchase";
		
		$.ajax({
			url:"/purchase/json/getPurchase/"+tranNo,
			method:"GET",
			dataType:"Json",
			headers : {
				"Accept" : "application/json",
				"Content-Type" : "application/json"
			},
			success : function(JSONData, status){
				var displayValue="<h3>"	+"물품번호 : "+JSONData.purchaseProd.prodNo+"<br/>"
										+"상품명 : " +JSONData.purchaseProd.prodName+"<br/>"
										+"구매자아이디 : "+JSONData.buyer.userId+"<br/>"
										if(JSONData.paymentOption == 1){
											displayValue+="구매방법 : 현금 구매<br/>"}
										else if(JSONData.paymentOption == 2){
											displayValue+="구매방법 : 신용 구매<br/>"}
										displayValue+="구매자이름 : "+(JSONData.receiverName==null?"":JSONData.receiverName)+"<br/>" 
										displayValue+="구매자연락처 : "+(JSONData.receiverPhone==null?"":JSONData.receiverPhone)+"<br/>"
										displayValue+="구매자주소 : "+(JSONData.dlvyAddr==null?"":JSONData.dlvyAddr)+"<br/>"
										displayValue+="구매요청사항 : "+(JSONData.dlvyRequest==null?"":JSONData.dlvyRequest)+"<br/>"
										displayValue+="배송희망일 : "+(JSONData.dlvyDate==null?"":JSONData.dlvyDate)+"<br/>"
										displayValue+="주문일 : "+(JSONData.orderDate==null?"":JSONData.orderDate)+"<br/>"							
										displayValue+="</h3>";
																									
				$("h3").remove();
				$("#"+tranNo+"").html(displayValue);
			}
		});	
			
	});
	
	$(".ct_list_pop td:nth-child(3)").on("click", function() {
			//self.location="/user/getUser?userId="+$(this).children().val();	
		var userId = $(this).children().val();
		var tran = "user";
		
		$.ajax({
			url:"/user/json/getUser/"+userId,
			method:"GET",
			dataType:"Json",
			headers : {
				"Accept" : "application/json",
				"Content-Type" : "application/json"
			},
			success : function(JSONData, status){
				var displayValue="<h3>"	+"아이디 : "+JSONData.userId+"<br/>"
										+"이름 : " +JSONData.userName+"<br/>"
										+"주소 : "+JSONData.addr+"<br/>"
										+"휴대전화번호 : "+JSONData.phone+"<br/>"
										+"이메일 : "+JSONData.email+"<br/>"
										+"가입일자 : "+JSONData.regDate+"<br/>"						
								+"</h3>";
																									
				$("h3").remove();
				$("#"+userId+"").html(displayValue);
			}
		});	
	});
	
});

</script>

<title>구매 목록조회</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width: 98%; margin-left: 10px;">

<form name="detailForm">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"width="15" height="37"></td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">구매 목록조회</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"	width="12" height="37"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td colspan="11">전체 ${resultPage.totalCount} 건수, 현재 ${resultPage.currentPage} 페이지</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">회원ID</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">회원명</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">전화번호</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">배송현황</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">정보수정</td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>

	<c:forEach var="purchase" items="${list}" varStatus="status">	
	<tr class="ct_list_pop">
		<td align="center">${status.count} <input type="hidden" id="tranNo" value="${purchase.tranNo}"/> </td>
		<td></td>
		<td align="left">${purchase.buyer.userId} <input type="hidden" id="userId" value="${purchase.buyer.userId}"/> </td>
		<td></td>
		<td align="left">${purchase.receiverName}</td>
		<td></td>
		<td align="left">${purchase.receiverPhone}</td>
		<td></td>
		<td align="left">
		<c:if test="${fn:trim(purchase.tranCode)=='2'}"> 현재 구매완료 상태입니다. </c:if>
		<c:if test="${fn:trim(purchase.tranCode)=='3'}"> 현재 배송 중 상태입니다. </c:if>
		<c:if test="${fn:trim(purchase.tranCode)=='4'}"> 현재 배송완료 상태입니다. </c:if>
		</td>
		<td></td>
		<td align="left">
			<c:if test="${fn:trim(purchase.tranCode)=='3'}">물건도착</c:if>
			<c:if test="${fn:trim(purchase.tranCode)=='4' && fn:trim(purchase.revStatusCode)=='false'}">후기쓰기</c:if>
		</td>
	</tr>
	<tr>
		<td id="${purchase.tranNo}" colspan="11" bgcolor="D6D7D6" height="1"></td>
		<td id="${user.userId}" colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>
	</c:forEach>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"
				style="margin-top: 10px;">
				<tr>
					<td align="center">
						<input type="hidden" id="currentPage" name="currentPage" value=""/>
						<jsp:include page="../common/pageNavigator.jsp">
						<jsp:param name="navi" value="Purchase"/>
						</jsp:include>	

					</td>
				</tr>
			</table>

<!--  페이지 Navigator 끝 -->
</form>

</div>

</body>
</html>