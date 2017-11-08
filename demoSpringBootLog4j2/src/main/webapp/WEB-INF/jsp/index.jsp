<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Demo</title>
<meta name="description" content="" />
<meta name="viewport" content="width=device-width" />
<base href="/" />
<link rel="stylesheet" type="text/css"
	href="/webjars/bootstrap/css/bootstrap.min.css" />
<script type="text/javascript" src="/webjars/jquery/jquery.min.js"></script>
<script type="text/javascript"
	src="/webjars/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/webjars/js-cookie/js.cookie.js"></script>
<script type="text/javascript">
	$.get("/user", function(data) {
		$("#user").html(data.userAuthentication.details.name);
		$(".unauthenticated").hide()
		$(".authenticated").show()
	});
// 	$.ajax({
// 		  url : "/user",
// 		  success : function(data) {
// 		    $(".unauthenticated").hide();
// 		    $("#user").html(data.userAuthentication.details.name);
// 		    $(".authenticated").show();
// 		  },
// 		  error : function(data) {
// 		    $("#user").html('');
// 		    $(".unauthenticated").show();
// 		    $(".authenticated").hide();
// 		    if (location.href.indexOf("error=true")>=0) {
// 		      $(".error").show();
// 		    }
// 		  }
// 		});
	var logout = function() {
		$.post("/logout", function() {
			$("#user").html('');
			$(".unauthenticated").show();
			$(".authenticated").hide();
		})
		return true;
	}

	$.ajaxSetup({
		beforeSend : function(xhr, settings) {
			if (settings.type == 'POST' || settings.type == 'PUT'
					|| settings.type == 'DELETE') {
				if (!(/^http:.*/.test(settings.url) || /^https:.*/
						.test(settings.url))) {
					// Only send the token to relative URLs i.e. locally.
					xhr.setRequestHeader("X-XSRF-TOKEN", Cookies
							.get('XSRF-TOKEN'));
				}
			}
		}
	});
</script>
</head>
<body>
	<h1>Demo</h1>
	<div class="container"></div>
	<div class="container unauthenticated">
		With Facebook: <a href="/login/facebook">click here</a>
	</div>
	<div>
		With Github: <a href="/login/github">click here</a>
	</div>
	<div class="container authenticated" style="display: none">
		Logged in as: <span id="user"></span>
		<div>
			<button onClick="logout()" class="btn btn-primary">Logout</button>
		</div>
	</div>
	<div class="container text-danger error" style="display: none">
		There was an error (bad credentials).</div>
</body>
</html>