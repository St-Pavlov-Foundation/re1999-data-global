module("modules.logic.fight.view.preview.SkillEffectStatViewContainer", package.seeall)

slot0 = class("SkillEffectStatViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "view/scroll"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromView
	slot2.prefabUrl = "view/scroll/item"
	slot2.cellClass = SkillEffectStatItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 1
	slot2.cellWidth = 744
	slot2.cellHeight = 45
	slot2.cellSpaceH = 0
	slot2.cellSpaceV = 0

	table.insert(slot1, LuaListScrollView.New(SkillEffectStatModel.instance, slot2))
	table.insert(slot1, SkillEffectStatView.New())
	table.insert(slot1, ToggleListView.New(1, "view/toggles"))

	return slot1
end

function slot0.onContainerInit(slot0)
	slot0:registerCallback(ViewEvent.ToSwitchTab, slot0._toSwitchTab, slot0)
end

function slot0.onContainerDestroy(slot0)
	slot0:unregisterCallback(ViewEvent.ToSwitchTab, slot0._toSwitchTab, slot0)
end

function slot0._toSwitchTab(slot0, slot1, slot2)
	SkillEffectStatModel.instance:switchTab(slot2)
end

return slot0
