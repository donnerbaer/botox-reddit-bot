% rebase('base.tpl', title='All data', activeNav=activeNav)

<table class="table table-bordered table-striped">
<tr class="table-dark">
    <th>Show Annotation</th>
    <th>annotator (TEXT)</th>
    <th>user_id (TEXT)<br> <span class="text-danger">[Link to Reddit]</span></th>
    <th>was_fetched (BOOL)</th>
    <th>is_deleted (BOOL)</th>
    <th>is_banned (BOOL)</th>
    <th>human (BOOL)</th>
    <th>bot (BOOL)</th>
    <th>like (BOOL)</th>
    <th>repost (BOOL)</th>
    <th>derived_content (BOOL)</th>
    <th>repeated_posts (BOOL)</th>
    <th>fluent_content (BOOL)</th>
    <th>active_inactivity_period (BOOL)</th>
    <th>high_frequency_activity (BOOL)</th>
    <th>note TEXT</th>
</tr>

%for entry in data:    
<tr>
<%  parameter = ""
    if annotator_marker != "None" and annotator_marker is not None:
        parameter = f"?annotator={annotator_marker}"
    end
%>
    <td><a class="btn btn-primary" href="/../../annotation/{{entry[1]}}/{{entry[0]}}{{parameter}}">Annotate</a></td>
    %for datapoint in entry:
        <%
        if datapoint == None:
            datapoint = ""
        end
        %>    
        %if datapoint == entry[1]:
            <td><a href="https://www.reddit.com/user/{{entry[1]}}" target="_blank">u/{{entry[1]}}</td>
        %else:
            <td>{{datapoint}}</td>
        %end
    %end
</tr>

%end


</table>