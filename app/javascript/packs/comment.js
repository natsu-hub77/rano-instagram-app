import $ from 'jquery'
import axios from 'modules/axios'
import {
  loadComments,
  bindCommentSubmit 
} from 'modules/handle_comment'

document.addEventListener('turbo:load', () => {
  const dataset = $('#comment-index').data()
  if (!dataset) return

  const postId = dataset.postId
  const currentUserId = dataset.currentUserId

  loadComments(postId, currentUserId)
  bindCommentSubmit(postId, currentUserId)

})
