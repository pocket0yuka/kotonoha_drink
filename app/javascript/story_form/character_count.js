document.addEventListener("turbo:load", function() {
  const textarea = document.getElementById('story-textarea');
  const charCount = document.getElementById('char-count');

  textarea.addEventListener('input', function() {
    const remaining = 60 - textarea.value.length;
    charCount.textContent = `残りの文字数: ${remaining}`;
  });
});