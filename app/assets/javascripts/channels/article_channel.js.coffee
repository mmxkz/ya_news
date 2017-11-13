App.article = App.cable.subscriptions.create 'ArticleChannel',
  received: (article) ->
    document.getElementById('Article').innerHTML = article.article
