#!/bin/bash 

#installing Red Hat GPG Keys
curl -o /etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release https://www.redhat.com/security/data/fd431d51.txt
curl -o /etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release-aux "http://pgp.mit.edu:11371/pks/lookup?op=get&search=0x45689C882FA658E0"
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release-aux

#account options
sed -i 's/\<nullok\>//g' /etc/pam.d/system-auth
#minimal 14 chars password
var_accounts_password_minlen_login_defs="6"
grep -q ^PASS_MIN_LEN /etc/login.defs && \
  sed -i "s/PASS_MIN_LEN.*/PASS_MIN_LEN     $var_accounts_password_minlen_login_defs/g" /etc/login.defs
if ! [ $? -eq 0 ]; then
    echo "PASS_MIN_LEN      $var_accounts_password_minlen_login_defs" >> /etc/login.defs
fi
#to prevent chaging it back to easy password
var_accounts_minimum_age_login_defs="7"
grep -q ^PASS_MIN_DAYS /etc/login.defs && \
  sed -i "s/PASS_MIN_DAYS.*/PASS_MIN_DAYS     $var_accounts_minimum_age_login_defs/g" /etc/login.defs
if ! [ $? -eq 0 ]; then
    echo "PASS_MIN_DAYS      $var_accounts_minimum_age_login_defs" >> /etc/login.defs
fi


#set lib folders non group writeable
DIRS="/lib /lib64 /usr/lib /usr/lib64"
for dirPath in $DIRS; do
  find "$dirPath" -perm /022 -type f -exec chmod go-w '{}' \;
done

#max 3 login attempts
var_password_pam_retry="3"
if grep -q "retry=" /etc/pam.d/system-auth; then   
  sed -i --follow-symlink "s/\(retry *= *\).*/\1$var_password_pam_retry/" /etc/pam.d/system-auth
else
  sed -i --follow-symlink "/pam_pwquality.so/ s/$/ retry=$var_password_pam_retry/" /etc/pam.d/system-auth
fi

