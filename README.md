# App_SimpleBox
>github/Draw0919
* Static Info:
  ![Bash使用](https://img.shields.io/badge/Bash_Script-2A2Ba2)
  ![Docker使用](https://img.shields.io/badge/Docker-2496ED?logo=docker&logoColor=white)
  ![Python使用](https://img.shields.io/badge/Python-14354C.svg?logo=python&logoColor=white)
* Development:
  ![版權宣告](https://img.shields.io/github/license/Draw0919/App_SimpleBox)

### 一、運用目標

* 提供一個腳本，執行後可建立簡單靶機環境。

### 二、運用架構

* 本Repo提供一個bash script。

### 三、運作流程

* 將bash script複製到Ubuntu的VM或DockerContainer中。
* 以Root權限執行後，可：
  - 自動設定弱密碼之ssh服務。
  - 自動設定一般使用者CP提權弱點
* 使用者可以此設定後之VM或DockerContainer，作為練習破密及提權靶機

## 貳、REPO內容結構

* Github Repo<br/>
  📁.github資料夾<br/>
  └ 📁actions<br/>
  　└ ◻️ModuleTest.yml<br/>
  　└ ◻️PublishZip.yml<br/>
  📁.vs資料夾<br/>
  📁doc資料夾<br/>
  ◻️.gitignore檔案<br/>
  ◻️docker-compose.yml檔案<br/>
  ◻️Dockerfile檔案<br/>
  ◻️README.md<br/>

## 參、作業步驟

### 一、需求分析 & 二、系統設計

None

### 三、模組設計

設計(滾修)後直接於Readme註記。

### 四、模發測佈

#### (一)模組發展

主要是dockerfile及資料庫初始化腳本，完成後直接存檔。

#### (二)模組測試

利用github action做自動化測試。

#### (三)模組發佈

利用github action做自動化發佈。

### 五、系測版控

#### (一)獨立使用

* [方法]執行image
  * 利用docker直接建置，將新增image至本地registry
    ```bash
    # -t: tag
    # . : 單點表示目前目錄
    # --no-cache: 避免在Build時被cache，造成沒有讀到最新的Dockerfile
    docker build -t neo4j . --no-cache
    ```
  * 檢視本地images
    ```bash
    docker images
    ```  
  * 使用本地image起容器
    ```
    docker run --publish=7474:7474 --publish=7687:7687 --volume=$HOME/neo4j/data:/data neo4j
    ```
* 瀏覽器開啟 
* [方法]執行dockercompose
  * 直接執行dockercompose
    ```powershell
    docker-compose up
    ```
* 登入瀏覽器確認運作正常
* http://localhost:7474/browser/

* 使用UI關閉container並刪除image

#### (二)併入SOA使用

* 將dockercompose內容複製至系統dockercompose使用。
