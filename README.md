# Readme

## Running
```
> docker-compose up --build
> docker-compose  run -d yanews rake db:create db:migrate
```

## Testing
```
> docker-compose exec yanews bundle exec rspec
```
