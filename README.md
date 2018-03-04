# DV Odin Facebook

DV Odin Facebook is the final project in the OdinProject's curriculum on the Ruby on Rails framework.  It consists if 18 requirements along with 4 "extra credit."  A look at the development of each of the requirements is detailed below.

An honest effort was made to write comprehensive tests for the features implemented.

If you want to explore the application from a web browser, go to [https://fast-earth-56311.herokuapp.com/](https://fast-earth-56311.herokuapp.com/), then use one of the logins provided below.

```sh
Email: example@example.net
Password: password
```

```sh
Email: seeded@example.net
Password: password
```

## Requirements
The following is all the required features of the application, along with notes about how it was developed and implemented.


1. > Use Postgresql for your database from the beginning (not sqlite3), that way your deployment to Heroku will go much more smoothly. See the Heroku Docs for setup info.

Figuring out how to use Postgre instead of SQLite was surprisingly one of the more difficult parts of the exercise. The biggest issue was having to figure out that the database had to be initialize somehow by running 
```sh
sudo service postgresql start
```
 It seems like the command had to be entered every time changes were made to the database, after restarting.

2. > Users must sign in to see anything except the sign in page. 

This requirement actually made the project easier because logic didn't have to be written that separated the logged in pages from the logged out pages.

3. > User sign-in should use the Devise gem. Devise gives you all sorts of helpful methods so you no longer have to write your own user passwords, sessions, and #current_user methods. See the Railscast (which uses Rails 3) for a step-by-step introduction. The docs will be fully current.

The Devise gem made this exercise a lot easier, but it also took a lot of time to set up and to become comfortable with its features.  As part of the Odin curriculum, I built a fully functional authentication system from scratch using the Ruby on Rails Tutorial by Michael Hartl, so I developed an appreciation for how much more convenient it is to have sessions, password recovery, confirmation emails and more to be readily available.

The most difficult part of working with the Devise App was reading through the Docs and wrapping my head around some of the terminology and concepts.

4. > Users can send Friend Requests to other Users.

Unlike the  Hartl tutorial's Twitter clone, where relationships were one sided, this Facebook clone requires two sided relationships.  In other words, while the Twitter clone had separate tables for followed users and following users, the Facebook clone only keeps track of who is friend with whom.  However, it was still important to track who had sent the friend request and who had received the friend request as it becomes important later when implementing the "pending friends" feature.

A Relationship model was built to keep track of relationships. It contains two foreign keys, "requester_id" and "receiver_id", both of which keep track of User objects. 

5. > A User must accept the Friend Request to become friends.

A "confirmed_friends" boolean column was added to the Relationship model that kept track of whether two users were friends or not. It is defaulted to False. 

An index was also added to make sure that two users could not be friends if they were already friends.  Furthermore, if User-A requests for User-B to be friends, User-B cannot request for User-A to be friends anymore.

6. > The Friend Request shows up in the notifications section of a User’s navbar.

A link to the a "NEW FRIENDS!" page appears on the top of the nav bar when a user receives a friend request from another user.  The user can then go to the "pending friends" page and either confirm or ignore the friend request.  If a friendship is confirmed, the "confirmed_friends" column on the Relationships table is updated to "True".

7. > Users can create Posts (text only to start).

A Posts model belonging to a User was created that contains a content column.  Controllers and views were also created to be able to display the posts.

8. > Users can Like Posts.

Many different solutions were considered, but the one implemented was the creation of a Like model that kept track of who the user was and the Post being liked.  The table was modified later in order to turn the Like model polymorphic.

9. > Users can Comment on Posts.

Users could comment on posts, but like the Like model, the Comment model was modified to allow comments to be made on both Posts and Pictures.

10. > Posts should always display with the post content, author, comments and likes.

Posts content, author, comments, and likes are displayed on each post, as laid out in the Post views.

11. > Treat the Posts Index page like the real Facebook’s “Timeline” feature – show all the recent posts from the current user and users she is friends with.

The user timeline consists of both her own posts and her friends' posts, arranged in chronological order. Finding all the posts that met this criteria is done through a method inside the User model that looks for the posts through a SQL query.  

12. > Users can create a Profile with a Photo (just start by using the Gravatar image like you did in the Rails Tutorial).

Users were initially able to add profile pictures using Gravatar, but was later changed to being implemented by the Paperclip gem.

13. > The User Show page contains their Profile information, photo, and Posts.

User show pages contain all the information listed above.

14. > The Users Index page lists all users and buttons for sending Friend Requests to those who are not already friends or who don’t already have a pending request.

All users are listed in the User index.  Next to each name is a form button that will send a friend request to the other user.  If two users are already friends or are pending friends, an "unfriend" button will be displayed and the corresponding record in the Relationship table will be destroyed.

15. > Sign in should use Omniauth to allow a user to sign in with their real Facebook account. See the RailsCast on FB authentication with Devise for a step-by-step look at how it works.

Omniauth was not implemented due to Facebook wanting too much personal information during the registration process.  I do not have a Facebook account, and had to register a new one.  It allowed me to register one, but I was logged out several times, and the only way my account could be accessed was by providing increasingly invasive pieces of information.  

16. > Set up a mailer to send a welcome email when a new user signs up. Use the letter_opener gem (see docs here) to test it in development mode.

A mailer was generated that sends a welcome email after a user signs up.

17. > Deploy your App to Heroku.

The app was successfully deployed to Heroku and can be viewed [here](https://fast-earth-56311.herokuapp.com/).

18. > Set up the SendGrid add-on and start sending real emails. It’s free for low usage tiers.

An email is sent to new users when they sign up for an account in production.  This is accomplished using SendGrid.

#### "Extra Credit" Tasks

1. > Make posts also allow images (either just via a URL or, more complicated, by uploading one). 

Images can be uploaded as posts on the Post index page.

2. > Use the Paperclip gem to allow users to upload a photo to their profile.

The Paperclip gem is used to upload images as posts, and also to allow users to upload their own profile pictures.  If they haven't uploaded a profile picture, a default picture will be displayed.  

A separate Picture model, belonging to User was created.

3. > Make your post able to be either a text OR a photo by using a polymorphic association (so users can still like or comment on it while being none-the-wiser).

Posts and Pictures are displayed similarly in the post index and a user's show page.  Each post or picture is displayed with the author, number of likes, the comments, and forms that allow a user to like and comment on it.  Likes and Comments were made polymorphic and allowed them to be easily used for both Posts and Pictures.  If future models are created that need likes and comments, it can be easily implemented because most of these methods were written using metaprogramming with this in mind

One of the more challenging aspects of development was trying to find a way to have all of a user's posts and pictures displayed as one ActiveRecord object.  I was hoping to be able to simply display them using something like

```sh
<%= render @posts %>
```

However, I couldn't figure out how to do that, so based on the advice of someone on StackOverflow,  A Timeline table was created that recorded the user id and either picture id or post id every time either of those objects was created. 

Logic was added within the views that iterated through the Timeline object collection and displayed them.

4. > Style it up nicely! We’ll dive into HTML/CSS in the next course.

Right now, the app contains very rudimentary styling.  I hope to revisit this 
app once I progress further into the Odin Project curriculum and make it look nicer!