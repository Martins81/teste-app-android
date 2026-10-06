#!/usr/bin/env bash

set -euo pipefail

ANDROID_HOME="${HOME}/android-sdk"
CMDLINE_TOOLS_VERSION="15859902"
CMDLINE_TOOLS_URL="https://dl.google.com/android/repository/commandlinetools-linux-${CMDLINE_TOOLS_VERSION}_latest.zip"

echo "=========================================="
echo " Android App Factory"
echo " Configuração do Android SDK"
echo "=========================================="

mkdir -p "${ANDROID_HOME}/cmdline-tools"

echo "→ A descarregar Android Command-line Tools..."

curl -L "${CMDLINE_TOOLS_URL}" \
  -o /tmp/android-cmdline-tools.zip

echo "→ A preparar Android SDK..."

rm -rf "${ANDROID_HOME}/cmdline-tools/latest"
mkdir -p "${ANDROID_HOME}/cmdline-tools/latest"

unzip -q -o \
  /tmp/android-cmdline-tools.zip \
  -d /tmp/android-cmdline-tools

cp -R /tmp/android-cmdline-tools/cmdline-tools/. \
  "${ANDROID_HOME}/cmdline-tools/latest/"

rm -rf /tmp/android-cmdline-tools
rm -f /tmp/android-cmdline-tools.zip

export ANDROID_HOME="${ANDROID_HOME}"
export ANDROID_SDK_ROOT="${ANDROID_HOME}"

export PATH="${ANDROID_HOME}/cmdline-tools/latest/bin:${ANDROID_HOME}/platform-tools:${PATH}"

echo "→ A aceitar licenças Android..."

yes | sdkmanager --licenses >/dev/null || true

echo "→ A instalar ferramentas Android..."

sdkmanager \
  "platform-tools" \
  "platforms;android-37" \
  "build-tools;36.0.0"

echo "→ A configurar variáveis de ambiente..."

cat >> "${HOME}/.bashrc" <<EOF

# Android App Factory
export ANDROID_HOME="${ANDROID_HOME}"
export ANDROID_SDK_ROOT="${ANDROID_HOME}"
export PATH="\${ANDROID_HOME}/cmdline-tools/latest/bin:\${ANDROID_HOME}/platform-tools:\${PATH}"
EOF

echo ""
echo "=========================================="
echo " Android SDK instalado com sucesso!"
echo "=========================================="
echo ""
echo "ANDROID_HOME=${ANDROID_HOME}"
echo ""