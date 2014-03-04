Deploying OpenMRS ID
====================

SSH into the server for deployment and change to OpenMRS ID's root

	$ ssh santa
	$ cd /opt/id
	
Switch to the `node` user. It is important to use `su` so that node's bashrc runs, which loads Node's [NVM][nvm] into the path.

	$ sudo su node
	
At this point NVM should have selected Node v0.8 (it should be set by default). To verify:

	$ nvm current		# should return "v0.8.26"
	
Pull the latest commit to master from the OpenMRS ID repo.

	$ git pull origin master
	
Stop the ID server, and restart it.

	$ ./stop.sh			# should return "Node (PID xxxx) killed"
	$ ./start.sh

The start/stop scripts are extremely primitive, so you can verify node is running with a `pgrep node`. If you want to run node interactively (so you can more easily determine if/why it's crashing), run

	$ node app/app



[nvm]: https://github.com/creationix/nvm
