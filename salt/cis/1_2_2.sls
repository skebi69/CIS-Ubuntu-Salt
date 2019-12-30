# 1.2.2 - 1.2.3  GPG Checks

# 1.2.2 Ensure GPG keys are configured
# Description:
# Most packages managers implement GPG key signing to verify package integrity during
# installation.
# Rationale:
# It is important to ensure that updates are obtained from a valid source to protect against
# spoofing that could lead to the inadvertent installation of malware on the system.
{% set rule = '(1.2.2)' %}
{{ rule }} ensure GPG keys are configured:
    cmd.run:
        - name: "apt-key list"
