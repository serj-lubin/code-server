#!/usr/bin/env bash
set -euo pipefail

apply_service_worker_mock_patches() {
  # The `service-worker-mock` package is no longer maintained
  # so we have to apply patches ourselves

  # This patch fixes an undefined error in fetch.js and adds a missing import
  patch --forward node_modules/service-worker-mock/fetch.js < patches/service-worker-mock-fetch.patch

  # This patch adds a missing import
  patch --forward node_modules/service-worker-mock/models/Response.js < patches/service-worker-mock-response.patch

  # This patch fixes the types declaration file
  # See discussion:
  patch --forward node_modules/@types/service-worker-mock/index.d.ts < patches/service-worker-types.patch
}

main() {
  echo -e "🔨 Applying patches..."
  apply_service_worker_mock_patches

  echo -e "✅ Patches applied successfully."
}

main "$@"
