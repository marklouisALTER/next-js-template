FROM node:20-alpine AS base 

FROM base AS builder

RUN apk add --no-cache libc6-compat && \
    npm install -g npm@10.8.3

WORKDIR /builder

COPY package*.json ./

RUN npm install
COPY . .

RUN npm run build && \
    npm prune --production 

FROM base AS runner

WORKDIR /runner


COPY --from=builder /builder/node_modules /runner/node_modules
COPY --from=builder /builder/.next /runner/.next  
COPY --from=builder /builder/package.json /runner/package.json

EXPOSE 3000

CMD ["npm", "run", "start"]

# For running docker build 
# docker build -t <image-name> . ex next-js-template
# docker run -p 3000:3000 <image-name> ex next-js-template