
# YouLai_Boot 데이터베이스(postgresql x.x)
# Copyright (c) 2021-present, youlai.tech


-- ----------------------------
-- 1. 
-- ----------------------------
-- CREATE DATABASE IF NOT EXISTS youlai_boot CHARACTER SET utf8mb4 DEFAULT COLLATE utf8mb4_unicode_ci;


-- ----------------------------
-- 2. 테이블 생성 && 데이터 초기화
-- ----------------------------
--use youlai_boot;

--SET NAMES utf8mb4;  # 문자 집합 설정
--SET FOREIGN_KEY_CHECKS = 0; # 외래 키 검사 닫기, 가져오기 속도 향상

-- bigserial은 PostgreSQL에서 자동으로 시퀀스를 생성하고 디폴트 값으로 설정

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
-- bigint 타입의 컬럼 생성
-- 시퀀스 자동 생성 (sys_dept_id_seq)
-- 컬럼의 디폴트 값을 nextval('sys_dept_id_seq')로 설정

DROP TABLE IF EXISTS sys_dept;

CREATE TABLE sys_dept (
    id bigserial NOT NULL PRIMARY KEY,
    name varchar(100) NOT NULL,
    code varchar(100) NOT NULL,
    parent_id bigint DEFAULT 0,
    tree_path varchar(255) NOT NULL,
    sort smallint DEFAULT 0,
    status smallint DEFAULT 1,
    create_by bigint NULL,
    create_time timestamp NULL,
    update_by bigint NULL,
    update_time timestamp NULL,
    is_deleted smallint DEFAULT 0,
    CONSTRAINT uk_code UNIQUE (code)
);

COMMENT ON TABLE sys_dept IS '부문표';
COMMENT ON COLUMN sys_dept.id IS '주건';
COMMENT ON COLUMN sys_dept.name IS '부문명칭';
COMMENT ON COLUMN sys_dept.code IS '부문편호';
COMMENT ON COLUMN sys_dept.parent_id IS '부절점id';
COMMENT ON COLUMN sys_dept.tree_path IS '부절점id로경';
COMMENT ON COLUMN sys_dept.sort IS '현시순서';
COMMENT ON COLUMN sys_dept.status IS '상태(1-정상 0-금용)';
COMMENT ON COLUMN sys_dept.create_by IS '창건인ID';
COMMENT ON COLUMN sys_dept.create_time IS '창건시간';
COMMENT ON COLUMN sys_dept.update_by IS '수정인ID';
COMMENT ON COLUMN sys_dept.update_time IS '갱신시간';
COMMENT ON COLUMN sys_dept.is_deleted IS '논리삭제표식(1-이삭제 0-미삭제)';

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO sys_dept (id, name, code, parent_id, tree_path, sort, status, create_by, create_time, update_by, update_time, is_deleted) 
VALUES (1, '유래기술', 'YOULAI', 0, '0', 1, 1, 1, NULL, 1, now(), 0);

INSERT INTO sys_dept (id, name, code, parent_id, tree_path, sort, status, create_by, create_time, update_by, update_time, is_deleted) 
VALUES (2, '연발부문', 'RD001', 1, '0,1', 1, 1, 2, NULL, 2, now(), 0);

INSERT INTO sys_dept (id, name, code, parent_id, tree_path, sort, status, create_by, create_time, update_by, update_time, is_deleted) 
VALUES (3, '측시부문', 'QA001', 1, '0,1', 1, 1, 2, NULL, 2, now(), 0);

-- 시퀀스 동기화
SELECT setval('sys_dept_id_seq', (SELECT MAX(id) FROM sys_dept));

-- ----------------------------

-- Table structure for sys_dict

DROP TABLE IF EXISTS sys_dict;

CREATE TABLE sys_dict (
    id bigserial NOT NULL PRIMARY KEY,
    dict_code varchar(50),
    name varchar(50),
    status smallint DEFAULT 0,
    remark varchar(255),
    create_time timestamp,
    create_by bigint,
    update_time timestamp,
    update_by bigint,
    is_deleted smallint DEFAULT 0
);

CREATE INDEX idx_dict_code ON sys_dict (dict_code);

COMMENT ON TABLE sys_dict IS '사전 테이블';
COMMENT ON COLUMN sys_dict.id IS '주키';
COMMENT ON COLUMN sys_dict.dict_code IS '유형 코드';
COMMENT ON COLUMN sys_dict.name IS '유형 이름';
COMMENT ON COLUMN sys_dict.status IS '상태(0:정상;1:비활성화)';
COMMENT ON COLUMN sys_dict.remark IS '비고';
COMMENT ON COLUMN sys_dict.create_time IS '생성 시간';
COMMENT ON COLUMN sys_dict.create_by IS '생성자 ID';
COMMENT ON COLUMN sys_dict.update_time IS '갱신 시간';
COMMENT ON COLUMN sys_dict.update_by IS '수정자 ID';
COMMENT ON COLUMN sys_dict.is_deleted IS '삭제 여부(1-삭제됨, 0-삭제되지 않음)';

-- Records of sys_dict

INSERT INTO sys_dict VALUES (1, 'gender', '성별', 1, NULL, now() , 1,now(), 1,0);
INSERT INTO sys_dict VALUES (2, 'notice_type', '통지 유형', 1, NULL, now(), 1,now(), 1,0);
INSERT INTO sys_dict VALUES (3, 'notice_level', '통지 레벨', 1, NULL, now(), 1,now(), 1,0);

-- 시퀀스 동기화
SELECT setval('sys_dict_id_seq', (SELECT MAX(id) FROM sys_dict));


-- ----------------------------
-- Table structure for sys_dict_item

DROP TABLE IF EXISTS sys_dict_item;

CREATE TABLE sys_dict_item (
    id bigserial NOT NULL PRIMARY KEY,
    dict_code varchar(50),
    value varchar(50),
    label varchar(100),
    tag_type varchar(50),
    status smallint DEFAULT 0,
    sort integer DEFAULT 0,
    remark varchar(255),
    create_time timestamp,
    create_by bigint,
    update_time timestamp,
    update_by bigint
);

COMMENT ON TABLE sys_dict_item IS '사전 항목 테이블';
COMMENT ON COLUMN sys_dict_item.id IS '주키';
COMMENT ON COLUMN sys_dict_item.dict_code IS '관련 사전 코드, sys_dict 테이블의 dict_code와 대응';
COMMENT ON COLUMN sys_dict_item.value IS '사전 항목 값';
COMMENT ON COLUMN sys_dict_item.label IS '사전 항목 라벨';
COMMENT ON COLUMN sys_dict_item.tag_type IS '태그 유형, 프론트엔드 스타일 표시용(success, warning 등)';
COMMENT ON COLUMN sys_dict_item.status IS '상태(1-정상, 0-비활성화)';
COMMENT ON COLUMN sys_dict_item.sort IS '정렬';
COMMENT ON COLUMN sys_dict_item.remark IS '비고';
COMMENT ON COLUMN sys_dict_item.create_time IS '생성 시간';
COMMENT ON COLUMN sys_dict_item.create_by IS '생성자 ID';
COMMENT ON COLUMN sys_dict_item.update_time IS '갱신 시간';
COMMENT ON COLUMN sys_dict_item.update_by IS '수정자 ID';

-- ----------------------------
-- - Records of sys_dict_item

