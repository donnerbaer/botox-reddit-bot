<%
	#list of all url for main menu
	#url , link text
    navigationList=[
		['','Home'],
		['new','new annotation'],
		['random','annotate'],
    #    ['database','Show Database'],
		['!DROPDOWN','DATABASE'],
	#	 ['database/not_annotated','Data (not annotated)'],
	#	 ['database/has_annotation','Data (annotated)'],
	#	 ['database/has_fetched','Data (fetched)'],
		['search','Search']
    ]

	navigationListDatabase=[
		['database','Show Database'],
		['database/not_annotated','Data (not annotated)'],
		['database/has_annotation','Data (annotated)'],
		['database/has_fetched','Data (fetched)']
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
					<%  navClass = ""
						if activeNavigation == entry[0]:
							navClass = "btn-secondary active"
						end
					%>

					%if entry[0] != '!DROPDOWN':
						<li class="nav-item btn {{ navClass }}">
							<a class="nav-link active" href="../../{{entry[0]}}">{{entry[1]}}</a>
						</li>
					%elif entry[0] == '!DROPDOWN' and entry[1] == 'DATABASE':
						<li class="nav-item dropdown btn {{ navClass }}">
							<a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button" aria-expanded="false">Database Views</a>
							<ul class="dropdown-menu">
							%for db_entry in navigationListDatabase:
								<%  navClass = ""
									if activeNavigation == db_entry[0]:
										navClass = "btn-secondary active"
									end
								%>
								<li><a class="dropdown-item btn" href="../../{{db_entry[0]}}">{{db_entry[1]}}</a></li>
							% end
							</ul>
						</li>
					%end
				%end


			</ul>
		</div>
	</div>
	</nav>
