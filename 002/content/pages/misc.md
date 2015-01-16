title: Miscellaneous
date: Jan 2 2014
## Markdown Syntax Quirks

1. Code blocks within a list must be indented by 8 spaces.

## Getting Started With Complex Math in C.

Complex math is supported by C99.  The following code example 
demonstrates a simple use of complex functions provided by C99.

    :::C
    #include <stdio.h>
    #include <complex.h>
    
    int main (void)
    {
        double complex z1 = 1.0 + 3.0 * I;
        double complex z2 = 1.0 - 4.0 * I;
    
        printf("Working with complex numbers:\n\v");
    
        printf("Starting values: Z1 = %.2f + %.2fi\tZ2 = %.2f %+.2fi\n",
		creal(z1), cimag(z1), creal(z2), cimag(z2));
    
        double complex sum = z1 + z2;
        printf("The sum: Z1 + Z2 = %.2f %+.2fi\n", creal(sum), cimag(sum));
    
        double complex difference = z1 - z2;
        printf("The difference: Z1 - Z2 = %.2f %+.2fi\n", creal(difference),
		cimag(difference));
    
        double complex product = z1 * z2;
        printf("The product: Z1 x Z2 = %.2f %+.2fi\n", creal(product), 
		cimag(product));
    
        double complex quotient = z1 / z2;
        printf("The quotient: Z1 / Z2 = %.2f %+.2fi\n", creal(quotient),
		cimag(quotient));
    
        double complex squareroot = csqrt(z1);
        printf("The conjugate of Z1 = %.2f %+.2fi\n", creal(squareroot), 
		cimag(squareroot));
    
        return 0;
    }

    
Compile/Link this with the following command

`gcc -std=c99 -o example example.c -lm`

The option flag `-lm` tells gcc to include the math libraries (this is 
done by default for `stdio.h` for example, but not maths).  
    
## Making a Time-Lapse Movie in Linux

Capture a sequence of images with your webcam. 

If you are like me, you might have used a timestamp for the image
names. If so, you will need to rename all of them to have a name
followed by an uninterrupted sequence of numbers (hi00.jpg, hi01.jpg,
hi02.jpg,...).  To avoid the trouble of renaming every file and
thereby losing the timestamps, you may create symbolic links to the
files.  The following bash script will do just that, output a sequence
of files in chronological order and create links for them within the
`/tmp` directory of your system. Then the video encoder will accept
the sequence of links and make a movie (it doesn't need to know they
point to files with timestamps in the filename...). Change the video
output format to suit your fancy.

From within the directory of the images, run the following:

    :::bash
    x=1; 
    for i in *.jpg*; # extra * for syntax highlight problems in editor
    do counter=$(printf %03d $x); 
    ln /pathtoimages/"$i" /tmp/img"$counter".jpg -s; x=$(($x+1)); 
    done
    
    avconv -i /tmp/img%03d.jpg -vcodec mpeg4 test.avi

If you plan to do this with different sets of files, you must delete 
    the links within `/tmp` before creating new links. 
    
## Averaging a Sequence of Images

There are many ways to accomplish this. One way is to use the Python
Image Library. The key command in this process is `Image.blend(image1,
image2, alpha)`.

Another is to properly set the alpha value to simulate a straight 
average of ALL images together. 

A summary of these two ideas follows:

    :::python
    Image.blend(previm, currim, alpha)
    alpha = 0.5 / num_images

## Setup SSH on LAN

1. Install openssh-server on your system unless it is already installed.
1. If you are on an Ubuntu based distro, install Uncomplicated Firewall (ufw).
1. Open the SSH port: `sudo ufw allow ssh`
1. Make a backup of your sshd_config file:

        sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.original  
        sudo chmod a-w /etc/ssh/sshd_config.original
        
1. Create an authorized keys file and set correct permissions for it:
        
        touch ~/.ssh/authorized_keys  
        chmod 0700 ~/.ssh/  
        chmod 0600 ~/.ssh/authorized_keys  

1. I have an encrypted home folder. I followed the instructions from 
https://help.ubuntu.com/community/SSH/OpenSSH/Keys. 
> ### Encrypted Home Directory
> If you have an encrypted home directory, SSH cannot access your 
authorized_keys file because it is inside your encrypted home directory
and won't be available until after you are authenticated. Therefore, SSH
will default to password authentication.
>
> To solve this, create a folder outside your home named 
/etc/ssh/<username\> (replace "<username\>" with your actual username). 
This directory should have 755 permissions and be owned by the user. 
Move the authorized_keys file into it. The authorized_keys file should 
have 644 premissions and be owned by the user.
>
> Then edit your /etc/ssh/sshd_config and add:
>
> `AuthorizedKeysFile    /etc/ssh/%u/authorized_keys`
>
> Finally, restart ssh with:
>
> `sudo restart ssh`

1. Create a key pair.

        ssh-keygen -f /etc/ssh/<username>/id_rsa

1. If you wish to login to your computer from others, transfer their 
public keys to your computer.  Add them to your `authorized_keys`:

        cat mykey_rsa >> /etc/ssh/<username>/authorized_keys
        
1. Disable  password login (quoting from Ubuntu Docs OpenSSH):
>
> It's recommended to disable password authentication unless you have a specific reason not to.
>
>To disable password authentication, look for the following line in your sshd_config file:
>
> `#PasswordAuthentication yes`
>
> replace it with a line that looks like this:
>
> `PasswordAuthentication no`
>
> Finally, restart ssh with:
>
> `sudo restart ssh`

