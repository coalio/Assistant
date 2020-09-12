<div align="center">
  <img src="https://github.com/coalio/Assistant/blob/master/docs/repo/assistant-brand-l.png">
</div>

-----------------

[![Last Commit](https://img.shields.io/github/last-commit/coalio/assistant)](https://github.com/coalio/Assistant/commits/master)
[![Only Lua](https://img.shields.io/badge/lua-100%25-blue)](https://github.com/coalio/Assistant/search?l=lua)

## What is Assistant?

Assistant is a data science library in continuous development

Assistant aspires to provide the tools required for real-world data management,
because Lua also deserves a nice data science and data analysis library.

*I'm currently the only maintainer of this project*, but I would love your contributions
and I'm currently looking for help.

So far the library it's getting at least one commit weekly, but we can improve this to **two** if you help to build Assistant

## Currently implemented

1. Label naming, be it strings, numbers, or a combination of both
2. Column sorting by labels
3. Printing your dataframe in the form of a spreadsheet within your console
4. Smart indexing functions
5. Metamethods to make the code as simple as possible

## What Assistant should support next

1. Data analysis functions
2. head: returns x amount of values from the head of the series
3. tail: returns x amount of values from the tail of the series
4. filter: returns all the series, except values that do not meet the condition
5. getNils: returns all the pairs of data (row, columns) in which X is nil
6. Complete data inserting functions ( such as appending columns and rows )
7. Memoize
8. Importing and exporting data to different file formats
9. Pass metadata of the dataframe for any returned objects
10. Find bugs and fix them

## Contributions

I would love your contributions to Assistant, and I wouldn't like to un-inspire you from contributing,
but to make the code easier to maintain in the long term, there's a <a href="https://github.com/coalio/Assistant/blob/master/conventions.txt">conventions.txt</a> file
  
These conventions are not very restricting, as long as it works there's no need to use a special method for it

## Usage

I provided some examples in docs/testing, I'll try to provide a full documentation for the first stable release
