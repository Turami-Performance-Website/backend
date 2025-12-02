// 📌 Controller : HTTP + Swagger (HTTP 라우터)
// - 어떤 URL + 메서드(POST/GET)를 받을지
// - 어떤 DTO로 받는지
// - Swagger 문서 정보

// src/admin/member/member.controller.ts
import { Controller, Get, Post, Body, Query } from '@nestjs/common';
import { MemberService } from './member.service';

//Swagger
import { ApiTags, ApiOperation, ApiQuery } from '@nestjs/swagger'; 

// DTO
import { CreateMemberDto } from './dto/create-member.dto';
import { SearchMembersDto } from './dto/search-members.dto';

//-------------------------------------------------------------------------

@ApiTags('Members') // Swagger 탭 이름
@Controller('admin/members') // 'admin/members' : 엔드포인트
export class MemberController {
  constructor(private readonly memberService: MemberService) {}

  @Post()
  @ApiOperation({
  //   summary: '멤버 생성',
  //   description: '기수 / 이름 / 비고를 입력해 새로운 멤버를 추가합니다.',
  })
  async create(@Body() dto: CreateMemberDto) {
    return this.memberService.createMember(dto);
  }

  @Get()
  @ApiOperation({
  //   summary: '멤버 목록 조회',
  //   description: '필터 없이 전체 멤버 목록을 조회합니다. (나중에 검색 조건 추가 가능)',
  })
  @ApiQuery({
    name: 'generation',
    required: false,
    type: Number,
  })
  @ApiQuery({
    name: 'name',
    required: false,
    type: String,
    description: '이름 부분 검색',
    example: '홍',
  })
  async findAll(@Query() query: SearchMembersDto) {
    return this.memberService.getMembers(query); //    return 'members';
  }
}
