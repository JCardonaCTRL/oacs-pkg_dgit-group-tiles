<?xml version="1.0"?>
<queryset>

  <fullquery name="dap::group::tile::get.select_active">
    <querytext>
        select *
        from dgit_group_tiles_active_view
        where group_tile_id = :group_tile_id
    </querytext>
  </fullquery>

  <fullquery name="dap::group::tile::get.select_all">
    <querytext>
        select *
        from dgit_group_tiles_view
        where group_tile_id = :group_tile_id
    </querytext>
  </fullquery>

  <fullquery name="dap::group::tile::new.insert">
    <querytext>
        insert into dgit_group_tiles
            (group_tile_id,  group_id,  tile_id,  creation_user,  creation_date)
        values
            (:group_tile_id, :group_id, :tile_id, :creation_user, now())
    </querytext>
  </fullquery>

  <fullquery name="dap::group::tile::delete.delete">
    <querytext>
        update dgit_group_tiles
        set deleted_p = true,
            modifying_user = :modifying_user,
            last_modified = now()
        where group_tile_id = :group_tile_id
    </querytext>
  </fullquery>

  <fullquery name="dap::group::tile::purge.delete">
    <querytext>
        delete from dgit_group_tiles
        where group_tile_id = :group_tile_id
    </querytext>
  </fullquery>

  <fullquery name="dap::group::tile::set_tiles.get_assigned_tiles">
    <querytext>
        select  gtav.tile_id
        from dgit_group_tiles_active_view   gtav
        where gtav.group_id = :group_id
    </querytext>
  </fullquery>

  <fullquery name="dap::group::tile::set_tiles.delete_group_and_tile">
    <querytext>
        update dgit_group_tiles
        set deleted_p = true,
            modifying_user = :creation_user,
            last_modified = now()
        where group_id = :group_id
          and tile_id = :tile_id
    </querytext>
  </fullquery>

  <fullquery name="dap::group::tile::set_groups.get_assigned_groups">
    <querytext>
        select  gtav.group_id
        from dgit_group_tiles_active_view   gtav
        where gtav.tile_id = :tile_id
    </querytext>
  </fullquery>

  <fullquery name="dap::group::tile::set_groups.delete_group_and_tile">
    <querytext>
        update dgit_group_tiles
        set deleted_p = true,
            modifying_user = :creation_user,
            last_modified = now()
        where group_id = :group_id
          and tile_id = :tile_id
    </querytext>
  </fullquery>

</queryset>
