// グローバルに関数を定義
const live_frame = document.getElementById("live_frame");
window.update_live_frame = function () {
  const html_editor_value = document.getElementById("editorSource_HTML").value;

  if (live_frame && live_frame.contentWindow && live_frame.contentWindow.document) {
    live_frame.contentWindow.document.body.innerHTML = html_editor_value;
  }
};

document.addEventListener("DOMContentLoaded", function () {
  // 初回ロード時にエディタの内容をiframeに反映
  if (!live_frame) {
    return; // 要素が存在しない場合、処理を中断
  }
  update_live_frame();
});
