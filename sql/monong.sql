--회원관련 테이블 
CREATE TABLE member (
	member_id 	varchar2(100)		NOT NULL,
	member_name	varchar2(30)		NOT NULL,
	member_password	varchar2(255)		NOT NULL,
	member_email	varchar2(100)		NOT NULL,
	member_address	varchar2(100)		NOT NULL,
	member_address_ex	varchar2(100)		NULL,
	member_phone	varchar2(11)		NOT NULL,
	member_birthday	date		NOT NULL,
	member_del	varchar2(1)	DEFAULT 'N'	NOT NULL,
	member_enroll_date	date	DEFAULT current_date	NOT NULL,
	member_quit_date	date		NULL
);

COMMENT ON COLUMN member.member_birthday IS '0000-00-00';

COMMENT ON COLUMN member.member_enroll_date IS '0000-00-00';

CREATE TABLE member_notification (
	noti_no	varchar2(100)		NOT NULL,
	member_id	varchar2(100)		NOT NULL,
	noti_content	varchar2(2000)		NOT NULL,
	noti_created_at	date	DEFAULT current_date	NULL,
	noti_is_read 	varchar2(1)	DEFAULT 'N'	NULL,
	d_inquire_no	number		NULL,
	d_order_no	number		NULL,
	s_order_no	number		NULL
);
COMMENT ON COLUMN member_notification.d_inquire_no IS '답변완료시 알림';

COMMENT ON COLUMN member_notification.d_order_no IS '주문관련 알림';

COMMENT ON COLUMN member_notification.s_order_no IS '주문상태 변경시 알림';

CREATE TABLE inquire (
	inquire_no	number		NOT NULL,
	member_id	varchar2(100)		NOT NULL,
	inquire_title	varchar2(512)		NOT NULL,
	inquire_content	varchar2(2000)		NULL,
	inquire_created_at	date	DEFAULT current_date	NULL,
	has_answer	varchar2(1)	DEFAULT 'N'	NULL
);

CREATE TABLE inquire_answer (
	inquire_a_no	number	NOT NULL,
	inquire_no	number		NOT NULL,
	inquire_a_content	varchar2(2000)		NULL,
	inquire_answered_at	date	DEFAULT current_date	NULL
);

CREATE TABLE seller_info (
	member_id	varchar2(100)		NOT NULL,
	seller_reg_no	varchar2(12)		NOT NULL,
	seller_name	varchar2(100)		NOT NULL,
	seller_status	varchar2(8)	DEFAULT 'REG_W'	NULL,
	seller_quit_date	date		NULL,
	seller_enroll_date	date		NULL,
	seller_del	varchar2(1)	DEFAULT 'N'	NULL
);

CREATE TABLE seller_info_attachment (
	seller_attach_no	number		NOT NULL,
	member_id	varchar2(100)		NOT NULL,
	original_filename	 varchar2(256)		NOT NULL,
	renamed_filename	varchar2(256)		NOT NULL
);

--회원 이메일 인증키 저장 테이블 추가: member 테이블과 연결X
create table member_email_identify(
    member_email varchar2(100), 
    identify_key varchar2(50) not null,
    constraint pk_member_email primary key(member_email)
);

COMMENT ON COLUMN seller_info.seller_reg_no IS '000-00-00000';

COMMENT ON COLUMN seller_info.seller_status IS '가입대기, 가입승인';

COMMENT ON COLUMN seller_info.seller_del IS 'Y, N';

CREATE TABLE member_authority (
	auth varchar2(50)		NOT NULL,
	member_id	varchar2(100)		NOT NULL
);
--회원관련 PK,FK
ALTER TABLE member ADD CONSTRAINT PK_MEMBER PRIMARY KEY (
	member_id
);

ALTER TABLE seller_info_attachment ADD CONSTRAINT PK_SELLER_INFO_ATTACHMENT PRIMARY KEY (
	seller_attach_no,
	member_id
);

ALTER TABLE seller_info ADD CONSTRAINT PK_SELLER_INFO PRIMARY KEY (
	member_id
);

ALTER TABLE member_authority ADD CONSTRAINT PK_MEMBER_AUTHORITY PRIMARY KEY (
	auth,
	member_id
);
ALTER TABLE member_notification ADD CONSTRAINT PK_MEMBER_NOTIFICATION PRIMARY KEY (
	noti_no
);

ALTER TABLE inquire ADD CONSTRAINT PK_INQUIRE PRIMARY KEY (
	inquire_no
);

