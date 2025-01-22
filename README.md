# README

## setup

1. Clone the repository.
2. Create a `.env` file.
3. Add the following env variables to your `.env` file with the correct information:
```
  DB_HOST=xxxxxx.xxxxx.xxx
  DB_USERNAME=xxxxxxx
  DB_PASSWORD=xxxxxxx
  DB_DATABASE=xxxxxx 
```
4. Install dependencies with `bundle install`.

**NOTE:** Ruby and Posgresql should be installed and running correctly.

## server
To run the API server locally, run `bin/rails server` in the terminal.

**NOTE:** The cache duration is set for 1 hour, but can be changed.

## job
To run the sales report job directly run `bin/rails runner "SendSalesReportJob.perform_now"`.

**NOTE:** 
- The jobs are configured to be run locally without installing Redis or anything else.
- The email and name for the reports email is hardcoded as there is no specification on that.
- The from field for the emails is generic and should be changed.
- The "every morning" part of the tasks is handled differently for each platform (which is outside the scope of this repository).

## tests
To run the API endpoints automated tests, run: `bin/rails test -v`.
