## README

### Guard setup

#### In terminal 1
1. _vagrant up_

2. _vagrant ssh_

3. _cd /vagrant/_

4. _rails s -b 0.0.0.0_

5. open [localhost:3000](http://locahost:3000)

#### In terminal 2

1. _vagrant ssh_

2. _cd /vagrant/_

3. _guard -p -l 1_

4. Refresh localhost:3000, you will see __INFO - Browser connected.__

5. Make a change to a js, html, css file, and the browser will auto refresh the page.

6. (quit guard with _exit_)

### Vagrant setup
Alright, so I have it done. I am walking through the steps as I type this so I don't miss anything. If something doesn't seem right, let me know and I can fix it. This is my first time use vagrant too. OS = operating system (windows, linux)

I'll explain what you're doing for each step too. You don't need to completely understand. Type the stuff in italics into the command line, then hit enter.

(virtual box allows you to install virtual machines, an OS inside an OS basically. vagrant allows you to automate OS installs and have the host and guest OS share space, making the project accessible for both OSs)
#### 0. Pre-req:
[Install virtual box](https://www.virtualbox.org/)

[Install vagrant](https://www.vagrantup.com/downloads.html)

Pull for latest updates for the project through git (you should see a file called 'Vagrantfile' in the root folder)

Right click project, Open in Git Shell/Terminal

(you will have to restart for vagrant install, there shouldn't be any tricks when installing, nothing to checkmark)

(we will run vagrant, which installs everything you need. this will take awhile, but please watch it for errors. I've sat through this a bunch of times and works for me)
#### 1. Install vagrant os:
(you will be typing this into the black git shell you just opened)

_vagrant up_ (this installs ruby, rails, postgresql, nodejs to get the complete package. also sets some stuff up)
(this will take awhile to be finish. 10+ minutes for me. if you're stuck on 'Building native extensions' forever, it's going right)

(you just installed the vagrant os, but have not connected to it yet)
#### 2. Connect to vagrant
_vagrant ssh_ (connects you to your vagrant os, puts you in magic vagrant linux land)

(you will only need to run these commands once ever, unless you delete vagrant and reinstall everything of course)
#### 3. One Time Database Setup commands
_sudo su postgres_

_createuser vagrant_

_y_ (answer yes to 'shall new user be superuser?')

_exit_

#### 4. Rails commands
_cd /vagrant_ (move to project folder)

_ls_ (lower case letter L, then s. list/shows the stuff in the current folder, you should see app, bin,config, etc like where you have the project in windows. I assume ls stands for 'list stuff')

_bundle install_ (gets ruby addons called gems)

_rake db:setup_ (sets up the actual database for use)

_rails server --bind 0.0.0.0_ (starts the rails server)

You are done setting up here.

Now if you go into a browser, and go to [localhost:3000](localhost:3000), you should see bomb-hills in the state that you sent to me in the zip.

#### 5. Exiting and stopping server and vagrant
Ctrl + C (stops the rails server)

_exit_ (exit vagrant, you are now in windows land again)

_vagrant halt_ (stops the vagrant os)

#### 6. Starting vagrant and rails server when not the first time
(you will be doing this whenever you shutdown vagrant, turn off your computer, etc.)

_vagrant up_ (this starts vagrant linux land. will not take forever if it is not your first. the setup stuff only runs when you first run vagrant up on a fresh install)

_vagrant ssh_ (puts you in vagrant linux magic land)

_cd /vagrant_

_bundle install_ (if you want, you don't need to every time)

_rake db:setup_ (you don't need to do this every time either, only when you want a fresh database)

_rails s --bind 0.0.0.0_ (this starts the server, you will need to do this every time of course. go to [localhost:3000](localhost:3000) to see the website)

#### 7. Edit a file
(just to show you how easy it is to make front end changes)
in windows project folder, open the file app/views/layouts/_navbar.html.erb in whatever text editor you want (sublime text is good)

type something into the div (big boys)

save the file

refresh localhost:3000

you will see the text (big boys) on the top left, git will say you have 1 change

#### X. If you mess up
Vagrant is a self contained virtual machine, and does not interact with your windows at all. So you could blow up vagrant linux, and windows will not be affected. So if you mess up, press Ctrl+C to stop everything. Then open virtual box (Oracle VM Virtual Box) from start menu. You should see bomb-hills_default_... That is your virtual machine. If it is running, you can stop it with Right Click -> Close -> Power Off. And to restart the process if you messed up, Right Click -> Remove -> Delete All Files for fresh start. Then go back to Step 1.