1. Try to login from the remote computer to your computer now.
1. If you have any problems, read the SSH `man` page and also try the 
following (again from the Ubuntu Docs OpenSSH page):
>
> ###Debugging and sorting out further problems
>
> The permissions of files and folders is crucial to this working. You 
> can get debugging information from both the client and server.
>
> if you think you have set it up correctly , yet still get asked for 
> the password, try starting the server with debugging output to the terminal.
>
> `sudo /usr/sbin/sshd -d`

## Uncomplicated Firewall (ufw) Setup and Vino (VNC)

1. Install ufw.
1. Enable it:
> `sudo ufw enable`
1. Open port 22 for any protocal to a specific IP address:
> `sudo ufw allow from 192.168.1.100 to any port 22`
1. Install vino. 
1. Run `sudo vino-preferences`.
1. Start vino-server: `/usr/lib/vino/vino-server &`
1. Check to make sure it is running and listening on port 5900:
> `netstat -nl | grep 5900`
1. To permit only local connections (Ubuntu 11.10 and newer):
> `gsettings set org.gnome.Vino network-interface lo`
1. To permit connections from anywhere (Ubuntu 11.10 and newer):
> `gsettings reset org.gnome.Vino network-interface`
1. On the remote machine, forward port 5900 on the vino-server
machine to your port 5900:
> `ssh -L 5900:localhost:5900 user@remotebox`

## Adding a global .gitignore File
(Pulled from the Github docs)

1. Create the file `~/.gitignore_global` and add some rules to it.
1. To add this to your config, run 
> `git config --global core.excludesfile ~/.gitignore_global`

## Per-repo Git Settings
(from the Github help docs)

	$ cd my_other_repo
	# Changes the working directory to the repo you need to switch info for
	$ git config user.name "Different Name"
	# Sets the user's name for this specific repo
	$ git config user.email "differentemail@email.com"
	# Sets the user's email for this specific repo
	
## Internet Radio Streams with Mplayer

    mplayer -playlist kmusic.m3u

## Git Branching (Git Pro Book, by Scott Chacon)
    
    # Create branch pointer
    git branch testing
    # Switch to the 'testing' branch
    git checkout testing

    # Create branch and switch to it
    git checkout -b iss53
    # Switch back to master branch
    git checkout master
    
    # Create another branch and switch to it
    git checkout -b hotfix
    # Make changes and commits
    # Go back to master
    git checkout master
    # Merge hotfix back into master
    git merge hotfix
    # Now you may delete the hotfix branch/pointer (it's redundant now)
    git branch -d hotfix
    
    # Go back to iss53
    git checkout iss53
    # If you needed the changes now in master in iss53, merge master into it
    git merge master
    # When finished with iss53, go back to master and merge in iss53
    git checkout master
    git merge iss53
    # Cleanup
    git branch -d iss53

### Branch Management
    
    # display branches
    git branch
    # show last commit on each branch
    git branch -v
    # show branches already merged into current branch
    git branch --merged
    # show branches not yet merged into current branch
    git branch --no-merged
    
### Remote references

    # Update remote references
    git fetch origin

## Check for iMac Sleep Problems

FROM: http://forums.macrumors.com/showpost.php?p=14336469&postcount=9
 Feb 16, 2012, 10:18 PM	   #9
raxafarian
macrumors regular
 
Join Date: Jun 2007
this was my problem:
I had the same issue with no sleep when shutting the lid. I'd open the lid and the screen would light up for a few seconds and then go black. If I waited a minute or so I could click the trackpad and the screen would turn back on.

Drove me crazy for about 2 weeks. Then I noticed if I unplugged the cord it would sleep fine. More head scratching.

I found this someplace .... open a terminal window and type:
pmset -g assertions

and you can see what is keeping it from sleeping. In my case it was a few printers set for sharing (don't know how that happened). I deleted the unneeded printers and turned sharing off on the two I use. 

Reran the terminal command:
pmset -g assertions 
and now nothing is preventing system sleep.

Other commands I used:
pmset -g (to get the process id)

and 
ps -ef |grep -e 17
(with 17 being the process id from the previous command results)


Hope this helps.

## Git

### Search for string in a commit

    $ git log -p -S stringToFind

### Git setup

    $ git config --global user.name "Your Name"
    $ git config --global user.email. "your_email@example.com"
    $ ssh-keygen -t rsa -C "your_email@example.com"

### Committing and Staging

    # show diff in editor when writing commit message
    $ git commit -v
    # keep file, prevent git from tracking it
    $ git rm --cached readme.txt
    # diff of staged changes
    $ git diff --staged
    # amend last commit message
    $ git commit --amend

### Git Tags

    # lightweight tags
    $ git tag v1.1-1

    # tag a specific commit later
    $ git tag -a v1.2 -m 'version 1.2' 9cdef4e

    # share a specific tag
    $ git push origin v1.5
    # share all tags
    $ git push origin --tags

    # look at a specific tag
    $ git show v1.4

### Branching and Merging

    # create and checkout new branch
    $ git checkout -b newbranch
    # merge things back into master
    $ git checkout master
    $ git merge newbranch

    # See what has been merged back or not
    $ git branch --merged
    $ git branch --no-merged

### Git log

    # show one-liners for last five commits
    $ git log --abbrev-commit --pretty=oneline -5

    # From SO, [http://stackoverflow.com/a/9074343](http://stackoverflow.com/a/9074343)
    I have two aliases I normally throw in my ~/.gitconfig file:

    [alias]
    lg1 = log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all
    lg2 = log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all
    lg = !"git lg1"
    
