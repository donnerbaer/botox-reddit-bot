% rebase('base.tpl', title=f'Search', activeNav=activeNav)



    <form action="/search_result" method="post">
      <div class="mb-3">
        <label for="id" class="form-label">ID</label>
        <input type="number" class="form-control" id="id" name="id">
      </div>
      <div class="mb-3">
        <label for="unnamed" class="form-label">Unnamed</label>
        <input type="number" class="form-control" id="unnamed" name="unnamed">
      </div>
      <div class="mb-3">
        <label for="annotator" class="form-label">Annotator</label>
        <input type="text" class="form-control" id="annotator" name="annotator">
      </div>
      <div class="mb-3">
        <label for="user_id" class="form-label">User ID</label>
        <input type="text" class="form-control" id="user_id" name="user_id">
      </div>
      <div class="mb-3 form-check">
        <input type="checkbox" class="form-check-input" id="was_fetched" name="was_fetched">
        <label class="form-check-label" for="was_fetched">Was Fetched</label>
      </div>
      <div class="mb-3 form-check">
        <input type="checkbox" class="form-check-input" id="is_duplicate" name="is_duplicate">
        <label class="form-check-label" for="is_duplicate">Is Duplicate</label>
      </div>
      <div class="mb-3 form-check">
        <input type="checkbox" class="form-check-input" id="is_deleted" name="is_deleted">
        <label class="form-check-label" for="is_deleted">Is Deleted</label>
      </div>

      <div class="mb-3 form-check">
        <input type="checkbox" class="form-check-input" id="is_banned" name="is_banned">
        <label class="form-check-label" for="is_banned">Is Banned</label>
      </div>

      <div class="mb-3 form-check">
        <input type="checkbox" class="form-check-input" id="human" name="human">
        <label class="form-check-label" for="human">Human</label>
      </div>
      <div class="mb-3 form-check">
        <input type="checkbox" class="form-check-input" id="bot" name="bot">
        <label class="form-check-label" for="bot">Bot</label>
      </div>
      <div class="mb-3 form-check">
        <input type="checkbox" class="form-check-input" id="like" name="like">
        <label class="form-check-label" for="like">Like</label>
      </div>
      <div class="mb-3 form-check">
        <input type="checkbox" class="form-check-input" id="repost" name="repost">
        <label class="form-check-label" for="repost">Repost</label>
      </div>
      <div class="mb-3 form-check">
        <input type="checkbox" class="form-check-input" id="derived_content" name="derived_content">
        <label class="form-check-label" for="derived_content">Derived Content</label>
      </div>
      <div class="mb-3 form-check">
        <input type="checkbox" class="form-check-input" id="repeated_posts" name="repeated_posts">
        <label class="form-check-label" for="repeated_posts">Repeated Posts</label>
      </div>
      <div class="mb-3 form-check">
        <input type="checkbox" class="form-check-input" id="fluent_content" name="fluent_content">
        <label class="form-check-label" for="fluent_content">Fluent Content</label>
      </div>
      <div class="mb-3 form-check">
        <input type="checkbox" class="form-check-input" id="active_inactivity_period" name="active_inactivity_period">
        <label class="form-check-label" for="active_inactivity_period">Active Inactivity Period</label>
      </div>
      <div class="mb-3 form-check">
        <input type="checkbox" class="form-check-input" id="high_frequency_activity" name="high_frequency_activity">
        <label class="form-check-label" for="high_frequency_activity">High Frequency Activity</label>
      </div>
      <div class="mb-3">
        <label for="note" class="form-label">Note</label>
        <textarea class="form-control" id="note" name="note" rows="3"></textarea>
      </div>
      <button type="submit" class="btn btn-primary">Search</button>
    </form>