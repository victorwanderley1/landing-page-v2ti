FROM node:21 as builder
WORKDIR /app
COPY . .
RUN npm install
RUN npm run build

FROM nginx:alpine
COPY --from=builder /app/dist/landing-page/browser usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf
COPY mime.type /etc/nginx/mime.type
COPY ssl/cert.pem ssl/cert.pem
COPY ssl/privkey.pem ssl/privkey.pem
EXPOSE 80
EXPOSE 443
CMD ["nginx", "-g", "daemon off;"]