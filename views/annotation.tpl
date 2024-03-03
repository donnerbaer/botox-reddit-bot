<%
title = 'new annotation' 
activeNav = 'new'
if data is not None:
    title = data[3]
    activeNav = 'random'


end
print(data)
%>

% rebase('base.tpl', title=f'Annotation {title}', activeNav=activeNav)

<%
    empty_data = False
    if data is None:
        data = ['', None, None, '', None, None, None, None, None, None, None, None, None, None, None, None, None, None]
        empty_data = True
    end

    was_fetched_button_style = "btn btn-secondary"
    was_fetched_button_text = "fetch again"
    if data[4] == 0 or data[4] is None or data[4] is False or data[4] == "":
        was_fetched_button_style = "btn btn-warning"
        was_fetched_button_text = "fetch now"
    end


    was_fetched_checked = "checked"
    if data[4] == 0 or data[4] is None or data[4] is False or data[4] == "":
        was_fetched_checked = ""
    end


    is_duplicate_checked = "checked"
    if data[5] == 0 or data[5] is None or data[5] is False or data[5] == "":
        is_duplicate_checked = ""
    end
    

    is_banned_checked = "checked"
    if data[6] == 0 or data[6] is None or data[6] is False or data[6] == "":
        is_banned_checked = ""
    end
    
    is_deleted_checked = "checked"
    if data[7] == 0 or data[7] is None or data[7] is False or data[7] == "":
        is_deleted_checked = ""
    end

    human_checked = "checked"
    if data[8] == 0 or data[8] is None or data[8] is False or data[8] == "":
        human_checked = ""
    end
    

    bot_checked = "checked"
    if data[9] == 0 or data[9] is None or data[9] is False or data[9] == "":
        bot_checked = ""
    end
    

    like_checked = "checked"
    if data[10] == 0 or data[10] is None or data[10] is False or data[10] == "":
        like_checked = ""
    end
    

    repost_checked = "checked"
    if data[11] == 0 or data[11] is None or data[11] is False or data[11] == "":
        repost_checked = ""
    end
    

    derived_content_checked = "checked"
    if data[12] == 0 or data[12] is None or data[12] is False or data[12] == "":
        derived_content_checked = ""
    end
    

    repeated_posts_checked = "checked"
    if data[13] == 0 or data[13] is None or data[13] is False or data[13] == "":
        repeated_posts_checked = ""
    end
    

    fluent_content_checked = "checked"
    if data[14] == 0 or data[14] is None or data[14] is False or data[14] == "":
        fluent_content_checked = ""
    end
    

    active_inactivity_period_checked = "checked"
    if data[15] == 0 or data[15] is None or data[15] is False or data[15] == "":
        active_inactivity_period_checked = ""
    end
    

    high_frequency_activity_checked = "checked"
    if data[16] == 0 or data[16] is None or data[16] is False or data[16] == "":
        high_frequency_activity_checked = ""
    end
    

    note = data[17]
    if( data[17] == 0 or data[17] is None or data[17] is False):
        note = ""
    end

