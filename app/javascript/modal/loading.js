document.addEventListener('turbo:load', () => {
  const searchForm = document.getElementById('drink-search-form');

  if (searchForm) {
    searchForm.addEventListener('submit', () => {
      showLoadingModal(); // モーダルを表示
      // ここではe.preventDefault()を使用しない
      // フォームのデフォルトのGET送信を利用してページ遷移を行う
    });
  }
});

// モーダルを表示する関数
function showLoadingModal() {
  const modalOverlay = document.getElementById('modalOverlay');
  modalOverlay.classList.remove('hidden');
}

// モーダルを非表示にする関数
function hideLoadingModal() {
  const modalOverlay = document.getElementById('modalOverlay');
  modalOverlay.classList.add('hidden');
}