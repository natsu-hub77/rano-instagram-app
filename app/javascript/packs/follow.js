import axios from 'axios'
import $ from 'jquery'
import Rails from "@rails/ujs"

axios.defaults.headers.common['X-CSRF-Token'] = Rails.csrfToken()

document.addEventListener('turbo:load', () => {
  $('.account_info').each(function() {
    const userId = $(this).data('user-id');
    const accountElement = $(this);
  
    if (!window.commentHandlersBound) {
    window.commentHandlersBound = true;

// 画面遷移時に表示させる
    axios.get(`/accounts/${userId}.json`)
      .then((response) => {
        const hasFollowed = response.data.has_followed

        console.log('userId', userId);
        console.log('hasFollowed', hasFollowed);

        if (hasFollowed) {
          accountElement.find('.unfollow-btn').removeClass('hidden')
          accountElement.find('.follow-btn').addClass('hidden')
        } else {
          accountElement.find('.follow-btn').removeClass('hidden')
          accountElement.find('.unfollow-btn').addClass('hidden')
        }
      })

    $(this).find('.follow-btn').on('click', function(e){
      e.preventDefault();
      const accountElement = $(this).closest('.account_info');
      const userId = accountElement.data('user-id');

      axios.post(`/accounts/${userId}/follows`)
        .then((response) => {

          if (response.data.status === 'followed') {
            accountElement.find('.unfollow-btn').removeClass('hidden')
            accountElement.find('.follow-btn').addClass('hidden')
          }
        })
        .catch((e) => {
          window.alert('Error');
          console.log(e);
        });
    });

    $(this).find('.unfollow-btn').on('click', function(e)
    {
      e.preventDefault();
      const accountElement = $(this).closest('.account_info');
      const userId = accountElement.data('user-id');

      axios.post(`/accounts/${userId}/unfollows`)
        .then((response) => {
          if (response.data.status === 'unfollowed') {
            accountElement.find('.follow-btn').removeClass('hidden')
            accountElement.find('.unfollow-btn').addClass('hidden')
          }
        })
        .catch((e) => {
          window.alert('Error');
          console.log(e);
        });
    }); 
    }
    // この上の括弧を消す
  });
})