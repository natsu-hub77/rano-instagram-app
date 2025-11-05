import $ from 'jquery'
import axios from 'modules/axios'
import { appendAllComment} from 'modules/append_comment'

const loadComments = (postId, currentUserId) => {
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
}

const bindCommentSubmit = (postId, currentUserId) => {
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
}

export {
  loadComments,
  bindCommentSubmit
}
