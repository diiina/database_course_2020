| id | select\_type | table | partitions | type | possible\_keys | key | key\_len | ref | rows | filtered | Extra |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| 1 | PRIMARY | AP | NULL | index | NULL | appointment\_time | 5 | NULL | 295 | 100 | Using index; Using temporary; Using filesort |
| 1 | PRIMARY | &lt;derived2&gt; | NULL | ALL | NULL | NULL | NULL | NULL | 3 | 33.33 | Using where |
| 2 | DERIVED | appointments | NULL | index | NULL | appointment\_time | 5 | NULL | 295 | 100 | Using index |
| 3 | UNION | cte | NULL | ALL | NULL | NULL | NULL | NULL | 2 | 100 | Recursive; Using where |
| 5 | SUBQUERY | appointments | NULL | index | NULL | appointment\_time | 5 | NULL | 295 | 100 | Using index |
