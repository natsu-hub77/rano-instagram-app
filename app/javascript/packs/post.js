import axios from 'axios'
import $ from 'jquery'
import Rails from "@rails/ujs"
import {
  listenInactiveHeartEvent,
  listenActiveHeartEvent
} from 'modules/handle_heart'

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

    // ハート表示制御
    axios.get(`/posts/${postId}/like`).then((response) => {
      handleHeartDisplay(postElement, response.data.hasLiked);
    });

    listenInactiveHeartEvent(postElement, postId)
    listenActiveHeartEvent(postElement, postId)

  });
});