ad_page_contract {
    @author: JC (jcardona@mednet.ucla.edu)
    @creation-date: 2020-06-30
} {
}

set title           "Associate Groups / Tiles"
set package_url     [ad_conn vhost_package_url]

set dt_groups_url   "${package_url}admin/datatable-json/groups"
set dt_tiles_url    "${package_url}admin/datatable-json/tiles"
set ajax_groups_url "${package_url}admin/list-ajax/groups"
set ajax_tiles_url  "${package_url}admin/list-ajax/tiles"

 security::csp::require script-src "'strict-dynamic'"


template::head::add_css -href "//cdn.datatables.net/2.0.3/css/dataTables.dataTables.min.css" -order 99
template::head::add_javascript -src "//cdn.datatables.net/2.0.3/js/dataTables.min.js" -order 99

security::csp::require script-src cdn.datatables.net
security::csp::require style-src cdn.datatables.net