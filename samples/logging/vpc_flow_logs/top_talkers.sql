/* Copyright 2023 Google LLC
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 https://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */
 
SELECT
 JSON_VALUE(json_payload.src_instance.vm_name) vm_name,
 SUM(CAST(JSON_VALUE(json_payload.bytes_sent) as INT64)) as total_bytes_sent,
 SUM(CAST(JSON_VALUE(json_payload.packets_sent) as INT64)) as total_packets_sent,
FROM
 `[MY_PROJECT].global._Default._Default`
WHERE
 log_id = "compute.googleapis.com/vpc_flows"
 AND SEARCH(json_payload.reporter, "SRC")
 GROUP BY 1
 ORDER BY 2 DESC
 LIMIT 100
