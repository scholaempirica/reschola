# Czech Date Internals

Function used by S3 methods for class `czech_date`.

## Usage

``` r
czech_date_main(date, case)
```

## Arguments

- date:

  *date or date-like object* to parse.

- case:

  *character*, either "nominative", "locative" or "genitive" (default)
  or any unambiguous abbreviation of these.

## Grammatical cases

Three grammatical cases are supported:

- *nominative* – native form, i.e. "leden" in Czech

- *locative* – "in ...", i.e. "v lednu" in Czech

- *genitive* – "the 'nth' of ...", i.e. "5. ledna" in Czech

Czech months listed by case are available in `.czech_months`.
