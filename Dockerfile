# Build phase
FROM node:alpine as builder

WORKDIR '/app'
COPY package.json .
RUN npm install

# Don't use volume in production
COPY . .
RUN npm run build

# We need /app/build/*

# Run phase
FROM nginx

# From option to choose where it come from
# Check nginx image document
COPY --from=builder /app/build /usr/share/nginx/html

# Nginx contaien's default starts nginx automatically