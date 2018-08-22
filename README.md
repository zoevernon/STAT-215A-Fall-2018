# STAT 215A, Fall 2018

This is the GitHub repository for STAT 215A, Fall 2018.

Thanks to Rebecca Barter and the past GSI's for this course for sharing their material with me. This document was originally written by Rebecca for STAT 215A in the Fall of 2017 and has been slightly modified.  

Questions and discussions between students can be posted on the forums in [piazza](https://piazza.com/class/jl2lok9zrup2nz). To sign up go to [piazza.com](piazza.com) and click on the "Students Get Started" button.  After selecting University of California, Berkeley you can find the course under "STAT 215A: Applied Statistics". This way everyone else can see your questions and the answers, so we can try to avoid answering the same questions over and over. Preferably you will answer each other's questions. It is our intention to only jump in when the question is one that only we can answer.

Also, note that the projects are to be done individually, so please think carefully before asking questions specifically about the projects. For example, questions concerning how to do something specific in R (e.g. "how do I convert a list of lists to a long-form data frame?") are fine, but questions asking what other people did for their analysis are not (e.g. "what are some findings that people have come across in the Redwood project?"). Questions asking about clarifications are fine.

If you have a more sensitive question that you'd rather your peers not see, of course you can feel free to email me at zoe_vernon@berkeley.edu, and/or email Bin at binyu@stat.berkeley.edu.



# Class times

**Lectures**:

Tuesdays & Thursdays, 11-12:30, Wheeler 204

**Labs**:

Fridays, 9-11, Evans 344

**Office Hours**:

*Bin*:  TBD

*Zoe*: TBD



# Useful resources

The following resources are excellent for both learning R and becoming a more advanced user.

- The [tidyverse website](http://www.tidyverse.org/). Much of what makes R powerful is the collection of packages developed by Hadley Wickham and the other lovely people over at RStudio encompassed in a the so-called "tidyverse". The tidyverse website provides a summary of all of its packages. The particularly useful ones will be `ggplot2` and `dplyr`.

- The ["Tidy Data"](https://www.jstatsoft.org/article/view/v059i10/v59i10.pdf) paper by Hadley Wickham will give you a feel for how to effectively mold in R your data for maximizing ease of usefulness. Note that the `reshape2` package is essentially obsolete and have been replaced by the `tidyr` package (part of the tidyverse). Specifically, the functions `melt` and `cast` have been replaced by the more intuitively named functions `gather` and `spread`, respectively.

We will also be using Git and GitHub a lot in this course. Here are some resources for figuring out what Git is and how to use it. 

- For information on installing Git and setting up GitHub see their [website](https://github.com/).

- Software Carpentry has a thorough [Git and GitHub tutorial](http://swcarpentry.github.io/git-novice/) available for free.

Finally, here are some resources that give instructions on how to be a good referee for academic papers.  Some of the information in these links is not relevant to the course itself as these reports will not be published and therefore you will not be asked to make a decision about whether or not to accept or reject the report.  However, being a good, thoughtful referee is an important skill to build, and these guides will provide a helpful way to start thinking about how to give appropriate and informative feedback to your peers. 

- A short document with bulleted advice on ["How to Referee a Research Paper"](https://people.csail.mit.edu/fredo/gifford-how-to-referee.pdf) by Dave Gifford

- A guide discussing ["How to Write a Referee Report"](http://web.uvic.ca/~mfarnham/phd_seminar/how_to_referee.pdf) by Martin Farnham
 
# The lab assignments

There will be 4-5 lab reports throughout the semester. These reports are a *big deal*. It is in completing these reports that the real learning happens. You will get to apply what you've learned in the lectures and labs to real datasets (with real issues). You will also learn to develop a narrative that reports your scientific findings as accurately and accessibly as possible: you will learn to tell a story with your analysis.

While you are allowed to discuss the projects with one another, each student must work on and hand in their own report. If your discussions with other students lead to ideas that you then use in your project you must give them credit.

The current tentative dates for the labs are as follows:

| Project title                  | Date released | Due date                | Peer review submission date |
|--------------------------------|---------------|-------------------------|----------------------------|
| Redwood trees                  | August 31  | September 14 (2 weeks)  | September 21               |
| Linguistic Survey              |   September 21 | October 5 (2 weeks)     | October 12               |
| Stability of Linguistic Survey | October 12   | October 19 (1 week)     | October 26                |
| Cloud detection (group project)| October 26   | November 9 (2 weeks)   |   November 16             |
| *Midterm*                      | November 13    |                         | No peer review        |
| fMRI (final project)           | November 16   | December 7 (3 weeks)    | (graded by Zoe)        |



## The reports

Each report will be up to 12 pages (.pdf format) and will contain (1) a description of the problem, (2) a description of the data, (3) a description of the data cleaning procedure, (4) a description of the analytic methods, (5) a description of your results, and (6) relevant visualizations in all five stages.
There is no predetermined structure of the report, and it is entirely free form. There are only a few real requirements:

1. No code is to appear in the final pdf report.

1. Your report must not exceed 12 pages.

1. You must make an effort to communicate effectively. Think as if you are writing a blog post or an informal journal article.

1. Favor simplicity over complexity. It is much more important to be thorough and to communicate effectively than to come up with some super fancy modeling idea that no one understands. If a super fancy is needed or justified, then feel free to go for it, just make sure to justify your choices in the report.

Keep in mind that there are two types of visualization: *exploratory* and *explanatory*. Exploratory visualizations are graphics that you produce to help *you* understand the data, whereas explanatory visualizations are final versions of a small subset of these figures that you produce to explain to *other people* what is in the data. Typically you will produce many, many exploratory plots and only a few key explanatory plots that answer specific questions. Choose your explanatory plots carefully, and ask the following question of every figure in your report: "Does this figure add anything? Is my story strictly worse when I remove it?" If the answer to either question is "no", then you should remove the figure. Just because you spent a lot of time making a really pretty figure, doesn't mean that it adds anything to your story. There have been many times in my life where I have spent an hour or two making a really awesome plot only to decide the next day that it is actually fairly irrelevant to my main points and removing it.

You will also be submitting your code, and you should write it nicely according to the Google Style Guide (https://google.github.io/styleguide/Rguide.xml).

## Setting up GitHub for this class

Your report and code will be submitted via GitHub. The following instructions will show you how to set up your GitHub account and configure a repository so that you can submit your assignments. This workflow is shamelessly copied (with slight modifications) from Chris Paciorek and Jarod Millman's setup from when I took their STAT243 class way back in 2014.

1. Install Git on your system (https://git-scm.com/book/en/v2/Getting-Started-Installing-Git).

1. Sign up for GitHub (https://github.com/).

1. Go to https://education.github.com/ and sign up for the student pack to get unlimited private repositories. You are a "student" and you want an "individual account".

Once you have completed these first steps, you are then ready to create your private GitHub repository for this class.

1. Locally on your machine, clone my stat-215-a repository: `git clone https://github.com/zoevernon/stat-215-a. This will create a copy of the repository on your own computer.

1. On the GitHub website, log in and create a **private** remote repository called *stat-215-a*. Add me (*zoevernon*) as a collaborator for this repository (check out settings on the repo website).

1. Back in the terminal, set the origin of your local repository to be the remote repository that you just made. Change USERNAME below to your username. This tells git which remote repository to push your changes to when you `git push` (`git remote set-url origin https://github.com/USERNAME/stat-215-a.git`).

1. Edit *info.txt* to reflect your own information.

```
name = "Jane Smith"
SID = "0123456789"
email = "jsmith@berkeley.edu"
github_name = "janesmith"
```

Now you're ready to push to your remote repository for the first time:

1. Check git status `git status`. You should see a bunch of text including `modified:   info.txt`.

1. Add (`git add info.txt`) and commit (`git commit -m “Updated info.txt with my own information”`) your edited *info.txt* file

1. Push your changes to your copy of the remote repository (`git push` or sometimes `git push remote origin`)

1. Check that info.txt has been updated in your remote github repository by navigating to https://github.com/USERNAME/stat-215-a (change USERNAME to your username)

## Submitting your projects

To submit your projects, you will need to create a subfolder in your local `stat-215-a` folder called `lab1` (if you are submitting lab 1). Inside this folder you should have the following (exact) structure:

```
lab1/
  homework.pdf
  lab1.Rmd
  lab1.pdf
  lab1_blind.Rmd
  lab1_blind.pdf
  R/
  extra/
```

- The source of your report (with code) will be contained in the `lab1.Rmd` file (`lab1.Rnw` is fine too).

- The compiled version of your report will be contained in `lab1.pdf`.

- You will also submit a "blind" version of each of these documents that does not include your name (`lab1_blind.Rmd` and `lab1_blind.pdf`).

- The `R/` folder will contain any extra R scripts needed to compile your report.

- The `homework.pdf` file will contain your completed homework. Please do not include any irrelevant files.

Note that GitHub cannot host files more than 100 MB. If you try to push a file larger than this, GitHub will cry. This means you should avoid pushing the data to your GitHub.  

When you are ready, you need to add, commit, and push the `lab1/` folder.

At the time when the lab is due, we will run a script that automatically pulls all of your assignments into my local versions of your `stat-215-a` repositories. Please make sure to submit your labs on time. We will spend some time in a lab having everyone submit a pretend assignment so that you are all clear on what to do.

## Peer-reviews

While you probably did a lot of really cool stuff in your own report, an excellent way to learn about other cool things is to see what other people did! This includes other exploratory and modeling ideas, neat R tricks, and issues with the data that you didn't notice or think of when you were doing your own analysis. So that you each have the opportunity to see a splattering of alternative approaches to the labs, we will be doing peer reviews.  Additionally, this will give you the opportunity to get feed back from multiple people.  

For each report (except for the final), you will each receive 2 reports from your peers to review. A detailed rubric will be provided and you will be expected to provide both written feedback on a variety of topics including communication, quality of data cleaning, relevance of visualizations, and reproducibility (can you easily re-compile their report).  

After you have all submitted your own assignments (and shortly after the deadline), I will run a script that will automatically push two randomly selected reports into a folder called `lab1_review/`. To retrieve your allocated reports, you will need to `git pull`. You will have one week to review these two reports and return your feedback in the form of a google questionnaire that I will send by email to you all.  


## Frequently asked questions

**Do I have to use R? Can I use Python instead?**

We strongly recommend using R for several reasons.

1. The ability to embed R code, text and LaTeX formulae in RStudio is excellent and makes reproducibility a breeze.

1. Since we are doing peer reviewing, which includes a code-review, it will be *so* much easier for everyone if we are all using the same language.

If you *really, really* want to use Python, please talk to me in person in the lab or during Office Hours (I will probably say no).


**Can I write my report using Jupyter Notebooks?**

No, sorry. One of the ways that we are ensuring that the reports are a reasonable length is to require a 12 page or less length limit. We also don't want to see any code in your final report.


**When should I start working on my lab?**

The labs, if done properly, will take you a long time. Ideally, you should be writing the report simultaneously with your analysis in order to avoid a last minute hacking together of all of your analyses. Do not leave starting the lab until the last minute. You should start as soon as you receive the lab and work on it a little bit every day (rather than in one massive chunk). If you can easily do an entire lab in less than a week, then you have missed a lot in the data cleaning process.
