<div class="modal-dialog" role="document">
    <div class="modal-content">
        <div class="modal-header resume-edit-model-header">
            <button type="button" class="close" data-dismiss="modal" data-bs-dismiss="modal" id="aa_cancel_x" aria-label="Close">
            <span aria-hidden="true">&times;</span></button>
            <h4 class="modal-title">Remove Tile</h4>
        </div>
        <div id="removeBox" class="modal-body">
            Are you sure you want to remove the group <i>@tile_info.group_name@</i> from the tile <b>@tile_ref@</b>?
        </div>
        <div class="modal-footer">
            <button id="btn-group-remove" type="button" class="btn btn-danger">Remove</button>
            <button type="button" class="btn btn-default" data-dismiss="modal" data-bs-dismiss="modal">Cancel</button>
        </div>
    </div>
</div>

<script type="text/javascript" <if @::__csp_nonce@ not nil> nonce="@::__csp_nonce;literal@"</if>>
$("#btn-group-remove").click(function() {
    location.href = "@destination_url;noquote@";
});
</script>
