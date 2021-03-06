# Handling old `Panel` objects

This repository contains a series of old `Panel` objects generated by previous versions of **iSEE**.
It also provides a number of tests to check that the current version of **iSEE** can gracefully handle these old objects.
This involves protecting the getters/setters for new/deprecated slots and providing appropriate `updateObject()` methods.

These tests are periodically executed in the **iSEE** container via the GitHub Action in this repository.
To execute the tests manually, simply run:

```r
source("testthat.R")
```

New tests should be added to `tests/` whenever the class definition changes.
(It may also be appropriate to update existing tests rather than creating a new file, depending on the manner of the change.)
Old objects with the previous class definition should be added to `objects/`.
