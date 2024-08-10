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

// エディタの初期化
let editor = new EditorView({
  extensions: [
    basicSetup,
    minimalSetup,
    html(),
    myTheme,
    fixedHeightEditor,
    syntaxHighlighting(myHighlightStyle),
    keymap.of([indentWithTab]),
    javascript(),
  ],
  // parent: document.body,
  parent: document.querySelector("#editor"),
});
