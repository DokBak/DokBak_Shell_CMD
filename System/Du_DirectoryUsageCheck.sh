#!/bin/sh

#-------------------------
# 테스트 쉘 : 디렉토리 사용량 체크
#-------------------------
function DirectoryUsageCheck(){
    echo 
    echo "## 디렉토리 사용량 체크 시작 ##"
    echo " 명령어  : du"
    echo " 사용방법 : du [옵션] [디렉토리]"
    echo " 기본설명 : 리눅스 시스템 전체의 마운트 된 디스크 사용량을 확인할 수 있다."
    echo
    echo " 예시1) du"
    echo " 부가설명) 옵션과 디렉토리를 지정하지 않는다면 현재 디렉토리를 기준으로 각 폴더별 사용량을 확인 할 수 있다."
    du
    echo " 예시2) du /home"
    echo " 부가설명) 지정된 디렉토리를 기준으로 각 폴더별 사용량을 확인 할 수 있다."
    du /home
    echo
    echo " 옵션 -a : 하위 디렉토리내에 존재하는 모든 파일, 서브 디렉토리까지 확인할 수 있다."
    echo " 예시2) du -a"
    du -a
    echo " 옵션 -h : 사람이 읽을 수 있는 단위중 읽기 쉬운 단위로 출력 (1024단위로 용량 표기)"
    echo " 예시2) du -h"
    du -h
    echo
    echo " 옵션 -s : 지정된 디렉토리의 총 사용량 합을 보여준다. (디렉토리 지정하지 않을 경우 현재 디렉토리의 사용량)"
    echo " 예시2) du -s"
    du -s
    echo
    echo "## 디스크 사용량 체크 종료 ##"
    echo 
}

DirectoryUsageCheck