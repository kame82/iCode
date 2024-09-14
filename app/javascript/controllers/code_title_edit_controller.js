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
  noSubmitTag(event) {
    const tagInput = document.getElementById("tag_input");
    tagInput.blur();
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

  // プライベートチェックボックスの表示切り替え
  initialize() {
    this.toggleIconDisplay();
  }
  public() {
    this.toggleIconDisplay();
  }
  toggleIconDisplay() {
    const publicIcon = document.getElementById("public_icon");
    const privateIcon = document.getElementById("private_icon");
    const checkBox = document.getElementById("private-checkBox");

    if (checkBox.checked) {
      publicIcon.style.display = "none";
      privateIcon.style.display = "inline-block";
    } else {
      publicIcon.style.display = "inline-block";
      privateIcon.style.display = "none";
    }
  }
}
