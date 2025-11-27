import 'dotenv/config'; // .env 로드
import { defineConfig, env } from 'prisma/config';

export default defineConfig({
  // schema 파일 위치
  schema: 'prisma/schema.prisma',

  // migrate 관련 설정 (원하면 seed도 같이 등록 가능)
  migrations: {
    path: 'prisma/migrations',
    // seed: 'ts-node prisma/seed.ts', // 나중에 시드 스크립트 만들면 여기 등록
  },

  // ❗ 여기서 DB URL 설정
  datasource: {
    url: env('DATABASE_URL'),
    // shadowDatabaseUrl: env('SHADOW_DATABASE_URL'), // 필요하면
  },
});
