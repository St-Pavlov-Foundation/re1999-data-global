module("modules.logic.versionactivity1_4.act136.view.Activity136ChoiceViewContainer", package.seeall)

slot0 = class("Activity136ChoiceViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "root/#scroll_item"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot2.prefabUrl = slot0._viewSetting.otherRes[1]
	slot2.cellClass = Activity136ChoiceItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 6
	slot2.cellWidth = 200
	slot2.cellHeight = 225
	slot2.cellSpaceH = 30
	slot2.startSpace = 10

	table.insert(slot1, Activity136ChoiceView.New())
	table.insert(slot1, LuaListScrollView.New(Activity136ChoiceViewListModel.instance, slot2))

	return slot1
end

function slot0.onContainerClickModalMask(slot0)
	slot0:closeThis()
end

return slot0
