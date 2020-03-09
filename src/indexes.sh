set search_path to bgt,public;
set work_mem to '2GB';
set maintenance_work_mem to '1GB';


drop index if exists index_gebouw_vlak0_gist;
CREATE INDEX index_gebouw_vlak0_geohash_idx ON gebouw_vlak0 (ST_GeoHash(ST_Transform(ST_Envelope(geometrie),4326),10) COLLATE "C");
CLUSTER gebouw_vlak0 USING index_gebouw_vlak0_geohash_idx;
DROP INDEX index_gebouw_vlak0_geohash_idx;
CREATE INDEX index_gebouw_vlak0_gist ON gebouw_vlak0 USING gist(geometrie);

drop index if exists index_gebouw_vlak1_gist;
CREATE INDEX index_gebouw_vlak1_geohash_idx ON gebouw_vlak1 (ST_GeoHash(ST_Transform(ST_Envelope(geometrie),4326),10) COLLATE "C");
CLUSTER gebouw_vlak1 USING index_gebouw_vlak1_geohash_idx;
DROP INDEX index_gebouw_vlak1_geohash_idx;
CREATE INDEX index_gebouw_vlak1_gist ON gebouw_vlak1 USING gist(geometrie);

drop index if exists index_gebouw_vlak2_gist;
CREATE INDEX index_gebouw_vlak2_geohash_idx ON gebouw_vlak2 (ST_GeoHash(ST_Transform(ST_Envelope(geometrie),4326),10) COLLATE "C");
CLUSTER gebouw_vlak2 USING index_gebouw_vlak2_geohash_idx;
DROP INDEX index_gebouw_vlak2_geohash_idx;
CREATE INDEX index_gebouw_vlak2_gist ON gebouw_vlak2 USING gist(geometrie);

drop index if exists index_gebouw_vlak3_gist;
CREATE INDEX index_gebouw_vlak3_geohash_idx ON gebouw_vlak3 (ST_GeoHash(ST_Transform(ST_Envelope(geometrie),4326),10) COLLATE "C");
CLUSTER gebouw_vlak3 USING index_gebouw_vlak3_geohash_idx;
DROP INDEX index_gebouw_vlak3_geohash_idx;
CREATE INDEX index_gebouw_vlak3_gist ON gebouw_vlak3 USING gist(geometrie);

drop index if exists index_gebouw_vlak4_gist;
CREATE INDEX index_gebouw_vlak4_geohash_idx ON gebouw_vlak4 (ST_GeoHash(ST_Transform(ST_Envelope(geometrie),4326),10) COLLATE "C");
CLUSTER gebouw_vlak4 USING index_gebouw_vlak4_geohash_idx;
DROP INDEX index_gebouw_vlak4_geohash_idx;
CREATE INDEX index_gebouw_vlak4_gist ON gebouw_vlak4 USING gist(geometrie);

drop index if exists index_gebouw_vlak5_gist;
CREATE INDEX index_gebouw_vlak5_geohash_idx ON gebouw_vlak5 (ST_GeoHash(ST_Transform(ST_Envelope(geometrie),4326),10) COLLATE "C");
CLUSTER gebouw_vlak5 USING index_gebouw_vlak5_geohash_idx;
DROP INDEX index_gebouw_vlak5_geohash_idx;
CREATE INDEX index_gebouw_vlak5_gist ON gebouw_vlak5 USING gist(geometrie);


drop index if exists index_gebouw_vlak_1_gist;
CREATE INDEX index_gebouw_vlak_1_geohash_idx ON gebouw_vlak_1 (ST_GeoHash(ST_Transform(ST_Envelope(geometrie),4326),10) COLLATE "C");
CLUSTER gebouw_vlak_1 USING index_gebouw_vlak_1_geohash_idx;
DROP INDEX index_gebouw_vlak_1_geohash_idx;
CREATE INDEX index_gebouw_vlak_1_gist ON gebouw_vlak_1 USING gist(geometrie);

drop index if exists index_gebouw_vlak_2_gist;
CREATE INDEX index_gebouw_vlak_2_geohash_idx ON gebouw_vlak_2 (ST_GeoHash(ST_Transform(ST_Envelope(geometrie),4326),10) COLLATE "C");
CLUSTER gebouw_vlak_2 USING index_gebouw_vlak_2_geohash_idx;
DROP INDEX index_gebouw_vlak_2_geohash_idx;
CREATE INDEX index_gebouw_vlak_2_gist ON gebouw_vlak_2 USING gist(geometrie);

