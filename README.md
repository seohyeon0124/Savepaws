# 🐱 세이브포스 Savepaws

<br>

## 프로젝트 소개

- 세이브포스는 유기동물의 입양을 촉진하고, 입양 후기를 공유하며, 지역사회의 중고 물건을 나눔할 수 있는 플랫폼입니다.
- 이 웹사이트는 Java, JSP, HTML, CSS, Oracle, jQuery 등의 기술 스택을 활용하여 개발되었습니다.
- 관리자는 유기동물을 등록할 수 있고, 사용자는 입양 신청을 하며, 다양한 커뮤니티 활동에 참여할 수 있습니다.

<br>

## 기대 효과

- 세이브포스는 유기동물 입양을 장려하고, 지역 사회의 나눔 문화를 촉진하는 것을 목표로 합니다.
- 사용자들은 서로의 경험을 공유하며, 유기동물에게 따뜻한 가정을 제공할 수 있는 기회를 가집니다.
- 또한, 중고 물건 나눔을 통해 자원의 효율적인 사용과 환경 보호에도 기여할 수 있습니다.

<br>

## 1. 개발 환경

- 개발 인원 : 1명
- 개발 기간 : 2024-04-23 ~ 2024-05-08
- 프론트엔드 : HTML, CSS, jQuery
- 백엔드 : Java, JSP
- 데이터베이스 : Oracle
- 기타 : AJAX를 활용한 비동기 통신 구현으로 사용자 경험 향상

<br>

## 2. 프로젝트 구조

```
├─README.md
└─ Project_jsh
   ├─ .classpath
   ├─ .project
   ├─ .settings
   ├─ build
   └─ src
      └─ main
         ├─ java
         │  └─ my
         │     ├─ animal
         │     │  ├─ AnicateBean.java
         │     │  ├─ AnicateDao.java
         │     │  ├─ AnimalBean.java
         │     │  ├─ AnimalDao.java
         │     │  ├─ RequestBean.java
         │     │  └─ RequestDao.java
         │     ├─ free
         │     │  ├─ FreeBean.java
         │     │  └─ FreeDao.java
         │     ├─ member
         │     │  ├─ MemberBean.java
         │     │  └─ MemberDao.java
         │     ├─ review
         │     │  ├─ ReviewBean.java
         │     │  └─ ReviewDao.java
         │     └─ store
         │        ├─ StoreBean.java
         │        ├─ StoreDao.java
         │        ├─ StorecateBean.java
         │        └─ StorecateDao.java
         └─ webapp
            ├─ META-INF
            ├─ WEB-INF
            │  └─ lib
            │     ├─ commons-collections-3.1.jar
            │     ├─ commons-dbcp-1.2.1.jar
            │     ├─ commons-pool-1.2.jar
            │     ├─ cos.jar
            │     ├─ gson-2.8.5.jar
            │     ├─ json-simple-1.1.1.jar
            │     ├─ ojdbc8.jar
            │     └─ servlet-api.jar
            ├─ admin
            │  ├─ admin.jsp
            │  ├─ admin_bottom.jsp
            │  ├─ admin_top.jsp
            │  ├─ aniCate.jsp
            │  ├─ animalList.jsp
            │  ├─ animalProc.jsp
            │  ├─ animalUser.jsp
            │  ├─ animalView.jsp
            │  ├─ blog.css
            │  ├─ cateProc.jsp
            │  ├─ deleteAnimal.jsp
            │  ├─ deleteCate.jsp
            │  ├─ deleteStore.jsp
            │  ├─ inputAnimal.jsp
            │  ├─ inputCate.jsp
            │  ├─ inputStore.jsp
            │  ├─ requestProc.jsp
            │  ├─ storeCate.jsp
            │  ├─ storeList.jsp
            │  ├─ storeProc.jsp
            │  ├─ storeView.jsp
            │  ├─ updateAnimal.jsp
            │  ├─ updateAnimalProc.jsp
            │  ├─ updateStore.jsp
            │  ├─ updateStoreProc.jsp
            │  └─ userList.jsp
            ├─ animal
            │  ├─ aniRequest.jsp
            │  ├─ aniRequestAll.jsp
            │  ├─ anilike.jsp
            │  ├─ anilikeBtn.jsp
            │  ├─ animal.jsp
            │  ├─ animalView.jsp
            │  ├─ animal_top.jsp
            │  ├─ blog.css
            │  ├─ delAnilike.jsp
            │  └─ delRequest.jsp
            ├─ free
            │  ├─ blog.css
            │  ├─ delFree.jsp
            │  ├─ free.jsp
            │  ├─ freeView.jsp
            │  ├─ free_around.jsp
            │  ├─ free_input.jsp
            │  ├─ free_inputProc.jsp
            │  ├─ free_my.jsp
            │  ├─ free_place.jsp
            │  ├─ free_thing.jsp
            │  ├─ free_top.jsp
            │  ├─ free_want.jsp
            │  └─ map.js
            ├─ introduce
            │  ├─ carousel.css
            │  └─ introduce.jsp
            ├─ member
            │  ├─ checkEmailProc.jsp
            │  ├─ findid.jsp
            │  ├─ findidProc.jsp
            │  ├─ findpw.jsp
            │  ├─ findpwProc.jsp
            │  ├─ login.jsp
            │  ├─ loginProc.jsp
            │  ├─ logout.jsp
            │  ├─ naverLogin.jsp
            │  ├─ register.jsp
            │  ├─ registerProc.jsp
            │  └─ signin.css
            ├─ review
            │  ├─ review.jsp
            │  ├─ reviewProc.jsp
            │  ├─ review_delete.jsp
            │  ├─ review_form.jsp
            │  ├─ review_top.jsp
            │  ├─ review_update.jsp
            │  ├─ review_updateProc.jsp
            │  └─ review_view.jsp
            ├─ store
            │  ├─ blog.css
            │  ├─ store.jsp
            │  └─ store_top.jsp
            ├─ js
            ├─ img
            ├─ main.css
            ├─ main.jsp
            ├─ top.jsp
            ├─ bottom.jsp
            ├─ carousel.css
            ├─ memo.txt
            └─ 이미지
```

