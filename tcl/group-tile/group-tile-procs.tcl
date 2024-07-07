ad_library {

    Set of TCL procedures to handle group tiles

    @author JC (jcardona@mednet.ucla.edu)
    @cvs-id $Id$
    @creation-date 2020-06-30

}

namespace eval dap::group::tile {}

ad_proc -public dap::group::tile::get {
    -group_tile_id:required
    -all:boolean
    {-column_array "dap_group_tile_info"}
} {
    Get the group tile information
} {
    upvar $column_array row

    if {$all_p} {
        set exists_p [db_0or1row select_all "" -column_array row]
    } else {
        set exists_p [db_0or1row select_active "" -column_array row]
    }

    set row(exists_p) $exists_p
}

ad_proc -public dap::group::tile::get_element {
    -group_tile_id:required
    -element:required
    -all:boolean
} {
    Returns a specific element of the group tile data
} {
    dap::group::tile::get -all=$all_p -group_tile_id $group_tile_id -column_array "gt_info"
    return $gt_info($element)
}

ad_proc -public dap::group::tile::new {
    -group_tile_id
    -group_id:required
    -tile_id:required
    -creation_user:required
} {
    Creates a new group/tile relation
} {
    if {![info exists group_tile_id]} {
        set group_tile_id [db_nextval "dgit_group_tile_seq"]
    }

    set failed_p 0
    db_transaction {
        db_dml insert ""
    } on_error {
        set failed_p 1
        db_abort_transaction
    }
    if $failed_p {
        error "DGSOM App - Failed to add: $errmsg"
    }
    return $group_tile_id
}

ad_proc -public dap::group::tile::delete {
    -group_tile_id:required
    -modifying_user:required
} {
    Deletes a group/tile relation
} {
    set success_p   0
    set failed_p    0
    db_transaction {
        db_dml delete ""
        set success_p 1
    } on_error {
        set failed_p 1
        db_abort_transaction
    }

    if $failed_p {
        error "DGSOM App - Failed to delete: $errmsg"
    }
    return $success_p
}

ad_proc -private dap::group::tile::purge {
    -group_tile_id:required
} {
    Deletes a group/tile relation
} {
    set success_p   0
    set failed_p    0
    db_transaction {
        db_dml delete ""
        set success_p 1
    } on_error {
        set failed_p 1
        db_abort_transaction
    }

    if $failed_p {
        error "DGSOM App - Failed to purge: $errmsg"
    }
    return $success_p
}

ad_proc -public dap::group::tile::set_tiles {
   -group_id:required
   -creation_user:required
   -selected_tiles:required
   {-old_tiles ""}
} {
    Sets the tiles for a group
    If this procedure succeeds, returns the group_id.  Otherwise, returns 0.
} {

    set success_p 0

    if {$old_tiles eq ""} {
        set old_tiles [db_list_of_lists get_assigned_tiles ""]
    }
    if {[llength $selected_tiles] > 0 || [llength $old_tiles] > 0} {
        dap::group::tile::compare_lists $old_tiles $selected_tiles added_list removed_list
        if {[llength $added_list] > 0 } {
            foreach tile_id $added_list {
                dap::group::tile::new \
                    -group_id $group_id \
                    -tile_id $tile_id \
                    -creation_user $creation_user
            }
        }
        if {[llength $removed_list] > 0 } {
            foreach tile_id $removed_list {
                db_dml delete_group_and_tile {**SQL**}
            }
        }
        set success_p 1
    }
    return $success_p
}

ad_proc -public dap::group::tile::set_groups {
   -tile_id:required
   -creation_user:required
   -selected_groups:required
   {-old_groups ""}
} {
    Sets the groups for a tile
    If this procedure succeeds, returns the group_id.  Otherwise, returns 0.
} {

    set success_p 0

    if {$old_groups eq ""} {
        set old_groups [db_list_of_lists get_assigned_groups ""]
    }
    if {[llength $selected_groups] > 0 || [llength $old_groups] > 0} {
        dap::group::tile::compare_lists $old_groups $selected_groups added_list removed_list
        if {[llength $added_list] > 0 } {
            foreach group_id $added_list {
                dap::group::tile::new \
                    -group_id $group_id \
                    -tile_id $tile_id \
                    -creation_user $creation_user
            }
        }
        if {[llength $removed_list] > 0 } {
            foreach group_id $removed_list {
                db_dml delete_group_and_tile {**SQL**}
            }
        }
        set success_p 1
    }
    return $success_p
}

ad_proc -private dap::group::tile::compare_lists {
    ori_list new_list added_element_list removed_element_list
} {
    Compare two list to return added and removed element list
    ori_list is already existed list
    new_list is new list
} {
    upvar $added_element_list added_list
    upvar $removed_element_list removed_list
    array unset arr
    set added_list      [list]
    set removed_list    [list]

    foreach n $ori_list {
        set arr($n) 0
    }

    foreach n $new_list {
        if {[info exists arr($n)]} {
            set arr($n) 1
        } else {
            lappend added_list $n
        }
    }

    foreach n [array names arr] {
        if {$arr($n) == 0} {
            lappend removed_list $n
        }
    }
}
