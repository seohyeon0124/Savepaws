# 🐱 세이브포스 Savepaws

<br>

## 프로젝트 소개

- 본 프로젝트는 Java 프로그래밍 언어와 Oracle 데이터베이스를 활용한 키오스크 시스템 개발을 목표로 하였습니다.
- 이 시스템은 고객이 손쉽게 정보를 조회하고, 주문을 진행할 수 있는 통합 솔루션을 제공합니다.
- 또한 관리자 화면에서는 고객의 주문내역 및 매출, 메뉴 관리, 쿠폰 관리 등의 기능을 이용할 수 있도록 제작하였습니다.

<br>

## 1. 개발 환경

- 개발 인원 : 1명
- 개발 기간 : 2024-04-23 ~ 2024-05-08
- 프로그래밍 언어 : Java, JavaScript, JSP
- GUI 프레임워크 : Bootstrap, jQuery
- 데이터베이스 : Oracle

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

- 결제 작업을 못했기 때문에 관련 API를 활용하여 돈이 입출금되는 과정을 구현해야 할 것입니다.
- 주문 내역에 따라 사용되는 자재 및 재료의 재고를 계산하여 물품 관리를 함께 진행할 수 있도록 관리자 기능을 추가하고 싶습니다. 

<br>

## 5. 프로젝트 후기

 첫 번째 자바 프로젝트를 완성도 있게 진행하기 위해, 반년 이상 아르바이트를 하며 익숙해진 햄버거 가게 키오스크를 구현했습니다. 이 과정은 그동안 배운 문법과 기술들을 실제로 활용할 수 있는 귀중한 기회였습니다. 프로젝트 진행 중 DB 수정이나 계획 변경을 경험하면서, 코드 작성만큼이나 사전 계획이 중요하다는 것을 깨달았습니다. 또한, Swing에 대해 처음 알게 되었고, 관련 자료가 많지 않아 진행 속도가 더뎌지기도 했습니다. 하지만 이러한 어려움을 극복하며 원하는 결과물을 만들어낸 경험은 저에게 큰 성장의 기회가 되었습니다.
