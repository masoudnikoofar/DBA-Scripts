SELECT segment_type, segment_name, COUNT(*)
FROM   dba_extents
WHERE  owner = 'RECLAIM_USER'
GROUP BY segment_type, segment_name
ORDER BY segment_type, segment_name;