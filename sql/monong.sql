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
	inquire_no	varchar2(100)		NOT NULL,
	member_id	varchar2(100)		NOT NULL,
	inquire_title	varchar2(512)		NOT NULL,
	inquire_content	varchar2(2000)		NULL,
	inquire_created_at	date	DEFAULT current_date	NULL,
	has_answer	varchar2(1)	DEFAULT 'N'	NULL
);

CREATE TABLE inquire_answer (
	inquire_a_no	varchar2(100)	NOT NULL,
	inquire_no	varchar2(100)		NOT NULL,
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
);

ALTER TABLE seller_info ADD CONSTRAINT FK_member_TO_seller_info_1 FOREIGN KEY (
	member_id
)
REFERENCES member (
	member_id
);

ALTER TABLE member_authority ADD CONSTRAINT FK_member_TO_member_authority_1 FOREIGN KEY (
	member_id
)
REFERENCES member (
	member_id
);
ALTER TABLE member_notification ADD CONSTRAINT FK_member_id_TO_motification FOREIGN KEY (
	member_id
) 
REFERENCES member
(
	member_id
);
--회원관련 시퀀스
create sequence seq_noti_no;
create sequence seq_seller_attach_no;
create sequence seq_inquire_no;
create sequence seq_inquire_a_no;

--회원관련 테이블 끝

CREATE TABLE "direct_product" (
	"d_product_no"	varchar2(100)		NOT NULL,
	"member_id"	varchar2(100)		NOT NULL,
	"d_product_name"	varchar2(100)		NOT NULL,
	"d_product_content"	clob		NOT NULL,
	"d_product_created_at"	date	DEFAULT current_date	NULL,
	"d_product_updated_at"	date		NULL
);



CREATE TABLE "direct_inquire_answer" (
	"d_inquire_no"	varchar2(100)		NOT NULL,
	"d_inquire_a_content"	varchar2(2000)		NOT NULL,
	"d_inquire_created_at"	date	DEFAULT current_date	NULL
);


CREATE TABLE "direct_order" (
	"d_order_no"	varchar2(100)		NOT NULL,
	"member_id"	varchar2(100)		NOT NULL,
	"d_total_price"	number		NOT NULL,
	"d_dest_address"	varchar2(100)		NOT NULL,
	"d_dest_address_2"	varchar2(100)		NULL,
	"d_delivery_request"	varchar2(150)		NULL,
	"d_recipient"	varchar2(50)		NOT NULL,
	"d_order_phone"	varchar2(11)		NOT NULL,
	"d_order_date"	date	DEFAULT current_date	NOT NULL,
	"d_payments"	varchar2(10)		NOT NULL,
	"d_order_status"	varchar2(30)	DEFAULT 'P'	NOT NULL
);

COMMENT ON COLUMN "direct_order"."d_total_price" IS '주문건당 총 결제금액';

COMMENT ON COLUMN "direct_order"."d_dest_address" IS '주문 페이지에서 작성한 배송지정보';

COMMENT ON COLUMN "direct_order"."d_payments" IS '카드, 카카오페이';

COMMENT ON COLUMN "direct_order"."d_order_status" IS '결제완료, 상품준비중, 주문취소, 배송중, 배송완료';

CREATE TABLE "cart" (
	"cart_no"	varchar2(100)		NOT NULL,
	"d_option_no"	varchar2(100)		NOT NULL,
	"member_id"	varchar2(100)		NOT NULL,
	"product_count"	number		NULL
);

CREATE TABLE "member_direct_order" (
	"d_option_no"	varchar2(100)		NOT NULL,
	"d_order_no"	varchar2(100)		NOT NULL,
	"d_option_count"	number		NOT NULL
);

COMMENT ON COLUMN "member_direct_order"."d_option_count" IS '옵션별 수량';

CREATE TABLE "direct_review_attachment" (
	"d_review_attach_no"	number	DEFAULT seq_attach_no.nextval	NOT NULL,
	"d_review_no"	number	DEFAULT seq_rNo.nextval	NOT NULL,
	"d_review_origin_filename"	varchar2(256)		NOT NULL,
	"d_review_renamed_filename"	varchar2(256)		NOT NULL,
	"d_review_created_at"	date	DEFAULT current_date	NULL
);

COMMENT ON COLUMN "direct_review_attachment"."d_review_attach_no" IS '직거래 후기 첨부파일 번호';

COMMENT ON COLUMN "direct_review_attachment"."d_review_no" IS '직거래 후기게시판 번호';

COMMENT ON COLUMN "direct_review_attachment"."d_review_origin_filename" IS '직거래 후기 첨부파일 기존파일이름';

COMMENT ON COLUMN "direct_review_attachment"."d_review_renamed_filename" IS '직거래 후기 첨부파일 새로운파일이름';

COMMENT ON COLUMN "direct_review_attachment"."d_review_created_at" IS '직거래 후기 첨부파일 등록일';

