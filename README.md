# Using Mechanical Turk to Produce an NCES to CEEB Crosswalk

## Introduction
Merging two different data sets requires a unique key. Unfortunately, there are often
situations when two or more related data sets exist, yet no useful crosswalk is available. 

This is a long-standing challenege in educational policy because performance and conditions at one level of education (Pre-K, K-12), might longitudinally explain performance in post-secondary institutions and beyond.

This project attempts to create a crosswalk between the National Center for Education Statistics (NCES) secondary school data the codes utilized by national post-secondary entrance examinations like the ACT and SAT. These codes, often referred to as "CEEB" codes, uniquely identify the secondary school in which a test-taking student is graduating.  

Other institutional researchers and scholars [1](https://ire.uncg.edu/research/NCES_CEEB_Table/),[2](https://help.liaisonedu.com/WebAdMIT_Help_Center/Documents_and_Reference_Guides/Master_College_Code_List) have tackled this problem, often using fuzzy matching methods which are helpful, but incomplete.  This project attempts to provide a reproducible, open-source framework to solve this problem.

## Method

The [Office of Data Analytics](https://www.colorado.edu/oda/) at 
The [University of Colorado Boulder](https://www.colorado.edu) utlized three methods to create as complete of a file that included all secondary schools that had recently submitted applications to our institution. 

First, we looked for others who have done some or all of this work successfully. To our knowledge, the best data set was created by Mark Davenport at the [University of North Carolina - Greensboro](https://ire.uncg.edu/). This set (known in the code as the "Davenport Set"), was considered the "base". Our first pass was leaning on the Davenport set for any records that had already been matched.

Second, we used fuzzy matching techniques to merge data from both the NCES Common Core of Data and the  NCES Private School Survey to any records _not_ in the Davenport Data Set. Matches were scored based on _school name_, _city_, _state_ and _zip code_. It was assumed that few, if any schools would share all four of those characteristics. 

The remaining cases were set up as jobs for workers using Amazon's [Mechanical Turk](https://www.mturk.com/). Mechanical Turk is a crowdsourcing website that allows for _requesters_ like CU Boulder, to hire _crowdworkers_ to assist with work that require human intervention. In our case, we wanted crowdworkers to manually search for high schools in the NCES database, and input the correct code whenever possible. To increase accuracy, we covered each request with 3-4 independent workers so that discrepancies could be sorted with a tie-breaking aggregation of the workers.

The final file, which is included here, contains 21,592 matched secondary schools in the United States with both CEEB codes and NCES IDS.

## Contents

This repo contains all of the raw data files including 

* [NCES Private School Survey data for 2017-2018](https://github.com/cu-boulder/ceeb_nces_crosswalk/blob/master/data/davenport_nces_ceeb_crosswalk.xlsx)
* The 'Davenport' [data set](https://github.com/cu-boulder/ceeb_nces_crosswalk/blob/master/data/davenport_nces_ceeb_crosswalk.xlsx) generously provided by Mark Davenport at the University of North Carolina-Greensboro
* [High schools](https://github.com/cu-boulder/ceeb_nces_crosswalk/blob/master/data/ucb_apps_hs.csv) from which The University of Colorado Boulder has received applications, intended to be the full universe of matches for our purposes
* A listing of [state codes](https://github.com/cu-boulder/ceeb_nces_crosswalk/blob/master/data/state_codes.csv) for matching

* The master crosswalk found [here](https://github.com/cu-boulder/ceeb_nces_crosswalk/blob/master/oda_nces_ceeb_crosswalk.csv):

https://github.com/cu-boulder/ceeb_nces_crosswalk/blob/master/oda_nces_ceeb_crosswalk.csv

We have also included the code so others may reproduce or improve upon it.

## Team

The team below are all affiliated with The Office of Data Analytics (ODA) at
The Universty of Colorado, Boulder.

The ODA mission is to foster an understanding of institutional knowledge. This is done by transforming data into actionable intelligence; aiding the decision making processes throughout the university.

Danielle Lyles - Data and Evaluation Scientist  
Peter Shaffery - Postdoctoral Research Assistant
Ulises Guzman Sol - Data Engineer  
Seth Spielman - Chief Data Officer   
Brad Weiner - Director of Data Science    

## Terms of Use

Pull requests and data additions are welcome. Please feel free to 
use these data or this strategy on your own campus.

## Code of Conduct

Contributors and users of this repository are asked to adhere to the University of Colorado
[code of conduct](https://www.cu.edu/ope/aps/2027) which is stated below.

The University of Colorado recognizes that people are the most important resource in accomplishing its mission. The University of Colorado values academic freedom, diversity, and respect for all persons. The university is committed to the principle of non-discrimination and does not tolerate harassment on any basis, including race, color, national origin, sex, pregnancy, age, disability, creed, religion, sexual orientation, gender identity, gender expression, veteran status, political affiliation, or political philosophy. Members of the university community are expected to treat colleagues, co-workers, and students with respect, professionalism, and dignity in all interactions and communications. 

[![CC BY-SA 4.0][cc-by-sa-shield]][cc-by-sa]

This work is licensed under a
[Creative Commons Attribution-ShareAlike 4.0 International License][cc-by-sa].

[![CC BY-SA 4.0][cc-by-sa-image]][cc-by-sa]

[cc-by-sa]: http://creativecommons.org/licenses/by-sa/4.0/
[cc-by-sa-image]: https://licensebuttons.net/l/by-sa/4.0/88x31.png
[cc-by-sa-shield]: https://img.shields.io/badge/License-CC%20BY--SA%204.0-lightgrey.svg






