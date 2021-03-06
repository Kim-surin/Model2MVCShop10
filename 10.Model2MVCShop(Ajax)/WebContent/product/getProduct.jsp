<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<script src = "http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type = "text/javascript">

$(function(){
	
$("form[name='manageForm'] .ct_btn01:contains('확인')").on("click", function(){
	self.location="/product/listProduct?menu=manage";
});

$("form[name='searchForm'] .ct_btn01:contains('확인')").on("click", function(){
	self.location="/product/listProduct?menu=search";
});

$("form[name='searchForm'] .ct_btn01:contains('구매')").on("click", function(){
	self.location="/purchase/addPurchaseView?prod_no="+$("#prodNo").val();
});

});

</script>

<title>Insert title here</title>
</head>

<body bgcolor="#ffffff" text="#000000">
<input type="hidden" id="prodNo" value="${product.prodNo}"/>
<c:if test="${!empty menu}">
<c:if test="${menu=='manage'}">
	<form name="manageForm">

		<table width="100%" height="37" border="0" cellpadding="0"
			cellspacing="0">
			<tr>
				<td width="15" height="37"><img src="/images/ct_ttl_img01.gif" width="15" height="37"></td>
				<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="93%" class="ct_ttl01">상품상세조회</td>
							<td width="20%" align="right">&nbsp;</td>
						</tr>
					</table>
				</td>
				<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"
					width="12" height="37" /></td>
			</tr>
		</table>

		<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 13px;">
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			<tr>
				<td width="104" class="ct_write">상품번호 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle" />
				</td>
				<td bgcolor="D6D6D6" width="1"></td>
				<td class="ct_write01">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="105">${product.prodNo}</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			<tr>
				<td width="104" class="ct_write">상품명 <img
					src="/images/ct_icon_red.gif" width="3" height="3"
					align="absmiddle" />
				</td>
				<td bgcolor="D6D6D6" width="1"></td>
				<td class="ct_write01">${product.prodName}</td>
			</tr>
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			<tr>
				<td width="104" class="ct_write">상품이미지 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle" />
				</td>
				<td bgcolor="D6D6D6" width="1"></td>
				<td class="ct_write01">
				<c:forEach items="${fn:split(product.fileName,'/')}" var="fileName">
				<img src="/images/uploadFiles/${fileName}" style="max-width:20%; height: auto;"/>
				</c:forEach></td>
			</tr>
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			<tr>
				<td width="104" class="ct_write">상품상세정보 <img
					src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle" />
				</td>
				<td bgcolor="D6D6D6" width="1"></td>
				<td class="ct_write01">${product.prodDetail}</td>
			</tr>
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			<tr>
				<td width="104" class="ct_write">제조일자</td>
				<td bgcolor="D6D6D6" width="1"></td>
				<td class="ct_write01">${product.manuDate}</td>
			</tr>
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			<tr>
				<td width="104" class="ct_write">가격</td>
				<td bgcolor="D6D6D6" width="1"></td>
				<td class="ct_write01">${product.price}</td>
			</tr>
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			<tr>
				<td width="104" class="ct_write">수량</td>
				<td bgcolor="D6D6D6" width="1"></td>
				<td class="ct_write01">${product.amount}</td>
			</tr>
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			<tr>
				<td width="104" class="ct_write">등록일자</td>
				<td bgcolor="D6D6D6" width="1"></td>
				<td class="ct_write01">${product.regDate}</td>
			</tr>
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
		</table>

		<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
			<tr>
				<td width="53%"></td>
				<td align="right">

					<table border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="17" height="23"><img src="/images/ct_btnbg01.gif" width="17" height="23" /></td>
							<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">확인</td>
							<td width="14" height="23"><img src="/images/ct_btnbg03.gif" width="14" height="23"></td>
							<td width="30"></td>
						</tr>
					</table>

				</td>
			</tr>
		</table>
	</form>
	</c:if>
	</c:if>
