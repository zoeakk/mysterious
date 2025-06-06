CREATE TABLE `mysterious_user` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
    `username` varchar(128) NOT NULL DEFAULT '' COMMENT '用户名',
    `password` varchar(128) NOT NULL DEFAULT '' COMMENT '密码',
    `real_name` varchar(128) NOT NULL DEFAULT '' COMMENT '真实姓名',
    `token` varchar(128) NOT NULL DEFAULT '' COMMENT 'token',
    `effect_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '生效时间',
    `expire_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '失效时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
COMMENT='用户信息表';

CREATE TABLE `mysterious_config` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
    `config_key` varchar(255) NOT NULL DEFAULT '' COMMENT '配置字段',
    `config_value` varchar(255) NOT NULL DEFAULT '' COMMENT '配置值',
    `description` varchar(255) NOT NULL DEFAULT '' COMMENT '配置描述',
    `creator_id` varchar(32) NOT NULL DEFAULT '' COMMENT '创建人ID',
    `creator` varchar(32) NOT NULL DEFAULT '' COMMENT '创建人',
    `modifier_id` varchar(32) NOT NULL DEFAULT '' COMMENT '修改人ID',
    `modifier` varchar(32) NOT NULL DEFAULT '' COMMENT '修改人',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '生成时间',
    `modify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
COMMENT='配置表';

CREATE TABLE `mysterious_node` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
    `name` varchar(255) NOT NULL DEFAULT '' COMMENT '节点名称',
    `description` varchar(255) NOT NULL DEFAULT '' COMMENT '节点描述',
    `type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0-slave，1-master',
    `host` varchar(128) NOT NULL DEFAULT '' COMMENT '节点IP地址',
    `username` varchar(128) NOT NULL DEFAULT '' COMMENT '节点登陆用户名',
    `password` varchar(128) NOT NULL DEFAULT '' COMMENT '节点登陆密码',
    `port` bigint(20) NOT NULL DEFAULT '0' COMMENT '节点登陆端口',
    `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0-禁用中，1-启用中',
    `creator_id` varchar(32) NOT NULL DEFAULT '' COMMENT '创建人ID',
    `creator` varchar(32) NOT NULL DEFAULT '' COMMENT '创建人',
    `modifier_id` varchar(32) NOT NULL DEFAULT '' COMMENT '修改人ID',
    `modifier` varchar(32) NOT NULL DEFAULT '' COMMENT '修改人',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '生成时间',
    `modify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
COMMENT='分布式节点表';

CREATE TABLE `mysterious_testcase` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
    `name` varchar(255) NOT NULL DEFAULT '' COMMENT '用例名称',
    `description` varchar(255) NOT NULL DEFAULT '' COMMENT '用例描述',
    `biz` varchar(128) NOT NULL DEFAULT '' COMMENT '业务线',
    `service` varchar(128) NOT NULL DEFAULT '' COMMENT '服务名称',
    `version` varchar(128) NOT NULL DEFAULT '' COMMENT '服务版本',
    `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0-未执行，1-执行中, 2-执行成功, 3-执行异常',
    `test_case_dir` varchar(255) NOT NULL DEFAULT '' COMMENT '用例目录',
    `creator_id` varchar(32) NOT NULL DEFAULT '' COMMENT '创建人ID',
    `creator` varchar(32) NOT NULL DEFAULT '' COMMENT '创建人',
    `modifier_id` varchar(32) NOT NULL DEFAULT '' COMMENT '修改人ID',
    `modifier` varchar(32) NOT NULL DEFAULT '' COMMENT '修改人',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '生成时间',
    `modify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
COMMENT='用例表';

