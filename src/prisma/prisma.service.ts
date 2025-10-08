import { INestApplication, Injectable, OnModuleInit } from '@nestjs/common';
// generated 경로가 레포 루트에 있으니 src/prisma 기준으로는 '../../generated/prisma'
import { PrismaClient } from '../../generated/prisma';

@Injectable()
export class PrismaService extends PrismaClient implements OnModuleInit {
  async onModuleInit() {
    await this.$connect();
  }

  async enableShutdownHooks(app: INestApplication) {
    this.$on('beforeExit', async () => {
      await app.close();
    });
  }
}
