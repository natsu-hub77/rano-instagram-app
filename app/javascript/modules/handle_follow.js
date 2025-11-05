import $ from 'jquery'
import axios from 'modules/axios'

const loadFollow = (userId, accountElement) => {
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

const submitFollowRequest = (userId, accountElement) => {
  axios.post(`/accounts/${userId}/follows`)
      .then((response) => {
        const FollowCount = response.data.followCount;
        if (response.data.status === 'followed') {
          accountElement.find('.unfollow-btn').removeClass('hidden');
          accountElement.find('.follow-btn').addClass('hidden');
          $('.stat-follower-number').text(FollowCount);
        }
      });
}

const submitUnfollowRequest = (userId, accountElement) => {
  axios.post(`/accounts/${userId}/unfollows`)
  .then((response) => {
    const FollowCount = response.data.followCount;
    if (response.data.status === 'unfollowed') {
      accountElement.find('.follow-btn').removeClass('hidden');
      accountElement.find('.unfollow-btn').addClass('hidden');
      $('.stat-follower-number').text(FollowCount);
    }
  });
}

export {
  loadFollow,
  submitFollowRequest,
  submitUnfollowRequest
}