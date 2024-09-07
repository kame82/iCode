// clipboard API
document.getElementById("copyBtn").addEventListener("click", function () {
  const HTMLText = document.getElementById("HTML_tab");
  const copyText = document.getElementById("editorSource_HTML").value;
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
