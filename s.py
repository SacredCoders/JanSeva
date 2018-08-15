from nltk.tokenize import sent_tokenize, word_tokenize
from nltk.corpus import stopwords
from nltk.tokenize import RegexpTokenizer
import re
from string import punctuation
from nltk.probability import FreqDist
from heapq import nlargest
from collections import defaultdict
#from nltk.tokenize import sent_tokenize, word_tokenize

#f=open('py.txt','r')
#content=f.read()
def score_tokens(filterd_words, sentence_tokens):
    """
    Builds a frequency map based on the filtered list of words and 
    uses this to produce a map of each sentence and its total score
    """
    word_freq = FreqDist(filterd_words)

    ranking = defaultdict(int)

    for i, sentence in enumerate(sentence_tokens):
        for word in word_tokenize(sentence.lower()):
            if word in word_freq:
                ranking[i] += word_freq[word]

    return ranking

def summarize(ranks, sentences ,length):
	indexes = nlargest(4,ranks, key=ranks.get)
	final_sentences = [sentences[j] for j in sorted(indexes)]
	return ''.join(final_sentences)




with open("2.txt") as f:
    content="".join(line for line in f if not line.isspace())



content=content.strip()
content=content.rstrip()
#content=content.replace(' ','')
print(content)



sentence_tokens= sent_tokenize(content) 
print(sentence_tokens) 
#sentence_ranks = score_tokens(word_tokens, sentence_tokens)

print("\n")
content = content.lower()
tokenizer = RegexpTokenizer(r'\w+')
word_tokens = tokenizer.tokenize(content)
print(word_tokens)
filtered_words = [w for w in word_tokens if not w in stopwords.words('english')]
content=" ".join(filtered_words)
print(content)

'''with open('py.txt', 'r') as f:
    lines = f.readlines()
lines = [line.replace(' ', '') for line in lines]

# finally, write lines in the file
with open('file.txt', 'w') as f:
   content= f.writelines(lines)
print(content)'''

sentence_ranks = score_tokens(word_tokens, sentence_tokens)
p=summarize(sentence_ranks, sentence_tokens,4)
print("\n")
print("summarizer:\n")


print(p)