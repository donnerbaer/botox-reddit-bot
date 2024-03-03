<%
	#list of all url for main menu
	#url , link text
    navigationList=[
		['','Home'],
		['new','new annotation'],
		['random','annotate'],
        ['database','Show Database'],
		['database/not_annotated','Data (not annotated)'],
		['database/has_annotation','Data (annotated)'],
		['search','Search']
		
    ]

%>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
	<div class="container-fluid">
		<a class="navbar-brand" href="/">
            <span class="px-3"></span>
        </a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav me-auto mb-2 mb-lg-0">

				%for entry in navigationList:
					<% 
						if activeNavigation == entry[0]:
							navClass = "btn-secondary active"
						else:
							navClass = "btn-dark"
						end
					%>

					<li class="nav-item btn rounded-0 border-0 {{ navClass }}">
						<a class="nav-link active" href="../../{{entry[0]}}">{{entry[1]}}</a>
					</li>
				%end


			</ul>
		</div>
	</div>
	</nav>
