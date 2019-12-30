# 1.4.1 Ensure permissions on bootloader config are configured
# Description:
# The grub configuration file contains information on boot settings and passwords for
# unlocking boot options. The grub configuration is usually located at /boot/grub/grub.cfg
# and linked as /etc/grub.cfg . Additional settings can be found in the
# /boot/grub/user.cfg file.
# Rationale:
# Setting the permissions to read and write for root only prevents non-root users from
# seeing the boot parameters or changing them. Non-root users who read the boot
# parameters may be able to identify weaknesses in security upon boot and be able to exploit them
{% set rule = '(1.4.1)' %}

{% set files = ['/boot/grub/grub.cfg', '/boot/grub/user.cfg'] %}

{% for file in files %}
{% if salt['file.file_exists'](file) %}
{{ rule }} boot config set on {{ file }}:
    file.managed:
        - name: {{ file }}
        - user: root
        - group: root
        - mode: 600
        - create: False
{% endif %}
{% endfor %}
