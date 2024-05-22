wget http://deploy.merico.cn/deploy/offline/k8s_install.zip
unzip k8s_install.zip
cd k8s_install
sh -x configure_sh.sh
sh -x main.sh
kubectl get node
