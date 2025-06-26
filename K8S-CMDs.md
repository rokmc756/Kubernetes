- name: Check Kube Minor Version if less than v1.24.x
  shell: |
    kubectl version | grep "Server Version" | awk '{print $3}' | cut -d . -f 2
  register: kube_minor_version
  when: inventory_hostname in groups['master']


- name: Make Sure that CF for K8S should be installed on versions less than Kube 1.24.x
  debug:
    msg: "CF for K8S should be required on versions higher than k8s v1.25.x"
  when: inventory_hostname in groups['master'] and ( kube_minor_version.stdout|int < 25 )