INSERT INTO sys_dict_item VALUES (1, 'gender', '1', '남', 'primary', 1, 1, NULL, now(), 1,now(),1);
INSERT INTO sys_dict_item VALUES (2, 'gender', '2', '여', 'danger', 1, 2, NULL, now(), 1,now(),1);
INSERT INTO sys_dict_item VALUES (3, 'gender', '0', '비공개', 'info', 1, 3, NULL, now(), 1,now(),1);
INSERT INTO sys_dict_item VALUES (4, 'notice_type', '1', '시스템 업그레이드', 'success', 1, 1, '', now(), 1,now(),1);
INSERT INTO sys_dict_item VALUES (5, 'notice_type', '2', '시스템 유지보수', 'primary', 1, 2, '', now(), 1,now(),1);
INSERT INTO sys_dict_item VALUES (6, 'notice_type', '3', '보안 경고', 'danger', 1, 3, '', now(), 1,now(),1);
INSERT INTO sys_dict_item VALUES (7, 'notice_type', '4', '휴일 통지', 'success', 1, 4, '', now(), 1,now(),1);
INSERT INTO sys_dict_item VALUES (8, 'notice_type', '5', '회사 뉴스', 'primary', 1, 5, '', now(), 1,now(),1);
INSERT INTO sys_dict_item VALUES (9, 'notice_type', '99', '기타', 'info', 1, 99, '', now(), 1,now(),1);
INSERT INTO sys_dict_item VALUES (10, 'notice_level', 'L', '낮음', 'info', 1, 1, '', now(), 1,now(),1);
INSERT INTO sys_dict_item VALUES (11, 'notice_level', 'M', '중간', 'warning', 1, 2, '', now(), 1,now(),1);
INSERT INTO sys_dict_item VALUES (12, 'notice_level', 'H', '높음', 'danger', 1, 3, '', now(), 1,now(),1);

-- 시퀀스 동기화
SELECT setval('sys_dict_item_id_seq', (SELECT MAX(id) FROM sys_dict_item));



-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS sys_menu;

CREATE TABLE sys_menu (
    id bigserial NOT NULL PRIMARY KEY,
    parent_id bigint NOT NULL,
    tree_path varchar(255),
    name varchar(64) NOT NULL,
    type smallint NOT NULL,
    route_name varchar(255),
    route_path varchar(128),
    component varchar(128),
    perm varchar(128),
    always_show smallint DEFAULT 0,
    keep_alive smallint DEFAULT 0,
    visible smallint DEFAULT 1,
    sort integer DEFAULT 0,
    icon varchar(64),
    redirect varchar(128),
    create_time timestamp NULL,
    update_time timestamp NULL,
    params varchar(255) NULL
);

COMMENT ON TABLE sys_menu IS '메뉴 관리';
COMMENT ON COLUMN sys_menu.id IS 'ID';
COMMENT ON COLUMN sys_menu.parent_id IS '부모 메뉴 ID';
COMMENT ON COLUMN sys_menu.tree_path IS '부모 노드 ID 경로';
COMMENT ON COLUMN sys_menu.name IS '메뉴 이름';
COMMENT ON COLUMN sys_menu.type IS '메뉴 유형(1-메뉴 2-디렉토리 3-외부 링크 4-버튼)';
COMMENT ON COLUMN sys_menu.route_name IS '라우트 이름(Vue Router에서 라우트 이름 지정에 사용)';
COMMENT ON COLUMN sys_menu.route_path IS '라우트 경로(Vue Router에서 정의된 URL 경로)';
COMMENT ON COLUMN sys_menu.component IS '컴포넌트 경로(컴포넌트 페이지 전체 경로, src/views/ 기준, .vue 접미사 생략)';
COMMENT ON COLUMN sys_menu.perm IS '[버튼] 권한 식별자';
COMMENT ON COLUMN sys_menu.always_show IS '[디렉토리] 하위 라우트가 하나일 때도 항상 표시할지 여부(1-예 0-아니오)';
COMMENT ON COLUMN sys_menu.keep_alive IS '[메뉴] 페이지 캐시 활성화 여부(1-예 0-아니오)';
COMMENT ON COLUMN sys_menu.visible IS '표시 상태(1-표시 0-숨김)';
COMMENT ON COLUMN sys_menu.sort IS '정렬';
COMMENT ON COLUMN sys_menu.icon IS '메뉴 아이콘';
COMMENT ON COLUMN sys_menu.redirect IS '리다이렉트 경로';
COMMENT ON COLUMN sys_menu.create_time IS '생성 시간';
COMMENT ON COLUMN sys_menu.update_time IS '갱신 시간';
COMMENT ON COLUMN sys_menu.params IS '라우트 매개변수';


-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO sys_menu VALUES (1, 0, '0', '시스템 관리', 2, '', '/system', 'Layout', NULL, NULL, NULL, 1, 1, 'system', '/system/user', now(), now(), NULL);
INSERT INTO sys_menu VALUES (2, 1, '0,1', '사용자 관리', 1, 'User', 'user', 'system/user/index', NULL, NULL, 1, 1, 1, 'el-icon-User', NULL, now(), now(), NULL);
INSERT INTO sys_menu VALUES (3, 1, '0,1', '역할 관리', 1, 'Role', 'role', 'system/role/index', NULL, NULL, 1, 1, 2, 'role', NULL, now(), now(), NULL);

