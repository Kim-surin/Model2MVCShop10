<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>

<script src = "http://code.jquery.com/jquery-2.1.4.js"></script>
<script type="text/javascript">
	
	$(function(){
	
		$("#star").on("click", function(){
			var obj = $("#star");
			for (var i = 0; i < obj.length; i++) {
				if (obj[i] != a) {
					obj[i].checked = false;}
			}
		});
		
		
		$("#confirmation").on("click", function(){
			var star_btn = $("input[name='star']");
			 var star = null;
			 var review = $("#review").val();
			 
			 //라디오 버튼이 체크되었나 확인하기 위한 변수
		        var star_btn_check = 0;
		        for(var i = 0; i<star_btn.length; i++){
		            //만약 라디오 버튼이 체크가 되어있다면 true
		            if(star_btn[i].checked==true){
		                //라디오 버튼 값
		                star = star_btn[i].value;
		                //라디오 버튼이 체크되면 radio_btn_check를 1로 만들어준다.
		                star_btn_check++;
		            }
		        }
		        
		        if(star_btn_check==0){
		            alert("별점을 선택해주세요.");
		            return;
		        }
		        
		       if(review==null){
		    	   alert("후기를 작성해주세요.");
		    	   return;
		       }

		        $("form").attr("method", "POST").attr("action", "/purchase/reviewPurchase").submit();
			
		});
		
	});
	
</script>

<style>
.test::-ms-clear {
   display:none;
}
</style>

</head>
<body bgcolor="#ffffff" text="#000000">
<form name="reviewForm">

<table width="100%" height="37" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif"	width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">후기 작성 </td>
					<td width="20%" align="right">&nbsp;</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif"	width="12" height="37"/>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 13px;">
	<tr>
		<td height="2" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="110" height="50" class="ct_write"> 상품명 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="1050"> &nbsp; ${purchase.purchaseProd.prodName} </td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" height="50" class="ct_write"> 구매자아이디  <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01"> &nbsp; ${purchase.buyer.userId} </td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" height="50" class="ct_write">구매자이름</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01"> &nbsp; ${purchase.receiverName} </td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" height="50" class="ct_write">별점</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td>
		&nbsp;<input type="checkbox" id="star" name="star" value="1"/>★
		&nbsp;<input type="checkbox" id="star" name="star" value="2"/>★★
		&nbsp;<input type="checkbox" id="star" name="star" value="3"/>★★★
		&nbsp;<input type="checkbox" id="star" name="star" value="4"/>★★★★
		&nbsp;<input type="checkbox" id="star" name="star" value="5"/>★★★★★
		</td>
	</tr>

	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>

	<tr>
		<td width="104" height="200" class="ct_write">후기</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">&nbsp;<input type="text" class="test" id="review" name="review" style="text-align:left; width:1300px; height:200px; letter-spacing: 0px; border:none" /></td>
		<input type="hidden" name="tranNo" value="${purchase.tranNo}"/>
	</tr>

	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td width="53%"></td>
		<td align="right">
			<table border="0" cellspacing="0" cellpadding="0"> 
						<tr>
							<td width="17" height="23"><img src="/images/ct_btnbg01.gif" width="17" height="23" /></td>
							<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;"><input type=button id="confirmation" value="확인"></td>
							<td width="14" height="23"><img src="/images/ct_btnbg03.gif" width="14" height="23"></td>
							<td width="30"></td>
						</tr>
					</table>
		</td>
	</tr>
</table>
</form>
</body>
</html>