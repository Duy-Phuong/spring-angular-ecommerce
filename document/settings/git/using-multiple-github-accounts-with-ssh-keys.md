
## Links
https://gist.github.com/oanhnn/80a89405ab9023894df7

https://www.youtube.com/watch?v=ap56ivm0dhw


## Problem

I have two Github accounts: _oanhnn_ (personal) and _superman_ (for work). I want to use both accounts on same computer (without typing password everytime, when doing git push or pull).

## Solution

Use ssh keys and define host aliases in ssh config file (each alias for an account).

## How to?

1.  [Generate ssh key pairs for accounts](https://help.github.com/articles/generating-a-new-ssh-key/) and [add them to GitHub accounts](https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account/).
    
2.  Edit/Create ssh config file (`~/.ssh/config`):
    
    ```
    # Default github account: oanhnn
    Host github.com
       HostName github.com
       IdentityFile ~/.ssh/oanhnn_private_key
       IdentitiesOnly yes
       
    # Other github account: superman
    Host github-superman
       HostName github.com
       IdentityFile ~/.ssh/superman_private_key
       IdentitiesOnly yes
    ```
    
3.  [Add ssh private keys to your agent](https://help.github.com/articles/adding-a-new-ssh-key-to-the-ssh-agent/):
    
```bash
    $ ssh-add ~/.ssh/oanhnn_private_key
    $ ssh-add ~/.ssh/superman_private_key
```
    
4.  Test your connection
    
```bash
    $ ssh -T git@github.com
    $ ssh -T git@github-superman
```
    
    With each command, you may see this kind of warning, type `yes`:
    
   >The authenticity of host 'github.com (192.30.252.1)' can't be established.
    RSA key fingerprint is xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:
    Are you sure you want to continue connecting (yes/no)?
    
    If everything is OK, you will see these messages:
```
    Hi oanhnn! You've successfully authenticated, but GitHub does not provide shell access.
    
    Hi superman! You've successfully authenticated, but GitHub does not provide shell access.
```

    
5.  Now all are set, just clone your repositories
    
    $ git clone git@github-superman:org2/project2.git /path/to/project2
    $ cd /path/to/project2
    $ git config user.email "superman@org2.com"
    $ git config user.name  "Super Man"

```bash
$ eval "$(ssh-agent -s)"
Agent pid 2377


$ ssh-add ~/.ssh/id_rsa
Enter passphrase for /c/Users/PhuongTran/.ssh/id_rsa:
Identity added: /c/Users/PhuongTran/.ssh/id_rsa (trand@LNV-PF291FAQ)

$ ssh-add ~/.ssh/id_rsa_other
Identity added: /c/Users/PhuongTran/.ssh/id_rsa_other (phuong@MacBook-Pro-Phuong.local)

 
$ cat ~/.ssh/config

# Default github account: oanhnn
Host github.com
   HostName github.com
   IdentityFile ~/.ssh/id_rsa
   IdentitiesOnly yes

  

# Other github account: superman

Host github-superman
   HostName github.com
   IdentityFile ~/.ssh/id_rsa_other
   IdentitiesOnly yes
  

$ git clone git@github.com:Duy-Phuong/phuong-docs.git
Cloning into 'phuong-docs'...
Enter passphrase for key '/c/Users/PhuongTran/.ssh/id_rsa':
git@github.com: Permission denied (publickey).
fatal: Could not read from remote repository.
Please make sure you have the correct access rights
and the repository exists.


$ git clone git@github-superman:Duy-Phuong/phuong-docs.git
Cloning into 'phuong-docs'...
remote: Enumerating objects: 46, done.
remote: Counting objects: 100% (46/46), done.
remote: Compressing objects: 100% (41/41), done.
remote: Total 46 (delta 1), reused 43 (delta 1), pack-reused 
Receiving objects: 100% (46/46), 1.03 MiB | 688.00 KiB/s, done.
Resolving deltas: 100% (1/1), done.

$ ll
-rw-r--r-- 1 AzureAD+PhuongTran 4096 263 Jul 20 09:41 config
-rw-r--r-- 1 AzureAD+PhuongTran 4096 645 Jul 20 11:56 id_rsa
-rw-r--r-- 1 AzureAD+PhuongTran 4096  15 Jul 20 11:56 id_rsa.pub
-rw-r--r-- 1 AzureAD+PhuongTran 4096 647 Jul 20 11:56 id_rsa_other
-rw-r--r-- 1 AzureAD+PhuongTran 4096  15 Jul 20 11:56 id_rsa_other.pub

```

Done! Goodluck!
