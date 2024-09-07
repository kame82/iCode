// グローバルに関数を定義
const live_frame = document.getElementById("live_frame");

// update_live_frameの関数は (edit/new/show).html.erb に記載

document.addEventListener("DOMContentLoaded", function () {
  // 初回ロード時にエディタの内容をiframeに反映
  if (!live_frame) {
    return; // 要素が存在しない場合、処理を中断
  }
  update_live_frame();
});
