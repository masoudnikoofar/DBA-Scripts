alter system set log_checkpoint_timeout=0 scope=both;
alter system set log_checkpoint_interval=102400 scope=both;

ALTER PROFILE DEFAULT LIMIT PASSWORD_LIFE_TIME UNLIMITED;
