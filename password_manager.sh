#!/bin/bash
echo "パスワードマネージャーへようこそ！"

while true; do
    echo "次の選択肢から入力してください(Add Password/Get Password/Exit)："

    read input

    # 条件分岐

    # Add Password が入力された場合
  if [  "$input" = "Add Password" ]; then
    echo  "サービス名を入力してください："
    read service_name
    echo "ユーザー名を入力してください："
    read username
    echo "パスワードを入力してください："
    read password
    echo "パスワードの追加は成功しました。"

    #暗号化処理

    #金庫のチェック
    if  [ -f passwords.txt.gpg ]; then
        #金庫がある場合、中身をtemp.txtに取り出す
        gpg --batch --passphrase "aaa" -d passwords.txt.gpg > temp.txt
    else
        #金庫がない場合、空のtemp.txtを作る
        touch temp.txt
    fi

    # passwords.txtに保存
    echo "サービス名：$service_name" >> temp.txt
    echo "ユーザー名：$username" >> temp.txt
    echo "パスワード：$password" >> temp.txt

       
    # temp.txtを暗号化して金庫に
    gpg --batch --passphrase "aaa" -c temp.txt
    mv temp.txt.gpg passwords.txt.gpg
    rm temp.txt


  elif [ "$input" = "Get Password" ]; then
    echo  "サービス名を入力してください："
    read service_name

    #暗号化ファイルが存在するかチェック
    if [ ! -f passwords.txt.gpg ]; then
        echo "そのサービスは登録されていません。"
        continue
    fi

    #一時的に復号化して検索
    gpg --batch --passphrase "aaa" -d passwords.txt.gpg > temp_decrypt.txt 2>/dev/null

    #登録されているサービス名と一致するか確認
    if grep "サービス名：$service_name" temp_decrypt.txt > /dev/null 2>&1; then

         # サービスが存在する場合
        grep -A2 "サービス名：$service_name" temp_decrypt.txt
    else
        # サービスが存在しない場合
        echo "そのサービスは登録されていません。"
    fi

    rm -f temp_decrypt.txt

  # Exit が入力された場合
  elif [ "$input" = "Exit" ]; then
    echo "Thank you!"
   break;
    
  # Add Password/Get Password/Exit 以外が入力された場合
  else
    echo "入力が間違えています。Add Password/Get Password/Exit から入力してください。"
  fi
done

