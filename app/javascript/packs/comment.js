import axios from 'axios'
import $ from 'jquery'
import Rails from "@rails/ujs"

const appendAllComment = (comment) => {
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
}


document.addEventListener('turbo:load', () => {
  const dataset = $('#comment-index').data()
  if (!dataset) return
  const postId = dataset.postId

  axios.get(`/posts/${postId}/comments`, {
    headers: { Accept: "application/json" }
  })
    .then((response) => {
      const comments = response.data
      $('.comments-container').empty()

      comments.forEach((comment) => {
        appendAllComment(comment)
      })
    })
 
  if (!window.commentHandlersBound) {
    window.commentHandlersBound = true;

    $(document).on('click', '.comment-submit-btn', function(e){
      e.preventDefault();
      const content = $('#comment_content').val()
      if (!content) {
        window.alert('コメントを入力してください')
        return
      } 

        axios.post(`/posts/${postId}/comments`, {
          comment: {content: content}
        })
          .then((res) => {
            const comment = res.data
            appendAllComment(comment)
            $('#comment_content').val('')
          })
    })
  }
})