drop index if exists index_inrichtingselement_lijn0_gist;
CREATE INDEX index_inrichtingselement_lijn0_geohash_idx ON inrichtingselement_lijn0 (ST_GeoHash(ST_Transform(ST_Envelope(geometrie),4326),10) COLLATE "C");
CLUSTER inrichtingselement_lijn0 USING index_inrichtingselement_lijn0_geohash_idx;
DROP INDEX index_inrichtingselement_lijn0_geohash_idx;
CREATE INDEX index_inrichtingselement_lijn0_gist ON inrichtingselement_lijn0 USING gist(geometrie);

drop index if exists index_inrichtingselement_lijn1_gist;
CREATE INDEX index_inrichtingselement_lijn1_geohash_idx ON inrichtingselement_lijn1 (ST_GeoHash(ST_Transform(ST_Envelope(geometrie),4326),10) COLLATE "C");
CLUSTER inrichtingselement_lijn1 USING index_inrichtingselement_lijn1_geohash_idx;
DROP INDEX index_inrichtingselement_lijn1_geohash_idx;
CREATE INDEX index_inrichtingselement_lijn1_gist ON inrichtingselement_lijn1 USING gist(geometrie);

drop index if exists index_inrichtingselement_lijn2_gist;
CREATE INDEX index_inrichtingselement_lijn2_geohash_idx ON inrichtingselement_lijn2 (ST_GeoHash(ST_Transform(ST_Envelope(geometrie),4326),10) COLLATE "C");
CLUSTER inrichtingselement_lijn2 USING index_inrichtingselement_lijn2_geohash_idx;
DROP INDEX index_inrichtingselement_lijn2_geohash_idx;
CREATE INDEX index_inrichtingselement_lijn2_gist ON inrichtingselement_lijn2 USING gist(geometrie);

drop index if exists index_inrichtingselement_lijn3_gist;
CREATE INDEX index_inrichtingselement_lijn3_geohash_idx ON inrichtingselement_lijn3 (ST_GeoHash(ST_Transform(ST_Envelope(geometrie),4326),10) COLLATE "C");
CLUSTER inrichtingselement_lijn3 USING index_inrichtingselement_lijn3_geohash_idx;
DROP INDEX index_inrichtingselement_lijn3_geohash_idx;
CREATE INDEX index_inrichtingselement_lijn3_gist ON inrichtingselement_lijn3 USING gist(geometrie);


drop index if exists index_inrichtingselement_lijn_1_gist;
CREATE INDEX index_inrichtingselement_lijn_1_geohash_idx ON inrichtingselement_lijn_1 (ST_GeoHash(ST_Transform(ST_Envelope(geometrie),4326),10) COLLATE "C");
CLUSTER inrichtingselement_lijn_1 USING index_inrichtingselement_lijn_1_geohash_idx;
DROP INDEX index_inrichtingselement_lijn_1_geohash_idx;
CREATE INDEX index_inrichtingselement_lijn_1_gist ON inrichtingselement_lijn_1 USING gist(geometrie);

drop index if exists index_inrichtingselement_lijn_2_gist;
CREATE INDEX index_inrichtingselement_lijn_2_geohash_idx ON inrichtingselement_lijn_2 (ST_GeoHash(ST_Transform(ST_Envelope(geometrie),4326),10) COLLATE "C");
CLUSTER inrichtingselement_lijn_2 USING index_inrichtingselement_lijn_2_geohash_idx;
DROP INDEX index_inrichtingselement_lijn_2_geohash_idx;
CREATE INDEX index_inrichtingselement_lijn_2_gist ON inrichtingselement_lijn_2 USING gist(geometrie);

drop index if exists index_inrichtingselement_punt0_gist;
CREATE INDEX index_inrichtingselement_punt0_geohash_idx ON inrichtingselement_punt0 (ST_GeoHash(ST_Transform(geometrie,4326),10) COLLATE "C");
CLUSTER inrichtingselement_punt0 USING index_inrichtingselement_punt0_geohash_idx;
DROP INDEX index_inrichtingselement_punt0_geohash_idx;
CREATE INDEX index_inrichtingselement_punt0_gist ON inrichtingselement_punt0 USING gist(geometrie);

