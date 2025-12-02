// src/admin/member/dto/create-member.dto.ts

import { IsInt, IsOptional, IsString, MaxLength, Min } from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';


export class CreateMemberDto { // member 생성
  // 기수 (1기, 2기, 3기...)
  @ApiProperty({
    description: '기수',
    example: 5,
    minimum: 1,
  })
  @IsInt()
  @Min(1, { message: '기수는 1 이상이어야 합니다.' })
  generation: number;

  // 이름
  @ApiProperty({
    description: '이름',
    example: '김철수',
    maxLength: 20,
  })
  @IsString()
  @MaxLength(20, { message: '이름은 20자를 넘을 수 없습니다.' })
  name: string;

  // 비고 (선택)
  @ApiPropertyOptional({
    description: '비고 (참고용)',
    example: '신소재, 목조 등',
    maxLength: 20,
  })
  @IsOptional()
  @IsString()
  @MaxLength(20, { message: '비고는 20자를 넘을 수 없습니다.' })
  note?: string;
}
