module("modules.logic.reactivity.view.ReactivityRuleViewContainer", package.seeall)

slot0 = class("ReactivityRuleViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "object/#scroll_rule"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromView
	slot2.prefabUrl = "object/#scroll_rule/Viewport/Content/#ruleitem"
	slot2.cellClass = ReactivityRuleItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 3
	slot2.cellWidth = 490
	slot2.cellHeight = 172
	slot2.cellSpaceH = 0
	slot2.cellSpaceV = 0
	slot2.startSpace = 10

	table.insert(slot1, LuaListScrollView.New(ReactivityRuleModel.instance, slot2))
	table.insert(slot1, ReactivityRuleView.New())

	return slot1
end

function slot0.onContainerClickModalMask(slot0)
	slot0:closeThis()
end

return slot0
