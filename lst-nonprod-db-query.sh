sqoop import --connect jdbc:oracle:thin:@10.232.12.20:1521/lst --username quercus_proxy --password *****
 
 
--query "select p.object_id, lpad(p.id_number,8,0) id_number, p.first_name first_name, p.surname last_name,agt.description class_group,sa.note note,ti.tutorial_instance class,rtrim(tp.first_name)
|| ' ' || rtrim(tp.surname) tutor,ti.tutorial_date class_date,substr(lpad(ti.tutorial_time,4,'0'), 1, 2) || ':'
|| substr(lpad(ti.tutorial_time,4,'0'), 3, 2) class_start, substr(lpad(ti.tutorial_end_time,4,'0'), 1, 2) || ':'
|| substr(lpad(ti.tutorial_end_time,4,'0'), 3, 2) class_end, m.module course_code, m.description course_title, mi.academic_session session_code, nvl(mi.description, m.module) || ' ('
|| m.module || ' '
|| mi.module_instance_number || ')'
section_code,mi.start_date section_start_date, mi.end_date section_end_date,cpd.credits credits_ceu, abt.description, srs.subject_registration_status,v.description venue,l.description location
 
 
from   person p, student_course_detail_table scd,     student_curriculum sc, attendance_group_type agt, student_absence sa, tutorial_instance ti,module m, module_instance_table mi,course_program_detail cpd, person tp,absence_type abt,subject_registration_status srs,venue v,        location l
 
 
where  p.object_id  = scd.person and    abt.object_id  = sa.absence_type and    scd.object_id  = sc.student_course_detail and    sc.object_id  = sa.student_curriculum and cpd.object_id = sc.course_program_detail and srs.object_id = sc.subject_registration_status and  ti.object_id  = sa.tutorial_instance and  agt.object_id  = ti.attendance_group_type and    tp.object_id = ti.person and    mi.object_id = ti.module_instance and    m.object_id  = mi.module and ti.venue = v.object_id (+) and    ti.location  = l.object_id (+)  AND \$CONDITIONS"
 
 
--split-by p.object_id --null-string 'NA' --null-non-string '\\N' 
 
 
--target-dir 's3://ellucian-qe-eu/sqoop-output/nonprod/lst/'