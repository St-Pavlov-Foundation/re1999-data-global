module("modules.logic.dungeon.defines.DungeonEnum", package.seeall)

slot0 = _M
slot0.StarType = {
	Ultra = 3,
	Advanced = 2,
	Normal = 1,
	None = 0
}
slot0.EpisodeType = {
	Season166Base = 125,
	RoleStoryChallenge = 16,
	Boss = 2,
	Act1_5Dungeon = 116,
	SeasonSpecial = 13,
	Act1_3Role1Chess = 111,
	TowerLimited = 23,
	WeekWalk = 9,
	Act1_4Role6 = 115,
	SpecialEquip = 8,
	DreamTailNormal = 128,
	Cachot = 17,
	DreamTailHard = 129,
	Season166Teach = 127,
	Act1_6DungeonBoss = 119,
	Season123Retail = 121,
	TowerBoss = 22,
	Story = 4,
	Season123Trial = 122,
	Sp = 6,
	Explore = 14,
	Act1_8Dungeon = 123,
	Jiexika = 104,
	ToughBattle = 124,
	SeasonTrial = 15,
	Season166Train = 126,
	Act183 = 130,
	TrialHero = 205,
	TowerPermanent = 21,
	ToughBattleStory = 19,
	Act1_3Operation = 112,
	Act1_3Role2Chess = 108,
	Act1_2Daily = 107,
	TeachNote = 10,
	Season = 11,
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
slot0.ChapterType = {
	Season166Base = 30,
	Season123Retail = 24,
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
	Simulate = 99,
	LeiMiTeBeiNew = 111,
	TowerBoss = 35,
	Season123Trial = 25,
	Activity1_2DungeonNormal1 = 121,
	TowerPermanent = 34,
	Explore = 14,
	Activity1_2DungeonHard = 122,
	DreamTailNormal = 128,
	RoleActivityStory = 26,
	Activity1_2DungeonNormal2 = 123,
	Buildings = 13,
	Activity1_2DungeonNormal3 = 124,
	YaXian = 126,
	BossRushNormal = 141,
	BossRushInfinite = 142,
	Act1_8Dungeon = 181,
	Hard = 2,
	ToughBattle = 191,
	Simple = 28,
	Act183 = 183,
	TeachNote = 11,
	Season = 15,
	Season166Train = 31,
	Season123 = 23,
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
slot4 = slot0.EpisodeType.RoleStoryChallenge
slot0.ChapterContainEpisodeType = {
	[slot0.ChapterType.Normal] = {
		slot0.EpisodeType.Normal,
		slot0.EpisodeType.Boss,
		slot0.EpisodeType.Story,
		slot0.EpisodeType.Decrypt
	},
	[slot0.ChapterType.Hard] = {
		slot0.EpisodeType.Normal
	},
	[slot0.ChapterType.Newbie] = {
		slot0.EpisodeType.Normal
	},
	[slot0.ChapterType.Gold] = {
		slot0.EpisodeType.Normal
	},
	[slot0.ChapterType.Exp] = {
		slot0.EpisodeType.Normal
	},
	[slot0.ChapterType.Equip] = {
		slot0.EpisodeType.Equip
	},
	[slot0.ChapterType.Break] = {
		slot0.EpisodeType.Normal
	},
	[slot0.ChapterType.SpecialEquip] = {
		slot0.EpisodeType.SpecialEquip
	},
	[slot0.ChapterType.WeekWalk] = {
		slot0.EpisodeType.WeekWalk
	},
	[slot0.ChapterType.Sp] = {
		slot0.EpisodeType.Sp
	},
	[slot0.ChapterType.TeachNote] = {
		slot0.EpisodeType.Sp
	},
	[slot0.ChapterType.Season] = {
		slot0.EpisodeType.Season
	},
	[slot0.ChapterType.RoleStoryChallenge] = {
		slot4
	}
}
slot0.ChapterListType = {
	WeekWalk = 4,
	Story = 1,
	Insight = 3,
	Resource = 2
}
slot0.Probability = {
	Flag1 = 1,
	Flag3 = 3,
	Flag2 = 2
}
slot0.TagType = {
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
slot0.RewardProbability = {
	dagailv = slot0.TagType.LargeProbability,
	gailv = slot0.TagType.Probability,
	xiaogailv = slot0.TagType.SmallProbability,
	guding = slot0.TagType.Fix,
	jixiaogailv = slot0.TagType.VerySmallProbability
}
slot0.RewardProbabilityToMaterialProbability = {
	dagailv = MaterialEnum.JumpProbability.Large,
	gailv = MaterialEnum.JumpProbability.Small,
	xiaogailv = MaterialEnum.JumpProbability.Little,
	guding = MaterialEnum.JumpProbability.Must,
	jixiaogailv = MaterialEnum.JumpProbability.VerySmall
}
slot0.ChallengeCountLimitType = {
	Daily = 1,
	Monthly = 3,
	Weekly = 2
}
slot0.AdditionRuleType = {
	TimeLimit = 3,
	Skill = 1,
	FightSkill = 6,
	AmountLimit = 4,
	Level = 2,
	DeadLimit = 5
}
slot0.UnlockContentType = {
	OpenGroup = 3,
	ActivityOpen = 4,
	Episode = 2,
	Open = 1
}
slot0.ElementType = {
	EnterDispatch = 501,
	OuijaGame = 15,
	ChangeColor = 10,
	Question = 5,
	Task = 3,
	Investigate = 19,
	Activity1_2Building_Repair = 102,
	Activity1_2Building_Upgrade = 103,
	Fight = 2,
	FullScreenQuestion = 8,
	Activity1_2Building_Trap = 104,
	Activity1_2Fight = 105,
	EnterDialogue = 18,
	UnLockExplore = 17,
	PuzzleGame = 101,
	Dispatch = 502,
	PipeGame = 9,
	Story = 4,
	ToughBattle = 901,
	Guidepost = 7,
	HeroInvitation = 904,
	ToughBattleBoss = 903,
	FairyLand = 902,
	UnlockEpisode = 6,
	Activity1_2Note = 107,
	Activity1_2Episode13Unlock = 106,
	PutCubeGame = 13,
	MazeDraw = 12,
	CircuitGame = 14,
	Graffiti = 503,
	DailyEpisode = 16,
	None = 1
}
slot0.FragmentType = {
	OptionsText = 2,
	LeiMiTeBeiNew = 101,
	PlainText = 3,
	Normal = 1
}
slot0.ElementTypeIconIndex = {
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
slot0.ElementTypeUIResIdMap = {
	[slot0.ElementType.PipeGame] = slot0.ElementType.FullScreenQuestion,
	[slot0.ElementType.MazeDraw] = slot0.ElementType.FullScreenQuestion,
	[slot0.ElementType.PutCubeGame] = slot0.ElementType.FullScreenQuestion,
	[slot0.ElementType.OuijaGame] = slot0.ElementType.FullScreenQuestion,
	[slot0.ElementType.CircuitGame] = slot0.ElementType.FullScreenQuestion,
	[slot0.ElementType.UnLockExplore] = slot0.ElementType.FullScreenQuestion,
	[slot0.ElementType.Activity1_2Fight] = slot0.ElementType.Fight,
	[slot0.ElementType.Activity1_2Note] = slot0.ElementType.Fight,
	[slot0.ElementType.Activity1_2Episode13Unlock] = slot0.ElementType.Fight,
	[slot0.ElementType.EnterDialogue] = slot0.ElementType.None,
	[slot0.ElementType.EnterDispatch] = slot0.ElementType.None,
	[slot0.ElementType.ToughBattle] = slot0.ElementType.None,
	[slot0.ElementType.FairyLand] = slot0.ElementType.None,
	[slot0.ElementType.ToughBattleBoss] = slot0.ElementType.None,
	[slot0.ElementType.HeroInvitation] = slot0.ElementType.None
}
slot0.EquipDungeonChapterId = 601
slot0.ChapterId = {
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
	HeroInvitation = 311,
	RoleDuDuGu = 23501,
	ToughBattleStory = 19101
}
slot0.SpecialMainPlot = {
	[310.0] = "p_dungeonchapterminiitem_txt_Special",
	[slot0.ChapterId.HeroInvitation] = "dungeonchapterminiitem_txt_NewWorld"
}
slot0.ChapterWidth = {
	Special = 270,
	Normal = 415
}
slot0.RefreshTimeAfterShowReward = 0
slot0.ShowNewElementsTimeAfterShowReward = 0.7
slot0.MoveEpisodeTimeAfterShowReward = 1.5
slot0.UpdateLockTimeAfterShowReward = 2.5
slot0.dungeonweekwalkviewPath = "ui/viewres/dungeon/dungeonweekwalkview.prefab"
slot0.dungeonexploreviewPath = "ui/viewres/explore/exploremainview.prefab"
slot0.DefaultTweenMapTime = 0.26
slot0.NotPopFragmentToastDict = {
	[5007.0] = true,
	[5004.0] = true,
	[5005.0] = true,
	[5002.0] = true,
	[5001.0] = true,
	[5003.0] = true,
	[5009.0] = true,
	[5010.0] = true,
	[5011.0] = true,
	[5006.0] = true,
	[5008.0] = true
}
slot0.AssistType = {
	Normal = PickAssistEnum.Type.Normal,
	Season123 = PickAssistEnum.Type.Activity123
}
slot0.MapIdGroupDef = {
	{
		10701,
		10702,
		10703,
		10704,
		10707,
		10708,
		10709,
		10711,
		10712,
		10713,
		10718,
		10719,
		10720,
		10721,
		10722,
		10723,
		10724,
		10727,
		10728
	},
	{
		10705,
		10706,
		10710,
		10714,
		10715,
		10716,
		10717,
		10725,
		10726,
		10729,
		10730
	}
}
slot0.MapIdGroup = {}

for slot4, slot5 in pairs(slot0.MapIdGroupDef) do
	for slot9, slot10 in pairs(slot5) do
		slot0.MapIdGroup[slot10] = slot4
	end
end

slot0.ElementExEffectPath = {
	[100702.0] = "scenes/v1a9_m_s08_hddt/vx/prefab/vx_boss_effect1.prefab",
	[100709.0] = "scenes/v1a9_m_s08_hddt/vx/prefab/vx_boss_effect2.prefab"
}
slot0.MapExEffectPath = {
	[10712.0] = "scenes/v1a9_m_s08_hddt/vx/prefab/vx_boss_effect4.prefab"
}
slot0.EpisodeListVisibleSource = {
	ToughBattle = 1,
	Normal = 0
}

return slot0
