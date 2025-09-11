import axios from 'axios'
import $ from 'jquery'
import Rails from "@rails/ujs"

axios.defaults.headers.common['X-CSRF-Token'] = Rails.csrfToken()

document.addEventListener('turbo:load', () => {
  $('.account_info').each(function() {
    const userId = $(this).data('user-id');
    const accountElement = $(this);

    axios.get(`/accounts/${userId}`)
      .then((response) => {
        const hasFollowed = response.data.has_followed
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
  });
});