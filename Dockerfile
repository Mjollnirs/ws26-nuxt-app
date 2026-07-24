FROM node:24.1.0-bookworm AS build
WORKDIR /app
COPY package*.json .npmrc ./
RUN npm install
COPY . .
RUN npm run build

FROM node:24.1.0-bookworm AS runtime
WORKDIR /app
ENV NODE_ENV=production
ENV HOST=0.0.0.0
ENV PORT=80
COPY --from=build /app/.output ./.output
EXPOSE 80
CMD ["node", ".output/server/index.mjs"]
