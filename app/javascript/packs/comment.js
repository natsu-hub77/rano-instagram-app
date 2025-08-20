import axios from 'axios'
import $ from 'jquery'
import Rails from "@rails/ujs"

document.addEventListener('turbo:load', () => {
  const dataset = $('#comment-index').data()
  const postId = dataset.postId

  axios.get(`/posts/${postId}/comments`, {
    headers: { Accept: "application/json" }
  })
    .then((response) => {
      const comments = response.data
      $('.comments-container').empty()

      comments.forEach((comment) => {
        $('.comments-container').append(
        `     
        <div class="comment-post">
          <div class="comment-icon">
            <img src="${comment.avatar_url}" alt="${comment.account_name}" />
          </div>
          <div class="comment-body">
            <div class="comment-account-name">
              <p>${comment.account_name}</p>
            </div>
            <div class="comment-content">
              <p>${comment.content}</p>
            </div>
          </div>
        </div>
        `
        )
      })
    })
})
