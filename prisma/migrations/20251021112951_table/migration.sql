/*
  Warnings:

  - The primary key for the `SongParticipants` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `performance_id` on the `SongParticipants` table. All the data in the column will be lost.
  - You are about to drop the `SetlistItems` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "public"."SetlistItems" DROP CONSTRAINT "SetlistItems_performance_id_fkey";

-- DropForeignKey
ALTER TABLE "public"."SetlistItems" DROP CONSTRAINT "SetlistItems_song_id_fkey";

-- DropForeignKey
ALTER TABLE "public"."SongParticipants" DROP CONSTRAINT "SongParticipants_performance_id_fkey";

-- DropIndex
DROP INDEX "public"."SongParticipants_performance_id_song_id_idx";

-- AlterTable
ALTER TABLE "SongParticipants" DROP CONSTRAINT "SongParticipants_pkey",
DROP COLUMN "performance_id",
ADD CONSTRAINT "SongParticipants_pkey" PRIMARY KEY ("song_id", "member_id", "role");

-- AlterTable
ALTER TABLE "Songs" ADD COLUMN     "part_no" INTEGER,
ADD COLUMN     "performance_id" BIGINT,
ADD COLUMN     "position_no" INTEGER;

-- DropTable
DROP TABLE "public"."SetlistItems";

-- CreateIndex
CREATE INDEX "Songs_performance_id_part_no_position_no_idx" ON "Songs"("performance_id", "part_no", "position_no");
