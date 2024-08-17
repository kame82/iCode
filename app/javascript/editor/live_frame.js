document.addEventListener("DOMContentLoaded", function () {
  // iframeの要素を取得
  const live_frame = document.getElementById("live_frame");

  // エディタの内容をiframeに反映
  window.update_live_frame = function () {
    live_frame.contentWindow.document.body.innerHTML =
      document.getElementById("editorSource_HTML").value;
  };
});
