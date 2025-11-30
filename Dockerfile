FROM node:18

# 앱 내부 디렉토리
WORKDIR /app

# 불필요한 파일 빼고 package*만 먼저 복사
COPY package*.json ./

# production dependency만 설치
RUN npm install --production

# 전체 파일 복사
COPY . .

# uploads 디렉터리가 없다면 생성
RUN mkdir -p uploads

# 앱이 사용 중인 포트 (예: 3000)
EXPOSE 3000

# 실행
CMD ["node", "app.js"]
