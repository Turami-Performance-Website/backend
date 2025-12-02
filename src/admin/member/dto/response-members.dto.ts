export class MemberResponseDto {
  member_id: bigint; // 또는 string
  generation: number;
  name: string;
  note?: string | null;
}