ALTER TABLE inquire_answer ADD CONSTRAINT PK_INQUIRE_ANSWER PRIMARY KEY (
	inquire_a_no,
	inquire_no
);

ALTER TABLE inquire_answer ADD CONSTRAINT FK_inquire_TO_inquire_answer_1 FOREIGN KEY (
	inquire_no
)
REFERENCES inquire (
	inquire_no
);

ALTER TABLE seller_info_attachment ADD CONSTRAINT FK_seller_info_TO_seller_info_attachment_1 FOREIGN KEY (
	member_id
)
REFERENCES seller_info (
	member_id
) on delete cascade;

ALTER TABLE seller_info ADD CONSTRAINT FK_member_TO_seller_info_1 FOREIGN KEY (
	member_id
)
REFERENCES member (
	member_id
) on delete cascade;

ALTER TABLE member_authority ADD CONSTRAINT FK_member_TO_member_authority_1 FOREIGN KEY (
	member_id
)
REFERENCES member (
	member_id
) on delete cascade;

ALTER TABLE member_notification ADD CONSTRAINT FK_member_id_TO_motification FOREIGN KEY (
	member_id
) 
REFERENCES member
(
	member_id
) on delete cascade;
--회원 이메일인증 관련 컬럼 추가
alter table member add member_identified varchar2(1);
--회원관련 시퀀스
create sequence seq_noti_no;
create sequence seq_seller_attach_no;
create sequence seq_inquire_no;
create sequence seq_inquire_a_no;

--회원관련 테이블 끝

-- 정기구독시작(정기구독 관련 테이블)
CREATE TABLE  subscription (
	s_no	varchar2(100)		NOT NULL,
	card_info_no	number		NOT NULL,
	member_id	varchar2(100)		NOT NULL,
	s_product_code	varchar2(6)		NOT NULL,
	s_exclude_vegs	varchar2(500)		NULL,
	s_delivery_cycle	number		NOT NULL,
	s_next_delivery_date	date		NOT NULL,
	s_delay_yn	varchar2(1)	DEFAULT 'N'	NULL,
	s_recipient	varchar2(100)		NOT NULL,
	s_phone	varchar2(11)		NOT NULL,
	s_address	varchar2(100)		NOT NULL,
	s_address_ex	varchar2(100)		NULL,
	s_delivery_request	varchar2(150)		NULL
);

ALTER TABLE subscription ADD CONSTRAINT fk_s_card_info_no FOREIGN KEY (card_info_no)REFERENCES card_info (card_info_no);
ALTER TABLE subscription ADD CONSTRAINT fk_s_s_product_code FOREIGN KEY (s_product_code)REFERENCES subscription_product (s_product_code);
ALTER TABLE subscription ADD CONSTRAINT fk_s_member_id FOREIGN KEY (member_id)REFERENCES member (member_id);
-- check 조건 추가
alter table subscription add constraint ck_s_s_delay_yn check(s_delay_yn in ('Y', 'N'));
-- 정기구독 취소여부 컬럼 추가 9/13
alter table subscription add s_quit_yn varchar2(1) default 'N';
alter table subscription add constraint ck_s_s_quit_yn check(s_quit_yn in ('Y', 'N'));
-- 결제예정일 컬럼 추가 9/15
alter table subscription add s_payment_date date;

CREATE TABLE subscription_order (
	s_order_no	varchar2(100)		NOT NULL,
	s_no	varchar2(100)		NOT NULL,
	s_times	number		NOT NULL,
	s_price	number		NOT NULL,
	s_order_date	date		NOT NULL,
	s_order_status	varchar2(20)		NOT NULL
);
ALTER TABLE subscription_order ADD CONSTRAINT fk_s_o_s_no FOREIGN KEY (s_no)REFERENCES subscription (s_no);
-- 제약조건 default 추가 9/11
alter table subscription_order modify s_order_status default '상품준비중';
alter table subscription_order modify s_order_date default current_date;
alter table subscription_order modify s_times default 1;
-- 컬럼추가(기존 정보를 insert하기때문에 null로 진행) 9/15
alter table subscription_order add so_card_info_no number;
alter table subscription_order add so_product_code varchar2(6);
alter table subscription_order add so_exclude_vegs varchar2(500);
alter table subscription_order add so_delivery_cycle number;
alter table subscription_order add so_delay_yn varchar2(1);
alter table subscription_order add so_recipient varchar2(100);
alter table subscription_order add so_phone varchar2(11);
alter table subscription_order add so_address varchar2(100);
alter table subscription_order add so_address_ex varchar2(100);
alter table subscription_order add so_delivery_request varchar2(150);
-- 컬럼명 변경 9/15
alter table subscription_order add so_next_delivery_date date;
alter table subscription_order rename column so_next_delivery_date TO so_delivery_date;
-- fk 제약조건 삭제 9/15
ALTER TABLE subscription_order drop CONSTRAINT fk_s_o_s_no;
-- 컬럼추가 9/20
alter table subscription_order add so_delivery_completed_date date;

