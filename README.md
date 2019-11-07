# Good Night

## General info

This is an application that lets users track when they go to bed and when they wake up.
In order to achieve the following:

1. Clock In operation, and return all clocked-in times, ordered by created time.
2. Users can follow and unfollow other users.
3. See the sleep records over the past week for their friends, ordered by the length of their sleep.


## API endpoints

We have 6 APIs endpoints as below:

No | Endpoint | Functionality
-- | -------- | -------------
1  | POST /api/v1/:user_id/sleep | To set the sleep time for a single user.
2  | POST /api/v1/:user_id/wake_up | To set the wake up time for a single user.
3  | POST /api/v1/:user_id/follow/:following_id | To let a specific user follow another user.
4  | DELETE /api/v1/:user_id/unfollow/:following_id | To let a specific user unfollow a single user that he is currently following.
5  | GET /api/v1/:user_id/clocked_ins | To get all the clocked-in times of a single user (sorted by created_at)
6  | GET /api/v1/:user_id/friends_records | To get all the sleeping records of a user's friends (sorted by sleep length)

## Tests

There are specs for models and API endpoints, using `rspec`, `factory_bot_rails`, `shoudlda-matchers`, `database_cleaner`

## Setup

* `bundle exec rake db:migate db:seed`

## Interface

There is a super simple web interface, which provides the ability to see a list of users and their actions.

Clicking on some actions (Sleep/Wake up) will disappear the links to prevent user to continue clicking them.

Refreshing the page, the results will be shown on the right column.

For `Friends records` action, please monitor it via the `Network` tab of Chrome inspector.

## Notes

- To keep it simple, there are only two fields on the users: "id" and "name”.
- There is no implementation for user registration API.
