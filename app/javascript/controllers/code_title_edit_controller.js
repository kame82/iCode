import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="code-title-edit"
export default class extends Controller {
  // connect() {
  //  // 接続確認
  //   console.log("connected");
  // }
  noSubmit(event) {
    const codeTitleInput = document.getElementById("code_title_input");
    codeTitleInput.blur();
    event.preventDefault();
  }
  edit() {
    const codeTitle = document.getElementById("code_title");
    const codeTitleEdit = document.getElementById("code_title_edit");
    const codeTitleInput = document.getElementById("code_title_input");
    var defaultValue = codeTitle.textContent;

    // タイトルをクリックしたらinputに変更
    codeTitle.style.display = "none";
    codeTitleEdit.style.display = "none";
    codeTitleInput.style.display = "block";
    codeTitleInput.focus();
    defaultValue = codeTitle.textContent;

    // inputからフォーカスが外れたらタイトルに変更
    codeTitleInput.addEventListener("blur", function () {
      const codeTitleInputValue = codeTitleInput.value.trim();
      if (codeTitleInputValue === "") {
        codeTitleInput.value = defaultValue; // 空白の場合はdefaultValueを代入
        codeTitle.textContent = defaultValue; // codeTitleもdefaultValueに設定
      } else {
        defaultValue = codeTitleInputValue; // 新しい値をdefaultValueに更新
        codeTitle.textContent = codeTitleInputValue; // 入力値をタイトルに設定
      }
      codeTitle.style.display = "inline-block";
      codeTitleEdit.style.display = "inline-block";
      codeTitleInput.style.display = "none";
    });
  }
}