drop index if exists index_inrichtingselement_punt1_gist;
CREATE INDEX index_inrichtingselement_punt1_geohash_idx ON inrichtingselement_punt1 (ST_GeoHash(ST_Transform(geometrie,4326),10) COLLATE "C");
CLUSTER inrichtingselement_punt1 USING index_inrichtingselement_punt1_geohash_idx;
DROP INDEX index_inrichtingselement_punt1_geohash_idx;
CREATE INDEX index_inrichtingselement_punt1_gist ON inrichtingselement_punt1 USING gist(geometrie);

drop index if exists index_inrichtingselement_punt2_gist;
CREATE INDEX index_inrichtingselement_punt2_geohash_idx ON inrichtingselement_punt2 (ST_GeoHash(ST_Transform(geometrie,4326),10) COLLATE "C");
CLUSTER inrichtingselement_punt2 USING index_inrichtingselement_punt2_geohash_idx;
DROP INDEX index_inrichtingselement_punt2_geohash_idx;
CREATE INDEX index_inrichtingselement_punt2_gist ON inrichtingselement_punt2 USING gist(geometrie);

drop index if exists index_inrichtingselement_punt_1_gist;
CREATE INDEX index_inrichtingselement_punt_1_geohash_idx ON inrichtingselement_punt_1 (ST_GeoHash(ST_Transform(geometrie,4326),10) COLLATE "C");
CLUSTER inrichtingselement_punt_1 USING index_inrichtingselement_punt_1_geohash_idx;
DROP INDEX index_inrichtingselement_punt_1_geohash_idx;
CREATE INDEX index_inrichtingselement_punt_1_gist ON inrichtingselement_punt_1 USING gist(geometrie);

drop index if exists index_inrichtingselement_vlak0_gist;
CREATE INDEX index_inrichtingselement_vlak0_geohash_idx ON inrichtingselement_vlak0 (ST_GeoHash(ST_Transform(ST_Envelope(geometrie),4326),10) COLLATE "C");
CLUSTER inrichtingselement_vlak0 USING index_inrichtingselement_vlak0_geohash_idx;
DROP INDEX index_inrichtingselement_vlak0_geohash_idx;
CREATE INDEX index_inrichtingselement_vlak0_gist ON inrichtingselement_vlak0 USING gist(geometrie);

drop index if exists index_inrichtingselement_vlak1_gist;
CREATE INDEX index_inrichtingselement_vlak1_geohash_idx ON inrichtingselement_vlak1 (ST_GeoHash(ST_Transform(ST_Envelope(geometrie),4326),10) COLLATE "C");
CLUSTER inrichtingselement_vlak1 USING index_inrichtingselement_vlak1_geohash_idx;
DROP INDEX index_inrichtingselement_vlak1_geohash_idx;
CREATE INDEX index_inrichtingselement_vlak1_gist ON inrichtingselement_vlak1 USING gist(geometrie);

drop index if exists index_inrichtingselement_vlak2_gist;
CREATE INDEX index_inrichtingselement_vlak2_geohash_idx ON inrichtingselement_vlak2 (ST_GeoHash(ST_Transform(ST_Envelope(geometrie),4326),10) COLLATE "C");
CLUSTER inrichtingselement_vlak2 USING index_inrichtingselement_vlak2_geohash_idx;
DROP INDEX index_inrichtingselement_vlak2_geohash_idx;
CREATE INDEX index_inrichtingselement_vlak2_gist ON inrichtingselement_vlak2 USING gist(geometrie);

drop index if exists index_inrichtingselement_vlak3_gist;
CREATE INDEX index_inrichtingselement_vlak3_geohash_idx ON inrichtingselement_vlak3 (ST_GeoHash(ST_Transform(ST_Envelope(geometrie),4326),10) COLLATE "C");
CLUSTER inrichtingselement_vlak3 USING index_inrichtingselement_vlak3_geohash_idx;
DROP INDEX index_inrichtingselement_vlak3_geohash_idx;
CREATE INDEX index_inrichtingselement_vlak3_gist ON inrichtingselement_vlak3 USING gist(geometrie);


