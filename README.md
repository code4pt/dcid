DCID
====

*propose . discuss . decide*

Live demo at [www.dcid.org](http://www.dcid.org/)


- **License**: The author [Diogo Nunes](http://github.com/dialex) releases this software under the [GNU General Public License 3](http://www.gnu.org/licenses/gpl.txt).
- **Development plan**: This project is managed using a [Trello board](https://trello.com/b/36itFGvs/dcid).


### Release notes

#### 0.1.0

- Migrated look to bootstrap 3 (still some issues on flash[:alert] and size of form buttons)

#### 0.0.6
- Added basic tagging system using `acts-as-taggable-on` gem (tags separated by commas, auto-hypheneted, tags index page, tags link to page showing proposals with that tag)
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
