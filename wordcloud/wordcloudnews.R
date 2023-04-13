#By Brando Huaman www.linkedin.com/in/brandohuaman
#Install required packages
install.packages("tm")
install.packages("wordcloud")
install.packages("quantmod")

#Load required libraries
library(tm)
library(wordcloud)
library(quantmod)
library(httr)
library(jsonlite)

# declaring url
url = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=6b34b617e1104d35b03856e658b7be61"

# making http request and storing it in 
# news variable
news = GET(url)

# converting raw data to character
data = rawToChar(news$content)

# converting character to json format
jsondata = fromJSON(data)

# printing news title
print(jsondata$articles$title)
noticias<-jsondata$articles$title

# combine all news into a single text
noticias_texto <- paste(noticias, collapse = " ")

# create a Corpus object with the text
noticias_corpus <- Corpus(VectorSource(noticias_texto))

# remove stop words like 'the' and 'a
noticias_corpus <- tm_map(noticias_corpus, removeWords, stopwords("english"))

# remove punctuation
noticias_corpus <- tm_map(noticias_corpus, removePunctuation)

# convert all text to lowercase
noticias_corpus <- tm_map(noticias_corpus, content_transformer(tolower))

# create the Word Cloud
set.seed(123)
wordcloud(noticias_corpus, max.words = 500, min.freq = 1, random.order = FALSE,
          rot.per=0.35, colors=RColorBrewer::brewer.pal(8,"YlGnBu")
          )






