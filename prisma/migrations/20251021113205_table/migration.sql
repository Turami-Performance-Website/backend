/*
  Warnings:

  - Made the column `composer` on table `Songs` required. This step will fail if there are existing NULL values in that column.
  - Made the column `part_no` on table `Songs` required. This step will fail if there are existing NULL values in that column.
  - Made the column `performance_id` on table `Songs` required. This step will fail if there are existing NULL values in that column.
  - Made the column `position_no` on table `Songs` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "Songs" ALTER COLUMN "composer" SET NOT NULL,
ALTER COLUMN "part_no" SET NOT NULL,
ALTER COLUMN "performance_id" SET NOT NULL,
ALTER COLUMN "position_no" SET NOT NULL;

-- AddForeignKey
ALTER TABLE "Songs" ADD CONSTRAINT "Songs_performance_id_fkey" FOREIGN KEY ("performance_id") REFERENCES "Performances"("performance_id") ON DELETE CASCADE ON UPDATE CASCADE;