INSERT INTO sys_menu VALUES (4, 1, '0,1', '메뉴 관리', 1, 'SysMenu', 'menu', 'system/menu/index', NULL, NULL, 1, 1, 3, 'menu', NULL, now(), now(), NULL);
INSERT INTO sys_menu VALUES (5, 1, '0,1', '부서 관리', 1, 'Dept', 'dept', 'system/dept/index', NULL, NULL, 1, 1, 4, 'tree', NULL, now(), now(), NULL);
INSERT INTO sys_menu VALUES (6, 1, '0,1', '사전 관리', 1, 'Dict', 'dict', 'system/dict/index', NULL, NULL, 1, 1, 5, 'dict', NULL, now(), now(), NULL);
INSERT INTO sys_menu VALUES (20, 0, '0', '다단계 메뉴', 2, NULL, '/multi-level', 'Layout', NULL, 1, NULL, 1, 9, 'cascader', '', now(), now(), NULL);
INSERT INTO sys_menu VALUES (21, 20, '0,20', '메뉴 1단계', 1, NULL, 'multi-level1', 'demo/multi-level/level1', NULL, 1, NULL, 1, 1, '', '', now(), now(), NULL);
INSERT INTO sys_menu VALUES (22, 21, '0,20,21', '메뉴 2단계', 1, NULL, 'multi-level2', 'demo/multi-level/children/level2', NULL, 0, NULL, 1, 1, '', NULL, now(), now(), NULL);
INSERT INTO sys_menu VALUES (23, 22, '0,20,21,22', '메뉴 3단계-1', 1, NULL, 'multi-level3-1', 'demo/multi-level/children/children/level3-1', NULL, 0, 1, 1, 1, '', '', now(), now(), NULL);
INSERT INTO sys_menu VALUES (24, 22, '0,20,21,22', '메뉴 3단계-2', 1, NULL, 'multi-level3-2', 'demo/multi-level/children/children/level3-2', NULL, 0, 1, 1, 2, '', '', now(), now(), NULL);
INSERT INTO sys_menu VALUES (26, 0, '0', '플랫폼 문서', 2, '', '/doc', 'Layout', NULL, NULL, NULL, 1, 8, 'document', 'https://juejin.cn/post/7228990409909108793', now(), now(), NULL);
INSERT INTO sys_menu VALUES (30, 26, '0,26', '플랫폼 문서(외부 링크)', 3, NULL, 'https://juejin.cn/post/7228990409909108793', '', NULL, NULL, NULL, 1, 2, 'document', '', now(), now(), NULL);
INSERT INTO sys_menu VALUES (31, 2, '0,1,2', '사용자 추가', 4, NULL, '', NULL, 'sys:user:add', NULL, NULL, 1, 1, '', '', now(), now(), NULL);
INSERT INTO sys_menu VALUES (32, 2, '0,1,2', '사용자 편집', 4, NULL, '', NULL, 'sys:user:edit', NULL, NULL, 1, 2, '', '', now(), now(), NULL);
INSERT INTO sys_menu VALUES (33, 2, '0,1,2', '사용자 삭제', 4, NULL, '', NULL, 'sys:user:delete', NULL, NULL, 1, 3, '', '', now(), now(), NULL);
INSERT INTO sys_menu VALUES (36, 0, '0', '컴포넌트 패키징', 2, NULL, '/component', 'Layout', NULL, NULL, NULL, 1, 10, 'menu', '', now(), now(), NULL);
INSERT INTO sys_menu VALUES (37, 36, '0,36', '리치 텍스트 에디터', 1, NULL, 'wang-editor', 'demo/wang-editor', NULL, NULL, 1, 1, 2, '', '', NULL, NULL, NULL);
INSERT INTO sys_menu VALUES (38, 36, '0,36', '이미지 업로드', 1, NULL, 'upload', 'demo/upload', NULL, NULL, 1, 1, 3, '', '', now(), now(), NULL);
INSERT INTO sys_menu VALUES (39, 36, '0,36', '아이콘 선택기', 1, NULL, 'icon-selector', 'demo/icon-selector', NULL, NULL, 1, 1, 4, '', '', now(), now(), NULL);
INSERT INTO sys_menu VALUES (40, 0, '0', '인터페이스 문서', 2, NULL, '/api', 'Layout', NULL, 1, NULL, 1, 7, 'api', '', now(), now(), NULL);
INSERT INTO sys_menu VALUES (41, 40, '0,40', 'Apifox', 1, NULL, 'apifox', 'demo/api/apifox', NULL, NULL, 1, 1, 1, 'api', '', now(), now(), NULL);
INSERT INTO sys_menu VALUES (70, 3, '0,1,3', '역할 추가', 4, NULL, '', NULL, 'sys:role:add', NULL, NULL, 1, 2, '', NULL, now(), now(), NULL);
INSERT INTO sys_menu VALUES (71, 3, '0,1,3', '역할 편집', 4, NULL, '', NULL, 'sys:role:edit', NULL, NULL, 1, 3, '', NULL, now(), now(), NULL);
INSERT INTO sys_menu VALUES (72, 3, '0,1,3', '역할 삭제', 4, NULL, '', NULL, 'sys:role:delete', NULL, NULL, 1, 4, '', NULL, now(), now(), NULL);
INSERT INTO sys_menu VALUES (73, 4, '0,1,4', '메뉴 추가', 4, NULL, '', NULL, 'sys:menu:add', NULL, NULL, 1, 1, '', NULL, now(), now(), NULL);
INSERT INTO sys_menu VALUES (74, 4, '0,1,4', '메뉴 편집', 4, NULL, '', NULL, 'sys:menu:edit', NULL, NULL, 1, 3, '', NULL, now(), now(), NULL);
INSERT INTO sys_menu VALUES (75, 4, '0,1,4', '메뉴 삭제', 4, NULL, '', NULL, 'sys:menu:delete', NULL, NULL, 1, 3, '', NULL, now(), now(), NULL);
INSERT INTO sys_menu VALUES (76, 5, '0,1,5', '부서 추가', 4, NULL, '', NULL, 'sys:dept:add', NULL, NULL, 1, 1, '', NULL, now(), now(), NULL);
INSERT INTO sys_menu VALUES (77, 5, '0,1,5', '부서 편집', 4, NULL, '', NULL, 'sys:dept:edit', NULL, NULL, 1, 2, '', NULL, now(), now(), NULL);
INSERT INTO sys_menu VALUES (78, 5, '0,1,5', '부서 삭제', 4, NULL, '', NULL, 'sys:dept:delete', NULL, NULL, 1, 3, '', NULL, now(), now(), NULL);
INSERT INTO sys_menu VALUES (79, 6, '0,1,6', '사전 추가', 4, NULL, '', NULL, 'sys:dict:add', NULL, NULL, 1, 1, '', NULL, now(), now(), NULL);
INSERT INTO sys_menu VALUES (81, 6, '0,1,6', '사전 편집', 4, NULL, '', NULL, 'sys:dict:edit', NULL, NULL, 1, 2, '', NULL, now(), now(), NULL);
INSERT INTO sys_menu VALUES (84, 6, '0,1,6', '사전 삭제', 4, NULL, '', NULL, 'sys:dict:delete', NULL, NULL, 1, 3, '', NULL, now(), now(), NULL);
INSERT INTO sys_menu VALUES (88, 2, '0,1,2', '비밀번호 재설정', 4, NULL, '', NULL, 'sys:user:reset-password', NULL, NULL, 1, 4, '', NULL, now(), now(), NULL);
INSERT INTO sys_menu VALUES (89, 0, '0', '기능 데모', 2, NULL, '/function', 'Layout', NULL, NULL, NULL, 1, 12, 'menu', '', now(), now(), NULL);
INSERT INTO sys_menu VALUES (90, 89, '0,89', 'Websocket', 1, NULL, '/function/websocket', 'demo/websocket', NULL, NULL, 1, 1, 3, '', '', now(), now(), NULL);
INSERT INTO sys_menu VALUES (95, 36, '0,36', '사전 컴포넌트', 1, NULL, 'dict-demo', 'demo/dictionary', NULL, NULL, 1, 1, 4, '', '',  now(),  now(), NULL);
INSERT INTO sys_menu VALUES (97, 89, '0,89', 'Icons', 1, NULL, 'icon-demo', 'demo/icons', NULL, NULL, 1, 1, 2, 'el-icon-Notification', '',  now(),  now(), NULL);
INSERT INTO sys_menu VALUES (102, 26, '0,26', 'document', 3, '', 'internal-doc', 'demo/internal-doc', NULL, NULL, NULL, 1, 1, 'document', '',  now(),  now(), NULL);
INSERT INTO sys_menu VALUES (105, 2, '0,1,2', '사용자 조회', 4, NULL, '', NULL, 'sys:user:query', 0, 0, 1, 0, '', NULL,  now(),  now(), NULL);
INSERT INTO sys_menu VALUES (106, 2, '0,1,2', '사용자 가져오기', 4, NULL, '', NULL, 'sys:user:import', NULL, NULL, 1, 5, '', NULL,  now(),  now(), NULL);
INSERT INTO sys_menu VALUES (107, 2, '0,1,2', '사용자 내보내기', 4, NULL, '', NULL, 'sys:user:export', NULL, NULL, 1, 6, '', NULL,  now(),  now(), NULL);
INSERT INTO sys_menu VALUES (108, 36, '0,36', '증가삭제수정조회', 1, NULL, 'curd', 'demo/curd/index', NULL, NULL, 1, 1, 0, '', '', NULL, NULL, NULL);
INSERT INTO sys_menu VALUES (109, 36, '0,36', '리스트 선택기', 1, NULL, 'table-select', 'demo/table-select/index', NULL, NULL, 1, 1, 1, '', '', NULL, NULL, NULL);
INSERT INTO sys_menu VALUES (110, 0, '0', '라우트 매개변수', 2, NULL, '/route-param', 'Layout', NULL, 1, 1, 1, 11, 'el-icon-ElementPlus', NULL, now(), now(), NULL);
INSERT INTO sys_menu VALUES (111, 110, '0,110', '매개변수(type=1)', 1, NULL, 'route-param-type1', 'demo/route-param', NULL, 0, 1, 1, 1, 'el-icon-Star', NULL, now(), now(), '{\"type\": \"1\"}');
INSERT INTO sys_menu VALUES (112, 110, '0,110', '매개변수(type=2)', 1, NULL, 'route-param-type2', 'demo/route-param', NULL, 0, 1, 1, 2, 'el-icon-StarFilled', NULL, now(), now(), '{\"type\": \"2\"}');
INSERT INTO sys_menu VALUES (117, 1, '0,1', '시스템 로그', 1, 'Log', 'log', 'system/log/index', NULL, 0, 1, 1, 6, 'document', NULL, now(), now(), NULL);
INSERT INTO sys_menu VALUES (118, 0, '0', '시스템 도구', 2, NULL, '/codegen', 'Layout', NULL, 0, 1, 1, 2, 'menu', NULL, now(), now(), NULL);
INSERT INTO sys_menu VALUES (119, 118, '0,118', '코드 생성', 1, 'Codegen', 'codegen', 'codegen/index', NULL, 0, 1, 1, 1, 'code', NULL, now(), now(), NULL);
INSERT INTO sys_menu VALUES (120, 1, '0,1', '시스템 구성', 1, 'Config', 'config', 'system/config/index', NULL, 0, 1, 1, 7, 'setting', NULL, now(), now(), NULL);
INSERT INTO sys_menu VALUES (121, 120, '0,1,120', '시스템 구성 조회', 4, NULL, '', NULL, 'sys:config:query', 0, 1, 1, 1, '', NULL, now(), now(), NULL);
INSERT INTO sys_menu VALUES (122, 120, '0,1,120', '시스템 구성 추가', 4, NULL, '', NULL, 'sys:config:add', 0, 1, 1, 2, '', NULL, now(), now(), NULL);
INSERT INTO sys_menu VALUES (123, 120, '0,1,120', '시스템 구성 수정', 4, NULL, '', NULL, 'sys:config:update', 0, 1, 1, 3, '', NULL, now(), now(), NULL);
INSERT INTO sys_menu VALUES (124, 120, '0,1,120', '시스템 구성 삭제', 4, NULL, '', NULL, 'sys:config:delete', 0, 1, 1, 4, '', NULL, now(), now(), NULL);
INSERT INTO sys_menu VALUES (125, 120, '0,1,120', '시스템 구성 새로고침', 4, NULL, '', NULL, 'sys:config:refresh', 0, 1, 1, 5, '', NULL, now(), now(), NULL);
INSERT INTO sys_menu VALUES (126, 1, '0,1', '알림 공지', 1, 'Notice', 'notice', 'system/notice/index', NULL, NULL, NULL, 1, 9, '', NULL, now(), now(), NULL);
INSERT INTO sys_menu VALUES (127, 126, '0,1,126', '알림 조회', 4, NULL, '', NULL, 'sys:notice:query', NULL, NULL, 1, 1, '', NULL, now(), now(), NULL);
INSERT INTO sys_menu VALUES (128, 126, '0,1,126', '알림 추가', 4, NULL, '', NULL, 'sys:notice:add', NULL, NULL, 1, 2, '', NULL, now(), now(), NULL);
INSERT INTO sys_menu VALUES (129, 126, '0,1,126', '알림 편집', 4, NULL, '', NULL, 'sys:notice:edit', NULL, NULL, 1, 3, '', NULL, now(), now(), NULL);
INSERT INTO sys_menu VALUES (130, 126, '0,1,126', '알림 삭제', 4, NULL, '', NULL, 'sys:notice:delete', NULL, NULL, 1, 4, '', NULL, now(), now(), NULL);
INSERT INTO sys_menu VALUES (133, 126, '0,1,126', '알림 게시', 4, NULL, '', NULL, 'sys:notice:publish', 0, 1, 1, 5, '', NULL, now(), now(), NULL);
INSERT INTO sys_menu VALUES (134, 126, '0,1,126', '알림 철회', 4, NULL, '', NULL, 'sys:notice:revoke', 0, 1, 1, 6, '', NULL, now(), now(), NULL);
INSERT INTO sys_menu VALUES (135, 1, '0,1', '사전 항목', 1, 'DictItem', 'dict-item', 'system/dict/dict-item', NULL, 0, 1, 0, 6, '', NULL, now(), now(), NULL);
INSERT INTO sys_menu VALUES (136, 135, '0,1,135', '사전 항목 추가', 4, NULL, '', NULL, 'sys:dict-item:add', NULL, NULL, 1, 2, '', NULL, now(), now(), NULL);
INSERT INTO sys_menu VALUES (137, 135, '0,1,135', '사전 항목 편집', 4, NULL, '', NULL, 'sys:dict-item:edit', NULL, NULL, 1, 3, '', NULL, now(), now(), NULL);
INSERT INTO sys_menu VALUES (138, 135, '0,1,135', '사전 항목 삭제', 4, NULL, '', NULL, 'sys:dict-item:delete', NULL, NULL, 1, 4, '', NULL, now(), now(), NULL);
INSERT INTO sys_menu VALUES (139, 3, '0,1,3', '역할 조회', 4, NULL, '', NULL, 'sys:role:query', NULL, NULL, 1, 1, '', NULL, now(), now(), NULL);
INSERT INTO sys_menu VALUES (140, 4, '0,1,4', '메뉴 조회', 4, NULL, '', NULL, 'sys:menu:query', NULL, NULL, 1, 1, '', NULL, now(), now(), NULL);
INSERT INTO sys_menu VALUES (141, 5, '0,1,5', '부서 조회', 4, NULL, '', NULL, 'sys:dept:query', NULL, NULL, 1, 1, '', NULL, now(), now(), NULL);
INSERT INTO sys_menu VALUES (142, 6, '0,1,6', '사전 조회', 4, NULL, '', NULL, 'sys:dict:query', NULL, NULL, 1, 1, '', NULL, now(), now(), NULL);
INSERT INTO sys_menu VALUES (143, 135, '0,1,135', '사전 항목 조회', 4, NULL, '', NULL, 'sys:dict-item:query', NULL, NULL, 1, 1, '', NULL, now(), now(), NULL);
INSERT INTO sys_menu VALUES (144, 26, '0,26', '백엔드 문서', 3, NULL, 'https://youlai.blog.csdn.net/article/details/145178880', '', NULL, NULL, NULL, 1, 3, 'document', '', '2024-10-05 23:36:03', '2024-10-05 23:36:03', NULL);
INSERT INTO sys_menu VALUES (145, 26, '0,26', '모바일 문서', 3, NULL, 'https://youlai.blog.csdn.net/article/details/143222890', '', NULL, NULL, NULL, 1, 4, 'document', '', '2024-10-05 23:36:03', '2024-10-05 23:36:03', NULL);
INSERT INTO sys_menu VALUES (146, 36, '0,36', '드래그 컴포넌트', 1, NULL, 'drag', 'demo/drag', NULL, NULL, NULL, 1, 5, '', '', '2025-03-31 14:14:45', '2025-03-31 14:14:52', NULL);
INSERT INTO sys_menu VALUES (147, 36, '0,36', '스크롤 텍스트', 1, NULL, 'text-scroll', 'demo/text-scroll', NULL, NULL, NULL, 1, 6, '', '', '2025-03-31 14:14:49', '2025-03-31 14:14:56', NULL);
INSERT INTO sys_menu VALUES (148, 89, '0,89', '사전 실시간 동기화', 1, NULL, 'dict-sync', 'demo/dict-sync', NULL, NULL, NULL, 1, 3, '', '', '2025-03-31 14:14:49', '2025-03-31 14:14:56', NULL);

