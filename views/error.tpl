<%
    # This component represents server error page e.g. Error 404 or Error 500

    # requierements
    #
    # errorCode:int = code of the error
    # errorMsg:str = message of the error
%>

% rebase('base.tpl', title=errorCode, activeNav=None)
<h1 class="h1">Error {{errorCode}}</h1>
<p>{{errorMsg}}</p>
