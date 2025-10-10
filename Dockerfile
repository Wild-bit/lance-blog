# ---------- 构建阶段 ----------
FROM node:20-alpine AS builder
WORKDIR /app

# ---------- 开启 pnpm ----------
RUN corepack enable && corepack prepare pnpm@latest --activate

# ---------- 缓存依赖层 ----------
# 仅复制依赖相关文件，避免每次构建都重新安装
COPY package.json pnpm-lock.yaml ./

# 安装依赖（利用缓存）
RUN pnpm install --frozen-lockfile

# ---------- 拷贝完整源码 ----------
COPY . .

# 构建 Next.js SSR 项目
RUN pnpm build

# ---------- 运行阶段 ----------
FROM node:20-alpine AS runner
WORKDIR /app

ENV NODE_ENV=production
ENV PORT=3000

# 开启 pnpm
RUN corepack enable && corepack prepare pnpm@latest --activate

# 拷贝构建产物和依赖
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/package.json ./package.json
COPY --from=builder /app/next.config.ts ./next.config.ts

# 暴露端口
EXPOSE 3000

# 启动应用
CMD ["pnpm", "start"]
