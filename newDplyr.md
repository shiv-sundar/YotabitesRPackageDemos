`dplyr`: The Yotabites Demo
================
Shiv Sundar
June 5, 2018

Introduction
============

This tutorial was created to inform the user about every function provided by the `dplyr` package. Commonly used and simple functions will include a short use case and demo.

The pipe operator
-----------------

One of the most used tools provided by `dplyr` is the pipe (`%>%`) operator. We can use it to chain together multiple functions. It's kind of like saying: do this, **then** do this, **then** do this. We'll cover the use and syntax for it as we go.

Commonly used `dplyr` functions
-------------------------------

### Are these two data frames the same?

The `all_equal()` function is used to compare two data frames. One can use this function to check for equality without considering row order, column order, or both.

#### Usage

`all_equal(df1, df2, ignore_col_order = TRUE, ignore_row_order = TRUE, convert = FALSE, ...)`

#### Parameters

-   `df1`, `df2`: dataframes to compare.
-   `ignore_col_order`: should the ordering of columns be ignored?
-   `ignore_row_order`: should the ordering of rows be ignored?
-   `convert`: should the function attempt to coerce factors to characters and integers to doubles?
-   `...`: **not used**. required to comply with `all.equal()` usage.

#### Examples

Here we see what the data looks like.

``` r
head(worldCountries1)
```

    ##        Country Population Phones..per.1000.
    ## 18   Barbados      279912             481.9
    ## 112    Kuwait     2418393             211.0
    ## 201  Tanzania    37445392               4.0
    ## 121 Lithuania     3585906             223.4
    ## 225     Yemen    21456188              37.2
    ## 91   Honduras     7326496              67.5

``` r
head(worldCountriesMix)
```

    ##     Population Phones..per.1000.    Country
    ## 201   37445392               4.0  Tanzania 
    ## 116    3874050             255.6   Lebanon 
    ## 225   21456188              37.2     Yemen 
    ## 223    2460492             145.2 West Bank 
    ## 81       56361             448.9 Greenland 
    ## 64     4786994               7.9   Eritrea

Here we test different variations of the function.

``` r
all_equal(worldCountries1, worldCountriesMix)
```

    ## [1] TRUE

``` r
all_equal(worldCountries1, worldCountriesMix, TRUE, FALSE)
```

    ## [1] "Same row values, but different order"

``` r
all_equal(worldCountries1, worldCountriesMix, FALSE, FALSE)
```

    ## [1] "Same column names, but different order"

### I want to sort my data by a specified order!

Data can be sorted by using the `arrange()` function. It sorts using by using the natural order of the data type. Factors are normally sorted by alphabetical order. To order them differently, please use the `levels()` function.

#### Usage

`arrange(.data, ...)`

#### Parameters

-   `.data`: the dataframe to arrange
-   `...`: the columns to sort by

#### Examples

``` r
head(arrange(worldCountries1, Population))
```

    ##       Country Population Phones..per.1000.
    ## 1  Greenland       56361             448.9
    ## 2    Andorra       71201             497.2
    ## 3   Barbados      279912             481.9
    ## 4 Gaza Strip     1428757             244.3
    ## 5     Kuwait     2418393             211.0
    ## 6  West Bank     2460492             145.2

``` r
head(worldCountries1 %>%
  arrange(Phones..per.1000.))
```

    ##      Country Population Phones..per.1000.
    ## 1  Tanzania    37445392               4.0
    ## 2   Eritrea     4786994               7.9
    ## 3     Sudan    41236378              16.3
    ## 4     Yemen    21456188              37.2
    ## 5 Indonesia   245452739              52.0
    ## 6  Honduras     7326496              67.5

We just saw the first use of the pipe operator! In English, we took the data frame `worldCountries1`, **then** arranged its data by the values in the `Phones..per.1000.` column. We can accomplish this task without using the pipe operator as well.

``` r
head(arrange(worldCountries1, Phones..per.1000.))
```

    ##      Country Population Phones..per.1000.
    ## 1  Tanzania    37445392               4.0
    ## 2   Eritrea     4786994               7.9
    ## 3     Sudan    41236378              16.3
    ## 4     Yemen    21456188              37.2
    ## 5 Indonesia   245452739              52.0
    ## 6  Honduras     7326496              67.5

Functions provided by `dplyr` support both options that we just covered. It's up to your preference. However, in this demo we will use the pipe operator to familiarize you with its use.

### Which values in a vector fall between 10.4 and 73?

How can we answer this question? Well, `dplyr` actually provides us with a function called `between()`. That's convenient!

#### Usage

`between(vector, min, max)`

#### Parameters

-   `vector`: the values to check
-   `min`: the minimum value (inclusive)
-   `max`: the maximum value (inclusive)

#### Examples

``` r
newData <- sample_n(worldCountriesMix, 15)$Population
head(newData)
```

    ## [1] 41236378  2418393  7326496   279912  1428757    56361

``` r
newData%>%
  between(200000, 7500000)
```

    ##  [1] FALSE  TRUE  TRUE  TRUE  TRUE FALSE FALSE  TRUE FALSE  TRUE  TRUE
    ## [12]  TRUE FALSE FALSE  TRUE

### `arrange()`, but backwards!

`desc()` is a function that is pretty straightforward. It just sorts everything in reverse natural order.

#### Usage

`desc(vec)`

#### Parameters

-   `vec`: a vector to sort backwards

#### Examples

``` r
worldCountries1$Population %>%
  desc() %>%
  head
```

    ## [1]   -279912  -2418393 -37445392  -3585906 -21456188  -7326496

Datasets provided by `dplyr`
----------------------------

These datasets are bundled with the `dplyr` package for testing and manipulating.

-   `band_members`
-   `band_instruments`
-   `band_instruments2`
-   `nasa`
-   `starwars`
-   `storms`

Other functions not covered
---------------------------

all\_vars arrange\_all as.table.tbl\_cube as.tbl\_cube auto\_copy bind case\_when coalesce compute copy\_to cumall desc distinct do dr\_dplyr explain filter filter\_all funs groups group\_by group\_by\_all ident if\_else join join.tbl\_df lead-lag mutate n na\_if near nth n\_distinct order\_by pull ranking recode rowwise sample scoped select select\_all select\_vars setops slice sql src\_dbi summarise summarise\_all tally tbl tbl\_cube top\_n vars
