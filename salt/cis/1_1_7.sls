# 1.1.3 - 1.1.5 
#  1.1.3 Ensure nodev option set on /tmp partition
#  1.1.4 Ensure nosuid option set on /tmp partition
#  1.1.5 Ensure nosuid option set on /tmp partition
# Description:
# The nodev mount option specifies that the filesystem cannot contain special devices.
# Rationale:
# Since the /tmp filesystem is not intended to support devices, set this option to ensure that
# users cannot attempt to create block or character special devices in /tmp .

{% set rule = '(1.1.7)' %}

{% if salt['mount.is_mounted']('/var/tmp') %}

#    {% set options = salt['mount.fstab']()['/var/tmp']['opts'] %}

#    {% if 'nosuid' in options and 'noexec' in options and 'nodev' in options %}

{{ rule }} /var/tmp nosuid,nodev,noexec:
    test.succeed_without_changes:
        - name: {{ rule }} /var/tmp already set with nosuid,noexec,nodev.

    {% else %}


{{ rule }} unmount /var/tmp:
    mount.unmounted:
        - name: tmpfs
        - device: /var/tmp    

{{ rule }} remount /var/tmp:
    mount.mounted:
        - name: /var/tmp
        - device: /var/tmp
        - fstype: tmpfs
        - mkmnt: True
        - opts:  rw,nodev,noexec,nosuid,seclabel
        - persist: True
        - user: root

#    {% endif %}

{% else %}
{{ rule }} /var/tmp nosuid,nodev,noexec:
    {% set options = salt['mount.fstab']()['/var/tmp']['opts'] %}

    {% if 'nosuid' in options and 'noexec' in options and 'nodev' in options %}

    {% endif %}
#    test.fail_without_changes:
#        - name: {{ rule }} /var/tmp is not mounted as separate partition, unable to check nosuid,nodev,noexec.
{% endif %}
