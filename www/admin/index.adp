<master>
<property name="title">@title;noquote@</property>
<style type="text/css">
 td.details-control {
   background: url('/resources/dgit-group-tiles/images/details_open.png') no-repeat center center;
   cursor: pointer;
 }
 tr.shown td.details-control {
   background: url('/resources/dgit-group-tiles/images/details_close.png') no-repeat center center;
 }
</style>

<div class="container">

        <h1>@title;noquote@</h1>


    <div class="row">
        <ul class="nav nav-pills mb-3" id="gmTab" role="tablist">
          <li class="nav-item" role="presentation">
            <button class="nav-link btn-primary active" id="pills-groups-tab"  data-target="#groups-tab" data-toggle="pill" data-bs-target="#groups-tab" data-bs-toggle="pill" 
                    type="button" role="tab" aria-controls="groups-tab" aria-selected="false">
              Groups
            </button>
          </li>
          <li class="nav-item" role="presentation">
            <button class="nav-link btn-info" id="pills-tiles-tab" data-target="#tiles-tab" data-toggle="pill" data-bs-target="#tiles-tab" data-bs-toggle="pill" 
                    type="button" role="tab" aria-controls="tiles-tab" aria-selected="false">
              Tiles
            </button>
          </li>
        </ul>
        <div class="tab-content" id="gmTabContent">

            <div class="tab-pane fade active in show" id="groups-tab" role="tabpanel" aria-labelledby="pills-groups-tab" tabindex="0">
                <table id="group-list" width="100%" cellpadding="0" class="table table-stripped table-hover"></table>
            </div>

            <div class="tab-pane fade" id="tiles-tab" role="tabpanel" aria-labelledby="pills-tiles-tab" tabindex="0">
                <table id="tile-list" width="100%" cellpadding="0" class="table table-stripped table-hover"></table>
            </div>

        </div>
    </div>
</div>

<div class="modal fade" id="modal-container" tabindex="-1" role="dialog" aria-labelledby="Modal">
    <div class="modal-dialog" role="document"></div>
</div>

<script type="text/javascript" <if @::__csp_nonce@ not nil> nonce="@::__csp_nonce;literal@"</if>>

$(".btn-group-remove").on('click', function (event) {
    //var button = $(event.relatedTarget); // Button that triggered the modal
    //location.href = button.data('destination');
    alert('test');
});

$("#modal-container").on('show.bs.modal', function (event) {
    var button = $(event.relatedTarget); // Button that triggered the modal
    var modal = $(this);
    modal.html("");
    modal.load(button.data('destination'));
    console.log('modal-container data');
    console.log(button.data());
});
function getTiles(object) {
    console.log('getTiles');
    console.log(object);
    var html = $.ajax({
        type: "GET",
        url:  "@ajax_tiles_url;noquote@?group_id="+object.group_id,
        async: false
    }).responseText;
    return html;
}
function getGroups(object) {
    var html = $.ajax({
        type: "GET",
        url:  "@ajax_groups_url;noquote@?tile_id="+object.tile_id,
        async: false
    }).responseText;
    return html;
}
$(document).ready(function() {
    var groups_table =
    $("#group-list").DataTable({
        "processing": true,
        "serverSide": true,
        "searching": true,
        "pageLength": 25,
        "ajax": {
          "url": "@dt_groups_url;noquote@",
          "method": "get"
        },
        "columns": [
          { "searchable":false, "orderable":false, "visible": true, "title": "", "data": null, "className": "details-control", "defaultContent": "" , "width": "10%"},
          { "data": "group_name", "title": "Group"},
          { "data": "num_of_users", "title": "No. of Users","class": "center"},
          { "data": "num_of_tiles", "title": "No. of Tiles","class": "center"},
          { "data": "actions", "title": "Actions", "orderable": false, "class": "center", "visible": true, "width": "10%"}
        ],
        "order": [["1","asc"]]
    });

    $("#group-list").on('click', 'td.details-control', function(e) {
        e.preventDefault();
        var tr =    $(this).closest("tr");
        var row =   groups_table.row(tr);
        if ( row.child.isShown() ) {
            row.child.hide();
            tr.removeClass("shown");
        } else {
            row.child( getTiles( row.data() ) ).show();
            tr.addClass("shown");
        }
	});

    var tiles_table =
    $("#tile-list").DataTable({
        "processing": true,
        "serverSide": true,
        "searching": true,
        "pageLength": 25,
        "ajax": {
          "url": "@dt_tiles_url;noquote@",
          "method": "get"
        },
        "columns": [
          { "searchable":false, "orderable":false, "visible": true, "title": "", "data": null, "className": "details-control", "defaultContent": "" , "width": "10%"},
          { "data": "tile_ref", "title": "Tile Name ","orderable": false},
          { "data": "package_key", "title": "Tile Ref"},
          { "data": "package_name", "title": "Tile Instance"},
          { "data": "num_of_groups", "title": "No. of Groups","class": "center"},
          { "data": "actions", "title": "Actions", "orderable": false, "class": "center", "visible": true, "width": "10%"}
        ],
        "order": [["2","asc"]]
    });

    $("#tile-list").on('click', 'td.details-control', function(e) {
        e.preventDefault();
        var tr =    $(this).closest("tr");
        var row =   tiles_table.row(tr);
        if ( row.child.isShown() ) {
            row.child.hide();
            tr.removeClass("shown");
        } else {
            row.child( getGroups( row.data() ) ).show();
            tr.addClass("shown");
        }
	});

    $(".btn-group-remove").click(function(event) {
        var button = $(event.relatedTarget); // Button that triggered the modal
        location.href = button.data('destination');
    });
});
</script>
