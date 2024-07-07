create view dgit_group_tiles_view as
select
    -- Main columns
    dgt.group_tile_id,
    dgt.group_id,
    dgt.tile_id,
    dgt.creation_user,
    dgt.modifying_user,
    dgt.creation_date,
    dgt.last_modified,
    dgt.deleted_p,
    -- Group columns
    g.group_name,
    g.join_policy,
    g.description,
    -- Tile columns
    p.package_key,
    p.instance_name,
    -- Creation user
    cupe.first_names || ' ' || cupe.last_name as entered_user,
    cupe.first_names    as entered_first_names,
    cupe.last_name      as entered_last_name,
    cupa.email          as entered_email,
    -- Modifying user
    mupe.first_names || ' ' || mupe.last_name as last_modifying_user,
    mupe.first_names    as last_modifying_first_names,
    mupe.last_name      as last_modifying_last_name,
    mupa.email          as last_modifying_email,
    -- Pretty dates
    to_char(dgt.creation_date,'MM/DD/YYYY') as creation_date_pretty,
    to_char(dgt.last_modified,'MM/DD/YYYY') as last_modified_pretty,
    to_char(dgt.creation_date,'MM/DD/YYYY HH24:MI:SS') as creation_date_pretty_timestamp_24,
    to_char(dgt.last_modified,'MM/DD/YYYY HH24:MI:SS') as last_modified_pretty_timestamp_24,
    to_char(dgt.creation_date,'MM/DD/YYYY HH12:MI:SS am') as creation_date_pretty_timestamp_ampm,
    to_char(dgt.last_modified,'MM/DD/YYYY HH12:MI:SS am') as last_modified_pretty_timestamp_ampm
from dgit_group_tiles       dgt
    join groups             g       on g.group_id       = dgt.group_id
    join apm_packages       p       on p.package_id     = dgt.tile_id
    join parties            cupa    on cupa.party_id    = dgt.creation_user
    join persons            cupe    on cupe.person_id   = dgt.creation_user
    left join parties       mupa    on mupa.party_id    = dgt.modifying_user
    left join persons       mupe    on mupe.person_id   = dgt.modifying_user;

create view dgit_group_tiles_active_view as
select *
from dgit_group_tiles_view  dgtv
where dgtv.deleted_p is false;