-- 시퀀스 동기화
SELECT setval('sys_menu_id_seq', (SELECT MAX(id) FROM sys_menu));



-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS sys_role;

CREATE TABLE sys_role (
    id bigserial NOT NULL PRIMARY KEY,
    name varchar(64) NOT NULL,
    code varchar(32) NOT NULL,
    sort integer NULL,
    status smallint DEFAULT 1,
    data_scope smallint NULL,
    create_by bigint NULL,
    create_time timestamp NULL,
    update_by bigint NULL,
    update_time timestamp NULL,
    is_deleted smallint DEFAULT 0,
    CONSTRAINT uk_sys_role_name UNIQUE (name),
    CONSTRAINT uk_sys_role_code UNIQUE (code)
);

COMMENT ON TABLE sys_role IS '역할 테이블';
COMMENT ON COLUMN sys_role.id IS 'ID';
COMMENT ON COLUMN sys_role.name IS '역할 이름';
COMMENT ON COLUMN sys_role.code IS '역할 코드';
COMMENT ON COLUMN sys_role.sort IS '표시 순서';
COMMENT ON COLUMN sys_role.status IS '역할 상태(1-정상 0-중지)';
COMMENT ON COLUMN sys_role.data_scope IS '데이터 권한(1-모든 데이터 2-부서 및 하위 부서 데이터 3-본 부서 데이터 4-자신의 데이터)';
COMMENT ON COLUMN sys_role.create_by IS '생성자 ID';
COMMENT ON COLUMN sys_role.create_time IS '생성 시간';
COMMENT ON COLUMN sys_role.update_by IS '갱신자 ID';
COMMENT ON COLUMN sys_role.update_time IS '갱신 시간';
COMMENT ON COLUMN sys_role.is_deleted IS '논리적 삭제 표시(0-삭제되지 않음 1-삭제됨)';



