// 📌 Service : 실제 DB 로직 (비즈니스 로직 & DB 접근 담당)
// - controller에서 HTTP는 처리
// - service에서 Prisma를 사용해서 DB에 접근하는 구조

// src/admin/member/member.service.ts
import { Injectable } from '@nestjs/common';
import { PrismaService } from '../../prisma/prisma.service';

// DTO
import { CreateMemberDto } from './dto/create-member.dto';
import { SearchMembersDto } from './dto/search-members.dto';

//---------------------------------------------------------------------------------

@Injectable()
export class MemberService {
  constructor(private readonly prisma: PrismaService) {} // prisma -> DB 접근

  // 멤버 생성 로직
  async createMember(dto: CreateMemberDto) {
    return this.prisma.members.create({
      data: {
        generation: dto.generation,
        name: dto.name,
        note: dto.note ?? null,
      },
    });
  }

  // 멤버 목록 조회 + 검색 로직
  async getMembers(query: SearchMembersDto) {
    const where: any = {};

    if (query.generation !== undefined) {
      where.generation = query.generation;
    }

    if (query.name) {
      where.name = {
        contains: query.name,
        mode: 'insensitive', // 대소문자 무시 (Postgres에서 지원)
      };
    }

    return this.prisma.members.findMany({
      where,
      orderBy: [{ generation: 'desc' }, { name: 'asc' }],
    });
  }
}