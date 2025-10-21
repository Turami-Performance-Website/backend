import { Controller, Get, Query } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';

@Controller('members')
export class MemberController {
  constructor(private readonly prisma: PrismaService) {}

  @Get()
  async list(@Query('generation') generation?: string) {
    return this.prisma.members.findMany({
      where: generation ? { generation: Number(generation) } : undefined,
      orderBy: [{ generation: 'asc' }, { name: 'asc' }],
    });
  }
}
