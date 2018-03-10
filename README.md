> :warning: _this project is no longer actively maintaned_ :warning:

DCID
====

*propose . discuss . decide*

Live demo at [dcid.herokuapp.com](http://dcid.herokuapp.com//)

- **License**: The author [Diogo Nunes](http://github.com/dialex) releases this software under the [GNU GPL 3](http://www.gnu.org/licenses/gpl.txt).
- **Development plan**: This project is managed using a [Trello board](https://trello.com/b/36itFGvs/dcid).

### Set up

- Create the file `/config/application.yml` as a copy of the existing `application.yml.example`. Fill out the variables according to your deployment.


### Release notes

#### 0.1.2

- Sort proposals by different criteria

#### 0.1.1

- Show proposals even when you aren't logged in

#### 0.1.0

- Migrated look to bootstrap 3 (still some issues on flash[:alert] and size of form buttons)

#### 0.0.7

- Moved all configrations and passwords into a single configuration file

#### 0.0.6
- Added basic tagging system using `acts-as-taggable-on` gem (tags separated by commas, auto-hypheneted, tags index page, tags link to page showing proposals with that tag)
- Citizen numbers with minimum of 7 digits
- Tweaks here and there

#### 0.0.5

- Vote on proposals, using `thumbs_up` gem
- Design tweaks: tooltip on BI/CC, a switch button to toogle public name
- Users can choose to make their name hidden
- Users can choose a political party , that's displayed next to their name
- Users can comment using facebook comments plugin

#### 0.0.4

- Proposals: show, list, paginate, create, delete, (no edit though)

#### 0.0.3

- Static pages: how it works
- Design: responsive bootstrap
- User: list, paginate, profile edit, public profile, admin permissions
- Authentication: sign up, in and out
- Data model: User
