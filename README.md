# Next.js (src/app 模式) 项目结构与服务端逻辑
```
lance-blog/
├─ src/
│  ├─ app/                     # App Router 根目录
│  │  ├─ api/                  # API 路由（服务端代码）
│  │  │  ├─ hello/route.ts     # /api/hello GET/POST
│  │  │  └─ users/route.ts     # /api/users
│  │  │      └─ 用户请求 -> 调用 lib/services 逻辑 -> 返回响应
│  │  ├─ layout.tsx            # 全局布局（Server Component 或 Client Component）
│  │  ├─ page.tsx              # 首页 Server Component，SSR 页面
│  │  │      └─ 调用 lib/services 获取数据 -> 渲染页面
│  │  └─ dashboard/            # 嵌套路由
│  │      ├─ layout.tsx
│  │      └─ page.tsx          # Dashboard 页面
│  │             └─ 调用服务端逻辑（lib/services/db）渲染
│  ├─ components/              # 可复用前端组件（纯前端）
│  ├─ lib/                     # 服务端逻辑工具库
│  │  ├─ db.ts                 # 数据库连接
│  │  └─ services/             # 业务逻辑函数
│  │      ├─ userService.ts    # 用户相关服务函数
│  │      └─ authService.ts    # 认证相关服务函数
│  └─ styles/                  # 样式文件
├─ public/                      # 静态资源
├─ middleware.ts                # 请求中间件（认证/日志/重定向）
├─ next.config.js
├─ package.json
└─ tsconfig.json
```
# 🔹 逻辑关系说明

- `app/api/*/route.ts`
  - 接收 HTTP 请求（GET/POST/PUT/DELETE）
  - 调用 `lib/services/*` 处理业务逻辑
  - 返回 JSON 响应

- `Server Components` (app/page.tsx, app/dashboard/page.tsx)
  - 运行在服务端
  - 可以直接访问 `lib/db.ts` 或 `lib/services/*` 获取数据
  - 渲染后输出 HTML 给客户端

- `Client Components` (components/*)
  - 前端渲染组件
  - 可通过 fetch 调用 API 路由获取数据

- `middleware.ts`
  - 拦截请求
  - 可做认证、缓存、日志、重定向等


This is a [Next.js](https://nextjs.org) project bootstrapped with [`create-next-app`](https://nextjs.org/docs/app/api-reference/cli/create-next-app).

## Getting Started

First, run the development server:

```bash
npm run dev
# or
yarn dev
# or
pnpm dev
# or
bun dev
```

Open [http://localhost:3000](http://localhost:3000) with your browser to see the result.

You can start editing the page by modifying `app/page.tsx`. The page auto-updates as you edit the file.

This project uses [`next/font`](https://nextjs.org/docs/app/building-your-application/optimizing/fonts) to automatically optimize and load [Geist](https://vercel.com/font), a new font family for Vercel.

## Learn More

To learn more about Next.js, take a look at the following resources:

- [Next.js Documentation](https://nextjs.org/docs) - learn about Next.js features and API.
- [Learn Next.js](https://nextjs.org/learn) - an interactive Next.js tutorial.

You can check out [the Next.js GitHub repository](https://github.com/vercel/next.js) - your feedback and contributions are welcome!

## Deploy on Vercel

The easiest way to deploy your Next.js app is to use the [Vercel Platform](https://vercel.com/new?utm_medium=default-template&filter=next.js&utm_source=create-next-app&utm_campaign=create-next-app-readme) from the creators of Next.js.

Check out our [Next.js deployment documentation](https://nextjs.org/docs/app/building-your-application/deploying) for more details.
