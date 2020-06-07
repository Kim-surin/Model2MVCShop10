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
			 
			 //���� ��ư�� üũ�Ǿ��� Ȯ���ϱ� ���� ����
		        var star_btn_check = 0;
		        for(var i = 0; i<star_btn.length; i++){
		            //���� ���� ��ư�� üũ�� �Ǿ��ִٸ� true
		            if(star_btn[i].checked==true){
		                //���� ��ư ��
		                star = star_btn[i].value;
		                //���� ��ư�� üũ�Ǹ� radio_btn_check�� 1�� ������ش�.
		                star_btn_check++;
		            }
		        }
		        
		        if(star_btn_check==0){
		            alert("������ �������ּ���.");
		            return;
		        }
		        
		       if(review==null){
		    	   alert("�ı⸦ �ۼ����ּ���.");
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
					<td width="93%" class="ct_ttl01">�ı� �ۼ� </td>
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
		<td width="110" height="50" class="ct_write"> ��ǰ�� <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
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
		<td width="104" height="50" class="ct_write"> �����ھ��̵�  <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01"> &nbsp; ${purchase.buyer.userId} </td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" height="50" class="ct_write">�������̸�</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01"> &nbsp; ${purchase.receiverName} </td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" height="50" class="ct_write">����</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td>
		&nbsp;<input type="checkbox" id="star" name="star" value="1"/>��
		&nbsp;<input type="checkbox" id="star" name="star" value="2"/>�ڡ�
		&nbsp;<input type="checkbox" id="star" name="star" value="3"/>�ڡڡ�
		&nbsp;<input type="checkbox" id="star" name="star" value="4"/>�ڡڡڡ�
		&nbsp;<input type="checkbox" id="star" name="star" value="5"/>�ڡڡڡڡ�
		</td>
	</tr>

	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>

	<tr>
		<td width="104" height="200" class="ct_write">�ı�</td>
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
							<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;"><input type=button id="confirmation" value="Ȯ��"></td>
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