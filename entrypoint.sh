
#Args
set -u
VERSION_FILE=$1
VERSION_KEY=$2

#Get version info
VERSION_VALUE=$(cat "$VERSION_FILE" | grep "$VERSION_KEY" | cut -d'=' -f2 | tr -d '[:space:]')

if [[ "$VERSION_VALUE" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  IS_RELEASE=true
else
  IS_RELEASE=false
fi

if [[ "$VERSION_VALUE" =~ ^[0-9]+\.[0-9]+\.[0-9]+(-(M|RC)[0-9]+)?$ ]]; then
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

echo "::set-env name=VERSION_VALUE::$VERSION_VALUE"
echo "::set-env name=IS_RELEASE::$IS_RELEASE"
echo "::set-env name=IS_PRE_RELEASE::$IS_PRE_RELEASE"
echo "::set-env name=IS_SNAPSHOT::$IS_SNAPSHOT"
echo "::set-env name=HAS_VALID_FORMAT::$HAS_VALID_FORMAT"

echo "::set-output name=version_value::$VERSION_VALUE"
echo "::set-output name=is_release::$IS_RELEASE"
echo "::set-output name=is_pre_release::$IS_PRE_RELEASE"
echo "::set-output name=is_snapshot::$IS_SNAPSHOT"
echo "::set-output name=has_valid_format::$HAS_VALID_FORMAT"