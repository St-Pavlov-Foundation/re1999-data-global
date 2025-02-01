module("modules.logic.login.view.ServerListViewContainer", package.seeall)

slot0 = class("ServerListViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "serverlist"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot2.prefabUrl = slot0._viewSetting.otherRes[1]
	slot2.cellClass = ServerListItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 2
	slot2.cellWidth = 400
	slot2.cellHeight = 60
	slot2.cellSpaceH = 50
	slot2.cellSpaceV = 40

	table.insert(slot1, LuaListScrollView.New(ServerListModel.instance, slot2))
	table.insert(slot1, ServerListView.New())

	return slot1
end

function slot0.onContainerClickModalMask(slot0)
	slot0:closeThis()
end

return slot0
