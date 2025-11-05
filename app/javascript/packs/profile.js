document.addEventListener('turbo:load', () => {
  const avatarUpload = document.getElementById('avatar-upload');
  const avatarInput = document.getElementById('avatar-input');
  const form = document.getElementById('profile-form');
  if (!avatarInput || !form) return;

  if (avatarUpload.dataset.bound) return;
  avatarUpload.dataset.bound = true;

  avatarUpload.addEventListener('click', () => {
    avatarInput.click();
  });

  avatarInput.addEventListener('change', async () => {
    const formData = new FormData(form);

    try {
      const response = await fetch(form.action, {
        method: 'PATCH',
        headers: {
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
        },
        body: formData
      });

      if (response.ok) {
        const data = await response.json();
        if (data.avatar_url) {
          avatarUpload.src = data.avatar_url;
        }
      } else {
        console.error('アップロード失敗', await response.text());
        alert('画像のアップロードに失敗しました');
      }
    } catch (error) {
      console.error('通信エラー:', error);
      alert('通信エラーが発生しました');
    }
  });
});