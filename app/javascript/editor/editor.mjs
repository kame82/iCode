import { EditorView, basicSetup, minimalSetup } from "codemirror";
import { html } from "@codemirror/lang-html"; // HTML用のインポート

import { tags } from "@lezer/highlight";
import { HighlightStyle } from "@codemirror/language";
import { syntaxHighlighting } from "@codemirror/language";

// -------Tabキーでインデントを行うためのインポート------
import { keymap } from "@codemirror/view";
import { indentWithTab } from "@codemirror/commands";
import { javascript } from "@codemirror/lang-javascript";
// ------------------------------------------------

// テーマの定義
let myTheme = EditorView.theme(
  {
    "&": {
      color: "white",
      backgroundColor: "#034",
    },
    ".cm-content": {
      caretColor: "#0e9",
    },
    "&.cm-focused .cm-cursor": {
      borderLeftColor: "#0e9",
    },
    "&.cm-focused .cm-selectionBackground, ::selection": {
      backgroundColor: "#074",
    },
    ".cm-gutters": {
      backgroundColor: "#045",
      color: "#ddd",
      border: "none",
    },
  },
  { dark: true }
);

// エディタの高さの固定
const fixedHeightEditor = EditorView.theme({
  "&": { height: "300px" },
  ".cm-scroller": { overflow: "auto" },
});

// シンタックスハイライトのカスタマイズ
const myHighlightStyle = HighlightStyle.define([
  {
    tag: tags.keyword,
    color: "#f92672",
  },
  {
    tag: tags.name,
    color: "#a6e22e",
  },
  {
    tag: tags.string,
    color: "#e6db74",
  },
]);

// エディタの内容が変更されたときに更新
const Editor_updateListener = EditorView.updateListener.of(function (e) {
  if (e.docChanged) {
    submit();
  }
});

// エディタの初期化
let editor_HTML = new EditorView({
  extensions: [
    basicSetup,
    minimalSetup,
    html(),
    myTheme,
    fixedHeightEditor,
    syntaxHighlighting(myHighlightStyle),
    keymap.of([indentWithTab]),
    javascript(),
    Editor_updateListener,
  ],
  parent: document.querySelector("#editor_HTML"),
});

// エディタの内容をtextareaに同期
const syncEditor = () => {
  editor_HTML.value = editor_HTML.state.sliceDoc();
  // console.log(editor_HTML.value);
};

// エディタの内容をtextareaに送信
function submit() {
  syncEditor();
  document.querySelector("#editorSource").value = editor_HTML.value;
}

// エディタ(textarea)の非表示
// const editorSource = document.querySelector("#editorSource");
// editorSource.setAttribute("hidden", "true");