-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO sys_role VALUES (1, '최고 관리자', 'ROOT', 1, 1, 1, NULL, now(), NULL, now(), 0);
INSERT INTO sys_role VALUES (2, '시스템 관리자', 'ADMIN', 2, 1, 1, NULL, now(), NULL, NULL, 0);
INSERT INTO sys_role VALUES (3, '방문 게스트', 'GUEST', 3, 1, 3, NULL, now(), NULL, now(), 0);
INSERT INTO sys_role VALUES (4, '시스템 관리자1', 'ADMIN1', 4, 1, 1, NULL, now(), NULL, NULL, 0);
INSERT INTO sys_role VALUES (5, '시스템 관리자2', 'ADMIN2', 5, 1, 1, NULL, now(), NULL, NULL, 0);
INSERT INTO sys_role VALUES (6, '시스템 관리자3', 'ADMIN3', 6, 1, 1, NULL, now(), NULL, NULL, 0);
INSERT INTO sys_role VALUES (7, '시스템 관리자4', 'ADMIN4', 7, 1, 1, NULL, now(), NULL, NULL, 0);
INSERT INTO sys_role VALUES (8, '시스템 관리자5', 'ADMIN5', 8, 1, 1, NULL, now(), NULL, NULL, 0);
INSERT INTO sys_role VALUES (9, '시스템 관리자6', 'ADMIN6', 9, 1, 1, NULL, now(), NULL, NULL, 0);
INSERT INTO sys_role VALUES (10, '시스템 관리자7', 'ADMIN7', 10, 1, 1, NULL, now(), NULL, NULL, 0);
INSERT INTO sys_role VALUES (11, '시스템 관리자8', 'ADMIN8', 11, 1, 1, NULL, now(), NULL, NULL, 0);
INSERT INTO sys_role VALUES (12, '시스템 관리자9', 'ADMIN9', 12, 1, 1, NULL, now(), NULL, NULL, 0);

-- 시퀀스 동기화
SELECT setval('sys_role_id_seq', (SELECT MAX(id) FROM sys_role));


-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS sys_role_menu;

CREATE TABLE sys_role_menu (
    role_id bigint NOT NULL,
    menu_id bigint NOT NULL,
    CONSTRAINT uk_roleid_menuid UNIQUE (role_id, menu_id)
);

COMMENT ON TABLE sys_role_menu IS '역할과 메뉴 연결 테이블';
COMMENT ON COLUMN sys_role_menu.role_id IS '역할 ID';
COMMENT ON COLUMN sys_role_menu.menu_id IS '메뉴 ID';

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO sys_role_menu VALUES (2, 1);
INSERT INTO sys_role_menu VALUES (2, 2);
INSERT INTO sys_role_menu VALUES (2, 3);
INSERT INTO sys_role_menu VALUES (2, 4);
INSERT INTO sys_role_menu VALUES (2, 5);
INSERT INTO sys_role_menu VALUES (2, 6);
INSERT INTO sys_role_menu VALUES (2, 20);
INSERT INTO sys_role_menu VALUES (2, 21);
INSERT INTO sys_role_menu VALUES (2, 22);
INSERT INTO sys_role_menu VALUES (2, 23);
INSERT INTO sys_role_menu VALUES (2, 24);
INSERT INTO sys_role_menu VALUES (2, 26);
INSERT INTO sys_role_menu VALUES (2, 30);
INSERT INTO sys_role_menu VALUES (2, 31);
INSERT INTO sys_role_menu VALUES (2, 32);
INSERT INTO sys_role_menu VALUES (2, 33);
INSERT INTO sys_role_menu VALUES (2, 36);
INSERT INTO sys_role_menu VALUES (2, 37);
INSERT INTO sys_role_menu VALUES (2, 38);
INSERT INTO sys_role_menu VALUES (2, 39);
INSERT INTO sys_role_menu VALUES (2, 40);
INSERT INTO sys_role_menu VALUES (2, 41);
INSERT INTO sys_role_menu VALUES (2, 70);
INSERT INTO sys_role_menu VALUES (2, 71);
INSERT INTO sys_role_menu VALUES (2, 72);
INSERT INTO sys_role_menu VALUES (2, 73);
INSERT INTO sys_role_menu VALUES (2, 74);
INSERT INTO sys_role_menu VALUES (2, 75);
INSERT INTO sys_role_menu VALUES (2, 76);
INSERT INTO sys_role_menu VALUES (2, 77);
INSERT INTO sys_role_menu VALUES (2, 78);
INSERT INTO sys_role_menu VALUES (2, 79);
INSERT INTO sys_role_menu VALUES (2, 81);
INSERT INTO sys_role_menu VALUES (2, 84);
INSERT INTO sys_role_menu VALUES (2, 85);
INSERT INTO sys_role_menu VALUES (2, 86);
INSERT INTO sys_role_menu VALUES (2, 87);
INSERT INTO sys_role_menu VALUES (2, 88);
INSERT INTO sys_role_menu VALUES (2, 89);
INSERT INTO sys_role_menu VALUES (2, 90);
INSERT INTO sys_role_menu VALUES (2, 91);
INSERT INTO sys_role_menu VALUES (2, 95);
INSERT INTO sys_role_menu VALUES (2, 97);
INSERT INTO sys_role_menu VALUES (2, 102);
INSERT INTO sys_role_menu VALUES (2, 105);
INSERT INTO sys_role_menu VALUES (2, 106);
INSERT INTO sys_role_menu VALUES (2, 107);
INSERT INTO sys_role_menu VALUES (2, 108);
INSERT INTO sys_role_menu VALUES (2, 109);
INSERT INTO sys_role_menu VALUES (2, 110);
INSERT INTO sys_role_menu VALUES (2, 111);
INSERT INTO sys_role_menu VALUES (2, 112);
INSERT INTO sys_role_menu VALUES (2, 114);
INSERT INTO sys_role_menu VALUES (2, 115);
INSERT INTO sys_role_menu VALUES (2, 116);
INSERT INTO sys_role_menu VALUES (2, 117);
INSERT INTO sys_role_menu VALUES (2, 118);
INSERT INTO sys_role_menu VALUES (2, 119);
INSERT INTO sys_role_menu VALUES (2, 120);
INSERT INTO sys_role_menu VALUES (2, 121);
INSERT INTO sys_role_menu VALUES (2, 122);
INSERT INTO sys_role_menu VALUES (2, 123);
INSERT INTO sys_role_menu VALUES (2, 124);
INSERT INTO sys_role_menu VALUES (2, 125);
INSERT INTO sys_role_menu VALUES (2, 126);
INSERT INTO sys_role_menu VALUES (2, 127);
INSERT INTO sys_role_menu VALUES (2, 128);
INSERT INTO sys_role_menu VALUES (2, 129);
INSERT INTO sys_role_menu VALUES (2, 130);
INSERT INTO sys_role_menu VALUES (2, 131);
INSERT INTO sys_role_menu VALUES (2, 132);
INSERT INTO sys_role_menu VALUES (2, 133);
INSERT INTO sys_role_menu VALUES (2, 134);
INSERT INTO sys_role_menu VALUES (2, 135);
INSERT INTO sys_role_menu VALUES (2, 136);
INSERT INTO sys_role_menu VALUES (2, 137);
INSERT INTO sys_role_menu VALUES (2, 138);
INSERT INTO sys_role_menu VALUES (2, 139);
INSERT INTO sys_role_menu VALUES (2, 140);
INSERT INTO sys_role_menu VALUES (2, 141);
INSERT INTO sys_role_menu VALUES (2, 142);
INSERT INTO sys_role_menu VALUES (2, 143);
INSERT INTO sys_role_menu VALUES (2, 144);
INSERT INTO sys_role_menu VALUES (2, 145);
INSERT INTO sys_role_menu VALUES (2, 146);
INSERT INTO sys_role_menu VALUES (2, 147);
INSERT INTO sys_role_menu VALUES (2, 148);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS sys_user;

