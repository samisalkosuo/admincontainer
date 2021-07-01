#admin docker file
FROM rockylinux/rockylinux:8.4

#name of the container should be the name of the container host (-h admincontainer, when starting the container)
ENV ADMIN_CONTAINER_NAME=admincontainer

#install tools, libs, etc
#from /root/setup_scripts directory
#setup scripts for each "larger" component like SSH server and packages from repo
#each .sh file from setup_scripts directory is copied and executed
#one at a time so that builds are cached

WORKDIR /root/setup_scripts

#install ssh server
COPY setup_scripts/ssh_server.sh .
RUN sh ssh_server.sh

#install development tools
COPY setup_scripts/development_tools.sh .
RUN sh development_tools.sh

#install helpful packages
COPY setup_scripts/install_packages.sh .
RUN sh install_packages.sh

#environment variables used in build time
#change these and build your own image
ENV OCP_VERSION=4.6.28

#DISPLAY env for Windows set as default
#use -e DISPLAY to set another DISPLAY
#X-server is needed for Windows: https://sourceforge.net/projects/vcxsrv/ 
#and start 'XLaunch' before starting this container
ENV DISPLAY=host.docker.internal:0

#DISPLAY env in Mac
#X-server is needed for Windows: https://www.xquartz.org/
#and start 'XQuartz' before starting this container
#ENV DISPLAY=docker.for.mac.host.internal:0

#DISPLAY env in Linux, use "--net host" when starting the container
#ENV DISPLAY=:0

#install tools from rpms
COPY setup_scripts/rpm_packages.sh .
RUN sh rpm_packages.sh

#install openshift clients
COPY setup_scripts/openshift_clients.sh .
RUN sh openshift_clients.sh

#install node.js and node related tools
COPY setup_scripts/nodejs.sh .
RUN sh nodejs.sh

#install various tools from git sources
COPY setup_scripts/tools.sh .
RUN sh tools.sh

#change workdir
WORKDIR /root

#tmux setup
COPY .tmux.conf.local ./
#install tmux plugin packages during build by starting session and killing it
RUN tmux new-session -d -s build && sleep 5 && tmux kill-session -t build

#map this volume to host directory where you want your persistent data
VOLUME ["/root/host"]

#ports
EXPOSE 22 3000

COPY environment.sh .
COPY shell.sh .

CMD ["sh","/root/shell.sh"]