CREATE TABLE "direct_review" (
	"d_review_no"	varchar2(100)	DEFAULT seq_rNo.nextval	NOT NULL,
	"d_option_no"	varchar2(100)		NOT NULL,
	"d_order_no"	varchar2(100)		NOT NULL,
	"d_review_title"	varchar2(512)		NOT NULL,
	"member_id"	varchar2(100)		NOT NULL,
	"d_review_content"	varchar2(2000)		NOT NULL,
	"review_rating"	number	DEFAULT 5	NULL,
	"d_review_recommend"	number	DEFAULT 0	NULL,
	"d_review_created_at"	date	DEFAULT current_date	NULL,
	"d_review_updated_at"	date		NULL
);

COMMENT ON COLUMN "direct_review"."d_review_no" IS '직거래 후기 게시판 번호';

COMMENT ON COLUMN "direct_review"."d_review_title" IS '직거래 후기 게시판 제목';

COMMENT ON COLUMN "direct_review"."d_review_content" IS '직거래 후기 내용';

COMMENT ON COLUMN "direct_review"."review_rating" IS '직거래 후기 별점(기본값 5)';

COMMENT ON COLUMN "direct_review"."d_review_recommend" IS '직거래 후기 추천 수';

COMMENT ON COLUMN "direct_review"."d_review_created_at" IS '직거래 후기 작성일';

COMMENT ON COLUMN "direct_review"."d_review_updated_at" IS '직거래 후기 수정일(관리용)';

CREATE TABLE "direct_inquire" (
	"d_inquire_no"	varchar2(100)		NOT NULL,
	"d_product_no"	varchar2(100)		NOT NULL,
	"member_id"	varchar2(100)		NOT NULL,
	"inquire_title"	varchar2(255)		NULL,
	"content"	varchar2(2000)		NOT NULL,
	"created_at"	date	DEFAULT current_date	NULL,
	"status"	varchar2(1)	DEFAULT 'W'	NOT NULL
);

COMMENT ON COLUMN "direct_inquire"."status" IS '답변대기중, 답변완료';

CREATE TABLE "direct_product_attachment" (
	"d_product_attach_no"	number		NOT NULL,
	"d_product_no"	varchar2(100)		NOT NULL,
	"d_product_original_filename"	varchar2(255)		NULL,
	"d_product_renamed_filename"	varchar2(255)		NULL
);


CREATE TABLE "direct_product_option" (
	"d_option_no"	varchar2(100)		NOT NULL,
	"d_product_no"	number		NOT NULL,
	"d_option_name"	varchar2(100)		NULL,
	"d_sale_status"	varchar2(100)		NULL,
	"d_price"	number		NULL,
	"d_stock"	varchar2(100)		NULL
);

COMMENT ON COLUMN "direct_product_option"."d_sale_status" IS '판매중, 판매중단, 판매마감';



ALTER TABLE member ADD CONSTRAINT "PK_MEMBER" PRIMARY KEY ("member_id");

ALTER TABLE "direct_product" ADD CONSTRAINT "PK_DIRECT_PRODUCT" PRIMARY KEY ("d_product_no");

ALTER TABLE "member_notification" ADD CONSTRAINT "PK_MEMBER_NOTIFICATION" PRIMARY KEY ("noti_no");

ALTER TABLE "inquire" ADD CONSTRAINT "PK_INQUIRE" PRIMARY KEY ("inquire_no");

ALTER TABLE "inquire_answer" ADD CONSTRAINT "PK_INQUIRE_ANSWER" PRIMARY KEY ("inquire_a_no","inquire_no");

ALTER TABLE "direct_inquire_answer" ADD CONSTRAINT "PK_DIRECT_INQUIRE_ANSWER" PRIMARY KEY ("d_inquire_no");

ALTER TABLE "direct_order" ADD CONSTRAINT "PK_DIRECT_ORDER" PRIMARY KEY ("d_order_no");

ALTER TABLE "cart" ADD CONSTRAINT "PK_CART" PRIMARY KEY ("cart_no");

ALTER TABLE "member_direct_order" ADD CONSTRAINT "PK_MEMBER_DIRECT_ORDER" PRIMARY KEY ("d_option_no","d_order_no");

ALTER TABLE "direct_review_attachment" ADD CONSTRAINT "PK_DIRECT_REVIEW_ATTACHMENT" PRIMARY KEY ("d_review_attach_no");

ALTER TABLE "direct_review" ADD CONSTRAINT "PK_DIRECT_REVIEW" PRIMARY KEY ("d_review_no");

ALTER TABLE "direct_inquire" ADD CONSTRAINT "PK_DIRECT_INQUIRE" PRIMARY KEY ("d_inquire_no");

ALTER TABLE "direct_product_attachment" ADD CONSTRAINT "PK_DIRECT_PRODUCT_ATTACHMENT" PRIMARY KEY ("d_product_attach_no");