drop index if exists index_inrichtingselement_vlak_1_gist;
CREATE INDEX index_inrichtingselement_vlak_1_geohash_idx ON inrichtingselement_vlak_1 (ST_GeoHash(ST_Transform(ST_Envelope(geometrie),4326),10) COLLATE "C");
CLUSTER inrichtingselement_vlak_1 USING index_inrichtingselement_vlak_1_geohash_idx;
DROP INDEX index_inrichtingselement_vlak_1_geohash_idx;
CREATE INDEX index_inrichtingselement_vlak_1_gist ON inrichtingselement_vlak_1 USING gist(geometrie);

drop index if exists index_inrichtingselement_vlak_2_gist;
CREATE INDEX index_inrichtingselement_vlak_2_geohash_idx ON inrichtingselement_vlak_2 (ST_GeoHash(ST_Transform(ST_Envelope(geometrie),4326),10) COLLATE "C");
CLUSTER inrichtingselement_vlak_2 USING index_inrichtingselement_vlak_2_geohash_idx;
DROP INDEX index_inrichtingselement_vlak_2_geohash_idx;
CREATE INDEX index_inrichtingselement_vlak_2_gist ON inrichtingselement_vlak_2 USING gist(geometrie);

drop index if exists index_inrichtingselement_vlak_3_gist;
CREATE INDEX index_inrichtingselement_vlak_3_geohash_idx ON inrichtingselement_vlak_3 (ST_GeoHash(ST_Transform(ST_Envelope(geometrie),4326),10) COLLATE "C");
CLUSTER inrichtingselement_vlak_3 USING index_inrichtingselement_vlak_3_geohash_idx;
DROP INDEX index_inrichtingselement_vlak_3_geohash_idx;
CREATE INDEX index_inrichtingselement_vlak_3_gist ON inrichtingselement_vlak_3 USING gist(geometrie);

drop index if exists index_terreindeel_vlak0_gist;
CREATE INDEX index_terreindeel_vlak0_geohash_idx ON terreindeel_vlak0 (ST_GeoHash(ST_Transform(ST_Envelope(geometrie),4326),10) COLLATE "C");
CLUSTER terreindeel_vlak0 USING index_terreindeel_vlak0_geohash_idx;
DROP INDEX index_terreindeel_vlak0_geohash_idx;
CREATE INDEX index_terreindeel_vlak0_gist ON terreindeel_vlak0 USING gist(geometrie);

drop index if exists index_terreindeel_vlak1_gist;
CREATE INDEX index_terreindeel_vlak1_geohash_idx ON terreindeel_vlak1 (ST_GeoHash(ST_Transform(ST_Envelope(geometrie),4326),10) COLLATE "C");
CLUSTER terreindeel_vlak1 USING index_terreindeel_vlak1_geohash_idx;
DROP INDEX index_terreindeel_vlak1_geohash_idx;
CREATE INDEX index_terreindeel_vlak1_gist ON terreindeel_vlak1 USING gist(geometrie);

drop index if exists index_terreindeel_vlak2_gist;
CREATE INDEX index_terreindeel_vlak2_geohash_idx ON terreindeel_vlak2 (ST_GeoHash(ST_Transform(ST_Envelope(geometrie),4326),10) COLLATE "C");
CLUSTER terreindeel_vlak2 USING index_terreindeel_vlak2_geohash_idx;
DROP INDEX index_terreindeel_vlak2_geohash_idx;
CREATE INDEX index_terreindeel_vlak2_gist ON terreindeel_vlak2 USING gist(geometrie);

drop index if exists index_terreindeel_vlak3_gist;
CREATE INDEX index_terreindeel_vlak3_geohash_idx ON terreindeel_vlak3 (ST_GeoHash(ST_Transform(ST_Envelope(geometrie),4326),10) COLLATE "C");
CLUSTER terreindeel_vlak3 USING index_terreindeel_vlak3_geohash_idx;
DROP INDEX index_terreindeel_vlak3_geohash_idx;
CREATE INDEX index_terreindeel_vlak3_gist ON terreindeel_vlak3 USING gist(geometrie);


