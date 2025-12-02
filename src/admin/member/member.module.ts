// 📌 Module: 묶고 주입 연결 (member.module.ts)
// - member 기능과 관련된 controller/service/의존성 묶음
// - AppModule에 이  MemberModule import해줘야 함

// src/admin/member/member.module.ts
import { Module } from '@nestjs/common';
import { PrismaModule } from '../../prisma/prisma.module';


import { MemberService } from './member.service';
import { MemberController } from './member.controller';


@Module({
  imports: [PrismaModule],        // PrismaService 주입받기 위해
  controllers: [MemberController],
  providers: [MemberService],
  exports: [MemberService],       // 다른 모듈에서 MemberService 쓰고 싶을 때
})
export class MemberModule {}
