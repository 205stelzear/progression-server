-- CreateTable
CREATE TABLE "facilitators" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "username" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT,
    "surname" TEXT,
    "totem" TEXT,
    "entry_date" DATETIME NOT NULL,
    "inactive_date" DATETIME
);

-- CreateTable
CREATE TABLE "packs" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "packColorId" INTEGER NOT NULL,
    "scoutYearId" INTEGER NOT NULL,
    FOREIGN KEY ("packColorId") REFERENCES "pack_colors" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY ("scoutYearId") REFERENCES "scout_years" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "pack_colors" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "color" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "scout_years" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "startDate" DATETIME NOT NULL,
    "endDate" DATETIME NOT NULL
);

-- CreateTable
CREATE TABLE "cubs" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "username" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT,
    "birth_date" DATETIME NOT NULL,
    "clan_baloo_date" DATETIME,
    "promesse_date" DATETIME,
    "join_date" DATETIME NOT NULL,
    "quit_date" DATETIME,
    "packId" INTEGER NOT NULL,
    FOREIGN KEY ("packId") REFERENCES "packs" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "preys" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "given_date" DATETIME,
    "completed_date" DATETIME,
    "failed" BOOLEAN NOT NULL DEFAULT false,
    "cubId" INTEGER NOT NULL,
    "preyTypeId" INTEGER NOT NULL,
    FOREIGN KEY ("cubId") REFERENCES "cubs" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY ("preyTypeId") REFERENCES "prey_types" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "prey_types" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "description" TEXT
);

-- CreateTable
CREATE TABLE "hunts" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "given_date" DATETIME,
    "completed_date" DATETIME,
    "failed" BOOLEAN NOT NULL DEFAULT false,
    "huntDescriptionId" INTEGER NOT NULL,
    "cubId" INTEGER NOT NULL,
    FOREIGN KEY ("huntDescriptionId") REFERENCES "hunt_descriptions" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY ("cubId") REFERENCES "cubs" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "hunt_descriptions" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "huntTypeId" INTEGER NOT NULL,
    FOREIGN KEY ("huntTypeId") REFERENCES "hunt_types" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "hunt_types" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "cub_badges" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "given_date" DATETIME,
    "mat_de_meute_date" DATETIME,
    "badgeDescriptionId" INTEGER NOT NULL,
    FOREIGN KEY ("badgeDescriptionId") REFERENCES "badge_descriptions" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "badge_descriptions" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "progressRequired" INTEGER NOT NULL,
    "territory" TEXT NOT NULL,
    "inventoryItemId" INTEGER NOT NULL,
    FOREIGN KEY ("inventoryItemId") REFERENCES "inventory_items" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "cub_generic_items" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "given_date" DATETIME,
    "completed_date" DATETIME,
    "inventoryItemId" INTEGER NOT NULL,
    "cubId" INTEGER NOT NULL,
    FOREIGN KEY ("inventoryItemId") REFERENCES "inventory_items" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY ("cubId") REFERENCES "cubs" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "cub_super_certificates" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "given_date" DATETIME,
    "completed_date" DATETIME,
    "failed" BOOLEAN NOT NULL DEFAULT false,
    "superCertificateDescriptionId" INTEGER NOT NULL,
    FOREIGN KEY ("superCertificateDescriptionId") REFERENCES "super_certificate_descriptions" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "super_certificate_descriptions" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "inventoryItemId" INTEGER NOT NULL,
    FOREIGN KEY ("inventoryItemId") REFERENCES "inventory_items" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "inventory_items" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "image" BLOB,
    "quantity" INTEGER NOT NULL DEFAULT 0,
    "isUnique" BOOLEAN NOT NULL DEFAULT true,
    "itemCategoryId" INTEGER NOT NULL,
    FOREIGN KEY ("itemCategoryId") REFERENCES "item_categories" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "item_categories" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "description" TEXT
);

-- CreateTable
CREATE TABLE "inventory_logs" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "quantity" INTEGER NOT NULL,
    "date" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "inventoryItemId" INTEGER NOT NULL,
    "inventoryLogTypeId" INTEGER NOT NULL,
    FOREIGN KEY ("inventoryItemId") REFERENCES "inventory_items" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY ("inventoryLogTypeId") REFERENCES "inventory_log_types" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "inventory_log_types" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "_FacilitatorToScoutYear" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,
    FOREIGN KEY ("A") REFERENCES "facilitators" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY ("B") REFERENCES "scout_years" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "_CubToScoutYear" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,
    FOREIGN KEY ("A") REFERENCES "cubs" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY ("B") REFERENCES "scout_years" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "facilitators.username_unique" ON "facilitators"("username");

-- CreateIndex
CREATE UNIQUE INDEX "cubs.username_unique" ON "cubs"("username");

-- CreateIndex
CREATE UNIQUE INDEX "_FacilitatorToScoutYear_AB_unique" ON "_FacilitatorToScoutYear"("A", "B");

-- CreateIndex
CREATE INDEX "_FacilitatorToScoutYear_B_index" ON "_FacilitatorToScoutYear"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_CubToScoutYear_AB_unique" ON "_CubToScoutYear"("A", "B");

-- CreateIndex
CREATE INDEX "_CubToScoutYear_B_index" ON "_CubToScoutYear"("B");
