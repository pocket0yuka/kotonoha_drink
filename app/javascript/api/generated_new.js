document.addEventListener('turbo:load', function() {
  const form = document.getElementById('story-form'); // IDを更新
  if (form) {
    form.addEventListener('submit', function(e) {
      const story = document.getElementById('story-textarea').value; // ここはそのままでOK
      if (story.trim() === '') {
        e.preventDefault(); // 送信を阻止
        alert("注文内容を入力してください。"); // アラートを表示
      }
    });
  }
});