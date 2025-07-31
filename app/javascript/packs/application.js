// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import Rails from "@rails/ujs"
Rails.start()
import "@hotwired/turbo-rails"
import "controllers"
import axios from 'axios'
axios.defaults.headers.common['X-CSRF-Token'] = Rails.csrfToken()
// import $ from 'jquery'
import * as ActiveStorage from "@rails/activestorage"
ActiveStorage.start()

document.addEventListener('DOMContentLoaded', () => {
  const avatarUpload = document.getElementById('avatar-upload');
  const avatarInput = document.getElementById('avatar-input');
  const form = document.getElementById('profile-form');
  if (!avatarInput || !form) return;

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

// document.addEventListener('DOMContentLoaded', () => {
//   const avatarUpload = document.getElementById('avatar-upload');
//   const avatarInput = document.getElementById('avatar-input');
//   const form = document.getElementById('profile-form');
//   if (!avatarInput || !form) return;

//   avatarUpload.addEventListener('click', () => {
//     avatarInput.click();
//   });

//   avatarInput.addEventListener('change', () => {
//     form.requestSubmit();
//   });


//   form.addEventListener('ajax:success', (event) => {
//     const [data, status, xhr] = event.detail;
//     if (data.avatar_url) {
//       avatarUpload.src = data.avatar_url;
//     }
//   });

//   form.addEventListener('ajax:error', (event) => {
//     alert('画像のアップロードに失敗しました');
//   });
// });