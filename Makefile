LOCALAI=http://localhost:8085

start:
	mkdir -p models
	docker compose up

pull:
	docker compose pull

restart:
	rm -rf models/*.tmpl
	docker compose restart

test:
	curl $(LOCALAI)/v1/chat/completions -H "Content-Type: application/json" -d '{"model": "gpt4all-j", "messages": [{"role": "user", "content": "How are you?"}],"temperature": 0.1 }'
get_models:
	curl $(LOCALAI)/models/apply -H "Content-Type: application/json" -d '{"url": "github:go-skynet/model-gallery/gpt4all-j.yaml","name": "gpt4all-j"}'

.SILENT: install start restart pull test get_models