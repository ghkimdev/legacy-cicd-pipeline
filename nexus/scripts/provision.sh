#!/bin/sh
set -e

NEXUS_URL=http://nexus:8081
ADMIN_USER=admin

echo "Waiting for admin password..."

until [ -f /nexus-data/admin.password ]; do
    sleep 3
done

ADMIN_PASS=$(cat /nexus-data/admin.password)

echo "Waiting for Nexus API..."

until curl -sf ${NEXUS_URL}/service/rest/v1/status > /dev/null; do
    sleep 5
done

echo "Generating LDAP configuration..."

envsubst '
${LDAP_HOST}
${LDAPS_PORT}
${LDAP_BASE_DN}
${LDAP_BIND_DN}
${LDAP_BIND_PASSWORD}
${LDAP_USER_BASE}
${LDAP_ROLE_BASE}
' < templates/ldap.json.template > /tmp/ldap.json

echo "Provisioning LDAP..."

curl --fail -v -u ${ADMIN_USER}:${ADMIN_PASS} \
  -X POST \
  -H "Content-Type: application/json" \
  ${NEXUS_URL}/service/rest/v1/security/ldap \
  -d @/tmp/ldap.json

echo "LDAP provisioning completed"
