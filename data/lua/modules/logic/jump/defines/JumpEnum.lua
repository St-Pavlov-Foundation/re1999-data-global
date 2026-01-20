-- chunkname: @modules/logic/jump/defines/JumpEnum.lua

module("modules.logic.jump.defines.JumpEnum", package.seeall)

local JumpEnum = _M

JumpEnum.JumpStage = {
	Jumping = 1,
	Done = 3,
	None = 0
}
JumpEnum.JumpResult = {
	Fail = 2,
	Success = 1
}
JumpEnum.JumpView = {
	MailView = 25,
	SignInView = 21,
	MainUISwitchInfoViewGiftSet = 203,
	CuriseGuestAct = 10013221,
	RougeMainView = 35,
	TeachNoteView = 16,
	V1a5Dungeon = 1501,
	WeekWalk = 3801,
	InvestigateView = 37,
	HandbookView = 17,
	Achievement = 30,
	PushBox = 102,
	BpView = 52,
	SeasonMainView = 23,
	DungeonViewWithEpisode = 4,
	SummonView = 2,
	PackageStoreGoodsView = 204,
	HeroGroupView = 8,
	DungeonViewWithChapter = 3,
	StoreView = 1,
	StoreSupplementMonthCardUseView = 56,
	StoryHandBook = 173,
	LeiMiTeBeiDungeonView = 101,
	SignInViewWithBirthDay = 22,
	Challenge = 183,
	RoomFishing = 109,
	CommandStationTask = 3001,
	NoticeView = 19,
	SocialView = 18,
	DiceHero = 108,
	EquipView = 51,
	CharacterBackpackViewWithEquip = 7,
	CharacterBackpackViewWithCharacter = 6,
	ShelterBuilding = 2801,
	TaskView = 12,
	Rewind = 53,
	RoleStoryActivity = 31,
	RougeRewardView = 34,
	MainView = 11,
	TowerDeepOperAct = 42350000,
	SummonViewGroup = 24,
	Tower = 107,
	PermanentMainView = 36,
	InvestigateOpinionTabView = 38,
	BackpackUseType = 54,
	Role6Game = 106,
	AssassinLibraryView = 205,
	PlayerClothView = 10,
	BackpackView = 9,
	SkinGiftUseType = 55,
	SurvivalHandbook = 10013106,
	RoomProductLineView = 15,
	Act1_3DungeonView = 103,
	Season123 = 33,
	Role37Game = 105,
	Odyssey = 202,
	WeiCheng = 3401,
	VersionEnterView = 110,
	V1a6Dungeon = 1601,
	Turnback = 104,
	Show = 99,
	ActivityView = 100,
	DungeonViewWithType = 5,
	BossRush = 32,
	RoomView = 13,
	ZhuBi = 3501
}
JumpEnum.CharacterBackpack = {
	Character = 1,
	Equip = 2
}
JumpEnum.DungeonChapterType = {
	WeekWalk = 9,
	Story = 1,
	Explore = 10,
	Gold = 2,
	RoleStory = 19,
	Resource = 3
}
JumpEnum.HandbookType = {
	Story = 3,
	Equip = 2,
	Character = 1,
	CG = 4
}
JumpEnum.JumpId = {
	GlowCharge = 10175,
	Activity173 = 10012236,
	MonthCardPackageView = 610001,
	ChargeView = 10171,
	DecorateStorePay = 10177,
	RoomStoreTabFluff = 10012240,
	RoomStore = 10172
}
JumpEnum.ActIdEnum = {
	Act1_4DungeonStore = 11406,
	Act1_3Act304 = 11304,
	Act1_3Act307 = 11307,
	Act1_5Dungeon = 11502,
	Act106 = 11111,
	Act112 = 11114,
	Act1_3Shop = 11802,
	Act108 = 11102,
	Act107 = 11112,
	Act1_5Shop = 11503,
	Activity104 = 11100,
	Act105 = 11101,
	Role6 = 11403,
	Activity142 = 11508,
	Act111 = 11113,
	Act119 = 11206,
	Act1_5AiZiLa = 11509,
	Act1_5PeaceUlu = 11507,
	Act1_5SportNews = 11510,
	Act109 = 11103,
	Act113 = 11104,
	Act1_3Act305 = 11305,
	EnterView1_2 = 11201,
	Act1_2Dungeon = 11208,
	Act1_3Act125 = 11309,
	EnterView1_3 = 11301,
	Act1_3Dungeon = 11302,
	EnterView1_4 = 11401,
	YaXian = 11203,
	EnterView1_5 = 11501,
	Act114 = 11202,
	Act1_3Act306 = 11306,
	Act117 = 11205,
	Act1_4Dungeon = 11407,
	Role37 = 11402,
	Act1_2Shop = 11207,
	Act1_4Task = 11408,
	V2a4_WuErLiXi = VersionActivity2_4Enum.ActivityId.WuErLiXi,
	V3a0_Reactivity = VersionActivity3_0Enum.ActivityId.Reactivity,
	Act1_6EnterView = VersionActivity1_6Enum.ActivityId.EnterView,
	Act1_6Dungeon = VersionActivity1_6Enum.ActivityId.Dungeon,
	Act1_6DungeonStore = VersionActivity1_6Enum.ActivityId.DungeonStore,
	Act1_6DungeonBossRush = VersionActivity1_6Enum.ActivityId.DungeonBossRush,
	Act1_6Rougue = VersionActivity1_6Enum.ActivityId.Cachot,
	Act1_6QuNiang = VersionActivity1_6Enum.ActivityId.Role1,
	Act1_6GeTian = VersionActivity1_6Enum.ActivityId.Role2,
	Act1_9WarmUp = ActivityEnum.Activity.Activity1_9WarmUp
}
JumpEnum.LeiMiTeBeiSubJumpId = {
	DungeonHardMode = 2,
	LeiMiTeBeiStore = 3,
	DungeonStoryMode = 1
}
JumpEnum.Activity1_2DungeonJump = {
	Jump2Daily = 6,
	Task = 4,
	Hard = 2,
	Shop = 3,
	Jump2Camp = 7,
	Jump2Dungeon = 5,
	Normal = 1
}
JumpEnum.Activity1_3DungeonJump = {
	Daily = 3,
	Hard = 2,
	Buff = 5,
	Astrology = 4,
	Normal = 1
}
JumpEnum.BPChargeView = 610002

return JumpEnum
