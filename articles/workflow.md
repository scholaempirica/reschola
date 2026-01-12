# The Workflow

This vignette describes the ideal data analytical workflow used by the
Schola Empirica team.

## Objective

#### 

To do analysis and create great reports reproducibly and efficiently.

To make our lives easier.

To make life easier for our future selves.

## Principles

### 1. Reproducible projects

Project structure should be such that it is obvious what happens where
and the whole project can be rerun quickly, perhaps on new data.
Ideally, the structure also facilitates efficiency, i.e. during analysis
things are not rerun which only need to be done once etc.

### 2. Reproducible reports

Everything we submit to a client/partner/stakeholder should be based on
data and code that together reproducibly create the report: no hacks, no
manual edits if at all possible, no copy-pasting images from one place
to another.

Version control helps us track when each report was created, using what
code and what data, and can help us go back and fix things if needed. It
also helps us avoid mostly duplicate versions of everything lying
around.

> Code and data are real.

### 3. Consistent style of outputs

Reports and charts are based on well-designed styles and templates which
we use consistently.

### 3. Good documentation

Projects and reports should be self-documenting by their structure,
code, workflow, and comments inside, and the git history with good
commit messages.

### 4. Efficiency

Let’s not repeat code and keep reinventing the wheel.

## Building blocks

#### On reproducibility frameworks

The workflow described here does not rely on a particular framework that
would enforce a project structure and a way of orchestrating all the
bits together.

It is more lightweight - it suggests a structure, a way of working, and
provides suggested integrators (such as `build.R` and `shared.R` and the
`00_` data load scripts). It relies on simple order of execution and on
the analyst putting the right bits of code in the right places.

You are free to change any of this, but also responsible for making sure
that the system you create actually works.

This lightweight approach also does not provide any optimalisation with
regard to build time, like a `make`- or `drake`-based workflow would
(e.g. by only rebuilding outputs when te code has changed.)

