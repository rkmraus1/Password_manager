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

    # passwords.txtに保存
    echo "サービス名：$service_name" >> passwords.txt
    echo "ユーザー名：$username" >> passwords.txt
    echo "パスワード：$password" >> passwords.txt
    echo "------------------------" >> passwords.txt

  elif [ "$input" = "Get Password" ]; then
    echo  "サービス名を入力してください："
    read service_name

    #登録されているサービス名と一致するか確認
    if grep "サービス名：$service_name" passwords.txt > /dev/null 2>&1; then

         # サービスが存在する場合
        grep -A2 "サービス名：$service_name" passwords.txt
    else
        # サービスが存在しない場合
        echo "そのサービスは登録されていません。"
    fi

  # Exit が入力された場合
  elif [ "$input" = "Exit" ]; then
    echo "Thank you!"
   break;
    
  # Add Password/Get Password/Exit 以外が入力された場合
  else
    echo "入力が間違えています。Add Password/Get Password/Exit から入力してください。"
  fi
done

