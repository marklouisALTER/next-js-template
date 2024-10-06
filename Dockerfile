FROM node:20-alpine AS base 

FROM base AS development

RUN apk add --no-cache libc6-compat && \
    npm install -g npm@10.8.3

WORKDIR /app

COPY package*.json ./

RUN npm ci

COPY . .

CMD ["npm", "run", "dev"]


