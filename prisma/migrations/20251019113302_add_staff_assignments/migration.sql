-- CreateEnum
CREATE TYPE "role_enum" AS ENUM ('V', 'G', 'B', 'D', 'K');

-- CreateEnum
CREATE TYPE "performance_status_enum" AS ENUM ('DRAFT', 'PUBLISHED');

-- CreateEnum
CREATE TYPE "song_type_enum" AS ENUM ('자작곡', '기성곡');

-- CreateTable
CREATE TABLE "members" (
    "member_id" BIGSERIAL NOT NULL,
    "generation" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "note" TEXT,

    CONSTRAINT "members_pkey" PRIMARY KEY ("member_id")
);

-- CreateTable
CREATE TABLE "performances" (
    "performance_id" BIGSERIAL NOT NULL,
    "title" TEXT,
    "event_date" TIMESTAMP(3),
    "label" TEXT,
    "status" "performance_status_enum" NOT NULL DEFAULT 'DRAFT',

    CONSTRAINT "performances_pkey" PRIMARY KEY ("performance_id")
);

-- CreateTable
CREATE TABLE "performance_participants" (
    "performance_id" BIGINT NOT NULL,
    "member_id" BIGINT NOT NULL,

    CONSTRAINT "performance_participants_pkey" PRIMARY KEY ("performance_id","member_id")
);

-- CreateTable
CREATE TABLE "staff_assignments" (
    "performance_id" BIGINT NOT NULL,
    "member_id" BIGINT NOT NULL,

    CONSTRAINT "staff_assignments_pkey" PRIMARY KEY ("performance_id","member_id")
);

-- CreateTable
CREATE TABLE "setlist_items" (
    "performance_id" BIGINT NOT NULL,
    "part_no" INTEGER NOT NULL,
    "position_no" INTEGER NOT NULL,
    "song_id" BIGINT NOT NULL,

    CONSTRAINT "setlist_items_pkey" PRIMARY KEY ("performance_id","part_no","position_no")
);

-- CreateTable
CREATE TABLE "song_participants" (
    "performance_id" BIGINT NOT NULL,
    "song_id" BIGINT NOT NULL,
    "member_id" BIGINT NOT NULL,
    "role" "role_enum" NOT NULL,

    CONSTRAINT "song_participants_pkey" PRIMARY KEY ("performance_id","song_id","member_id","role")
);

-- CreateTable
CREATE TABLE "songs" (
    "song_id" BIGSERIAL NOT NULL,
    "type" "song_type_enum" NOT NULL,
    "title" TEXT NOT NULL,
    "composer" TEXT,

    CONSTRAINT "songs_pkey" PRIMARY KEY ("song_id")
);

-- CreateIndex
CREATE INDEX "members_generation_idx" ON "members"("generation");

-- CreateIndex
CREATE INDEX "members_name_idx" ON "members"("name");

-- CreateIndex
CREATE INDEX "performances_label_idx" ON "performances"("label");

-- CreateIndex
CREATE INDEX "song_participants_member_id_idx" ON "song_participants"("member_id");

-- CreateIndex
CREATE INDEX "song_participants_performance_id_song_id_idx" ON "song_participants"("performance_id", "song_id");

-- CreateIndex
CREATE INDEX "songs_title_idx" ON "songs"("title");

-- AddForeignKey
ALTER TABLE "performance_participants" ADD CONSTRAINT "performance_participants_performance_id_fkey" FOREIGN KEY ("performance_id") REFERENCES "performances"("performance_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "performance_participants" ADD CONSTRAINT "performance_participants_member_id_fkey" FOREIGN KEY ("member_id") REFERENCES "members"("member_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "staff_assignments" ADD CONSTRAINT "staff_assignments_performance_id_fkey" FOREIGN KEY ("performance_id") REFERENCES "performances"("performance_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "staff_assignments" ADD CONSTRAINT "staff_assignments_member_id_fkey" FOREIGN KEY ("member_id") REFERENCES "members"("member_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "setlist_items" ADD CONSTRAINT "setlist_items_performance_id_fkey" FOREIGN KEY ("performance_id") REFERENCES "performances"("performance_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "setlist_items" ADD CONSTRAINT "setlist_items_song_id_fkey" FOREIGN KEY ("song_id") REFERENCES "songs"("song_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "song_participants" ADD CONSTRAINT "song_participants_member_id_fkey" FOREIGN KEY ("member_id") REFERENCES "members"("member_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "song_participants" ADD CONSTRAINT "song_participants_performance_id_fkey" FOREIGN KEY ("performance_id") REFERENCES "performances"("performance_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "song_participants" ADD CONSTRAINT "song_participants_song_id_fkey" FOREIGN KEY ("song_id") REFERENCES "songs"("song_id") ON DELETE CASCADE ON UPDATE CASCADE;