<%------------------------------------------------------------------------------------ --%>
<c:if test="${!empty menu}">
<c:if test="${menu=='search'}">
	<form name="searchForm">

		<table width="100%" height="37" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td width="15" height="37"><img src="/images/ct_ttl_img01.gif" width="15" height="37"></td>
				<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="93%" class="ct_ttl01">상품상세조회</td>
							<td width="20%" align="right">&nbsp;</td>
						</tr>
					</table>
				</td>
				<td width="12" height="37"><img src="/images/ct_ttl_img03.gif" width="12" height="37"/></td>
			</tr>
		</table>

		<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 13px;">
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			<tr>
				<td width="104" class="ct_write">상품번호 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle" />
				</td>
				<td bgcolor="D6D6D6" width="1"></td>
				<td class="ct_write01">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="105">${product.prodNo}</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			<tr>
				<td width="104" class="ct_write">상품명 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle" />
				</td>
				<td bgcolor="D6D6D6" width="1"></td>
				<td class="ct_write01">${product.prodName}</td>
			</tr>
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			<tr>
				<td width="104" class="ct_write">상품이미지 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle" />
				</td>
				<td bgcolor="D6D6D6" width="1"></td>

				<td class="ct_write01">
					<c:forEach items="${fn:split(product.fileName,'/')}" var="fileName">
					<img src="/images/uploadFiles/${fileName}" style="max-width:20%; height: auto;"/>
					</c:forEach>
				</td>				
			</tr>
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			<tr>
				<td width="104" class="ct_write">상품상세정보 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle" />
				</td>
				<td bgcolor="D6D6D6" width="1"></td>
				<td class="ct_write01">${product.prodDetail}</td>
			</tr>
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			<tr>
				<td width="104" class="ct_write">제조일자</td>
				<td bgcolor="D6D6D6" width="1"></td>
				<td class="ct_write01">${fn:substring(product.manuDate,0,4)}-${fn:substring(product.manuDate,4,6)}-${fn:substring(product.manuDate,6,8)}</td>
			</tr>
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			<tr>
				<td width="104" class="ct_write">가격</td>
				<td bgcolor="D6D6D6" width="1"></td>
				<td class="ct_write01">${product.price}</td>
			</tr>
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			<tr>
				<td width="104" class="ct_write">수량</td>
				<td bgcolor="D6D6D6" width="1"></td>
				<td class="ct_write01">${product.amount}</td>
			</tr>
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			<tr>
				<td width="104" class="ct_write">등록일자</td>
				<td bgcolor="D6D6D6" width="1"></td>
				<td class="ct_write01">${product.regDate}</td>
			</tr>
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
		</table>	
				
		<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 13px; margin-right:10px">
			<tr height="3">
				<td colspan="1" bgcolor="D6D6D6" align="center"></td>
				<td colspan="1" bgcolor="D6D6D6" align="center">No</td>
				<td colspan="1" bgcolor="D6D6D6" align="center">리뷰</td>
				<td colspan="1" bgcolor="D6D6D6" align="center">별점</td>
				<td colspan="1" bgcolor="D6D6D6" align="center">리뷰작성자</td>
				<td colspan="1" bgcolor="D6D6D6" align="center">등록일</td>
				<td colspan="1" bgcolor="D6D6D6" align="center">리뷰 이미지</td>
			</tr>						
			
			<c:forEach var="review" items="${list}" varStatus="status">
			<tr class="ct_list_pop">
				<td></td>
				<td align="center">${status.count}</td>
				<td align="center" >${review.reviewSentence}</td>
				<td align="center"><c:if test="${!empty review.star}">
									<c:if test="${review.star == 0}">  </c:if>
									<c:if test="${review.star == 1}"> ★ </c:if>
									<c:if test="${review.star == 2}"> ★★ </c:if>
									<c:if test="${review.star == 3}"> ★★★ </c:if>
									<c:if test="${review.star == 4}"> ★★★★ </c:if>
									<c:if test="${review.star == 5}"> ★★★★★ </c:if>
									</c:if>
									</td>
				<td align="center">${review.buyer}</td>
				<td align="center">${review.revDate}</td>
				<td align="center"><c:forEach items="${fn:split(review.reviewImage,'/')}" var="fileName"><img src="/images/uploadFiles/${fileName}" style="max-width:20%; height: auto;"/></c:forEach></td>
				</tr>
				</c:forEach>
				</table>		
		
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			style="margin-top: 10px;">
			<tr>
				<td width="53%"></td>
				<td align="right">

					<table border="0" cellspacing="0" cellpadding="0">
						<tr>
						<c:if test="${!empty product.amount}">
						<c:if test="${product.amount > 0}">

							<td width="17" height="23"><img src="/images/ct_btnbg01.gif" width="17" height="23" /></td>
							<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">구매</td>

							<td width="14" height="23"><img src="/images/ct_btnbg03.gif" width="14" height="23"></td>
							<td width="30"></td>
							</c:if>
							</c:if>
							<td width="17" height="23"><img src="/images/ct_btnbg01.gif" width="17" height="23" /></td>
							<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">확인</td>
							<td width="14" height="23"><img src="/images/ct_btnbg03.gif" width="14" height="23" /></td>
						</tr>
					</table>

				</td>
			</tr>
		</table>
	</form>
	</c:if>
	</c:if>
</body>
</html>