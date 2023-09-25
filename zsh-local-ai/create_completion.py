#!/usr/bin/env python3

import subprocess
import sys
import time


ai_url = 'http://localhost:8085/v1'

cursor_position_char = int(sys.argv[1])

buffer = sys.stdin.read()
prompt_prefix = buffer[:cursor_position_char]
prompt_suffix = buffer[cursor_position_char:]
full_command = prompt_prefix + prompt_suffix
messages = [{
    "role": 'system',
    "content": "You are a zsh shell expert, please help me complete"
               " the following command. "
               "You should only output the completed command, "
               "no need to include any other explanation."
},
    {
    "role": 'user',
    "content": full_command,
}]
messages = str(messages).replace("'", '"')

curl_command = (
    f"curl -X POST -H 'Content-Type: application/json' "
    f"-d '{{\"model\": \"gpt4all-j\", \"messages\": {messages}}}' "
    f"{ai_url}/chat/completions"
)

process = subprocess.Popen(
    curl_command,
    stderr=subprocess.PIPE,
    stdout=subprocess.PIPE,
    shell=True,
)

spinner = ['-', '/', '|', '\\']
i = 0
while process.poll() is None:
    sys.stdout.write('\r' + spinner[i % len(spinner)])
    i += 1
    time.sleep(0.1)


stdout, stderr = process.communicate()

sys.stdout.write('\r')

# print the output
if process.returncode == 0:
    completed_command = eval(stdout)['choices'][0]['message']['content']
    sys.stdout.write(f" {completed_command}")
