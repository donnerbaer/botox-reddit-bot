<!DOCTYPE html>
<html lang="en">
<head>
	
	<meta charset="utf-8">
  	<meta name="viewport" content="width=device-width, initial-scale=1">
  	<link href="/static/css/bootstrap.min.css" rel="stylesheet">
  	
    <title>{{ title or 'No title' }}</title>
	
</head>
<body class="px-md-3 py-sm-1 mb-4">
    <div class="py-4">
		% include('menu.tpl', activeNavigation=activeNav)
	</div>
	<div class="px-lg-4 pt-3">
		<main class="py-sm-2 py-xl-2 ">
			<!-- CONTENT -->
            {{ !base }}
		</main>
	</div>
	
    <script src="/static/js/bootstrap.bundle.min.js"></script>
	
	<script>
		const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]')
		const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl))
	</script>

</body>
</html>
