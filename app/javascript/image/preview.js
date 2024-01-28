document.addEventListener('turbo:load', () => {
  const elements = document.querySelectorAll('.js-file-select-preview');
  elements.forEach((element) => {
    const previewElement = document.querySelector(element.dataset.target);
    if (previewElement) {
      element.addEventListener('change', (e) => {
        const reader = new FileReader();
        reader.onloadend = () => {
          previewElement.src = reader.result;
        };
        const file = e.target.files[0];
        if (file) {
          reader.readAsDataURL(file);
        }
      });
    }
  });
});