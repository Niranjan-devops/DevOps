FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install --omit=dev
FROM node:20-alpine
WORKDIR /app
COPY --from=builder /app/node_modules ./node_modules
COPY src/ ./src/
COPY views/ ./views/
COPY package.json ./
RUN addgroup -S appgroup && adduser -S -G appgroup appuser
USER appuser
EXPOSE 3000
CMD ["node", "src/server.js"]