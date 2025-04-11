import praw
import pandas as pd
from datetime import datetime
from vaderSentiment.vaderSentiment import SentimentIntensityAnalyzer

# Step 1: Authenticate with Reddit API (Use your credentials here)
reddit = praw.Reddit(
    client_id='YOUR_CLIENT_ID',
    client_secret='YOUR_CLIENT_SECRET',
    user_agent='meme-market-analyzer'
)

# Step 2: Scrape top posts from r/wallstreetbets
subreddit = reddit.subreddit('wallstreetbets')
posts = []

for post in subreddit.top(time_filter='year', limit=1000):
    posts.append({
        'title': post.title,
        'created_utc': datetime.utcfromtimestamp(post.created_utc),
        'score': post.score
    })

# Step 3: Create DataFrame
df = pd.DataFrame(posts)

# Step 4: Run sentiment analysis on meme titles
analyzer = SentimentIntensityAnalyzer()
df['sentiment'] = df['title'].apply(lambda x: analyzer.polarity_scores(x)['compound'])

# Step 5 (Optional): Display sample
print(df.head())

# Save to CSV for future use
df.to_csv('reddit_memes_sentiment.csv', index=False)
