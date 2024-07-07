ad_page_contract {
    @author: JC (jcardona@mednet.ucla.edu)
    @creation-date: 2020-06-30
} {
    {group_id}
}

set package_url     [ad_conn vhost_package_url]

db_multirow -extend {remove_link app_code} tiles select_tiles {} {
    set app_code    [dap::tile::getModuleName -tile_id $tile_id]
    set remove_link "<button type='button' \
                            class='btn btn-danger btn-xs' \
                            data-toggle='modal' \
                            data-target='#modal-container' \
                            data-bs-toggle='modal' \
                            data-bs-target='#modal-container' \
                            data-destination='${package_url}admin/tile/modal/tile-remove?[export_vars {group_tile_id group_id tile_id}]'>Remove</button>"
}
