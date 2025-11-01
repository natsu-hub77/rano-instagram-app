import $ from 'jquery'
import axios from 'modules/axios'
import { 
  loadFollow, 
  submitFollowRequest,
  submitUnfollowRequest
} from 'modules/handle_follow'

document.addEventListener('turbo:load', () => {
  const accountElement = $('.account_info');
  const userId = accountElement.data('user-id');

  if (userId) {
    loadFollow(userId, accountElement)
  }
});

  if (!window.followHandlerAttached) { // すでに登録済みならスキップ
  window.followHandlerAttached = true;

  // フォロー
  $(document).on('click', '.follow-btn', function(e) {
    e.preventDefault();

    const userId = $('.account_info').data('user-id'); 
    const accountElement = $('.account_info');

    submitFollowRequest(userId, accountElement)
  });

  // アンフォロー
  $(document).on('click', '.unfollow-btn', function(e) {
    e.preventDefault();

    const userId = $('.account_info').data('user-id');
    const accountElement = $('.account_info');

    submitUnfollowRequest(userId, accountElement)
  }); 
}
