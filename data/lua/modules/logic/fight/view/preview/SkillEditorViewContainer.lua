module("modules.logic.fight.view.preview.SkillEditorViewContainer", package.seeall)

local var_0_0 = class("SkillEditorViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()

	var_1_0.scrollGOPath = "selectHeros/scroll"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_0.prefabUrl = "selectHeros/scroll/hero"
	var_1_0.cellClass = SkillEditorHeroSelectItem
	var_1_0.scrollDir = ScrollEnum.ScrollDirV
	var_1_0.lineCount = 6
	var_1_0.cellWidth = 220
	var_1_0.cellHeight = 90
	var_1_0.cellSpaceH = 30
	var_1_0.cellSpaceV = 10
	var_1_0.startSpace = 0

	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "selectBuff/scroll"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_1.prefabUrl = "selectBuff/scroll/item"
	var_1_1.cellClass = SkillEditorBuffSelectItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 6
	var_1_1.cellWidth = 220
	var_1_1.cellHeight = 90
	var_1_1.cellSpaceH = 30
	var_1_1.cellSpaceV = 10
	var_1_1.startSpace = 0

	local var_1_2 = ListScrollParam.New()

	var_1_2.scrollGOPath = "selectScene/scroll"
	var_1_2.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_2.prefabUrl = "selectScene/scroll/scene"
	var_1_2.cellClass = SkillEditorSceneSelectItem
	var_1_2.scrollDir = ScrollEnum.ScrollDirV
	var_1_2.lineCount = 6
	var_1_2.cellWidth = 220
	var_1_2.cellHeight = 90
	var_1_2.cellSpaceH = 30
	var_1_2.cellSpaceV = 10
	var_1_2.startSpace = 0

	local var_1_3 = ListScrollParam.New()

	var_1_3.scrollGOPath = "autoPlaySkill/scroll"
	var_1_3.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_3.prefabUrl = "autoPlaySkill/scroll/item"
	var_1_3.cellClass = SkillEditorAutoPlaySkillItem
	var_1_3.scrollDir = ScrollEnum.ScrollDirV
	var_1_3.lineCount = 4
	var_1_3.cellWidth = 240
	var_1_3.cellHeight = 100
	var_1_3.cellSpaceH = 10
	var_1_3.cellSpaceV = 10
	var_1_3.startSpace = 0

	local var_1_4 = ListScrollParam.New()

	var_1_4.scrollGOPath = "autoPlaySkill/selectScroll"
	var_1_4.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_4.prefabUrl = "autoPlaySkill/selectScroll/item"
	var_1_4.cellClass = SkillEditorAutoPlaySkillSelectItem
	var_1_4.scrollDir = ScrollEnum.ScrollDirV
	var_1_4.lineCount = 4
	var_1_4.cellWidth = 240
	var_1_4.cellHeight = 100
	var_1_4.cellSpaceH = 10
	var_1_4.cellSpaceV = 10
	var_1_4.startSpace = 0
	arg_1_0.leftSkillEditorSideView = SkillEditorSideView.New(FightEnum.EntitySide.EnemySide)
	arg_1_0.rightSkillEditorSideView = SkillEditorSideView.New(FightEnum.EntitySide.MySide)

	return {
		SkillEditorSkillSelectTargetView.New(FightEnum.EntitySide.MySide),
		SkillEditorSkillSelectTargetView.New(FightEnum.EntitySide.EnemySide),
		arg_1_0.leftSkillEditorSideView,
		arg_1_0.rightSkillEditorSideView,
		SkillEditorView.New(),
		SkillEditorSceneSelectView.New(),
		SkillEditorHeroSelectView.New(),
		SkillEditorBuffSelectView.New(),
		SkillEditorActionSelectView.New(),
		FightViewSkillFrame.New(true),
		LuaListScrollView.New(SkillEditorHeroSelectModel.instance, var_1_0),
		LuaListScrollView.New(SkillEditorBuffSelectModel.instance, var_1_1),
		LuaListScrollView.New(SkillEditorSceneSelectModel.instance, var_1_2),
		LuaListScrollView.New(SkillEditorToolAutoPlaySkillModel.instance, var_1_3),
		LuaListScrollView.New(SkillEditorToolAutoPlaySkillSelectModel.instance, var_1_4),
		SkillEditorStanceSelectView.New(),
		SkillEditorCharacterSkinSelectView.New(),
		SkillEditorMulSkillView.New(),
		SkillEditorToolsAutoPlaySkillView.New()
	}
end

return var_0_0
