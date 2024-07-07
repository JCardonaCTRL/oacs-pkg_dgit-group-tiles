ad_page_contract {
    @author: JC (jcardona@mednet.ucla.edu)
    @creation-date: 2020-06-30
} {
    {group_type_name "dgsom_app"}
}

set package_url [ad_conn vhost_package_url]

ctrl::jquery::datatable::query_param

set sql_order ""
set sql_order_list ""
foreach {col dir} $dt_info(sort_list) {
    lappend sql_order_list "$col $dir"
}

if ![empty_string_p $sql_order_list] {
    set sql_order " order by [join $sql_order_list ","]"
}

set sql_search_filter ""
# ---------------------------------------------
# Add filter for the numbmer of rows to display
# ----------------------------------------------
array set dt_page_info $dt_info(page_attribute_list)
set sql_filter_row "where rn > $dt_page_info(start) and rn <= [expr $dt_page_info(start)+$dt_page_info(length)]"
# ---------------------------------------------
# Set search up
# ---------------------------------------------
set search_value ""
if ![empty_string_p $dt_info(search_global)] {
    array set search_arr $dt_info(search_global)
    set search_value $search_arr(value)
}
# -----------------------------------------------
# Generate the records to return
# -----------------------------------------------
set sql_search_list  [list]
set sql_search_filter ""
set field_list  [list group_name]

foreach field_name $field_list {
    if {![empty_string_p $search_value]} {
	lappend sql_search_list "lower($field_name) like '%'||lower(:search_value)||'%'"
    }
}

if {[llength $sql_search_list] > 0} {
    set sql_search_filter " and  ([join $sql_search_list " or "])"
}

set data_json_list ""
set field_list [list group_name group_id num_of_users num_of_tiles]
db_foreach selected_rows_to_display "" {
    set field_json [list]

    foreach fs_field $field_list {
        if [empty_string_p $fs_field] {
            continue
        }
        set $fs_field [ctrl::json::filter_special_chars_dt [set $fs_field]]
        set _value_list [list]
        set new_value [set $fs_field]
        set new_value [regsub -all "\r" $new_value " "]

        lappend field_json [ctrl::json::construct_record  [list [list $fs_field $new_value]]]

    }

    set actions ""
    append actions "<button type='button' \
                            class='btn btn-info btn-xs' \
                            data-toggle='modal' \
                            data-target='#modal-container' \
                            data-bs-toggle='modal' \
                            data-bs-target='#modal-container' \
                            data-destination='${package_url}admin/tile/modal/tile-add?[export_vars {group_id}]'>Manage Tiles</button>"
    #append actions "<a href='${package_url}group/new-tile?[export_vars -url {group_id}]'>Add Tiles</a>"
    lappend field_json [ctrl::json::construct_record [list [list "actions" $actions]]]
    lappend data_json_list "{[join $field_json ","]}"
}
set iFilteredTotal [db_string total_selected_rows ""]
set iTotal         [db_string total_rows ""]
set result [ctrl::json::construct_record [list [list draw $dt_page_info(draw) i] [list recordsTotal $iTotal] [list recordsFiltered $iFilteredTotal] [list data [join $data_json_list ","] a-joined]]]
doc_return 200 application/json "{$result}"
