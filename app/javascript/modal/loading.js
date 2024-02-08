document.addEventListener('turbo:load', () => {
  const searchForm = document.getElementById('drink-search-form');
  const loadingModal = document.getElementById('loadingModal');

  searchForm.addEventListener('submit', (e) => {
    // モーダルを表示する
    loadingModal.classList.remove('hidden');
  });
});

document.addEventListener('turbo:load', function() {
  const searchForm = document.getElementById('drink-search-form');

  if (searchForm) {
    searchForm.addEventListener('submit', function(event) {
      showLoadingModal(); // フォーム送信時にローディングモーダルを表示
    });
  }
  
  // Ajaxリクエストが成功したらローディングモーダルを非表示にする
  // RailsのUJSによるajax:successイベントを利用
  $(document).on('ajax:success', function() {
    hideLoadingModal();
  });
  
  // エラー時もモーダルを非表示にする
  $(document).on('ajax:error', function() {
    hideLoadingModal();
  });
});