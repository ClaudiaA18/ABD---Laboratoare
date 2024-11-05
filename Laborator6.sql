create tablespace abd_data1 datafile 'c:/Oracle19c/temp/abd_data1.dbf' size 5M
extent management local uniform size 128k;

create tablespace abd_data2
datafile 'c:/Oracle19c/temp/abd_data2.dbf' size 5M;

alter database datafile 'c:/Oracle19c/temp/abd_data1.dbf'
autoextend on next 2M;

alter database datafile 'c:/Oracle19c/temp/abd_data1.dbf' resize 3M;

alter tablespace abd_data1
add datafile 'c:/Oracle19c/temp/abd_data11.dbf' size 3M;

desc dba_tablespaces

select tablespace_name, contents, block_size,status from dba_tablespaces;

desc v$tablespace

desc dba_data_files;

select tablespace_name,file_name,status from dba_data_files;

select tablespace_name, sum(bytes)/1024/1024 tab_size
from dba_data_files
group by tablespace_name;

desc dba_free_space;

select tablespace_name, round(sum(bytes)/1024/1024 ,2) tab_free_space
from dba_free_space
group by tablespace_name;

select b.tablespace_name, b.tab_size, a.tab_free_space
from 
    (select tablespace_name, round(sum(bytes)/1024/1024 ,2) tab_free_space
    from dba_free_space group by tablespace_name) a,
        (select tablespace_name, sum(bytes)/1024/1024 tab_size 
        from dba_data_files
        group by tablespace_name) b
where a.tablespace_name = b.tablespace_name;

desc v$datafile

select file#, name, creation_time,status, enabled from v$datafile;

desc dba_temp_files

select file_name,tablespace_name, status from dba_temp_files;

desc v$tempfile

select file#, name, creation_time, status from v$tempfile;

desc database_properties;

select * from database_properties;

desc dba_users

select username, default_tablespace, temporary_tablespace from dba_users;

desc dba_ts_quotas

select tablespace_name, username, max_bytes, bytes from dba_ts_quotas;

desc user_users

select user_id, username, created, lock_date from user_users;

create temporary tablespace abd_temp1 tempfile 'c:/Oracle19c/temp/abd_temp1.dbf' size 5M
extent management local uniform size 2M;

alter database default temporary tablespace temp;

select * 
from database_properties 
where property_name = 'DEFAULT_TEMP_TABLESPACE' ;

alter tablespace abd_data2 read only;

select tablespace_name,block_size,status 
from dba_tablespaces 
where tablespace_name ='ABD_DATA2';

alter tablespace abd_data2 read write;

select tablespace_name,block_size,status 
from dba_tablespaces 
where tablespace_name ='ABD_DATA2';

select tablespace_name, status 
from dba_tablespaces 
where tablespace_name = 'BD_DATA';

alter tablespace abd_data2 offline;

select tablespace_name, status 
from dba_tablespaces 
where tablespace_name='ABD_DATA2';

alter tablespace abd_data2 online;

alter tablespace abd_data1 offline;

alter tablespace abd_data1 rename datafile 
'c:/Oracle19c/temp/abd_data11.dbf' to 'c:/Oracle19c/temp/abd_data11_copy.dbf'; 

select tablespace_name, status, online_status, file_name from dba_data_files;

alter database rename file 'c:/Oracle19c/temp/abd_data11_copy.dbf' to 'c:/Oracle19c/temp/abd_data11.dbf';

create undo tablespace ubd_undo1 datafile 'c:/Oracle19c/temp/ubd_undo1.dbf' size 10M;

alter tablespace abd_data1 drop datafile 'c:/Oracle19c/temp/abd_data11.dbf';

lespace abd_data1 online;

alter tablespace abd_data1 drop datafile 'c:/Oracle19c/temp/abd_data11.dbf';

alter tablespace abd_data1 drop datafile 'c:/Oracle19c/temp/abd_data11_copy.dbf';

alter tablespace abd_data2 drop datafile 'c:/Oracle19c/temp/abd_data2.db';

alter tablespace abd_temp1 drop tempfile 'c:/Oracle19c/temp/abd_temp1.dbf';

alter database tempfile 'c:/Oracle19c/temp/abd_temp1.dbf' drop including datafiles;

drop tablespace abd_data1 including contents and datafiles;

drop tablespace abd_temp1 including contents; 

-- Verificare:
select tablespace_name from dba_tablespaces;
select tablespace_name,file_name,status from dba_data_files;
select tablespace_name,file_name,status from dba_temp_files;