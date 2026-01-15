# Make Date of Class `czech_date`

Appends the `czech_date` class attribute to the input object. Date of
class `czech_date` is printed as a date in long format with correct
Czech grammatical case (see Details and Grammatical cases section
below).

## Usage

``` r
as_czech_date(date, case = "genitive")
```

## Arguments

- date:

  *date or date-like object* to parse.

- case:

  *character*, either "nominative", "locative" or "genitive" (default)
  or any unambiguous abbreviation of these.

## Value

Same as input, but with class `czech_date` and attribute `gramm_case`.

## Details

The grammatical case *should* be specified as and argument to
[`print()`](https://rdrr.io/r/base/print.html) method, but for
convenience, you can predefine it in `as_czech_date` call directly. It
is then stored as an attribute, later grabbed by the `print` method.

Note that as opposed to other date formating functions in `R`,
`as_date_czech` trims leading zeros.

## Grammatical cases

Three grammatical cases are supported:

- *nominative* – native form, i.e. "leden" in Czech

- *locative* – "in ...", i.e. "v lednu" in Czech

- *genitive* – "the 'nth' of ...", i.e. "5. ledna" in Czech

Czech months listed by case are available in `.czech_months`.

## Examples

``` r
Sys.time() |> as_czech_date()
#> [1] "15. ledna 2026"

# in "nominative" grammatical case (note the abbreviation)
Sys.time() |> as_czech_date("nom")
#> [1] "15. leden 2026"
```
