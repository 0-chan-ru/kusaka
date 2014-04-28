<? 
require_once('inc/AYAH/ayah.php');
$ayah = new AYAH();
?>
<style>
.hf {display: inline-block;}
.fl {float: left;}
input:not([type='submit']) { 
	background: #818181;
border: 1px solid #D8D8D8;
border-radius: 9px;
text-align: center;
}
input:not([type='submit'])  {
	background: #D8D8D8;
	outline: none;
}
form {text-align: center;}
input[type=submit] {
	font-size: 30px;
}
</style>
<div id="boards">
    <center>
    <a href="/?p=boards" title="Доски">Доски</a> | <a href="/?p=2.0" title="2.0"><b>Nullchorg 2.0<sup>beta</sup></b></a> | <a href="/?p=faq" title="FAQ">FAQ</a>
    </center>
    <table id="boardlist" border="0" align="center" cellpadding="0" cellspacing="0" style="border-top:1px #AAA solid">
    <tbody>
    <tr><td valign="top">
        <div class="content">
<h2><div class="newssub">$pегистрация</div><div class="permalink"></div></h2>
<p>Регистрация позволяет создавать собственные доски и осуществлять полноценную их модерацию. <br />Это никак не отразится на вашей анонимности.</p><br />
<form action="manage_page.php?action=sregister" method="post" id="sregister">
	<div class="hf fl">
		Логин:<br>
		<input type="text" name="username" id="username"><br/>
		Пароль:<br>
		<input type="password" name="pass1" id="pass1"><br/>
		<input type="password" name="pass2" id="pass2" placeholder="Еще раз"><br>
		<input id="wryyy" type="submit" value="WRYYY!!" disabled title="Пройдите игру --&gt;"/>
	</div>
	<div class="hf"><? echo $ayah->getPublisherHTML(); ?></div>
</form>

    </td></tr>
    </tbody></table>
</div>
<script>
	$(document).ready(function() {
		if (!AYAH.isIframeCommSupported()) {
			alert('Ваш браузер не поддерживает iframe и вы не сможете ввести капчу.');
		}
		var gameCompleted = false;
		$('#sregister').on('submit', function() {
			if($('#pass1').val() !== $('#pass2').val()) {
				alert('Пароли не совпадают.');
				return false;
			}
			if(!gameCompleted) {
				alert('Пройдите игру.');
				return false;
			}
		});
		AYAH.addGameCompleteHandler(function() {
			$('#wryyy').removeAttr('disabled title');
			gameCompleted = true;
		});
	});
</script>