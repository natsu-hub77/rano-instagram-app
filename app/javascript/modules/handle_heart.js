import axios from 'axios'
import $ from 'jquery'
import Rails from "@rails/ujs"

axios.defaults.headers.common['X-CSRF-Token'] = Rails.csrfToken()

function updateLikeMessage(postElement, data) {
  const likeMessage = $(postElement).find('.like-message');
  const count = data.like_count;
  const lastLiker = data.last_liker;

  if (count === 0) {
    likeMessage.text('No likes yet');
  } else if (count === 1) {
    likeMessage.text(`${lastLiker} liked your post`);
  } else {
    likeMessage.text(`${lastLiker} and ${count - 1} others liked your post`);
  }
}

const listenInactiveHeartEvent = (postElement, postId) => {
  postElement.find('.inactive-heart-button').on('click', (e) => {
  e.preventDefault();
  axios.post(`/posts/${postId}/like`).then((response) => {
    if (response.data.status === 'ok') {
      postElement.find('.active-heart-button').removeClass('hidden');
      postElement.find('.inactive-heart-button').addClass('hidden');
      
      const postWrapper = postElement.closest('.post_wrapper');
      updateLikeMessage(postWrapper.find('.post_content'), response.data);
    }
  });
});
}

const listenActiveHeartEvent = (postElement, postId) => {
  postElement.find('.active-heart-button').on('click', (e) => {
    e.preventDefault();
    axios.delete(`/posts/${postId}/like`).then((response) => {
      if (response.data.status === 'ok') {
        postElement.find('.active-heart-button').addClass('hidden');
        postElement.find('.inactive-heart-button').removeClass('hidden');

        const postWrapper = postElement.closest('.post_wrapper');
        updateLikeMessage(postWrapper.find('.post_content'), response.data);
      }
    });
  });
}

export {
  listenInactiveHeartEvent,
  listenActiveHeartEvent
}

