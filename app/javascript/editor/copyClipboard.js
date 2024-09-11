// clipboard API

function attachClipboardListener() {
  if (document.getElementById("copyBtn")) {
    document.getElementById("copyBtn").addEventListener("click", function () {
      const HTMLText = document.getElementById("HTML_tab");
      const CSSText = document.getElementById("CSS_tab");

      let copyText;
      if (HTMLText.checked == true) {
        copyText = document.getElementById("editorSource_HTML").value;
      } else if (CSSText.checked == true) {
        copyText = document.getElementById("editorSource_CSS").value;
      } else {
        alert("Please select the language you want to copy");
      }

      const copyBtn = document.getElementById("copyBtn");
      const copiedText = document.getElementById("copiedText");

      navigator.clipboard.writeText(copyText).then(
        () => {
          copyBtn.classList.add("hidden");
          copiedText.classList.remove("hidden");

          window.setTimeout(() => {
            copyBtn.classList.remove("hidden");
            copiedText.classList.add("hidden");
          }, 2200);
        },
        () => {
          alert("Copy failed");
        }
      );
    });
  } else {
    return false;
  }
}

document.addEventListener("turbo:load", attachClipboardListener);
document.addEventListener("turbo:render", attachClipboardListener);
