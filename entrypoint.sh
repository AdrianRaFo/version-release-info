
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

# Bump up

#if [[ "$VERSION" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
#  VERSION_PATCH=$(echo "$VERSION" | awk -F"." '{print $NF}')
#  NEXT_PATCH=$(($VERSION_PATCH + 1))
#  ROOT_UNTIL=$(echo "$VERSION" | awk -F "." '{print length($0)-length($NF)}')
#  VERSION_ROOT=$(echo "$VERSION" | cut -c 1-$ROOT_UNTIL)
#  NEXT_VERSION="$VERSION_ROOT$NEXT_PATCH-SNAPSHOT"
#  sed -i -e "s/$VERSION_KEY=$VERSION/$VERSION_KEY=0.0.2-SNAPSHOT/" "$VERSION_FILE"
#  echo "Setting next version $NEXT_VERSION"
#else
#  echo "Bump-up will not be executed, the version is a SNAPSHOT or has a bad format"
#fi