# ========== Stage 1: Base ==========
FROM node:18-alpine AS base

# <<< Explicitly set PNPM path and ensure it's available
ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corepack enable && corepack prepare pnpm@latest --activate

WORKDIR /app
COPY package.json pnpm-lock.yaml* ./
RUN pnpm install --frozen-lockfile
COPY . .

# ========== Stage 2: Development ==========
FROM base AS dev
# <<< Use absolute path to pnpm with shell syntax
CMD ["/bin/sh", "-c", "pnpm dev"]

# ========== Stage 3: Builder ==========
FROM base AS builder
# Copy only necessary files for production build
COPY vite.config.ts tsconfig.json ./
RUN pnpm build

# ========== Stage 4: Production ==========
FROM nginx:alpine AS prod
COPY --from=builder /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]