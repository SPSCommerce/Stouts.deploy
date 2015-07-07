FROM ansible/ubuntu14.04-ansible:devel
MAINTAINER acyost@spscommerce.com
ADD . /tmp/playbook
WORKDIR /tmp/playbook
ENV ANSIBLE_FORCE_COLOR=true
RUN ansible-playbook -i "localhost," -c local test.yml -e "deploy_user=test_user"
RUN ansible-playbook -i "localhost," -c local test.yml -e "deploy_user=test_user" \
    | grep -q 'changed=0.*failed=0' \
    && (echo 'Idempotence test: pass' && exit 0) \
    || (echo 'Idempotence test: fail' && exit 1)
CMD /bin/bash
