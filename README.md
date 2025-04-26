텍스트의 한자를 한글로 변환해 드리겠습니다:

<div align="center">
   <img alt="logo" width="100" height="100" src="https://foruda.gitee.com/images/1733417239320800627/3c5290fe_716974.png">
   <h2>youlai-boot</h2>
   <img alt="유라이 기술" src="https://img.shields.io/badge/Java -17-brightgreen.svg"/>
   <img alt="유라이 기술" src="https://img.shields.io/badge/SpringBoot-3.3.6-green.svg"/>
   <a href="https://gitee.com/youlaiorg/youlai-boot" target="_blank">
     <img alt="유라이 기술" src="https://gitee.com/youlaiorg/youlai-boot/badge/star.svg"/>
   </a>     
   <a href="https://github.com/haoxianrui/youlai-boot" target="_blank">
     <img alt="유라이 기술" src="https://img.shields.io/github/stars/haoxianrui/youlai-boot.svg?style=social&label=Stars"/>
   </a>
   <br/>
   <img alt="유라이 기술" src="https://img.shields.io/badge/license-Apache%20License%202.0-blue.svg"/>
   <a href="https://gitee.com/youlaiorg" target="_blank">
     <img alt="유라이 기술" src="https://img.shields.io/badge/Author-유라이 오픈소스 조직-orange.svg"/>
   </a>
</div>