If you would like a more rigid framework or need one that optimizes for
computing time, look through your options in the
[Resources](#resources-for-building-reproducible-workflows) section
below.

### 1. Project initiation via the project template

The `reschola` package provides an RStudio project template that (a)
takes care of setting up your project on Github (if you let it) and (b)
creates a default project structure, incorporating key parameters that
you give it in setup.

### 2. Default project structure

Feel free to adapt this in any way that works and remains understandable
to someone who is not you.

- `shared.R` for variables and perhaps functions shared by more scripts.
  By default contains GDrive URL and project title, if provided during
  setup
- `001_retrieve-data.R` helps you download files from your GDrive
  folder, if set. You can also use it to store code for retrieving other
  data. This should only hold things which you expect to only run once,
  or refresh rarely - particularly things that take time or put a load
  on other servers.
- `002_read-data.R` should hold code that reads the data and does any
  transformations immediately tied to data reading, e.g. setting data
  types or basic filtering. Again, this is code that you don’t expect to
  change as you work on the actual analysis. You may want to save the
  result into `rds` files in `data-intermediate` (or `data-input` if it
  is simply an `rds` mirror of the input data saved for quick access.)
- `003_check-and-process-data.R` (if you plan to run it often, you may
  wish signal this by numbering it `01_*` to rerun it often with the
  rest of the analysis, and you may also turn it into an Rmd file if
  that is more convenient.) This should process data in `data-input` and
  save its outputs in `data-processed`.
- `[NN]_*.Rmd` where NN is 01-98 is the actual analysis - may be an
  exploratory script, a partial analysis, or a report. Expected to be
  run in the order of their numbering, but ideally key components should
  work off data saved in `data-input` or `data-intermediate`.
- `data-input` should contain only unaltered input data as downloaded.
- `data-processed` should contain processed data files
- `data-output` should contain data that you expect to share externally
  that are the output of your project
- `charts-output` and `reports-output` for the obvious
- `99_reproducibility.R` by default contains a description of the system
  and environment used to run the analysis. Use it to store any other
  information useful for reproducing the analysis (but not passwords
  etc.)

You should feel free to move code between the analysis and the `00*`
scripts as you discover data transformations that should be made earlier
on in the workflow.

Use `build.R` to tie these together - when run, it should rebuild the
whole project from scratch, except perhaps downloading data. You may
want to build different versions of `build_*.R` as helpers for running
different parts of the workflow while you work. If you deal with lots of
build scripts, use the wonderful (pun intended)
[{buildr}](https://netique.github.io/buildr/) package.

### 3. Document templates

There are two templates in the package: Schola PDF report (prefered) and
Schola Word report.

The PDF report use LaTeX to create typographically correct, completely
vector-graphics document.

The Word report is simple: it creates a Word document with some nice
custom defaults and styles.

### 4. ggplot2 theme

`reschola` offers a ggplot2 theme,
[`theme_schola()`](https://scholaempirica.github.io/reschola/reference/theme_schola.md),
which provides some sensible easthetic defaults, including font choice,
to make charts beautiful and consistent.

The desired approach is to use this theme, alter its parameters if
needed, and then if necessary make other changes using another
[`theme()`](https://ggplot2.tidyverse.org/reference/theme.html) call.

There are also a small number of other plotting utilities.

See the [Making
charts](https://scholaempirica.github.io/reschola/articles/charts.md)
vignette for details on everything graphics related.

### 5. Utilities

There are also utilities, e.g. for creating report drafts (`draft_*()`)
and for interacting with Google Drive (`gdrive_*()`)

## Step by step

### 1. Start a new project

In RStudio, go to
`File > New Project > New directory > Standard Schola Empirica Project`.

> Ideally, start from a clean RStudio session with no project open.

Fill in the fields (only directory name is mandatory), switch the Git
menu to get a (reschola/your) Github repo of you wish, select other
options if needed, check “Open in new session”, and click `Create`.

Other ways are possible but this gives you a good starting point and
takes care of a lot of the setup hassle for you.

##### Not committing sensitive data to git

The `data-input` and `data-processed` have `.gitignore` files in to stop
you form committing sensitive data to git. Commit these `.gitignore`
files to git. But only alter them if you are sure you know what you are
doing.

#### Google Authentication

If you haven’t used the `googledrive` package before, the package may
ask for authorisation to access Google Drive. This is legitimate and you
should grant access. This happens in the browser and on some machines
may cause project initiatition to freeze or stop. If that happens, run
[`googledrive::drive_auth()`](https://googledrive.tidyverse.org/reference/drive_auth.html),
delete the directory created by the previous project creation attempt,
and try creating the project again.

#### `renv`: managing package dependencies

One of the most annoying barriers do reproducibility is when packages on
which your code depends change over time and as a result your code
breaks or behaves differently.

The most convenient and sophisticated way to handle this is to use the
`renv` dependency management system. `renv`

In short, it makes sure that your project holds a complete record of the
exact package versions you are using when creating it.

When to use it:

Always, really, but especaially when:

- you start collaborating on a project with someone else
- you are putting a project aside for a while
- you want it to run on a remote machine, e.g. to build and publish a
  website through Travis CI or Github Actions

What it does:

- creates a project-specific library
- installs the packages on which your code depends into it
- records the exact versions of these packages in something called a
  lockfile - a small text file that you keep and commit into git
  alongside your code
- sets up the project such that the project library is rebuilt with the
  minimum amount of hassle when you open it up in the future or someone
  else clones it.

To save avoid wasting time, disk space and download bandwidth, `renv`
keeps a copy of all the package versions used in your projects in a
shared per-computer cache. The project libraries only contain links to
that cache. That way you are not committing the package code into your
project, nor do the package files sit in your project directory, and
they only get downloaded once if multiple projects’ libraries use the
save version of a package.

All you need to do is call `renv::init()` at the beginning and then
`renv::snapshot()` anytime you install new packages or commit code.

See <https://rstudio.github.io/renv/> for an intro to the package and
<https://environments.rstudio.com/> for a broader intro.

Renv is not part of the standard project setup in `reschola` so as not
to increase the complexity of project initiation, but it is much
recommended that you use it.

### 2. Download the data

Use `001_retrieve-data.R`; if you have other data retrieval, ideally the
code for it should live here.

Do not edit the data by hand.

See [tips](https://scholaempirica.github.io/reschola/articles/tips.md)
for some packages that can help you retrieve data from public sources or
other systems.

### 3. Read in, check and process the data

Use `002_read-data.R`. Add any other data reading that is needed.

See
[`readr::locale()`](https://readr.tidyverse.org/reference/locale.html)
for handling encoding, decimal marks and separators in CSVs. You might
also need
[`readr::read_csv2()`](https://readr.tidyverse.org/reference/read_delim.html).

Use
[`readr::guess_encoding()`](https://readr.tidyverse.org/reference/encoding.html)
if the text comes in garbled.

Use `003_check-and-process-data.R`. You may need to move this into an
RMarkdown document.

See [tips](https://scholaempirica.github.io/reschola/articles/tips.md)
for packages that can help you set up a structured data checking
pipeline.

#### Data and git

You may want to commit some of the summarised/processed data output here
once you have done some analysis and are reasonably sure it will not
change too often. But generally, data should not be committed, esp. if
large or at risk of committing personal information.

### 4. Explore/Analyse the data

I suggest you keep your data exploration in a separate script from your
report; often the EDA will happen in the report as you go, but a better
process perhaps is to develop bits of your analysis in one script/Rmd
and only move bits of code into the report Rmd which is essential for
building the report.

An RMarkdown Notebook might be an appropriate format for this.

See
[tips.html#data-exploration-1](https://scholaempirica.github.io/reschola/articles/tips)
for a list of appropriate tools for data exploration.

#### Approaches

There is a real trade off here: one way to do it is to work through the
analysis in the report script, perhaps hiding most through chunk options
(`include = FALSE`) and only outputting into the final format stuff that
is relevant.

That way you get a sense of the thought process but also a bloated and
circuitous script. Another is to do the analysis in one or more files
and only moving bits into the report which are needed there.

That way you get a tight report script but at times disconnected from
the analytical process.

One way to lighten the load is to hive off some work into partial
Rmarkdown files, typically named `_something.Rmd`, and then “insert”
them into the main document via

```` markdown
```{r child=c('_one.Rmd', '_two.Rmd')}
```
````

\`\`\`

See RMarkdown Cookbook [on child
documents](https://bookdown.org/yihui/rmarkdown-cookbook/child-document.html).

### 5. Write reports using a template

Use `draft_*` to quickly create a draft using the required template.

The Word output of the two templates is aesthetically equivalent, but
the `_word` template (and output format as set in the YAML header) can
do more sophisticated handling of
e.g. [cross-references](#footnotes-and-cross-references).

Note the `schola_word` format is based on the
[`bookdown::word_document2`](https://pkgs.rstudio.com/bookdown/reference/html_document2.html)
format. This means it can be customised like [other bookdown
documents](https://bookdown.org/yihui/bookdown/) and even strung into a
whole book.

#### Footnotes and cross-references

You can create a cross-reference to any section, e.g. link to section
Methods using `[Methods]` or `[the methods section][Methods]`. This will
show up as a link in Word and HTML.

Create a footnote by using `Text^[This is a footnote]`.

You can also refer to tables, figures and equations. This only works in
the `schola_word` output format (template).

Do it like this (note that `@` is escaped with `\`):

- `See table \@ref(fig:graf6).` to ref to a table in a chunk named
  `graf6`
- `As table \@ref(tab:tab3) shows...` for a table in a chunk named
  `tab3`

Note that these chunks need to have the `fig.cap` set to a non-empty
string, and they need to have a chunk name **without underscores or any
special character** (camelCase style is recommended). Yihui Xie
[says](https://yihui.org/knitr/options/):

> Try to avoid spaces, periods (.), and underscores (\_) in chunk labels
> and paths. If you need separators, you are recommended to use hyphens
> (-) instead. For example, setup-options is a good label, whereas
> setup.options and chunk 1 are bad; fig.path = ‘figures/mcmc-’ is a
> good path for figure output, and fig.path = ‘markov chain/monte carlo’
> is bad.

Edit `_bookdown.yml` to change the words used for “Figure” and “Table”
in captions (doesn’t apply for PDF).

See more on cross-references [in the bookdown
guide](https://bookdown.org/yihui/bookdown/cross-references.html).

#### Citations

Knitr and Rmarkdown incorporate a system for managing citations and
bibliographies, which can take reference lists from a number of citation
managers. For the basics, see the [RMarkdown
site](https://rmarkdown.rstudio.com/authoring_bibliographies_and_citations.html),
details are in the [RMarkdown
Cookbook](https://bookdown.org/yihui/rmarkdown-cookbook/bibliography.html).

#### Web output

In principle, if you want a HTML file you can just switch the format to
`html_document` and it should work fine if perhaps the details might
differ slightly. See
[tips](https://scholaempirica.github.io/reschola/articles/tips.md) on
how to get that online.

#### Parameterising

If you expect your report to be rerun in some time with different data
or a different parameter, like a changed date or name of something, you
can make your report parameterised. See this [brief
guide](https://rmarkdown.rstudio.com/lesson-6.html) or a [longer
explanation](https://bookdown.org/yihui/rmarkdown/parameterized-reports.html).

This is also useful if you are running the same report for a number of
units of something, e.g. for different waves of research or different
geographical units - see [how the Urban Institute does
it](https://medium.com/@urban_institute/iterated-fact-sheets-with-r-markdown-d685eb4eafce).

#### Visualising

Charts should be created using `ggplot2` as far as possible. Use the
`schola_theme()` theme.[¹](#fn1)

### 6. Iterate steps 3-6

None of this is a linear process. The only requirement is that from an
external point of view (and that includes you in three months or two
years), the process of rebuilding the report(s) and the entire project
is linear.

But as you work, you will find bits of code that belong somewhere else;
you will make data transformations in your report that you will then
realize you can move to your data transformation script. You will load
new data in a script and than move that loading code to an earlier
script. That is fine - it will happen gradually through iteration, but
the iteration should also move you towards more organised code.

The logic described by Emily Riederer in her [RMarkdown driven
development](https://emilyriederer.netlify.com/post/rmarkdown-driven-development/)
approach may be helpful here.

In the end, the scripts should follow these principes:

1.  each should be able to run separately, in the sense that it doesn’t
    fail, that is
2.  it reads its own data (possibly written by a previous script)
3.  it should write its data if another script is expected to use them
    (though ideally this would all be done by a data-transformation
    script early on)
4.  it should load its libraries, shared variable and functions

Don’t forget to update the README.md and other documentation as you go,
as well as `build.R` and any other `build*.R` scripts you may have.

Feel free to use git to go back and forth. Version control is your
friend here. Something broke? You can go back to when it worked.

See
[workflow](https://scholaempirica.github.io/reschola/articles/workflow.md)
guidance for a primer on git and Github, which should be a core part of
your process.

When a draft report goes out e.g. to stakeholders for feedback, it might
be useful to create a [git
tag](https://happygitwithr.com/git-basics.html):

> You can also designate certain snapshots as special with a tag, which
> is a name of your choosing. In a software project, it is typical to
> tag a release with its version, e.g., “v1.0.3”. For a manuscript or
> analytical project, you might tag the version submitted to a journal
> or transmitted to external collaborators. Figure 20.1 shows a tag,
> “draft-01”, associated with the last commit.

### 7. Finalise report

Run
[`reschola::manage_docx_header_logos()`](https://scholaempirica.github.io/reschola/reference/manage_docx_header_logos.md)
to replace default Schola logo or add a client/funder logo.

### 8. Prepare project for reuse

Really just make sure that you have followed the steps. If you have,
then:

- files should be named properly and with the correct order
- each Rmd file should run without error
- `build.R` should contain all scripts needed to run the whole thing in
  the right order; so should any other built-type script you may have
  created
- README.md should contain workable instructions

Additionally, you should use `renv` and snapshot the state of the
project library using `renv::snapshot()`.

## Tools for implementing good practices

### Tidyverse approach and tidy data

See [R for Data Science](https://r4ds.had.co.nz/) by Hadley Wickham and
Garret Grolemund.

The rest mostly draws on [**W**hat **T**hey **F**orgot to teach you
about R](https://rstats.wtf), which seems to have the remedy to many
common pains of working with R.

### Blank slates

See RStudio part in
[setup](https://scholaempirica.github.io/reschola/articles/setup.md) for
the options to set for this.)

### Safe paths

Use the `here` package instead of
[`setwd()`](https://rdrr.io/r/base/getwd.html) to [make sure paths just
work](https://github.com/jennybc/here_here).

### File naming conventions

See [Naming things](https://speakerdeck.com/jennybc/how-to-name-files)
by Jenny Bryan.

- machine readable: ASCII, no spaces, sensible separators (`_` between
  parts, `-` between words)
- human readable: descriptive words in title, consistent logic across
  files
- plays well with default ordering: 01 x 11, sensible separators, all
  lowercase, YYYY-MM-DD dates

### Safe storage of secret and confidential information

- use .Renviron for passwords (or look at `keyring`), never hard code
  them
  ([`usethis::edit_r_environ()`](https://usethis.r-lib.org/reference/edit.html))
- store individual data on team GDrive and only download for analysis;
  do not commit to git

#### Ignore files in git

You can add files you do not wish to commit to git’s ‘.gitignore’ file.
That way, git will not even show those as new/changed. This works
separately for each repo.

The easiest way to do this is to run
e.g. `usethis::use_git_ignore("secret_file.R")`.

You need to commit the `.gitignore` file.

### Other bits of good practice to follow:

#### In R code:

- Document why you wrote that code (not necessarily just what it does,
  which should be obvious)
- don’t use T and F for TRUE and FALSE
- use only trustworthy packages, ideally CRAN-based unless there is a
  good reason to do otherwise.

See the [`goodpractice`](http://mangothecat.github.io/goodpractice/)
package for a list of good practice and automated checking for them.

#### With version control

- Write informative commit messages
- don’t overwrite history (force push) unless absolutely necessary
- commit often, push carefully
- pushed commits should contain complete changes such that the code will
  run without errors.
- always work in UTF-8: save code in RStudio as UTF-8, save input CSV as
  UTF-8, and save any R text output as UTF-8.

### Style

Currently we have no explicitly agreed style.

Still, following some basic code hygiene seems like a good idea:

- sensible indents
- lower_case_var_names
- functions are verbs, like do_something()
- spaces around operators like `=` and `+`
- break lines at around 80 characters

## Resources for building reproducible workflows

[Drake](https://github.com/ropensci/drake), [intro
slides](https://pkg.garrickadenbuie.com/drake-intro/#1)

[Sharla Gelfand](https://resources.rstudio.com/rstudio-conf-202) on
reproducible reporting with RMarkdown at rstudio::conf(2020) Emily
Riederer on [RMarkdown driven
development](https://emilyriederer.netlify.com/post/rmarkdown-driven-development/)

Wilson et al. 2016, [“Good Enough Practices in Scientific
Computing”](https://arxiv.org/abs/1609.00037)

[`rrtools`](https://github.com/benmarwick/rrtools) for research
compendia

[Reproducible Analytical
Pipelines](https://ukgovdatascience.github.io/rap-website/)

[Workflowr](https://jdblischak.github.io/workflowr/)

[orderly](https://vimc.github.io/orderly/)

------------------------------------------------------------------------

1.  See the [Making
    charts](https://scholaempirica.github.io/reschola/articles/charts.md)
    vignette for more details.