<br>

## 3. 기능

### 🌱 사용자 화면

#### [메뉴확인]
- 처음에 매장 식사인지, 포장해서 가져가는 것인지 선택해야합니다.
- 메뉴판에서 매장 내의 모든 메뉴와 가격 정보를 확인할 수 있습니다.
- 메뉴판은 여섯가지 카테고리별로 보기 쉽게 구성되어 있습니다.

#### [메뉴선택]
- 메뉴 이미지를 선택하여 장바구니에 담을 수 있으며, 선택시마다 수량이 올라갑니다.
- 수량조절은 우측 하단의 +/- 버튼을 통해서도 가능합니다.
- 전체취소 버튼 클릭시 장바구니가 모두 비워집니다.
- 장바구니에 담긴 메뉴의 총금액은 하단에 표시됩니다.

#### [쿠폰사용]
- 쿠폰사용 버튼을 눌러 발급받은 쿠폰 코드 입력을 통해 쿠폰을 사용할 수 있습니다.
- 올바르지 않은 쿠폰 코드는 사용할 수 없으며, 성공적으로 사용되었을 경우 장바구니에 추가됩니다.

#### [주문하기]
- 메뉴를 담은 뒤 주문하기 버튼을 통해 결제를 진행할 수 있습니다.
- 주문시 해당 주문내역의 주문번호가 안내됩니다.

### 🌱 관리자 화면

#### [관리자 화면 접속]
- 관리자는 첫 화면의 상단 부분을 클릭하여 관리자 화면에 접속할 수 있습니다.
- 설정되어있는 관리자 비밀번호를 올바르게 입력하면 접속에 성공할 수 있습니다.
  
