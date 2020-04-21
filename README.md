# Version Release Info

A little github action to get information about the version release format.

## Output

This action provides the following information:

 - has-valid-format: If the version has the right format: major.minor.patch-M|RC|SNAPSHOT
 
 - is-release: If the version has a release format. This excludes milestones, release-candidates and snapshots

 - is-pre-release: If the version has a pre-release format like milestones or release-candidates

 - is-snapshot: If the version is a snapshot.

## Example

```yaml
- name: Get version
  run: echo "::set-env name=git-version::$(git describe --abbrev=0 --tags)"
- uses: AdrianRaFo/version-release-info@v1
  id: v-info #Required to use outputs
  with:
    version: ${{ env.git-version }}
- name: Do something if release with env
  if: env.is-release == 'true'
  #OR
- name: Do something if release with outputs
  if: steps.v-info.outputs.is-release
```

## Thanks

Special thanks to @rachelcarmena for her help with the regex.
