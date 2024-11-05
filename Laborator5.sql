-- Exercitii (Cap 6 si Cap 7):
-- 1. Aratati din dictionar numele bazei de date curenta, 
-- care sunt fisierele de control asignate si data cand au fost create.
SELECT  
    db.name AS database_name, 
    cf.name AS control_file, 
    db.created AS creation_date 
FROM 
    v$database db
CROSS JOIN 
    v$controlfile cf;

-- CROSS JOIN pentru a combina fiecare fișier de control cu detaliile bazei de date

-- 2. Faceti o lista cu numele fisierelor de control asignate 
-- la baza de date curenta si dimensiunea lor exprimata in numar de blocuri.
SELECT *
FROM v$controlfile;

SELECT 
    name AS controlfile_name, 
    FILE_SIZE_BLKS AS blocks
FROM 
    v$controlfile;


-- 3. Faceti o lista cu grupurile fisierelor de log, fisierele membru 
-- din cadrul fiecarui grup si dimensiunea lor in MB.
SELECT *
FROM v$log a;

SELECT 
    a.group# AS log_group, 
    b.member AS log_file_member,
    a.bytes / (1024 * 1024) AS size_mb
FROM 
    v$log a
JOIN 
    v$logfile b ON a.group# = b.group#;

-- 4. Aratati din dictionar numele instantei curente si grupurile 
-- fisierelor de log aflate in starea ‘OPEN’
SELECT 
    i.instance_name AS instance_name, 
    l.group# AS log_group
FROM 
    v$instance i
JOIN 
    v$thread t ON i.instance_number = t.thread#
JOIN 
    v$log l ON t.current_group# = l.group#
WHERE 
    t.status = 'OPEN';


-- 5. Aratati din dictionar data cand a fost creata baza de date si data 
-- cand au fost resetate fisierele de log (data in format cu ora/min/sec)
SELECT 
    created AS db_creation_date, 
    TO_CHAR(resetlogs_time, 'DD-MON-YYYY HH24:MI:SS') AS log_reset_time
FROM 
    v$database;
