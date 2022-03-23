# Inception

# 과제 내용 정리

## General guidelines

- 이 프로젝트는 `가상 머신(virtual machine)`에서 실행
- 프로젝트 구성에 필요한 모든 파일 `srcs` 폴더 안에 저장
- `Makefile`은 반드시 루트 디렉토리에 위치 (`Makefile`은 `docker-compose.yml`을 사용해서 `Docker image` 빌드)
- 도커 사용과 관련된 많은 문서 보기

## Mandatory part

- 모든 프로젝트는 `virtual-machine`에서 수행되어야 하고 `docker-compose`를 사용해야한다.
- 각 `Docker image`는 반드시 해당 서비스와 같은 이름이어야 한다.
- 각 서비스는 전용 `container`에서 실행되어야 한다.
- 성능상의 문제를 위해 `container`는 반드시 `Alpine Linux`의 안정적인 버전(최신 버전의 이전 버전)을 쓰거나 `Debian Buster`에서 만들어져야 한다. (선택은 자유)
- 한 서비스당 `Dockerfile`을 하나씩 작성해야한다. 반드시 `Makefile`로 `doecker-compose.yml`을 호출해야 한다.
- 프로젝트의 `Docker image`를 직접 만들어야 한다는 의미. 이미 만들어진 `Docker image`는 물론 `Dockerhub` 같은 서비스를 사용하는 것은 금지된다. (`Alpine` / `Debain` 은 제외)
- set up

    → `TLSv1.2` 또는 `TLSv1.3` 만 있는 `NGINX`를 포함하는 `Docker container`

    → `nginx` 없이 `WordPress` + `php-fpm`(반드시 설치되고 구성되어야 합니다)만 설치된 `Docker container`.

    → `nginx` 없이 `MariaDB`만 설치된 `Docker container`.

    → `WordPress` 데이터 베이스가 포함된 `볼륨`.

    → `WordPress` 웹사이트 파일이 포함된 두번째 `볼륨`.

    → `container`들 사이의 연결을 설계하는 `도커 네트워크.`

- `container`는 충돌이 발생한 경우에 다시 시작해야합니다.

`Docker container`는 `가상머신`이 아닙니다. 더불어, 실행할 때 "`tail -f`"을 기반한 어떠한 `해키 패치`(임시 방편의 부분)를 사용하는 것은 권장하지 않습니다. `데몬`의 동작 방식과 `데몬`을 사용하는 것이 좋은지에 대해 읽어보세요.

마찬가지로 네트워크를 사용하는 것: `host` 또는 `--link` 또는 `links:` 는 금지되어 있습니다. 네트워크 선언은 반드시 `docker-compose.yaml` 파일에 이루어져야 합니다. `컨테이너`는 무한 루프로 돌아가는 명령어로 시작하면 절대로 안됩니다. 또한 `entryporint` 또는 `entrypoint.sh`에서 실행되는 명령어도 이 규칙을 따라야 합니다. 다음은 금지된 `해키 패치`들 입니다: `tail -f`, `bash`, `sleep infinity`, `while true`.

`PID 1`에 대해 읽고 `도커 파일` 작성을 위한 최적의 연습을 해보세요

- `워드프레스 데이터 베이스`에는 반드시 2명의 유저가 있어야 하는데, 그 중 한 명은 `관리자`입니다. `관리자`의 이름은 `admin`/`Admin` 또는 `administrator`/`Administrator` (예시., `admin`, `administrator`, `Administrator`, `admin-123` 기타 등등)이 포함되어서는 안됩니다.

`볼륨`은 `도커`를 사용하여 `host` 머신의 `/home/login/data` 폴더에 존재해야 합니다. 마찬가지로, 이 때 `login`은 로그인이 아닌 여러분의 `인트라 아이디`여야 합니다.

간단하게 하기 위해서, `로컬 IP 주소`를 가리키도록 도메인 이름을 구성해야 합니다. `도메인 이름`은 반드시 `login.42.fr` 이어야 합니다. 다시 말해, 여러분이 만든 `login`을 사용해야 합니다.

`latest` 태그는 금지되어있습니다. 어떠한 비밀번호도 `도커파일`에서 보여지면 안됩니다. `환경 변수`를 사용하는 것이 필수입니다. 또한, `환경변수`를 저장할 `.env` 파일을 사용하는 것을 강력하게 권합니다. `.env` 파일은 `srcs` 루트 디렉토리에 위치해있어야 합니다. `NGINX 컨테이너`는 반드시 `TLSv1.2` 또는 `TLSv1.3` 프로토콜을 사용하여 오직 `443 Port`만을 통해서 접속을 허용해야 합니다.

structure
```
.
├── Makefile
├── README.md
└── srcs
    ├── docker-compose.yml
    └── requirements
        ├── adminer
        │   ├── Dockerfile
        │   ├── conf
        │   │   └── www.conf
        │   └── tools
        │       └── entrypoint.sh
        ├── badge42
        │   ├── Dockerfile
        │   └── tools
        │       └── entrypoint.sh
        ├── ftp
        │   ├── Dockerfile
        │   ├── conf
        │   │   └── vsftpd.conf
        │   └── tools
        │       └── entrypoint.sh
        ├── mariadb
        │   ├── Dockerfile
        │   ├── conf
        │   │   └── mariadb-server.cnf
        │   └── tools
        │       └── entrypoint.sh
        ├── nginx
        │   ├── Dockerfile
        │   ├── conf
        │   │   └── www.conf.template
        │   └── tools
        │       └── entrypoint.sh
        ├── redis
        │   ├── Dockerfile
        │   ├── conf
        │   │   └── redis.conf.template
        │   └── tools
        │       └── entrypoint.sh
        ├── simple-portfolio
        │   ├── Dockerfile
        │   ├── src
        │   └── tools
        │       └── entrypoint.sh
        ├── tools
        └── wordpress
            ├── Dockerfile
            ├── conf
            │   ├── wp-cli.yml
            │   └── www.conf
            └── tools
                └── entrypoint.sh
.
```
