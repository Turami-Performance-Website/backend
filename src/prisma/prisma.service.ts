import { Injectable, OnModuleInit, OnModuleDestroy } from '@nestjs/common';
import { PrismaClient } from '../../generated/prisma/client';
import { PrismaPg } from '@prisma/adapter-pg';
import pg from 'pg';

@Injectable()
export class PrismaService extends PrismaClient implements OnModuleInit, OnModuleDestroy {
  async onModuleInit() {
    await this.$connect();
  }

  // 앱이 내려갈 때 커넥션 정리
  async onModuleDestroy() {
    await this.$disconnect();
  }

  constructor() {
    // 1) Postgres 커넥션 풀 생성
    const pool = new pg.Pool({
      connectionString: process.env.DATABASE_URL,
    });

    // 2) Prisma용 adapter 생성
    const adapter = new PrismaPg(pool);

    // 3) PrismaClient에 adapter 주입
    super({ adapter });
  }


}





