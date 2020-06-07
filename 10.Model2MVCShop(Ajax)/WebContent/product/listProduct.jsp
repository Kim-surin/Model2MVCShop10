<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<title>��ǰ �����ȸ</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<script src= "http://code.jquery.com/jquery-2.1.4.js"></script>
<script type="text/javascript">

function fncGetProductList(currentPage) {
	$("#currentPage").val(currentPage)
	$("form").attr("method", "POST").attr("action", "/product/listProduct?menu="+$("#menu").val()).submit();
		
}

$(function() {
	
	$("#searchCondition").on("change", function(){
		if($("#searchCondition").val() == "6"){
			$("#div1").css("display", "none");
			$("#div2").css("display", "block");
		}else{
			$("#div1").css("display", "block");
			$("#div2").css("display", "none");
		}
	});
	
	$("#searchKeyword").on("keydown", function(key){	
		if(key.keyCode==13 ){
			fncGetProductList('1');}
	});
	
	$("#searchPrice2").on("keypress", function(event){	
		if( event.keyCode==13 ){
			fncGetProductList('1');}
	});
	
	$(".ct_btn01:contains('�˻�')").on("click", function(){
		fncGetProductList('1');
	});
	
	
	$( "form[name='manageForm'] td:nth-child(3)" ).on("click" , function() {
			self.location ="/product/getProduct?menu=manage&prod_no="+$(this).children().val();
	});
	
	$( "form[name='searchForm'] td:nth-child(3)" ).on("click" , function() {
		self.location ="/product/getProduct?menu=search&prod_no="+$(this).children().val();	
		
	});
	
	if($("form[name='searchForm']") || $("form[name='manageForm']") ){
	
	$( "form td:nth-child(1)" ).on("click" , function() {
		var prodNo = $(this).children().val();
		
		$.ajax({
			url:"/product/json/getProduct/"+prodNo,
			method:"GET",
			dataType:"Json",
			headers : {
				"Accept" : "application/json",
				"Content-Type" : "application/json"
			},
			success : function(JSONData, status){
				
				var displayValue="<h3>"	+"��ǰ��ȣ : "+JSONData.product.prodNo+"<br/>"
										+"��ǰ�� : " +JSONData.product.prodName+"<br/>"
										+"��ǰ�̹��� : "+JSONData.product.fileName+"<br/>"
										+"��ǰ������ : "+JSONData.product.prodDetail+"<br/>"
										+"�������� : "+JSONData.product.manuDate+"<br/>"
										+"���� : "+JSONData.product.price+"<br/>"
										+"���� : "+JSONData.product.amount+"<br/>"
										+"������� : "+JSONData.product.regDate+"<br/>"	
										if(JSONData.review != null){
										for(var i=0; i<JSONData.review.length; i++){
											displayValue+="���� �ۼ��� : "+JSONData.review[i].buyer+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
											displayValue+="���� :	"+JSONData.review[i].reviewSentence+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
											displayValue+="���� :	"+JSONData.review[i].star+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"										
											displayValue+="����� : "+JSONData.review[i].revDate	
											displayValue+="<br/>"
										}}
										displayValue+="</h3>";
																									
				$("h3").remove();
				$("#"+prodNo+"").html(displayValue);
			}
		});	
	});
	
	}
	
});
	
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

	<div style="width: 98%; margin-left: 10px;">	
		<c:if test="${menu == 'manage' || param.menu == 'manage'}">
			<form name="manageForm">
			<input type="hidden" id="menu" value="manage"/>
				<table width="100%" height="37" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td width="15" height="37"><img
							src="/images/ct_ttl_img01.gif" width="15" height="37" /></td>
						<td background="/images/ct_ttl_img02.gif" width="100%"
							style="padding-left: 10px;">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td width="93%" class="ct_ttl01">��ǰ ����</td>
								</tr>
							</table>
						</td>
						<td width="12" height="37"><img
							src="/images/ct_ttl_img03.gif" width="12" height="37" /></td>
					</tr>
				</table>


				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					style="margin-top: 10px;">
					<tr>
						<td align="right">
						<select name="searchCondition" id="searchCondition" class="ct_input_g" style="width: 120px; margin-right:4px;">
								<option value="1"
									${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>��ǰ��</option>
								<option value="2"
									${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>��ǰ����</option>
								<option value="3"
									${ ! empty search.searchCondition && search.searchCondition==3 ? "selected" : "" }>���� ���� ��</option>
								<option value="4"
									${ ! empty search.searchCondition && search.searchCondition==4 ? "selected" : "" }>���� ���� ��</option>
								<option value="5"
									${ ! empty search.searchCondition && search.searchCondition==5 ? "selected" : "" }>�ҽ� ��ǰ ��</option>
								<option value="6"
									${ ! empty search.searchCondition && search.searchCondition==6 ? "selected" : "" }>���ݴ� �� ��ǰ</option>
						</select> 
						<div name="div1" id="div1" style="display:block; float:right">
						<input type="text" name="searchKeyword" id="searchKeyword" value="${! empty search.searchKeyword ? search.searchKeyword : ""}" class="ct_input_g" style="width: 200px; height: 19px"/> 
						</div>
						<div name="div2" id="div2" style="display:none; float:right">
						<input type="text" name="searchPrice1" id="searchPrice1" value="${! empty search.searchPrice1 ? search.searchPrice1 : ""}" class="ct_input_g" style="width: 130px; height: 19px"/>
						<input type="text" name="searchPrice2" id="searchPrice2" value="${! empty search.searchPrice2 ? search.searchPrice2 : ""}" class="ct_input_g" style="width: 130px; height: 19px"/>
						</div>
						</td>

						<td align="right" width="70">
							<table border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td width="17" height="23"><img src="/images/ct_btnbg01.gif" width="17" height="23"></td>
									<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">�˻�</td>
									<td width="14" height="23"><img src="/images/ct_btnbg03.gif" width="14" height="23"></td>
								</tr>
							</table>
						</td>
					</tr>
				</table>


				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					style="margin-top: 10px;">
					<tr>
						<td colspan="11">��ü ${resultPage.totalCount} �Ǽ�, ����
							${resultPage.currentPage} ������</td>
					</tr>
					<tr>
						<td class="ct_list_b" width="100">No</td>
						<td class="ct_line02"></td>
						<td class="ct_list_b" width="150">��ǰ��</td>
						<td class="ct_line02"></td>
						<td class="ct_list_b" width="150">����</td>
						<td class="ct_line02"></td>
						<td class="ct_list_b">������</td>
						<td class="ct_line02"></td>
						<td class="ct_list_b">����</td>
						<td class="ct_line02"></td>
						<td class="ct_list_b">�ֹ� �Ǽ�</td>
					</tr>
					<tr>
						<td colspan="11" bgcolor="808285" height="1"></td>
					</tr>
					<c:forEach var="product" items="${listProduct}" varStatus="status">
					
						<tr class="ct_list_pop">						
							<td align="center">${status.count} <input type="hidden" id="prodNo" name="prodNo" value="${product.prodNo}"/></td>
							<td></td>
							<td align="left">${product.prodName} <input type="hidden" id="prodNo" name="prodNo" value="${product.prodNo}"/></td>
							<td></td>
							<td align="left">${product.price}</td>
							<td></td>
							<td align="left">${fn:substring(product.manuDate,0,4)}-${fn:substring(product.manuDate,4,6)}-${fn:substring(product.manuDate,6,8)}</td>
							<td></td>
							<td align="left">${product.amount}</td>
							<td></td>
							<td align="left"><c:if test="${!empty product.orderCount}">
									${product.orderCount} &nbsp; &nbsp;
									<c:if test="${product.orderCount >= 1}"> <a href="/purchase/deliveryProductView?prod_no=${product.prodNo}"> ����ϱ� </a> </c:if>
								</c:if></td>
						</tr>
						<tr>
							<!-- <td colspan="11" bgcolor="D6D7D6" height="1"></td> -->
							<td id="${product.prodNo}" colspan="11" bgcolor="D6D7D6" height="1"></td>
						</tr>
					</c:forEach>
				</table>

				<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
					<tr>
						<td align="center"><input type="hidden" id="currentPage" name="currentPage" value="" /> 
						<jsp:include page="../common/pageNavigator.jsp">
								<jsp:param name="navi" value="Product" />
							</jsp:include></td>
					</tr>
				</table>
				<!--  ������ Navigator �� -->

			</form>
		</c:if>

		<!--  -------------------------------------------------------------------------------------- -->

		<c:if test="${menu == 'search' || param.menu == 'search'}">
			<form name="searchForm">
				<input type="hidden" id="menu" value="search"/>
				<table width="100%" height="37" border="0" cellpadding="0"
					cellspacing="0">
					<tr>
						<td width="15" height="37"><img
							src="/images/ct_ttl_img01.gif" width="15" height="37" /></td>
						<td background="/images/ct_ttl_img02.gif" width="100%"
							style="padding-left: 10px;">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td width="93%" class="ct_ttl01">��ǰ �����ȸ</td>
								</tr>
							</table>
						</td>
						<td width="12" height="37"><img
							src="/images/ct_ttl_img03.gif" width="12" height="37" /></td>
					</tr>
				</table>


				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					style="margin-top: 10px;">
					<tr>
						<td align="right">
						<select name="searchCondition" id="searchCondition" class="ct_input_g" style="width: 120px; margin-right:4px;">
								<option value="1"
									${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>��ǰ��</option>
								<option value="2"
									${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>��ǰ����</option>
								<option value="3"
									${ ! empty search.searchCondition && search.searchCondition==3 ? "selected" : "" }>���� ���� ��</option>
								<option value="4"
									${ ! empty search.searchCondition && search.searchCondition==4 ? "selected" : "" }>���� ���� ��</option>
								<option value="5"
									${ ! empty search.searchCondition && search.searchCondition==5 ? "selected" : "" }>�ҽ� ��ǰ ��</option>
								<option value="6"
									${ ! empty search.searchCondition && search.searchCondition==6 ? "selected" : "" }>���ݴ� �� ��ǰ</option>
						</select> 
						<div name="div1" id="div1" style="display:block; float:right">
						<input type="text" name="searchKeyword" id="searchKeyword" value="${! empty search.searchKeyword ? search.searchKeyword : ""}" class="ct_input_g" style="width: 200px; height: 19px"/> 
						</div>
						<div name="div2" id="div2" style="display:none; float:right">
						<input type="text" name="searchPrice1" id="searchPrice1" value="${! empty search.searchPrice1 ? search.searchPrice1 : ""}" class="ct_input_g" style="width: 130px; height: 19px"/>
						<input type="text" name="searchPrice2" id="searchPrice2" value="${! empty search.searchPrice2 ? search.searchPrice2 : ""}" class="ct_input_g" style="width: 130px; height: 19px"/>
						</div>
						</td>
						


						<td align="right" width="70">
							<table border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td width="17" height="23"><img
										src="/images/ct_btnbg01.gif" width="17" height="23"></td>
									<td background="/images/ct_btnbg02.gif" class="ct_btn01"
										style="padding-top: 3px;">�˻�</td>
									<td width="14" height="23"><img
										src="/images/ct_btnbg03.gif" width="14" height="23"></td>
								</tr>
							</table>
						</td>
					</tr>
				</table>


				<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
					<tr>
						<td colspan="11">��ü ${resultPage.totalCount} �Ǽ�, ����
							${resultPage.currentPage} ������</td>
					</tr>
					<tr>
						<td class="ct_list_b" width="100">No</td>
						<td class="ct_line02"></td>
						<td class="ct_list_b" width="150">��ǰ��</td>
						<td class="ct_line02"></td>
						<td class="ct_list_b" width="150">����</td>
						<td class="ct_line02"></td>
						<td class="ct_list_b">������</td>
						<td class="ct_line02"></td>
						<td class="ct_list_b">����</td>
						<td class="ct_line02"></td>
						<td class="ct_list_b">����</td>
					</tr>
					<tr>
						<td colspan="11" bgcolor="808285" height="1"></td>
					</tr>

					<c:set var="i" value="0" />
					<c:forEach var="product" items="${listProduct}">
						<c:set var="i" value="${ i+1 }" />

						<tr class="ct_list_pop">
							<td align="center">${i} <input type="hidden" id="prodNo" name="prodNo" value="${product.prodNo}"/></td>
							<td></td>

							<td align="left">${product.prodName} <input type="hidden" id="prodNo" name="prodNo" value="${product.prodNo}"/></td>
							<td></td> 
							<td align="left">${product.price}</td>
							<td></td>
							<td align="left">${fn:substring(product.manuDate,0,4)}-${fn:substring(product.manuDate,4,6)}-${fn:substring(product.manuDate,6,8)}</td>
							<td></td>
							<td align="left">${product.amount}</td>
							<td></td>
							<td align="left"><c:if test="${!empty product.star}">
									<c:if test="${product.star == 0}"> </c:if>
									<c:if test="${product.star == 1}"> �� </c:if>
									<c:if test="${product.star == 2}"> �ڡ� </c:if>
									<c:if test="${product.star == 3}"> �ڡڡ� </c:if>
									<c:if test="${product.star == 4}"> �ڡڡڡ� </c:if>
									<c:if test="${product.star == 5}"> �ڡڡڡڡ� </c:if>
								</c:if></td>
						</tr>
						<tr>
							<!--<td colspan="11" bgcolor="D6D7D6" height="1"></td>-->
							<td id="${product.prodNo}" colspan="11" bgcolor="D6D7D6" height="1"></td>
						</tr>
					</c:forEach>
				</table>

				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					style="margin-top: 10px;">
					<tr>
						<td align="center">
						<input type="hidden" id="currentPage" name="currentPage" value="" /> 
						<jsp:include page="../common/pageNavigator.jsp">
								<jsp:param name="navi" value="Product" />
						</jsp:include></td>
					</tr>
				</table>
				<!--  ������ Navigator �� -->

			</form>
		</c:if>


	</div>
</body>
</html>