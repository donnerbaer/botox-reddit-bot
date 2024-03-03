% rebase('base.tpl', title='All data', activeNav=activeNav)

<table class="table table-bordered">
<tr class="table-primary">
    <th>Show Annotation</th>
    <th>ID (INTEGER)</th>
    <th>unnamed (INTEGER)</th>
    <th>annotator (TEXT)</th>
    <th>user_id (TEXT)<br> <span class="text-danger">[Link to Reddit]</span></th>
    <th>was_fetched (BOOL)</th>
    <th>is_duplicate (BOOL)</th>
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
    <td><a class="btn btn-primary" href="../annotation/{{entry[1]}}/{{entry[3]}}">Annotate</a></td>
    %for datapoint in entry:
        <%
        if datapoint == None:
            datapoint = ""
        end
        %>    
        %if datapoint == entry[3]:
            <td><a href="https://www.reddit.com/user/{{entry[3]}}" target="_blank">u/{{entry[3]}}</td>
        %else:
            <td>{{datapoint}}</td>
        %end
    %end
</tr>

%end


</table>