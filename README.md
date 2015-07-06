# Noblis - myHealthAlerts
[myHealthAlerts](http://www.myhealthalerts18f.com/) is prototype application which allows users to view side effects of medications they may be using.  Monitoring side effects of prescription medications is both complex and extremely important due to the serious and potentially life threatening repercussions. That is why this prototype—and others like it—matter.  It is also why the federal government needs a team—like ours—that can deliver.

As a public interest nonprofit, <a href=http://www.noblis.org>Noblis</a> shares 18F’s values and culture—our focus is a “mission first” approach to problem-solving that is free from vendor allegiances, uses open-source solutions, and is transparent throughout project lifecycles.

Here is a day-by-day look at our process for bringing [myHealthAlerts](http://www.myhealthalerts18f.com/) into the world.

## June 17: Team Setup

Anxiously awaiting the release of this RFQ, we developed a budget, received prototype seed funding, assembled our [cross-functional team of Super Heroes](evidence/b_myHealthAlerts_Super_Heros.pdf), developed our [Team Charter](evidence/a_myHealthAlerts_Team_Charter.pdf), and selected Yasamin as our dedicated Product Owner.

## June 18: User Engagement and Product Vision
[With users as the central focus of all products we build](evidence/c_myHealthAlerts_Understanding_User_Needs.pdf), Yasamin and Kelly held a two-hour [light-weight Design Studio](evidence/d_myHealthAlerts_Design_Studio.pdf) with five users to define distinct user groups (to inform the creation of Peronas), understand their goals, and relate their goals to the available datasets on OpenFDA. They included the product development team in this Design Studio so they could hear the user needs articulated first-hand, an approach that helps to build empathy and shared understanding between the team and end-users. Kelly defined the rules of the Design Studio and, working with Yasamin, facilitated a brainstorming discussion.

Yasamin captured ideas on sticky-notes to serve as the initial product backlog and grouped these ideas based on the goals of specific user groups. With this input, Yasamin finalized the Product Vision and developed preliminary User Stories, while Kelly developed [User Personas](evidence/d_myHealthAlerts_Personas.pdf), hand-drawn mockups, a product name, logo, and [Style Guide](evidence/e_myHealthAlerts_Style_Guide.pdf) intended to convey a trustworthy and approachable image.

At the end of the Design Studio, Yasamin consolidated the discussion into Epics for tracking in Trello, while Kelly used her initial sketches to inform the development of wireframes. While user ideas far surpassed the prototype budget and schedule, we populated the backlog and Yasamin prioritized the most important items iteratively each day.

## June 19: Technical Setup
With a [robust development stack](evidence/i_myHealthAlerts_Open_Source_Tools.pdf) at its fingertips, the team selected GitHub as the provider for repository management, Jenkins for Continuous Integration (CI) / Continuous Delivery (CD), Docker as a container platform, and Amazon AWS IaaS provider for the deployment target of the application built on the Grails framework.  The combination of widely used, [FOSS technologies](evidence/i_myHealthAlerts_Open_Source_Tools.pdf) leads to efficiencies of effort, maximizes reuse (benefiting taxpayers), [eliminates licensing costs](evidence/q_myHealthAlerts_Licenses.pdf), and allows for outside contributors. Grails uses coding by convention to remove common configuration bottlenecks and accelerate rapid prototyping. [This infrastructure and selection of Bootstrap 3 HTML, CSS, and JS framework on the frontend plus jQuery](evidence/i_myHealthAlerts_Open_Source_Tools.pdf), allowed the team to build a [responsive, mobile-first web application](evidence/h_myHealthAlerts_Responsive_Design.pdf) while maintaining freedom from licensing restrictions.

In order to efficiently manage aspects of the deployment and development infrastructure, a combination of the GitHub hosted git repository and Puppet was leveraged to address various [configuration management](evidence/m_myHealthAlerts_Configuration_Management.pdf) needs.  This provided the ability to automatically verify the expected configurations were in place for specific development and deployment activities.  Beyond configuration management, [continuous monitoring](evidence/n_myHealthAlerts_Continuous_Monitoring.pdf) of the resources was put in place.  A combination of Puppet output and data from an internal Noblis monitoring tool similar to Munin provided real-time tracking of resource utilization, load, etc.

Finally, while not related to our dev stack tooling, to maximize transparency and encourage direct interaction between users and the team, our co-located team provided a view of our product backlog and an interactive version of the most recent prototype build, available at any time. Users visited the co-located development team multiples times per day to [iteratively review and refine](evidence/d_myHealthAlerts_Design_Progression.pdf) wireframes, interact with working prototypes, and provide feedback verbally and via “sticky notes” to be incorporated into our product backlog in [Trello](https://trello.com/b/gb1av8iH/gsa-18f-prototype).

## June 20-21: Weekend
Noblis respects the need for a [strong work-life balance](http://www.noblis.org/about/Awards-Recognition). We all enjoyed our weekends with our families.

## June 22-25: “Sprinting”
To employ Agile team ceremonies with a compressed prototype challenge timeline, we executed development work in four iterative “Sprints” following the same daily schedule:

* 9am: Sprint Planning – Product Owner presented highest priorities. Team committed to one Sprint of scope.
* 1pm: Daily Standup – Team communicated progress and blockers.
* 5pm: Sprint Review – Team demonstrated working prototype progress to users, [solicited user feedback](evidence/g_myHealthAlerts_User_Feedback_Summary.pdf), and used this feedback to inform [iterative prioritization in Trello](evidence/g_myHealthAlerts_Iterative_Approach.pdf).
* 5:30pm: Sprint Retrospective – Facilitated “1-to-10 pulse check” and discussion.
* 6pm: Day Ends – “Hands off” code to ensure quality development cycles.

[Employing best-practice CI/CD activities](evidence/l_myHealthAlerts_Continuous_Integration.pdf), each day the development team consisting of Jason, Evan, Sev, John, and Milosz would:

*	Begin work on the User Stories in the current "Sprint"
*	[Write unit tests](evidence/k_myHealthAlerts_Unit_Tests.pdf) to ensure enduring code quality
*	Frequently push changesets to the GitHub repository

Upon the repository receiving changesets, via the [myCabinetDev job](evidence/l_myHealthAlerts_Job_Config.xml), Jenkins would:

* Execute automated tests with the Grails framework
* Check for code style consistency with CodeNarc.
* Build and deploy the application to our [(XNICC) environment](evidence/j_myHealthAlerts_Prototype_Deployment_Provider.pdf) for testing

While Noblis typically employs various coding practices such as test driven development (TDD) and hybrid branching strategies with validated merging.  Given the size of the development team, and short development cycle, the team largely took a “develop the mainline” approach with respect to branching.  Additionally, understanding that TDD leads to lower maintenance costs in the long run, there is an upfront cost in terms of the pace of productivity.  As such we focused primarily on writing targeted unit tests covering critical functionality to maintain cost control while allowing for the successful deployment of a minimum viable product (MVP) to validate with end-users.

Noblis is experienced with maintaining multiple environments (dev, staging, production) typically associated with the Continuous Delivery (CD) aspect of software development.  In this instance, we elected to maintain development and production environments with Jenkins pushing each successful new build to production where the application would run within a host provided by our XNICC IaaS.  With each successful build, interactive testers could iteratively test newly available functionality, bug fixes, and system usability.  In order to have an up-to-date picture of security vulnerabilities and associated risks, the deployment target was periodically scanned with acunetix.  This generated detailed [web application security reports](evidence/n_myHealth_Alerts_Risk_Assessment_Security_Scans.pdf).

It is worth noting, that while we were initially planning on deploying the application to our XNICC IaaS environment, based on clarifications coming out the Q & A, we decided to deploy our application to AWS within a [Docker container](evidence/o_myHealthAlerts_Virtualization.pdf).  Based on this history, the vast majority of CI builds and deployment logs reflect the original setup.

#### Sprint Breakdown
| Sprint           | Completed Stories, Enhancements, & Bugs Fixed |
| -----------------| ------------------|
| 06.22.15 (1) | 4 Stories|
| 06.23.15 (2)  | 5 Stories|
| 06.24.15 (3) | 8 Stories|
| 06.25.15 (4) | 5 Stories, 10 Enhancements / Bugs|
| 06.26.15 (5) | 13 Enhancements / Bugs|
Additional details on the work completed can be found in [here](evidence/g_myHealthAlerts_Iterative_Approach.pdf).

On Development Day 4 (the final full development day) and Day 5 (the hardening and UI enhancement day), our team conducted [System Usability Surveys](evidence/f_myHealthAlerts_SUS_Survey_Results.pdf) based on the [Usability.gov System Usability Scale] (http://www.usability.gov/how-to-and-tools/methods/system-usability-scale.html) and [scoring approach popularized by Jeff Sauro] (http://www.measuringu.com/sus.php). Our baseline score of 77.69% (B) and final score of 80.42% (A) validated the changes made to improve the prototype's usability.

## June 26-July 6: Evidence Consolidation, Deployment Update, and Final Review
Although GSA extended the BPA response timeline, Noblis made a deliberate choice to maintain the agreed-upon prototype development budget and we completed development at 26th at noon.  A large amount of evidence was automatically generated by our CI pipeline and continuous monitoring tools.  That said, much of the evidence related to user centered design and usability required a good deal of consolidation.  We used the additional time to complete these consolidation activities to provide GSA’s 18F team with ample evidence demonstrating the process we followed to design, develop, and [deploy the working prototype](evidence/p_myHealthAlerts_install.md).  As previously mentioned, we also updated our deployment target and associated documentation in this time.


## July 7: Submittal
On the final day, we made our [myHealthAlerts prototype](http://www.myhealthalerts18f.com/), [repository](https://github.com/NoblisDemo/myCabinet), and [Trello board](https://trello.com/b/gb1av8iH/gsa-18f-prototype) public and submitted final details via eBuy.

## Evidence Inventory

* [Attachmet_E_Appr_Criteria_Evide_Template.xlsx](evidence/Attachmet_E_Appr_Criteria_Evide_Template.xlsx)
* [Digital_Services_Playbook_Checklist.xlsx](evidence/Digital_Services_Playbook_Checklist.xlsx)
* [a_myHealthAlerts_Team_Charter.pdf](evidence/a_myHealthAlerts_Team_Charter.pdf)
* [b_myHealthAlerts_Super_Heros.pdf](evidence/b_myHealthAlerts_Super_Heros.pdf)
* [b_myHealthAlerts_Team_Charter.pdf](evidence/b_myHealthAlerts_Team_Charter.pdf)
* [c_myHealthAlerts_Understanding_User_Needs.pdf](evidence/c_myHealthAlerts_Understanding_User_Needs.pdf)
* [d_myHealthAlerts_Design_Progression.pdf](evidence/d_myHealthAlerts_Design_Progression.pdf)
* [d_myHealthAlerts_Design_Studio.pdf](evidence/d_myHealthAlerts_Design_Studio.pdf)
* [d_myHealthAlerts_Personas.pdf](evidence/d_myHealthAlerts_Personas.pdf)
* [e_myHealthAlerts_Style_Guide.pdf](evidence/e_myHealthAlerts_Style_Guide.pdf)
* [f_myHealthAlerts_SUS_Survey_Results.pdf](evidence/f_myHealthAlerts_SUS_Survey_Results.pdf)
* [g_myHealthAlerts_Iterative_Approach.pdf](evidence/g_myHealthAlerts_Iterative_Approach.pdf)
* [g_myHealthAlerts_User_Feedback_Summary.pdf](evidence/g_myHealthAlerts_User_Feedback_Summary.pdf)
* [h_myHealthAlerts_Responsive_Design.pdf](evidence/h_myHealthAlerts_Responsive_Design.pdf)
* [i_myHealthAlerts_Open_Source_Tools.pdf](evidence/i_myHealthAlerts_Open_Source_Tools.pdf)
* [j_myHealthAlerts_Prototype_Deployment_Provider.pdf](evidence/j_myHealthAlerts_Prototype_Deployment_Provider.pdf)
* [k_myHealthAlerts_Unit_Tests.pdf](evidence/k_myHealthAlerts_Unit_Tests.pdf)
* [l_myHealthAlerts_Continuous_Integration.pdf](evidence/l_myHealthAlerts_Continuous_Integration.pdf)
* [l_myHealthAlerts_Job_Config.xml](evidence/l_myHealthAlerts_Job_Config.xml)
* [m_myHealthAlerts_Configuration_Management.pdf](evidence/m_myHealthAlerts_Configuration_Management.pdf)
* [n_myHealthAlerts_Continuous_Monitoring.pdf](evidence/n_myHealthAlerts_Continuous_Monitoring.pdf)
* [n_myHealth_Alerts_Risk_Assessment_Security_Scans.pdf](evidence/n_myHealth_Alerts_Risk_Assessment_Security_Scans.pdf)
* [o_myHealthAlerts_Virtualization.pdf](evidence/o_myHealthAlerts_Virtualization.pdf)
* [p_myHealthAlerts_Docker_File.txt](evidence/p_myHealthAlerts_Docker_File.txt)
* [p_myHealthAlerts_Docker_Install.sh](evidence/p_myHealthAlerts_Docker_Install.sh)
* [p_myHealthAlerts_install.md](evidence/p_myHealthAlerts_install.md)
* [q_myHealthAlerts_Licenses.pdf](evidence/q_myHealthAlerts_Licenses.pdf)
