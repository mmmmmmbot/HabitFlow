#!/bin/sh
set -e
GRADLE_VERSION=8.7
DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
ZIP="$DIR/.gradle/gradle-$GRADLE_VERSION-bin.zip"
HOMEGRADLE="${HOME}/.gradle"
DIST="$HOMEGRADLE/caches/habitflow-gradle/gradle-$GRADLE_VERSION"
if [ ! -x "$DIST/bin/gradle" ]; then
  mkdir -p "$HOMEGRADLE/caches/habitflow-gradle"
  tmp="$HOMEGRADLE/caches/habitflow-gradle/gradle.zip"
  curl -fsSL "https://services.gradle.org/distributions/gradle-$GRADLE_VERSION-bin.zip" -o "$tmp"
  rm -rf "$DIST"
  mkdir -p "$DIST"
  unzip -q "$tmp" -d "$HOMEGRADLE/caches/habitflow-gradle/"
  mv "$HOMEGRADLE/caches/habitflow-gradle/gradle-$GRADLE_VERSION" "$DIST"
fi
exec "$DIST/bin/gradle" "$@"
