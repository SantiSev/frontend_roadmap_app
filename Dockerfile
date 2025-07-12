# ---------- Stage 1: Builder ----------
FROM node:18-alpine AS builder

# Enable pnpm and set working directory
ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corepack enable && corepack prepare pnpm@latest --activate

WORKDIR /app
COPY package.json pnpm-lock.yaml* ./
RUN pnpm install --frozen-lockfile

# Copy all necessary files and build
COPY . .
RUN pnpm build

# ---------- Stage 2: Production ----------
FROM nginx:alpine AS prod

# Copy built assets
COPY --from=builder /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]
