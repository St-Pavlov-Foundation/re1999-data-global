-- chunkname: @modules/logic/rouge2/common/define/Rouge2_Enum.lua

module("modules.logic.rouge2.common.define.Rouge2_Enum", package.seeall)

local Rouge2_Enum = _M

Rouge2_Enum.ResPath = {
	CoinView = "ui/viewres/rouge2/map/rouge2_mapcoinview.prefab",
	AttributeMap = "ui/viewres/rouge2/rouge2_careerattributemap.prefab",
	ChoiceCheckItem = "ui/viewres/rouge2/map/rouge2_mapchoicecheckitem.prefab",
	AttrToolBar = "ui/viewres/rouge2/rouge2_attributetoolbar.prefab",
	ItemDescModeSwitcher = "ui/viewres/rouge2/backpack/rouge2_itemdescmodeswitcher.prefab",
	MapChoiceItem = "ui/viewres/rouge2/map/rouge2_mapchoiceitem.prefab",
	ComBuffItem = "ui/viewres/rouge2/backpack/rouge2_commonbuffitem.prefab",
	MapExploreChoiceItem = "ui/viewres/rouge2/map/rouge2_mapexplorechoiceitem.prefab",
	ComRelicsItem = "ui/viewres/rouge2/backpack/rouge2_commonrelicsitem.prefab",
	BackpackFormulaItem = "ui/viewres/rouge2/backpack/rouge2_backpackformulaitem.prefab",
	AttrSplitToolbar = "ui/viewres/rouge2/backpack/rouge2_attrsplittoolbar.prefab",
	BuffDropItem = "ui/viewres/rouge2/map/rouge2_buffdropitem.prefab",
	DifficultyItem = "ui/viewres/rouge2/rouge2_difficultyitem.prefab"
}
Rouge2_Enum.State = {
	Difficulty = 1,
	isEnd = 3,
	Start = 2,
	Empty = 0
}
Rouge2_Enum.TweenFocusDifficultyDuration = 0.2
Rouge2_Enum.DifficultyPageNum = 2
Rouge2_Enum.TweenSwitchPageDuration = 1
Rouge2_Enum.MinSwitchPageOffset = 100
Rouge2_Enum.BackpackTabContainerId = 2
Rouge2_Enum.MaxActiveSkillNum = 3
Rouge2_Enum.EmptyActiveSkill = 0
Rouge2_Enum.BackpackSkillSortType = {
	AssembleCost = 2,
	GetTime = 1
}
Rouge2_Enum.BackpackBuffType = 0
Rouge2_Enum.SkillTipsUsage = {
	Default = 1,
	BackpackEditView_Right = 3,
	BackpackEditView_Left = 2
}
Rouge2_Enum.SkillTipsPos = {
	BackpackSkillEdit1 = Vector2(-340, -7),
	BackpackSkillEdit2 = Vector2(-340, -7)
}
Rouge2_Enum.AttributeData = {
	Server = 2,
	Config = 1,
	Custom = 3
}
Rouge2_Enum.OutSideConstId = {
	TalentPointMaxCount = 103,
	CollectRotateParam = 121,
	AlchemySubMaterialCount = 115,
	SettleScoreIcon = 116,
	StoreFinalReward = 107,
	TalentPointId = 102
}
Rouge2_Enum.RewardGroupConstIdOffset = 116
Rouge2_Enum.ConstId = {
	AchievementJumpId = 51,
	DifficultyIndexDuration = 11,
	DifficultyIndexCount = 12
}
Rouge2_Enum.AttrMapUsage = {
	MapAttributeUpView = 3,
	BackpackCareerView = 2,
	CareerSelectView = 1
}
Rouge2_Enum.BagType = {
	Relics = 1,
	ActiveSkill = 4,
	InVisibleRelics = 2,
	Buff = 3
}
Rouge2_Enum.ItemType2DescHelper = {
	[Rouge2_Enum.BagType.Relics] = Rouge2_RelicsDescHelper,
	[Rouge2_Enum.BagType.InVisibleRelics] = Rouge2_BuffDescHelper,
	[Rouge2_Enum.BagType.Buff] = Rouge2_BuffDescHelper,
	[Rouge2_Enum.BagType.ActiveSkill] = Rouge2_ActiveSkillDescHelper
}
Rouge2_Enum.ItemDataType = {
	Server = 1,
	Unknow = 0,
	Clone = 3,
	Config = 2
}
Rouge2_Enum.ItemFilterType = {
	Attribute = 6,
	GreaterAndEqualRare = 4,
	GreaterRare = 3,
	EqualRare = 5,
	Unique = 7,
	Remove = 8,
	LessRare = 1,
	LessAndEqualRare = 2
}
Rouge2_Enum.ItemDescMode = {
	Simply = 1,
	Full = 2
}
Rouge2_Enum.ItemExpressionData = {
	LeaderAttr = 2,
	ItemAttr = 1
}
Rouge2_Enum.ItemDescModeDataKey = {
	BuffAbandon = 4,
	BuffDrop = 3,
	RelicsDrop = 1,
	RelicsAbandon = 2
}
Rouge2_Enum.ItemStatus = {
	New = 1,
	Old = 0,
	SecNew = 2
}
Rouge2_Enum.RelicsDescType = {
	NarrativeDescOutside = 5,
	LevelUp = 4,
	NarrativeDesc = 3,
	UnlockDesc = 2,
	Desc = 1
}
Rouge2_Enum.RelicsDescShowType = {
	DescWithCondition = 2,
	OnlyDesc = 1,
	SplitLineAndDesc = 3,
	LevelUp = 4
}
Rouge2_Enum.RelicsDescType2ShowType = {
	[Rouge2_Enum.RelicsDescType.Desc] = Rouge2_Enum.RelicsDescShowType.OnlyDesc,
	[Rouge2_Enum.RelicsDescType.UnlockDesc] = Rouge2_Enum.RelicsDescShowType.DescWithCondition,
	[Rouge2_Enum.RelicsDescType.NarrativeDesc] = Rouge2_Enum.RelicsDescShowType.SplitLineAndDesc,
	[Rouge2_Enum.RelicsDescType.LevelUp] = Rouge2_Enum.RelicsDescShowType.LevelUp,
	[Rouge2_Enum.RelicsDescType.NarrativeDescOutside] = Rouge2_Enum.RelicsDescShowType.OnlyDesc
}
Rouge2_Enum.RelicsDescParam = {
	LevelUp = "levelup",
	isTrigger = "isTrigger",
	Condition = "condition",
	Desc = "desc"
}
Rouge2_Enum.TalentType = {
	Common = 0
}
Rouge2_Enum.SkillEditItemLongPressTime = 0.5
Rouge2_Enum.BagItemTabId_All = 0
Rouge2_Enum.BagTabType = {
	Relics = 3,
	ActiveSkill = 2,
	Career = 1,
	Buff = 4
}
Rouge2_Enum.BagTabTypeNameLangId = {
	[Rouge2_Enum.BagTabType.Career] = "rouge2_backpacktabview_career",
	[Rouge2_Enum.BagTabType.ActiveSkill] = "rouge2_backpacktabview_skill",
	[Rouge2_Enum.BagTabType.Relics] = "rouge2_backpacktabview_relics",
	[Rouge2_Enum.BagTabType.Buff] = "rouge2_backpacktabview_buff"
}
Rouge2_Enum.BagTabTypeNameEn = {
	[Rouge2_Enum.BagTabType.Career] = "Character Profile",
	[Rouge2_Enum.BagTabType.ActiveSkill] = "Resonator",
	[Rouge2_Enum.BagTabType.Relics] = "Artefacts",
	[Rouge2_Enum.BagTabType.Buff] = "Harmonic"
}
Rouge2_Enum.AttributeToolType = {
	Default = 1,
	Enter_Attr_Detail = 3,
	Enter_Attr = 2,
	Attr_Detail = 4,
	Enter = 5
}
Rouge2_Enum.AttrIconSuffix = {
	Big = "_1",
	Tag = "_4",
	Circle = "_3",
	Small = "_2"
}
Rouge2_Enum.CareerIconSuffix = {
	Bag = "_1",
	Tab = "_2"
}
Rouge2_Enum.ItemRareIconType = {
	Default = 0,
	Bg = 1,
	NameBg = 2,
	TagBg = 3
}
Rouge2_Enum.BagTabType2Reddot = {
	[Rouge2_Enum.BagTabType.ActiveSkill] = RedDotEnum.DotNode.Rouge2ActiveSkillTab,
	[Rouge2_Enum.BagTabType.Relics] = RedDotEnum.DotNode.Rouge2RelicsTab,
	[Rouge2_Enum.BagTabType.Buff] = RedDotEnum.DotNode.Rouge2BuffTab
}
Rouge2_Enum.ItemType2Reddot = {
	[Rouge2_Enum.BagType.ActiveSkill] = Rouge2_Enum.BagTabType2Reddot[Rouge2_Enum.BagTabType.ActiveSkill],
	[Rouge2_Enum.BagType.Relics] = Rouge2_Enum.BagTabType2Reddot[Rouge2_Enum.BagTabType.Relics],
	[Rouge2_Enum.BagType.Buff] = Rouge2_Enum.BagTabType2Reddot[Rouge2_Enum.BagTabType.Buff]
}
Rouge2_Enum.AttrSplitToolbarEventFlag = {
	Relics = 1,
	AbandonBuff = 4,
	Buff = 2,
	AbandonRelics = 3
}
Rouge2_Enum.BXSCareerId = 1
Rouge2_Enum.GuideView = {
	ActivityView = 1
}

return Rouge2_Enum