%>









    <div class="container">

	    <h1 class="h4">Annotation {{data[3]}}</h1>
        <div class="mb-3">
            %if empty_data == False:
            <a class="{{was_fetched_button_style}}" href="/../../fetch/{{data[1]}}/{{data[3]}}">{{was_fetched_button_text}}</a>
            <a class="btn btn-primary" href="https://www.reddit.com/user/{{data[3]}}" target="_blank">Reddit u/{{data[3]}}</a>

                %if data[4] == 1:
                    <a class="btn btn-primary" href="/../data/{{data[3]}}.json">{{data[3]}}.json</a>
                    <a class="btn btn-primary" href="/../data/{{data[3]}}.json" target="_blank">open Tab {{data[3]}}.json</a>
                %end 
            % end
        </div>


        <form class="" action ="/save" method="post">
            <!-- ID -->
            <div class="form-group">
                <label for="id">ID</label>
                <input type="text" class="form-control" id="id" name="id" value="{{data[0]}}">
            </div>
            
            <!-- Unnamed -->
            <div class="form-group">
                <label for="unnamed">Unnamed <span class="text-danger">(required)</span></label>
                <input type="number" class="form-control" id="unnamed" name="unnamed" value="{{data[1]}}" required>
            </div>
            
            <!-- Annotator -->
            <div class="form-group">
                <label for="annotator">Annotator</label>
                <%
                    annotator = ''

                    #print(annotator)
                    #print(type(annotator))
                    #print()
                    #print(data[2])
                    #print(type(data[2]))
                    #print()
                    #print(annotator_marker)
                    #print(annotator_marker)

                    if annotator_marker is not None and annotator_marker != '':
                        annotator = annotator_marker
                    elif data[2] is not None and data[2] != '': 
                        annotator = data[2]
                   
                    end
                %>
                <input type="text" class="form-control" id="annotator" name="annotator" value="{{annotator}}">
            </div>
            
            <!-- User ID -->
            <div class="form-group">
                <label for="user_id">User ID <span class="text-danger">(required)</span></label>
                <input type="text" class="form-control" id="user_id" name="user_id" value="{{data[3]}}" required>
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
                    <input type="checkbox" class="form-check-input" id="is_duplicate" name="is_duplicate" {{is_duplicate_checked}}>
                    <label class="form-check-label" for="is_duplicate">Is Duplicate</label>
                    <button type="button" class="btn btn-info " data-bs-toggle="tooltip" data-bs-placement="right" 
				            data-bs-title="if the user_id is more then once in the system">?</button>
                </div>
                <div class="form-check">
                    <input type="checkbox" class="form-check-input" id="is_deleted" name="is_deleted" {{is_deleted_checked}}>
                    <label class="form-check-label" for="is_deleted">Is Deleted</label>
                </div>
                <div class="form-check">
                    <input type="checkbox" class="form-check-input" id="is_banned" name="is_banned" {{is_banned_checked}}>
                    <label class="form-check-label" for="is_banned">Is Banned</label>
                </div>

                <div class="form-check">
                    <input type="checkbox" class="form-check-input" id="human" name="human" {{human_checked}}>
                    <label class="form-check-label" for="human">Human</label>
                </div>
                <div class="form-check">
                    <input type="checkbox" class="form-check-input" id="bot" name="bot" {{bot_checked}}>
                    <label class="form-check-label" for="bot">Bot</label>
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
                    <label class="form-check-label" for="derived_content">Derived Content</label>
                </div>
                <div class="form-check">
                    <input type="checkbox" class="form-check-input" id="repeated_posts" name="repeated_posts" {{repeated_posts_checked}}>
                    <label class="form-check-label" for="repeated_posts">Repeated Posts</label>
                </div>
                <div class="form-check">
                    <input type="checkbox" class="form-check-input" id="fluent_content" name="fluent_content" {{fluent_content_checked}}>
                    <label class="form-check-label" for="fluent_content">Fluent Content</label>
                </div>
                <div class="form-check">
                    <input type="checkbox" class="form-check-input" id="active_inactivity_period" name="active_inactivity_period" {{active_inactivity_period_checked}}>
                    <label class="form-check-label" for="active_inactivity_period">Active Inactivity Period</label>
                </div>
                <div class="form-check">
                    <input type="checkbox" class="form-check-input" id="high_frequency_activity" name="high_frequency_activity" {{high_frequency_activity_checked}}>
                    <label class="form-check-label" for="high_frequency_activity">High Frequency Activity</label>
                </div>
                
                <!-- Note -->
                <div class="form-group">
                    <label for="note">Note</label>
                    <textarea class="form-control" id="note" rows="3" name="note">{{note}}</textarea>
                </div>
            </div>


            <input type="hidden" id="anno_type" name="anno_type" value="{{anno_type}}">
            <input type="hidden" id="annotator_marker" name="annotator_marker" value="{{annotator_marker}}">

            <!-- Submit Button -->
            <div class="my-3">
            
            <button type="submit" class="btn btn-success me-5">Save</button>
            <button type="reset" class="btn btn-danger ms-5 ms-5">Reset form</button>


            <a class="btn btn-primary ms-5 ms-5" href="/next?annotator={{annotator}}">next unannotated entry</a>
            <a class="btn btn-success ms-5 ms-5" href="/new?annotator={{annotator}}&anno_type=new">add new annotated entry</a>
            
            
            </div>
        </form>
    </div>

<div class="position-absolute top-50 end-0 translate-middle-y">
    <img src="./../../static/img/collecting_bot_data_reddit.png" class="rounded float-end" style="width:900px" alt="collecting bot data reddit">

    </div>