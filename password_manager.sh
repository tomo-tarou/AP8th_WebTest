#/bin/bash
touch ~/password_data.txt
chmod 755 ~/password_data.txt

echo  "パスワードマネージャーへようこそ！"
read -p "次の選択肢から入力してください(Add Password/Get Password/Exit)：" reply
while ! [[ "${reply}" == "Add Password" || "${reply}" == "Get Password" || "${reply}" == "Exit" ]]
do
	read -p "入力が間違えています。Add Password/Get Password/Exit から入力してください。:" reply
done

# Add Password が入力された場合
while [[ -n ${reply} ]]
do
  if [[ "${reply}" == "Add Password" ]]; then
    read -p "サービス名を入力してください：" service_name
    read -p "ユーザー名を入力してください：" user_name
    read -p "パスワードを入力してください：" password
  
    echo "${service_name}":"${user_name}":"${password}" >> ~/password_data.txt
  	echo
   	echo "パスワードの追加は成功しました。"
  
    read -p "次の選択肢から入力してください(Add Password/Get Password/Exit)：" reply
  
  	while ! [[ "${reply}" == "Add Password" || "${reply}" == "Get Password" || "${reply}" == "Exit" ]]
    do
      read -p "入力が間違えています。Add Password/Get Password/Exit から入力してください。:" reply
    done
  # Get Password が入力された場合
  elif [[ "${reply}" == "Get Password" ]]; then
    read -p "サービス名を入力してください：" service_name
  
    if ! grep -q "${service_name}" ~/password_data.txt; then
  		echo "そのサービスは登録されていません。"
  	  echo
  	elif results=($(grep "${service_name}" ~/password_data.txt | tr ":" " ")); then
  		echo
  		service_name="${results[0]}"
      user_name="${results[1]}"
      password="${results[2]}"
  		echo -e "サービス名:${service_name}\nユーザー名:${user_name}\nパスワード:${password}"
  		echo
  	fi
  
    read -p "次の選択肢から入力してください(Add Password/Get Password/Exit)：" reply
  
  	while ! [[ "${reply}" == "Add Password" || "${reply}" == "Get Password" || "${reply}" == "Exit" ]]
    do
      read -p "入力が間違えています。Add Password/Get Password/Exit から入力してください。:" reply
    done
  # Exit が入力された場合
  elif [[ "${reply}" == "Exit" ]]; then
    echo "Thank you!"
		break
  fi	
done
