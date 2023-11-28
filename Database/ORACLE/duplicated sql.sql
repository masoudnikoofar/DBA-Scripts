select w.PLAN_HASH_VALUE,count(*) From v$sql w group by w.PLAN_HASH_VALUE order by 2 desc;