CREATE TABLE `mysterious_jmx` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
    `src_name` varchar(255) NOT NULL DEFAULT '' COMMENT '上传前脚本名称',
    `dst_name` varchar(255) NOT NULL DEFAULT '' COMMENT '上传后脚本名称',
    `description` varchar(255) NOT NULL DEFAULT '' COMMENT '脚本描述',
    `jmx_dir` varchar(255) NOT NULL DEFAULT '' COMMENT '脚本目录',
    `test_case_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '用例ID',
    `jmeter_script_type` tinyint(2) NOT NULL DEFAULT '0' COMMENT '脚本生成方式',
    `jmeter_threads_type` tinyint(2) NOT NULL DEFAULT '0' COMMENT '线程组类型',
    `jmeter_sample_type` tinyint(2) NOT NULL DEFAULT '0' COMMENT 'Sample类型',
    `creator_id` varchar(32) NOT NULL DEFAULT '' COMMENT '创建人ID',
    `creator` varchar(32) NOT NULL DEFAULT '' COMMENT '创建人',
    `modifier_id` varchar(32) NOT NULL DEFAULT '' COMMENT '修改人ID',
    `modifier` varchar(32) NOT NULL DEFAULT '' COMMENT '修改人',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '生成时间',
    `modify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    KEY `idx_test_case_id` (`test_case_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
COMMENT='JMX脚本表';

CREATE TABLE `mysterious_jar` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
    `src_name` varchar(255) NOT NULL DEFAULT '' COMMENT '上传前JAR包名称',
    `dst_name` varchar(255) NOT NULL DEFAULT '' COMMENT '上传后JAR包名称',
    `description` varchar(255) NOT NULL DEFAULT '' COMMENT 'JAR包描述',
    `jar_dir` varchar(255) NOT NULL DEFAULT '' COMMENT 'jar包目录',
    `test_case_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '用例ID',
    `creator_id` varchar(32) NOT NULL DEFAULT '' COMMENT '创建人ID',
    `creator` varchar(32) NOT NULL DEFAULT '' COMMENT '创建人',
    `modifier_id` varchar(32) NOT NULL DEFAULT '' COMMENT '修改人ID',
    `modifier` varchar(32) NOT NULL DEFAULT '' COMMENT '修改人',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '生成时间',
    `modify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    KEY `idx_test_case_id` (`test_case_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
COMMENT='JAR包表';

CREATE TABLE `mysterious_csv` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
    `src_name` varchar(255) NOT NULL DEFAULT '' COMMENT '上传前CSV文件名称',
    `dst_name` varchar(255) NOT NULL DEFAULT '' COMMENT '上传后CSV文件名称',
    `description` varchar(255) NOT NULL DEFAULT '' COMMENT 'CSV文件描述',
    `csv_dir` varchar(255) NOT NULL DEFAULT '' COMMENT 'csv文件目录',
    `test_case_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '用例ID',
    `creator_id` varchar(32) NOT NULL DEFAULT '' COMMENT '创建人ID',
    `creator` varchar(32) NOT NULL DEFAULT '' COMMENT '创建人',
    `modifier_id` varchar(32) NOT NULL DEFAULT '' COMMENT '修改人ID',
    `modifier` varchar(32) NOT NULL DEFAULT '' COMMENT '修改人',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '生成时间',
    `modify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    KEY `idx_test_case_id` (`test_case_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
COMMENT='CSV文件表';

CREATE TABLE `mysterious_report` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
    `name` varchar(255) NOT NULL DEFAULT '' COMMENT '报告名称',
    `description` varchar(255) NOT NULL DEFAULT '' COMMENT '报告描述',
    `test_case_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '用例ID',
    `report_dir` varchar(255) NOT NULL DEFAULT '' COMMENT '测试报告目录',
    `exec_type` tinyint(2) NOT NULL DEFAULT '1' COMMENT '1-调试, 2-执行',
    `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0-未执行，1-执行中, 2-执行成功, 3-执行异常',
    `response_data` varchar(512) NOT NULL DEFAULT '' COMMENT '调试结果',
    `jmeter_log_file_path` varchar(255) NOT NULL DEFAULT '' COMMENT '结果JTL文件',
    `creator_id` varchar(32) NOT NULL DEFAULT '' COMMENT '创建人ID',
    `creator` varchar(32) NOT NULL DEFAULT '' COMMENT '创建人',
    `modifier_id` varchar(32) NOT NULL DEFAULT '' COMMENT '修改人ID',
    `modifier` varchar(32) NOT NULL DEFAULT '' COMMENT '修改人',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '生成时间',
    `modify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    KEY `idx_test_case_id` (`test_case_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
COMMENT='测试报告表';

CREATE TABLE `mysterious_jmx_thread_group` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
    `test_case_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '用例ID',
    `jmx_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '脚本ID',
    `num_threads` varchar(32) NOT NULL DEFAULT '' COMMENT '线程数',
    `ramp_time` varchar(32) NOT NULL DEFAULT '' COMMENT '持续时间',
    `loops` varchar(32) NOT NULL DEFAULT '' COMMENT '循环次数',
    `same_user_on_next_iteration` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-不勾选，1-勾选',
    `delayed_start` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-不勾选，1-勾选',
    `scheduler` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-不勾选，1-勾选',
    `duration` varchar(32) NOT NULL DEFAULT '' COMMENT '持续时间',
    `delay` varchar(32) NOT NULL DEFAULT '' COMMENT '延迟启动',
    `creator_id` varchar(32) NOT NULL DEFAULT '' COMMENT '创建人ID',
    `creator` varchar(32) NOT NULL DEFAULT '' COMMENT '创建人',
    `modifier_id` varchar(32) NOT NULL DEFAULT '' COMMENT '修改人ID',
    `modifier` varchar(32) NOT NULL DEFAULT '' COMMENT '修改人',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '生成时间',
    `modify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    KEY `idx_test_case_id` (`test_case_id`) USING BTREE,
    KEY `idx_jmx_id` (`jmx_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
COMMENT='JXM脚本普通线程组表';

CREATE TABLE `mysterious_jmx_stepping_thread_group` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
    `test_case_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '用例ID',
    `jmx_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '脚本ID',
    `num_threads` varchar(32) NOT NULL DEFAULT '' COMMENT 'ThreadGroup.num_threads',
    `first_wait_for_seconds` varchar(32) NOT NULL DEFAULT '' COMMENT 'Threads initial delay',
    `then_start_threads` varchar(32) NOT NULL DEFAULT '' COMMENT 'Start users count burst',
    `next_add_threads` varchar(32) NOT NULL DEFAULT '' COMMENT 'Start users count',
    `next_add_threads_every_seconds` varchar(32) NOT NULL DEFAULT '' COMMENT 'Start users period',
    `using_ramp_up_seconds` varchar(32) NOT NULL DEFAULT '' COMMENT 'rampUp',
    `then_hold_load_for_seconds` varchar(32) NOT NULL DEFAULT '' COMMENT 'flighttime',
    `finally_stop_threads` varchar(32) NOT NULL DEFAULT '' COMMENT 'Stop users count',
    `finally_stop_threads_every_seconds` varchar(32) NOT NULL DEFAULT '' COMMENT 'Stop users period',
    `creator_id` varchar(32) NOT NULL DEFAULT '' COMMENT '创建人ID',
    `creator` varchar(32) NOT NULL DEFAULT '' COMMENT '创建人',
    `modifier_id` varchar(32) NOT NULL DEFAULT '' COMMENT '修改人ID',
    `modifier` varchar(32) NOT NULL DEFAULT '' COMMENT '修改人',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '生成时间',
    `modify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    KEY `idx_test_case_id` (`test_case_id`) USING BTREE,
    KEY `idx_jmx_id` (`jmx_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
COMMENT='JXM脚本梯度加压线程组表';

CREATE TABLE `mysterious_jmx_concurrency_thread_group` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
    `test_case_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '用例ID',
    `jmx_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '脚本ID',
    `target_concurrency` varchar(32) NOT NULL DEFAULT '' COMMENT '目标线程数',
    `ramp_up_time` varchar(32) NOT NULL DEFAULT '' COMMENT '目标时间',
    `ramp_up_steps_count` varchar(32) NOT NULL DEFAULT '' COMMENT '梯度数量',
    `hold_target_rate_time` varchar(32) NOT NULL DEFAULT '' COMMENT '梯度结束持续时间',
    `creator_id` varchar(32) NOT NULL DEFAULT '' COMMENT '创建人ID',
    `creator` varchar(32) NOT NULL DEFAULT '' COMMENT '创建人',
    `modifier_id` varchar(32) NOT NULL DEFAULT '' COMMENT '修改人ID',
    `modifier` varchar(32) NOT NULL DEFAULT '' COMMENT '修改人',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '生成时间',
    `modify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    KEY `idx_test_case_id` (`test_case_id`) USING BTREE,
    KEY `idx_jmx_id` (`jmx_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
COMMENT='JXM脚本并发线程组表';

CREATE TABLE `mysterious_jmx_http` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
    `test_case_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '用例ID',
    `jmx_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '脚本ID',
    `method` varchar(32) NOT NULL DEFAULT '' COMMENT '方法',
    `protocol` varchar(32) NOT NULL DEFAULT '' COMMENT '协议',
    `domain` varchar(255) NOT NULL DEFAULT '' COMMENT 'IP',
    `port` varchar(32) NOT NULL DEFAULT '' COMMENT '端口',
    `path` varchar(255) NOT NULL DEFAULT '' COMMENT '路径',
    `content_encoding` varchar(32) NOT NULL DEFAULT '' COMMENT '编码',
    `body` varchar(4096) NOT NULL DEFAULT '' COMMENT 'http的body',
    `creator_id` varchar(32) NOT NULL DEFAULT '' COMMENT '创建人ID',
    `creator` varchar(32) NOT NULL DEFAULT '' COMMENT '创建人',
    `modifier_id` varchar(32) NOT NULL DEFAULT '' COMMENT '修改人ID',
    `modifier` varchar(32) NOT NULL DEFAULT '' COMMENT '修改人',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '生成时间',
    `modify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    KEY `idx_test_case_id` (`test_case_id`) USING BTREE,
    KEY `idx_jmx_id` (`jmx_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
COMMENT='JXM脚本HTTP请求表';

CREATE TABLE `mysterious_jmx_http_header` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
    `test_case_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '用例ID',
    `jmx_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '脚本ID',
    `http_id` bigint(20) NOT NULL DEFAULT '0' COMMENT 'HTTP请求ID',
    `header_key` varchar(255) NOT NULL DEFAULT '' COMMENT 'header名称',
    `header_value` varchar(255) NOT NULL DEFAULT '' COMMENT 'header值',
    `creator_id` varchar(32) NOT NULL DEFAULT '' COMMENT '创建人ID',
    `creator` varchar(32) NOT NULL DEFAULT '' COMMENT '创建人',
    `modifier_id` varchar(32) NOT NULL DEFAULT '' COMMENT '修改人ID',
    `modifier` varchar(32) NOT NULL DEFAULT '' COMMENT '修改人',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '生成时间',
    `modify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    KEY `idx_test_case_id` (`test_case_id`) USING BTREE,
    KEY `idx_jmx_id` (`jmx_id`) USING BTREE,
    KEY `idx_http_id` (`http_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
COMMENT='JXM脚本HTTP请求Header表';

CREATE TABLE `mysterious_jmx_http_param` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
    `test_case_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '用例ID',
    `jmx_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '脚本ID',
    `http_id` bigint(20) NOT NULL DEFAULT '0' COMMENT 'HTTP请求ID',
    `param_key` varchar(255) NOT NULL DEFAULT '' COMMENT '参数名称',
    `param_value` varchar(255) NOT NULL DEFAULT '' COMMENT '参数值',
    `creator_id` varchar(32) NOT NULL DEFAULT '' COMMENT '创建人ID',
    `creator` varchar(32) NOT NULL DEFAULT '' COMMENT '创建人',
    `modifier_id` varchar(32) NOT NULL DEFAULT '' COMMENT '修改人ID',
    `modifier` varchar(32) NOT NULL DEFAULT '' COMMENT '修改人',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '生成时间',
    `modify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    KEY `idx_test_case_id` (`test_case_id`) USING BTREE,
    KEY `idx_jmx_id` (`jmx_id`) USING BTREE,
    KEY `idx_http_id` (`http_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
COMMENT='JXM脚本HTTP请求参数表';

CREATE TABLE `mysterious_jmx_java` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
    `test_case_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '用例ID',
    `jmx_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '脚本ID',
    `java_request_class_path` varchar(32) NOT NULL DEFAULT '' COMMENT 'Java类路径',
    `param_key` varchar(255) NOT NULL DEFAULT '' COMMENT '参数名称',
    `param_value` varchar(255) NOT NULL DEFAULT '' COMMENT '参数值',
    `creator_id` varchar(32) NOT NULL DEFAULT '' COMMENT '创建人ID',
    `creator` varchar(32) NOT NULL DEFAULT '' COMMENT '创建人',
    `modifier_id` varchar(32) NOT NULL DEFAULT '' COMMENT '修改人ID',
    `modifier` varchar(32) NOT NULL DEFAULT '' COMMENT '修改人',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '生成时间',
    `modify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    KEY `idx_test_case_id` (`test_case_id`) USING BTREE,
    KEY `idx_jmx_id` (`jmx_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
COMMENT='JXM脚本Java请求表';

CREATE TABLE `mysterious_jmx_assertion` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
    `test_case_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '用例ID',
    `jmx_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '脚本ID',
    `response_code` varchar(32) NOT NULL DEFAULT '' COMMENT '响应码',
    `response_message` varchar(255) NOT NULL DEFAULT '' COMMENT '响应内容',
    `json_path` varchar(32) NOT NULL DEFAULT '' COMMENT 'JSON路径',
    `expected_value` varchar(255) NOT NULL DEFAULT '' COMMENT '期望值',
    `creator_id` varchar(32) NOT NULL DEFAULT '' COMMENT '创建人ID',
    `creator` varchar(32) NOT NULL DEFAULT '' COMMENT '创建人',
    `modifier_id` varchar(32) NOT NULL DEFAULT '' COMMENT '修改人ID',
    `modifier` varchar(32) NOT NULL DEFAULT '' COMMENT '修改人',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '生成时间',
    `modify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    KEY `idx_test_case_id` (`test_case_id`) USING BTREE,
    KEY `idx_jmx_id` (`jmx_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
COMMENT='JMX脚本断言表';

CREATE TABLE `mysterious_jmx_csv` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
    `test_case_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '用例ID',
    `jmx_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '脚本ID',
    `filename` varchar(255) NOT NULL DEFAULT '' COMMENT 'CSV文件名',
    `variable_names` varchar(255) NOT NULL DEFAULT '' COMMENT '变量名（逗号分隔）',
    `delimiter` varchar(10) NOT NULL DEFAULT ',' COMMENT '分隔符',
    `file_encoding` varchar(32) NOT NULL DEFAULT 'UTF-8' COMMENT '文件编码',
    `ignore_first_line` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否忽略第一行；1-是，0-否',
    `allow_quoted_data` tinyint(1) NOT NULL DEFAULT '0' COMMENT '允许带引号的数据；1-是，0-否',
    `recycle_on_eof` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否在EOF时循环；1-是，0-否',
    `stop_thread_on_eof` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否在EOF时停止线程；1-是，0-否',
    `sharing_mode` varchar(32) NOT NULL DEFAULT 'Current thread group' COMMENT '共享模式（all, group, thread）',
    `creator_id` varchar(32) NOT NULL DEFAULT '' COMMENT '创建人ID',
    `creator` varchar(32) NOT NULL DEFAULT '' COMMENT '创建人',
    `modifier_id` varchar(32) NOT NULL DEFAULT '' COMMENT '修改人ID',
    `modifier` varchar(32) NOT NULL DEFAULT '' COMMENT '修改人',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '生成时间',
    `modify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    KEY `idx_test_case_id` (`test_case_id`) USING BTREE,
    KEY `idx_jmx_id` (`jmx_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
COMMENT='JMX脚本CSV模块表';

CREATE TABLE `mysterious_jmx_dubbo` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
    `test_case_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '用例ID',
    `jmx_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '脚本ID',
    `name` varchar(255) NOT NULL DEFAULT '' COMMENT '名称',
    `comments` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
    `config_center_protocol` varchar(255) NOT NULL DEFAULT '' COMMENT '配置中心协议',
    `config_center_group` varchar(255) NOT NULL DEFAULT '' COMMENT '配置中心组',
    `config_center_namespace` varchar(255) NOT NULL DEFAULT '' COMMENT '配置中心命名空间',
    `config_center_username` varchar(255) NOT NULL DEFAULT '' COMMENT '配置中心用户名',
    `config_center_password` varchar(255) NOT NULL DEFAULT '' COMMENT '配置中心密码',
    `config_center_address` varchar(255) NOT NULL DEFAULT '' COMMENT '配置中心地址',
    `config_center_timeout` varchar(255) NOT NULL DEFAULT '' COMMENT '配置中心超时时间',
    `registry_protocol` varchar(255) NOT NULL DEFAULT '' COMMENT '注册中心协议',
    `registry_group` varchar(255) NOT NULL DEFAULT '' COMMENT '注册中心组',
    `registry_username` varchar(255) NOT NULL DEFAULT '' COMMENT '注册中心用户名',
    `registry_password` varchar(255) NOT NULL DEFAULT '' COMMENT '注册中心密码',
    `registry_address` varchar(255) NOT NULL DEFAULT '' COMMENT '注册中心地址',
    `registry_timeout` varchar(255) NOT NULL DEFAULT '' COMMENT '注册中心超时时间',
    `rpc_protocol` varchar(255) NOT NULL DEFAULT '' COMMENT 'RPC协议',
    `timeout` varchar(255) NOT NULL DEFAULT '' COMMENT '超时时间',
    `version` varchar(255) NOT NULL DEFAULT '' COMMENT '版本',
    `retries` varchar(255) NOT NULL DEFAULT '' COMMENT '重试次数',
    `cluster` varchar(255) NOT NULL DEFAULT '' COMMENT '集群策略',
    `group` varchar(255) NOT NULL DEFAULT '' COMMENT '组',
    `connections` varchar(255) NOT NULL DEFAULT '' COMMENT '连接数',
    `async` varchar(255) NOT NULL DEFAULT '' COMMENT '异步/同步',
    `load_balance` varchar(255) NOT NULL DEFAULT '' COMMENT '负载均衡策略',
    `interface` varchar(255) NOT NULL DEFAULT '' COMMENT '接口',
    `method` varchar(255) NOT NULL DEFAULT '' COMMENT '方法',
    `method_args_size` tinyint(4) NOT NULL DEFAULT '0' COMMENT '方法参数数量',
    `attachment_args_size` tinyint(4) NOT NULL DEFAULT '0' COMMENT '附件参数数量',
    `creator_id` varchar(32) NOT NULL DEFAULT '' COMMENT '创建人ID',
    `creator` varchar(32) NOT NULL DEFAULT '' COMMENT '创建人',
    `modifier_id` varchar(32) NOT NULL DEFAULT '' COMMENT '修改人ID',
    `modifier` varchar(32) NOT NULL DEFAULT '' COMMENT '修改人',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '生成时间',
    `modify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    KEY `idx_test_case_id` (`test_case_id`) USING BTREE,
    KEY `idx_jmx_id` (`jmx_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
COMMENT='JMX脚本Dubbo请求表';

CREATE TABLE `mysterious_jmx_dubbo_method_args` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
    `test_case_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '用例ID',
    `jmx_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '脚本ID',
    `dubbo_id` bigint(20) NOT NULL DEFAULT '0' COMMENT 'Dubbo请求ID',
    `param_type` varchar(255) NOT NULL DEFAULT '' COMMENT '参数类型',
    `param_value` varchar(4096) NOT NULL DEFAULT '' COMMENT '参数值',
    `creator_id` varchar(32) NOT NULL DEFAULT '' COMMENT '创建人ID',
    `creator` varchar(32) NOT NULL DEFAULT '' COMMENT '创建人',
    `modifier_id` varchar(32) NOT NULL DEFAULT '' COMMENT '修改人ID',
    `modifier` varchar(32) NOT NULL DEFAULT '' COMMENT '修改人',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '生成时间',
    `modify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    KEY `idx_test_case_id` (`test_case_id`) USING BTREE,
    KEY `idx_jmx_id` (`jmx_id`) USING BTREE,
    KEY `idx_dubbo_id` (`dubbo_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
COMMENT='JMX脚本Dubbo方法参数表';

CREATE TABLE `mysterious_jmx_dubbo_attachment_args` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
    `test_case_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '用例ID',
    `jmx_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '脚本ID',
    `dubbo_id` bigint(20) NOT NULL DEFAULT '0' COMMENT 'Dubbo请求ID',
    `attachment_key` varchar(255) NOT NULL DEFAULT '' COMMENT '附件键',
    `attachment_value` varchar(4096) NOT NULL DEFAULT '' COMMENT '附件值',
    `creator_id` varchar(32) NOT NULL DEFAULT '' COMMENT '创建人ID',
    `creator` varchar(32) NOT NULL DEFAULT '' COMMENT '创建人',
    `modifier_id` varchar(32) NOT NULL DEFAULT '' COMMENT '修改人ID',
    `modifier` varchar(32) NOT NULL DEFAULT '' COMMENT '修改人',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '生成时间',
    `modify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    KEY `idx_test_case_id` (`test_case_id`) USING BTREE,
    KEY `idx_jmx_id` (`jmx_id`) USING BTREE,
    KEY `idx_dubbo_id` (`dubbo_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
COMMENT='JMX脚本Dubbo附件参数表';