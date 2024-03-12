% rebase('base.tpl', title='Index', activeNav='')

<h1 class="h1">Reddit user annotation</h1>



<div>
    <table class="table table-bordered table-striped">
    <thead class="table-dark">
        <tr>
            <th>Annotator</th>
            <th>Database: has already annotated</th>
            <th>Database: still has to go</th>
            <th>Quick annotation for  
                    <button type="button" class="btn btn-info " data-bs-toggle="tooltip" data-bs-placement="right" 
                            data-bs-title="Set all accounts as annotated, this applies to: [Annotator is NULL and (is_deleted=1 or is_banned=1)] This process can take a while">?</button> 
            </th>
        </tr>
    </thead>
    <tbody> 
        %for annotator in data.get('annotator_numbers'):
        <tr>
            <td>{{annotator[0]}}</td>
            <td><a class="btn btn-primary" href="database/has_annotation/{{annotator[0]}}">Show Database <span class="badge text-bg-secondary">{{annotator[1]}}</span></a></td>
            <td><a class="btn btn-primary" href="database/not_annotated/{{annotator[0]}}">Show Database <span class="badge text-bg-secondary">{{data.get('number_not_annotated')-annotator[1]}}</span></a></td>
            <td><a class="btn btn-warning" href="/quick_annotation/{{annotator[0]}}">Quick annotation for {{annotator[0]}}  <span class="badge text-bg-secondary">{{data.get('quick_annotation')}}</span></a></td>
        </tr>
        %end
        </tbody>
    </table>
</div>