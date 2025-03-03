# Introduction

- How is this habit tracker application defined?  
It is an application to:
  1. (goal) enforce or simplify a new or existing routine,
  2. (motivation) in an effort to achieve personal accountability,
  3. (method) through external cognition via cognitive offloading.

- Who may be interested in using this application?  
Users seeking to achieve personal accountability, through the enforcement of a new or existing routine. Specifically:
  1. Users with new routines
  - Internally/externally motivated
  - Seeks to enforce personal accountability
  2. Users with existing routines
  - Internally motivated
  - Seeks to simplify efforts in personal accountability 

- What is the success metric for the application?  
When users transition from using the application as means of enforcement to means of simplification; the routine becomes internally motivated, thus becoming a habit.  


# Development Philosophy

This project's development takes inspiration from [The Lean Startup](https://theleanstartup.com/) (Eric Reis).

Thus, the MVP is designed to encompass a minimal problem scope, with the goal of validating critical business assumptions.


# Considerations in first MVP

The brief description provided in the [Introduction](#introduction) section provides an initial scope for the project. 

The assumptions to validate are:
1. User types - validate if true, or if there exist more types of users.
2. User type motivations - internally or externally motivated.
3. Assumed needs of user types - more details in the [Persona](#persona) section.

Therefore, the MVP is **not** the production-grade application. It is a prototype to verify, and realign the business context for this project.

# Persona - Features

This section describes how and why the selected features are proposed for the current MVP.

### 1. Users with new routines

Motivations:  
- Fear of an undesirable outcome, through the lack of commitment to a routine.
- Guilt from a lack of personal accountability.
- Non-relating perks (monetary incentives, achievements collection, etc).


#### Relevant themes and features

- Engaging
  - Daily streaks
  - Gamified experience - virtual currency
  - Intuitive UX
  - Intuitive UI
- Instructive
  - Notifications at time of check-in
    - Responses to notifications {check-in, snooze, cancel}
  - Clear instructions
- Accountable
  - Logs of missed check-ins
  - Logs of completed check-ins


### 2. Users with existing routines

Motivations:  
- Perceived increased of productivity through the usage of the application.
- Proof of personal accountability (streaks, achievements, etc).


#### Relevant themes and features

- Convenience
  - Intuitive UX
  - Intuitive UI
  - Notifications at time of check-in
    - Responses to notifications {check-in, snooze, cancel}
  - Clear instructions
- Informative
  - At-a-glance view
    - Summary of all habits
    - Summary of all actions
    - Percentages of check-ins completed per day
  - Graphical/visual representation of statistics for intuitive understandng
    - Completion/progress bar
- Showcasing
  - Daily streaks
  - Achievements
  - Logs of completed check-ins


### MVP consolidated feature list 

The themes discussed above can be abstracted to simplify the MVP's development. Based on the initial assumptions about the chosen target personas, the features are consolidated as such.

- UI
  - Shows added habit
  - Shows habit logging
  - Shows completion status per day
  - Visually intuitive representation of daily status
    - Progress bar per day
    - Statistics
- UX
  - Intuitive to add habit
  - Intuitive to remove habit
  - Intuitive to check-in for daily logging
  - Successful habit check-in returns compliments
  - Missed check-ins are logged, and reviewable


#### Feature list

1. Adding habit
2. Removing habit
3. Check-in habit, daily
4. Status of daily action 
