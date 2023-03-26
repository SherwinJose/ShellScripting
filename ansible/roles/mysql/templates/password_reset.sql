SET PASSWORD FOR 'root'@'localhost' = PASSWORD('{{MYSQL_NEW_PASSWORD}}');
uninstall plugin validate_password;