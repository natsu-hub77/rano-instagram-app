import $ from 'jquery'

export const appendAllComment = (comment, currentUserId) => {
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