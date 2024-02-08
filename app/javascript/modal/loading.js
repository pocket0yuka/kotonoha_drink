document.addEventListener('turbo:load', () => {
  // 複数のフォームIDを配列で管理
  const formIds = ['drink-search-form', 'story-form'];

  // 各フォームに対してイベントリスナーを設定
  formIds.forEach((formId) => {
    const form = document.getElementById(formId);
    if (form) {
      form.addEventListener('submit', () => {
        showLoadingModal(); // ローディングモーダルを表示
      });
    }
  });
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