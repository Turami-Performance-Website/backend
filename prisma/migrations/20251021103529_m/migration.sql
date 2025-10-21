-- DropForeignKey
ALTER TABLE "public"."SetlistItems" DROP CONSTRAINT "SetlistItems_song_id_fkey";

-- AddForeignKey
ALTER TABLE "SetlistItems" ADD CONSTRAINT "SetlistItems_song_id_fkey" FOREIGN KEY ("song_id") REFERENCES "Songs"("song_id") ON DELETE CASCADE ON UPDATE CASCADE;