#### [주문관리]
- 고객의 주문 내역을 조회할 수 있습니다. 주문 내역에는 주문 번호, 상품, 수량, 금액, 날짜, 방식(포장/매장) 등이 포함됩니다. (조회)
- 오늘/이번주/이번달 날짜에 따른 주문 내역 조회가 가능합니다. (필터)
- 주문 번호, 상품, 날짜에 따라 정렬된 주문 내역 조회가 가능합니다. (정렬)
- 원하는 조회 방식에 따른 총 매출이 하단에 표시됩니다.
- 삭제 버튼을 통해 원하는 주문 내역 정보를 삭제할 수 있습니다. (삭제)

#### [메뉴관리]
- 매장 내의 모든 메뉴를 조회할 수 있습니다. 메뉴 정보에는 상품 코드, 카테고리 분류, 상품명, 가격 등이 포함됩니다. (조회)
- 메뉴판의 여섯가지 카테고리별로 메뉴 조회가 가능합니다. (필터)
- 상품코드, 카테고리 분류, 상품명, 가격에 따라 정렬된 주문 내역 조회가 가능합니다. (정렬)
- 추가 버튼을 통해 원하는 메뉴 정보를 추가할 수 있습니다. 이때 상품분류, 상품명, 상품가격, 이미지를 반드시 선택해야하며, 상품 코드는 상품 분류에 따라 자동으로 입력됩니다. (추가)
- 변경 버튼을 통해 원하는 메뉴 정보를 수정할 수 있습니다. (수정)
- 삭제 버튼을 통해 원하는 메뉴 정보를 삭제할 수 있습니다. (삭제)
- 메뉴 정보 추가/변경/삭제시 결과는 사용자 화면에서 바로 확인 가능합니다.

#### [쿠폰관리]
- 주문시 사용가능한 쿠폰 관련 정보를 조회할 수 있습니다. 쿠폰 정보에는 쿠폰코드, 상품명, 유효기간이 포함됩니다. (조회)
- 기간에 따라 사용가능/불가능으로 나누어 조회가 가능합니다. (필터)
- 쿠폰코드, 상품명, 유효기간에 따라 정렬된 쿠폰 조회가 가능합니다. (정렬)
- 추가 버튼을 통해 원하는 쿠폰 정보를 추가할 수 있습니다. 이때 쿠폰코드, 상품명, 유효기간을 반드시 선택해야합니다. (추가)
- 변경 버튼을 통해 원하는 쿠폰 정보를 수정할 수 있습니다. (수정)
- 삭제 버튼을 통해 원하는 쿠폰 정보를 삭제할 수 있습니다. (삭제)

<br><br>

## 4. 개선할 부분

- 사용자들이 질문이나 건의사항을 남길 수 있는 문의 게시판 기능을 추가하여, 커뮤니티의 소통을 강화하고 사용자 지원을 개선해야 합니다.
- 로그인 없이 접근이 필요한 기능에 대해 자동으로 로그인 화면으로 이동하도록 설정하여, 사용자들이 필요한 서비스를 원활하게 이용할 수 있도록 해야 합니다. 이를 통해 사용자 경험을 향상시키고 보안성을 높입니다.

<br>

## 5. 프로젝트 후기

세이브포스 프로젝트는 기술적 도전과 사회적 가치를 동시에 추구할 수 있는 기회였습니다. 유기동물과 지역 사회에 긍정적인 영향을 미칠 수 있는 프로젝트라는 점이 매우 뿌듯했습니다. 
Java, JSP, Oracle 등 다양한 기술을 활용하면서 실무 경험을 쌓을 수 있었고, 특히 데이터베이스와의 연동 및 비동기 통신을 구현하는 과정에서 많은 것을 배웠습니다.
앞으로는 사용자 피드백을 반영하여 웹사이트를 발전시켜 나갈 수 있도록 노력할 것입니다.
