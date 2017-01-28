def review_to_wordlist( review, remove_stopwords=False ):
  review_text = BeautifulSoup(review).get_text()
  review_text = re.sub("[^azAZ.]","", review_text)
  document = []
  k = 0
  #handling negation
  words = review_text.split()
  for i in range(len(words)1):
    if words[i] in ["not", "didn't", "don't" ]:
        k = 3
    elif k > 0:
        document.append( 'NOT_' + words[i])
    else:
        document.append( words[i]