drop index if exists index_terreindeel_vlak_1_gist;
CREATE INDEX index_terreindeel_vlak_1_geohash_idx ON terreindeel_vlak_1 (ST_GeoHash(ST_Transform(ST_Envelope(geometrie),4326),10) COLLATE "C");
CLUSTER terreindeel_vlak_1 USING index_terreindeel_vlak_1_geohash_idx;
DROP INDEX index_terreindeel_vlak_1_geohash_idx;
CREATE INDEX index_terreindeel_vlak_1_gist ON terreindeel_vlak_1 USING gist(geometrie);

drop index if exists index_terreindeel_vlak_2_gist;
CREATE INDEX index_terreindeel_vlak_2_geohash_idx ON terreindeel_vlak_2 (ST_GeoHash(ST_Transform(ST_Envelope(geometrie),4326),10) COLLATE "C");
CLUSTER terreindeel_vlak_2 USING index_terreindeel_vlak_2_geohash_idx;
DROP INDEX index_terreindeel_vlak_2_geohash_idx;
CREATE INDEX index_terreindeel_vlak_2_gist ON terreindeel_vlak_2 USING gist(geometrie);

drop index if exists index_terreindeel_vlak_3_gist;
CREATE INDEX index_terreindeel_vlak_3_geohash_idx ON terreindeel_vlak_3 (ST_GeoHash(ST_Transform(ST_Envelope(geometrie),4326),10) COLLATE "C");
CLUSTER terreindeel_vlak_3 USING index_terreindeel_vlak_3_geohash_idx;
DROP INDEX index_terreindeel_vlak_3_geohash_idx;
CREATE INDEX index_terreindeel_vlak_3_gist ON terreindeel_vlak_3 USING gist(geometrie);

drop index if exists index_waterdeel_lijn0_gist;
CREATE INDEX index_waterdeel_lijn0_geohash_idx ON waterdeel_lijn0 (ST_GeoHash(ST_Transform(ST_Envelope(geometrie),4326),10) COLLATE "C");
CLUSTER waterdeel_lijn0 USING index_waterdeel_lijn0_geohash_idx;
DROP INDEX index_waterdeel_lijn0_geohash_idx;
CREATE INDEX index_waterdeel_lijn0_gist ON waterdeel_lijn0 USING gist(geometrie);

drop index if exists index_waterdeel_lijn_1_gist;
CREATE INDEX index_waterdeel_lijn_1_geohash_idx ON waterdeel_lijn_1 (ST_GeoHash(ST_Transform(ST_Envelope(geometrie),4326),10) COLLATE "C");
CLUSTER waterdeel_lijn_1 USING index_waterdeel_lijn_1_geohash_idx;
DROP INDEX index_waterdeel_lijn_1_geohash_idx;
CREATE INDEX index_waterdeel_lijn_1_gist ON waterdeel_lijn_1 USING gist(geometrie);

drop index if exists index_waterdeel_lijn_2_gist;
CREATE INDEX index_waterdeel_lijn_2_geohash_idx ON waterdeel_lijn_2 (ST_GeoHash(ST_Transform(ST_Envelope(geometrie),4326),10) COLLATE "C");
CLUSTER waterdeel_lijn_2 USING index_waterdeel_lijn_2_geohash_idx;
DROP INDEX index_waterdeel_lijn_2_geohash_idx;
CREATE INDEX index_waterdeel_lijn_2_gist ON waterdeel_lijn_2 USING gist(geometrie);

drop index if exists index_wegdeel_vlak0_gist;
CREATE INDEX index_wegdeel_vlak0_geohash_idx ON wegdeel_vlak0 (ST_GeoHash(ST_Transform(ST_Envelope(geometrie),4326),10) COLLATE "C");
CLUSTER wegdeel_vlak0 USING index_wegdeel_vlak0_geohash_idx;
DROP INDEX index_wegdeel_vlak0_geohash_idx;
CREATE INDEX index_wegdeel_vlak0_gist ON wegdeel_vlak0 USING gist(geometrie);

drop index if exists index_wegdeel_vlak1_gist;
CREATE INDEX index_wegdeel_vlak1_geohash_idx ON wegdeel_vlak1 (ST_GeoHash(ST_Transform(ST_Envelope(geometrie),4326),10) COLLATE "C");
CLUSTER wegdeel_vlak1 USING index_wegdeel_vlak1_geohash_idx;
DROP INDEX index_wegdeel_vlak1_geohash_idx;
CREATE INDEX index_wegdeel_vlak1_gist ON wegdeel_vlak1 USING gist(geometrie);

