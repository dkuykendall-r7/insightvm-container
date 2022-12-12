#!/usr/bin/env bash
docker compose stop; docker compose rm -v -f; docker compose -f docker-compose.yml up -d --build
