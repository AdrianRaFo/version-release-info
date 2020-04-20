# Version-release-info

A little github action to get information about the version format.

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
uses: AdrianRaFo/version-release-info@v1
  with:
    version: env.git-version
- name: Do something if release
  if: steps.is-release == 'true'
```
