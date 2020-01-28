
1. lightgbmのインストール
git clone --recursive https://github.com/microsoft/LightGBM
cd LightGBM
Rscript build_r.R

2.実行ファイルを実行

ライブラリは以下

R packages available

Packages in library ‘/usr/local/lib/R/3.6/site-library’:

askpass                 Safe Password Entry for R, Git, and SSH
assertthat              Easy Pre and Post Assertions
backports               Reimplementations of Functions Introduced Since
                        R-3.0.0
base64enc               Tools for base64 encoding
BH                      Boost C++ Header Files
brew                    Templating Framework for Report Generation
callr                   Call R from R
cli                     Helpers for Developing Command Line Interfaces
clipr                   Read and Write from the System Clipboard
clisymbols              Unicode Symbols at the R Prompt
colorspace              A Toolbox for Manipulating and Assessing Colors
                        and Palettes
commonmark              High Performance CommonMark and Github Markdown
                        Rendering in R
covr                    Test Coverage for Packages
crayon                  Colored Terminal Output
crosstalk               Inter-Widget Interactivity for HTML Widgets
curl                    A Modern and Flexible Web Client for R
data.table              Extension of `data.frame`
desc                    Manipulate DESCRIPTION Files
devtools                Tools to Make Developing R Packages Easier
digest                  Create Compact Hash Digests of R Objects
DT                      A Wrapper of the JavaScript Library
                        'DataTables'
ellipsis                Tools for Working with ...
evaluate                Parsing and Evaluation Tools that Provide More
                        Details than the Default
fansi                   ANSI Control Sequence Aware String Functions
farver                  High Performance Colour Space Manipulation
fastmap                 Fast Implementation of a Key-Value Store
fs                      Cross-Platform File System Operations Based on
                        'libuv'
ggplot2                 Create Elegant Data Visualisations Using the
                        Grammar of Graphics
gh                      'GitHub' 'API'
git2r                   Provides Access to Git Repositories
glue                    Interpreted String Literals
gtable                  Arrange 'Grobs' in Tables
htmltools               Tools for HTML
htmlwidgets             HTML Widgets for R
httpuv                  HTTP and WebSocket Server Library
httr                    Tools for Working with URLs and HTTP
ini                     Read and Write '.ini' Files
IRdisplay               'Jupyter' Display Machinery
IRkernel                Native R Kernel for the 'Jupyter Notebook'
jsonlite                A Robust, High Performance JSON Parser and
                        Generator for R
labeling                Axis Labeling
later                   Utilities for Scheduling Functions to Execute
                        Later with Event Loops
lazyeval                Lazy (Non-Standard) Evaluation
lifecycle               Manage the Life Cycle of your Package Functions
lightgbm                Light Gradient Boosting Machine
magrittr                A Forward-Pipe Operator for R
memoise                 Memoisation of Functions
mime                    Map Filenames to MIME Types
munsell                 Utilities for Using Munsell Colours
openssl                 Toolkit for Encryption, Signatures and
                        Certificates Based on OpenSSL
pbdZMQ                  Programming with Big Data -- Interface to
                        'ZeroMQ'
pillar                  Coloured Formatting for Columns
pkgbuild                Find Tools Needed to Build R Packages
pkgconfig               Private Configuration for 'R' Packages
pkgload                 Simulate Package Installation and Attach
plyr                    Tools for Splitting, Applying and Combining
                        Data
praise                  Praise Users
prettyunits             Pretty, Human Readable Formatting of Quantities
processx                Execute and Control System Processes
promises                Abstractions for Promise-Based Asynchronous
                        Programming
ps                      List, Query, Manipulate System Processes
purrr                   Functional Programming Tools
R6                      Encapsulated Classes with Reference Semantics
rcmdcheck               Run 'R CMD check' from 'R' and Capture Results
RColorBrewer            ColorBrewer Palettes
Rcpp                    Seamless R and C++ Integration
remotes                 R Package Installation from Remote
                        Repositories, Including 'GitHub'
repr                    Serializable Representations
reshape2                Flexibly Reshape Data: A Reboot of the Reshape
                        Package
rex                     Friendly Regular Expressions
rlang                   Functions for Base Types and Core R and
                        'Tidyverse' Features
roxygen2                In-Line Documentation for R
rprojroot               Finding Files in Project Subdirectories
rstudioapi              Safely Access the RStudio API
rversions               Query 'R' Versions, Including 'r-release' and
                        'r-oldrel'
scales                  Scale Functions for Visualization
sessioninfo             R Session Information
shiny                   Web Application Framework for R
sourcetools             Tools for Reading, Tokenizing and Parsing R
                        Code
stringi                 Character String Processing Facilities
stringr                 Simple, Consistent Wrappers for Common String
                        Operations
sys                     Powerful and Reliable Tools for Running System
                        Commands in R
testthat                Unit Testing for R
tibble                  Simple Data Frames
usethis                 Automate Package and Project Setup
utf8                    Unicode Text Processing
uuid                    Tools for generating and handling of UUIDs
vctrs                   Vector Helpers
viridisLite             Default Color Maps from 'matplotlib' (Lite
                        Version)
whisker                 {{mustache}} for R, Logicless Templating
withr                   Run Code 'With' Temporarily Modified Global
                        State
xml2                    Parse XML
xopen                   Open System Files, 'URLs', Anything
xtable                  Export Tables to LaTeX or HTML
yaml                    Methods to Convert R Data to YAML and Back
zeallot                 Multiple, Unpacking, and Destructuring
                        Assignment

Packages in library ‘/usr/local/Cellar/r/3.6.2/lib/R/library’:

base                    The R Base Package
boot                    Bootstrap Functions (Originally by Angelo Canty
                        for S)
class                   Functions for Classification
cluster                 "Finding Groups in Data": Cluster Analysis
                        Extended Rousseeuw et al.
codetools               Code Analysis Tools for R
compiler                The R Compiler Package
datasets                The R Datasets Package
foreign                 Read Data Stored by 'Minitab', 'S', 'SAS',
                        'SPSS', 'Stata', 'Systat', 'Weka', 'dBase', ...
graphics                The R Graphics Package
grDevices               The R Graphics Devices and Support for Colours
                        and Fonts
grid                    The Grid Graphics Package
KernSmooth              Functions for Kernel Smoothing Supporting Wand
                        & Jones (1995)
lattice                 Trellis Graphics for R
MASS                    Support Functions and Datasets for Venables and
                        Ripley's MASS
Matrix                  Sparse and Dense Matrix Classes and Methods
methods                 Formal Methods and Classes
mgcv                    Mixed GAM Computation Vehicle with Automatic
                        Smoothness Estimation
nlme                    Linear and Nonlinear Mixed Effects Models
nnet                    Feed-Forward Neural Networks and Multinomial
                        Log-Linear Models
parallel                Support for Parallel computation in R
rpart                   Recursive Partitioning and Regression Trees
spatial                 Functions for Kriging and Point Pattern
                        Analysis
splines                 Regression Spline Functions and Classes
stats                   The R Stats Package
stats4                  Statistical Functions using S4 Classes
survival                Survival Analysis
tcltk                   Tcl/Tk Interface
tools                   Tools for Package Development
utils                   The R Utils Package
