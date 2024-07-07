ad_page_contract {
    @author: JC (jcardona@mednet.ucla.edu)
    @creation-date: 2020-06-30
} {
    {group_tile_id}
}

set package_url     [ad_conn vhost_package_url]
set destination_url "${package_url}admin/"

if [dap::group::tile::delete -group_tile_id $group_tile_id -modifying_user [ad_conn user_id]] {
    set message "Group has been removed"
} else {
    set message "Group has not been removed"
}
ad_returnredirect -message $message "${destination_url}"
ad_script_abort