drop index if exists index_wegdeel_vlak2_gist;
CREATE INDEX index_wegdeel_vlak2_geohash_idx ON wegdeel_vlak2 (ST_GeoHash(ST_Transform(ST_Envelope(geometrie),4326),10) COLLATE "C");
CLUSTER wegdeel_vlak2 USING index_wegdeel_vlak2_geohash_idx;
DROP INDEX index_wegdeel_vlak2_geohash_idx;
CREATE INDEX index_wegdeel_vlak2_gist ON wegdeel_vlak2 USING gist(geometrie);

drop index if exists index_wegdeel_vlak3_gist;
CREATE INDEX index_wegdeel_vlak3_geohash_idx ON wegdeel_vlak3 (ST_GeoHash(ST_Transform(ST_Envelope(geometrie),4326),10) COLLATE "C");
CLUSTER wegdeel_vlak3 USING index_wegdeel_vlak3_geohash_idx;
DROP INDEX index_wegdeel_vlak3_geohash_idx;
CREATE INDEX index_wegdeel_vlak3_gist ON wegdeel_vlak3 USING gist(geometrie);

drop index if exists index_wegdeel_vlak_1_gist;
CREATE INDEX index_wegdeel_vlak_1_geohash_idx ON wegdeel_vlak_1 (ST_GeoHash(ST_Transform(ST_Envelope(geometrie),4326),10) COLLATE "C");
CLUSTER wegdeel_vlak_1 USING index_wegdeel_vlak_1_geohash_idx;
DROP INDEX index_wegdeel_vlak_1_geohash_idx;
CREATE INDEX index_wegdeel_vlak_1_gist ON wegdeel_vlak_1 USING gist(geometrie);

drop index if exists index_wegdeel_vlak_2_gist;
CREATE INDEX index_wegdeel_vlak_2_geohash_idx ON wegdeel_vlak_2 (ST_GeoHash(ST_Transform(ST_Envelope(geometrie),4326),10) COLLATE "C");
CLUSTER wegdeel_vlak_2 USING index_wegdeel_vlak_2_geohash_idx;
DROP INDEX index_wegdeel_vlak_2_geohash_idx;
CREATE INDEX index_wegdeel_vlak_2_gist ON wegdeel_vlak_2 USING gist(geometrie);