CREATE TABLE sys_user (
    id bigserial NOT NULL PRIMARY KEY,
    username varchar(64),
    nickname varchar(64),
    gender smallint DEFAULT 1,
    password varchar(100),
    dept_id integer,
    avatar varchar(255),
    mobile varchar(20),
    status smallint DEFAULT 1,
    email varchar(128),
    create_time timestamp,
    create_by bigint,
    update_time timestamp,
    update_by bigint,
    is_deleted smallint DEFAULT 0,
    openid char(28),
    CONSTRAINT login_name UNIQUE (username)
);

COMMENT ON TABLE sys_user IS '사용자 정보 테이블';
COMMENT ON COLUMN sys_user.id IS 'ID';
COMMENT ON COLUMN sys_user.username IS '사용자명';
COMMENT ON COLUMN sys_user.nickname IS '닉네임';
COMMENT ON COLUMN sys_user.gender IS '성별((1-남 2-여 0-비공개)';
COMMENT ON COLUMN sys_user.password IS '비밀번호';
COMMENT ON COLUMN sys_user.dept_id IS '부서 ID';
COMMENT ON COLUMN sys_user.avatar IS '사용자 아바타';
COMMENT ON COLUMN sys_user.mobile IS '연락처';
COMMENT ON COLUMN sys_user.status IS '상태(1-정상 0-비활성화)';
COMMENT ON COLUMN sys_user.email IS '사용자 이메일';
COMMENT ON COLUMN sys_user.create_time IS '생성 시간';
COMMENT ON COLUMN sys_user.create_by IS '생성자 ID';
COMMENT ON COLUMN sys_user.update_time IS '갱신 시간';
COMMENT ON COLUMN sys_user.update_by IS '수정자 ID';
COMMENT ON COLUMN sys_user.is_deleted IS '논리적 삭제 표시(0-삭제되지 않음 1-삭제됨)';
COMMENT ON COLUMN sys_user.openid IS '위챗 openid';




-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO sys_user VALUES (1, 'root', '유라이 기술', 0, '$2a$10$xVWsNOhHrCxh5UbpCE7/HuJ.PAOKcYAqRxD2CO2nVnJS.IAXkr5aq', NULL, 'https://foruda.gitee.com/images/1723603502796844527/03cdca2a_716974.gif', '18812345677', 1, 'youlaitech@163.com', now(), NULL, now(), NULL, 0,NULL);
INSERT INTO sys_user VALUES (2, 'admin', '시스템 관리자', 1, '$2a$10$xVWsNOhHrCxh5UbpCE7/HuJ.PAOKcYAqRxD2CO2nVnJS.IAXkr5aq', 1, 'https://foruda.gitee.com/images/1723603502796844527/03cdca2a_716974.gif', '18812345678', 1, 'youlaitech@163.com', now(), NULL, now(), NULL, 0,NULL);
INSERT INTO sys_user VALUES (3, 'test', '테스트 사용자', 1, '$2a$10$xVWsNOhHrCxh5UbpCE7/HuJ.PAOKcYAqRxD2CO2nVnJS.IAXkr5aq', 3, 'https://foruda.gitee.com/images/1723603502796844527/03cdca2a_716974.gif', '18812345679', 1, 'youlaitech@163.com', now(), NULL, now(), NULL, 0,NULL);

-- 시퀀스 동기화
SELECT setval('sys_user_id_seq', (SELECT MAX(id) FROM sys_user));





-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS sys_user_role;

CREATE TABLE sys_user_role (
    user_id bigint NOT NULL,
    role_id bigint NOT NULL,
    PRIMARY KEY (user_id, role_id)
);

COMMENT ON TABLE sys_user_role IS '사용자와 역할 연결 테이블';
COMMENT ON COLUMN sys_user_role.user_id IS '사용자 ID';
COMMENT ON COLUMN sys_user_role.role_id IS '역할 ID';


-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO sys_user_role VALUES (1, 1);
INSERT INTO sys_user_role VALUES (2, 2);
INSERT INTO sys_user_role VALUES (3, 3);


-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS sys_log;

CREATE TABLE sys_log (
    id bigserial NOT NULL PRIMARY KEY,
    module varchar(50) NOT NULL,
    request_method varchar(64) NOT NULL,
    request_params text,
    response_content text,
    content varchar(255) NOT NULL,
    request_uri varchar(255),
    method varchar(255),
    ip varchar(45),
    province varchar(100),
    city varchar(100),
    execution_time bigint,
    browser varchar(100),
    browser_version varchar(100),
    os varchar(100),
    create_by bigint,
    create_time timestamp,
    is_deleted smallint DEFAULT 0
);

CREATE INDEX idx_create_time ON sys_log (create_time);

