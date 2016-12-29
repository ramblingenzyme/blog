---
title: 'The Tech Hammer. Or How I Learned to Love The Problem Solving'
---

# Introduction
As a computer science student, I not only noticed but am guilty of a tendency to want to throw software
or hardware at any number of problems.
At some point I noticed this "every problem is a nail" issue, particularly when discussing the shortcomings
of SOLS, the student dashboard system provided by my university. Specifically, the issue is when students
have to sign up for tutorials before the start of session.

# The percieved problem
As it stands, the system provides an opening date, and a first come, first serve approach.
The issue with this solution is that their systems buckle under the load of a large number of students
attempting to all sign up at the same time. This ends up leading to load times of around a minute, where
afterwards the tutorial you want to enrol in, is taken.

# The "solution"
In a conversation about this, a few of my friends were proposing tech fixes for an excess of students
trying to connect to SOLS all at once.

The solutions involved:
* Better load balancing
* Dedicated servers to handle enrolment requests for blocks of time
* Decoupling the frontend and implementing a backend with a queue of enrolment requests
* Moving static content to a CDN
* And a variety of other solutions

## Short comings of this approach
However, as this went on, I realised that these are all just stopgaps using technology to avoid addressing the real issue.

So why do these students want to all enrol at the same time?

Well, because there's an opening time posted and the system is first come, first serve. Need I say more?
So, you begin to wonder what the situation would look like if the system was based on preferences with a closing time, don't you?


# Potential solutions
:

* Fallacy of people involved in the tech industry to use software/hardware as a hammer
* Alternatives, solving for the user, rather than for the vendor
* Can you solve your problem with psychology?
