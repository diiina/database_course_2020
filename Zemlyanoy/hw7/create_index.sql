CREATE INDEX idx_ses ON sessions (begin_dttm ASC, user_id) USING BTREE
;