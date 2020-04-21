#!/usr/bin/env bash

#Args
set -u
VERSION=$1

#Get version info
VERSION_VALUE=$(echo "$VERSION" | tr -d '[:space:]')

if [[ "$VERSION_VALUE" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  IS_RELEASE=true
else
  IS_RELEASE=false
fi

if [[ "$VERSION_VALUE" =~ ^[0-9]+\.[0-9]+\.[0-9]+(-(M|RC)[0-9]+)$ ]]; then
  IS_PRE_RELEASE=true
else
  IS_PRE_RELEASE=false
fi

if [[ "$VERSION_VALUE" == '*-SNAPSHOT' ]]; then
  IS_SNAPSHOT=true
else
  IS_SNAPSHOT=false
fi

if [[ $IS_RELEASE == 'true' || $IS_PRE_RELEASE == 'true' || $IS_SNAPSHOT == 'true' ]]; then
  HAS_VALID_FORMAT=true
else
  HAS_VALID_FORMAT=false
fi

echo "is-release::$IS_RELEASE"
echo "is-pre-release::$IS_PRE_RELEASE"
echo "is-snapshot::$IS_SNAPSHOT"
echo "has-valid-format::$HAS_VALID_FORMAT"