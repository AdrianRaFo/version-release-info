
#Args
set -u
VERSION_FILE=$1
VERSION_KEY=$2

#Get version info
VERSION=$(cat "$VERSION_FILE" | grep "$VERSION_KEY" | cut -d'=' -f2 | tr -d '[:space:]')

if [[ "$VERSION" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  IS_RELEASE=true
else
  IS_RELEASE=false
fi

if [[ "$VERSION" == '*-SNAPSHOT' ]]; then
  IS_SNAPSHOT=true
else
  IS_SNAPSHOT=false
fi

if [[ $IS_RELEASE == 'true' || $IS_SNAPSHOT == 'true' ]]; then
  HAS_VALID_FORMAT=true
else
  HAS_VALID_FORMAT=false
fi

echo "::set-env name=VERSION::$VERSION"
echo "::set-env name=IS_RELEASE::$IS_RELEASE"
echo "::set-env name=IS_SNAPSHOT::$IS_SNAPSHOT"
echo "::set-env name=HAS_VALID_FORMAT::$HAS_VALID_FORMAT"