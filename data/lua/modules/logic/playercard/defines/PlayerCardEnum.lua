-- chunkname: @modules/logic/playercard/defines/PlayerCardEnum.lua

module("modules.logic.playercard.defines.PlayerCardEnum", package.seeall)

local PlayerCardEnum = _M

PlayerCardEnum.LeftContent = {
	Act148SSSCount = 4,
	TowerBossPassCount = 7,
	Act128Level = 9,
	ExploreCollection = 5,
	RougeDifficulty = 1,
	WeekwalkVer2PlatinumCup = 8,
	RoomCollection = 3,
	TowerLayer = 6,
	WeekWalkDeep = 2
}
PlayerCardEnum.ProgressShowType = {
	Explore = 4,
	Room = 5,
	Normal = 1
}
PlayerCardEnum.RightContent = {
	LoginDay = 3,
	AssitCount = 5,
	CreatTime = 2,
	HeroCount = 1,
	MaxLevelHero = 4,
	HeroCoverTimes = 9,
	SkinCount = 7,
	TotalCostPower = 8,
	CompleteConfidence = 6
}
PlayerCardEnum.BaseInfoType = {
	HeroCount = 1,
	CreatTime = 3,
	Normal = 2
}
PlayerCardEnum.EmptyString = "—"
PlayerCardEnum.EmptyString2 = "— —"
PlayerCardEnum.MaxProgressCardNum = 5
PlayerCardEnum.MaxBaseInfoNum = 4
PlayerCardEnum.CompType = {
	Layout = 2,
	Normal = 1
}
PlayerCardEnum.FriendViewType = {
	black = 5,
	offline = 2,
	add = 3,
	online = 1,
	playerinfo = 4
}
PlayerCardEnum.PlayerCardGuideId = 24110
PlayerCardEnum.TowerMaxStageId = 7

return PlayerCardEnum