ALTER TABLE "seller_info_attachment" ADD CONSTRAINT "PK_SELLER_INFO_ATTACHMENT" PRIMARY KEY ("seller_attach_no","member_id");

ALTER TABLE "seller_info" ADD CONSTRAINT "PK_SELLER_INFO" PRIMARY KEY ("member_id");

ALTER TABLE "member_authority" ADD CONSTRAINT "PK_MEMBER_AUTHORITY" PRIMARY KEY ("auth","member_id");

ALTER TABLE "direct_product_option" ADD CONSTRAINT "PK_DIRECT_PRODUCT_OPTION" PRIMARY KEY ("d_option_no");

ALTER TABLE "inquire_answer" ADD CONSTRAINT "FK_inquire_TO_inquire_answer_1" FOREIGN KEY ("inquire_no")REFERENCES "inquire" ("inquire_no");

ALTER TABLE "direct_inquire_answer" ADD CONSTRAINT "FK_direct_inquire_TO_direct_inquire_answer_1" FOREIGN KEY ("d_inquire_no")REFERENCES "direct_inquire" ("d_inquire_no");

ALTER TABLE "member_direct_order" ADD CONSTRAINT "FK_direct_product_option_TO_member_direct_order_1" FOREIGN KEY ("d_option_no")REFERENCES "direct_product_option" ("d_option_no");

ALTER TABLE "member_direct_order" ADD CONSTRAINT "FK_direct_order_TO_member_direct_order_1" FOREIGN KEY ("d_order_no")REFERENCES "direct_order" ("d_order_no");

ALTER TABLE "seller_info_attachment" ADD CONSTRAINT "FK_seller_info_TO_seller_info_attachment_1" FOREIGN KEY ("member_id")REFERENCES "seller_info" ("member_id");

ALTER TABLE "seller_info" ADD CONSTRAINT "FK_member_TO_seller_info_1" FOREIGN KEY ("member_id")REFERENCES "member" ("member_id");

ALTER TABLE "member_authority" ADD CONSTRAINT "FK_member_TO_member_authority_1" FOREIGN KEY ("member_id")REFERENCES "member" ("member_id");

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
-- member pk설정이 안되어 있어서 보류
ALTER TABLE subscription ADD CONSTRAINT fk_s_member_id FOREIGN KEY (member_id)REFERENCES member (member_id);

CREATE TABLE subscription_order (
	s_order_no	varchar2(100)		NOT NULL,
	s_no	varchar2(100)		NOT NULL,
	s_times	number		NOT NULL,
	s_price	number		NOT NULL,
	s_order_date	date		NOT NULL,
	s_order_status	varchar2(20)		NOT NULL
);
ALTER TABLE subscription_order ADD CONSTRAINT fk_s_o_s_no FOREIGN KEY (s_no)REFERENCES subscription (s_no);

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

CREATE TABLE subscription_review_attachment (
	s_attach_no	number	NOT NULL,
	s_review_no	varchar2(100)		NOT NULL,
	s_review_origin_filename	varchar2(256)		NOT NULL,
	s_review_renamed_filename	varchar2(256)		NOT NULL,
	s_review_created_at	date	DEFAULT current_date	NULL
);
ALTER TABLE subscription_review_attachment ADD CONSTRAINT fk_s_r_a_s_review_no FOREIGN KEY (s_review_no)REFERENCES subscription_review (s_review_no);

create sequence seq_s_attach_no;

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

CREATE TABLE card_info (
	card_info_no	number		NOT NULL,
	card_no	varchar2(16)		NOT NULL,
	card_expire_date	varchar2(12)		NOT NULL,
	card_birth_date	varchar2(12)		NOT NULL,
	card_password	varchar2(2)		NOT NULL,
	customer_uid	varchar2(100)		NOT NULL
);

ALTER TABLE subscription ADD CONSTRAINT PK_SUBSCRIPTION PRIMARY KEY (s_no);
ALTER TABLE subscription_review ADD CONSTRAINT PK_SUBSCRIPTION_REVIEW PRIMARY KEY (s_review_no);
ALTER TABLE subscription_review_attachment ADD CONSTRAINT PK_SUBSCRIPTION_REVIEW_ATTACHMENT PRIMARY KEY (s_attach_no);
ALTER TABLE subscription_week_vegs ADD CONSTRAINT PK_SUBSCRIPTION_WEEK_VEGS PRIMARY KEY (week_criterion);
ALTER TABLE subscription_product ADD CONSTRAINT PK_SUBSCRIPTION_PRODUCT PRIMARY KEY (s_product_code);
ALTER TABLE vegetables ADD CONSTRAINT PK_VEGETABLES PRIMARY KEY (veg_code);
ALTER TABLE subscription_order ADD CONSTRAINT PK_SUBSCRIPTION_ORDER PRIMARY KEY (s_order_no);
ALTER TABLE card_info ADD CONSTRAINT PK_CARD_INFO PRIMARY KEY (card_info_no);
-- 정기구독 끝