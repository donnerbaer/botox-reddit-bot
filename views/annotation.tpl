<%
    title = 'new annotation' 
    activeNav = 'new'
    if data is not None:
        title = data[1]
        activeNav = 'random'
    end

    print(data) 
%>

% rebase('base.tpl', title=f'Annotation {title}', activeNav=activeNav)

<%
    empty_data = False
    if data is None:
        data = ['', '', None, None, None, None, None, None, None, None, None, None, None, None, None, None]
        empty_data = True
    end

    annotator = ''
    if annotator_marker is not None and annotator_marker != '':
        annotator = annotator_marker
    elif data[0] is not None and data[0] != '': 
        annotator = data[0]
    end


    was_fetched_button_style = "btn btn-secondary"
    was_fetched_button_text = "fetch again"
    was_fetched_checked = "checked"
    if data[2] == 0 or data[2] is None or data[2] is False or data[2] == "":
        was_fetched_button_style = "btn btn-warning"
        was_fetched_button_text = "fetch now"
        was_fetched_checked = ""
    end


    is_deleted_checked = "checked"
    if data[3] == 0 or data[3] is None or data[3] is False or data[3] == "":
        is_deleted_checked = ""
    end
    
    is_banned_checked = "checked"
    if data[4] == 0 or data[4] is None or data[4] is False or data[4] == "":
        is_banned_checked = ""
    end

    human_checked = "checked"
    if data[5] == 0 or data[5] is None or data[5] is False or data[5] == "":
        human_checked = ""
    end
    

    bot_checked = "checked"
    if data[6] == 0 or data[6] is None or data[6] is False or data[6] == "":
        bot_checked = ""
    end
    

    like_checked = "checked"
    if data[7] == 0 or data[7] is None or data[7] is False or data[7] == "":
        like_checked = ""
    end
    

    repost_checked = "checked"
    if data[8] == 0 or data[8] is None or data[8] is False or data[8] == "":
        repost_checked = ""
    end
    

    derived_content_checked = "checked"
    if data[9] == 0 or data[9] is None or data[9] is False or data[9] == "":
        derived_content_checked = ""
    end
    

    repeated_posts_checked = "checked"
    if data[10] == 0 or data[10] is None or data[10] is False or data[10] == "":
        repeated_posts_checked = ""
    end
    

    fluent_content_checked = "checked"
    if data[11] == 0 or data[11] is None or data[11] is False or data[11] == "":
        fluent_content_checked = ""
    end
    

    active_inactivity_period_checked = "checked"
    if data[12] == 0 or data[12] is None or data[12] is False or data[12] == "":
        active_inactivity_period_checked = ""
    end
    

    high_frequency_activity_checked = "checked"
    if data[13] == 0 or data[13] is None or data[13] is False or data[13] == "":
        high_frequency_activity_checked = ""
    end
    

    note = data[14]
    if( data[14] == 0 or data[14] is None or data[14] is False):
        note = ""
    end


    json_file_path = f'./../../json/{data[1]}.json'
