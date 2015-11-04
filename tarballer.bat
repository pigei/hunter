@echo off
tar czf %1.tar.gz cmake scripts LICENSE README.md
openssl sha1 %1.tar.gz > %1.sha1
cat %1.sha1