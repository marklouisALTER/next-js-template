FROM node:20-alpine AS base 

FROM base AS builder

RUN apk add --no-cache libc6-compat && \
    npm install -g npm@10.8.3

WORKDIR /builder

COPY package*.json ./

RUN npm install --frozen-lockfile

COPY . .

RUN npm run build && \
    npm prune --production 

FROM base AS runner

WORKDIR /runner


COPY --from=builder /builder/node_modules /runner/node_modules
COPY --from=builder /builder/build /runner/build
COPY --from=builder /builder/package.json /runner/package.json

EXPOSE 3000

