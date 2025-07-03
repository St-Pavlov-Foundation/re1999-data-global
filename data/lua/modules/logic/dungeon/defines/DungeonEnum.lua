module("modules.logic.dungeon.defines.DungeonEnum", package.seeall)

local var_0_0 = _M

var_0_0.StarType = {
	Ultra = 3,
	Advanced = 2,
	Normal = 1,
	None = 0
}
var_0_0.EpisodeType = {
	Season166Base = 125,
	WeekWalk_2 = 24,
	RoleStoryChallenge = 16,
	Act1_5Dungeon = 116,
	Act191 = 131,
	SeasonSpecial = 13,
	TowerLimited = 23,
	WeekWalk = 9,
	ToughBattleStory = 19,
	SpecialEquip = 8,
	Act1_3Role1Chess = 111,
	Cachot = 17,
	Act1_4Role6 = 115,
	Season166Teach = 127,
	DreamTailHard = 129,
	Boss = 2,
	TowerBoss = 22,
	Story = 4,
	Act1_6DungeonBoss = 119,
	Sp = 6,
	Explore = 14,
	Season123Retail = 121,
	Jiexika = 104,
	Season123Trial = 122,
	Act1_8Dungeon = 123,
	ToughBattle = 124,
	Act183 = 130,
	Season166Train = 126,
	DreamTailNormal = 128,
	TowerBossTeach = 25,
	TrialHero = 205,
	Act1_3Operation = 112,
	Act1_3Role2Chess = 108,
	SeasonTrial = 15,
	Act1_2Daily = 107,
	TeachNote = 10,
	Season = 11,
	TowerPermanent = 21,
	Act1_3Dungeon = 109,
	Season123 = 120,
	Adventure = 3,
	YaXian = 105,
	Act1_3Daily = 110,
	Normal = 1,
	Daily1_2 = 103,
	Equip = 7,
	Dog = 102,
	RoleTryFight = 18,
	Decrypt = 5,
	Act1_6Dungeon = 118,
	BossRush = 113,
	Meilanni = 101,
	SeasonRetail = 12,
	Rouge = 20
}
var_0_0.ChapterType = {
	Season166Base = 30,
	WeekWalk_2 = 37,
	Newbie = 3,
	RoleActivityFight = 27,
	Exp = 5,
	SeasonSpecial = 17,
	TowerLimited = 36,
	WeekWalk = 9,
	Break = 7,
	SpecialEquip = 8,
	Sp = 10,
	Cachot = 22,
	Gold = 4,
	Season166Teach = 32,
	Season123Retail = 24,
	Simulate = 99,
	TowerBoss = 35,
	Season123Trial = 25,
	LeiMiTeBeiNew = 111,
	TowerPermanent = 34,
	Explore = 14,
	Activity1_2DungeonNormal1 = 121,
	DreamTailNormal = 128,
	RoleActivityStory = 26,
	Activity1_2DungeonNormal2 = 123,
	Buildings = 13,
	Activity1_2DungeonNormal3 = 124,
	YaXian = 126,
	Activity1_2DungeonHard = 122,
	TowerBossTeach = 38,
	BossRushNormal = 141,
	Hard = 2,
	BossRushInfinite = 142,
	Simple = 28,
	Act1_8Dungeon = 181,
	TeachNote = 11,
	Season = 15,
	ToughBattle = 191,
	Season166Train = 31,
	Season123 = 23,
	Act183 = 183,
	RoleStoryChallenge = 21,
	TrialHero = 202,
	Normal = 1,
	DreamTailHard = 129,
	Equip = 6,
	Dog = 116,
	PermanentActivity = 98,
	Act1_6Dungeon = 161,
	Meilanni = 115,
	SeasonRetail = 16,
	RoleStory = 19,
	Rouge = 29
}
var_0_0.ChapterContainEpisodeType = {
	[var_0_0.ChapterType.Normal] = {
		var_0_0.EpisodeType.Normal,
		var_0_0.EpisodeType.Boss,
		var_0_0.EpisodeType.Story,
		var_0_0.EpisodeType.Decrypt
	},
	[var_0_0.ChapterType.Hard] = {
		var_0_0.EpisodeType.Normal
	},
	[var_0_0.ChapterType.Newbie] = {
		var_0_0.EpisodeType.Normal
	},
	[var_0_0.ChapterType.Gold] = {
		var_0_0.EpisodeType.Normal
	},
	[var_0_0.ChapterType.Exp] = {
		var_0_0.EpisodeType.Normal
	},
	[var_0_0.ChapterType.Equip] = {
		var_0_0.EpisodeType.Equip
	},
	[var_0_0.ChapterType.Break] = {
		var_0_0.EpisodeType.Normal
	},
	[var_0_0.ChapterType.SpecialEquip] = {
		var_0_0.EpisodeType.SpecialEquip
	},
	[var_0_0.ChapterType.WeekWalk] = {
		var_0_0.EpisodeType.WeekWalk
	},
	[var_0_0.ChapterType.Sp] = {
		var_0_0.EpisodeType.Sp
	},
	[var_0_0.ChapterType.TeachNote] = {
		var_0_0.EpisodeType.Sp
	},
	[var_0_0.ChapterType.Season] = {
		var_0_0.EpisodeType.Season
	},
	[var_0_0.ChapterType.RoleStoryChallenge] = {
		var_0_0.EpisodeType.RoleStoryChallenge
	}
}
var_0_0.ChapterListType = {
	WeekWalk = 4,
	Story = 1,
	Insight = 3,
	Resource = 2
}
var_0_0.Probability = {
	Flag1 = 1,
	Flag3 = 3,
	Flag2 = 2
}
var_0_0.TagType = {
	FirstPass = 100,
	SecondPass = 101,
	Fix = 1,
	FirstHardPass = 102,
	TurnBack = 103,
	Medium = 6,
	LargeProbability = 2,
	SmallProbability = 9,
	Act = 8,
	Probability = 3,
	Low = 5,
	VerySmallProbability = 4,
	High = 7,
	StoryFirst = 104,
	None = 0
}
var_0_0.RewardProbability = {
	dagailv = var_0_0.TagType.LargeProbability,
	gailv = var_0_0.TagType.Probability,
	xiaogailv = var_0_0.TagType.SmallProbability,
	guding = var_0_0.TagType.Fix,
	jixiaogailv = var_0_0.TagType.VerySmallProbability
}
var_0_0.RewardProbabilityToMaterialProbability = {
	dagailv = MaterialEnum.JumpProbability.Large,
	gailv = MaterialEnum.JumpProbability.Small,
	xiaogailv = MaterialEnum.JumpProbability.Little,
	guding = MaterialEnum.JumpProbability.Must,
	jixiaogailv = MaterialEnum.JumpProbability.VerySmall
}
var_0_0.ChallengeCountLimitType = {
	Daily = 1,
	Monthly = 3,
	Weekly = 2
}
var_0_0.AdditionRuleType = {
	TimeLimit = 3,
	Skill = 1,
	FightSkill = 6,
	AmountLimit = 4,
	Level = 2,
	DeadLimit = 5
}
var_0_0.UnlockContentType = {
	OpenGroup = 3,
	ActivityOpen = 4,
	Episode = 2,
	Open = 1
}
var_0_0.ElementType = {
	EnterDispatch = 501,
	Dispatch = 502,
	Fight = 2,
	Activity1_2Building_Repair = 102,
	Investigate = 19,
	ChangeColor = 10,
	FairyLand = 902,
	Activity1_2Building_Trap = 104,
	FullScreenQuestion = 8,
	EnterDialogue = 18,
	PipeGame = 9,
	Story = 4,
	ToughBattle = 901,
	HeroInvitation = 904,
	UnlockEpisode = 6,
	Activity1_2Note = 107,
	Activity1_2Episode13Unlock = 106,
	UnLockExplore = 17,
	None = 1,
	Question = 5,
	Graffiti = 503,
	Activity1_2Fight = 105,
	SpStory = 2601,
	PuzzleGame = 101,
	Activity1_2Building_Upgrade = 103,
	Task = 3,
	Guidepost = 7,
	ToughBattleBoss = 903,
	OuijaGame = 15,
	PutCubeGame = 13,
	MazeDraw = 12,
	CircuitGame = 14,
	DailyEpisode = 16
}
var_0_0.FragmentType = {
	LeiMiTeBeiNew = 101,
	PlainText = 3,
	OptionsText = 2,
	AvgStory = 2601,
	Normal = 1
}
var_0_0.ElementTypeIconIndex = {
	["20"] = 2,
	["31"] = 5,
	["51"] = 9,
	["30"] = 4,
	["80"] = 10,
	["90"] = 10,
	["81"] = 11,
	["11"] = 1,
	["120"] = 10,
	["50"] = 8,
	["41"] = 7,
	["121"] = 11,
	["21"] = 3,
	["10"] = 0,
	["40"] = 6,
	["91"] = 11
}
var_0_0.ElementTypeUIResIdMap = {
	[var_0_0.ElementType.PipeGame] = var_0_0.ElementType.FullScreenQuestion,
	[var_0_0.ElementType.MazeDraw] = var_0_0.ElementType.FullScreenQuestion,
	[var_0_0.ElementType.PutCubeGame] = var_0_0.ElementType.FullScreenQuestion,
	[var_0_0.ElementType.OuijaGame] = var_0_0.ElementType.FullScreenQuestion,
	[var_0_0.ElementType.CircuitGame] = var_0_0.ElementType.FullScreenQuestion,
	[var_0_0.ElementType.UnLockExplore] = var_0_0.ElementType.FullScreenQuestion,
	[var_0_0.ElementType.Activity1_2Fight] = var_0_0.ElementType.Fight,
	[var_0_0.ElementType.Activity1_2Note] = var_0_0.ElementType.Fight,
	[var_0_0.ElementType.Activity1_2Episode13Unlock] = var_0_0.ElementType.Fight,
	[var_0_0.ElementType.EnterDialogue] = var_0_0.ElementType.None,
	[var_0_0.ElementType.EnterDispatch] = var_0_0.ElementType.None,
	[var_0_0.ElementType.ToughBattle] = var_0_0.ElementType.None,
	[var_0_0.ElementType.FairyLand] = var_0_0.ElementType.None,
	[var_0_0.ElementType.ToughBattleBoss] = var_0_0.ElementType.None,
	[var_0_0.ElementType.HeroInvitation] = var_0_0.ElementType.None
}
var_0_0.EquipDungeonChapterId = 601
var_0_0.ChapterId = {
	ResourceExp = 401,
	ResourceGold = 501,
	InsightBrutes = 704,
	InsightSylvanus = 703,
	Main1_6 = 106,
	InsightStarfall = 702,
	InsightMountain = 701,
	Main1_8 = 108,
	HarvestDungeonChapterId = 1001,
	Main1_7 = 107,
	EquipDungeonChapterId = 601,
	Main1_9 = 109,
	HeroInvitation = 311,
	ToughBattleStory = 19101,
	RoleDuDuGu = 23501
}
var_0_0.SpecialMainPlot = {
	[310] = "p_dungeonchapterminiitem_txt_Special",
	[var_0_0.ChapterId.HeroInvitation] = "dungeonchapterminiitem_txt_NewWorld"
}
var_0_0.ChapterWidth = {
	Special = 270,
	Normal = 415
}
var_0_0.DungeonViewTabEnum = {
	Explore = 2,
	Permanent = 3,
	WeekWalk_2 = 4,
	WeekWalk = 1
}
var_0_0.RefreshTimeAfterShowReward = 0
var_0_0.ShowNewElementsTimeAfterShowReward = 0.7
var_0_0.MoveEpisodeTimeAfterShowReward = 1.5
var_0_0.UpdateLockTimeAfterShowReward = 2.5
var_0_0.dungeonweekwalkviewPath = "ui/viewres/dungeon/dungeonweekwalkview.prefab"
var_0_0.dungeonweekwalk_2viewPath = "ui/viewres/dungeon/dungeonweekwalkdeepview.prefab"
var_0_0.dungeonexploreviewPath = "ui/viewres/explore/exploremainview.prefab"
var_0_0.DefaultTweenMapTime = 0.26
var_0_0.NotPopFragmentToastDict = {
	[5007] = true,
	[5004] = true,
	[5005] = true,
	[5002] = true,
	[5001] = true,
	[5003] = true,
	[5009] = true,
	[5010] = true,
	[5011] = true,
	[5006] = true,
	[5008] = true
}
var_0_0.AssistType = {
	Normal = PickAssistEnum.Type.Normal,
	Season123 = PickAssistEnum.Type.Activity123
}
var_0_0.ElementExEffectPath = {
	[100702] = "scenes/v1a9_m_s08_hddt/vx/prefab/vx_boss_effect1.prefab",
	[100709] = "scenes/v1a9_m_s08_hddt/vx/prefab/vx_boss_effect2.prefab"
}
var_0_0.MapExEffectPath = {
	[10712] = "scenes/v1a9_m_s08_hddt/vx/prefab/vx_boss_effect4.prefab"
}
var_0_0.EpisodeListVisibleSource = {
	ToughBattle = 1,
	Normal = 0
}

return var_0_0
