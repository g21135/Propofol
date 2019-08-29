<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Propofol - 포트폴리오 제작</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta content="" name="keywords">
<meta content="" name="description">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="author" content="colorlib.com">

<!-- Favicons -->
<link href="/img/favicon.png" rel="icon">
<link href="/img/apple-touch-icon.png" rel="apple-touch-icon">


<!-- bootstrap -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- jquery ui-->
<link href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"
	rel="stylesheet" type="text/css">

<!-- Main Stylesheet File -->
<link href="/css/makePortfolio/mainStyle.css" rel="stylesheet">
<body>
	<link rel="stylesheet" href="/css/makePortfolio/layout/info/info.css">

	<div id="layout">
		<div class="editContainer" id="edit-header" style="">
			<div
				class="edit cke_editable cke_editable_inline cke_contents_ltr cke_show_borders"
				id="info-header" contenteditable="true" tabindex="0"
				spellcheck="false" role="textbox" aria-multiline="true"
				aria-label="리치 텍스트 편집기, info-header" title="리치 텍스트 편집기, info-header"
				aria-describedby="cke_68" style="position: relative;">
				<h1>2-Column Layout</h1>
			</div>
		</div>
		<div
			class="editContainer ui-resizable ui-draggable ui-draggable-handle ui-resizable-disabled ui-draggable-disabled"
			id="edit-content" style="left: 44px; top: 94px;">
			<div
				class="edit cke_editable cke_editable_inline cke_contents_ltr cke_show_borders"
				id="info-content" contenteditable="true" tabindex="0"
				spellcheck="false" role="textbox" aria-multiline="true"
				aria-label="리치 텍스트 편집기, info-content"
				title="리치 텍스트 편집기, info-content" aria-describedby="cke_116"
				style="position: relative;">
				<h2>Content</h2>
				<p>
					Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean nec
					mollis nulla. Phasellus lacinia tempus mauris eu laoreet. Proin
					gravida velit dictum dui consequat malesuada. Aenean et n<br>
				</p>
				<div class="youtube-embed-wrapper"
					style="position: relative; padding-bottom: 56.25%; padding-top: 30px; height: 0; overflow: hidden">
					<iframe allow=";" width="640" height="360"
						src="https://www.youtube.com/embed/la-wyQI_fFw"
						style="position: absolute; top: 0; left: 0; width: 100%; height: 100%"
						frameborder="0" allowfullscreen=""></iframe>
				</div>
				<p>ibh eu purus scelerisque aliquet nec non justo. Aliquam vitae
					aliquet ipsum. Etiam condimentum varius purus ut ultricies. Mauris
					id odio pretium, sollicitudin sapien eget, adipiscing risus.</p>
				<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.
					Aenean nec mollis nulla. Phasellus lacinia tempus mauris eu
					laoreet. Proin gravida velit dictum dui consequat malesuada. Aenean
					et nibh eu purus scelerisque aliquet nec non justo. Aliquam vitae
					aliquet ipsum. Etiam condimentum varius purus ut ultricies. Mauris
					id odio pretium, sollicitudin sapien eget, adipiscing risus.</p>
			</div>
			<div class="ui-resizable-handle ui-resizable-n" style="z-index: 90;"></div>
			<div class="ui-resizable-handle ui-resizable-e" style="z-index: 90;"></div>
			<div class="ui-resizable-handle ui-resizable-s" style="z-index: 90;"></div>
			<div class="ui-resizable-handle ui-resizable-w" style="z-index: 90;"></div>
			<div class="ui-resizable-handle ui-resizable-ne" style="z-index: 90;"></div>
			<div
				class="ui-resizable-handle ui-resizable-se ui-icon ui-icon-gripsmall-diagonal-se"
				style="z-index: 90;"></div>
			<div class="ui-resizable-handle ui-resizable-sw" style="z-index: 90;"></div>
			<div class="ui-resizable-handle ui-resizable-nw" style="z-index: 90;"></div>
		</div>
		<div class="editContainer" id="edit-sidebar">
			<div
				class="edit cke_editable cke_editable_inline cke_contents_ltr cke_show_borders"
				id="info-sidebar" contenteditable="true" tabindex="0"
				spellcheck="false" role="textbox" aria-multiline="true"
				aria-label="리치 텍스트 편집기, info-sidebar"
				title="리치 텍스트 편집기, info-sidebar" aria-describedby="cke_164"
				style="position: relative;">
				<h2>Sidebar</h2>
				<ul>
					<li>Lorem</li>
					<li>Ipsum</li>
					<li>Dolor</li>
				</ul>
			</div>
		</div>
		<div class="editContainer" id="edit-footer">
			<div
				class="edit cke_editable cke_editable_inline cke_contents_ltr cke_show_borders"
				id="info-footer" contenteditable="true" tabindex="0"
				spellcheck="false" role="textbox" aria-multiline="true"
				aria-label="리치 텍스트 편집기, info-footer" title="리치 텍스트 편집기, info-footer"
				aria-describedby="cke_212" style="position: relative;">
				<p>Copyright</p>
			</div>
		</div>
	</div>
</body>
</html>
