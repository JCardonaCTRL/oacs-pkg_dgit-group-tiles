<?xml version="1.0"?>
<queryset>

    <fullquery name="selected_rows_to_display">
        <querytext>
            select x1.*
            from (
                select  ROW_NUMBER() OVER () as rn, x2.*
                from (
                    select
                        g.group_id,
                        g.group_name,
                        (select count(rels.object_id_two)
                         from acs_rels  rels
                         where g.group_id = rels.object_id_one
                        ) as num_of_users,
                        (select count(*)
                         from dgit_group_tiles_active_view gtav
                         where gtav.group_id = g.group_id
                        ) as num_of_tiles
                    from groups     g
                        join acs_objects    obj     on g.group_id = obj.object_id
                    where obj.object_type = :group_type_name
                    $sql_search_filter
                    $sql_order
                ) x2
            ) x1
            $sql_filter_row
        </querytext>
    </fullquery>

    <fullquery name="total_selected_rows">
        <querytext>
            select count(*)
            from groups             g
                join acs_objects    obj     on g.group_id = obj.object_id
            where obj.object_type = :group_type_name
            $sql_search_filter
        </querytext>
    </fullquery>

    <fullquery name="total_rows">
        <querytext>
            select count(*)
            from groups             g
                join acs_objects    obj     on g.group_id = obj.object_id
            where obj.object_type = :group_type_name
        </querytext>
    </fullquery>

</queryset>
