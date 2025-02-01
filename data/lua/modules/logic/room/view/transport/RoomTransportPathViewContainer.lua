module("modules.logic.room.view.transport.RoomTransportPathViewContainer", package.seeall)

slot0 = class("RoomTransportPathViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoomTransportPathView.New())
	table.insert(slot1, TabViewGroup.New(2, "#go_righttop/#go_tabfailtips"))
	table.insert(slot1, RoomTransportPathViewUI.New())
	table.insert(slot1, RoomTransportPathViewUI.New())

	if RoomTransportPathQuickLinkViewUI._IsShow_ == true and GameResMgr.IsFromEditorDir then
		table.insert(slot1, RoomTransportPathQuickLinkViewUI.New())
	end

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigationView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			slot0.navigationView
		}
	elseif slot1 == 2 then
		return {
			RoomTransportPathFailTips.New()
		}
	end
end

return slot0
