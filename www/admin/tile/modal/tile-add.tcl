ad_page_contract {
    @author: JC (jcardona@mednet.ucla.edu)
    @creation-date: 2020-07-02
} {
    {group_id}
}

set package_url [ad_conn vhost_package_url]
group::get -group_id $group_id -array group_info

set title       "Tiles for group $group_info(group_name)"

set tiles_list          [list]

db_foreach get_tiles "" {
    set tile_ref        [dap::tile::getModuleName -tile_id $tile_id]
    lappend tiles_list [list "$package_name ($tile_ref)" $tile_id]
}
set associated_tiles    [db_list_of_lists get_assigned_tiles ""]

ad_form -name tile_form -export {group_id} -has_submit 1 -html {class "margin-form"} -form {
    {tiles:text(checkbox),multiple,optional
        {label "Tiles"}
        {html {class "ou-checkbox" required required}}
        {options $tiles_list}
    }
    {label1:text(text) {label ""} {mode display}}
} -on_request {
    set tiles $associated_tiles
} -on_submit {
    dap::group::tile::set_tiles \
        -creation_user [ad_conn user_id] \
        -group_id $group_id \
        -selected_tiles $tiles \
        -old_tiles $associated_tiles

} -after_submit {
    ad_returnredirect "${package_url}admin"
    ad_script_abort
}