COMMENT ON TABLE sys_log IS '시스템 로그 테이블';
COMMENT ON COLUMN sys_log.id IS '주키';
COMMENT ON COLUMN sys_log.module IS '로그 모듈';
COMMENT ON COLUMN sys_log.request_method IS '요청 방식';
COMMENT ON COLUMN sys_log.request_params IS '요청 매개변수(대량 요청 매개변수는 text를 초과할 수 있음)';
COMMENT ON COLUMN sys_log.response_content IS '반환 매개변수';
COMMENT ON COLUMN sys_log.content IS '로그 내용';
COMMENT ON COLUMN sys_log.request_uri IS '요청 경로';
COMMENT ON COLUMN sys_log.method IS '메소드명';
COMMENT ON COLUMN sys_log.ip IS 'IP 주소';
COMMENT ON COLUMN sys_log.province IS '성/도';
COMMENT ON COLUMN sys_log.city IS '도시';
COMMENT ON COLUMN sys_log.execution_time IS '실행 시간(ms)';
COMMENT ON COLUMN sys_log.browser IS '브라우저';
COMMENT ON COLUMN sys_log.browser_version IS '브라우저 버전';
COMMENT ON COLUMN sys_log.os IS '단말기 시스템';
COMMENT ON COLUMN sys_log.create_by IS '생성자 ID';
COMMENT ON COLUMN sys_log.create_time IS '생성 시간';
COMMENT ON COLUMN sys_log.is_deleted IS '논리적 삭제 표시(1-삭제됨 0-삭제되지 않음)';




-- ----------------------------
-- Table structure for gen_config
-- ----------------------------
DROP TABLE IF EXISTS gen_config;

CREATE TABLE gen_config (
    id bigserial NOT NULL PRIMARY KEY,
    table_name varchar(100) NOT NULL,
    module_name varchar(100),
    package_name varchar(255) NOT NULL,
    business_name varchar(100) NOT NULL,
    entity_name varchar(100) NOT NULL,
    author varchar(50) NOT NULL,
    parent_menu_id bigint,
    create_time timestamp,
    update_time timestamp,
    is_deleted boolean DEFAULT false,
    CONSTRAINT uk_tablename UNIQUE (table_name)
);

COMMENT ON TABLE gen_config IS '코드 생성 기본 설정 테이블';
COMMENT ON COLUMN gen_config.id IS 'ID';
COMMENT ON COLUMN gen_config.table_name IS '테이블명';
COMMENT ON COLUMN gen_config.module_name IS '모듈명';
COMMENT ON COLUMN gen_config.package_name IS '패키지명';
COMMENT ON COLUMN gen_config.business_name IS '비즈니스명';
COMMENT ON COLUMN gen_config.entity_name IS '엔티티 클래스명';
COMMENT ON COLUMN gen_config.author IS '작성자';
COMMENT ON COLUMN gen_config.parent_menu_id IS '상위 메뉴 ID, sys_menu의 id에 대응';
COMMENT ON COLUMN gen_config.create_time IS '생성 시간';
COMMENT ON COLUMN gen_config.update_time IS '갱신 시간';
COMMENT ON COLUMN gen_config.is_deleted IS '삭제 여부';


-- ----------------------------
-- Table structure for gen_field_config
-- ----------------------------
DROP TABLE IF EXISTS gen_field_config;

CREATE TABLE gen_field_config (
    id bigserial NOT NULL PRIMARY KEY,
    config_id bigint NOT NULL,
    column_name varchar(100),
    column_type varchar(50),
    column_length integer,
    field_name varchar(100) NOT NULL,
    field_type varchar(100),
    field_sort integer,
    field_comment varchar(255),
    max_length integer,
    is_required smallint,
    is_show_in_list smallint DEFAULT 0,
    is_show_in_form smallint DEFAULT 0,
    is_show_in_query smallint DEFAULT 0,
    query_type smallint,
    form_type smallint,
    dict_type varchar(50),
    create_time timestamp,
    update_time timestamp
);

CREATE INDEX gen_field_config_config_id_idx ON gen_field_config (config_id);

COMMENT ON TABLE gen_field_config IS '코드 생성 필드 설정 테이블';
COMMENT ON COLUMN gen_field_config.id IS 'ID';
COMMENT ON COLUMN gen_field_config.config_id IS '관련 설정 ID';
COMMENT ON COLUMN gen_field_config.column_name IS '컬럼명';
COMMENT ON COLUMN gen_field_config.column_type IS '컬럼 타입';
COMMENT ON COLUMN gen_field_config.column_length IS '컬럼 길이';
COMMENT ON COLUMN gen_field_config.field_name IS '필드명';
COMMENT ON COLUMN gen_field_config.field_type IS '필드 타입';
COMMENT ON COLUMN gen_field_config.field_sort IS '필드 정렬';
COMMENT ON COLUMN gen_field_config.field_comment IS '필드 설명';
COMMENT ON COLUMN gen_field_config.max_length IS '최대 길이';
COMMENT ON COLUMN gen_field_config.is_required IS '필수 여부';
COMMENT ON COLUMN gen_field_config.is_show_in_list IS '목록에 표시 여부';
COMMENT ON COLUMN gen_field_config.is_show_in_form IS '폼에 표시 여부';
COMMENT ON COLUMN gen_field_config.is_show_in_query IS '검색 조건에 표시 여부';
COMMENT ON COLUMN gen_field_config.query_type IS '검색 방식';
COMMENT ON COLUMN gen_field_config.form_type IS '폼 타입';
COMMENT ON COLUMN gen_field_config.dict_type IS '사전 타입';
COMMENT ON COLUMN gen_field_config.create_time IS '생성 시간';
COMMENT ON COLUMN gen_field_config.update_time IS '갱신 시간';





-- ----------------------------
-- 시스템 구성 테이블

DROP TABLE IF EXISTS sys_config;

CREATE TABLE sys_config (
    id bigserial NOT NULL PRIMARY KEY,
    config_name varchar(50) NOT NULL,
    config_key varchar(50) NOT NULL,
    config_value varchar(100) NOT NULL,
    remark varchar(255),
    create_time timestamp,
    create_by bigint,
    update_time timestamp,
    update_by bigint,
    is_deleted smallint DEFAULT 0 NOT NULL
);

COMMENT ON TABLE sys_config IS '시스템 구성 테이블';
COMMENT ON COLUMN sys_config.id IS 'ID';
COMMENT ON COLUMN sys_config.config_name IS '구성명';
COMMENT ON COLUMN sys_config.config_key IS '구성 키';
COMMENT ON COLUMN sys_config.config_value IS '구성값';
COMMENT ON COLUMN sys_config.remark IS '비고';
COMMENT ON COLUMN sys_config.create_time IS '생성 시간';
COMMENT ON COLUMN sys_config.create_by IS '생성자 ID';
COMMENT ON COLUMN sys_config.update_time IS '갱신 시간';
COMMENT ON COLUMN sys_config.update_by IS '갱신자 ID';
COMMENT ON COLUMN sys_config.is_deleted IS '논리적 삭제 표시(0-삭제되지 않음 1-삭제됨)';

INSERT INTO sys_config VALUES (1, '시스템 제한 QPS', 'IP_QPS_THRESHOLD_LIMIT', '10', '단일 IP 요청의 최대 초당 쿼리 수(QPS) 임계값 키', now(), 1, NULL, NULL, 0);

-- 시퀀스 동기화
SELECT setval('sys_config_id_seq', (SELECT MAX(id) FROM sys_config));



-- ----------------------------
-- 알림 공지 테이블
-- ----------------------------DROP TABLE IF EXISTS sys_notice;

CREATE TABLE sys_notice (
    id bigserial NOT NULL PRIMARY KEY,
    title varchar(500),
    content text,
    type smallint NOT NULL,
    level varchar(5) NOT NULL,
    target_type smallint NOT NULL,
    target_user_ids varchar(255),
    publisher_id bigint,
    publish_status smallint DEFAULT 0,
    publish_time timestamp,
    revoke_time timestamp,
    create_by bigint NOT NULL,
    create_time timestamp NOT NULL,
    update_by bigint,
    update_time timestamp,
    is_deleted smallint DEFAULT 0
);

