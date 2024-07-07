<?xml version="1.0"?>
<queryset>

    <fullquery name="get_groups">
        <querytext>
            select
                g.group_name,
                g.group_id
            from groups             g
                join acs_objects    obj on g.group_id = obj.object_id
            where obj.object_type = 'dgsom_app'
            order by g.group_name
        </querytext>
    </fullquery>

    <fullquery name="get_assigned_groups">
        <querytext>
            select  gtav.group_id
            from dgit_group_tiles_active_view   gtav
            where gtav.tile_id = :tile_id
        </querytext>
    </fullquery>

</queryset>
