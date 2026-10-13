# ---------- Stage 1: build ----------
# Node 16 for old CRA (react-scripts 4) compatibility
FROM node:16-alpine AS build

WORKDIR /app

# Install dependencies (v1 jaisi layer, taa ke build cache reuse ho)
COPY package*.json ./
RUN npm ci

# Copy source and build static files
COPY . .
RUN npm run build

# ---------- Stage 2: runtime ----------
FROM nginx:1.28-alpine

# SPA config: unknown routes -> index.html (same as `serve -s`)
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Sirf build output copy karo, node_modules/source nahi
COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
