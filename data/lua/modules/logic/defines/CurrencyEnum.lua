-- chunkname: @modules/logic/defines/CurrencyEnum.lua

module("modules.logic.defines.CurrencyEnum", package.seeall)

local CurrencyEnum = _M

CurrencyEnum.CurrencyType = {
	V1a8Dungeon = 1804,
	SkinCard = 12,
	V1a7Dungeon = 1701,
	V1a6DungeonSkill = 1601,
	Act191 = 2702,
	V1a5DungeonBuild = 1502,
	Act133 = 1413,
	Power = 4,
	TowerStore = 28,
	HeroExperience = 5,
	BossRushStore = 26,
	DryForest = 1202,
	Gold = 3,
	V1a9ToughEnter = 1902,
	RoomTrade = 2202,
	V2a2Dungeon = 2201,
	FreeDiamondCoupon = 2,
	V2a3DouQuQu = 2302,
	BlueSoul = 10,
	V2a4Dungeon = 2401,
	V2a5Dungeon = 2501,
	ReactivityCurrency = 25,
	BulbCurrency = 2881,
	Competition = 6,
	OldTravelTicket = 27,
	Diamond = 1,
	V2a7Dungeon = 2701,
	V1a6CachotCoin = 1603,
	V1a9Dungeon = 1901,
	V2a1Dungeon = 2101,
	V3a1Dungeon = 3101,
	Act134Clue = 1414,
	V1a8FactoryPart = 1812,
	V2a9Dungeon = 30501,
	V3a1DouQuQu = 3102,
	KeyCurrency = 2882,
	V2a8Dungeon = 2801,
	V2a0Dungeon = 2001,
	V3a0Dungeon = 3001,
	RoomFishing = 3103,
	Act186 = 2503,
	RoomCritterTrain = 280001,
	V2a6Dungeon = 2601,
	LvHuEMen = 1201,
	V1a6CachotCurrency = 1604,
	V1a6Dungeon = 1605,
	OrangeSoul = 11,
	V3a2Dungeon = 3203,
	V3a2Rouge = 3201,
	Act145 = 1515,
	Planet = 1301,
	LeiMiTeBei = 111,
	V1a5Dungeon = 1501,
	V1a8FactoryRawMat = 1811,
	V2a3Dungeon = 2301,
	RoleStory = 24
}
CurrencyEnum.SubType = {
	RoomFishingResourceItem = 3101
}
CurrencyEnum.AllCurrency = {
	CurrencyEnum.CurrencyType.Diamond,
	CurrencyEnum.CurrencyType.FreeDiamondCoupon,
	CurrencyEnum.CurrencyType.Gold,
	CurrencyEnum.CurrencyType.Power,
	CurrencyEnum.CurrencyType.HeroExperience,
	CurrencyEnum.CurrencyType.Competition,
	CurrencyEnum.CurrencyType.BlueSoul,
	CurrencyEnum.CurrencyType.OrangeSoul
}
CurrencyEnum.PayDiamondExchangeSource = {
	Store = 4,
	HUD = 1,
	SkinStore = 5,
	Summon = 3,
	Power = 2
}

return CurrencyEnum
