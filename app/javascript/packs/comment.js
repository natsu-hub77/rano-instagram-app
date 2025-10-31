import axios from 'axios'
import $ from 'jquery'
import Rails from "@rails/ujs"

const appendAllComment = (comment, currentUserId) => {
  const avatarUrl = comment.avatar_url || '/assets/avatar.svg'

  const profileLink =
    comment.user_id === currentUserId
      ? `/profile`
      : `/accounts/${comment.user_id}`

  const editLink =
    comment.user_id === currentUserId
      ? `/posts/${comment.post_id}/comments/${comment.id}/edit`
      : ''

  $('.comments-container').append(
    `     
      <div class="comment-post">
        <div class="comment-icon">
          <a href="${profileLink}">
            <img src="${avatarUrl}" alt="${comment.account_name}" />
          </a>
        </div>
        <div class="comment-body">
          <a href="${editLink}">
            <div class="comment-account-name">
              <p>${comment.account_name}</p>
            </div>
            <div class="comment-content">
              <p>${comment.content}</p>
            </div>
          </a>
        </div>
      </div>
    `
  )
}

document.addEventListener('turbo:load', () => {
  const dataset = $('#comment-index').data()
  if (!dataset) return

  const postId = dataset.postId
  const currentUserId = dataset.currentUserId

  axios.get(`/posts/${postId}/comments`, {
    headers: { Accept: "application/json" }
  })
    .then((response) => {
      const comments = response.data
      $('.comments-container').empty()

      comments.forEach((comment) => {
        appendAllComment(comment, currentUserId)
      })
    })
 
  if (!window.commentHandlersBound) {
    window.commentHandlersBound = true;

    $(document).on('click', '.comment-submit-btn', function(e){
      e.preventDefault();
      const content = $('#comment_content').val();

      if (!content) {
        window.alert('コメントを入力してください')
        return
      } 

      axios.post(`/posts/${postId}/comments`, {
        comment: {content: content}
      })
        .then((res) => {
          const comment = res.data
          appendAllComment(comment, currentUserId)
          $('#comment_content').val('')
        })
    })
  }
})
