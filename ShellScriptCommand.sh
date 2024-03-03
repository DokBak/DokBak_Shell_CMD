#!/bin/sh

###################################################################################
#                                                                                 #
#  Shell Name  : Reference Shell                                                  #
#                                                                                 #
#  Creater     : DokBak                                                           #
#  Create Date : 2024/2/21          New                                           #
#  Modify Date :                                                                  #
#                                                                                 #
#  Processing Overview : Reference Shell for Writing a Shell Script               #
#                                                                                 #
#  Parameter   :                                                                  #
#     Parameter1  (optional) : Command                                            #
#     Parameter2  (optional) : Language                                           #
#                                                                                 #
###################################################################################
#                                                                                 #
#  쉘  이름      : 참조 쉘                                                          　#
#                                                                                 #
#  작 성 자      : DokBak                                                        　　#
#  작 성 일      : 2024/2/21          신규 작성                                       #
#  수 정 일      :                                                               　　#
#                                                                                 #
#  처리 개요      : 쉘 스크립트 작성을 위한 참조 쉘                                       　#
#                                                                                 #
#  파라미터       :                                                             　　　#
#     파라미터1  (옵션) : 명령어                                                       #
#     파라미터2  (옵션) : 언어                                                       　#
#                                                                                 #
###################################################################################
#                                                                                 #
#  スクリプト名    : 参照シェル                                                         #
#                                                                                 #
#  作成者        : DokBak                                                        　　#
#  作成日        : 2024/2/21          新規作成                                        #
#  修正日        :                                                               　　#
#                                                                                 #
#  処理概要      : シェルスクリプト作成に参考できる参照シェル                                 　#
#                                                                                 #
#  パラメータ     :                                                               　　#
#     パラメータ1  (任意) : 言語                                                       #
#     パラメータ2  (任意) : 命令語                                                   　　#
#                                                                                 #
###################################################################################

#--------------------------------------------#
# Basic Setting(Start Run Time)              #
#  : Shell Start Running Time                #
#  : 쉘 기동 시작 시간 출력                       #
#  : シェル起動開始時間出力                        #
#--------------------------------------------#
function func_basicSetting_StartingRunTime() {
    
    ### Language Parameter / 언어 파라미터 / 言語パラメータ
    local languageParam=$1
    
    local functionOutput=""

    ### RunDate / 실행시간 / 実行日
    sys_YYYYMMDDhhmmss=`date +%Y%m%d%H%M%S`
    sys_YYYY=${sys_YYYYMMDDhhmmss:0:4}
    sys_MM=${sys_YYYYMMDDhhmmss:4:2}
    sys_DD=${sys_YYYYMMDDhhmmss:6:2}
    sys_hh=${sys_YYYYMMDDhhmmss:8:2}
    sys_mm=${sys_YYYYMMDDhhmmss:10:2}
    sys_ss=${sys_YYYYMMDDhhmmss:12:2}

    ### Shell start time / 쉘 시작 시간 / シェル開始時間
    if [[ ${languageParam} == [eE][nN] ]]; then
        functionOutput="### Shell Running Time：${sys_YYYY}-${sys_MM}-${sys_DD} ${sys_hh}:${sys_mm}:${sys_ss} ###"
    elif [[ ${languageParam} == [kK][rR] ]]; then
        functionOutput="### 쉘 기동 시작 시간：${sys_YYYY}년${sys_MM}월${sys_DD}일 ${sys_hh}시${sys_mm}분${sys_ss}초 ###"
    elif [[ ${languageParam} == [jJ][pP] ]]; then
        functionOutput="### シェル起動開始時間：${sys_YYYY}年${sys_MM}月${sys_DD}日 ${sys_hh}時${sys_mm}分${sys_ss}秒 ###"
    else
        functionOutput="### Shell Running Time：${sys_YYYY}-${sys_MM}-${sys_DD} ${sys_hh}:${sys_mm}:${sys_ss} ###"
    fi

    ### Result print / 결과 출력 / 結果出力
    echo ${functionOutput}

}

