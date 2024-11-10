-- CreateTable
CREATE TABLE "EventStatus" (
    "status_name" TEXT NOT NULL,
    "description" TEXT,

    CONSTRAINT "EventStatus_pkey" PRIMARY KEY ("status_name")
);

-- CreateTable
CREATE TABLE "Sport" (
    "official_name" TEXT NOT NULL,
    "description" TEXT,

    CONSTRAINT "Sport_pkey" PRIMARY KEY ("official_name")
);

-- CreateTable
CREATE TABLE "Event" (
    "event_id" SERIAL NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,
    "sport_name" TEXT NOT NULL,
    "status_name" TEXT NOT NULL,
    "season" INTEGER NOT NULL,
    "home_team_name" TEXT NOT NULL,
    "away_team_name" TEXT NOT NULL,

    CONSTRAINT "Event_pkey" PRIMARY KEY ("event_id")
);

-- CreateTable
CREATE TABLE "FootballEventResult" (
    "football_event_result_id" SERIAL NOT NULL,
    "home_goals" INTEGER NOT NULL,
    "away_goals" INTEGER NOT NULL,
    "winner" TEXT NOT NULL,
    "event_id" INTEGER NOT NULL,

    CONSTRAINT "FootballEventResult_pkey" PRIMARY KEY ("football_event_result_id")
);

-- CreateTable
CREATE TABLE "Team" (
    "official_name" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "venue_id" INTEGER NOT NULL,
    "slug" TEXT NOT NULL,
    "sport_name" TEXT NOT NULL,
    "abbreviation" TEXT NOT NULL,
    "country_code" TEXT NOT NULL,

    CONSTRAINT "Team_pkey" PRIMARY KEY ("official_name")
);

-- CreateTable
CREATE TABLE "Country" (
    "country_code" TEXT NOT NULL,
    "full_name" TEXT NOT NULL,

    CONSTRAINT "Country_pkey" PRIMARY KEY ("country_code")
);

-- CreateTable
CREATE TABLE "Venue" (
    "venue_id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "address" TEXT NOT NULL,

    CONSTRAINT "Venue_pkey" PRIMARY KEY ("venue_id")
);

-- CreateTable
CREATE TABLE "Player" (
    "player_id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "surname" TEXT NOT NULL,
    "birthday" TIMESTAMP(3) NOT NULL,
    "team_name" TEXT NOT NULL,
    "sport_played" TEXT NOT NULL,

    CONSTRAINT "Player_pkey" PRIMARY KEY ("player_id")
);

-- CreateIndex
CREATE UNIQUE INDEX "FootballEventResult_event_id_key" ON "FootballEventResult"("event_id");

-- CreateIndex
CREATE UNIQUE INDEX "Team_slug_key" ON "Team"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "Venue_address_key" ON "Venue"("address");

-- AddForeignKey
ALTER TABLE "Event" ADD CONSTRAINT "Event_away_team_name_fkey" FOREIGN KEY ("away_team_name") REFERENCES "Team"("official_name") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Event" ADD CONSTRAINT "Event_home_team_name_fkey" FOREIGN KEY ("home_team_name") REFERENCES "Team"("official_name") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Event" ADD CONSTRAINT "Event_sport_name_fkey" FOREIGN KEY ("sport_name") REFERENCES "Sport"("official_name") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Event" ADD CONSTRAINT "Event_status_name_fkey" FOREIGN KEY ("status_name") REFERENCES "EventStatus"("status_name") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FootballEventResult" ADD CONSTRAINT "FootballEventResult_event_id_fkey" FOREIGN KEY ("event_id") REFERENCES "Event"("event_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Team" ADD CONSTRAINT "Team_country_code_fkey" FOREIGN KEY ("country_code") REFERENCES "Country"("country_code") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Team" ADD CONSTRAINT "Team_sport_name_fkey" FOREIGN KEY ("sport_name") REFERENCES "Sport"("official_name") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Team" ADD CONSTRAINT "Team_venue_id_fkey" FOREIGN KEY ("venue_id") REFERENCES "Venue"("venue_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Player" ADD CONSTRAINT "Player_sport_played_fkey" FOREIGN KEY ("sport_played") REFERENCES "Sport"("official_name") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Player" ADD CONSTRAINT "Player_team_name_fkey" FOREIGN KEY ("team_name") REFERENCES "Team"("official_name") ON DELETE RESTRICT ON UPDATE CASCADE;