COMMENT ON TABLE sys_notice IS '알림 공지 테이블';
COMMENT ON COLUMN sys_notice.id IS 'ID';
COMMENT ON COLUMN sys_notice.title IS '알림 제목';
COMMENT ON COLUMN sys_notice.content IS '알림 내용';
COMMENT ON COLUMN sys_notice.type IS '알림 유형(관련 사전 코드: notice_type)';
COMMENT ON COLUMN sys_notice.level IS '알림 등급(사전 코드: notice_level)';
COMMENT ON COLUMN sys_notice.target_type IS '대상 유형(1: 전체, 2: 지정)';
COMMENT ON COLUMN sys_notice.target_user_ids IS '대상자 ID 집합(여러 개는 영문 쉼표,로 구분)';
COMMENT ON COLUMN sys_notice.publisher_id IS '게시자 ID';
COMMENT ON COLUMN sys_notice.publish_status IS '게시 상태(0: 미게시, 1: 게시됨, -1: 철회됨)';
COMMENT ON COLUMN sys_notice.publish_time IS '게시 시간';
COMMENT ON COLUMN sys_notice.revoke_time IS '철회 시간';
COMMENT ON COLUMN sys_notice.create_by IS '생성자 ID';
COMMENT ON COLUMN sys_notice.create_time IS '생성 시간';
COMMENT ON COLUMN sys_notice.update_by IS '갱신자 ID';
COMMENT ON COLUMN sys_notice.update_time IS '갱신 시간';
COMMENT ON COLUMN sys_notice.is_deleted IS '삭제 여부(0: 삭제되지 않음, 1: 삭제됨)';





INSERT INTO sys_notice VALUES (1, 'v2.12.0 시스템 로그, 접속 동향 통계 기능 추가.', '<p>1. 메시지 알림</p><p>2. 사전 재구성</p><p>3. 코드 생성</p>', 1, 'L', 1, '2', 1, 1, now(), now(), 2, now(), 1, now(), 0);
INSERT INTO sys_notice VALUES (2, 'v2.13.0 메뉴 검색 추가.', '<p>1. 메시지 알림</p><p>2. 사전 재구성</p><p>3. 코드 생성</p>', 1, 'L', 1, '2', 1, 1, now(), now(), 2, now(), 1, now(), 0);
INSERT INTO sys_notice VALUES (3, 'v2.14.0 개인 센터 추가.', '<p>1. 메시지 알림</p><p>2. 사전 재구성</p><p>3. 코드 생성</p>', 1, 'L', 1, '2', 2, 1, now(), now(), 2, now(), 2, now(), 0);
INSERT INTO sys_notice VALUES (4, 'v2.15.0 로그인 페이지 개선.', '<p>1. 메시지 알림</p><p>2. 사전 재구성</p><p>3. 코드 생성</p>', 1, 'L', 1, '2', 2, 1, now(), now(), 2, now(), 2, now(), 0);
INSERT INTO sys_notice VALUES (5, 'v2.16.0 알림 공지, 사전 번역 컴포넌트.', '<p>1. 메시지 알림</p><p>2. 사전 재구성</p><p>3. 코드 생성</p>', 1, 'L', 1, '2', 2, 1, now(), now(), 2, now(), 2, now(), 0);
INSERT INTO sys_notice VALUES (6, '시스템은 이번 주 토요일 새벽 2시에 유지보수가 진행될 예정이며, 예상 유지보수 시간은 2시간입니다.', '<p>1. 메시지 알림</p><p>2. 사전 재구성</p><p>3. 코드 생성</p>', 2, 'H', 1, '2', 2, 1, now(), now(), 2, now(), 2, now(), 0);
INSERT INTO sys_notice VALUES (7, '최근 피싱 이메일이 발견되었으니 주의하시고 낯선 링크를 클릭하지 마세요.', '<p>1. 메시지 알림</p><p>2. 사전 재구성</p><p>3. 코드 생성</p>', 3, 'L', 1, '2', 2, 1, now(), now(), 2, now(), 2, now(), 0);
INSERT INTO sys_notice VALUES (8, '국경절 휴가는 10월 1일부터 10월 7일까지 총 7일입니다.', '<p>1. 메시지 알림</p><p>2. 사전 재구성</p><p>3. 코드 생성</p>', 4, 'L', 1, '2', 2, 1, now(), now(), 2, now(), 2, now(), 0);
INSERT INTO sys_notice VALUES (9, '회사는 10월 15일에 신제품 발표회를 개최할 예정이니 기대해 주세요.', '회사는 10월 15일에 신제품 발표회를 개최할 예정이니 기대해 주세요.', 5, 'H', 1, '2', 2, 1, now(), now(), 2, now(), 2, now(), 0);
INSERT INTO sys_notice VALUES (10, 'v2.16.1 버전 출시.', 'v2.16.1 버전은 WebSocket 중복 연결로 인한 백엔드 스레드 블로킹 문제를 수정하고 알림 공지를 최적화했습니다.', 1, 'M', 1, '2', 2, 1, now(), now(), 2, now(), 2, now(), 0);

-- 시퀀스 동기화
SELECT setval('sys_notice_id_seq', (SELECT MAX(id) FROM sys_notice));



-- ----------------------------
-- 사용자 알림 공지 테이블
-- ----------------------------
DROP TABLE IF EXISTS sys_user_notice;

CREATE TABLE sys_user_notice (
    id bigserial NOT NULL PRIMARY KEY,
    notice_id bigint NOT NULL,
    user_id bigint NOT NULL,
    is_read smallint DEFAULT 0,
    read_time timestamp,
    create_time timestamp NOT NULL,
    update_time timestamp,
    is_deleted smallint DEFAULT 0
);

COMMENT ON TABLE sys_user_notice IS '사용자 알림 공지 테이블';
COMMENT ON COLUMN sys_user_notice.id IS 'id';
COMMENT ON COLUMN sys_user_notice.notice_id IS '공공 알림 id';
COMMENT ON COLUMN sys_user_notice.user_id IS '사용자 id';
COMMENT ON COLUMN sys_user_notice.is_read IS '읽기 상태(0: 읽지 않음, 1: 읽음)';
COMMENT ON COLUMN sys_user_notice.read_time IS '읽은 시간';
COMMENT ON COLUMN sys_user_notice.create_time IS '생성 시간';
COMMENT ON COLUMN sys_user_notice.update_time IS '갱신 시간';
COMMENT ON COLUMN sys_user_notice.is_deleted IS '논리적 삭제(0: 삭제되지 않음, 1: 삭제됨)';




INSERT INTO sys_user_notice VALUES (1, 1, 2, 1, NULL, now(), now(), 0);
INSERT INTO sys_user_notice VALUES (2, 2, 2, 1, NULL, now(), now(), 0);
INSERT INTO sys_user_notice VALUES (3, 3, 2, 1, NULL, now(), now(), 0);
INSERT INTO sys_user_notice VALUES (4, 4, 2, 1, NULL, now(), now(), 0);
INSERT INTO sys_user_notice VALUES (5, 5, 2, 1, NULL, now(), now(), 0);
INSERT INTO sys_user_notice VALUES (6, 6, 2, 1, NULL, now(), now(), 0);
INSERT INTO sys_user_notice VALUES (7, 7, 2, 1, NULL, now(), now(), 0);
INSERT INTO sys_user_notice VALUES (8, 8, 2, 1, NULL, now(), now(), 0);
INSERT INTO sys_user_notice VALUES (9, 9, 2, 1, NULL, now(), now(), 0);
INSERT INTO sys_user_notice VALUES (10, 10, 2, 1, NULL, now(), now(), 0);

 
-- 시퀀스 동기화
SELECT setval('sys_user_notice_id_seq', (SELECT MAX(id) FROM sys_user_notice));
