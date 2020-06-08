<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<title>Insert title here</title>

<script type="text/javascript" src="../javascript/calendar.js"></script>
<script src = "http://code.jquery.com/jquery-2.1.4.js"></script>
<script type="text/javascript">

$(function(){
	
	$("#phone1").on("change", function(){
		$("#phone2").focus();
	});
	
	$("#calender_img").on("click", function(){
		show_calendar('document.detailForm.receiverDate', document.detailForm.receiverDate.value);
	});
	
	$(".ct_btn01:contains('구매')").on("click", function(){
		var name = $("#receiverName").val();
		var phone = $("#receiverPhone").val();
		var addr = $("#receiverAddr").val();
		var date = $("#receiverDate").val(); 
		
		var betweenDlivyDate = new Date(date);
		var betweenStandardDate = new Date();
		betweenStandardDate.setDate(betweenStandardDate.getDate() + 2);
		
		var betweenDay = (betweenDlivyDate.getTime() - betweenStandardDate.getTime())/1000/60/60/24; 	
		
		if(name == null || name.length<1){
			alert("구매자 이름은 반드시 입력하여야 합니다.");
			return;
		}	
		if($("#phone2").val() != "" && $("#phone3").val() != "") {
			$("#receiverPhone").val($("#phone1").val() + "-" + $("#phone2").val() + "-" + $("#phone3").val());
		} else {
			alert("구매자 번호는 반드시 입력하셔야 합니다.");
			return;
		}
		if(addr == null || addr.length<1){
			alert("주소는 반드시 입력하셔야 합니다.");
			return;
		}	

		if(date == null || date.length<1){
			alert("배송 희망 일자는 반드시 입력하셔야 합니다.");
			return;
		}
		
		if(! $("#phone2").val().match(/^\d{4}$/)){
			alert("핸드폰 번호는 4자리 숫자만 입력 가능합니다.");
			$("#phone2").focus();
			return;
		}
		
		if(! $("#phone3").val().match(/^\d{4}$/)){
			alert("핸드폰 번호는 4자리 숫자만 입력 가능합니다.");
			$("#phone3").focus();
			return;
		}
		
		if(betweenDay < -2){
			var date = betweenStandardDate.getFullYear() + "/" + (betweenStandardDate.getMonth()+1) + "/" + betweenStandardDate.getDate();
			alert("배송 날짜는 "+date+ " 부터 가능합니다.");
			return;
		}
		
		
		$("form").attr("method", "POST").attr("action", "/purchase/addPurchase").submit();
	});
	
	$(".ct_btn01:contains('취소')").on("click", function(){
		history.go(-1);
	});
	
	
});


</script>
</head>

<body>

<form name="detailForm" method="post">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37">
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">상품상세조회</td>
					<td width="20%" align="right">&nbsp;</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
		</td>
	</tr>
</table>

<table width="600" border="0" cellspacing="0" cellpadding="0"	align="center" style="margin-top: 13px;">
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="300" class="ct_write">
			상품번호 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01" width="299">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="105">${product.prodNo}</td>
					<input type="hidden" name="prod_no" value="${product.prodNo}" />
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			상품명 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${product.prodName}</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			상품상세정보 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
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
		<td width="104" class="ct_write">등록일자</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${product.regDate}</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			구매자아이디 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${user.userId}</td>
		<input type="hidden" name="buyerId" value="${user.userId}" />
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">구매방법</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<select name="paymentOption" class="ct_input_g" style="width: 100px; height: 19px" maxLength="20">
				<option value="1" selected="selected">현금구매</option>
				<option value="2">신용구매</option>
			</select>
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">구매자이름</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input type="text" name="receiverName" id="receiverName" class="ct_input_g" style="width: 100px; height: 19px" maxLength="20" value="${user.userName}" />
		
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">구매자연락처</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
		<c:if test="${! empty user.phone}">
			<c:set var="tel" value="${fn:split(user.phone,'-')}" />		
		</c:if>
			<select name="phone1" id="phone1" class="ct_input_g" style="width:50px; height:25px">				
				<option value="010" ${ ! empty tel && fn:split(user.phone,'-')[0]=='010' ? "selected" : "" } >010</option> 
				<option value="011" ${ ! empty tel && fn:split(user.phone,'-')[0]=='011' ? "selected" : "" } >011</option>
				<option value="016" ${ ! empty tel && fn:split(user.phone,'-')[0]=='016' ? "selected" : "" } >016</option>
				<option value="018" ${ ! empty tel && fn:split(user.phone,'-')[0]=='018' ? "selected" : "" } >018</option>
				<option value="019" ${ ! empty tel && fn:split(user.phone,'-')[0]=='019' ? "selected" : "" } >019</option>			
			</select>
			
			
			<input 	type="text" id="phone2" name="phone2" value="<c:if test="${! empty tel}">${fn:split(user.phone,'-')[1]}</c:if>" class="ct_input_g" style="width:100px; height:19px"  maxLength="9" >
			- 
			<input 	type="text" id="phone3" name="phone3" value="<c:if test="${! empty tel}">${fn:split(user.phone,'-')[2]}</c:if>"  class="ct_input_g"  style="width:100px; height:19px"  maxLength="9" >
							
			<input type="hidden" name="receiverPhone" id="receiverPhone" value="" class="ct_input_g"  />
			
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">구매자주소</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input type="text" name="receiverAddr" id="receiverAddr" class="ct_input_g" style="width: 100px; height: 19px" maxLength="20" value="${user.addr}" />
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">구매요청사항</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input type="text" name="receiverRequest" id="receiverRequest" class="ct_input_g" style="width: 100px; height: 19px" maxLength="20" />
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">배송희망일자</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td width="200" class="ct_write01">
			<input 	type="text" readonly="readonly" name="receiverDate" id="receiverDate" class="ct_input_g" style="width: 100px; height: 19px" maxLength="20"/>
			<img id="calender_img" src="../images/ct_icon_date.gif" width="15" height="15"/>
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
	<tr>
		<td width="53%"></td>
		<td align="center">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">구매</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
					</td>
					<td width="30"></td>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">취소</td>
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