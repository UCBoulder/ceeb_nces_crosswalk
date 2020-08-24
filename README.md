# Using Mechanical Turk to Produce an NCES to CEEB Crosswalk

## Introduction
Merging two different data sets requires a unique key. There is a long standing problem in educational policy where analysis of two or more connected data sets would expand our understanding of a problem, yet no useful crosswalk exists. 

This project attempts to create a crosswalk between the National Center for Education Statistics (NCES) data and the CEEB codes utilized by national testing agencies including the ACT.

Other institutional researchers and scholars [1](https://ire.uncg.edu/research/NCES_CEEB_Table/)],[2](https://help.liaisonedu.com/WebAdMIT_Help_Center/Documents_and_Reference_Guides/Master_College_Code_List) have tackled this problem, often using fuzzy matching methods which are helpful, but incomolete.  This project attempts to provide a reproducible, open-source framework to solve this problem.

## Method

The [Office of Data Analytics](https://www.colorado.edu/oda/) at 
The [University of Colorado Boulder](https://www.colorado.edu) utlized three methods to create as complete of a file as was possible given existing data and our use case.

First, we looked for others who have done some or all of this work successfully. The most robust data set was created by Mark Davenport at the University of North Carolina - Greensboro. This set (known in the code as the "Davenport Set"), for our purposes was considered the "base". Our first pass was leaning on the Davenport set for any records that had already been matched.

Second, we used fuzzy matching techniques to join on the NCES Private and Public school data sets to the UCB CEEB codes that were _not_ in the Davenport set. The assumption was that there would be no similarly named high schools in the same city, state and zip code. 

The remaining cases were set up as jobs for workers using Amazon's [Mechanical Turk](https://www.mturk.com/). Workers were asked to conduct individual Google searches on the remaining names and to input correct data whenever possible. Our strategy was to "cover" each request with 3-4 workers, so any discrepancies could be averaged for accuracy. 

The final file, which is included here, contains 21,592 matched secondary schools in the United States with both CEEB codes and NCES ids. 

## Contents

This repo contains all of the raw data files including 

* NCES Public and Private School data for 2017-2018
* The 'Davenport' data set generously provided by Mark Davenport at the University of North Carolina-Greensboro
* Listing of high schools from which University of Colorado Boulder has received applications intended to be the full universe of matches for our purposes
* And, of course, the master crosswalk found here: 

oda_nces_ceeb_crosswalk.csv

We have also included the code so others may reproduce or improve upon it.

## Team

Danielle Lyles
Peter Shaffery
Ulises Guzman Sol
Seth Spielman
Brad Weiner

## Terms of Use

Pull requests and data additions are welcome. Please feel free to 
use these data or this strategy on your own campus. When using this file or work for analysis, please cite the following DOI

## License

## Code of Conduct






