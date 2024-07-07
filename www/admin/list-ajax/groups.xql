<?xml version="1.0"?>
<queryset>

    <fullquery name="select_groups">
        <querytext>
            select  gtav.group_tile_id,
                    gtav.group_id,
                    gtav.group_name,
                    (select count(rels.object_id_two)
                     from acs_rels  rels
                     where gtav.group_id = rels.object_id_one
                    ) as num_of_users
            from dgit_group_tiles_active_view   gtav
            where gtav.tile_id = :tile_id
            order by gtav.group_name asc
        </querytext>
    </fullquery>

</queryset>
