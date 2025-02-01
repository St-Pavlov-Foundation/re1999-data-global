module("modules.logic.versionactivity2_2.act101.view.VersionActivity2_2RoomSignViewContainer", package.seeall)

slot0 = class("VersionActivity2_2RoomSignViewContainer", Activity101SignViewBaseContainer)

function slot0.onModifyListScrollParam(slot0, slot1)
	slot1.cellClass = VersionActivity2_2RoomSignItem
	slot1.scrollGOPath = "#scroll_ItemList"
	slot1.cellWidth = 476
	slot1.cellHeight = 576
	slot1.cellSpaceH = 30
end

function slot0.onGetMainViewClassType(slot0)
	return VersionActivity2_2RoomSignView
end

function slot0.onBuildViews(slot0)
	return {
		slot0:getMainView()
	}
end

return slot0
