document.addEventListener('DOMContentLoaded', () => {
  document.querySelectorAll('.js-file-select-preview').forEach(element => {
    element.addEventListener('change', (event) => {
      const file = event.target.files[0];
      if (file) {
        const reader = new FileReader();
        reader.onload = (e) => {
          const preview = document.getElementById('preview-target');
          if (preview) {
            preview.src = e.target.result;
          }
        };
        reader.readAsDataURL(file);
      }
    });
  });
});