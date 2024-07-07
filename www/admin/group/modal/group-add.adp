<style>
    .name-textbox{
        width:400px;
    }
    input[type="checkbox"]{
        margin:5px;
    }
    div.form-required-mark,
    strong.form-required-mark {
        font-size: 0;
        color:transparent;
        display:inline;
    }
    div.form-required-mark:after,
    strong.form-required-mark:after {
       color:red;
       content: "*";
       font-size:18px;
       font-weight:bold;
    }
    span.form-label {
        float: left;
        text-align: right;
        display: block;
        width: 16em;
        margin-bottom: 5px;
        font-weight: bold;
    }
    .required {
        /* insert your own styles for invalid form input */
        -moz-box-shadow: none;
        color: red;
    }
</style>

<div class="modal-dialog" role="document">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" data-bs-dismiss="modal" id="aa_cancel_x" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
            <h4 class="modal-title">@title;noquote@</h4>
        </div>
        <div class="modal-body">
            <formtemplate id="group_form"></formtemplate>
        </div>
        <div class="modal-footer">
            <button type='button' class='btn btn-success' id="btn-submit-grup-form">Submit</button>
            <button type='button' class='btn btn-default' data-dismiss="modal" data-bs-dismiss="modal">Close</button>
        </div>
    </div>
</div>

<script type="text/javascript" <if @::__csp_nonce@ not nil> nonce="@::__csp_nonce;literal@"</if>>
    $("#btn-submit-grup-form").click(function(){
        var $checkboxes             = $('#group_form input[type="checkbox"]');
        var countCheckedCheckboxes  = $checkboxes.filter(':checked').length;

        if (countCheckedCheckboxes > 0) {
            $("#group_form").submit();
        } else {
            $('#group_form :input:visible[required="required"]').each(function() {
                $(this).parent('label').addClass('required');
            });
        }
    });
</script>
