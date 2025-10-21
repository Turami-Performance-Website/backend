/*
  Warnings:

  - You are about to drop the `members` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `performances` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `setlist_items` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `song_participants` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `songs` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "public"."performance_participants" DROP CONSTRAINT "performance_participants_member_id_fkey";

-- DropForeignKey
ALTER TABLE "public"."performance_participants" DROP CONSTRAINT "performance_participants_performance_id_fkey";

-- DropForeignKey
ALTER TABLE "public"."setlist_items" DROP CONSTRAINT "setlist_items_performance_id_fkey";

-- DropForeignKey
ALTER TABLE "public"."setlist_items" DROP CONSTRAINT "setlist_items_song_id_fkey";

-- DropForeignKey
ALTER TABLE "public"."song_participants" DROP CONSTRAINT "song_participants_member_id_fkey";

-- DropForeignKey
ALTER TABLE "public"."song_participants" DROP CONSTRAINT "song_participants_performance_id_fkey";

-- DropForeignKey
ALTER TABLE "public"."song_participants" DROP CONSTRAINT "song_participants_song_id_fkey";

-- DropForeignKey
ALTER TABLE "public"."staff_assignments" DROP CONSTRAINT "staff_assignments_member_id_fkey";

-- DropForeignKey
ALTER TABLE "public"."staff_assignments" DROP CONSTRAINT "staff_assignments_performance_id_fkey";

-- DropTable
DROP TABLE "public"."members";

-- DropTable
DROP TABLE "public"."performances";

-- DropTable
DROP TABLE "public"."setlist_items";

-- DropTable
DROP TABLE "public"."song_participants";

-- DropTable
DROP TABLE "public"."songs";

-- CreateTable
CREATE TABLE "Members" (
    "member_id" BIGSERIAL NOT NULL,
    "generation" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "note" TEXT,

    CONSTRAINT "Members_pkey" PRIMARY KEY ("member_id")
);

-- CreateTable
CREATE TABLE "Performances" (
    "performance_id" BIGSERIAL NOT NULL,
    "title" TEXT,
    "event_date" TIMESTAMP(3),
    "label" TEXT,
    "status" "performance_status_enum" NOT NULL DEFAULT 'DRAFT',

    CONSTRAINT "Performances_pkey" PRIMARY KEY ("performance_id")
);

-- CreateTable
CREATE TABLE "SetlistItems" (
    "performance_id" BIGINT NOT NULL,
    "part_no" INTEGER NOT NULL,
    "position_no" INTEGER NOT NULL,
    "song_id" BIGINT NOT NULL,

    CONSTRAINT "SetlistItems_pkey" PRIMARY KEY ("performance_id","part_no","position_no")
);

-- CreateTable
CREATE TABLE "SongParticipants" (
    "performance_id" BIGINT NOT NULL,
    "song_id" BIGINT NOT NULL,
    "member_id" BIGINT NOT NULL,
    "role" "role_enum" NOT NULL,

    CONSTRAINT "SongParticipants_pkey" PRIMARY KEY ("performance_id","song_id","member_id","role")
);

-- CreateTable
CREATE TABLE "Songs" (
    "song_id" BIGSERIAL NOT NULL,
    "type" "song_type_enum" NOT NULL,
    "title" TEXT NOT NULL,
    "composer" TEXT,

    CONSTRAINT "Songs_pkey" PRIMARY KEY ("song_id")
);

-- CreateIndex
CREATE INDEX "Members_generation_idx" ON "Members"("generation");

-- CreateIndex
CREATE INDEX "Members_name_idx" ON "Members"("name");

-- CreateIndex
CREATE INDEX "Performances_label_idx" ON "Performances"("label");

-- CreateIndex
CREATE INDEX "SongParticipants_member_id_idx" ON "SongParticipants"("member_id");

-- CreateIndex
CREATE INDEX "SongParticipants_performance_id_song_id_idx" ON "SongParticipants"("performance_id", "song_id");

-- CreateIndex
CREATE INDEX "Songs_title_idx" ON "Songs"("title");

-- AddForeignKey
ALTER TABLE "performance_participants" ADD CONSTRAINT "performance_participants_performance_id_fkey" FOREIGN KEY ("performance_id") REFERENCES "Performances"("performance_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "performance_participants" ADD CONSTRAINT "performance_participants_member_id_fkey" FOREIGN KEY ("member_id") REFERENCES "Members"("member_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "staff_assignments" ADD CONSTRAINT "staff_assignments_performance_id_fkey" FOREIGN KEY ("performance_id") REFERENCES "Performances"("performance_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "staff_assignments" ADD CONSTRAINT "staff_assignments_member_id_fkey" FOREIGN KEY ("member_id") REFERENCES "Members"("member_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SetlistItems" ADD CONSTRAINT "SetlistItems_performance_id_fkey" FOREIGN KEY ("performance_id") REFERENCES "Performances"("performance_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SetlistItems" ADD CONSTRAINT "SetlistItems_song_id_fkey" FOREIGN KEY ("song_id") REFERENCES "Songs"("song_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SongParticipants" ADD CONSTRAINT "SongParticipants_member_id_fkey" FOREIGN KEY ("member_id") REFERENCES "Members"("member_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SongParticipants" ADD CONSTRAINT "SongParticipants_performance_id_fkey" FOREIGN KEY ("performance_id") REFERENCES "Performances"("performance_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SongParticipants" ADD CONSTRAINT "SongParticipants_song_id_fkey" FOREIGN KEY ("song_id") REFERENCES "Songs"("song_id") ON DELETE CASCADE ON UPDATE CASCADE;
