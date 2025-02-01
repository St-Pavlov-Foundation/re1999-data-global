module("modules.logic.fight.view.preview.SkillEditorViewContainer", package.seeall)

slot0 = class("SkillEditorViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "selectHeros/scroll"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromView
	slot1.prefabUrl = "selectHeros/scroll/hero"
	slot1.cellClass = SkillEditorHeroSelectItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 6
	slot1.cellWidth = 220
	slot1.cellHeight = 90
	slot1.cellSpaceH = 30
	slot1.cellSpaceV = 10
	slot1.startSpace = 0
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "selectBuff/scroll"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromView
	slot2.prefabUrl = "selectBuff/scroll/item"
	slot2.cellClass = SkillEditorBuffSelectItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 6
	slot2.cellWidth = 220
	slot2.cellHeight = 90
	slot2.cellSpaceH = 30
	slot2.cellSpaceV = 10
	slot2.startSpace = 0
	slot3 = ListScrollParam.New()
	slot3.scrollGOPath = "selectScene/scroll"
	slot3.prefabType = ScrollEnum.ScrollPrefabFromView
	slot3.prefabUrl = "selectScene/scroll/scene"
	slot3.cellClass = SkillEditorSceneSelectItem
	slot3.scrollDir = ScrollEnum.ScrollDirV
	slot3.lineCount = 6
	slot3.cellWidth = 220
	slot3.cellHeight = 90
	slot3.cellSpaceH = 30
	slot3.cellSpaceV = 10
	slot3.startSpace = 0
	slot4 = ListScrollParam.New()
	slot4.scrollGOPath = "autoPlaySkill/scroll"
	slot4.prefabType = ScrollEnum.ScrollPrefabFromView
	slot4.prefabUrl = "autoPlaySkill/scroll/item"
	slot4.cellClass = SkillEditorAutoPlaySkillItem
	slot4.scrollDir = ScrollEnum.ScrollDirV
	slot4.lineCount = 4
	slot4.cellWidth = 240
	slot4.cellHeight = 100
	slot4.cellSpaceH = 10
	slot4.cellSpaceV = 10
	slot4.startSpace = 0
	slot5 = ListScrollParam.New()
	slot5.scrollGOPath = "autoPlaySkill/selectScroll"
	slot5.prefabType = ScrollEnum.ScrollPrefabFromView
	slot5.prefabUrl = "autoPlaySkill/selectScroll/item"
	slot5.cellClass = SkillEditorAutoPlaySkillSelectItem
	slot5.scrollDir = ScrollEnum.ScrollDirV
	slot5.lineCount = 4
	slot5.cellWidth = 240
	slot5.cellHeight = 100
	slot5.cellSpaceH = 10
	slot5.cellSpaceV = 10
	slot5.startSpace = 0
	slot0.leftSkillEditorSideView = SkillEditorSideView.New(FightEnum.EntitySide.EnemySide)
	slot0.rightSkillEditorSideView = SkillEditorSideView.New(FightEnum.EntitySide.MySide)

	return {
		SkillEditorSkillSelectTargetView.New(FightEnum.EntitySide.MySide),
		SkillEditorSkillSelectTargetView.New(FightEnum.EntitySide.EnemySide),
		slot0.leftSkillEditorSideView,
		slot0.rightSkillEditorSideView,
		SkillEditorView.New(),
		SkillEditorSceneSelectView.New(),
		SkillEditorHeroSelectView.New(),
		SkillEditorBuffSelectView.New(),
		SkillEditorActionSelectView.New(),
		FightViewSkillFrame.New(true),
		LuaListScrollView.New(SkillEditorHeroSelectModel.instance, slot1),
		LuaListScrollView.New(SkillEditorBuffSelectModel.instance, slot2),
		LuaListScrollView.New(SkillEditorSceneSelectModel.instance, slot3),
		LuaListScrollView.New(SkillEditorToolAutoPlaySkillModel.instance, slot4),
		LuaListScrollView.New(SkillEditorToolAutoPlaySkillSelectModel.instance, slot5),
		SkillEditorStanceSelectView.New(),
		SkillEditorCharacterSkinSelectView.New(),
		SkillEditorMulSkillView.New(),
		SkillEditorToolsAutoPlaySkillView.New()
	}
end

return slot0
