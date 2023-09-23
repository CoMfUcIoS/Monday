#!/usr/bin/env python3

import openai
import sys

openai.api_base = "http://localhost:8085/v1"
openai.api_key = "LOCAL-KEY"

cursor_position_char = int(sys.argv[1])

# Read the input prompt from stdin.
buffer = sys.stdin.read()
prompt_prefix = '#!/bin/zsh\n\n' + buffer[:cursor_position_char]
prompt_suffix = buffer[cursor_position_char:]
full_command = prompt_prefix + prompt_suffix
response = openai.ChatCompletion.create(model='gpt4all-j"', messages=[
    {
        "role":'system',
        "content": "You are a zsh shell expert, please help me complete the following command, you should only output the completed command, no need to include any other explanation",
    },
    {
        "role":'user',
        "content": full_command,
    }
])
completed_command = response['choices'][0]['message']['content']

sys.stdout.write(f"\n{completed_command.replace(prompt_prefix, '', 1)}")