CREATE TABLE subscription_review (
	s_review_no	varchar2(100)		NOT NULL,
	s_order_no	varchar2(100)		NOT NULL,
	s_review_title	varchar2(255)		NOT NULL,
	s_review_content	varchar2(2000)		NOT NULL,
	s_review_star	number		NOT NULL,
	s_review_recommend_num	number	DEFAULT 0	NULL,
	s_review_created_at	date	DEFAULT current_date	NULL,
	s_review_updated_at	date		NULL
);
ALTER TABLE subscription_review ADD CONSTRAINT fk_s_r_s_order_no FOREIGN KEY (s_order_no)REFERENCES subscription_order (s_order_no);
-- 정기구독 리뷰 시퀀스 생성(9/6)
create sequence seq_s_review_no nocache;

CREATE TABLE subscription_review_attachment (
	s_attach_no	number	NOT NULL,
	s_review_no	varchar2(100)		NOT NULL,
	s_review_origin_filename	varchar2(256)		NOT NULL,
	s_review_renamed_filename	varchar2(256)		NOT NULL,
	s_review_created_at	date	DEFAULT current_date	NULL
);
ALTER TABLE subscription_review_attachment ADD CONSTRAINT fk_s_r_a_s_review_no FOREIGN KEY (s_review_no)REFERENCES subscription_review (s_review_no);
-- 컬럼명 변경(s_review_origin_filename -> s_review_original_filename)(9/7)
ALTER TABLE subscription_review_attachment RENAME COLUMN s_review_origin_filename TO s_review_original_filename;
-- 제약조건 제거 후 새로 생성(9/21)
ALTER TABLE subscription_review_attachment DROP CONSTRAINT fk_s_r_a_s_review_no;
ALTER TABLE subscription_review_attachment ADD CONSTRAINT fk_s_r_a_s_review_no FOREIGN KEY (s_review_no)REFERENCES subscription_review (s_review_no) on delete cascade;

create sequence seq_s_attach_no;
-- 시퀀스 증가 오류 방지(9/2)
alter sequence seq_s_attach_no nocache;

-- 회원별 정기구독후기 추천 목록 테이블 생성(9/13)
CREATE TABLE recommended_subscription_review (
	member_id	varchar2(100)		NOT NULL,
	s_review_no	varchar2(100)		NOT NULL
);
ALTER TABLE recommended_subscription_review ADD CONSTRAINT PK_RECOMMENDED_SUBSCRIPTION_REVIEW PRIMARY KEY (member_id, s_review_no);
ALTER TABLE recommended_subscription_review ADD CONSTRAINT fk_r_s_r_member_id FOREIGN KEY (member_id) REFERENCES member (member_id);
ALTER TABLE recommended_subscription_review ADD CONSTRAINT fk_r_s_r_s_review_no FOREIGN KEY (s_review_no) REFERENCES subscription_review (s_review_no);

CREATE TABLE vegetables (
	veg_code	varchar2(30)		NOT NULL,
	veg_category	varchar2(50)		NOT NULL,
	veg_name	varchar2(100)		NOT NULL
);

CREATE TABLE subscription_week_vegs (
	week_criterion	varchar2(6)		NOT NULL,
	veg_composition	varchar2(500)		NOT NULL
);

CREATE TABLE subscription_product (
	s_product_code	varchar2(6)		NOT NULL,
	s_product_name	varchar2(30)		NOT NULL,
	s_product_price	number		NOT NULL
);
-- 고정배송비 컬럼 추가
alter table subscription_product add s_delivery_fee number default 3000;
-- 상품설명 컬럼 추가
alter table subscription_product add s_product_info varchar2(300);

CREATE TABLE card_info (
	card_info_no	number		NOT NULL,
	card_no	varchar2(16)		NOT NULL, -- null
	card_expire_date	varchar2(12)		NOT NULL, -- null
	card_birth_date	varchar2(12)		NOT NULL, -- null
	card_password	varchar2(2)		NOT NULL, -- null
	customer_uid	varchar2(100)		NOT NULL
);
-- 카드 info 시퀀스 추가 및 증가 오류 방지(9/2)
create sequence seq_card_info_no;
alter sequence seq_card_info_no nocache;
-- 유니크제약조건 추가(9/2)
alter table card_info add unique(customer_uid);
-- 제약조건 변경 추가(9/5)
alter table card_info modify card_expire_date null;
alter table card_info modify card_birth_date null;
alter table card_info modify card_password null;
alter table card_info modify card_no null;

