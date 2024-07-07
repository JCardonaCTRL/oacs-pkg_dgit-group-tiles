ad_page_contract {
    @author: JC (jcardona@mednet.ucla.edu)
    @creation-date: 2020-07-02
} {
    {tile_id}
}

set package_url [ad_conn vhost_package_url]
set tile_ref    [dap::tile::getModuleName -tile_id $tile_id]
set title       "Groups for tile $tile_ref"

set group_list          [db_list_of_lists get_groups ""]
set associated_groups   [db_list_of_lists get_assigned_groups ""]

ad_form -name group_form -export {tile_id} -has_submit 1 -html {class "margin-form"} -form {
    {groups:text(checkbox),multiple,optional
        {label "Groups"}
        {html {class "ou-checkbox" required required}}
        {options $group_list}
    }
    {label1:text(text) {label ""} {mode display}}
} -on_request {
    set groups $associated_groups
} -on_submit {
    dap::group::tile::set_groups \
        -creation_user [ad_conn user_id] \
        -tile_id $tile_id \
        -selected_groups $groups \
        -old_groups $associated_groups

} -after_submit {
    ad_returnredirect "${package_url}admin"
    ad_script_abort
}
