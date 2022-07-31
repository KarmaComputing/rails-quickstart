# Rails Quickstart for container hosting

Ref https://github.com/KarmaComputing/container-hosting


## Create a new controller


> Note, use `docker-compose exec app /usr/src/app/app/bin/rails`
  not `bin/rails generate`. This is because you want to run the command inside
  your container, not on your host. This means you don't need ruby installed on 
  your local laptop, which means no version mismatch issues! 

This is based on the [official Ruby guide](See https://guides.rubyonrails.org/getting_started.html#say-hello-rails).

```
docker-compose exec app /usr/src/app/app/bin/rails generate controller Articles index --skip-routes
```

## Generate a model (database table)

[Official guide](https://guides.rubyonrails.org/getting_started.html#mvc-and-you-generating-a-model)

```
docker-compose exec app /usr/src/app/app/bin/rails generate model Article title:string body:text
```

Expected output:
```
(main)$ docker-compose exec app /usr/src/app/app/bin/rails generate model Article title:string body:text
      invoke  active_record
      create    db/migrate/20220731172200_create_articles.rb
      create    app/models/article.rb
      invoke    test_unit
      create      test/models/article_test.rb
      create      test/fixtures/articles.yml
```

Correct permissions:
```
sudo chown -R $USER:$USER app/*
```

## Run the database migration(s)

```
docker-compose exec -w /usr/src/app/app app /usr/src/app/app/bin/rails db:migrate
```

Expected output:
```
== 20220731172200 CreateArticles: migrating ===================================
-- create_table(:articles)
   -> 0.0296s
== 20220731172200 CreateArticles: migrated (0.0297s) ==========================
```

## Enter the rails console

```
docker-compose exec -w /usr/src/app/app app /usr/src/app/app/bin/rails console
```

Expected output:

```
Loading development environment (Rails 7.0.3.1)
irb(main):001:0>
```

## Create/Insert an article

```
irb> article = Article.new(title: "Hello Rails", body: "I am on Rails!")
```

Expected output:

```
irb(main):002:0> article.save
  TRANSACTION (0.2ms)  begin transaction
  Article Create (0.9ms)  INSERT INTO "articles" ("title", "body", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["title", "Hello Rails"], ["body", "I am on Rails!"], ["created_at", "2022-07-31 19:02:48.402426"], ["updated_at", "2022-07-31 19:02:48.402426"]]                                                          
  TRANSACTION (9.8ms)  commit transaction                       
=> true                                                         
irb(main):003:0>
```

You can also do:

```
irb(main):007:0> Article.find(1)
```

```
irb(main):007:0> Article.all()
```

## Display all articles in the template (templates)

[Official docs](https://guides.rubyonrails.org/getting_started.html#showing-a-list-of-articles)

In your file: `app/controllers/articles_controller.rb`:

```
class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end
end
```

In your file: app/views/articles/index.html.erb

```
<h1>Articles</h1>

<ul>
  <% @articles.each do |article| %>
    <li>
      <%= article.title %>
    </li>
  <% end %>
</ul>
```