ALTER TABLE subscription ADD CONSTRAINT PK_SUBSCRIPTION PRIMARY KEY (s_no);
ALTER TABLE subscription_review ADD CONSTRAINT PK_SUBSCRIPTION_REVIEW PRIMARY KEY (s_review_no);
ALTER TABLE subscription_review_attachment ADD CONSTRAINT PK_SUBSCRIPTION_REVIEW_ATTACHMENT PRIMARY KEY (s_attach_no);
ALTER TABLE subscription_week_vegs ADD CONSTRAINT PK_SUBSCRIPTION_WEEK_VEGS PRIMARY KEY (week_criterion);
ALTER TABLE subscription_product ADD CONSTRAINT PK_SUBSCRIPTION_PRODUCT PRIMARY KEY (s_product_code);
ALTER TABLE vegetables ADD CONSTRAINT PK_VEGETABLES PRIMARY KEY (veg_code);
ALTER TABLE subscription_order ADD CONSTRAINT PK_SUBSCRIPTION_ORDER PRIMARY KEY (s_order_no);
ALTER TABLE card_info ADD CONSTRAINT PK_CARD_INFO PRIMARY KEY (card_info_no);
-- faq 생성(9/13)
CREATE TABLE faq (
	faq_no number NOT NULL,
	faq_type varchar2(1) NOT NULL,
	faq_title varchar2(100) NOT NULL,
        faq_content varchar2(1000),
        constraint pk_faq_no primary key(faq_no)
);
create sequence seq_faq_no;
alter sequence seq_faq_no nocache;
-- 정기구독 끝

-- 직거래 시작
CREATE TABLE direct_product (
	d_product_no	varchar2(100)		NOT NULL,
	member_id	varchar2(100)		NOT NULL,
	d_product_name	varchar2(100)		NOT NULL,
	d_product_content	clob		NOT NULL,
	d_product_created_at	date	DEFAULT current_date	NULL,
	d_product_updated_at	date		NULL,
	constraint pk_direct_product primary key(d_product_no),
	constraint fk_member_id_01 foreign key(member_id) references member(member_id)
);

ALTER TABLE direct_product ADD d_default_price number;
alter table direct_product add d_delivery_fee number default 3000 null;
-- 민지: 상품 테이블 배송비 추가했습니다(9/13)

CREATE TABLE direct_product_attachment (
	d_product_attach_no	number		NOT NULL,
	d_product_no	varchar2(100)		NOT NULL,
	d_product_original_filename	varchar2(255)		NULL,
	d_product_renamed_filename	varchar2(255)		NULL,
	constraint pk_direct_product_attachment primary key(d_product_attach_no),
	constraint fk_d_product_no_02 foreign key(d_product_no) references direct_product(d_product_no)
);

CREATE TABLE direct_product_option (
	d_option_no	varchar2(100)		NOT NULL,
	d_product_no	varchar2(100)		NOT NULL,
	d_option_name	varchar2(100)		NULL,
	d_sale_status	varchar2(100)		NULL,
	d_price	number		NULL,
	d_stock	number		NULL,
	constraint pk_direct_product_option_no primary key(d_option_no),
	constraint fk_direct_product_option_no foreign key(d_product_no) references direct_product(d_product_no)
);

CREATE TABLE direct_order (
	d_order_no	varchar2(100)		NOT NULL,
	member_id	varchar2(100)		NOT NULL,
	d_total_price	number		NOT NULL,
	d_dest_address	varchar2(100)		NOT NULL,
	d_dest_address_ex	varchar2(100)		NULL,
	d_delivery_request	varchar2(150)		NULL,
	d_recipient	varchar2(50)		NOT NULL,
	d_order_phone	varchar2(11)		NOT NULL,
	d_order_date	date	DEFAULT current_date	NOT NULL,
	d_payments	varchar2(10)		NOT NULL,
	d_order_status	varchar2(30)	DEFAULT 'P'	NOT NULL,
	constraint pk_direct_order_no primary key(d_order_no),
	constraint fk_direct_order_member_id foreign key(member_id) references member(member_id),
	constraint ck_direct_order_status check(d_order_status in ('P', 'R', 'C', 'D', 'F'))
);

