<?xml version="1.0"?>
<queryset>

    <fullquery name="get_tiles">
        <querytext>
            select
                p.package_id    as tile_id,
                p.instance_name as package_name,
                v.version_id,
                v.package_key,
                d.dependency_id,
                d.dependency_type,
                d.service_version
            from apm_package_versions           v
                join apm_package_dependencies   d on (d.version_id = v.version_id)
                join apm_package_types          t on (t.package_key = v.package_key)
                join apm_packages               p on (p.package_key = t.package_key)
            where d.service_uri = 'dgit-base-tile'
                and d.dependency_type = 'extends'
                and (
                    installed_p = 't' or
                    enabled_p = 't' or
                    not exists (
                        select 1
                        from apm_package_versions v2
                        where v2.package_key = v.package_key
                            and (
                                v2.installed_p = 't' or
                                v2.enabled_p = 't'
                            )
                            and apm_package_version__sortable_version_name(v2.version_name) > apm_package_version__sortable_version_name(v.version_name)
                    )
                )
            order by p.instance_name
        </querytext>
    </fullquery>

    <fullquery name="get_assigned_tiles">
        <querytext>
            select  gtav.tile_id
            from dgit_group_tiles_active_view   gtav
            where gtav.group_id = :group_id
        </querytext>
    </fullquery>

</queryset>
