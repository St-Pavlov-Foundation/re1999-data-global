module("modules.logic.sp01.odyssey.define.OdysseyEnum", package.seeall)

local var_0_0 = _M

var_0_0.SceneRootName = "OdysseyDungeonScene"
var_0_0.DungeonMapCameraSize = 5
var_0_0.DungeonMapLightUrl = "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_light.prefab"
var_0_0.DungeonMainElement = 1
var_0_0.DungeonElementNeedFollow = 1
var_0_0.ElementOptionNotFinish = 1
var_0_0.NotOpenInteractWithGuideId = 130516
var_0_0.IconFrameType = {
	Gold = 1,
	Silver = 2,
	None = 0
}
var_0_0.ElementType = {
	Fight = 3,
	Dialog = 2,
	Option = 1
}
var_0_0.ElementTypeRoot = {
	[var_0_0.ElementType.Dialog] = "dialog",
	[var_0_0.ElementType.Option] = "option",
	[var_0_0.ElementType.Fight] = "fight"
}
var_0_0.ElementAnimName = {
	Tips = "tips",
	Close = "close",
	Idle = "idle",
	Select = "select",
	Open = "open"
}
var_0_0.ConditionType = {
	FinishOption = "finishOption",
	Time = "time",
	Item = "item",
	TalentType = "talentType",
	Finish = "finish",
	Level = "level",
	TalentNode = "talentNode",
	Empty = ""
}
var_0_0.FightType = {
	Conquer = 5,
	Myth = 6,
	Elite = 2,
	Religion = 4,
	Mercenary = 3,
	Normal = 1
}
var_0_0.RecommendOffset = -30
var_0_0.CurrentOffset = -20
var_0_0.ConstId = {
	MercenaryInitNum = 4,
	MainHeroEquipCount = 9,
	MercenaryLimitedNum = 5,
	EpicMercenarySuit = 14,
	MapSelectUrl = 17,
	NormalHeroEquipCount = 10,
	ReligionUnlock = 31,
	NormalMercenarySuit = 12,
	RareMercenarySuit = 13,
	ExpItemRare = 28,
	TrialHeroId = 2,
	TalentUnlockLevel = 30,
	MapSelectPos = 18,
	MainHeroId = 11,
	TalentItemRare = 29,
	MercenaryRecoverSpeed = 6,
	MercenaryUnlock = 3
}
var_0_0.MercenaryType = {
	Epic = 3,
	Rare = 2,
	Normal = 1
}
var_0_0.MercenaryTypeToSuit = {
	[var_0_0.MercenaryType.Normal] = var_0_0.ConstId.NormalMercenarySuit,
	[var_0_0.MercenaryType.Rare] = var_0_0.ConstId.RareMercenarySuit,
	[var_0_0.MercenaryType.Epic] = var_0_0.ConstId.EpicMercenarySuit
}
var_0_0.MythRecord = {
	[0] = "",
	"B",
	"A",
	"S"
}
var_0_0.FightElementTag = {
	Conquest = 7,
	NormalFight = 1,
	EpicMercenary = 5,
	NormalMercenary = 3,
	Religion = 6,
	RareMercenary = 4,
	EliteFight = 2,
	Myth = 8
}
var_0_0.FightElementTagLang = {
	[var_0_0.FightType.Normal] = {
		[0] = "odyssey_tag_fight"
	},
	[var_0_0.FightType.Elite] = {
		[0] = "odyssey_tag_fight_elite"
	},
	[var_0_0.FightType.Mercenary] = {
		"odyssey_tag_mercenary_normal",
		"odyssey_tag_mercenary_rare",
		"odyssey_tag_mercenary_epic"
	},
	[var_0_0.FightType.Religion] = {
		[0] = "odyssey_tag_religion"
	},
	[var_0_0.FightType.Conquer] = {
		[0] = "odyssey_tag_conquest"
	},
	[var_0_0.FightType.Myth] = {
		[0] = "odyssey_tag_myth"
	}
}
var_0_0.FightElementTagIcon = {
	[var_0_0.FightType.Normal] = "odyssey_map_event_fight_6",
	[var_0_0.FightType.Elite] = "odyssey_map_event_fight_5",
	[var_0_0.FightType.Mercenary] = "odyssey_map_event_fight_2",
	[var_0_0.FightType.Religion] = "odyssey_map_event_fight_3",
	[var_0_0.FightType.Conquer] = "odyssey_map_event_fight_1",
	[var_0_0.FightType.Myth] = "odyssey_map_event_fight_4"
}
var_0_0.FightElementEnemyIcon = {
	[var_0_0.FightType.Normal] = "odyssey_map_level6",
	[var_0_0.FightType.Elite] = "odyssey_map_level3",
	[var_0_0.FightType.Mercenary] = "odyssey_map_level2",
	[var_0_0.FightType.Religion] = "odyssey_map_level4",
	[var_0_0.FightType.Conquer] = "odyssey_map_level3",
	[var_0_0.FightType.Myth] = "odyssey_map_level5"
}
var_0_0.EquipTypeLang = {
	"odyssey_equip_normal",
	"odyssey_equip_rare",
	"odyssey_equip_epic",
	"odyssey_equip_legend"
}
var_0_0.EquipRareColor = {
	"#59B388",
	"#80C2F0",
	"#FE8EFF",
	"#FFE490"
}
var_0_0.BlockKey = {
	LoadingMapEffect = "OdysseyDungeonLoadingMapEffect",
	FocusNewElement = "OdysseyDungeonFocusNewElement"
}
var_0_0.LocalSaveKey = {
	MythNew = "OdysseyMythNew",
	MapNew = "OdysseyMapNew",
	ReligionClue = "OdysseyReligionClue",
	FightLevelSuppress = "OdysseyFightElementLevelSuppress"
}
var_0_0.ElementStatus = {
	Finish = 1,
	Normal = 0
}
var_0_0.DungeonUISideType = {
	Bottom = 1,
	Right = 2
}
var_0_0.ItemType = {
	Item = 1,
	Equip = 2
}
var_0_0.RewardItemType = {
	Exp = "exp",
	Talent = "talent",
	Item = "item",
	OuterItem = "OuterItem"
}
var_0_0.OuterItemRareColor = {
	1,
	1,
	2,
	3,
	4,
	4
}
var_0_0.TalentType = {
	Worrior = 2,
	Hunter = 1,
	Assassin = 3
}
var_0_0.TalentUnlockCondition = {
	TalentNode = "talentNode",
	TalentType = "talentType"
}
var_0_0.MemberStatus = {
	Dead = 2,
	Expose = 1
}
var_0_0.Reason = {
	MapUpdateExplore = 202,
	MapElementCreate = 203,
	TalentLevelUp = 401,
	CommonFightReward = 601,
	TalentNodeReset = 402,
	ReligionFightReward = 602,
	MapElementFinish = 204,
	ConquestFightReward = 604,
	MapUnlock = 201,
	MercenaryFightReward = 603,
	TalentAllReset = 403,
	LevelUp = 102,
	MythicFightReward = 605,
	ElementOptionReward = 205,
	GM = 101
}
var_0_0.GetItemPushReason = {
	[var_0_0.Reason.GM] = true,
	[var_0_0.Reason.LevelUp] = true,
	[var_0_0.Reason.ElementOptionReward] = true,
	[var_0_0.Reason.CommonFightReward] = true,
	[var_0_0.Reason.ReligionFightReward] = true,
	[var_0_0.Reason.MercenaryFightReward] = true,
	[var_0_0.Reason.ConquestFightReward] = true,
	[var_0_0.Reason.MythicFightReward] = true
}
var_0_0.HeroGroupType = {
	Fight = 2,
	Prepare = 1
}
var_0_0.MaxHeroGroupCount = 5
var_0_0.TaskGroupType = {
	Fight = 3000,
	Collect = 4000,
	Story = 2000,
	LevelReward = 1000,
	Myth = 5000
}
var_0_0.NormalTaskGroupType = {
	[var_0_0.TaskGroupType.Story] = 1,
	[var_0_0.TaskGroupType.Fight] = 2,
	[var_0_0.TaskGroupType.Collect] = 3,
	[var_0_0.TaskGroupType.Myth] = 4
}
var_0_0.NormalTaskGroupTypeLang = {
	[var_0_0.TaskGroupType.Story] = "odyssey_task_tab_1",
	[var_0_0.TaskGroupType.Fight] = "odyssey_task_tab_2",
	[var_0_0.TaskGroupType.Collect] = "odyssey_task_tab_3",
	[var_0_0.TaskGroupType.Myth] = "odyssey_task_tab_4"
}
var_0_0.TaskType = {
	LevelReward = 1,
	NormalTask = 2
}
var_0_0.RareToConst = {
	24,
	25,
	26,
	27
}
var_0_0.BagType = {
	FightPrepare = 1,
	Bag = 2,
	OnlyDisplay = 3
}
var_0_0.TaskBigRewardType = 0
var_0_0.Result = {
	Win = 1,
	Lose = 0
}
var_0_0.JumpType = {
	JumpToLibrary = 7,
	JumpToHeroPos = 3,
	JumpToReligion = 4,
	JumpToMyth = 5,
	JumpToElementAndOpen = 2,
	JumpToLevelReward = 6,
	JumpToMainElement = 1
}
var_0_0.SuitDescColor = {
	Active = "#B8B3A2"
}
var_0_0.ResultRewardType = {
	Exp = 2,
	Talent = 3,
	Item = 1
}
var_0_0.EquipOptionType = {
	Unload = 2,
	Equip = 1,
	Replace = 3
}
var_0_0.EquipSuitType = {
	All = 1,
	SingleType = 2
}
var_0_0.HeroGroupSaveType = {
	ItemUnload = 3,
	FormUpdate = 4,
	ItemReplace = 2,
	ItemEquip = 1
}
var_0_0.EquipDefaultIndex = 1

return var_0_0
