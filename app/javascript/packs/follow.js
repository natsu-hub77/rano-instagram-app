import $ from 'jquery'
import axios from 'modules/axios'

document.addEventListener('turbo:load', () => {
  const accountElement = $('.account_info');
  const userId = accountElement.data('user-id');

  if (userId) {
    // 初期表示処理
    axios.get(`/accounts/${userId}.json`)
      .then((response) => {
        const hasFollowed = response.data.has_followed;
        const FollowCount = response.data.FollowCount;

        if (hasFollowed) {
          accountElement.find('.unfollow-btn').removeClass('hidden');
          accountElement.find('.follow-btn').addClass('hidden');
        } else {
          accountElement.find('.follow-btn').removeClass('hidden');
          accountElement.find('.unfollow-btn').addClass('hidden');
        }

        $('.stat-follower-number').text(FollowCount);
      });
  }
});

  if (!window.followHandlerAttached) { // すでに登録済みならスキップ
  window.followHandlerAttached = true;

  // フォロー
  $(document).on('click', '.follow-btn', function(e) {
    e.preventDefault();

    const userId = $('.account_info').data('user-id'); 
    const accountElement = $('.account_info');

    axios.post(`/accounts/${userId}/follows`)
      .then((response) => {
        const FollowCount = response.data.followCount;
        if (response.data.status === 'followed') {
          accountElement.find('.unfollow-btn').removeClass('hidden');
          accountElement.find('.follow-btn').addClass('hidden');
          $('.stat-follower-number').text(FollowCount);
        }
      });
  });

  // アンフォロー
  $(document).on('click', '.unfollow-btn', function(e) {
    e.preventDefault();

    const userId = $('.account_info').data('user-id');
    const accountElement = $('.account_info');

    axios.post(`/accounts/${userId}/unfollows`)
      .then((response) => {
        const FollowCount = response.data.followCount;
        if (response.data.status === 'unfollowed') {
          accountElement.find('.follow-btn').removeClass('hidden');
          accountElement.find('.unfollow-btn').addClass('hidden');
          $('.stat-follower-number').text(FollowCount);
        }
      });
  }); 
}
