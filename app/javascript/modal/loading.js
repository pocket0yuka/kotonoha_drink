document.addEventListener('turbo:load', () => {
  // 複数のフォームIDを配列で管理
  const formIds = ['drink-search-form', 'story-form'];

  // 各(ドリンク検索)フォームに対してイベントリスナーを設定
  formIds.forEach((formId) => {
    const form = document.getElementById(formId);
    if (form) {
      form.addEventListener('submit', () => {
        showLoadingModal(); // ローディングモーダルを表示
      });
    }
  });

 // ドリンク名のリンクに対するイベントリスナーを設定
const modalLinks = document.querySelectorAll('.show-modal');
modalLinks.forEach(link => {
  link.addEventListener('click', (event) => {
    event.preventDefault(); // リンクのデフォルト動作を防止
    showLoadingModal(); // ローディングモーダルを表示
    // Turbo Driveを使用している場合、リンクのhref属性からページを読み込む
    Turbo.visit(event.currentTarget.getAttribute('href'));
  });
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