// グローバルに関数を定義
window.update_live_frame = function () {
  const live_frame = document.getElementById("live_frame");
  const html_editor_value = document.getElementById("editorSource_HTML").value;

  if (live_frame && live_frame.contentWindow && live_frame.contentWindow.document) {
    live_frame.contentWindow.document.body.innerHTML = html_editor_value;
  }
};

document.addEventListener("DOMContentLoaded", function () {
  // 初回ロード時にエディタの内容をiframeに反映
  update_live_frame();
});
