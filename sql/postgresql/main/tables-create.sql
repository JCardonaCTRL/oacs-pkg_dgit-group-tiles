create table dgit_group_tiles (
    group_tile_id   integer
        constraint  dgit_gt_pk primary key,
    group_id        integer not null
        constraint dgit_gt_group_fk references groups(group_id),
    tile_id         integer not null
        constraint dgit_gt_tile_fk references apm_packages(package_id),
    creation_user   integer not null
        constraint dgit_gt_creation_user_fk references users(user_id),
    modifying_user  integer
        constraint dgit_gt_modifying_user_fk references users(user_id),
    creation_date   timestamp with time zone not null default CURRENT_TIMESTAMP,
    last_modified   timestamp with time zone not null default CURRENT_TIMESTAMP,
    deleted_p       boolean default false
);

create sequence dgit_group_tile_seq;

create index dgit_gt_ix on dgit_group_tiles(group_tile_id);
create index dgit_gt_group_ix on dgit_group_tiles(group_id);
create index dgit_gt_tile_ix on dgit_group_tiles(tile_id);
create index dgit_gt_creation_user_ix on dgit_group_tiles(creation_user);
create index dgit_gt_modifying_user_ix on dgit_group_tiles(modifying_user);