--주문취소로 재고 복구처리시 판매상태 변경하는 트리거
create trigger trigger_stock_update_by_cancel 
    after
    update on direct_product_option
    for each row
begin
    if :new.d_stock > 0 and :new.d_sale_status not like '판매중단' then
        update direct_product_option set d_sale_status = '판매중';
    end if;
end;
/

CREATE TABLE member_direct_order (
	d_option_no	varchar2(100)		NOT NULL,
	d_order_no	varchar2(100)		NOT NULL,
	d_option_count	number		NOT NULL,
	constraint pk_member_direct_option_order_no primary key(d_option_no,d_order_no)
);
--수진: 회원 주문옵션 테이블에 상품번호컬럼 추가했습니다!
alter table member_direct_order add d_product_no varchar2(100) not null;

CREATE TABLE cart (
	cart_no	varchar2(100)		NOT NULL,
	d_option_no	varchar2(100)		NOT NULL,
	member_id	varchar2(100)		NOT NULL,
	product_count	number		NULL,
	constraint pk_cart primary key(cart_no),
	constraint fk_d_option_no_01 foreign key(d_option_no) references direct_product_option(d_option_no),
	constraint fk_member_id_03 foreign key(member_id) references member(member_id)
);

CREATE TABLE direct_inquire (
	d_inquire_no	varchar2(100)		NOT NULL,
	d_product_no	varchar2(100)		NOT NULL,
	member_id	varchar2(100)		NOT NULL,
	inquire_title	varchar2(255)		NULL,
	content	 varchar2(2000)		NOT NULL,
	created_at	date	DEFAULT current_date	NULL,
	has_answer	varchar2(1)	DEFAULT 'N'	NULL,--컬럼명, 값 YN타입으로 변경
    
	constraint pk_direct_inquire  primary key(d_inquire_no),
	constraint fk_d_product_no_01 foreign key(d_product_no) references direct_product(d_product_no),
	constraint fk_member_id_02 foreign key(member_id) references member(member_id)
);

CREATE TABLE direct_inquire_answer (
	d_inquire_no	varchar2(100)		NOT NULL,
	d_inquire_a_content	varchar2(2000)		NOT NULL,
	d_inquire_answered_at	date	DEFAULT current_date	NULL,
	constraint fk_d_inquire_no_01 foreign key(d_inquire_no) references direct_inquire(d_inquire_no)
);

CREATE TABLE direct_review (
	d_review_no	varchar2(100)	NOT NULL,
	d_option_no	varchar2(100)		NOT NULL,
	d_order_no	varchar2(100)		NOT NULL,
	d_review_title	varchar2(512)		NOT NULL,
	member_id	varchar2(100)		NOT NULL,
	d_review_content	varchar2(2000)		NOT NULL,
	review_rating	number	DEFAULT 5	NULL,
	d_review_recommend	number	DEFAULT 0	NULL,
	d_review_created_at	date	DEFAULT current_date	NULL,
	d_review_updated_at	date		NULL,
	constraint pk_direct_review_no primary key(d_review_no),
	constraint fk_direct_option_order_no foreign key(d_option_no, d_order_no) references member_direct_order(d_option_no, d_order_no),
	constraint ck_direct_review_rating check(review_rating in ('1', '2', '3', '4', '5'))
);

CREATE TABLE direct_review_attachment (
	d_review_attach_no	number NOT NULL,
	d_review_no	varchar2(100) NOT NULL,
	d_review_original_filename	varchar2(256)		NOT NULL,
	d_review_renamed_filename	varchar2(256)		NOT NULL,
	d_review_created_at	date	DEFAULT current_date	NULL,
	constraint pk_direct_review_attachment_no primary key(d_review_attach_no),
	constraint fk_direct_review_no foreign key(d_review_no) references direct_review(d_review_no)
);
--0922 수아 - fk 삭제 후, 다시 추가 (on delete cascade)
alter table direct_review_attachment drop constraint fk_direct_review_no;
alter table direct_review_attachment add constraint fk_direct_review_no foreign key(d_review_no) 
references direct_review(d_review_no) on delete cascade;

create sequence seq_d_product_no;
create sequence seq_d_product_attach_no;
create sequence seq_d_option_no;
create sequence seq_cart_no;
create sequence seq_d_inquire_no;
create sequence seq_d_review_no;
create sequence seq_d_review_attach_no;
commit;
-- 직거래 끝

--security remember-me 테이블
create table persistent_logins (
        username varchar(64) not null, 
        series varchar(64) primary key, 
        token varchar(64) not null,
        last_used timestamp not null);
        