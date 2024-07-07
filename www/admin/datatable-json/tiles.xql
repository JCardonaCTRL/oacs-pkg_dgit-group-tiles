<?xml version="1.0"?>
<queryset>

    <fullquery name="selected_rows_to_display">
        <querytext>
            select x1.*
            from (
                select  ROW_NUMBER() OVER () as rn, x2.*
                from (
                    select
                        p.package_id    as tile_id,
                        p.instance_name as package_name,
                        v.version_id,
                        v.package_key,
                        d.dependency_id,
                        d.dependency_type,
                        d.service_version,
                        (select count(*)
                         from dgit_group_tiles_active_view gtav
                         where gtav.tile_id = p.package_id
                        ) as num_of_groups
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
                $sql_search_filter
        </querytext>
    </fullquery>

    <fullquery name="total_rows">
        <querytext>
            select count(*)
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
                $sql_search_filter
            </querytext>
      </fullquery>

</queryset>
