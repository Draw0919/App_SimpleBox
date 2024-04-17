please write a bash so that I can use it to set a Ubuntu OS, which has following properties:

# User Guide
* Explain how to build and run image at the beginning of the docker file

# OS setting
*  small size of Linux Ubuntu

# Game Management Setting
* * add a new user, gm with password "gm". And add him to root group.

# User Setting
* add a new user, allen, who is a regular user.
* In Allen's home directory create a new file, named user.txt. And add a string "user's flag" to the file.
*  set Allen's password as "password". And enable ssh service from any source ip.

# Privilege Escalation Setting
* In root's home directory create a new file, named root.txt. And add a string "root's flag" to the file.
* authorize all users the sudo privilege that can execute cp command with root privileged.
