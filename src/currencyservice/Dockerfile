# Production Dockerfile (recreated) - currencyservice (Node.js / gRPC)

FROM node:20-alpine AS base
WORKDIR /usr/src/app

FROM base AS deps
COPY package*.json ./
RUN npm ci --omit=dev

FROM base
ENV NODE_ENV=production
COPY --from=deps /usr/src/app/node_modules ./node_modules
COPY . .
EXPOSE 7000
USER node
ENTRYPOINT ["node","server.js"]

