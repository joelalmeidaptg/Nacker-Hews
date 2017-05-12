# Nacker-Hews
A Hacker News clone for my application for an internship position at Faber Ventures.

I have never done any kind of projet with any of the tools required for this project and although I have some experience with PHP and Python, I decided that since I was going to take some time with this project I might as well learn something new, in this case the Ruby language and the Ruby on Rails plattform. Please do take into account that being my first time meddling with the language, my knowledge is limited to what I learned in the past four days from writting this documment.

That being said, I also have lots of workload at the university and because of that I decided to use as much existing modules that already exist as I could to save time.

## Software used
For this project I used the following tools:
- Ruby 2.4.0
- Ruby on rails 5.0.1
- MySQL 5.7.18
- bundler 1.14.6
- The following ruby gems:
- - simple_form
- - bootstrap-sass
- - devise
- - acts_as_votable
- - will_paginate
- - commontator

## Setup
You can follow [this tutorial](https://gorails.com/setup/ubuntu/16.04) to install Ruby/Bundler/RoR in Ubuntu 16.04.

First, configure the `config/database.yml` file with your database info in:

```ruby
default: &default
  adapter: mysql2
  encoding: utf8
  pool: 5
  username: root
  password: 
  socket: /var/run/mysqld/mysqld.sock
```

Then, create a new database called `nacker-hews_development`:

```sql
create database `nacker-hews_development`
```

In the project root folder, run these commands to install all the gems and setup the database:

```console
$ bundle install
$ rake db:migrate
```
If you run into a mysql error while doing `bundle install`, make sure `libmysqlclient-dev` is installed in your system.

Start the server with:

```console
$ rails server
```

You can now open the website in `http://localhost:3000`. If you want to create an administrator, it can be done in `http://localhost:3000/admins/sign_in`

### Setting up email server
If you want the server to be able to send emails (for the token with password recovery), you need to edit the file `config/environments/development.rb` and change the values at `config.action_mailer.smtp_settings`:

```ruby
config.action_mailer.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => 'nacker-hews.com',
  :user_name            => YOUR_ADDRESS,
  :password             => YOUR_PASSWORD,
  :authentication       => 'plain',
  :enable_starttls_auto => true
}
```
If you plan to use GMail as your email server, please make sure the account you use doesn't have 2-step verification and it [allows less secure apps](https://www.google.com/settings/security/lesssecureapps) to access it.
Note: the fields YOUR_ADDRESS and YOUR_PASSOWRD are originally setup with an ENV variable. This did not work for me (even after setting it in the system) and I had to insert the data directly into the file.

## Details about development
I only developed the project in the `development` environment. Building it in `production` would require extra setup that I belive is past the point of this project.
Another note, I didn't care about CSS (I'm not very experienced with it anyway) and just left the style of the tutorial you provided me to start working.

- see the top 30 articles out of the box
The homepage shows the latest posts with the most upvotes (separated by days), which means posts with lots of upvotes wont clutter the homepage forever. `will_paginate` takes care of the paging, showing numbers in the bottom of the page when there are more than 30 posts in the database.

- register form (require: e-mail, username and a password)
This is working fully as intended. Users can login with either their username or email after being registered and can change their password/email at will. This is done thanks to the `devise` gem.

- password recovery
Recovery is working by sending an email to the user with a tokened link so the password can be reset in the main website. Check the setup in order to have the email functionality working.

- allow register users to submit articles
Users can send any article with a title and a link.

- allow users comments on a article
`commontator`added to every post, allowing post comments. Any user can edit or delete their own comment. Gravatar avatars are shown for users.

- allow users to up vote and down vote articles
This was archieved with `acts_as_votable` to allow users to upvote and downvote posts. The down and up interactions appear for unregistered users, forwarding them to the login/register page, and users which already voted up/down will have the according button disappear.

- for extra points have a backoffice
Admins can be created in `admins/sign_in` and this page should have its registration disabled (I left it for testing purposes). Admins cannot create posts or upvote/downvote.

- show number of comments per article
To show the number of comments in an article I created a custom MySQL query that is run every time I am showing an article. This is VERY inefficient and probably will cause the servers to be overloaded if lots of users are browsing through the homepage. The best solution to this problem would be creating something like the cached fields implemented in `acts_as_votable` but due to time limitations and the fact that this was an extra, I decided to leave it like this. Also, I didn't quite understand if this was meant to only be available for admins but since it made more sence to show it to everyone I made it this way. It can ve easily changed to admins only with two lines of code.

- allow to hide a article
Users can choose to delete their own posts, and admins can delete any post. Admins will also be able to see deleted posts in the homepage or with the post url.

- build a share link feature that creates a unique "short" link for each article
I did not implement this feature. It would require to get an interface with an existing URL shortener and use it to create a share feature.

- show the up and down votes on each article per user
I did not quite understood what this meant. Was it meant to create a page for a user to see their own posts, along with their up and down votes, or did it only meant to show them in the homepage? Anyway, the homepage shows the score of the post, but changing it to show the upvotes and downvotes is an easy task.
