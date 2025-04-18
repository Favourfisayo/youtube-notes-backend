import sys
import json
from youtube_transcript_api import YouTubeTranscriptApi
from youtube_transcript_api._utils import TranscriptParser
import requests
import os
from dotenv import load_dotenv
load_dotenv()
proxy_url = os.getenv("PROXY_URL")

video_id = sys.argv[1]

# Replace this with a real proxy address
proxies = {
    "http": proxy_url,
    "https": proxy_url
}

try:
    session = requests.Session()
    session.proxies.update(proxies)

    # Monkey-patch the requests session in the YouTubeTranscriptApi
    YouTubeTranscriptApi._TranscriptRetriever._requester = session

    transcript = YouTubeTranscriptApi.get_transcript(video_id)
    texts = " ".join([entry['text'] for entry in transcript])
    print(json.dumps(texts))
except Exception as e:
    print(f"Error: {str(e)}", file=sys.stderr)
    sys.exit(1)
