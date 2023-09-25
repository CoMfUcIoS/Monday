LOCALAI=http://localhost:8085

install:
	pip3 install openai
	mkdir -p models

start:
	docker compose up

pull:
	docker compose pull

test:
	curl $(LOCALAI)/v1/chat/completions -H "Content-Type: application/json" -d '{"model": "gpt4all-j", "messages": [{"role": "user", "content": "How are you?"}],"temperature": 0.1 }'

.SILENT:
get_models:
	curl $(LOCALAI)/models/apply -H "Content-Type: application/json" -d '{"url": "github:go-skynet/model-gallery/gpt4all-j.yaml","name": "gpt4all-j"}'
	rm -rf models/*.tmpl