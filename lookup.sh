#!/bin/bash

# Lookup Japanese word reading using よみたんAPI

lookup_reading() {
  local word="$1"

  # Handle multiple words without quotes
  if [ $# -gt 1 ]; then
    word="$1"
    shift
    while [ $# -gt 0 ]; do
      word="$word $1"
      shift
    done
  fi

  if [ -z "$word" ]; then
    echo "Usage: $0 <japanese_word>"
    exit 1
  fi

  local encoded_word=$(printf '%s' "$word" | iconv -t UTF-8 | xxd -p | sed 's/\(..\)/%\1/g')
  local url="https://yomitan.harmonicom.jp/api/v2/yomi?ic=UTF8&oc=UTF8&kana=h&num=1&text=$encoded_word"

  local response=$(curl -s "$url")

  if [[ -z "$response" ]]; then
    echo "Error: Could not retrieve data from the API."
    exit 1
  fi

  local reading=$(echo "$response" | jq -r '.yomi[0]')

  if [[ -z "$reading" ]]; then
    echo "Reading not found."
    exit 1
  fi

  echo "$reading"
}

# Main execution
lookup_reading "$@"
