import { EditorView, basicSetup, minimalSetup } from "codemirror";
import { html } from "@codemirror/lang-html"; // HTML用のインポート
import { css } from "@codemirror/lang-css"; // CSS用のインポート

import { tags } from "@lezer/highlight";
import { HighlightStyle } from "@codemirror/language";
import { syntaxHighlighting } from "@codemirror/language";

import { EditorState } from "@codemirror/state"; //readOnlyのためのインポート
// -------Tabキーでインデントを行うためのインポート------
import { keymap } from "@codemirror/view";
import { indentWithTab } from "@codemirror/commands";
import { javascript } from "@codemirror/lang-javascript";
// ------------------------------------------------

// live_frameの要素を取得
import "./live_frame.js";

// エディタのセットアップに必要な共通部分を関数化
function setupEditor(language, editorElementId, textareaId) {
  // textareaの有無を確認
  const textarea = document.querySelector(textareaId);
  if (!textarea) {
    return; // 要素が存在しない場合、処理を中断
  }

  // ============================
  // 共通パーツ1
  // ============================

  // テーマの定義
  let myTheme = EditorView.theme(
    {
      "&": {
        color: "white",
        backgroundColor: "#333333",
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
        backgroundColor: "#333333",
        color: "#ddd",
        border: "none",
      },
    },
    { dark: true }
  );

  // エディタの高さの固定
  const fixedHeightEditor = EditorView.theme({
    "&": { height: "50vh" },
    ".cm-scroller": { overflow: "auto" },
  });

  // エディタのパディングの固定
  const fixedPaddingEditor = EditorView.theme({
    "&": { padding: "5px 0" },
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
      submitTextarea();
      update_live_frame();
    }
  });

  // extensionの定義
  let extensions = [
    basicSetup,
    minimalSetup,
    myTheme,
    fixedHeightEditor,
    fixedPaddingEditor,
    syntaxHighlighting(myHighlightStyle),
    keymap.of([indentWithTab]),
    language(), // 動的に言語を指定
    Editor_updateListener,
  ];

  function read_only() {
    return [EditorState.readOnly.of(true), EditorView.editable.of(false)]; // 読み取り専用,編集不可に設定
  }

  // data-controllerがあるかどうかで拡張を追加
  if (document.querySelector('[data-controller="read-only-editor"]')) {
    extensions.push(read_only());
  }

  // ============================
  // エディタの初期化
  // ============================
  let editor = new EditorView({
    extensions: extensions,
    parent: document.querySelector(editorElementId),
  });

  // エディタの初期内容を設定
  editor.dispatch({
    changes: {
      from: 0,
      to: editor.state.doc.length,
      insert: textarea.value,
    },
  });

  // ============================
  // 共通パーツ2
  // ============================
  // エディタの内容をtextareaに送信
  function submitTextarea() {
    textarea.value = editor.state.sliceDoc();
  }
}

document.addEventListener("turbo:load", function () {
  // HTMLエディタのセットアップ
  setupEditor(html, "#editor_HTML", "#editorSource_HTML");

  // CSSエディタのセットアップ
  setupEditor(css, "#editor_CSS", "#editorSource_CSS");
});
