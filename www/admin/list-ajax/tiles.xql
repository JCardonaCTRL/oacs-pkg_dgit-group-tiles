<?xml version="1.0"?>
<queryset>

    <fullquery name="select_tiles">
        <querytext>
            select  gtav.group_tile_id,
                    gtav.tile_id,
                    gtav.package_key,
                    gtav.instance_name,
                    pvi.pretty_name,
                    pvi.version_name
            from dgit_group_tiles_active_view   gtav
                join apm_package_version_info   pvi on pvi. package_key = gtav.package_key and pvi.enabled_p = 't'
            where gtav.group_id = :group_id
            order by gtav.instance_name asc
        </querytext>
    </fullquery>

</queryset>
