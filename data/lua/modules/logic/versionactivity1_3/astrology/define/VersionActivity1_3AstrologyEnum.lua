module("modules.logic.versionactivity1_3.astrology.define.VersionActivity1_3AstrologyEnum", package.seeall)

slot0 = _M
slot0.Planet = {
	muxing = 6,
	huoxing = 5,
	tuxing = 7,
	shuixing = 2,
	taiyang = 1,
	jinxing = 3,
	yueliang = 4
}
slot0.PlanetItem = {
	[slot0.Planet.shuixing] = 970004,
	[slot0.Planet.jinxing] = 970005,
	[slot0.Planet.yueliang] = 970006,
	[slot0.Planet.huoxing] = 970007,
	[slot0.Planet.muxing] = 970008,
	[slot0.Planet.tuxing] = 970009
}
slot0.TipPos = {
	{
		-130,
		280
	},
	{
		25,
		275
	},
	{
		-210,
		245
	}
}
slot0.PlanetOffsetX = -779
slot0.PlanetOffsetY = -152
slot0.Angle = 60
slot0.MaxStarNum = 10

return slot0
