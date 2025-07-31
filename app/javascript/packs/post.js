import axios from 'axios'
import $ from 'jquery'
import Rails from "@rails/ujs"

axios.defaults.headers.common['X-CSRF-Token'] = Rails.csrfToken()

const handleHeartDisplay = (postElement, hasLiked) => {
  if (hasLiked) {
  $(postElement).find('.active-heart-button').removeClass('hidden');
} else {
  $(postElement).find('.inactive-heart-button').removeClass('hidden');
}
}

document.addEventListener('turbo:load', () => {
  $('.post-actions').each(function() {
    const postId = $(this).data('post-id');
    const postElement = $(this);

    axios.get(`/posts/${postId}/like`)
      .then((response) => {
        const hasLiked = response.data.hasLiked
        handleHeartDisplay(postElement, hasLiked);
      });
  });

  $('.post-actions').each(function() {
    const postId = $(this).data('post-id');
    const postElement = $(this);
    
    $(this).find('.inactive-heart-button').on('click', function(e) {
      e.preventDefault();

      axios.post(`/posts/${postId}/like`)
        .then((response) => {
          if (response.data.status === 'ok') {
            postElement.find('.active-heart-button').removeClass('hidden')
            postElement.find('.inactive-heart-button').addClass('hidden')
          } 
        }) 
        .catch((e) => {
          window.alert('Error');
          console.log(e);
        });
    });
  });

  $('.post-actions').each(function() {
    const postId = $(this).data('post-id');
    const postElement = $(this);
  
    $(this).find('.active-heart-button').on('click', function(e) {
      e.preventDefault();

      axios.delete(`/posts/${postId}/like`)
        .then((response) => {
          if (response.data.status === 'ok') {
            postElement.find('.active-heart-button').addClass('hidden')
            postElement.find('.inactive-heart-button').removeClass('hidden')
          } 
        })
        .catch((e) => {
          window.alert('Error');
          console.log(e);
        });
      });
    });
});