# Blueface
Group Project - README Template
===

# GreekConnect

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
An app for students in the greek life community on campus to interact. Some examples are hosting exchanges with other groups or inviting other groups to philanthropic or fundraising events. Will have a common feed to post events on.

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category:** Social
- **Mobile:** Mobile app only with a first-hand experience
- **Story:** Allows users in frats or sororities to host an event and invite other users to the event. 
- **Market:** Students in Greek Life
- **Habit:** Users are able to see events that certain fraternities are hosting and invitations that they have recieved. App should be used every week minimum.
- **Scope:** College campuses across the nation

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**


* [x] User is able to log in with their organization, email, name, and password
* [x] Side out menu to navigate to events and users profile 
* [x] login persistence and logging out of database works, and creating the organized databases for each page
* [x] designs and logos and launch screen created
* Members will be able to send invites to other organizations as a whole, which will result in a push notification for everyone in the other organization
* Members will have the option to RSVP to events they have been invited to, as well as post events to a common feed.

**Optional Nice-to-have Stories**

* User chat
* Home pages for each group
* Personalized feed for each member with the events they are interested in attending

### 2. Screen Archetypes

* Login Screen
   * User can login
   * User can hit on a sign up screen
* Sign-up screen
   * User can create a new account 
   * User can register personal information and current fraternity or sorority
* Feed
   * User can view a feed of events being hosted
* Host
   * Frat/Sorority can host an event/invite

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* [fill out your first tab]
* [fill out your second tab]
* [fill out your third tab]

**Flow Navigation** (Screen to Screen)

* Login Screen
   * Home
* Sign-up Screen
   * Home
* Feed
   * None
* Host
   * Home 

## Wireframes
<img src="https://i.postimg.cc/DwxtzYSM/IMG-7706.jpg" width=600>

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

#### Current Working Demo
##### Milestone 1
<img src="http://g.recordit.co/xmCAdcQyTa.gif" width='' height='' alt='Video Walkthrough' />

##### Milestone 2
<img src="http://g.recordit.co/KFqiONUA1Z.gif" width='' height='' alt='Video Walkthrough' />

## Schema 
[This section will be completed in Unit 9]
### Models

#### User
| Property | Type | Description |
| -------- | ---- | ----------- |
| objectId | String | unique id for the user |
| organization | String | name of the fraternity or sorority the user is in |
| userInfo | String | basic information about the user |
| members | String | list of members in the same organization |

#### Post
| Property | Type | Description |
| -------- | ---- | ----------- |
| objectId | String | unique id for the user post (default field) |
| author | Pointer to User | image author |
| image | File | image of the event flyer that the user posts |
| event | String | caption of what the event is that the user is hosting |
| commentsCount | Number | number of comments that are posted to the event |
| goingCount | Number | number of people going to the event |
| interestedCount | Number | number of people interested of going to the event |
| notGoingCount | Number | number of people that are not going to the event |
| createdAt | DateTime | date when post was created (default field) |
| updatedAt | DateTime | date when post was last updated (default field) |

#### Comments
| Property | Type | Description |
| -------- | ---- | ----------- 
| objectId | String | unique id for the user post (default field) |
| author | Pointer to User | image author |
| comment | String | comment left by another user |


### Networking
- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]

* Home Feed Screen
   * (Read/GET) Query all posts where user is author and posts from the same organiztion
   * (Create/POST) Create a new going/interested/maybe on a post for an event
   * (Delete) Delete existing going/interested/maybe by changing option
   * (Create/POST) Create a new comment on a post
   * (Delete) Delete existing comment
* Create Post/Event Screen
   * (Create/POST) Create a new post object for posts and events
* Profile Screen
   * (Read/GET) Query logged in user object
   * (Update/PUT) Update user profile image with organization image
