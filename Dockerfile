FROM centos:8.3.2011
ENV container=docker

COPY sshd_config /etc/ssh/

RUN set -ex \
 && dnf update -y \
 && dnf install -y vim wget net-tools iproute lrzsz nano bind-utils traceroute openssh-server unzip bash-completion procps passwd cronie iptables iptables-services iputils util-linux-user \
 && dnf group install "Development Tools" -y \
 && echo "TZ='Asia/Hong_Kong'; export TZ" >> /etc/profile \
 && ln -sf /usr/share/zoneinfo/Asia/Hong_Kong /etc/localtime \
 && systemctl enable sshd.service \
 && systemctl enable crond.service \
 && systemctl enable iptables.service \
 && rm -rf /etc/ssh/ssh_host_dsa_key \
 && rm -rf /etc/ssh/ssh_host_rsa_key \
 && echo "root:123456" | chpasswd \
 && dnf clean all

CMD ["/usr/sbin/init"]
