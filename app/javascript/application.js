// Entry point for the build script in your package.json
import "@hotwired/turbo-rails";
import "./controllers";

import "./editor/editor.bundle.js";

// live_frameの要素を取得
import "./editor/live_frame.js";

// クリップボードにコピーする
import "./editor/copyClipboard.js";

import "./editor/tailwindCheck.js";