%>






    <div class="container">
        <div class="row">
            <div class="col-2">
                <h1 class="h4">Annotation {{data[1]}}</h1>
                <div class="mb-3">
                    %if empty_data == False:
                        %if data[0] is not None and data[0] != '':
                            <a class="{{was_fetched_button_style}}" href="/../../fetch/{{data[1]}}/{{data[0]}}">{{was_fetched_button_text}}</a>
                        %else:
                            <a class="{{was_fetched_button_style}}" href="/../../fetch/{{data[1]}}?annotator={{annotator}}">{{was_fetched_button_text}}</a>
                        %end
                    <a class="btn btn-warning" href="https://www.reddit.com/user/{{data[1]}}" target="_blank">Reddit u/{{data[1]}}</a>

                        %if data[2] == 1:
                            <a class="btn btn-primary" href="/../json/{{data[1]}}.json">{{data[1]}}.json</a>
                            <a class="btn btn-primary" href="/../json/{{data[1]}}.json" target="_blank">open Tab {{data[1]}}.json</a>
                        %end 
                    % end
                </div>
            </div>
        </div>



    <div class="row">
        <div class="col">
            <form class="" action ="/save" method="post">

                <!-- Annotator -->
                <div class="form-group">
                    <label for="annotator">Annotator <span class="text-danger">(required)</span></label>
                    <input type="text" class="form-control" id="annotator" name="annotator" value="{{annotator}}" required>
                </div>
                
                <!-- User ID -->
                <div class="form-group">
                    <label for="user_id">User ID <span class="text-danger">(required)</span></label>
                    <input type="text" class="form-control" id="user_id" name="user_id" value="{{data[1]}}" required>
                </div>
                
                <!-- Checkboxes for Boolean Fields -->
                <div class="my-2">
                    <div class="form-check">
                        <input type="checkbox" class="form-check-input" id="was_fetched" name="was_fetched" {{was_fetched_checked}}>
                        <label class="form-check-label" for="was_fetched">was fetched</label>
                        <button type="button" class="btn btn-info " data-bs-toggle="tooltip" data-bs-placement="right" 
                                data-bs-title="will autmaticaly updated if you click 'fetch now', unnamed and user id need to be in the system">?</button>
                    </div>
                    <div class="form-check">
                        <input type="checkbox" class="form-check-input" id="is_deleted" name="is_deleted" {{is_deleted_checked}}>
                        <label class="form-check-label" for="is_deleted">Is Deleted, Renamed or never existed</label>
                    </div>
                    <div class="form-check">
                        <input type="checkbox" class="form-check-input" id="is_banned" name="is_banned" {{is_banned_checked}}>
                        <label class="form-check-label" for="is_banned">Is Banned</label>
                    </div>
                    <div class="form-check">
                        <input type="checkbox" class="form-check-input" id="human" name="human" {{human_checked}}>
                        <label class="form-check-label" for="human">Human (could be)</label>
                    </div>
                    <div class="form-check">
                        <input type="checkbox" class="form-check-input" id="bot" name="bot" {{bot_checked}}>
                        <label class="form-check-label" for="bot">Bot (could be)</label>
                    </div>
                    <div class="form-check">
                        <input type="checkbox" class="form-check-input" id="like" name="like" {{like_checked}}>
                        <label class="form-check-label" for="like">Like</label>
                    </div>
                    <div class="form-check">
                        <input type="checkbox" class="form-check-input" id="repost" name="repost" {{repost_checked}}>
                        <label class="form-check-label" for="repost">Repost</label>
                    </div>
                    <div class="form-check">
                        <input type="checkbox" class="form-check-input" id="derived_content" name="derived_content" {{derived_content_checked}}>
                        <label class="form-check-label" for="derived_content">Derived Content (copy & paste)</label>
                    </div>
                    <div class="form-check">
                        <input type="checkbox" class="form-check-input" id="repeated_posts" name="repeated_posts" {{repeated_posts_checked}}>
                        <label class="form-check-label" for="repeated_posts">Repeated Posts</label>
                    </div>
                    <div class="form-check">
                        <input type="checkbox" class="form-check-input" id="fluent_content" name="fluent_content" {{fluent_content_checked}}>
                        <label class="form-check-label" for="fluent_content">Fluent in language</label>
                    </div>
                    <div class="form-check">
                        <input type="checkbox" class="form-check-input" id="active_inactivity_period" name="active_inactivity_period" {{active_inactivity_period_checked}}>
                        <label class="form-check-label" for="active_inactivity_period">Active Inactivity Period (large Inactivity and then activity)</label>
                    </div>
                    <div class="form-check">
                        <input type="checkbox" class="form-check-input" id="high_frequency_activity" name="high_frequency_activity" {{high_frequency_activity_checked}}>
                        <label class="form-check-label" for="high_frequency_activity">High Frequency Activity</label>
                    </div>
                    
                    <!-- Note -->
                    <div class="form-group">
                        <label for="note">Note:</label>
                        <textarea class="form-control" id="note" rows="3" name="note">{{note}}</textarea>
                    </div>
                </div>


                <input type="hidden" id="anno_type" name="anno_type" value="{{anno_type}}">
                <input type="hidden" id="annotator_marker" name="annotator_marker" value="{{annotator_marker}}">

                <!-- Submit Button -->
                <div class="my-3">
                
                    <button type="submit" class="btn btn-success">Save</button>
                    <button type="reset" class="btn btn-danger">Reset form</button>

                    <a class="btn btn-primary" href="/next?annotator={{annotator}}">next entry</a>
                    <a class="btn btn-success" href="/new?annotator={{annotator}}&anno_type=new">add new entry</a>
                
                </div>
            </form>
        </div>

        <div class="col">
            <h2 class="h6">json <button type="button" class="btn btn-info " data-bs-toggle="tooltip" data-bs-placement="right" 
                                data-bs-title="if json file has only username and rest has null-values user is deleted, banned or renamed">?</button></h2>
            <pre>
                <div w3-include-html="{{json_file_path}}"></div> 
            </pre>
        </div>

    </div>



    



<!-- source https://www.w3schools.com/howto/howto_html_include.asp -->
<script>
    function includeHTML() {
    var z, i, elmnt, file, xhttp;
    /*loop through a collection of all HTML elements:*/
    z = document.getElementsByTagName("*");
    for (i = 0; i < z.length; i++) {
        elmnt = z[i];
        /*search for elements with a certain atrribute:*/
        file = elmnt.getAttribute("w3-include-html");
        if (file) {
        /*make an HTTP request using the attribute value as the file name:*/
        xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function() {
            if (this.readyState == 4) {
            if (this.status == 200) {elmnt.innerHTML = this.responseText;}
            if (this.status == 404) {elmnt.innerHTML = "{{data[1]}}.json not found or fetched";}
            /*remove the attribute, and call this function once more:*/
            elmnt.removeAttribute("w3-include-html");
            includeHTML();
            }
        }      
        xhttp.open("GET", file, true);
        xhttp.send();
        /*exit the function:*/
        return;
        }
    }
    };
</script>

<script>
    includeHTML();
</script>