![](https://raw.gitmirror.com/youlaitech/image/main/docs/rainbow.png)

<div align="center">
  <a target="_blank" href="https://vue.youlai.tech/">🖥️ 온라인 미리보기</a> |  <a target="_blank" href="https://youlai.blog.csdn.net/article/details/145178880">📑 문서 읽기</a> |  <a target="_blank" href="https://www.youlai.tech/youlai-boot">🌐 공식 사이트</a>
</div>

## 📢 프로젝트 소개

JDK 17, Spring Boot 3, Spring Security 6, JWT, Redis, Mybatis-Plus, Vue 3, Element-Plus 기반으로 구축된 프론트엔드와 백엔드가 분리된 단일 권한 관리 시스템. [Mybatis-Flex 버전](https://gitee.com/youlaiorg/youlai-boot-flex)

- **🚀 개발 프레임워크**: Spring Boot 3와 Vue 3, Element-Plus 등 주류 기술 스택을 사용하여 실시간으로 업데이트됩니다.

- **🔐 보안 인증**: Spring Security 6 원천 아키텍처 기반, JWT 토큰 자동 갱신(무상태)과 Redis 세션 다중 기기 상호 배타적 관리(실시간 강제 오프라인) 이중 인증 메커니즘을 통합하여 기업급 신원 보안 중추를 구축합니다.

- **🔑 권한 관리**: RBAC 모델 기반으로 인터페이스 메소드와 버튼 수준의 세밀한 권한 제어를 구현합니다.

- **🛠️ 기능 모듈**: 사용자 관리, 역할 관리, 메뉴 관리, 부서 관리, 사전 관리 등의 기능을 포함합니다.

## 🌈 프로젝트 소스코드

| 프로젝트 유형       | Gitee                                                         | Github                                                        | GitCode                                                      |
| --------------| ------------------------------------------------------------  |  ------------------------------------------------------------ | ------------------------------------------------------------ |
| ✅ Java 백엔드  | [youlai-boot](https://gitee.com/youlaiorg/youlai-boot)       | [youlai-boot](https://github.com/haoxianrui/youlai-boot)    | [youlai-boot](https://gitcode.com/youlai/youlai-boot)        |
| vue3 프론트엔드     | [vue3-element-admin](https://gitee.com/youlaiorg/vue3-element-admin) | [vue3-element-admin](https://github.com/youlaitech/vue3-element-admin) | [vue3-element-admin](https://gitcode.com/youlai/vue3-element-admin) |
| uni-app 모바일     | [vue-uniapp-template](https://gitee.com/youlaiorg/vue-uniapp-template) | [vue-uniapp-template](https://github.com/youlaitech/vue-uniapp-template) | [vue-uniapp-template](https://gitcode.com/youlai/vue-uniapp-template) |



## 📚 프로젝트 문서

| 문서 이름          | 접속 주소                                                                                   |
|---------------|-------------------------------------------------------------------------------------------|
| 온라인 인터페이스 문서        | [https://www.apifox.cn/apidoc](https://www.apifox.cn/apidoc/shared-195e783f-4d85-4235-a038-eec696de4ea5) |
| 프로젝트 소개 및 사용 가이드     | [https://www.youlai.tech/youlai-boot/](https://www.youlai.tech/youlai-boot/)              |
| 기능 상세 설명 및 작동 매뉴얼     | [https://youlai.blog.csdn.net/article/details/145178880](https://youlai.blog.csdn.net/article/details/145178880) |
| 입문자 가이드(프로젝트 0에서 1까지) | [https://youlai.blog.csdn.net/article/details/145177011](https://youlai.blog.csdn.net/article/details/145177011) |


## 📁 프로젝트 디렉토리


<details>
<summary> 디렉토리 구조 </summary>

<br>

```
youlai-boot
├── docker                              # Docker 디렉토리
│   ├── docker-compose.yml              # docker-compose 스크립트
├── sql                                 # SQL 스크립트
│   ├── mysql                           # MySQL 스크립트
├── src                                 # 소스코드 디렉토리
│   ├── common                          # 공통 모듈
│   │   ├── annotation                  # 어노테이션 정의
│   │   ├── base                        # 기본 클래스
│   │   ├── constant                    # 상수
│   │   ├── enums                       # 열거형 타입
│   │   ├── exception                   # 예외 처리
│   │   ├── model                       # 데이터 모델
│   │   ├── result                      # 결과 래핑
│   │   └── util                        # 유틸리티 클래스
│   ├── config                          # 자동 설정 구성
│   │   └── property                    # 설정 속성 디렉토리
│   ├── core                            # 핵심 기능
│   │   ├── aspect                      # 관점(로그, 중복 제출 방지)
│   │   ├── filter                      # 필터(요청 로그, 제한)
│   │   ├── handler                     # 핸들러(데이터 권한, 데이터 채우기)
│   │   └── security                    # Spring Security 보안 모듈
│   ├── modules                         # 비즈니스 모듈
│   │   ├── member                      # 회원 모듈【비즈니스 모듈 데모】
│   │   ├── order                       # 주문 모듈【비즈니스 모듈 데모】
│   │   ├── product                     # 상품 모듈【비즈니스 모듈 데모】
│   ├── shared                          # 공유 모듈
│   │   ├── auth                        # 인증 모듈
│   │   ├── file                        # 파일 모듈
│   │   ├── codegen                     # 코드 생성 모듈
│   │   ├── mail                        # 메일 모듈
│   │   ├── sms                         # SMS 모듈
│   │   └── websocket                   # WebSocket 모듈
│   ├── system                          # 시스템 모듈
│   │   ├── controller                  # 컨트롤러 계층
│   │   ├── converter                   # MapStruct 변환기
│   │   ├── event                       # 이벤트 처리
│   │   ├── handler                     # 핸들러
│   │   ├── listener                    # 리스너
│   │   ├── model                       # 모델 계층
│   │   │   ├── bo                      # 비즈니스 객체
│   │   │   ├── dto                     # 데이터 전송 객체
│   │   │   ├── entity                  # 엔티티 객체
│   │   │   ├── form                    # 폼 객체
│   │   │   ├── query                   # 쿼리 매개변수 객체
│   │   │   └── vo                      # 뷰 객체
│   │   ├── mapper                      # 데이터베이스 액세스 계층
│   │   └── service                     # 비즈니스 로직 계층
│   └── YouLaiBootApplication           # 시작 클래스
└── end                             
```
</details>



## 🚀 프로젝트 시작

📚 전체 프로세스 참조: [프로젝트 시작](https://www.youlai.tech/youlai-boot/1.%E9%A1%B9%E7%9B%AE%E5%90%AF%E5%8A%A8/)

1. **프로젝트 클론**

   ```bash
   git clone https://gitee.com/youlaiorg/youlai-boot.git
   ```

2. **데이터베이스 초기화**

   [youlai_boot.sql](sql/mysql/youlai_boot.sql) 스크립트를 실행하여 데이터베이스 생성, 테이블 구조 및 기본 데이터 초기화를 완료합니다.

3. **설정 수정**

   기본적으로 '유라이' 온라인 MySQL/Redis(읽기 권한만)에 연결됩니다. 로컬 개발 시 [application-dev.yml](src/main/resources/application-dev.yml)의 MySQL 및 Redis 연결 정보를 수정하세요.

4. **프로젝트 시작**

   [YoulaiBootApplication.java](src/main/java/com/youlai/boot/YoulaiBootApplication.java)의 main 메소드를 실행하여 백엔드 프로젝트 시작을 완료하세요.

   인터페이스 문서 주소 [http://localhost:8989/doc.html](http://localhost:8989/doc.html)에 접속하여 프로젝트가 성공적으로 시작되었는지 확인하세요.


## 🚀 프로젝트 배포

공식 문서 참조: [프로젝트 배포 가이드](https://www.youlai.tech/youlai-boot/5.%E9%A1%B9%E7%9B%AE%E9%83%A8%E7%BD%B2/)


## ✅ 프로젝트 통계

![](https://repobeats.axiom.co/api/embed/544c5c0b5b3611a6c4d5ef0faa243a9066b89659.svg "Repobeats analytics image")

모든 기여자에게 감사드립니다!

[![](https://contrib.rocks/image?repo=haoxianrui/youlai-boot)](https://github.com/haoxianrui/youlai-boot/graphs/contributors)


## 💖 교류 그룹 가입

① 「유라이 기술」 공식 계정을 팔로우하고, 메뉴 **교류 그룹**을 클릭하여 그룹 QR 코드를 얻으세요(이는 광고가 그룹에 들어오는 것을 방지하기 위한 조치로, 이해와 지원에 감사드립니다).

② 또는 위챗 **`haoxianrui`**를 직접 추가하고 "프론트엔드/백엔드/풀스택"이라고 메모하세요.

![유라이 기술 공식 계정](https://foruda.gitee.com/images/1737108820762592766/3390ed0d_716974.png)