#--------------------------------------------#
# Basic Setting(LogFileName_Path)            #
#  : LogFile Name & Path Set                 #
#  : 로그 파일 이름 및 경로 설정                   #
#  : ログファイル名及びパス設定                     #
#--------------------------------------------#
function func_basicSetting_LogFileName_Path() {
    
    ### ShellScript relativePath / 쉘 스크립트 풀패스 / シェルスクリプトフルパス
    local fileRelativePath=$0
    ### relativePath -> AbsolutePath / 상대경로 -> 절대경로 / 相対パス -> 絶対パス
    local fileAbsolutePath=$(realpath "$fileRelativePath")
    ### ShellScript Name / 쉘 스크립트 이름 / シェルスクリプト名
    scriptName=$(basename $0)
    ### FilePath / 파일 패스 / ファイルパス
    filePath=${fileAbsolutePath%/*}/
    ### LogPath / 로그 패스 / ログパス
    logPath=${fileAbsolutePath%/*}/log/
    ### ProcessID / 프로세스ID / プロセスID
    PID=$1
    ### StartEndflg / 시작종료flg / 開始終了flg
    local startEndflg=$2
    ### Command Parameter / 명령어 파라미터 / コマンドパラメータ
    local searchCommandParam=$3

    ### Directory or File exists check / 디렉토리 또는 파일 존재 체크 / ディレクトリ又はファイル存在チェック
    if [ -e "${logPath}" ]; then
        logFilePath=""
    else
        mkdir -p ${logPath}
    fi

    ### logFileName Set / 로그 파일명 설정 / ログファイル名
    logFilePath=${logPath%/}/shellCommand_`date +%Y%m%d`.log
    commandLogFilePath=${logPath%/}/shellCommand_${searchCommandParam}_`date +%Y%m%d`.log

    ### log Print / 로그 출력 / ログファイル出力
    if [ ${startEndflg} -eq 0 ]; then
        echo "### `date +%Y/%m/%d-%H:%M:%S` [${PID}] ${scriptName} >>> START "
        echo "### `date +%Y/%m/%d-%H:%M:%S` [${PID}] ${scriptName} >>> START " >> ${logFilePath}
        if [ ! -z ${searchCommandParam} ];then
            echo "### `date +%Y/%m/%d-%H:%M:%S` [${PID}] ${scriptName} >>> ${searchCommandParam} START " >> ${commandLogFilePath}
        fi
    else
        echo "### `date +%Y/%m/%d-%H:%M:%S` [${PID}] ${scriptName} >>> END "
        echo "### `date +%Y/%m/%d-%H:%M:%S` [${PID}] ${scriptName} >>> END " >> ${logFilePath}
        if [ ! -z ${searchCommandParam} ];then
            echo "### `date +%Y/%m/%d-%H:%M:%S` [${PID}] ${scriptName} >>> ${searchCommandParam} END " >> ${commandLogFilePath}
        fi
    fi

}

#--------------------------------------------#
# How To Use                                 #
#  : How to use                              #
#  : 사용법                                  　#
#  : 使用法                                    #
#--------------------------------------------#
function func_howToUse() {

    ### Language Parameter / 언어 파라미터 / 言語パラメータ
    local languageParam=$1

    if [[ ${languageParam} == [kK][rR] ]];then
        echo 
        echo "##############################################################################################"
        echo
        echo "  이 쉘의 기본 설정 언어는 영어입니다. "
        echo "  지원 언어 : 영어(en), 한국어(kr), 일본어(jp) "
        echo "  사용법   : sh [Shell Scrip Directory Path]/ShellScriptCommand.sh [Command] [Language] "
        echo
        echo "  예시    : sh ./ShellScriptCommand.sh "
        echo "         : sh ./ShellScriptCommand.sh cp "
        echo "         : sh ./ShellScriptCommand.sh cat kr "
        echo
        echo "##############################################################################################"
    elif [[ ${languageParam} == [jJ][pP] ]];then
        echo 
        echo "##############################################################################################"
        echo
        echo "  このシェルの基本言語は英語です。 "
        echo "  支援言語 : 英語(en), 韓国語(kr), 日本語(jp) "
        echo "  使用法   : sh [Shell Scrip Directory Path]/ShellScriptCommand.sh [Command] [Language] "
        echo
        echo "  例      : sh ./ShellScriptCommand.sh "
        echo "         : sh ./ShellScriptCommand.sh cp "
        echo "         : sh ./ShellScriptCommand.sh cat kr "
        echo
        echo "##############################################################################################"
    else
        echo 
        echo "##############################################################################################"
        echo
        echo "  Default language for this shell script is English "
        echo "  Support language : English(en), Korean(kr), Japense(jp) "
        echo "  How To Use : sh [Shell Scrip Directory Path]/ShellScriptCommand.sh [Command] [Language] "
        echo
        echo "  Sample : sh ./ShellScriptCommand.sh "
        echo "         : sh ./ShellScriptCommand.sh cp "
        echo "         : sh ./ShellScriptCommand.sh cat kr "
        echo
        echo "##############################################################################################"
    fi

}

#--------------------------------------------#
# Support Language                           #
#  : support language                        #
#  : 지원 언어                                  #
#  : 支援言語                                   #
#--------------------------------------------#
function func_supportLanguage() {

    echo
    echo "##############################################################################################"
    echo
    echo "  Support language : English(en), Korean(kr), Japense(jp) "
    echo "    ( Parameter2 )  "
    echo
    echo "##############################################################################################"
    echo

}

#--------------------------------------------#
# Main Menu                                  #
#  : Main Menu Print                         #
#  : 메인 메뉴 출력                            　#
#  : メインメニュー出力                           #
#--------------------------------------------#
function func_mainMenu() {

    ### Language Parameter / 언어 파라미터 / 言語パラメータ
    local languageParam=$1

    ### Function Main Logic / 함수 메인 로직 / 関数メインロジック
    while true
    do
        if [[ ${languageParam} == [kK][rR] ]];then
            echo
            printf "  ******************************\n"
            printf "  *%18s%12s*\n"                     "메뉴"
            printf "  ******************************\n"
            printf "  * %-31s*\n"                       "1. 언어 선택"
            printf "  * %-36s*\n"                       "2. 리눅스 명령어 리스트"
            printf "  * %-36s*\n"                       "3. 스크립트 작성 도움말"
            printf "  *                            *\n"
            printf "  * %-29s*\n"                       "9. 종료"
            printf "  ******************************\n"
            echo 
            read -p " 메뉴 선택 : " selectMenu
            echo
        elif [[ ${languageParam} == [jJ][pP] ]]; then
            echo
            printf "  ******************************\n"
            printf "  *%22s%10s*\n"                     "メニュー"
            printf "  ******************************\n"
            printf "  * %-31s*\n"                       "1. 言語選択"
            printf "  * %-39s*\n"                       "2. リナックスコマンドリスト"
            printf "  * %-36s*\n"                       "3. スクリプトのヘルプ"
            printf "  *                            *\n"
            printf "  * %-29s*\n"                       "9. 終了"
            printf "  ******************************\n"
            echo 
            read -p " メニュー選択 : " selectMenu
            echo
        else
            echo
            printf "  ******************************\n"
            printf "  *%16s%12s*\n"                     "MENU"
            printf "  ******************************\n"
            printf "  * %-27s*\n"                       "1. Select Language"
            printf "  * %-27s*\n"                       "2. List of Linux Commands"
            printf "  * %-27s*\n"                       "3. Helping For Script"
            printf "  *                            *\n"
            printf "  * %-27s*\n"                       "9. End"
            printf "  ******************************\n"
            echo 
            read -p " Select Menu : " selectMenu
            echo
        fi

        ### Parameter exist / 파라미터가 존재 / パラメータが存在
        if [[ ${selectMenu} == 1 ]]; then
            break
        elif [[ ${selectMenu} == 2 ]]; then
            break
        elif [[ ${selectMenu} == 3 ]]; then
            break
        elif [[ ${selectMenu} == 9 ]]; then
            break
        else
            clear
            if [[ ${languageParam} == [kK][rR] ]]; then
                echo
                printf "%s\n" "### 선택 가능한 메뉴(번호) : 1, 2, 3, 9 ###"
            elif [[ ${languageParam} == [jJ][pP] ]]; then
                echo
                printf "%s\n" "### 選択可能なメニュー(番号) : 1, 2, 3, 9 ###"
            else
                echo
                printf "%s\n" "### Selectable menu (number): 1, 2, 3, 9 ###"
            fi
        fi
    done

}

#--------------------------------------------#
# Script End                                 #
#  : Shell Script Close                      #
#  : 쉘 스크립트 종료                           　#
#  : シェルスクリプト終了                          #
#--------------------------------------------#
function func_scriptEnd() {

    ### Language Parameter / 언어 파라미터 / 言語パラメータ
    local languageParam=$1

    clear

    ### Shell Script End / 쉘 스크립트 종료 / シェルスクリプト終了
    if [[ ${languageParam} == [kK][rR]  ]];then
        echo
        printf "  ******************************\n"
        printf "  *                            *\n"
        printf "  * %36s%2s*\n"                     "사용해주셔서 감사합니다"
        printf "  * %17s%10s*\n"                    "[DokBak]"
        printf "  *                            *\n"
        printf "  ******************************\n"
        echo
        break
    elif [[ ${languageParam} == [jJ][pP]  ]];then
        echo
        printf "  ******************************\n"
        printf "  *                            *\n"
        printf "  * %19s%1s*\n"                     "ご利用ありがとうございます"
        printf "  * %17s%10s*\n"                    "[DokBak]"
        printf "  *                            *\n"
        printf "  ******************************\n"
        echo
        break
    else
        echo
        printf "  ******************************\n"
        printf "  *                            *\n"
        printf "  * %22s%5s*\n"                     "Thank you for Using"
        printf "  * %17s%10s*\n"                    "[DokBak]"
        printf "  *                            *\n"
        printf "  ******************************\n"
        echo
        break
    fi
    
}

#--------------------------------------------#
# Select Language                            #
#  : Output Language Select                  #
#  : 출력 언어 선택                            　#
#  : 出力言語出力                               #
#--------------------------------------------#
function func_selectLanguage() {

    ### Language Parameter / 언어 파라미터 / 言語パラメータ
    local languageParam=$1

    ### Function Main Logic / 함수 메인 로직 / 関数メインロジック
    while true
    do
        if [[ ${languageParam} == [kK][rR] ]];then
            echo
            printf "  ******************************\n"
            printf "  * %22s%9s*\n"                     "언어 선택"
            printf "  ******************************\n"
            printf "  * %-29s*\n"                       "1. 영어(en)"
            printf "  * %-30s*\n"                       "2. 한국어(kr)"
            printf "  * %-30s*\n"                       "3. 일본어(jp)"
            printf "  *                            *\n"
            printf "  * %-31s*\n"                       "9. 이전메뉴"
            printf "  ******************************\n"
            echo 
            read -p " 출력 언어를 선택해주세요. : " selectLanguage
            echo
        elif [[ ${languageParam} == [jJ][pP] ]]; then
            echo
            printf "  ******************************\n"
            printf "  * %22s%9s*\n"                     "言語選択"
            printf "  ******************************\n"
            printf "  * %-29s*\n"                       "1. 英語(en)"
            printf "  * %-30s*\n"                       "2. 韓国語(kr)"
            printf "  * %-30s*\n"                       "3. 日本語(jp)"
            printf "  *                            *\n"
            printf "  * %-33s*\n"                       "9. 前のメニュー"
            printf "  ******************************\n"
            echo 
            read -p " 出力言語を選択ください。 : " selectLanguage
            echo
        else
            echo
            printf "  ******************************\n"
            printf "  * %22s%5s*\n"                     "Select Language"
            printf "  ******************************\n"
            printf "  * %-27s*\n"                       "1. English(en)"
            printf "  * %-27s*\n"                       "2. Korean(kr)"
            printf "  * %-27s*\n"                       "3. Japense(jp)"
            printf "  *                            *\n"
            printf "  * %-27s*\n"                       "9. Previous Menu"
            printf "  ******************************\n"
            echo 
            read -p " Select Language. : " selectLanguage
            echo
        fi

        ### Parameter exist / 파라미터가 존재 / パラメータが存在
        if [[ ${selectLanguage} == 1 || ${selectLanguage} == [eE][nN] ]]; then
            clear
            languageParam="en"
            ouputLanguage="en"
            break
        elif [[ ${selectLanguage} == 2 || ${selectLanguage} == [kK][rR] ]]; then
            clear
            languageParam="kr"
            ouputLanguage="kr"
            break
        elif [[ ${selectLanguage} == 3 || ${selectLanguage} == [jJ][pP] ]]; then
            clear
            languageParam="jp"
            ouputLanguage="jp"
            break
        else
            clear
            if [[ ${languageParam} == [kK][rR] ]]; then
                echo
                printf "%s%s\n" "### 출력 언어를 선택해주세요. (대소문자 구분없음 : " "en, kr, jp ) ###"
                printf "%s%36s\n" "### 출력 번호를 선택해주세요. (" "1,  2,  3 ) ###"
            elif [[ ${languageParam} == [jJ][pP] ]]; then
                echo
                printf "%s%s\n" "### 出力言語を選択してください. (大小文字区別無し : " "en, kr, jp ) ###"
                printf "%s%35s\n" "### 出力番号を選択してください. (" "1,  2,  3 ) ###"
            else
                echo
                printf "%s%s\n" "### Please check the language. (case-insensitive : " "en, kr, jp ) ###"
                printf "%s%35s\n" "### Please check the Number.   (" "1,  2,  3 ) ###"
            fi
        fi

        if [ ${selectLanguage} = 9 ]; then
            clear
            break
        fi
    done

}

#--------------------------------------------#
# Linux Commands List                        #
#  : Included Linux Commands List            #
#  : 포함된 리눅스 명령어 리스트                    #
#  : 含まれているLinuxコマンドリスト                 #
#--------------------------------------------#
function func_linuxCommandsList() {
    
    ### Command Existed Check　Flg / 명령 존재 확인 플래그 / コマンド存在チェックフラグ
    local existCheckParam=$1
    
    ### Language Parameter / 언어 파라미터 / 言語パラメータ
    local languageParam=$2

    ### Function Main Logic / 함수 메인 로직 / 関数メインロジック
    Index=0
    echo
    printf "##############################################################################################\n"
    if [[ ${languageParam} == [kK][rR] ]]; then
        printf "  %-8s %s  %-18s %s  %-102s\n" "번호" "#" "명령어" "#" "설명"
        printf "##############################################################################################\n"
        for commandIndex in ${commandList[@]}; do
            printf "  %03d    %s  %-15s %s  %-100s\n" $((${Index}+1)) "#" ${commandList[${Index}]} "#" ${commandDescriptionKr[${Index}]} | sed 's/_/ /g'
            Index=$(( ${Index} + 1 ))
        done
    elif [[ ${languageParam} == [jJ][pP] ]]; then
        printf "  %-8s %s  %-19s %s  %-102s\n" "番号" "#" "コマンド" "#" "説明"
        printf "##############################################################################################\n"
        for commandIndex in ${commandList[@]}; do
            printf "  %03d    %s  %-15s %s  %-100s\n" $((${Index}+1)) "#" ${commandList[${Index}]} "#" ${commandDescriptionJp[${Index}]} | sed 's/_/ /g'
            Index=$(( ${Index} + 1 ))
        done
    else
        printf "  %-6s %s  %-15s %s  %-100s\n" "Number" "#" "Command" "#" "Description"
        printf "##############################################################################################\n"
        for commandIndex in ${commandList[@]}; do
            printf "  %03d    %s  %-15s %s  %-100s\n" $((${Index}+1)) "#" ${commandList[${Index}]} "#" ${commandDescriptionEn[${Index}]} | sed 's/_/ /g'
            Index=$(( ${Index} + 1 ))
        done
    fi
    printf "##############################################################################################\n"
    echo
    if [[ ${existCheckParam} == 1 ]];then
        if [[ ${languageParam} == [kK][rR] ]];then
            read -p " 검색 명령어 (취소:C) : " searchCommand
        elif [[ ${languageParam} == [jJ][pP] ]];then
            read -p " 検索コマンド (取り消し:C) : " searchCommand
        else
            read -p " Search Command (Cancel:C) : " searchCommand
        fi

        if [[ ${searchCommand} == [cC] || ${searchCommand} == [cC][aA][nN][cC][eE][lL] ]];then
            searchCommand=""
            break
        fi
    else
        break
    fi

    #Debug Check Code
    #"#echo "func_linuxCommandsList Check"
    #"#echo "existCheckParam=${existCheckParam}"
    #"#echo "languageParam=${languageParam}"
    #"#echo "languageParam=${languageParam}"

}

#--------------------------------------------#
# Linux Commands Exist Check                 #
#  : Included Linux Commands Exist Check     #
#  : 포함된 리눅스 명령어 존재 체크                 #
#  : 含まれているLinuxコマンド存在チェック            #
#--------------------------------------------#
function func_linuxCommandsExistCheck() {

    ### Command List Array / 명령어 리스트 배열 / コマンドリスト配列
    local commandListParam=(${commandList[@]})
    
    ### Command List Array Length / 명령어 리스트 배열 길이 / コマンドリスト配列長
    local commandListArrayLength="${#commandList[@]}"

    ### Command Parameter / 명령어 파라미터 / コマンドパラメータ
    local searchCommandParam=$1

    ### Command Exist Check Flg / 명령어 존재 체크 플래그 / コマンド存在チェックフラグ
    existCheck=0

    ### Command Array Index / 명령어 리스트 인덱스 / コマンド配列インデックス
    commandItemIndex=0
    for commandItem in ${commandListParam[@]}; do
        if [[ ${commandItem} == ${searchCommandParam} ]];then
            existCheck=1
            break
        fi
        commandItemIndex=$(( ${commandItemIndex} + 1 ))
    done

    #Debug Check Code
    #"#echo "func_linuxCommandsExistCheck Check"
    #"#echo "commandListParam=${commandListParam[@]}"
    #"#echo "commandListArrayLength=${commandListArrayLength}"
    #"#echo "searchCommandParam=${searchCommandParam}"

}

#--------------------------------------------#
# Not Exist Command                          #
#  : Not Exist Command                       #
#  : 존재하지 않는 명령어                         #
#  : 存在しないコマンド                           #
#--------------------------------------------#
function func_notExistCommand() {
    

    ### Command Parameter / 명령어 파라미터 / コマンドパラメータ
    local searchCommandParam=$1
    
    ### Language Parameter / 언어 파라미터 / 言語パラメータ
    local ouputLanguageParam=$2

    ### Exist Check Parameter / 존재 체크 파라미터 / 存在チェックパラメータ
    local existCheckParam=$3

    if [[ ${ouputLanguageParam} == [kK][rR] ]];then
        echo "##############################################################################################"
        echo
        echo "  해당 명령어(${searchCommandParam})는 포함되어 있지 않습니다. "
        echo "    ( 파라미터1 )  "
        func_linuxCommandsList ${existCheckParam} ${ouputLanguageParam}
    elif [[ ${ouputLanguageParam} == [jJ][pP] ]];then
        echo "##############################################################################################"
        echo
        echo "  ごのコマンド(${searchCommandParam})は含まれていません。"
        echo "    ( パラメータ1 )  "
        func_linuxCommandsList ${existCheckParam} ${ouputLanguageParam}
    else
        func_howToUse ${ouputLanguageParam}
        echo
        echo "  The Command(${searchCommandParam}) not included. "
        echo "    ( Parameter1 )  "
        func_linuxCommandsList ${existCheckParam} ${ouputLanguageParam}
    fi

    #Debug Check Code
    #"#echo "func_notExistCommand Check"
    #"#echo "searchCommandParam=${searchCommandParam}"
    #"#echo "ouputLanguageParam=${ouputLanguageParam}"
    #"#echo "existCheckParam=${existCheckParam}"

}

#--------------------------------------------#
# Linux Command Example                      #
#  : Linux Command Example                   #
#  : 리눅스 명령어 예                            #
#  : Linuxコマンド例                            #
#--------------------------------------------#
function func_linuxCommandExample() {

    ### Language Parameter / 언어 파라미터 / 言語パラメータ
    local ouputLanguageParam=$1
    ### FilePath / 파일 패스 파라미터 / ファイルパスパラメータ
    local filePathParam=$2
    ### Array Index / 배열 인덱스 파라미터 / 配列インデックスパラメータ
    local commandItemIndex=$3

    clear
    echo
    case ${commandList[${commandItemIndex}]} in
        cat)
            func_command_cat ${ouputLanguageParam} ${filePath} ${commandDescriptionEn[${commandItemIndex}]} ${commandDescriptionKr[${commandItemIndex}]} ${commandDescriptionJp[${commandItemIndex}]} ${commandList[${commandItemIndex}]}
            ;;
        expr)
            func_command_expr ${ouputLanguageParam} ${filePath} ${commandDescriptionEn[${commandItemIndex}]} ${commandDescriptionKr[${commandItemIndex}]} ${commandDescriptionJp[${commandItemIndex}]} ${commandList[${commandItemIndex}]}
            ;;
        sleep)
            func_command_sleep ${ouputLanguageParam} ${filePath} ${commandDescriptionEn[${commandItemIndex}]} ${commandDescriptionKr[${commandItemIndex}]} ${commandDescriptionJp[${commandItemIndex}]} ${commandList[${commandItemIndex}]}
            ;;
        gunzip)
            func_command_gunzip ${ouputLanguageParam} ${filePath} ${commandDescriptionEn[${commandItemIndex}]} ${commandDescriptionKr[${commandItemIndex}]} ${commandDescriptionJp[${commandItemIndex}]} ${commandList[${commandItemIndex}]}
            ;;
        gzip)
            func_command_gzip ${ouputLanguageParam} ${filePath} ${commandDescriptionEn[${commandItemIndex}]} ${commandDescriptionKr[${commandItemIndex}]} ${commandDescriptionJp[${commandItemIndex}]} ${commandList[${commandItemIndex}]}
            ;;
        zip)
            func_command_zip ${ouputLanguageParam} ${filePath} ${commandDescriptionEn[${commandItemIndex}]} ${commandDescriptionKr[${commandItemIndex}]} ${commandDescriptionJp[${commandItemIndex}]} ${commandList[${commandItemIndex}]}
            ;;
        unzip)
            func_command_unzip ${ouputLanguageParam} ${filePath} ${commandDescriptionEn[${commandItemIndex}]} ${commandDescriptionKr[${commandItemIndex}]} ${commandDescriptionJp[${commandItemIndex}]} ${commandList[${commandItemIndex}]}
            ;;
        date)
            func_command_date ${ouputLanguageParam} ${filePath} ${commandDescriptionEn[${commandItemIndex}]} ${commandDescriptionKr[${commandItemIndex}]} ${commandDescriptionJp[${commandItemIndex}]} ${commandList[${commandItemIndex}]}
            ;;
        cal)
            func_command_cal ${ouputLanguageParam} ${filePath} ${commandDescriptionEn[${commandItemIndex}]} ${commandDescriptionKr[${commandItemIndex}]} ${commandDescriptionJp[${commandItemIndex}]} ${commandList[${commandItemIndex}]}
            ;;
        wc)
            func_command_wc ${ouputLanguageParam} ${filePath} ${commandDescriptionEn[${commandItemIndex}]} ${commandDescriptionKr[${commandItemIndex}]} ${commandDescriptionJp[${commandItemIndex}]} ${commandList[${commandItemIndex}]}
            ;;
        uniq)
            func_command_uniq ${ouputLanguageParam} ${filePath} ${commandDescriptionEn[${commandItemIndex}]} ${commandDescriptionKr[${commandItemIndex}]} ${commandDescriptionJp[${commandItemIndex}]} ${commandList[${commandItemIndex}]}
            ;;
        touch)
            func_command_touch ${ouputLanguageParam} ${filePath} ${commandDescriptionEn[${commandItemIndex}]} ${commandDescriptionKr[${commandItemIndex}]} ${commandDescriptionJp[${commandItemIndex}]} ${commandList[${commandItemIndex}]}
            ;;
        head)
            func_command_head ${ouputLanguageParam} ${filePath} ${commandDescriptionEn[${commandItemIndex}]} ${commandDescriptionKr[${commandItemIndex}]} ${commandDescriptionJp[${commandItemIndex}]} ${commandList[${commandItemIndex}]}
            ;;
        tail)
            func_command_tail ${ouputLanguageParam} ${filePath} ${commandDescriptionEn[${commandItemIndex}]} ${commandDescriptionKr[${commandItemIndex}]} ${commandDescriptionJp[${commandItemIndex}]} ${commandList[${commandItemIndex}]}
            ;;
        *)  echo ; 
            if [[ ${ouputLanguageParam} == [kK][rR] ]];then
                echo " 에러 : 명령어 함수 미포함 (func_command_${commandList[${commandItemIndex}]})"; 
            elif [[ ${ouputLanguageParam} == [jJ][pP] ]];then
                echo " エラー : コマンド関数を含まない (func_command_${commandList[${commandItemIndex}]})"; 
            else
                echo " ERROR : Command_Function Not Included (func_command_${commandList[${commandItemIndex}]})"; 
            fi
            echo ; # default
    esac
    
    while true
    do
        if [[ ${ouputLanguageParam} == [kK][rR] ]];then
            read -p " 메인메뉴[Y] / 재검색[N/C] : " previousMenu
        elif [[ ${ouputLanguageParam} == [jJ][pP] ]];then
            read -p " メインメニュー[Y] / 再検索[N/C] : " previousMenu
        else
            read -p " Main Menu[Y] / Re-searching[N/C] : " previousMenu
        fi

        if [[ ${previousMenu} == [yY] || ${previousMenu} == [yY][eE][sS] ]];then
            clear
            searchCommand=""
            break 2
        elif [[ ${previousMenu} == [nN] || ${previousMenu} == [nN][oO] || ${previousMenu} == [cC] || ${previousMenu} == [cC][aA][nN][cC][eE][lL] ]];then
            clear
            searchCommand=""
            break
        fi
    done

    #Debug Check Code
    #"#echo "func_linuxCommandExample Check"
    #"#echo "ouputLanguageParam=${ouputLanguageParam}"
    #"#echo "filePathParam=${filePathParam}"
    #"#echo "commandItemIndex=${commandItemIndex}"
    #"#echo "commandList[${commandItemIndex}]=${commandList[${commandItemIndex}]}"

}

#--------------------------------------------#
# Command : cat                              #
#--------------------------------------------#
function func_command_cat() {
    
    ### Language Parameter / 언어 파라미터 / 言語パラメータ
    local ouputLanguageParam=$1
    ### File Path Parameter / 파일 패스 파라미터 / ファイルパスパラメータ
    local filePathParam=$2
    ### English Command Description Parameter / 영어 명령어 설명 파라미터 / 英語コマンド説明パラメータ
    local commandDescriptionEnParam=$3
    ### Korean Command Description Parameter / 한국어 명령어 설명 파라미터 / 韓国語コマンド説明パラメータ
    local commandDescriptionKrParam=$4
    ### Japense Command Description Parameter / 일본어 명령어 설명 파라미터 / 日本語コマンド説明パラメータ
    local commandDescriptionJpParam=$5
    ### Command / 명령어 / コマンド
    local commandItem=$6
    ### Count / 번호 / 番号 
    local countNumber=0

    mkdir -p ${filePathParam%/}/tmp/${commandItem}/
    echo "testFile,Command,data" > ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
    echo "" >> ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
    echo "File,Command,data\t" >> ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
    echo "" >> ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
    echo "" >> ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
    echo "" >> ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
    echo "Command,date" >> ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
    old_LC_ALL=${LC_ALL}
    echo
    clear
    func_basicSetting_LogFileName_Path ${PID} "0" ${commandItem}
    printf "##############################################################################################\n"
    echo
    if [[ ${ouputLanguageParam} == [kK][rR] ]];then
        printf "  %-16s %s %s\n" "명령어" ":" "${commandItem}"
        printf "  %-17s %s %s\n" "기본설명" ":" "${commandDescriptionKrParam}" | sed 's/_/ /g'
        printf "  %-18s %s %s\n" "※사용법" ":" "${commandItem}_[옵션]_[인수]" | sed 's/_/ /g'
        printf "  %-17s %s %s\n" "※옵션" ":" "[-benst]" | sed 's/_/ /g'
        printf "  %-17s %s %s\n" "※인수" ":" "[파일경로]" | sed 's/_/ /g'
    elif [[ ${ouputLanguageParam} == [jJ][pP] ]];then
        printf "  %-17s %s %s\n" "コマンド" ":" "${commandItem}"
        printf "  %-17s %s %s\n" "基本説明" ":" "${commandDescriptionJpParam}" | sed 's/_/ /g'
        printf "  %-18s %s %s\n" "※使用法" ":" "${commandItem}_[オプション]_[引数]" | sed 's/_/ /g'
        printf "  %-20s %s %s\n" "※オプション" ":" "[-benst]" | sed 's/_/ /g'
        printf "  %-17s %s %s\n" "※引数" ":" "[ファイルパス]" | sed 's/_/ /g'
    else
        printf "  %-13s %s %s\n" "Command" ":" "${commandItem}"
        printf "  %-13s %s %s\n" "Description" ":" "${commandDescriptionEnParam}" | sed 's/_/ /g'
        printf "  %-15s %s %s\n" "※HowToUse" ":" "${commandItem}_[option]_[argument]" | sed 's/_/ /g'
        printf "  %-15s %s %s\n" "※option" ":" "[-benst]" | sed 's/_/ /g'
        printf "  %-15s %s %s\n" "※argument" ":" "[filePath]" | sed 's/_/ /g'
    fi
        echo
        printf "##############################################################################################\n"
        echo
    if [[ ${ouputLanguageParam} == [kK][rR] ]];then
        export LC_ALL="ko_KR.UTF-8"
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "cat ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "  %-12s %s %-15s\n" "옵션" ":" "없음"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(예상)" ":"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo "testFile,Command,data"
            echo ""
            echo "File,Command,data\t"
            echo ""
            echo ""
            echo ""
            echo "Command,date"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "cat ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            cat ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "cat -b ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "  %-12s %s %-15s\n" "옵션" ":" "b"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(예상)" ":" "공백이 아닌 라인의 라인 번호를 출력"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo "     1  testFile,Command,data"
            echo ""
            echo "     2  File,Command,data\t"
            echo ""
            echo ""
            echo ""
            echo "     3  Command,date"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "cat -b ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            cat -b ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "cat -n ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "  %-12s %s %-15s\n" "옵션" ":" "n"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(예상)" ":" "모든 라인을 라인 번호로 출력"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo "     1  testFile,Command,data"
            echo "     2"
            echo "     3  File,Command,data\t"
            echo "     4"
            echo "     5"
            echo "     6"
            echo "     7  Command,date"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "cat -n ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            cat -n ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "cat -e ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "  %-12s %s %-15s\n" "옵션" ":" "e"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(예상)" ":" "모든 행 끝에 [$] 출력"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo "testFile,Command,data$"
            echo "$"
            echo "File,Command,data\t$"
            echo "$"
            echo "$"
            echo "$"
            echo "Command,date$"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "cat -e ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            cat -e ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "cat -s ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "  %-12s %s %-15s\n" "옵션" ":" "s"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(예상)" ":" "연속된 빈 줄을 압축하여 한 줄로 출력"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo "testFile,Command,data"
            echo ""
            echo "File,Command,data\t"
            echo ""
            echo "Command,date"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "cat -s ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            cat -s ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "cat -t ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "  %-12s %s %-15s\n" "옵션" ":" "t"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(예상)" ":" "탭 문자열 "^I"로 대체되어 출력"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo "testFile,Command,data"
            echo ""
            echo "File,Command,data^I"
            echo ""
            echo ""
            echo ""
            echo "Command,date"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "cat -t ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            cat -t ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
        printf "#--------------------------------------------------------------------------------------------#\n"
    elif [[ ${ouputLanguageParam} == [jJ][pP] ]];then
        export LC_ALL="ja_JP.UTF-8"
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "cat ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "  %-12s %s %-15s\n" "オプション" ":" "無"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(予想)" ":" 
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo "testFile,Command,data"
            echo ""
            echo "File,Command,data\t"
            echo ""
            echo ""
            echo ""
            echo "Command,date"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "cat ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            cat ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "cat -b ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "  %-12s %s %-15s\n" "オプション" ":" "b"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(予想)" ":" "空白ではない行の前に行番号を出力します"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo "     1  testFile,Command,data"
            echo ""
            echo "     2  File,Command,data\t"
            echo ""
            echo ""
            echo ""
            echo "     3  Command,date"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "cat -b ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            cat -b ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "cat -n ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "  %-12s %s %-15s\n" "オプション" ":" "n"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(予想)" ":" "すべての行を行番号を出力します"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo "     1  testFile,Command,data"
            echo "     2"
            echo "     3  File,Command,data\t"
            echo "     4"
            echo "     5"
            echo "     6"
            echo "     7  Command,date"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "cat -n ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            cat -n ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "cat -e ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "  %-12s %s %-15s\n" "オプション" ":" "e"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(予想)" ":" "すべての行の末尾に[$]を出力します"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo "testFile,Command,data$"
            echo "$"
            echo "File,Command,data\t$"
            echo "$"
            echo "$"
            echo "$"
            echo "Command,date$"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "cat -e ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            cat -e ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "cat -s ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "  %-12s %s %-15s\n" "オプション" ":" "s"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(予想)" ":" "連続する空白行を圧縮し、1行として出力します"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo "testFile,Command,data"
            echo ""
            echo "File,Command,data\t"
            echo ""
            echo "Command,date"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "cat -s ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            cat -s ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "cat -t ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "  %-12s %s %-15s\n" "オプション" ":" "t"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(予想)" ":" "タブ文字列を"^I"に置き換えられ、出力されます"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo "testFile,Command,data"
            echo ""
            echo "File,Command,data^I"
            echo ""
            echo ""
            echo ""
            echo "Command,date"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "cat -t ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            cat -t ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
        printf "#--------------------------------------------------------------------------------------------#\n"
    else
        export LC_ALL="en_US.UTF-8"
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "cat ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "  %-10s %s %-15s\n" "Option" ":" "Not"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(expect)" ":"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo "testFile,Command,data"
            echo ""
            echo "File,Command,data\t"
            echo ""
            echo ""
            echo ""
            echo "Command,date"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "cat ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            cat ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "cat -b ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "  %-10s %s %-15s\n" "Option" ":" "b"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(expect)" ":" "Outputs a line number in front of a line that is not blank"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo "     1  testFile,Command,data"
            echo ""
            echo "     2  File,Command,data\t"
            echo ""
            echo ""
            echo ""
            echo "     3  Command,date"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "cat -b ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            cat -b ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "cat -n ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "  %-10s %s %-15s\n" "Option" ":" "n"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(expect)" ":" "Print out all lines with line numbers"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo "     1  testFile,Command,data"
            echo "     2"
            echo "     3  File,Command,data\t"
            echo "     4"
            echo "     5"
            echo "     6"
            echo "     7  Command,date"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "cat -n ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            cat -n ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "cat -e ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "  %-10s %s %-15s\n" "Option" ":" "e"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(expect)" ":" "Print a [$] at the end of all lines"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo "testFile,Command,data$"
            echo "$"
            echo "File,Command,data\t$"
            echo "$"
            echo "$"
            echo "$"
            echo "Command,date$"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "cat -e ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            cat -e ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "cat -s ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "  %-10s %s %-15s\n" "Option" ":" "s"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(expect)" ":" "Compresses consecutive blank lines and outputs them as a single line"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo "testFile,Command,data"
            echo ""
            echo "File,Command,data\t"
            echo ""
            echo "Command,date"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "cat -s ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            cat -s ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "cat -t ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "  %-10s %s %-15s\n" "Option" ":" "t"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(expect)" ":" "tab string is replaced with a string "^I" and outputted"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo "testFile,Command,data"
            echo ""
            echo "File,Command,data^I"
            echo ""
            echo ""
            echo ""
            echo "Command,date"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "cat -t ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            cat -t ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
        printf "#--------------------------------------------------------------------------------------------#\n"
    fi
        echo
    printf "##############################################################################################\n"
    
    export LC_ALL=${old_LC_ALL}

    ### tmp Directory Delete / 임시 디렉토리 삭제 / 作業ディレクトリ削除
    rm -rf ${filePathParam%/}/tmp/${commandItem}/
    
    func_basicSetting_LogFileName_Path ${PID} "1" ${commandItem}
    echo 
    
}

#--------------------------------------------#
# Command : expr                             #
#--------------------------------------------#
function func_command_expr() {
    
    ### Language Parameter / 언어 파라미터 / 言語パラメータ
    local ouputLanguageParam=$1
    ### File Path Parameter / 파일 패스 파라미터 / ファイルパスパラメータ
    local filePathParam=$2
    ### English Command Description Parameter / 영어 명령어 설명 파라미터 / 英語コマンド説明パラメータ
    local commandDescriptionEnParam=$3
    ### Korean Command Description Parameter / 한국어 명령어 설명 파라미터 / 韓国語コマンド説明パラメータ
    local commandDescriptionKrParam=$4
    ### Japense Command Description Parameter / 일본어 명령어 설명 파라미터 / 日本語コマンド説明パラメータ
    local commandDescriptionJpParam=$5
    ### Command / 명령어 / コマンド
    local commandItem=$6
    ### Count / 번호 / 番号 
    local countNumber=0

    old_LC_ALL=${LC_ALL}
    echo
    clear
    func_basicSetting_LogFileName_Path ${PID} "0" ${commandItem}
    printf "##############################################################################################\n"
    echo
    if [[ ${ouputLanguageParam} == [kK][rR] ]];then
        printf "  %-16s %s %s\n" "명령어" ":" "${commandItem}"
        printf "  %-17s %s %s\n" "기본설명" ":" "${commandDescriptionKrParam}" | sed 's/_/ /g'
        printf "  %-18s %s %s\n" "※사용법" ":" "${commandItem}_[인수1]_[연산자]_[인수2]" | sed 's/_/ /g'
        printf "  %-17s %s %s\n" "※인수1" ":" "[숫자1]" | sed 's/_/ /g'
        printf "  %-17s %s %s\n" "※연산자" ":" "[+,-,/,*,%,>,>=,=,<=,<]" | sed 's/_/ /g'
        printf "  %-17s %s %s\n" "※인수2" ":" "[숫자2]" | sed 's/_/ /g'
    elif [[ ${ouputLanguageParam} == [jJ][pP] ]];then
        printf "  %-17s %s %s\n" "コマンド" ":" "${commandItem}"
        printf "  %-17s %s %s\n" "基本説明" ":" "${commandDescriptionJpParam}" | sed 's/_/ /g'
        printf "  %-18s %s %s\n" "※使用法" ":" "${commandItem}_[引数1]_[演算子]_[引数2]" | sed 's/_/ /g'
        printf "  %-17s %s %s\n" "※引数1" ":" "[数字1]" | sed 's/_/ /g'
        printf "  %-17s %s %s\n" "※演算子" ":" "[+,-,/,*,%,>,>=,=,<=,<]" | sed 's/_/ /g'
        printf "  %-17s %s %s\n" "※引数2" ":" "[数字2]" | sed 's/_/ /g'
    else
        printf "  %-13s %s %s\n" "Command" ":" "${commandItem}"
        printf "  %-13s %s %s\n" "Description" ":" "${commandDescriptionEnParam}" | sed 's/_/ /g'
        printf "  %-15s %s %s\n" "※HowToUse" ":" "${commandItem}_[argument1]_[Operator]_[argument2]" | sed 's/_/ /g'
        printf "  %-15s %s %s\n" "※argument1" ":" "[number1]" | sed 's/_/ /g'
        printf "  %-15s %s %s\n" "※Operator" ":" "[+,-,/,*,%,>,>=,=,<=,<]" | sed 's/_/ /g'
        printf "  %-15s %s %s\n" "※argument2" ":" "[number2]" | sed 's/_/ /g'
    fi
        echo
        printf "##############################################################################################\n"
        echo
    if [[ ${ouputLanguageParam} == [kK][rR] ]];then
        export LC_ALL="ko_KR.UTF-8"
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "expr '5' '+' '2'"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "expr '5' '-' '2'"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "expr '5' '/' '2'"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "expr '5' '*' '2'"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "expr '5' '%' '2'"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(예상)" ":" "산술연산"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo "7"
            echo "3"
            echo "2"
            echo "10"
            echo "1"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "expr '5' '+' '2'"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "expr '5' '-' '2'"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "expr '5' '/' '2'"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "expr '5' '*' '2'"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "expr '5' '%' '2'"
        printf "#--------------------------------------------------------------------------------------------#\n"
            expr '5' '+' '2'
            expr '5' '-' '2'
            expr '5' '/' '2'
            expr '5' '*' '2'
            expr '5' '%' '2'
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "expr '5' '>' '2'"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "expr '5' '>=' '2'"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "expr '5' '=' '2'"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "expr '5' '<=' '2'"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "expr '5' '<' '2'"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(예상)" ":" "관계연산"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo "1"
            echo "1"
            echo "0"
            echo "0"
            echo "0"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "expr '5' '>' '2'"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "expr '5' '>=' '2'"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "expr '5' '=' '2'"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "expr '5' '<=' '2'"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "expr '5' '<' '2'"
        printf "#--------------------------------------------------------------------------------------------#\n"
            expr '5' '>' '2'
            expr '5' '>=' '2'
            expr '5' '=' '2'
            expr '5' '<=' '2'
            expr '5' '<' '2'
        printf "#--------------------------------------------------------------------------------------------#\n"
    elif [[ ${ouputLanguageParam} == [jJ][pP] ]];then
        export LC_ALL="ja_JP.UTF-8"
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "expr '5' '+' '2'"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "expr '5' '-' '2'"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "expr '5' '/' '2'"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "expr '5' '*' '2'"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "expr '5' '%' '2'"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(予想)" ":" "算術演算"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo "7"
            echo "3"
            echo "2"
            echo "10"
            echo "1"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "expr '5' '+' '2'"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "expr '5' '-' '2'"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "expr '5' '/' '2'"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "expr '5' '*' '2'"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "expr '5' '%' '2'"
        printf "#--------------------------------------------------------------------------------------------#\n"
            expr '5' '+' '2'
            expr '5' '-' '2'
            expr '5' '/' '2'
            expr '5' '*' '2'
            expr '5' '%' '2'
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "expr '5' '>' '2'"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "expr '5' '>=' '2'"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "expr '5' '=' '2'"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "expr '5' '<=' '2'"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "expr '5' '<' '2'"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(予想)" ":" "算術演算"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo "1"
            echo "1"
            echo "0"
            echo "0"
            echo "0"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "expr '5' '>' '2'"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "expr '5' '>=' '2'"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "expr '5' '=' '2'"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "expr '5' '<=' '2'"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "expr '5' '<' '2'"
        printf "#--------------------------------------------------------------------------------------------#\n"
            expr '5' '>' '2'
            expr '5' '>=' '2'
            expr '5' '=' '2'
            expr '5' '<=' '2'
            expr '5' '<' '2'
        printf "#--------------------------------------------------------------------------------------------#\n"
    else
        export LC_ALL="en_US.UTF-8"
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "expr '5' '+' '2'"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "expr '5' '-' '2'"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "expr '5' '/' '2'"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "expr '5' '*' '2'"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "expr '5' '%' '2'"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(expect)" ":" "arithmetic operations"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo "7"
            echo "3"
            echo "2"
            echo "10"
            echo "1"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "expr '5' '+' '2'"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "expr '5' '-' '2'"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "expr '5' '/' '2'"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "expr '5' '*' '2'"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "expr '5' '%' '2'"
        printf "#--------------------------------------------------------------------------------------------#\n"
            expr '5' '+' '2'
            expr '5' '-' '2'
            expr '5' '/' '2'
            expr '5' '*' '2'
            expr '5' '%' '2'
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "expr '5' '>' '2'"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "expr '5' '>=' '2'"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "expr '5' '=' '2'"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "expr '5' '<=' '2'"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "expr '5' '<' '2'"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(expect)" ":" "arithmetic operations"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo "1"
            echo "1"
            echo "0"
            echo "0"
            echo "0"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "expr '5' '>' '2'"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "expr '5' '>=' '2'"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "expr '5' '=' '2'"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "expr '5' '<=' '2'"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "expr '5' '<' '2'"
        printf "#--------------------------------------------------------------------------------------------#\n"
            expr '5' '>' '2'
            expr '5' '>=' '2'
            expr '5' '=' '2'
            expr '5' '<=' '2'
            expr '5' '<' '2'
        printf "#--------------------------------------------------------------------------------------------#\n"
    fi
        echo
    printf "##############################################################################################\n"
    
    export LC_ALL=${old_LC_ALL}

    func_basicSetting_LogFileName_Path ${PID} "1" ${commandItem}
    echo 
    
}

#--------------------------------------------#
# Command : sleep                            #
#--------------------------------------------#
function func_command_sleep() {
    
    ### Language Parameter / 언어 파라미터 / 言語パラメータ
    local ouputLanguageParam=$1
    ### File Path Parameter / 파일 패스 파라미터 / ファイルパスパラメータ
    local filePathParam=$2
    ### English Command Description Parameter / 영어 명령어 설명 파라미터 / 英語コマンド説明パラメータ
    local commandDescriptionEnParam=$3
    ### Korean Command Description Parameter / 한국어 명령어 설명 파라미터 / 韓国語コマンド説明パラメータ
    local commandDescriptionKrParam=$4
    ### Japense Command Description Parameter / 일본어 명령어 설명 파라미터 / 日本語コマンド説明パラメータ
    local commandDescriptionJpParam=$5
    ### Command / 명령어 / コマンド
    local commandItem=$6
    ### Count / 번호 / 番号 
    local countNumber=0

    old_LC_ALL=${LC_ALL}
    echo
    clear
    func_basicSetting_LogFileName_Path ${PID} "0" ${commandItem}
    printf "##############################################################################################\n"
    echo
    if [[ ${ouputLanguageParam} == [kK][rR] ]];then
        printf "  %-16s %s %s\n" "명령어" ":" "${commandItem}"
        printf "  %-17s %s %s\n" "기본설명" ":" "${commandDescriptionKrParam}" | sed 's/_/ /g'
        printf "  %-18s %s %s\n" "※사용법" ":" "${commandItem}_[인수1]" | sed 's/_/ /g'
        printf "  %-17s %s %s\n" "※인수" ":" "[대기시간:'n'초]" | sed 's/_/ /g'
    elif [[ ${ouputLanguageParam} == [jJ][pP] ]];then
        printf "  %-17s %s %s\n" "コマンド" ":" "${commandItem}"
        printf "  %-17s %s %s\n" "基本説明" ":" "${commandDescriptionJpParam}" | sed 's/_/ /g'
        printf "  %-18s %s %s\n" "※使用法" ":" "${commandItem}_[引数1]" | sed 's/_/ /g'
        printf "  %-17s %s %s\n" "※引数" ":" "[待機時間:'n'秒]" | sed 's/_/ /g'
    else
        printf "  %-13s %s %s\n" "Command" ":" "${commandItem}"
        printf "  %-13s %s %s\n" "Description" ":" "${commandDescriptionEnParam}" | sed 's/_/ /g'
        printf "  %-15s %s %s\n" "※HowToUse" ":" "${commandItem}_[argument]" | sed 's/_/ /g'
        printf "  %-15s %s %s\n" "※argument" ":" "[waitingTime:'n'seconds]" | sed 's/_/ /g'
    fi
        echo
        printf "##############################################################################################\n"
        echo
    if [[ ${ouputLanguageParam} == [kK][rR] ]];then
        export LC_ALL="ko_KR.UTF-8"
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "sleep 3"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(예상)" ":" "n초 후 다음 작업 실행"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo "sleep 명령어 전 출력"
            echo "sleep 명령어 3초 후 출력"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "sleep 3"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo "sleep 명령어 전 출력"
            sleep 3
            echo "sleep 명령어 3초 후 출력"
        printf "#--------------------------------------------------------------------------------------------#\n"
    elif [[ ${ouputLanguageParam} == [jJ][pP] ]];then
        export LC_ALL="ja_JP.UTF-8"
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "sleep 3"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(予想)" ":" "n秒後に次の作業を実行"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo "sleep コマンド前出力"
            echo "sleep コマンド3秒後出力"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "sleep 3"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo "sleep コマンド前出力"
            sleep 3
            echo "sleep コマンド3秒後出力"
        printf "#--------------------------------------------------------------------------------------------#\n"
    else
        export LC_ALL="en_US.UTF-8"
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "sleep 3"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(expect)" ":" "After n seconds, perform the following actions"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo "sleep Command Pre-Output"
            echo "sleep command output after 3 seconds"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "sleep 3"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo "sleep Command Pre-Output"
            sleep 3
            echo "sleep command output after 3 seconds"
        printf "#--------------------------------------------------------------------------------------------#\n"
    fi
        echo
    printf "##############################################################################################\n"
    
    export LC_ALL=${old_LC_ALL}

    func_basicSetting_LogFileName_Path ${PID} "1" ${commandItem}
    echo 
    
}

#--------------------------------------------#
# Command : gzip                             #
#--------------------------------------------#
function func_command_gzip() {
    
    ### Language Parameter / 언어 파라미터 / 言語パラメータ
    local ouputLanguageParam=$1
    ### File Path Parameter / 파일 패스 파라미터 / ファイルパスパラメータ
    local filePathParam=$2
    ### English Command Description Parameter / 영어 명령어 설명 파라미터 / 英語コマンド説明パラメータ
    local commandDescriptionEnParam=$3
    ### Korean Command Description Parameter / 한국어 명령어 설명 파라미터 / 韓国語コマンド説明パラメータ
    local commandDescriptionKrParam=$4
    ### Japense Command Description Parameter / 일본어 명령어 설명 파라미터 / 日本語コマンド説明パラメータ
    local commandDescriptionJpParam=$5
    ### Command / 명령어 / コマンド
    local commandItem=$6
    ### Count / 번호 / 番号 
    local countNumber=0

    mkdir -p ${filePathParam%/}/tmp/${commandItem}/
    echo "testFile1,Command,data" > ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt
    echo "testFile2,Command,data" > ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile2.txt
    echo "testFile3,Command,data" > ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile3.txt
    old_LC_ALL=${LC_ALL}
    echo
    clear
    func_basicSetting_LogFileName_Path ${PID} "0" ${commandItem}
    printf "##############################################################################################\n"
    echo
    if [[ ${ouputLanguageParam} == [kK][rR] ]];then
        printf "  %-16s %s %s\n" "명령어" ":" "${commandItem}"
        printf "  %-17s %s %s\n" "기본설명" ":" "${commandDescriptionKrParam}" | sed 's/_/ /g'
        printf "  %-18s %s %s\n" "※사용법" ":" "${commandItem}_[옵션]_[인수]" | sed 's/_/ /g'
        printf "  %-17s %s %s\n" "※옵션" ":" "[-dr]" | sed 's/_/ /g'
        printf "  %-17s %s %s\n" "※인수" ":" "[파일경로]" | sed 's/_/ /g'
    elif [[ ${ouputLanguageParam} == [jJ][pP] ]];then
        printf "  %-17s %s %s\n" "コマンド" ":" "${commandItem}"
        printf "  %-17s %s %s\n" "基本説明" ":" "${commandDescriptionJpParam}" | sed 's/_/ /g'
        printf "  %-18s %s %s\n" "※使用法" ":" "${commandItem}_[オプション]_[引数]" | sed 's/_/ /g'
        printf "  %-20s %s %s\n" "※オプション" ":" "[-dr]" | sed 's/_/ /g'
        printf "  %-17s %s %s\n" "※引数" ":" "[ファイルパス]" | sed 's/_/ /g'
    else
        printf "  %-13s %s %s\n" "Command" ":" "${commandItem}"
        printf "  %-13s %s %s\n" "Description" ":" "${commandDescriptionEnParam}" | sed 's/_/ /g'
        printf "  %-15s %s %s\n" "※HowToUse" ":" "${commandItem}_[option]_[argument]" | sed 's/_/ /g'
        printf "  %-15s %s %s\n" "※option" ":" "[-dr]" | sed 's/_/ /g'
        printf "  %-15s %s %s\n" "※argument" ":" "[filePath]" | sed 's/_/ /g'
    fi
        echo
        printf "##############################################################################################\n"
        echo
    if [[ ${ouputLanguageParam} == [kK][rR] ]];then
        export LC_ALL="ko_KR.UTF-8"
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "gzip ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(예상)" ":" "파일 단위로 압축"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo "폴더 내 파일 확인"
            echo "대상 폴더 : ${filePathParam%/}/tmp/${commandItem}/"
            echo
            echo "${commandItem}_TestFile1.txt.gz"
            echo "${commandItem}_TestFile2.txt"
            echo "${commandItem}_TestFile3.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "gzip ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo "폴더 내 파일 확인"
            echo "대상 폴더 : ${filePathParam%/}/tmp/${commandItem}/"
            echo
            gzip ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt
            ls ${filePathParam%/}/tmp/${commandItem}/ | grep ${commandItem}_TestFile1.txt.gz
            ls ${filePathParam%/}/tmp/${commandItem}/ | grep ${commandItem}_TestFile2.txt
            ls ${filePathParam%/}/tmp/${commandItem}/ | grep ${commandItem}_TestFile3.txt
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "gzip -d ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt.gz"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(예상)" ":" "파일 단위로 압축 해제(gunzip)"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo "폴더 내 파일 확인"
            echo "대상 폴더 : ${filePathParam%/}/tmp/${commandItem}/"
            echo
            echo "${commandItem}_TestFile1.txt"
            echo "${commandItem}_TestFile2.txt"
            echo "${commandItem}_TestFile3.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "gzip -d ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt.gz"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo "폴더 내 파일 확인"
            echo "대상 폴더 : ${filePathParam%/}/tmp/${commandItem}/"
            echo
            gzip -d ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt.gz
            ls ${filePathParam%/}/tmp/${commandItem}/ | grep ${commandItem}_TestFile1.txt
            ls ${filePathParam%/}/tmp/${commandItem}/ | grep ${commandItem}_TestFile2.txt
            ls ${filePathParam%/}/tmp/${commandItem}/ | grep ${commandItem}_TestFile3.txt
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "gzip -r ${filePathParam%/}/tmp/${commandItem}/"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(예상)" ":" "하위 폴더내 모든 파일 압축"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo "폴더 내 파일 확인"
            echo "대상 폴더 : ${filePathParam%/}/tmp/${commandItem}/"
            echo
            echo "${commandItem}_TestFile1.txt.gz"
            echo "${commandItem}_TestFile2.txt.gz"
            echo "${commandItem}_TestFile3.txt.gz"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "gzip -r ${filePathParam%/}/tmp/${commandItem}/"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo "폴더 내 파일 확인"
            echo "대상 폴더 : ${filePathParam%/}/tmp/${commandItem}/"
            echo
            gzip -r ${filePathParam%/}/tmp/${commandItem}/
            ls ${filePathParam%/}/tmp/${commandItem}/ | grep ${commandItem}_TestFile1.txt.gz
            ls ${filePathParam%/}/tmp/${commandItem}/ | grep ${commandItem}_TestFile2.txt.gz
            ls ${filePathParam%/}/tmp/${commandItem}/ | grep ${commandItem}_TestFile3.txt.gz
        printf "#--------------------------------------------------------------------------------------------#\n"
    elif [[ ${ouputLanguageParam} == [jJ][pP] ]];then
        export LC_ALL="ja_JP.UTF-8"
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "gzip ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(予想)" ":" "ファイル単位で圧縮"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo "フォルダ内ファイル確認"
            echo "対象フォルダ : ${filePathParam%/}/tmp/${commandItem}/"
            echo
            echo "${commandItem}_TestFile1.txt.gz"
            echo "${commandItem}_TestFile2.txt"
            echo "${commandItem}_TestFile3.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "gzip ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo "フォルダ内ファイル確認"
            echo "対象フォルダ : ${filePathParam%/}/tmp/${commandItem}/"
            echo
            gzip ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt
            ls ${filePathParam%/}/tmp/${commandItem}/ | grep ${commandItem}_TestFile1.txt.gz
            ls ${filePathParam%/}/tmp/${commandItem}/ | grep ${commandItem}_TestFile2.txt
            ls ${filePathParam%/}/tmp/${commandItem}/ | grep ${commandItem}_TestFile3.txt
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "gzip -d ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt.gz"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(予想)" ":" "ファイル単位で解凍(gunzip)"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo "フォルダ内ファイル確認"
            echo "対象フォルダ : ${filePathParam%/}/tmp/${commandItem}/"
            echo
            echo "${commandItem}_TestFile1.txt"
            echo "${commandItem}_TestFile2.txt"
            echo "${commandItem}_TestFile3.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "gzip -d ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt.gz"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo "フォルダ内ファイル確認"
            echo "対象フォルダ : ${filePathParam%/}/tmp/${commandItem}/"
            echo
            gzip -d ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt.gz
            ls ${filePathParam%/}/tmp/${commandItem}/ | grep ${commandItem}_TestFile1.txt
            ls ${filePathParam%/}/tmp/${commandItem}/ | grep ${commandItem}_TestFile2.txt
            ls ${filePathParam%/}/tmp/${commandItem}/ | grep ${commandItem}_TestFile3.txt
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "gzip -r ${filePathParam%/}/tmp/${commandItem}/"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(予想)" ":" "サブフォルダー内のすべてのファイルを圧縮"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo "フォルダ内ファイル確認"
            echo "対象フォルダ : ${filePathParam%/}/tmp/${commandItem}/"
            echo
            echo "${commandItem}_TestFile1.txt.gz"
            echo "${commandItem}_TestFile2.txt.gz"
            echo "${commandItem}_TestFile3.txt.gz"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "gzip -r ${filePathParam%/}/tmp/${commandItem}/"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo "フォルダ内ファイル確認"
            echo "対象フォルダ : ${filePathParam%/}/tmp/${commandItem}/"
            echo
            gzip -r ${filePathParam%/}/tmp/${commandItem}/
            ls ${filePathParam%/}/tmp/${commandItem}/ | grep ${commandItem}_TestFile1.txt.gz
            ls ${filePathParam%/}/tmp/${commandItem}/ | grep ${commandItem}_TestFile2.txt.gz
            ls ${filePathParam%/}/tmp/${commandItem}/ | grep ${commandItem}_TestFile3.txt.gz
        printf "#--------------------------------------------------------------------------------------------#\n"
    else
        export LC_ALL="en_US.UTF-8"
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "gzip ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(expect)" ":" "Compress by file"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo "Checking files in folders"
            echo "Target Folder : ${filePathParam%/}/tmp/${commandItem}/"
            echo
            echo "${commandItem}_TestFile1.txt.gz"
            echo "${commandItem}_TestFile2.txt"
            echo "${commandItem}_TestFile3.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "gzip ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo "Checking files in folders"
            echo "Target Folder : ${filePathParam%/}/tmp/${commandItem}/"
            echo
            gzip ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt
            ls ${filePathParam%/}/tmp/${commandItem}/ | grep ${commandItem}_TestFile1.txt.gz
            ls ${filePathParam%/}/tmp/${commandItem}/ | grep ${commandItem}_TestFile2.txt
            ls ${filePathParam%/}/tmp/${commandItem}/ | grep ${commandItem}_TestFile3.txt
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "gzip -d ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt.gz"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(expect)" ":" "Uncompress by file(gunzip)"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo "Checking files in folders"
            echo "Target Folder : ${filePathParam%/}/tmp/${commandItem}/"
            echo
            echo "${commandItem}_TestFile1.txt"
            echo "${commandItem}_TestFile2.txt"
            echo "${commandItem}_TestFile3.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "gzip -d ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt.gz"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo "Checking files in folders"
            echo "Target Folder : ${filePathParam%/}/tmp/${commandItem}/"
            echo
            gzip -d ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt.gz
            ls ${filePathParam%/}/tmp/${commandItem}/ | grep ${commandItem}_TestFile1.txt
            ls ${filePathParam%/}/tmp/${commandItem}/ | grep ${commandItem}_TestFile2.txt
            ls ${filePathParam%/}/tmp/${commandItem}/ | grep ${commandItem}_TestFile3.txt
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "gzip -r ${filePathParam%/}/tmp/${commandItem}/"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(expect)" ":" "Compress all files in subfolders"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo "Checking files in folders"
            echo "Target Folder : ${filePathParam%/}/tmp/${commandItem}/"
            echo
            echo "${commandItem}_TestFile1.txt.gz"
            echo "${commandItem}_TestFile2.txt.gz"
            echo "${commandItem}_TestFile3.txt.gz"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "gzip -r ${filePathParam%/}/tmp/${commandItem}/"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo "Checking files in folders"
            echo "Target Folder : ${filePathParam%/}/tmp/${commandItem}/"
            echo
            gzip -r ${filePathParam%/}/tmp/${commandItem}/
            ls ${filePathParam%/}/tmp/${commandItem}/ | grep ${commandItem}_TestFile1.txt.gz
            ls ${filePathParam%/}/tmp/${commandItem}/ | grep ${commandItem}_TestFile2.txt.gz
            ls ${filePathParam%/}/tmp/${commandItem}/ | grep ${commandItem}_TestFile3.txt.gz
        printf "#--------------------------------------------------------------------------------------------#\n"
    fi
        echo
    printf "##############################################################################################\n"
    
    export LC_ALL=${old_LC_ALL}
    
    ### tmp Directory Delete / 임시 디렉토리 삭제 / 作業ディレクトリ削除
    rm -rf ${filePathParam%/}/tmp/${commandItem}/

    func_basicSetting_LogFileName_Path ${PID} "1" ${commandItem}
    echo 
    
}

#--------------------------------------------#
# Command : gunzip                           #
#--------------------------------------------#
function func_command_gunzip() {
    
    ### Language Parameter / 언어 파라미터 / 言語パラメータ
    local ouputLanguageParam=$1
    ### File Path Parameter / 파일 패스 파라미터 / ファイルパスパラメータ
    local filePathParam=$2
    ### English Command Description Parameter / 영어 명령어 설명 파라미터 / 英語コマンド説明パラメータ
    local commandDescriptionEnParam=$3
    ### Korean Command Description Parameter / 한국어 명령어 설명 파라미터 / 韓国語コマンド説明パラメータ
    local commandDescriptionKrParam=$4
    ### Japense Command Description Parameter / 일본어 명령어 설명 파라미터 / 日本語コマンド説明パラメータ
    local commandDescriptionJpParam=$5
    ### Command / 명령어 / コマンド
    local commandItem=$6
    ### Count / 번호 / 番号 
    local countNumber=0

    mkdir -p ${filePathParam%/}/tmp/${commandItem}/
    echo "testFile1,Command,data" > ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt
    echo "testFile2,Command,data" > ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile2.txt
    echo "testFile3,Command,data" > ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile3.txt
    gzip ${filePathParam%/}/tmp/${commandItem}/*
    old_LC_ALL=${LC_ALL}
    echo
    clear
    func_basicSetting_LogFileName_Path ${PID} "0" ${commandItem}
    printf "##############################################################################################\n"
    echo
    if [[ ${ouputLanguageParam} == [kK][rR] ]];then
        printf "  %-16s %s %s\n" "명령어" ":" "${commandItem}"
        printf "  %-17s %s %s\n" "기본설명" ":" "${commandDescriptionKrParam}" | sed 's/_/ /g'
        printf "  %-18s %s %s\n" "※사용법" ":" "${commandItem}_[옵션]_[인수]" | sed 's/_/ /g'
        printf "  %-17s %s %s\n" "※옵션" ":" "[-r]" | sed 's/_/ /g'
        printf "  %-17s %s %s\n" "※인수" ":" "[파일경로]" | sed 's/_/ /g'
    elif [[ ${ouputLanguageParam} == [jJ][pP] ]];then
        printf "  %-17s %s %s\n" "コマンド" ":" "${commandItem}"
        printf "  %-17s %s %s\n" "基本説明" ":" "${commandDescriptionJpParam}" | sed 's/_/ /g'
        printf "  %-18s %s %s\n" "※使用法" ":" "${commandItem}_[オプション]_[引数]" | sed 's/_/ /g'
        printf "  %-20s %s %s\n" "※オプション" ":" "[-r]" | sed 's/_/ /g'
        printf "  %-17s %s %s\n" "※引数" ":" "[ファイルパス]" | sed 's/_/ /g'
    else
        printf "  %-13s %s %s\n" "Command" ":" "${commandItem}"
        printf "  %-13s %s %s\n" "Description" ":" "${commandDescriptionEnParam}" | sed 's/_/ /g'
        printf "  %-15s %s %s\n" "※HowToUse" ":" "${commandItem}_[argument]_[argument]" | sed 's/_/ /g'
        printf "  %-15s %s %s\n" "※option" ":" "[-r]" | sed 's/_/ /g'
        printf "  %-15s %s %s\n" "※argument" ":" "[filePath]" | sed 's/_/ /g'
    fi
        echo
        printf "##############################################################################################\n"
        echo
    if [[ ${ouputLanguageParam} == [kK][rR] ]];then
        export LC_ALL="ko_KR.UTF-8"
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "gunzip ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt.gz"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(예상)" ":" "파일 단위로 압축 해제"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo "폴더 내 파일 확인"
            echo "대상 폴더 : ${filePathParam%/}/tmp/${commandItem}/"
            echo
            echo "${commandItem}_TestFile1.txt"
            echo "${commandItem}_TestFile2.txt.gz"
            echo "${commandItem}_TestFile3.txt.gz"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "gunzip ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt.gz"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo "폴더 내 파일 확인"
            echo "대상 폴더 : ${filePathParam%/}/tmp/${commandItem}/"
            echo
            gunzip ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt.gz
            ls ${filePathParam%/}/tmp/${commandItem}/ | grep ${commandItem}_TestFile1.txt
            ls ${filePathParam%/}/tmp/${commandItem}/ | grep ${commandItem}_TestFile2.txt.gz
            ls ${filePathParam%/}/tmp/${commandItem}/ | grep ${commandItem}_TestFile3.txt.gz
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "gunzip -r ${filePathParam%/}/tmp/${commandItem}/"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(예상)" ":" "하위 폴더내 모든 파일 압축해제"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo "폴더 내 파일 확인"
            echo "대상 폴더 : ${filePathParam%/}/tmp/${commandItem}/"
            echo
            echo "${commandItem}_TestFile1.txt"
            echo "${commandItem}_TestFile2.txt"
            echo "${commandItem}_TestFile3.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "gunzip -r ${filePathParam%/}/tmp/${commandItem}/"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo "폴더 내 파일 확인"
            echo "대상 폴더 : ${filePathParam%/}/tmp/${commandItem}/"
            echo
            gunzip -r ${filePathParam%/}/tmp/${commandItem}/
            ls ${filePathParam%/}/tmp/${commandItem}/ | grep ${commandItem}_TestFile1.txt
            ls ${filePathParam%/}/tmp/${commandItem}/ | grep ${commandItem}_TestFile2.txt
            ls ${filePathParam%/}/tmp/${commandItem}/ | grep ${commandItem}_TestFile3.txt
        printf "#--------------------------------------------------------------------------------------------#\n"
    elif [[ ${ouputLanguageParam} == [jJ][pP] ]];then
        export LC_ALL="ja_JP.UTF-8"
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "gunzip ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt.gz"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(予想)" ":" "ファイル単位で解凍"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo "フォルダ内ファイル確認"
            echo "対象フォルダ : ${filePathParam%/}/tmp/${commandItem}/"
            echo
            echo "${commandItem}_TestFile1.txt"
            echo "${commandItem}_TestFile2.txt.gz"
            echo "${commandItem}_TestFile3.txt.gz"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "gunzip ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt.gz"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo "フォルダ内ファイル確認"
            echo "対象フォルダ : ${filePathParam%/}/tmp/${commandItem}/"
            echo
            gunzip ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt.gz
            ls ${filePathParam%/}/tmp/${commandItem}/ | grep ${commandItem}_TestFile1.txt
            ls ${filePathParam%/}/tmp/${commandItem}/ | grep ${commandItem}_TestFile2.txt.gz
            ls ${filePathParam%/}/tmp/${commandItem}/ | grep ${commandItem}_TestFile3.txt.gz
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "gunzip -r ${filePathParam%/}/tmp/${commandItem}/"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(予想)" ":" "サブフォルダー内のすべてのファイルの解凍"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo "フォルダ内ファイル確認"
            echo "対象フォルダ : ${filePathParam%/}/tmp/${commandItem}/"
            echo
            echo "${commandItem}_TestFile1.txt"
            echo "${commandItem}_TestFile2.txt"
            echo "${commandItem}_TestFile3.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "gunzip -r ${filePathParam%/}/tmp/${commandItem}/"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo "フォルダ内ファイル確認"
            echo "対象フォルダ : ${filePathParam%/}/tmp/${commandItem}/"
            echo
            gunzip -r ${filePathParam%/}/tmp/${commandItem}/
            ls ${filePathParam%/}/tmp/${commandItem}/ | grep ${commandItem}_TestFile1.txt
            ls ${filePathParam%/}/tmp/${commandItem}/ | grep ${commandItem}_TestFile2.txt
            ls ${filePathParam%/}/tmp/${commandItem}/ | grep ${commandItem}_TestFile3.txt
        printf "#--------------------------------------------------------------------------------------------#\n"
    else
        export LC_ALL="en_US.UTF-8"
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "gunzip ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt.gz"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(expect)" ":" "Uncompress by file"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo "Checking files in folders"
            echo "Target Folder : ${filePathParam%/}/tmp/${commandItem}/"
            echo
            echo "${commandItem}_TestFile1.txt"
            echo "${commandItem}_TestFile2.txt.gz"
            echo "${commandItem}_TestFile3.txt.gz"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "gunzip ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt.gz"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo "Checking files in folders"
            echo "Target Folder : ${filePathParam%/}/tmp/${commandItem}/"
            echo
            gunzip ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt.gz
            ls ${filePathParam%/}/tmp/${commandItem}/ | grep ${commandItem}_TestFile1.txt
            ls ${filePathParam%/}/tmp/${commandItem}/ | grep ${commandItem}_TestFile2.txt.gz
            ls ${filePathParam%/}/tmp/${commandItem}/ | grep ${commandItem}_TestFile3.txt.gz
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "gunzip -r ${filePathParam%/}/tmp/${commandItem}/"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(expect)" ":" "Unzip all files in subfolders"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo "Checking files in folders"
            echo "Target Folder : ${filePathParam%/}/tmp/${commandItem}/"
            echo
            echo "${commandItem}_TestFile1.txt"
            echo "${commandItem}_TestFile2.txt"
            echo "${commandItem}_TestFile3.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "gunzip -r ${filePathParam%/}/tmp/${commandItem}/"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo "Checking files in folders"
            echo "Target Folder : ${filePathParam%/}/tmp/${commandItem}/"
            echo
            gunzip -r ${filePathParam%/}/tmp/${commandItem}/
            ls ${filePathParam%/}/tmp/${commandItem}/ | grep ${commandItem}_TestFile1.txt
            ls ${filePathParam%/}/tmp/${commandItem}/ | grep ${commandItem}_TestFile2.txt
            ls ${filePathParam%/}/tmp/${commandItem}/ | grep ${commandItem}_TestFile3.txt
        printf "#--------------------------------------------------------------------------------------------#\n"
    fi
        echo
    printf "##############################################################################################\n"
    
    export LC_ALL=${old_LC_ALL}

    ### tmp Directory Delete / 임시 디렉토리 삭제 / 作業ディレクトリ削除
    rm -rf ${filePathParam%/}/tmp/${commandItem}/

    func_basicSetting_LogFileName_Path ${PID} "1" ${commandItem}
    echo 
    
}

#--------------------------------------------#
# Command : zip                              #
#--------------------------------------------#
function func_command_zip() {
    
    ### Language Parameter / 언어 파라미터 / 言語パラメータ
    local ouputLanguageParam=$1
    ### File Path Parameter / 파일 패스 파라미터 / ファイルパスパラメータ
    local filePathParam=$2
    ### English Command Description Parameter / 영어 명령어 설명 파라미터 / 英語コマンド説明パラメータ
    local commandDescriptionEnParam=$3
    ### Korean Command Description Parameter / 한국어 명령어 설명 파라미터 / 韓国語コマンド説明パラメータ
    local commandDescriptionKrParam=$4
    ### Japense Command Description Parameter / 일본어 명령어 설명 파라미터 / 日本語コマンド説明パラメータ
    local commandDescriptionJpParam=$5
    ### Command / 명령어 / コマンド
    local commandItem=$6
    ### Count / 번호 / 番号 
    local countNumber=0

    mkdir -p ${filePathParam%/}/tmp/${commandItem}/test1/
    echo "testFile1,Command,data" > ${filePathParam%/}/tmp/${commandItem}/test1/${commandItem}_TestFile1.txt
    echo "testFile2,Command,data" > ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile2.txt
    echo "testFile3,Command,data" > ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile3.txt
    old_LC_ALL=${LC_ALL}
    echo
    clear
    func_basicSetting_LogFileName_Path ${PID} "0" ${commandItem}
    printf "##############################################################################################\n"
    echo
    if [[ ${ouputLanguageParam} == [kK][rR] ]];then
        printf "  %-16s %s %s\n" "명령어" ":" "${commandItem}"
        printf "  %-17s %s %s\n" "기본설명" ":" "${commandDescriptionKrParam}" | sed 's/_/ /g'
        printf "  %-18s %s %s\n" "※사용법" ":" "${commandItem}_[옵션]_[인수1]_[인수2]_[인수3]_..." | sed 's/_/ /g'
        printf "  %-17s %s %s\n" "※옵션" ":" "[-rjd]" | sed 's/_/ /g'
        printf "  %-17s %s %s\n" "※인수1" ":" "[압축 대상 파일 경로]" | sed 's/_/ /g'
        printf "  %-17s %s %s\n" "※인수2" ":" "[압축 파일 출력 경로]" | sed 's/_/ /g'
        printf "  %-17s %s %s\n" "※인수3" ":" "[압축 파일 출력 경로]" | sed 's/_/ /g'
    elif [[ ${ouputLanguageParam} == [jJ][pP] ]];then
        printf "  %-17s %s %s\n" "コマンド" ":" "${commandItem}"
        printf "  %-17s %s %s\n" "基本説明" ":" "${commandDescriptionJpParam}" | sed 's/_/ /g'
        printf "  %-18s %s %s\n" "※使用法" ":" "${commandItem}_[オプション]_[引数1]_[引数2]_[引数3]_..." | sed 's/_/ /g'
        printf "  %-20s %s %s\n" "※オプション" ":" "[-rjd]" | sed 's/_/ /g'
        printf "  %-17s %s %s\n" "※引数1" ":" "[圧縮対象ファイルパス]" | sed 's/_/ /g'
        printf "  %-17s %s %s\n" "※引数2" ":" "[圧縮ファイル出力パス]" | sed 's/_/ /g'
        printf "  %-17s %s %s\n" "※引数3" ":" "[圧縮ファイル出力パス]" | sed 's/_/ /g'
    else
        printf "  %-13s %s %s\n" "Command" ":" "${commandItem}"
        printf "  %-13s %s %s\n" "Description" ":" "${commandDescriptionEnParam}" | sed 's/_/ /g'
        printf "  %-15s %s %s\n" "※HowToUse" ":" "${commandItem}_[option]_[argument1]_[argument2]_[argument3]_..." | sed 's/_/ /g'
        printf "  %-15s %s %s\n" "※option" ":" "[-rjd]" | sed 's/_/ /g'
        printf "  %-15s %s %s\n" "※argument1" ":" "[compressed_file_path]" | sed 's/_/ /g'
        printf "  %-15s %s %s\n" "※argument2" ":" "[compressed_file_output_path]" | sed 's/_/ /g'
        printf "  %-15s %s %s\n" "※argument3" ":" "[compressed_file_output_path]" | sed 's/_/ /g'
    fi
        echo
        printf "##############################################################################################\n"
        echo
    if [[ ${ouputLanguageParam} == [kK][rR] ]];then
        export LC_ALL="ko_KR.UTF-8"
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "zip ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.zip ${filePathParam%/}/tmp/${commandItem}/test1/${commandItem}_TestFile1.txt ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile2.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(예상)" ":" "여러 파일 압축 (신규파일 adding)"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "  adding: ${filePathParam%/}/tmp/${commandItem}/test1/${commandItem}_TestFile1.txt"
            echo "  adding: ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile2.txt"
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "zip ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.zip ${filePathParam%/}/tmp/${commandItem}/test1/${commandItem}_TestFile1.txt ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile2.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            zip ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.zip ${filePathParam%/}/tmp/${commandItem}/test1/${commandItem}_TestFile1.txt ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile2.txt
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "zip ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.zip ${filePathParam%/}/tmp/${commandItem}/test1/${commandItem}_TestFile1.txt ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile2.txt ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile3.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(예상)" ":" "여러 파일 압축 (기존파일 updatng)"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "updating: ${filePathParam%/}/tmp/${commandItem}/test1/${commandItem}_TestFile1.txt"
            echo "updating: ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile2.txt"
            echo "  adding: ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile3.txt"
            echo 
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "zip ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.zip ${filePathParam%/}/tmp/${commandItem}/test1/${commandItem}_TestFile1.txt ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile2.txt ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile3.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            zip ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.zip ${filePathParam%/}/tmp/${commandItem}/test1/${commandItem}_TestFile1.txt ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile2.txt ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile3.txt
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-10s %s %-15s\n" "샘플${countNumber}" ":" "zip -r ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile_r.zip ${filePathParam%/}/tmp/${commandItem}/"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "출력결과(예상)" ":" "지정된 폴더의 모든 하위 구조 압축"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "  adding: ${filePathParam%/}/tmp/${commandItem}/"
            echo "  adding: ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.zip"
            echo "  adding: ${filePathParam%/}/tmp/${commandItem}/test1/"
            echo "  adding: ${filePathParam%/}/tmp/${commandItem}/test1/${commandItem}_TestFile1.txt"
            echo "  adding: ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile2.txt"
            echo "  adding: ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile3.txt"
            echo 
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "출력결과(실제)" ":" "zip -r ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile_r.zip ${filePathParam%/}/tmp/${commandItem}/"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            zip -r ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile_r.zip ${filePathParam%/}/tmp/${commandItem}/
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-10s %s %-15s\n" "샘플${countNumber}" ":" "zip -j ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile_j.zip ${filePathParam%/}/tmp/${commandItem}/*"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "출력결과(예상)" ":" "하위 폴더를 무시하고 파일만 압축"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "  adding: ${commandItem}_TestFile.zip"
            echo "  adding: ${commandItem}_TestFile2.txt"
            echo "  adding: ${commandItem}_TestFile3.txt"
            echo "  adding: ${commandItem}_TestFile_r.zip"
            echo 
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "출력결과(실제)" ":" "zip -j ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile_j.zip ${filePathParam%/}/tmp/${commandItem}/*"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            zip -j ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile_j.zip ${filePathParam%/}/tmp/${commandItem}/*
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-10s %s %-15s\n" "샘플${countNumber}" ":" "zip -d ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile_j.zip ${commandItem}_TestFile2.txt ${commandItem}_TestFile3.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "출력결과(예상)" ":" "zip파일 내부에서 지정 파일을 삭제"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "deleting: ${commandItem}_TestFile2.txt"
            echo "deleting: ${commandItem}_TestFile3.txt"
            echo 
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "출력결과(실제)" ":" "zip -d ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile_j.zip ${commandItem}_TestFile2.txt ${commandItem}_TestFile3.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            zip -d ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile_j.zip ${commandItem}_TestFile2.txt ${commandItem}_TestFile3.txt
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
    elif [[ ${ouputLanguageParam} == [jJ][pP] ]];then
        export LC_ALL="ja_JP.UTF-8"
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "zip ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.zip ${filePathParam%/}/tmp/${commandItem}/test1/${commandItem}_TestFile1.txt ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile2.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(予想)" ":" "複数ファイル圧縮(新規ファイルadding)"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "  adding: ${filePathParam%/}/tmp/${commandItem}/test1/${commandItem}_TestFile1.txt"
            echo "  adding: ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile2.txt"
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "zip ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.zip ${filePathParam%/}/tmp/${commandItem}/test1/${commandItem}_TestFile1.txt ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile2.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            zip ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.zip ${filePathParam%/}/tmp/${commandItem}/test1/${commandItem}_TestFile1.txt ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile2.txt
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "zip ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.zip ${filePathParam%/}/tmp/${commandItem}/test1/${commandItem}_TestFile1.txt ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile2.txt ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile3.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(予想)" ":" "複数ファイル圧縮(既存ファイルupdatng)"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "updating: ${filePathParam%/}/tmp/${commandItem}/test1/${commandItem}_TestFile1.txt"
            echo "updating: ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile2.txt"
            echo "  adding: ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile3.txt"
            echo 
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "zip ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.zip ${filePathParam%/}/tmp/${commandItem}/test1/${commandItem}_TestFile1.txt ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile2.txt ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile3.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            zip ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.zip ${filePathParam%/}/tmp/${commandItem}/test1/${commandItem}_TestFile1.txt ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile2.txt ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile3.txt
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-10s %s %-15s\n" "サンプル${countNumber}" ":" "zip -r ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile_r.zip ${filePathParam%/}/tmp/${commandItem}/"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "出力結果(予想)" ":" "指定されたフォルダー内のすべてのサブ構造圧"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "  adding: ${filePathParam%/}/tmp/${commandItem}/"
            echo "  adding: ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.zip"
            echo "  adding: ${filePathParam%/}/tmp/${commandItem}/test1/"
            echo "  adding: ${filePathParam%/}/tmp/${commandItem}/test1/${commandItem}_TestFile1.txt"
            echo "  adding: ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile2.txt"
            echo "  adding: ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile3.txt"
            echo 
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "出力結果(実際)" ":" "zip -r ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile_r.zip ${filePathParam%/}/tmp/${commandItem}/"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            zip -r ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile_r.zip ${filePathParam%/}/tmp/${commandItem}/
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-10s %s %-15s\n" "サンプル${countNumber}" ":" "zip -j ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile_j.zip ${filePathParam%/}/tmp/${commandItem}/*"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "出力結果(予想)" ":" "サブフォルダーを無視してファイルのみを圧縮"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "  adding: ${commandItem}_TestFile.zip"
            echo "  adding: ${commandItem}_TestFile2.txt"
            echo "  adding: ${commandItem}_TestFile3.txt"
            echo "  adding: ${commandItem}_TestFile_r.zip"
            echo 
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "出力結果(実際)" ":" "zip -j ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile_j.zip ${filePathParam%/}/tmp/${commandItem}/*"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            zip -j ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile_j.zip ${filePathParam%/}/tmp/${commandItem}/*
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-10s %s %-15s\n" "サンプル${countNumber}" ":" "zip -d ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile_j.zip ${commandItem}_TestFile2.txt ${commandItem}_TestFile3.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "出力結果(予想)" ":" "zipファイルの内部から指定ファイルを削除"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "deleting: ${commandItem}_TestFile2.txt"
            echo "deleting: ${commandItem}_TestFile3.txt"
            echo 
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "出力結果(実際)" ":" "zip -d ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile_j.zip ${commandItem}_TestFile2.txt ${commandItem}_TestFile3.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            zip -d ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile_j.zip ${commandItem}_TestFile2.txt ${commandItem}_TestFile3.txt
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
    else
        export LC_ALL="en_US.UTF-8"
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "zip ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.zip ${filePathParam%/}/tmp/${commandItem}/test1/${commandItem}_TestFile1.txt ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile2.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(expect)" ":" "Compress multiple files (new file adding)"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "  adding: ${filePathParam%/}/tmp/${commandItem}/test1/${commandItem}_TestFile1.txt"
            echo "  adding: ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile2.txt"
            echo 
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "zip ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.zip ${filePathParam%/}/tmp/${commandItem}/test1/ ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile2.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            zip ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.zip ${filePathParam%/}/tmp/${commandItem}/test1/${commandItem}_TestFile1.txt ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile2.txt
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "zip ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.zip ${filePathParam%/}/tmp/${commandItem}/test1/${commandItem}_TestFile1.txt ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile2.txt ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile3.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(expect)" ":" "Compress multiple files (existing files updateng)"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "updating: ${filePathParam%/}/tmp/${commandItem}/test1/${commandItem}_TestFile1.txt"
            echo "updating: ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile2.txt"
            echo "  adding: ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile3.txt"
            echo 
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "zip ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.zip ${filePathParam%/}/tmp/${commandItem}/test1/${commandItem}_TestFile1.txt ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile2.txt ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile3.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            zip ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.zip ${filePathParam%/}/tmp/${commandItem}/test1/${commandItem}_TestFile1.txt ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile2.txt ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile3.txt
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "zip -r ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile_r.zip ${filePathParam%/}/tmp/${commandItem}/"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(expect)" ":" "Compress all substructures in the specified folder"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "  adding: ${filePathParam%/}/tmp/${commandItem}/"
            echo "  adding: ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.zip"
            echo "  adding: ${filePathParam%/}/tmp/${commandItem}/test1/"
            echo "  adding: ${filePathParam%/}/tmp/${commandItem}/test1/${commandItem}_TestFile1.txt"
            echo "  adding: ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile2.txt"
            echo "  adding: ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile3.txt"
            echo 
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "zip -r ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile_r.zip ${filePathParam%/}/tmp/${commandItem}/"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            zip -r ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile_r.zip ${filePathParam%/}/tmp/${commandItem}/
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "zip -j ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile_j.zip ${filePathParam%/}/tmp/${commandItem}/*"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(expect)" ":" "Ignore subfolders and compress only files"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "  adding: ${commandItem}_TestFile.zip"
            echo "  adding: ${commandItem}_TestFile2.txt"
            echo "  adding: ${commandItem}_TestFile3.txt"
            echo "  adding: ${commandItem}_TestFile_r.zip"
            echo 
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "zip -j ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile_j.zip ${filePathParam%/}/tmp/${commandItem}/*"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            zip -j ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile_j.zip ${filePathParam%/}/tmp/${commandItem}/*
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "zip -d ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile_j.zip ${commandItem}_TestFile2.txt ${commandItem}_TestFile3.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(expect)" ":" "Delete the specified file from inside the zip file"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "deleting: ${commandItem}_TestFile2.txt"
            echo "deleting: ${commandItem}_TestFile3.txt"
            echo 
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "zip -d ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile_j.zip ${commandItem}_TestFile2.txt ${commandItem}_TestFile3.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            zip -d ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile_j.zip ${commandItem}_TestFile2.txt ${commandItem}_TestFile3.txt
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
    fi
        echo
    printf "##############################################################################################\n"
    
    export LC_ALL=${old_LC_ALL}

    ### tmp Directory Delete / 임시 디렉토리 삭제 / 作業ディレクトリ削除
    rm -rf ${filePathParam%/}/tmp/${commandItem}/

    func_basicSetting_LogFileName_Path ${PID} "1" ${commandItem}
    echo 
    
}

#--------------------------------------------#
# Command : unzip                              #
#--------------------------------------------#
function func_command_unzip() {
    
    ### Language Parameter / 언어 파라미터 / 言語パラメータ
    local ouputLanguageParam=$1
    ### File Path Parameter / 파일 패스 파라미터 / ファイルパスパラメータ
    local filePathParam=$2
    ### English Command Description Parameter / 영어 명령어 설명 파라미터 / 英語コマンド説明パラメータ
    local commandDescriptionEnParam=$3
    ### Korean Command Description Parameter / 한국어 명령어 설명 파라미터 / 韓国語コマンド説明パラメータ
    local commandDescriptionKrParam=$4
    ### Japense Command Description Parameter / 일본어 명령어 설명 파라미터 / 日本語コマンド説明パラメータ
    local commandDescriptionJpParam=$5
    ### Command / 명령어 / コマンド
    local commandItem=$6
    ### Count / 번호 / 番号 
    local countNumber=0

    mkdir -p ${filePathParam%/}/tmp/${commandItem}/test1/
    mkdir -p ${filePathParam%/}/tmp/${commandItem}/test2/
    echo "testFile1,Command,data" > ${filePathParam%/}/tmp/${commandItem}/test1/${commandItem}_TestFile1.txt
    echo "testFile2,Command,data" > ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile2.txt
    echo "testFile3,Command,data" > ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile3.txt
    zip -jr ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile_jr.zip ${filePathParam%/}/tmp/${commandItem}/
    old_LC_ALL=${LC_ALL}
    echo
    clear
    func_basicSetting_LogFileName_Path ${PID} "0" ${commandItem}
    printf "##############################################################################################\n"
    echo
    if [[ ${ouputLanguageParam} == [kK][rR] ]];then
        printf "  %-16s %s %s\n" "명령어" ":" "${commandItem}"
        printf "  %-17s %s %s\n" "기본설명" ":" "${commandDescriptionKrParam}" | sed 's/_/ /g'
        printf "  %-18s %s %s\n" "※사용법" ":" "${commandItem}_[옵션]_[인수1]_[인수2]" | sed 's/_/ /g'
        printf "  %-17s %s %s\n" "※옵션" ":" "[-ld]" | sed 's/_/ /g'
        printf "  %-17s %s %s\n" "※인수1" ":" "[압축 파일 파일 경로]" | sed 's/_/ /g'
        printf "  %-17s %s %s\n" "※인수2" ":" "[압축 해제 경로]" | sed 's/_/ /g'
    elif [[ ${ouputLanguageParam} == [jJ][pP] ]];then
        printf "  %-17s %s %s\n" "コマンド" ":" "${commandItem}"
        printf "  %-17s %s %s\n" "基本説明" ":" "${commandDescriptionJpParam}" | sed 's/_/ /g'
        printf "  %-18s %s %s\n" "※使用法" ":" "${commandItem}_[オプション]_[引数1]_[引数2]" | sed 's/_/ /g'
        printf "  %-20s %s %s\n" "※オプション" ":" "[-ld]" | sed 's/_/ /g'
        printf "  %-17s %s %s\n" "※引数1" ":" "[圧縮ファイル出力パス]" | sed 's/_/ /g'
        printf "  %-17s %s %s\n" "※引数2" ":" "[ファイル解凍パス]" | sed 's/_/ /g'
    else
        printf "  %-13s %s %s\n" "Command" ":" "${commandItem}"
        printf "  %-13s %s %s\n" "Description" ":" "${commandDescriptionEnParam}" | sed 's/_/ /g'
        printf "  %-15s %s %s\n" "※HowToUse" ":" "${commandItem}_[option]_[argument1]_[argument2]" | sed 's/_/ /g'
        printf "  %-15s %s %s\n" "※option" ":" "[-ld]" | sed 's/_/ /g'
        printf "  %-15s %s %s\n" "※argument1" ":" "[compressed_file_output_path]" | sed 's/_/ /g'
        printf "  %-15s %s %s\n" "※argument2" ":" "[decompression_path]" | sed 's/_/ /g'
    fi
        echo
        printf "##############################################################################################\n"
        echo
    if [[ ${ouputLanguageParam} == [kK][rR] ]];then
        export LC_ALL="ko_KR.UTF-8"
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "unzip ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile_jr.zip"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(예상)" ":" "현재 폴더에 압축 해제"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "extracting: ${commandItem}_TestFile2.txt"
            echo "extracting: ${commandItem}_TestFile3.txt"
            echo "extracting: ${commandItem}_TestFile1.txt"
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "unzip ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile_jr.zip"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            unzip ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile_jr.zip
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "unzip -l ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile_jr.zip"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(예상)" ":" "압축 파일 내용 출력"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "  Length      Date    Time    Name"
            echo "---------  ---------- -----   ----"
            echo "       23  MM-DD-YYYY hh:mm   unzip_TestFile2.txt"
            echo "       23  MM-DD-YYYY hh:mm   unzip_TestFile3.txt"
            echo "       23  MM-DD-YYYY hh:mm   unzip_TestFile1.txt"
            echo "---------                     -------"
            echo "       69                     n files"
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "unzip -l ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile_jr.zip"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            unzip -l ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile_jr.zip
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "unzip ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile_jr.zip -d ${filePathParam%/}/tmp/${commandItem}/test2/"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(예상)" ":" "지정된 폴더에 압축 해제"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "extracting: ${filePathParam%/}/tmp/${commandItem}/test2/${commandItem}_TestFile2.txt"
            echo "extracting: ${filePathParam%/}/tmp/${commandItem}/test2/${commandItem}_TestFile3.txt"
            echo "extracting: ${filePathParam%/}/tmp/${commandItem}/test2/${commandItem}_TestFile1.txt"
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "unzip ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile_jr.zip -d ${filePathParam%/}/tmp/${commandItem}/test2/"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            unzip ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile_jr.zip -d ${filePathParam%/}/tmp/${commandItem}/test2/
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
    elif [[ ${ouputLanguageParam} == [jJ][pP] ]];then
        export LC_ALL="ja_JP.UTF-8"
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "unzip ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile_jr.zip"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(予想)" ":" "現在のフォルダへの解凍"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "extracting: ${commandItem}_TestFile2.txt"
            echo "extracting: ${commandItem}_TestFile3.txt"
            echo "extracting: ${commandItem}_TestFile1.txt"
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "unzip ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile_jr.zip"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            unzip ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile_jr.zip
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "unzip -l ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile_jr.zip"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(予想)" ":" "圧縮ファイルの内容出力"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "  Length      Date    Time    Name"
            echo "---------  ---------- -----   ----"
            echo "       23  MM-DD-YYYY hh:mm   unzip_TestFile2.txt"
            echo "       23  MM-DD-YYYY hh:mm   unzip_TestFile3.txt"
            echo "       23  MM-DD-YYYY hh:mm   unzip_TestFile1.txt"
            echo "---------                     -------"
            echo "       69                     n files"
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "unzip -l ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile_jr.zip"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            unzip -l ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile_jr.zip
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "unzip ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile_jr.zip -d ${filePathParam%/}/tmp/${commandItem}/test2/"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(予想)" ":" "指定されたフォルダへの解凍"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "extracting: ${filePathParam%/}/tmp/${commandItem}/test2/${commandItem}_TestFile2.txt"
            echo "extracting: ${filePathParam%/}/tmp/${commandItem}/test2/${commandItem}_TestFile3.txt"
            echo "extracting: ${filePathParam%/}/tmp/${commandItem}/test2/${commandItem}_TestFile1.txt"
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "unzip ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile_jr.zip -d ${filePathParam%/}/tmp/${commandItem}/test2/"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            unzip ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile_jr.zip -d ${filePathParam%/}/tmp/${commandItem}/test2/
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
    else
        export LC_ALL="en_US.UTF-8"
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "unzip ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile_jr.zip"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(expect)" ":" "Compressed File Content Output"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "extracting: ${commandItem}_TestFile2.txt"
            echo "extracting: ${commandItem}_TestFile3.txt"
            echo "extracting: ${commandItem}_TestFile1.txt"
            echo 
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "unzip ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile_jr.zip"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            unzip ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile_jr.zip
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "unzip -l ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile_jr.zip"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(expect)" ":" "Unzip to the current folder"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "  Length      Date    Time    Name"
            echo "---------  ---------- -----   ----"
            echo "       23  MM-DD-YYYY hh:mm   unzip_TestFile2.txt"
            echo "       23  MM-DD-YYYY hh:mm   unzip_TestFile3.txt"
            echo "       23  MM-DD-YYYY hh:mm   unzip_TestFile1.txt"
            echo "---------                     -------"
            echo "       69                     n files"
            echo 
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "unzip -l ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile_jr.zip"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            unzip -l ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile_jr.zip
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "unzip ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile_jr.zip -d ${filePathParam%/}/tmp/${commandItem}/test2/"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(expect)" ":" "Unzip to the specified folder"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "extracting: ${filePathParam%/}/tmp/${commandItem}/test2/${commandItem}_TestFile2.txt"
            echo "extracting: ${filePathParam%/}/tmp/${commandItem}/test2/${commandItem}_TestFile3.txt"
            echo "extracting: ${filePathParam%/}/tmp/${commandItem}/test2/${commandItem}_TestFile1.txt"
            echo 
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "unzip ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile_jr.zip -d ${filePathParam%/}/tmp/${commandItem}/test2/"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            unzip ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile_jr.zip -d ${filePathParam%/}/tmp/${commandItem}/test2/
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
    fi
        echo
    printf "##############################################################################################\n"
    
    export LC_ALL=${old_LC_ALL}

    ### tmp Directory Delete / 임시 디렉토리 삭제 / 作業ディレクトリ削除
    rm -rf ${filePathParam%/}/tmp/${commandItem}/
    rm -rf ./${commandItem}_TestFile2.txt
    rm -rf ./${commandItem}_TestFile3.txt
    rm -rf ./${commandItem}_TestFile1.txt

    func_basicSetting_LogFileName_Path ${PID} "1" ${commandItem}
    echo 
    
}

#--------------------------------------------#
# Command : date                              #
#--------------------------------------------#
function func_command_date() {
    
    ### Language Parameter / 언어 파라미터 / 言語パラメータ
    local ouputLanguageParam=$1
    ### File Path Parameter / 파일 패스 파라미터 / ファイルパスパラメータ
    local filePathParam=$2
    ### English Command Description Parameter / 영어 명령어 설명 파라미터 / 英語コマンド説明パラメータ
    local commandDescriptionEnParam=$3
    ### Korean Command Description Parameter / 한국어 명령어 설명 파라미터 / 韓国語コマンド説明パラメータ
    local commandDescriptionKrParam=$4
    ### Japense Command Description Parameter / 일본어 명령어 설명 파라미터 / 日本語コマンド説明パラメータ
    local commandDescriptionJpParam=$5
    ### Command / 명령어 / コマンド
    local commandItem=$6
    ### Count / 번호 / 番号 
    local countNumber=0

    old_LC_ALL=${LC_ALL}
    echo
    clear
    func_basicSetting_LogFileName_Path ${PID} "0" ${commandItem}
    printf "##############################################################################################\n"
    echo
    if [[ ${ouputLanguageParam} == [kK][rR] ]];then
        printf "  %-16s %s %s\n" "명령어" ":" "${commandItem}"
        printf "  %-17s %s %s\n" "기본설명" ":" "${commandDescriptionKrParam}" | sed 's/_/ /g'
        printf "  %-18s %s %s\n" "※사용법" ":" "${commandItem}_[인수1]" | sed 's/_/ /g'
        printf "  %-17s %s %s\n" "※인수1" ":" "[출력 날짜 형식]" | sed 's/_/ /g'
    elif [[ ${ouputLanguageParam} == [jJ][pP] ]];then
        printf "  %-17s %s %s\n" "コマンド" ":" "${commandItem}"
        printf "  %-17s %s %s\n" "基本説明" ":" "${commandDescriptionJpParam}" | sed 's/_/ /g'
        printf "  %-18s %s %s\n" "※使用法" ":" "${commandItem}_[引数1]" | sed 's/_/ /g'
        printf "  %-17s %s %s\n" "※引数1" ":" "[出力日付形式]" | sed 's/_/ /g'
    else
        printf "  %-13s %s %s\n" "Command" ":" "${commandItem}"
        printf "  %-13s %s %s\n" "Description" ":" "${commandDescriptionEnParam}" | sed 's/_/ /g'
        printf "  %-15s %s %s\n" "※HowToUse" ":" "${commandItem}_[argument1]" | sed 's/_/ /g'
        printf "  %-15s %s %s\n" "※argument1" ":" "[Output_Date_Format]" | sed 's/_/ /g'
    fi
        echo
        printf "##############################################################################################\n"
        echo
    if [[ ${ouputLanguageParam} == [kK][rR] ]];then
        export LC_ALL="ko_KR.UTF-8"
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "date"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(예상)" ":" "표준 형식 날짜 출력"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo ' export LC_ALL="ko_KR.UTF-8" '
            export LC_ALL="ko_KR.UTF-8"
            echo "[YYYY]년 [M]월  [D]일 [X]요일 [hh]시 [mm]분 [ss]초 JST"
            echo "2024년 3월  1일 금요일 21시 35분 28초 JST"
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "date"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            date
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "date +%c"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(예상)" ":" "표준 형식 날짜 출력(간소화)"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "[X]  [M]/ [D] [hh]:[mm]:[ss] [YYYY]"
            echo "금  3/ 1 21:35:28 2024"
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "date '+%c'"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            date '+%c'
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "date +%F"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "date +%D"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "date +%x"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(예상)" ":" "날짜 출력"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "YYYY-MM-DD : 2024-03-01"
            echo "MM/DD/YY : 03/01/24"
            echo "MM/DD/YYYY : 03/01/2024"
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "date '+%F'"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "date '+%D'"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "date '+%x'"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            date '+%F'
            date '+%D'
            date '+%x'
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "date +%Y"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "date +%y"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "date +%C"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(예상)" ":" "연도 출력"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "YYYY : 2024"
            echo "  YY :   24"
            echo "YY   : 20  "
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "date '+%Y'"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "date '+%y'"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "date '+%C'"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            date '+%Y'
            date '+%y'
            date '+%C'
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "date +%m"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "date +%B"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "date +%b"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "date +%h"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(예상)" ":" "월 출력"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "03"
            echo "3월"
            echo "3"
            echo "3"
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "date '+%m'"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "date '+%B'"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "date '+%b'"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "date '+%h'"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            date '+%m'
            date '+%B'
            date '+%b'
            date '+%h'
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "date +%d"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "date +%_d"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "date +%e"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(예상)" ":" "월 출력"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "03"
            echo "3"
            echo "3"
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "date '+%d'"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "date '+%_d'"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "date '+%e'"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            date '+%d'
            date '+%_d'
            date '+%e'
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "date +%A"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "date +%a"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "date +%u"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "date +%w"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(예상)" ":" "요일 출력"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "일요일"
            echo "일"
            echo "7 : 1(Mon)~7(Sun)"
            echo "0 : 0(Sun)~6(Mon)"
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "date '+%A'"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "date '+%a'"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "date '+%u'"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "date '+%w'"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            date '+%A'
            date '+%a'
            date '+%u'
            date '+%w'
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "date +%p"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(예상)" ":" "AM/PM 출력"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "PM"
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "date '+%p'"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            date '+%p'
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "date +%H"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "date +%I"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "date +%k"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "date +%l"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(예상)" ":" "시간 출력"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "01 : (2桁 24時)"
            echo "01 : (2桁 12時)"
            echo " 1 : (1桁 24時)"
            echo " 1 : (1桁 12時)"
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "date '+%H'"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "date '+%I'"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "date '+%k'"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "date '+%l'"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            date '+%H'
            date '+%I'
            date '+%k'
            date '+%l'
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "date +%M"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "date +%_M"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(예상)" ":" "분출력"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "01 : (2분)"
            echo " 1 : (1분)"
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "date '+%M'"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "date '+%_M'"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            date '+%M'
            date '+%_M'
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "date +%S"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "date +%_S"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(예상)" ":" "초출력"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "01 : (2자리수)"
            echo " 1 : (1자리수)"
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "date '+%S'"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "date '+%_S'"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            date '+%S'
            date '+%_S'
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "date +%z"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "date +%Z"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(예상)" ":" "타임존출력"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "+0900"
            echo "JST"
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "date '+%z'"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "date '+%Z'"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            date '+%z'
            date '+%Z'
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
    elif [[ ${ouputLanguageParam} == [jJ][pP] ]];then
        export LC_ALL="ja_JP.UTF-8"
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "date"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(予想)" ":" "標準形式日付出力"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo ' export LC_ALL="ja_JP.UTF-8" '
            export LC_ALL="ja_JP.UTF-8"
            echo "[YYYY]年 [M]月 [D]日 [X]曜日 [hh]時[mm]分[ss]秒 JST"
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "date"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            date
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "date '+%c'"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(予想)" ":" "標準形式日付出力(簡略)"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "[X]  [M]/ [D] [hh]:[mm]:[ss] [YYYY]"
            echo "金  3/ 1 21:35:28 2024"
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "date '+%c'"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            date '+%c'
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "date '+%F'"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "date '+%D'"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "date '+%x'"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(予想)" ":" "日付出力"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "YYYY-MM-DD : 2024-03-01"
            echo "MM/DD/YY : 03/01/24"
            echo "MM/DD/YYYY : 03/01/2024"
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "date '+%F'"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "date '+%D'"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "date '+%x'"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            date '+%F'
            date '+%D'
            date '+%x'
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "date '+%Y'"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "date '+%y'"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "date '+%C'"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(予想)" ":" "年度出力"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "YYYY : 2024"
            echo "  YY : 24"
            echo "YY   : 20"
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "date '+%Y'"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "date '+%y'"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "date '+%C'"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            date '+%Y'
            date '+%y'
            date '+%C'
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "date '+%m'"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "date '+%B'"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "date '+%b'"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "date '+%h'"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(予想)" ":" "月出力"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "03"
            echo "3月"
            echo "3"
            echo "3"
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "date '+%m'"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "date '+%B'"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "date '+%b'"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "date '+%h'"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            date '+%m'
            date '+%B'
            date '+%b'
            date '+%h'
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "date '+%d'"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "date '+%_d'"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "date '+%e'"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(予想)" ":" "日出力"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "03"
            echo " 3"
            echo " 3"
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "date '+%d'"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "date '+%_d'"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "date '+%e'"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            date '+%d'
            date '+%_d'
            date '+%e'
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "date '+%A'"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "date '+%a'"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "date '+%u'"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "date '+%w'"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(予想)" ":" "曜日出力"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "日曜日"
            echo "日"
            echo "7 : 1(Mon)~7(Sun)"
            echo "0 : 0(Sun)~6(Mon)"
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "date '+%A'"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "date '+%a'"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "date '+%u'"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "date '+%w'"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            date '+%A'
            date '+%a'
            date '+%u'
            date '+%w'
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "date '+%p'"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(予想)" ":" "AM/PM出力"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "PM"
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "date '+%p'"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            date '+%p'
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "date '+%H'"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "date '+%I'"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "date '+%k'"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "date '+%l'"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(予想)" ":" "時出力"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "01 : (2桁 24時)"
            echo "01 : (2桁 12時)"
            echo " 1 : (1桁 24時)"
            echo " 1 : (1桁 12時)"
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "date '+%H'"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "date '+%I'"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "date '+%k'"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "date '+%l'"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            date '+%H'
            date '+%I'
            date '+%k'
            date '+%l'
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "date '+%M'"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "date '+%_M'"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(予想)" ":" "分出力"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "01 : (2桁 分)"
            echo " 1 : (1桁 分)"
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "date '+%M'"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "date '+%_M'"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            date '+%M'
            date '+%_M'
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "date '+%S'"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "date '+%_S'"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(予想)" ":" "秒出力"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "01 : (2桁)"
            echo " 1 : (1桁)"
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "date '+%S'"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "date '+%_S'"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            date '+%S'
            date '+%_S'
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "date '+%z'"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "date '+%Z'"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(予想)" ":" "タイムゾーン出力"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "+0900"
            echo "JST"
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "date '+%z'"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "date '+%Z'"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            date '+%z'
            date '+%Z'
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
    else
        export LC_ALL="en_US.UTF-8"
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "date"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(expect)" ":" "Standard Format Date Output"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo ' export LC_ALL="en_US.UTF-8" '
            export LC_ALL="en_US.UTF-8"
            echo "[the week] [Months] [Days] [hh]:[mm]:[ss] JST [YYYY]"
            echo 
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "date"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            date
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "date '+%c'"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(expect)" ":" "Standard Format Date Output(simplify)"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "[X]  [M] [D] [hh]:[mm]:[ss] [YYYY]"
            echo "Fri Mar 1 21:35:28 2024"
            echo 
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "date '+%c'"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            date '+%c'
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "date '+%F'"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "date '+%D'"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "date '+%x'"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(expect)" ":" "Date Output"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "YYYY-MM-DD : 2024-03-01"
            echo "MM/DD/YY : 03/01/24"
            echo "MM/DD/YYYY : 03/01/2024"
            echo 
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "date '+%F'"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "date '+%D'"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "date '+%x'"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            date '+%F'
            date '+%D'
            date '+%x'
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "date '+%Y'"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "date '+%y'"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "date '+%C'"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(expect)" ":" "Year Output"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "YYYY : 2024"
            echo "  YY :   24"
            echo "YY   : 20  "
            echo 
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "date '+%Y'"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "date '+%y'"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "date '+%C'"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            date '+%Y'
            date '+%y'
            date '+%C'
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "date '+%m'"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "date '+%B'"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "date '+%b'"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "date '+%h'"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(expect)" ":" "Months Output"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "03"
            echo "March"
            echo "Mar"
            echo "Mar"
            echo 
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "date '+%m'"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "date '+%B'"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "date '+%b'"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "date '+%h'"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            date '+%m'
            date '+%B'
            date '+%b'
            date '+%h'
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "date '+%d'"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "date '+%_d'"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "date '+%e'"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(expect)" ":" "Days Output"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "03"
            echo " 3"
            echo " 3"
            echo 
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "date '+%d'"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "date '+%_d'"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "date '+%e'"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            date '+%d'
            date '+%_d'
            date '+%e'
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "date '+%A'"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "date '+%a'"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "date '+%u'"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "date '+%w'"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(expect)" ":" "Weeks Output"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "Sunday"
            echo "Sun"
            echo "7 : 1(Mon)~7(Sun)"
            echo "0 : 0(Sun)~6(Mon)"
            echo 
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "date '+%A'"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "date '+%a'"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "date '+%u'"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "date '+%w'"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            date '+%A'
            date '+%a'
            date '+%u'
            date '+%w'
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "date '+%p'"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(expect)" ":" "AM/PM Output"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "PM"
            echo 
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "date '+%p'"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            date '+%p'
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "date '+%H'"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "date '+%I'"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "date '+%k'"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "date '+%l'"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(expect)" ":" "hours Output"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "01 : (2 words 24hours)"
            echo "01 : (2 words 12hours)"
            echo " 1 : (1 words 24hours)"
            echo " 1 : (1 words 12hours)"
            echo 
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "date '+%H'"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "date '+%I'"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "date '+%k'"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "date '+%l'"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            date '+%H'
            date '+%I'
            date '+%k'
            date '+%l'
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "date '+%M'"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "date '+%_M'"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(expect)" ":" "Minutes Output"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "01 : (2 words)"
            echo " 1 : (1 words)"
            echo 
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "date '+%M'"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "date '+%_M'"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            date '+%M'
            date '+%_M'
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "date '+%S'"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "date '+%_S'"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(expect)" ":" "Seconds Output"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "01 : (2 words)"
            echo " 1 : (1 words)"
            echo 
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "date '+%S'"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "date '+%_S'"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            date '+%S'
            date '+%_S'
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "date '+%z'"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "date '+%Z'"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(expect)" ":" "Timezone Output"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "+0900"
            echo "JST"
            echo 
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "date '+%z'"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "date '+%Z'"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            date '+%z'
            date '+%Z'
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
    fi
        echo
    printf "##############################################################################################\n"
    
    export LC_ALL=${old_LC_ALL}

    ### tmp Directory Delete / 임시 디렉토리 삭제 / 作業ディレクトリ削除
    #rm -rf ${filePathParam%/}/tmp/${commandItem}/

    func_basicSetting_LogFileName_Path ${PID} "1" ${commandItem}
    echo 
    
}

#--------------------------------------------#
# Command : cal                              #
#--------------------------------------------#
function func_command_cal() {
    
    ### Language Parameter / 언어 파라미터 / 言語パラメータ
    local ouputLanguageParam=$1
    ### File Path Parameter / 파일 패스 파라미터 / ファイルパスパラメータ
    local filePathParam=$2
    ### English Command Description Parameter / 영어 명령어 설명 파라미터 / 英語コマンド説明パラメータ
    local commandDescriptionEnParam=$3
    ### Korean Command Description Parameter / 한국어 명령어 설명 파라미터 / 韓国語コマンド説明パラメータ
    local commandDescriptionKrParam=$4
    ### Japense Command Description Parameter / 일본어 명령어 설명 파라미터 / 日本語コマンド説明パラメータ
    local commandDescriptionJpParam=$5
    ### Command / 명령어 / コマンド
    local commandItem=$6
    ### Count / 번호 / 番号 
    local countNumber=0

    old_LC_ALL=${LC_ALL}
    echo
    clear
    func_basicSetting_LogFileName_Path ${PID} "0" ${commandItem}
    printf "##############################################################################################\n"
    echo
    if [[ ${ouputLanguageParam} == [kK][rR] ]];then
        printf "  %-16s %s %s\n" "명령어" ":" "${commandItem}"
        printf "  %-17s %s %s\n" "기본설명" ":" "${commandDescriptionKrParam}" | sed 's/_/ /g'
        printf "  %-18s %s %s\n" "※사용법" ":" "${commandItem}_[옵션]_[인수]" | sed 's/_/ /g'
        printf "  %-17s %s %s\n" "※옵션" ":" "[-r]" | sed 's/_/ /g'
        printf "  %-17s %s %s\n" "※인수" ":" "[대상날짜]" | sed 's/_/ /g'
    elif [[ ${ouputLanguageParam} == [jJ][pP] ]];then
        printf "  %-17s %s %s\n" "コマンド" ":" "${commandItem}"
        printf "  %-17s %s %s\n" "基本説明" ":" "${commandDescriptionJpParam}" | sed 's/_/ /g'
        printf "  %-18s %s %s\n" "※使用法" ":" "${commandItem}_[オプション]_[引数]" | sed 's/_/ /g'
        printf "  %-20s %s %s\n" "※オプション" ":" "[-r]" | sed 's/_/ /g'
        printf "  %-17s %s %s\n" "※引数" ":" "[対象日付]" | sed 's/_/ /g'
    else
        printf "  %-13s %s %s\n" "Command" ":" "${commandItem}"
        printf "  %-13s %s %s\n" "Description" ":" "${commandDescriptionEnParam}" | sed 's/_/ /g'
        printf "  %-15s %s %s\n" "※HowToUse" ":" "${commandItem}_[argument]_[argument]" | sed 's/_/ /g'
        printf "  %-15s %s %s\n" "※option" ":" "[-r]" | sed 's/_/ /g'
        printf "  %-15s %s %s\n" "※argument" ":" "[target_Date]" | sed 's/_/ /g'
    fi
        echo
        printf "##############################################################################################\n"
        echo
    if [[ ${ouputLanguageParam} == [kK][rR] ]];then
        export LC_ALL="ko_KR.UTF-8"
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "cal"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(예상)" ":" "명령어 실행 월의 달력을 출력"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "     M월 YYYY    "
            echo "일 월 화 수 목 금 토"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo "◯　◯　◯　◯　◯　●　◯"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "cal"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            cal
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "cal -h"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(예상)" ":" "명령어 실행 월의 달력을 출력(오늘 강조 표시)"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "     M월 YYYY    "
            echo "일 월 화 수 목 금 토"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "cal -h"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            cal -h
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "cal -j"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(예상)" ":" "줄리안 달력으로 출력(1월 1일을 기준으로 1씩 더해진 날짜를 출력)"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "     M월 YYYY    "
            echo "일 월 화 수 목 금 토"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo "◯　◯　◯　◯　◯　●　◯"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "cal -j"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            cal -j
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "cal -y"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(예상)" ":" "올해의 모든 날짜를 출력"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "     M월 YYYY    "
            echo "일 월 화 수 목 금 토"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo "◯　◯　◯　◯　◯　●　◯"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "cal -y"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            cal -y
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "cal -d 2022-6"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "cal -d 2022-6-1"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(예상)" ":" "지정된 날짜를 달력을 출력"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "     6월 2022    "
            echo "일 월 화 수 목 금 토"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "cal -d 2022-6"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "cal -d 2022-6-1"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            cal -d 2022-6
            cal -d 2022-6-1
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
    elif [[ ${ouputLanguageParam} == [jJ][pP] ]];then
        export LC_ALL="ja_JP.UTF-8"
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "cal"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(予想)" ":" "コマンド実行月のカレンダーを出力"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "     M月 YYYY    "
            echo "日 月 火 水 木 金 土"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo "◯　◯　◯　◯　◯　●　◯"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "cal"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            cal
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "cal -h"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(予想)" ":" "コマンド実行月のカレンダーを出力(今日は強調表示しない)"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "     M月 YYYY    "
            echo "日 月 火 水 木 金 土"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "cal -h"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            cal -h
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "cal -j"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(予想)" ":" "ジュリアンカレンダーへの出力（1月1日から1日ずつ足す日付を出力）"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "     M月 YYYY    "
            echo "日 月 火 水 木 金 土"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo "◯　◯　◯　◯　◯　●　◯"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "cal -j"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            cal -j
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "cal -y"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(予想)" ":" "今年のすべての日付を出力"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "     M月 YYYY    "
            echo "日 月 火 水 木 金 土"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo "◯　◯　◯　◯　◯　●　◯"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "cal -y"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            cal -y
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "cal -d 2022-6"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "cal -d 2022-6-1"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(予想)" ":" "指定された日付をカレンダーを出力"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "     6月 2022    "
            echo "日 月 火 水 木 金 土"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "cal -d 2022-6"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "cal -d 2022-6-1"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            cal -d 2022-6
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
    else
        export LC_ALL="en_US.UTF-8"
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "cal"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(expect)" ":" "Outputs the calendar for the month of command execution"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "   March YYYY    "
            echo "Su Mo Tu We Th Fr Sa"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo "◯　◯　◯　◯　◯　●　◯"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "cal"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            cal
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "cal -h"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(expect)" ":" "Outputs the calendar for the month of command execution(Not highlight today)"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "   March YYYY    "
            echo "Su Mo Tu We Th Fr Sa"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "cal -h"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            cal -h 
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "cal -j"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(expect)" ":" "Output to Julian Calendar (outputs the date added by 1 as of January 1st)"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "   March YYYY    "
            echo "Su Mo Tu We Th Fr Sa"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo "◯　◯　◯　◯　◯　●　◯"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "cal -j"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            cal -j
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "cal -y"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(expect)" ":" "Output all dates for this year"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "   March YYYY    "
            echo "Su Mo Tu We Th Fr Sa"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo "◯　◯　◯　◯　◯　●　◯"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "cal -y"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            cal -y
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "cal -d 2022-6"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "cal -d 2022-6-1"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(expect)" ":" "Output calendar for the specified date"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "   June 2022    "
            echo "Su Mo Tu We Th Fr Sa"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo "◯　◯　◯　◯　◯　◯　◯"
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "cal -d 2022-6"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "cal -d 2022-6-1"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            cal -d 2022-6
            cal -d 2022-6-1
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
    fi
        echo
    printf "##############################################################################################\n"
    
    export LC_ALL=${old_LC_ALL}

    ### tmp Directory Delete / 임시 디렉토리 삭제 / 作業ディレクトリ削除
    #rm -rf ${filePathParam%/}/tmp/${commandItem}/

    func_basicSetting_LogFileName_Path ${PID} "1" ${commandItem}
    echo 
    
}

#--------------------------------------------#
# Command : wc                               #
#--------------------------------------------#
function func_command_wc() {
    
    ### Language Parameter / 언어 파라미터 / 言語パラメータ
    local ouputLanguageParam=$1
    ### File Path Parameter / 파일 패스 파라미터 / ファイルパスパラメータ
    local filePathParam=$2
    ### English Command Description Parameter / 영어 명령어 설명 파라미터 / 英語コマンド説明パラメータ
    local commandDescriptionEnParam=$3
    ### Korean Command Description Parameter / 한국어 명령어 설명 파라미터 / 韓国語コマンド説明パラメータ
    local commandDescriptionKrParam=$4
    ### Japense Command Description Parameter / 일본어 명령어 설명 파라미터 / 日本語コマンド説明パラメータ
    local commandDescriptionJpParam=$5
    ### Command / 명령어 / コマンド
    local commandItem=$6
    ### Count / 번호 / 番号 
    local countNumber=0

    mkdir -p ${filePathParam%/}/tmp/${commandItem}/
    echo "testFileA,Command,data" > ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
    echo 'TestFile1' >> ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
    echo 'apple banana cream dust Test txt TestFile1 gui' >> ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
    echo 'Test,bash,zsh,sh' >> ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
    echo 'TestFile2' >> ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
    echo 'iphone,ipad,imac\tTest,ipod,ipodtouch' >> ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
    echo '' >> ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
    echo 'galaxyS7,Note7,ZFilp,S7,Test' >> ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
    echo 'TestFile3' >> ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
    echo 'Korea,Test,Japan,China' >> ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
    old_LC_ALL=${LC_ALL}
    echo
    clear
    func_basicSetting_LogFileName_Path ${PID} "0" ${commandItem}
    printf "##############################################################################################\n"
    echo
    if [[ ${ouputLanguageParam} == [kK][rR] ]];then
        printf "  %-16s %s %s\n" "명령어" ":" "${commandItem}"
        printf "  %-17s %s %s\n" "기본설명" ":" "${commandDescriptionKrParam}" | sed 's/_/ /g'
        printf "  %-18s %s %s\n" "※사용법" ":" "${commandItem}_[옵션]_[인수]" | sed 's/_/ /g'
        printf "  %-17s %s %s\n" "※옵션" ":" "[-lwc]" | sed 's/_/ /g'
        printf "  %-17s %s %s\n" "※인수" ":" "[대상_파일]" | sed 's/_/ /g'
    elif [[ ${ouputLanguageParam} == [jJ][pP] ]];then
        printf "  %-17s %s %s\n" "コマンド" ":" "${commandItem}"
        printf "  %-17s %s %s\n" "基本説明" ":" "${commandDescriptionJpParam}" | sed 's/_/ /g'
        printf "  %-18s %s %s\n" "※使用法" ":" "${commandItem}_[オプション]_[引数]" | sed 's/_/ /g'
        printf "  %-20s %s %s\n" "※オプション" ":" "[-lwc]" | sed 's/_/ /g'
        printf "  %-17s %s %s\n" "※引数" ":" "[対象ファイル]" | sed 's/_/ /g'
    else
        printf "  %-13s %s %s\n" "Command" ":" "${commandItem}"
        printf "  %-13s %s %s\n" "Description" ":" "${commandDescriptionEnParam}" | sed 's/_/ /g'
        printf "  %-15s %s %s\n" "※HowToUse" ":" "${commandItem}_[option]_[argument]" | sed 's/_/ /g'
        printf "  %-15s %s %s\n" "※option" ":" "[-lwc]" | sed 's/_/ /g'
        printf "  %-15s %s %s\n" "※argument" ":" "[Target_Files]" | sed 's/_/ /g'
    fi
        echo
        printf "##############################################################################################\n"
        echo
    if [[ ${ouputLanguageParam} == [kK][rR] ]];then
        export LC_ALL="ko_KR.UTF-8"
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "wc ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(예상)" ":" "라인수,단어수,바이트수출력"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "   라인수  단어수  바이트수  대상파일경로" 
            echo "    10     17        207       ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt" 
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "wc ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            wc ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        printf "#============================================================================================#\n"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "wc -l ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(예상)" ":" "라인수출력"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "   10 : 라인수" 
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "wc -l ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            wc -l ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        printf "#============================================================================================#\n"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "wc -w ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(예상)" ":" "단어수출력"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "   17 : 단어수 (구분자 : 스페이스)" 
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "wc -w ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            wc -w ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        printf "#============================================================================================#\n"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "wc -c ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(예상)" ":" "바이트수출력"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "   207 : 바이트수 (LF : 1바이트, CRLF : 2바이트)"
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "wc -c ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            wc -c ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
    elif [[ ${ouputLanguageParam} == [jJ][pP] ]];then
        export LC_ALL="ja_JP.UTF-8"
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "wc ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(予想)" ":" "行数、単語数、バイト数出力"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "   行数  単語数  バイト数  対象ファイルパス" 
            echo "    10    17       207      ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt" 
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "wc ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            wc ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "wc -l ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(予想)" ":" "行数出力"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "   10 : 行数" 
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "wc -l ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            wc -l ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "wc -w ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(予想)" ":" "単語数出力"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "   17 : 単語数 (区分字 : スペース)" 
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "wc -w ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            wc -w ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "wc -c ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(予想)" ":" "バイト数出力"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "   207 : バイト数 (LF : 1バイト, CRLF : 2バイト)"
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "wc -c ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            wc -c ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
    else
        export LC_ALL="en_US.UTF-8"
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "wc ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(expect)" ":" "Line_Count,Words_Count,Byte_Count Output"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "   Line_Count  Words_Count  Byte_Count  TargetFilePath" 
            echo "       10           17         207       ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt" 
            echo 
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "wc ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            wc ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "wc -l ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(expect)" ":" "Line Count Output"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "   10 : Line Count" 
            echo 
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "wc -l ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            wc -l ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "wc -w ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(expect)" ":" "Words Count Output"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "   17 : Words Count (Separator : space)" 
            echo 
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "wc -w ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            wc -w ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "wc -c ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(expect)" ":" "Bytes Count Output"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "   207 : Byte Count (LF : 1byte, CRLF : 2byte)"
            echo 
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "wc -c ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            wc -c ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
    fi
        echo
    printf "##############################################################################################\n"

    export LC_ALL=${old_LC_ALL}

    ### tmp Directory Delete / 임시 디렉토리 삭제 / 作業ディレクトリ削除
    rm -rf ${filePathParam%/}/tmp/${commandItem}/

    func_basicSetting_LogFileName_Path ${PID} "1" ${commandItem}
    echo 
    
}

#--------------------------------------------#
# Command : uniq                             #
#--------------------------------------------#
function func_command_uniq() {
    
    ### Language Parameter / 언어 파라미터 / 言語パラメータ
    local ouputLanguageParam=$1
    ### File Path Parameter / 파일 패스 파라미터 / ファイルパスパラメータ
    local filePathParam=$2
    ### English Command Description Parameter / 영어 명령어 설명 파라미터 / 英語コマンド説明パラメータ
    local commandDescriptionEnParam=$3
    ### Korean Command Description Parameter / 한국어 명령어 설명 파라미터 / 韓国語コマンド説明パラメータ
    local commandDescriptionKrParam=$4
    ### Japense Command Description Parameter / 일본어 명령어 설명 파라미터 / 日本語コマンド説明パラメータ
    local commandDescriptionJpParam=$5
    ### Command / 명령어 / コマンド
    local commandItem=$6
    ### Count / 번호 / 番号 
    local countNumber=0

    mkdir -p ${filePathParam%/}/tmp/${commandItem}/
    echo "testFileA,Command,data" > ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
    echo 'test apple' > ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
    echo 'test apple' >> ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
    echo 'test banana' >> ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
    echo 'test Banana' >> ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
    echo 'test banana' >> ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
    echo 'test apple' >> ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
    echo 'test Peach' >> ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
    echo 'test peach' >> ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
    echo 'test peach' >> ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
    old_LC_ALL=${LC_ALL}
    echo
    clear
    func_basicSetting_LogFileName_Path ${PID} "0" ${commandItem}
    printf "##############################################################################################\n"
    echo
    if [[ ${ouputLanguageParam} == [kK][rR] ]];then
        printf "  %-16s %s %s\n" "명령어" ":" "${commandItem}"
        printf "  %-17s %s %s\n" "기본설명" ":" "${commandDescriptionKrParam}" | sed 's/_/ /g'
        printf "  %-18s %s %s\n" "※사용법" ":" "${commandItem}_[옵션]_[인수]" | sed 's/_/ /g'
        printf "  %-17s %s %s\n" "※옵션" ":" "[-ci]" | sed 's/_/ /g'
        printf "  %-17s %s %s\n" "※인수" ":" "[대상_파일]" | sed 's/_/ /g'
    elif [[ ${ouputLanguageParam} == [jJ][pP] ]];then
        printf "  %-17s %s %s\n" "コマンド" ":" "${commandItem}"
        printf "  %-17s %s %s\n" "基本説明" ":" "${commandDescriptionJpParam}" | sed 's/_/ /g'
        printf "  %-18s %s %s\n" "※使用法" ":" "${commandItem}_[オプション]_[引数]" | sed 's/_/ /g'
        printf "  %-20s %s %s\n" "※オプション" ":" "[-ci]" | sed 's/_/ /g'
        printf "  %-17s %s %s\n" "※引数" ":" "[対象ファイル]" | sed 's/_/ /g'
    else
        printf "  %-13s %s %s\n" "Command" ":" "${commandItem}"
        printf "  %-13s %s %s\n" "Description" ":" "${commandDescriptionEnParam}" | sed 's/_/ /g'
        printf "  %-15s %s %s\n" "※HowToUse" ":" "${commandItem}_[option]_[argument]" | sed 's/_/ /g'
        printf "  %-15s %s %s\n" "※option" ":" "[-ci]" | sed 's/_/ /g'
        printf "  %-15s %s %s\n" "※argument" ":" "[Target_Files]" | sed 's/_/ /g'
    fi
        echo
        printf "##############################################################################################\n"
        echo
    if [[ ${ouputLanguageParam} == [kK][rR] ]];then
        export LC_ALL="ko_KR.UTF-8"
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "uniq ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(예상)" ":" "연속된 중복값을 제거하여 출력"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "##원본##"
            echo "test apple\ntest apple\ntest banana\ntest Banana\ntest banana\ntest apple\ntest Peach\ntest peach\ntest peach\n"
            echo "##예상출력##"
            echo "test apple\ntest banana\ntest Banana\ntest banana\ntest apple\ntest Peach\ntest peach\n"
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "uniq ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            uniq ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        printf "#============================================================================================#\n"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "uniq -c ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(예상)" ":" "연속된 중복값을 제거하여 출력(중복된 라인수를 선두에 출력)"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "##예상출력##"
            echo "   2 test apple\n   1 test banana\n   1 test Banana\n   1 test banana\n   1 test apple\n   1 test Peach\n   2 test peach\n"
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "uniq -c ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            uniq -c ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        printf "#============================================================================================#\n"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "uniq -i ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(예상)" ":" "대소문자 구분없이 출력"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "##예상출력##"
            echo "test apple\ntest banana\ntest apple\ntest Peach\n"
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "uniq -i ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            uniq -i ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
    elif [[ ${ouputLanguageParam} == [jJ][pP] ]];then
        export LC_ALL="ja_JP.UTF-8"
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "uniq ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(予想)" ":" "連続重複値の削除と出力(先頭に重複数を出力)"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "##原本##"
            echo "test apple\ntest apple\ntest banana\ntest Banana\ntest banana\ntest apple\ntest Peach\ntest peach\ntest peach\n"
            echo "##予想出力##"
            echo "test apple\ntest banana\ntest Banana\ntest banana\ntest apple\ntest Peach\ntest peach\n"
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "uniq ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            uniq ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "uniq -c ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(予想)" ":" "大文字と小文字を区別しない"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "##予想出力##"
            echo "   2 test apple\n   1 test banana\n   1 test Banana\n   1 test banana\n   1 test apple\n   1 test Peach\n   2 test peach\n"
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "uniq -c ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            uniq -c ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "uniq -i ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(予想)" ":" "単語数出力"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "##予想出力##"
            echo "test apple\ntest banana\ntest apple\ntest Peach\n"
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "uniq -i ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            uniq -i ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
    else
        export LC_ALL="en_US.UTF-8"
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "uniq ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(expect)" ":" "Delete consecutive duplicate values and output"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "##Original##"
            echo "test apple\ntest apple\ntest banana\ntest Banana\ntest banana\ntest apple\ntest Peach\ntest peach\ntest peach\n"
            echo "##Estimated_output##"
            echo "test apple\ntest banana\ntest Banana\ntest banana\ntest apple\ntest Peach\ntest peach\n"
            echo 
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "uniq ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            uniq ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "uniq -c ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(expect)" ":" "Output by eliminating consecutive duplicate values (number of duplicate outputs)"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "##Estimated_output##"
            echo "   2 test apple\n   1 test banana\n   1 test Banana\n   1 test banana\n   1 test apple\n   1 test Peach\n   2 test peach\n"
            echo 
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "uniq -c ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            uniq -c ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "uniq -i ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(expect)" ":" "Put out case-insensitive"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "##Estimated_output##"
            echo "test apple\ntest banana\ntest apple\ntest Peach\n"
            echo 
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "uniq -i ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            uniq -i ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
    fi
        echo
    printf "##############################################################################################\n"

    export LC_ALL=${old_LC_ALL}

    ### tmp Directory Delete / 임시 디렉토리 삭제 / 作業ディレクトリ削除
    rm -rf ${filePathParam%/}/tmp/${commandItem}/

    func_basicSetting_LogFileName_Path ${PID} "1" ${commandItem}
    echo 
    
}

#--------------------------------------------#
# Command : touch                            #
#--------------------------------------------#
function func_command_touch() {
    
    ### Language Parameter / 언어 파라미터 / 言語パラメータ
    local ouputLanguageParam=$1
    ### File Path Parameter / 파일 패스 파라미터 / ファイルパスパラメータ
    local filePathParam=$2
    ### English Command Description Parameter / 영어 명령어 설명 파라미터 / 英語コマンド説明パラメータ
    local commandDescriptionEnParam=$3
    ### Korean Command Description Parameter / 한국어 명령어 설명 파라미터 / 韓国語コマンド説明パラメータ
    local commandDescriptionKrParam=$4
    ### Japense Command Description Parameter / 일본어 명령어 설명 파라미터 / 日本語コマンド説明パラメータ
    local commandDescriptionJpParam=$5
    ### Command / 명령어 / コマンド
    local commandItem=$6
    ### Count / 번호 / 番号 
    local countNumber=0

    mkdir -p ${filePathParam%/}/tmp/${commandItem}/
    old_LC_ALL=${LC_ALL}
    echo
    clear
    func_basicSetting_LogFileName_Path ${PID} "0" ${commandItem}
    printf "##############################################################################################\n"
    echo
    if [[ ${ouputLanguageParam} == [kK][rR] ]];then
        printf "  %-16s %s %s\n" "명령어" ":" "${commandItem}"
        printf "  %-17s %s %s\n" "기본설명" ":" "${commandDescriptionKrParam}" | sed 's/_/ /g'
        printf "  %-18s %s %s\n" "※사용법" ":" "${commandItem}_[옵션]_[인수]" | sed 's/_/ /g'
        printf "  %-17s %s %s\n" "※옵션" ":" "[-trc]" | sed 's/_/ /g'
        printf "  %-17s %s %s\n" "※인수" ":" "[대상_파일]" | sed 's/_/ /g'
    elif [[ ${ouputLanguageParam} == [jJ][pP] ]];then
        printf "  %-17s %s %s\n" "コマンド" ":" "${commandItem}"
        printf "  %-17s %s %s\n" "基本説明" ":" "${commandDescriptionJpParam}" | sed 's/_/ /g'
        printf "  %-18s %s %s\n" "※使用法" ":" "${commandItem}_[オプション]_[引数]" | sed 's/_/ /g'
        printf "  %-20s %s %s\n" "※オプション" ":" "[-trc]" | sed 's/_/ /g'
        printf "  %-17s %s %s\n" "※引数" ":" "[対象ファイル]" | sed 's/_/ /g'
    else
        printf "  %-13s %s %s\n" "Command" ":" "${commandItem}"
        printf "  %-13s %s %s\n" "Description" ":" "${commandDescriptionEnParam}" | sed 's/_/ /g'
        printf "  %-15s %s %s\n" "※HowToUse" ":" "${commandItem}_[option]_[argument]" | sed 's/_/ /g'
        printf "  %-15s %s %s\n" "※option" ":" "[-trc]" | sed 's/_/ /g'
        printf "  %-15s %s %s\n" "※argument" ":" "[Target_Files]" | sed 's/_/ /g'
    fi
        echo
        printf "##############################################################################################\n"
        echo
    if [[ ${ouputLanguageParam} == [kK][rR] ]];then
        export LC_ALL="ko_KR.UTF-8"
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "touch ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "touch ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile2.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(예상)" ":" "0바이트의 빈 파일을 생성"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "현재시간"
            date "+%m/%d %H:%M"
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "touch ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "touch ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile2.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "현재시간"
            date "+%m/%d %H:%M"
            touch ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt
            touch ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile2.txt
            ls -l ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt
            ls -l ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile2.txt
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        printf "#============================================================================================#\n"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "touch -t 199112312359 ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(예상)" ":" "지정된 날짜 및 시간[[CC]YY]MMDDhhmm[SS]으로 수정"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "현재시간"
            date "+%m/%d %H:%M"
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "touch -t 199112312359 ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "현재시간"
            date "+%m/%d %H:%M"
            touch -t 199112312359 ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt
            ls -l ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt
            ls -l ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile2.txt
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        printf "#============================================================================================#\n"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "touch -r ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile2.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(예상)" ":" "파라미터(앞)의 수정 날짜 정보를 파라미터(뒤)의 수정날짜 정보로 수정"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "현재시간"
            date "+%m/%d %H:%M"
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "touch -r ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile2.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "현재시간"
            date "+%m/%d %H:%M"
            touch -r ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile2.txt
            ls -l ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt
            ls -l ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile2.txt
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        printf "#============================================================================================#\n"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "touch -c ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(예상)" ":" "수정 날짜 정보를 현재 시간으로 갱신"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "현재시간"
            date "+%m/%d %H:%M"
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "touch -c ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "현재시간"
            date "+%m/%d %H:%M"
            touch -c ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt
            ls -l ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt
            ls -l ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile2.txt
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
    elif [[ ${ouputLanguageParam} == [jJ][pP] ]];then
        export LC_ALL="ja_JP.UTF-8"
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "touch ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "touch ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile2.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(予想)" ":" "0バイトの空きファイルを作成"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "現在時間"
            date "+%m/%d %H:%M"
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "touch ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "touch ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile2.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "現在時間"
            date "+%m/%d %H:%M"
            touch ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt
            touch ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile2.txt
            ls -l ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt
            ls -l ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile2.txt            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "touch -t 199112312359 ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(予想)" ":" "指定された日付[[CC]YY]MMDDhhmm[SS]に修正"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "現在時間"
            date "+%m/%d %H:%M"
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "touch -t 199112312359 ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "現在時間"
            date "+%m/%d %H:%M"
            touch -t 199112312359 ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt
            ls -l ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt
            ls -l ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile2.txt
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "touch -r ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile2.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(予想)" ":" "パラメータ（前）の修正日付情報をパラメータ（後）の修正日付情報に修正"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "現在時間"
            date "+%m/%d %H:%M"
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "touch -r ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile2.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "現在時間"
            date "+%m/%d %H:%M"
            touch -r ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile2.txt
            ls -l ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt
            ls -l ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile2.txt
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "touch -c ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(予想)" ":" "修正日付情報を現在の時間に更新"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "現在時間"
            date "+%m/%d %H:%M"
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "touch -c ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "現在時間"
            date "+%m/%d %H:%M"
            touch -c ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt
            ls -l ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt
            ls -l ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile2.txt
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
    else
        export LC_ALL="en_US.UTF-8"
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "touch ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "touch ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile2.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(expect)" ":" "Create an empty file of 0 bytes"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "Current Time"
            date "+%m/%d %H:%M"
            echo 
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "touch ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "touch ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile2.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "Current Time"
            date "+%m/%d %H:%M"
            touch -c ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt
            touch -c ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile2.txt
            ls -l ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt
            ls -l ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile2.txt
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "touch -t 199112312359 ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(expect)" ":" "Modify to specified date and time [[CC]YY]MMDDhmm[SS]"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "Current Time"
            date "+%m/%d %H:%M"
            echo 
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "touch -t 199112312359 ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "Current Time"
            date "+%m/%d %H:%M"
            touch -t 199112312359 ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt
            ls -l ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt
            ls -l ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile2.txt
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "touch -r ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile2.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(expect)" ":" "Modify the modification date information of the parameter (front) to the modification date information of the parameter (back)"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "Current Time"
            date "+%m/%d %H:%M"
            echo 
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "touch -r ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile2.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "Current Time"
            date "+%m/%d %H:%M"
            touch -r ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile2.txt
            ls -l ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt
            ls -l ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile2.txt
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "touch -c ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(expect)" ":" "Refreshing revision date information to current time"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "Current Time"
            date "+%m/%d %H:%M"
            echo 
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "touch -c ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo "Current Time"
            date "+%m/%d %H:%M"
            touch -c ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt
            ls -l ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile1.txt
            ls -l ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile2.txt
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
    fi
        echo
    printf "##############################################################################################\n"

    export LC_ALL=${old_LC_ALL}

    ### tmp Directory Delete / 임시 디렉토리 삭제 / 作業ディレクトリ削除
    rm -rf ${filePathParam%/}/tmp/${commandItem}/

    func_basicSetting_LogFileName_Path ${PID} "1" ${commandItem}
    echo 
    
}

#--------------------------------------------#
# Command : head                             #
#--------------------------------------------#
function func_command_head() {
    
    ### Language Parameter / 언어 파라미터 / 言語パラメータ
    local ouputLanguageParam=$1
    ### File Path Parameter / 파일 패스 파라미터 / ファイルパスパラメータ
    local filePathParam=$2
    ### English Command Description Parameter / 영어 명령어 설명 파라미터 / 英語コマンド説明パラメータ
    local commandDescriptionEnParam=$3
    ### Korean Command Description Parameter / 한국어 명령어 설명 파라미터 / 韓国語コマンド説明パラメータ
    local commandDescriptionKrParam=$4
    ### Japense Command Description Parameter / 일본어 명령어 설명 파라미터 / 日本語コマンド説明パラメータ
    local commandDescriptionJpParam=$5
    ### Command / 명령어 / コマンド
    local commandItem=$6
    ### Count / 번호 / 番号 
    local countNumber=0

    mkdir -p ${filePathParam%/}/tmp/${commandItem}/
    echo 'TestFile1' > ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
    for n in {2..20};
    do
        echo "TestFile${n}" >> ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
    done 
    old_LC_ALL=${LC_ALL}
    echo
    clear
    func_basicSetting_LogFileName_Path ${PID} "0" ${commandItem}
    printf "##############################################################################################\n"
    echo
    if [[ ${ouputLanguageParam} == [kK][rR] ]];then
        printf "  %-16s %s %s\n" "명령어" ":" "${commandItem}"
        printf "  %-17s %s %s\n" "기본설명" ":" "${commandDescriptionKrParam}" | sed 's/_/ /g'
        printf "  %-18s %s %s\n" "※사용법" ":" "${commandItem}_[옵션]_[인수]" | sed 's/_/ /g'
        printf "  %-17s %s %s\n" "※옵션" ":" "[-nc]" | sed 's/_/ /g'
        printf "  %-17s %s %s\n" "※인수" ":" "[대상_파일]" | sed 's/_/ /g'
    elif [[ ${ouputLanguageParam} == [jJ][pP] ]];then
        printf "  %-17s %s %s\n" "コマンド" ":" "${commandItem}"
        printf "  %-17s %s %s\n" "基本説明" ":" "${commandDescriptionJpParam}" | sed 's/_/ /g'
        printf "  %-18s %s %s\n" "※使用法" ":" "${commandItem}_[オプション]_[引数]" | sed 's/_/ /g'
        printf "  %-20s %s %s\n" "※オプション" ":" "[-nc]" | sed 's/_/ /g'
        printf "  %-17s %s %s\n" "※引数" ":" "[対象ファイル]" | sed 's/_/ /g'
    else
        printf "  %-13s %s %s\n" "Command" ":" "${commandItem}"
        printf "  %-13s %s %s\n" "Description" ":" "${commandDescriptionEnParam}" | sed 's/_/ /g'
        printf "  %-15s %s %s\n" "※HowToUse" ":" "${commandItem}_[option]_[argument]" | sed 's/_/ /g'
        printf "  %-15s %s %s\n" "※option" ":" "[-nc]" | sed 's/_/ /g'
        printf "  %-15s %s %s\n" "※argument" ":" "[Target_Files]" | sed 's/_/ /g'
    fi
        echo
        printf "##############################################################################################\n"
        echo
    if [[ ${ouputLanguageParam} == [kK][rR] ]];then
        export LC_ALL="ko_KR.UTF-8"
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "head ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(예상)" ":" "앞에서 10줄 출력"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo 'TestFile1'
            echo 'TestFile2'
            echo 'TestFile3'
            echo 'TestFile4'
            echo 'TestFile5'
            echo 'TestFile6'
            echo 'TestFile7'
            echo 'TestFile8'
            echo 'TestFile9'
            echo 'TestFile10'
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "head ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            head ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        printf "#============================================================================================#\n"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "head -n 3 ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(예상)" ":" "앞에서 n줄 출력"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo 'TestFile1'
            echo 'TestFile2'
            echo 'TestFile3'
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "head -n 3 ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            head -n 3 ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        printf "#============================================================================================#\n"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "head -c 3 ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(예상)" ":" "앞에서 n바이트 출력"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo 'Tes'
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "head -c 3 ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            head -c 3 ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
    elif [[ ${ouputLanguageParam} == [jJ][pP] ]];then
        export LC_ALL="ja_JP.UTF-8"
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "head ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(予想)" ":" "前から10行出力"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo 'TestFile1'
            echo 'TestFile2'
            echo 'TestFile3'
            echo 'TestFile4'
            echo 'TestFile5'
            echo 'TestFile6'
            echo 'TestFile7'
            echo 'TestFile8'
            echo 'TestFile9'
            echo 'TestFile10'
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "head ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            head ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "head -n 3 ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(予想)" ":" "前からn行出力"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo 'TestFile1'
            echo 'TestFile2'
            echo 'TestFile3'
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "head -n 3 ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            head -n 3 ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "head -c 3 ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(予想)" ":" "前からnバイト出力"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo 'Tes'
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "head -c 3 ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            head -c 3 ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
    else
        export LC_ALL="en_US.UTF-8"
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "head ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(expect)" ":" "10 lines output from the front"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo 'TestFile1'
            echo 'TestFile2'
            echo 'TestFile3'
            echo 'TestFile4'
            echo 'TestFile5'
            echo 'TestFile6'
            echo 'TestFile7'
            echo 'TestFile8'
            echo 'TestFile9'
            echo 'TestFile10'
            echo 
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "head ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            head ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "head -n 3 ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(expect)" ":" "n-line output from front"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo 'TestFile1'
            echo 'TestFile2'
            echo 'TestFile3'
            echo 
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "head -n 3 ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            head -n 3 ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "head -c 3 ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(expect)" ":" "Output n-bytes from the front"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo 'Tes'
            echo 
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "head -c 3 ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            head -c 3 ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
    fi
        echo
    printf "##############################################################################################\n"

    export LC_ALL=${old_LC_ALL}

    ### tmp Directory Delete / 임시 디렉토리 삭제 / 作業ディレクトリ削除
    rm -rf ${filePathParam%/}/tmp/${commandItem}/

    func_basicSetting_LogFileName_Path ${PID} "1" ${commandItem}
    echo 
    
}

#--------------------------------------------#
# Command : tail                             #
#--------------------------------------------#
function func_command_tail() {
    
    ### Language Parameter / 언어 파라미터 / 言語パラメータ
    local ouputLanguageParam=$1
    ### File Path Parameter / 파일 패스 파라미터 / ファイルパスパラメータ
    local filePathParam=$2
    ### English Command Description Parameter / 영어 명령어 설명 파라미터 / 英語コマンド説明パラメータ
    local commandDescriptionEnParam=$3
    ### Korean Command Description Parameter / 한국어 명령어 설명 파라미터 / 韓国語コマンド説明パラメータ
    local commandDescriptionKrParam=$4
    ### Japense Command Description Parameter / 일본어 명령어 설명 파라미터 / 日本語コマンド説明パラメータ
    local commandDescriptionJpParam=$5
    ### Command / 명령어 / コマンド
    local commandItem=$6
    ### Count / 번호 / 番号 
    local countNumber=0

    mkdir -p ${filePathParam%/}/tmp/${commandItem}/
    echo 'TestFile1' > ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
    for n in {2..20};
    do
        echo "TestFile${n}" >> ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
    done 
    old_LC_ALL=${LC_ALL}
    echo
    clear
    func_basicSetting_LogFileName_Path ${PID} "0" ${commandItem}
    printf "##############################################################################################\n"
    echo
    if [[ ${ouputLanguageParam} == [kK][rR] ]];then
        printf "  %-16s %s %s\n" "명령어" ":" "${commandItem}"
        printf "  %-17s %s %s\n" "기본설명" ":" "${commandDescriptionKrParam}" | sed 's/_/ /g'
        printf "  %-18s %s %s\n" "※사용법" ":" "${commandItem}_[옵션]_[인수]" | sed 's/_/ /g'
        printf "  %-17s %s %s\n" "※옵션" ":" "[-nc]" | sed 's/_/ /g'
        printf "  %-17s %s %s\n" "※인수" ":" "[대상_파일]" | sed 's/_/ /g'
    elif [[ ${ouputLanguageParam} == [jJ][pP] ]];then
        printf "  %-17s %s %s\n" "コマンド" ":" "${commandItem}"
        printf "  %-17s %s %s\n" "基本説明" ":" "${commandDescriptionJpParam}" | sed 's/_/ /g'
        printf "  %-18s %s %s\n" "※使用法" ":" "${commandItem}_[オプション]_[引数]" | sed 's/_/ /g'
        printf "  %-20s %s %s\n" "※オプション" ":" "[-nc]" | sed 's/_/ /g'
        printf "  %-17s %s %s\n" "※引数" ":" "[対象ファイル]" | sed 's/_/ /g'
    else
        printf "  %-13s %s %s\n" "Command" ":" "${commandItem}"
        printf "  %-13s %s %s\n" "Description" ":" "${commandDescriptionEnParam}" | sed 's/_/ /g'
        printf "  %-15s %s %s\n" "※HowToUse" ":" "${commandItem}_[option]_[argument]" | sed 's/_/ /g'
        printf "  %-15s %s %s\n" "※option" ":" "[-nc]" | sed 's/_/ /g'
        printf "  %-15s %s %s\n" "※argument" ":" "[Target_Files]" | sed 's/_/ /g'
    fi
        echo
        printf "##############################################################################################\n"
        echo
    if [[ ${ouputLanguageParam} == [kK][rR] ]];then
        export LC_ALL="ko_KR.UTF-8"
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "tail ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(예상)" ":" "뒤에서 10줄 출력"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo 'TestFile11'
            echo 'TestFile12'
            echo 'TestFile13'
            echo 'TestFile14'
            echo 'TestFile15'
            echo 'TestFile16'
            echo 'TestFile17'
            echo 'TestFile18'
            echo 'TestFile19'
            echo 'TestFile20'
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "tail ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            tail ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        printf "#============================================================================================#\n"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "tail -n 3 ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(예상)" ":" "뒤에서 n줄 출력"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo 'TestFile18'
            echo 'TestFile19'
            echo 'TestFile20'
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "tail -n 3 ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            tail -n 3 ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        printf "#============================================================================================#\n"
        printf "  %-12s %s %-15s\n" "샘플${countNumber}" ":" "tail -c 3 ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(예상)" ":" "뒤에서 n바이트 출력"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo '20 : 개행코드 포함'
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "출력결과(실제)" ":" "tail -c 3 ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            tail -c 3 ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
    elif [[ ${ouputLanguageParam} == [jJ][pP] ]];then
        export LC_ALL="ja_JP.UTF-8"
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "tail ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(予想)" ":" "後ろから10行出力"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo 'TestFile11'
            echo 'TestFile12'
            echo 'TestFile13'
            echo 'TestFile14'
            echo 'TestFile15'
            echo 'TestFile16'
            echo 'TestFile17'
            echo 'TestFile18'
            echo 'TestFile19'
            echo 'TestFile20'
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "tail ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            tail ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "tail -n 3 ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(予想)" ":" "後ろからn行出力"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo 'TestFile18'
            echo 'TestFile19'
            echo 'TestFile20'
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "tail -n 3 ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            tail -n 3 ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-14s %s %-15s\n" "サンプル${countNumber}" ":" "tail -c 3 ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(予想)" ":" "後ろからnバイト出力"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo '20 : 改行コード付き'
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-21s %s %s\n" "出力結果(実際)" ":" "tail -c 3 ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            tail -c 3 ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
    else
        export LC_ALL="en_US.UTF-8"
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "tail ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(expect)" ":" "10 lines output from the back"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo 'TestFile11'
            echo 'TestFile12'
            echo 'TestFile13'
            echo 'TestFile14'
            echo 'TestFile15'
            echo 'TestFile16'
            echo 'TestFile17'
            echo 'TestFile18'
            echo 'TestFile19'
            echo 'TestFile20'
            echo 
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "tail ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            tail ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "tail -n 3 ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(expect)" ":" "n-line output from the back"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo 'TestFile18'
            echo 'TestFile19'
            echo 'TestFile20'
            echo 
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "tail -n 3 ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            tail -n 3 ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
        echo
        countNumber=$((${countNumber}+1))
        printf "#============================================================================================#\n"
        printf "  %-10s %s %-15s\n" "Sample${countNumber}" ":" "tail -c 3 ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(expect)" ":" "n-byte output from the back"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            echo '20 : Include NewLine code'
            echo 
        printf "#--------------------------------------------------------------------------------------------#\n"
        printf "    %-15s %s %s\n" "Output(Real)" ":" "tail -c 3 ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt"
        printf "#--------------------------------------------------------------------------------------------#\n"
            echo
            tail -c 3 ${filePathParam%/}/tmp/${commandItem}/${commandItem}_TestFile.txt
            echo
        printf "#--------------------------------------------------------------------------------------------#\n"
    fi
        echo
    printf "##############################################################################################\n"

    export LC_ALL=${old_LC_ALL}

    ### tmp Directory Delete / 임시 디렉토리 삭제 / 作業ディレクトリ削除
    rm -rf ${filePathParam%/}/tmp/${commandItem}/

    func_basicSetting_LogFileName_Path ${PID} "1" ${commandItem}
    echo 
    
}

#--------------------------------------------#
# Command List                               #
#  : 명령어 리스트                               #
#  : コマンドリスト                              #
#--------------------------------------------#
readonly calEn="It_allows_you_to_view_the_calendar_based_on_the_date_and_month_and_you_can_also_specify_a_particular_month_or_year_for_display"
readonly calKr="날짜와_월에_따라_달력을_확인할_수_있으며_특정_월이나_연도를_지정하여_출력"
readonly calJp="日付と月によってカレンダーを確認でき、特定の月や年を指定して表示"
readonly catEn="It_is_primarily_used_to_read_and_display_text_files_on_the_screen_and_can_be_used_to_communicate_the_contents_of_files_to_other_commands"
readonly catKr="주로_텍스트_파일을_읽어_화면에_표시할_때_사용되며_여러_파일을_순서대로_결합하거나_파일의_내용을_다른_명령어로_전달하는_데에도_활용"
readonly catJp="主にテキストファイルを読み込んで画面に表示するために使用され、ファイルの内容を他のコマンドに渡すためにも利用"
readonly dateEn="Displays_the_date_and_time_of_the_current_system_and_formats_the_output._Also_used_to_calculate_or_manipulate_dates_and_times"
readonly dateKr="현재_시스템의_날짜와_시간이_표시되며_포맷을_지정하여_출력.날짜_및_시간을_계산하거나_조작하는_데에도_사용"
readonly dateJp="現在のシステムの日付と時刻が表示され、フォーマットを指定して表示することもできます。また、日付や時刻の計算や操作にも使用"
readonly exprEn="It_is_employed_in_tasks_such_as_evaluating_expressions_entered_by_users_in_the_terminal_or_finding_patterns_in_strings"
readonly exprKr="사용자가_입력한_표현식을_계산하거나_문자열에서_패턴을_찾아내는_등의_작업에_사용"
readonly exprJp="ユーザーが入力した式を計算したり、文字列からパターンを検出するなどの作業に使用"
readonly gunzipEn="command_is_used_to_decompress_files_compressed_with_gzip.This_command_is_employed_to_extract_and_restore_the_original_file"
readonly gunzipKr="gzip으로_압축된_파일을_해제하는_데_사용됩니다.이_명령어는_파일을_압축_해제하고_원래_파일을_복원하는_데_활용"
readonly gunzipJp="gzipで圧縮されたファイルを解凍するために使用されます。このコマンドはファイルを解凍し、元のファイルを復元するのに利用"
readonly gzipEn="command_is_used_to_compress_files_primarily_useful_for_large_files_or_when_archiving_multiple_files"
readonly gzipKr="파일을_압축하는_데_사용됩니다.주로_대용량_파일이나_여러_파일을_아카이브할_때_활용"
readonly gzipJp="ファイルを圧縮するために使用されます。主に大容量ファイルや複数のファイルをアーカイブする際に利用"
readonly headEn="command_is_used_to_display_the_beginning(head)_of_a_file"
readonly headKr="파일의_처음_부분을_표시하는데_사용"
readonly headJp="ファイルの先頭部分を表示するために使用"
readonly sleepEn="It_is_commonly_used_in_scripts_or_programs_when_you_want_to_pause_execution_for_a_certain_duration"
readonly sleepKr="지정된_시간_동안_실행을_지연시키는_데_사용됩니다.주로_스크립트나_프로그램에서_일정한_시간_동안_대기하고자_할_때_활용"
readonly sleepJp="指定された時間の間、実行を遅延させるために使用されます。主にスクリプトやプログラムで一定の時間待機させたい場合に利用"
readonly tailEn="command_is_used_to_display_the_last_part_of_a_file"
readonly tailKr="파일의_마지막_부분을_표시하는데_사용"
readonly tailJp="ファイルの最後の部分を表示するために使用"
readonly touchEn="Used_to_create_empty_files_or_update_access_and_modification_times_for_existing_files"
readonly touchKr="빈_파일을_생성하거나_기존_파일의_액세스_및_수정_시간을_업데이트하는_데_사용"
readonly touchJp="空のファイルを作成したり、既存ファイルのアクセスおよび修正のタイムスタンプを更新するために使用"
readonly uniqEn="Used_to_remove_duplicate_rows_or_to_output_only_one_of_successively_repeated_rows"
readonly uniqKr="중복된_행을_제거하거나_연속적으로_반복된_행_중_하나만을_출력하는_데_사용"
readonly uniqJp="重複する行を削除するか、連続して繰り返される行の1つのみを出力するために使用"
readonly unzipEn="command_is_used_to_extract_files_from_a_ZIP_archive.It's_commonly_used_to_unzip_compressed_files_or_directories"
readonly unzipKr="ZIP_파일을_해제하는_데_사용됩니다.주로_압축된_파일이나_디렉토리를_푸는_데_활용"
readonly unzipJp="ZIPファイルを解凍するために使用されます。主に圧縮されたファイルやディレクトリを解凍するのに利用"
readonly wcEn="command_is_used_to_count_the_number_of_lines_words_and_bytes_in_a_file.It's_often_used_to_report_statistics_on_text_files_or_as_part_of_data_processing"
readonly wcKr="파일의_행_단어_바이트_수를_세는_데_사용됩니다.텍스트_파일의_통계_정보를_보고하거나_데이터_처리에서_활용"
readonly wcJp="ファイルの行数、単語数、バイト数を数えるのに使用されます。テキストファイルの統計情報を報告するか、データ処理で利用"
readonly zipEn="command_is_used_to_compress_files_and_directories_creating_a_compressed_archive.It's_primarily_used_to_save_space_by_compressing_files_or_when_transferring_files"
readonly zipKr="파일_및_디렉터리를_압축하고_압축_파일을_만드는_데_사용됩니다.주로_파일을_압축하여_용량을_절약하거나_파일을_전송할_때_활용"
readonly zipJp="ファイルやディレクトリを圧縮し、圧縮ファイルを作成するのに使用されます。主にファイルを圧縮して容量を節約しファイルを転送する際に利用"
declare -a commandList=("cal" "cat" "date" "expr" "gunzip" "gzip" "head" "sleep" "tail" "touch" "uniq" "unzip" "wc" "zip")
declare -a commandDescriptionEn=("${calEn}" "${catEn}" "${dateEn}" "${exprEn}" "${gunzipEn}" "${gzipEn}" "${headEn}" "${sleepEn}" "${tailEn}" "${touchEn}" "${uniqEn}" "${unzipEn}" "${wcEn}" "${zipEn}")
declare -a commandDescriptionKr=("${calKr}" "${catKr}" "${dateKr}" "${exprKr}" "${gunzipKr}" "${gzipKr}" "${headKr}" "${sleepKr}" "${tailKr}" "${touchKr}" "${uniqKr}" "${unzipKr}" "${wcKr}" "${zipKr}")
declare -a commandDescriptionJp=("${calJp}" "${catJp}" "${dateJp}" "${exprJp}" "${gunzipJp}" "${gzipJp}" "${headJp}" "${sleepJp}" "${tailJp}" "${touchJp}" "${uniqJp}" "${unzipJp}" "${wcJp}" "${zipJp}")

#--------------------------------------------#
# Script Basic Variable Setting              #
#  : 스크립트 기본 변수 설정                       #
#  : スクリプトの基本変数設定                      #
#--------------------------------------------#
### parameterCount / 파라미터 수 / パラメータ数
paramCount=$#
### ProcessID / 프로세스ID / プロセスID
PID=$$
### searchCommand / 검색명령어 / 検索コマンド
searchCommand=$1
### Output Language / 출력 언어 / 出力言語
ouputLanguage=$2
### Start Flg / 시작 Flg / 開始フラグ
startedFlg=0

#--------------------------------------------#
# Main Logic                                 #
#  : 메인 처리                                  #
#  : メイン処理                                 #
#--------------------------------------------#
### Parameter Check / 파라미터 체크 / パラメータチェック
#"# echo "CHECK TREE 1"
if [[ ! -z ${searchCommand} ]] || [[ ${startedFlg} == 0 ]];then 
    func_linuxCommandsExistCheck ${searchCommand}
fi

#"# echo "CHECK TREE 2"
if [[ ! -z ${searchCommand} && ${existCheck} == 0 ]];then
    clear
    echo
    func_notExistCommand ${searchCommand} ${ouputLanguage} ${existCheck}
    exit
fi
#"# echo "CHECK TREE 3"
if [[ -z ${ouputLanguage} ]];then
    clear
    ouputLanguage="en"
    func_howToUse
fi
#"# echo "CHECK TREE 4"
if ! [[ ${ouputLanguage} == [eE][nN] || ${ouputLanguage} == [kK][rR] || ${ouputLanguage} == [jJ][pP] ]];then
    func_supportLanguage
    exit
else
    clear
fi

echo
#"# echo "CHECK TREE 5"
### Function Run / 함수 실행 / 関数実行
func_basicSetting_StartingRunTime ${ouputLanguage} 
### Function Run / 함수 실행 / 関数実行
func_basicSetting_LogFileName_Path ${PID} "0" ${searchCommand}

while true
do
    if [[ startedFlg -ge 1 ]];then
        clear
    fi

    if [[ ${startedFlg} == 0 && ! -z ${searchCommand} ]];then
        selectMenu=2
    else
        ### Function Run / 함수 실행 / 関数実行
        #"# echo "CHECK TREE 6"
        func_mainMenu ${ouputLanguage}
    fi

    if [[ ${selectMenu} == 1 ]];then
        clear
        ### Function Run / 함수 실행 / 関数実行
        #"# echo "CHECK TREE 7"
        func_selectLanguage ${ouputLanguage}
    elif [[ ${selectMenu} == 2 ]];then
        clear
        while true
        do
            clear
            if [[ ${startedFlg} -gt 0 && ! -z ${searchCommand} ]] || [[ -z ${searchCommand} ]];then
                ### Function Run / 함수 실행 / 関数実行
                #"# echo "CHECK TREE 8"
                func_linuxCommandsList 1 ${ouputLanguage} 
            fi
            existCheck=0
            ### Function Run / 함수 실행 / 関数実行
            #"# echo "CHECK TREE 9"
            func_linuxCommandsExistCheck ${searchCommand}
            if [[ ${existCheck} == 1 ]];then
                #"# echo "CHECK TREE 10"
                func_linuxCommandExample ${ouputLanguage} ${filePath} ${commandItemIndex} 
            fi
        done
    elif [[ ${selectMenu} == 3 ]];then
        clear

    elif [[ ${selectMenu} == "終了" || ${selectMenu} == "종료" || ${selectMenu} == [eE][nN][dD] || ${selectMenu} == [eE][xX][iI][tT] ||  ${selectMenu} == 9 ]];then
        ### Function Run / 함수 실행 / 関数実行
        #"# echo "CHECK TREE 11"
        func_scriptEnd ${ouputLanguage}
    else
        continue
    fi
    selectMenu=0
    startedFlg=$((${startedFlg}+1))
done

### Function Run / 함수 실행 / 関数実行
func_basicSetting_LogFileName_Path ${PID} "1" ${searchCommand}

## What to do when adding a command (ex:gzip)
## 명령어 추가시 작업 내용 (예:gzip)
## コマンド追加時の作業内容 (例:gzip)
#readonly gzipEn="Compress_or_decompress_a_file"
#readonly gzipKr="파일을_압축하거나_압축_해제"
#readonly gzipJp="ファイルを圧縮したり解凍する"
#declare -a commandList=("cat" "expr" "sleep" "gzip")
#declare -a commandDescriptionEn=("${catEn}" "${exprEn}" "${sleepEn}" "${gzipEn}")
#declare -a commandDescriptionKr=("${catKr}" "${exprKr}" "${sleepKr}" "${gzipKr}")
#declare -a commandDescriptionJp=("${catJp}" "${exprJp}" "${sleepJp}" "${gzipJp}")
#func_linuxCommandExample case 추가