create unique index if not exists index_gebouw_vlak0_idx on gebouw_vlak0(identificatie_lokaalid);
create unique index if not exists index_gebouw_vlak1_idx on gebouw_vlak1(identificatie_lokaalid);
create unique index if not exists index_gebouw_vlak2_idx on gebouw_vlak2(identificatie_lokaalid);
create unique index if not exists index_gebouw_vlak3_idx on gebouw_vlak3(identificatie_lokaalid);
create unique index if not exists index_gebouw_vlak4_idx on gebouw_vlak4(identificatie_lokaalid);
create unique index if not exists index_gebouw_vlak5_idx on gebouw_vlak5(identificatie_lokaalid);
create unique index if not exists index_gebouw_vlak_1_idx on gebouw_vlak_1(identificatie_lokaalid);
create unique index if not exists index_gebouw_vlak_2_idx on gebouw_vlak_2(identificatie_lokaalid);
create unique index if not exists index_inrichtingselement_lijn0_idx on inrichtingselement_lijn0(identificatie_lokaalid);
create unique index if not exists index_inrichtingselement_lijn1_idx on inrichtingselement_lijn1(identificatie_lokaalid);
create unique index if not exists index_inrichtingselement_lijn2_idx on inrichtingselement_lijn2(identificatie_lokaalid);
create unique index if not exists index_inrichtingselement_lijn3_idx on inrichtingselement_lijn3(identificatie_lokaalid);
create unique index if not exists index_inrichtingselement_lijn_1_idx on inrichtingselement_lijn_1(identificatie_lokaalid);
create unique index if not exists index_inrichtingselement_lijn_2_idx on inrichtingselement_lijn_2(identificatie_lokaalid);
create unique index if not exists index_inrichtingselement_punt0_idx on inrichtingselement_punt0(identificatie_lokaalid);
create unique index if not exists index_inrichtingselement_punt1_idx on inrichtingselement_punt1(identificatie_lokaalid);
create unique index if not exists index_inrichtingselement_punt2_idx on inrichtingselement_punt2(identificatie_lokaalid);
create unique index if not exists index_inrichtingselement_punt_1_idx on inrichtingselement_punt_1(identificatie_lokaalid);
create unique index if not exists index_inrichtingselement_vlak0_idx on inrichtingselement_vlak0(identificatie_lokaalid);
create unique index if not exists index_inrichtingselement_vlak1_idx on inrichtingselement_vlak1(identificatie_lokaalid);
create unique index if not exists index_inrichtingselement_vlak2_idx on inrichtingselement_vlak2(identificatie_lokaalid);
create unique index if not exists index_inrichtingselement_vlak3_idx on inrichtingselement_vlak3(identificatie_lokaalid);
create unique index if not exists index_inrichtingselement_vlak_1_idx on inrichtingselement_vlak_1(identificatie_lokaalid);
create unique index if not exists index_inrichtingselement_vlak_2_idx on inrichtingselement_vlak_2(identificatie_lokaalid);
create unique index if not exists index_inrichtingselement_vlak_3_idx on inrichtingselement_vlak_3(identificatie_lokaalid);
create unique index if not exists index_spoor_lijn0_idx on spoor_lijn0(identificatie_lokaalid);
create unique index if not exists index_spoor_lijn1_idx on spoor_lijn1(identificatie_lokaalid);
create unique index if not exists index_spoor_lijn2_idx on spoor_lijn2(identificatie_lokaalid);
create unique index if not exists index_spoor_lijn3_idx on spoor_lijn3(identificatie_lokaalid);
create unique index if not exists index_spoor_lijn_1_idx on spoor_lijn_1(identificatie_lokaalid);
create unique index if not exists index_spoor_lijn_2_idx on spoor_lijn_2(identificatie_lokaalid);
create unique index if not exists index_spoor_lijn_3_idx on spoor_lijn_3(identificatie_lokaalid);
create index if not exists index_terreindeel_vlak0_idx on terreindeel_vlak0(identificatie_lokaalid);
create unique index if not exists index_terreindeel_vlak1_idx on terreindeel_vlak1(identificatie_lokaalid);
create unique index if not exists index_terreindeel_vlak2_idx on terreindeel_vlak2(identificatie_lokaalid);
create unique index if not exists index_terreindeel_vlak3_idx on terreindeel_vlak3(identificatie_lokaalid);
create unique index if not exists index_terreindeel_vlak_1_idx on terreindeel_vlak_1(identificatie_lokaalid);
create unique index if not exists index_terreindeel_vlak_2_idx on terreindeel_vlak_2(identificatie_lokaalid);
create unique index if not exists index_terreindeel_vlak_3_idx on terreindeel_vlak_3(identificatie_lokaalid);
create unique index if not exists index_waterdeel_lijn0_idx on waterdeel_lijn0(identificatie_lokaalid);
create unique index if not exists index_waterdeel_lijn_1_idx on waterdeel_lijn_1(identificatie_lokaalid);
create unique index if not exists index_waterdeel_lijn_2_idx on waterdeel_lijn_2(identificatie_lokaalid);
create index if not exists index_waterdeel_vlak0_idx on waterdeel_vlak0(identificatie_lokaalid);
create unique index if not exists index_waterdeel_vlak1_idx on waterdeel_vlak1(identificatie_lokaalid);
create unique index if not exists index_waterdeel_vlak_1_idx on waterdeel_vlak_1(identificatie_lokaalid);
create unique index if not exists index_waterdeel_vlak_2_idx on waterdeel_vlak_2(identificatie_lokaalid);
create index if not exists index_wegdeel_vlak0_idx on wegdeel_vlak0(identificatie_lokaalid);
create unique index if not exists index_wegdeel_vlak1_idx on wegdeel_vlak1(identificatie_lokaalid);
create unique index if not exists index_wegdeel_vlak2_idx on wegdeel_vlak2(identificatie_lokaalid);
create unique index if not exists index_wegdeel_vlak3_idx on wegdeel_vlak3(identificatie_lokaalid);
create unique index if not exists index_wegdeel_vlak_1_idx on wegdeel_vlak_1(identificatie_lokaalid);
create unique index if not exists index_wegdeel_vlak_2_idx on wegdeel_vlak_2(identificatie_lokaalid);
