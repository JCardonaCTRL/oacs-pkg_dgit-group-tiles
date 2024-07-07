ad_page_contract {
    @author: JC (jcardona@mednet.ucla.edu)
    @creation-date: 2020-06-30
} {
    {group_tile_id}
}

set package_url     [ad_conn vhost_package_url]
set destination_url "${package_url}admin/group/remove?[export_vars {group_tile_id}]"

dap::group::tile::get -group_tile_id $group_tile_id -column_array tile_info
set tile_ref    [dap::tile::getModuleName -tile_id $tile_info(tile_id)]
