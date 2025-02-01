module("modules.logic.room.view.manufacture.RoomOverViewContainer", package.seeall)

slot0 = class("RoomOverViewContainer", BaseViewContainer)
slot1 = {
	Navigate = 1,
	SubView = 2
}
slot0.SubViewTabId = {
	Manufacture = 1,
	Transport = 2
}

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoomOverView.New())
	table.insert(slot1, TabViewGroup.New(uv0.Navigate, "#go_BackBtns"))
	table.insert(slot1, TabViewGroup.New(uv0.SubView, "#go_subView"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == uv0.Navigate then
		slot0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			slot0.navigateView
		}
	elseif slot1 == uv0.SubView then
		return {
			RoomManufactureOverView.New(),
			RoomTransportOverView.New()
		}
	end
end

function slot0.onContainerInit(slot0)
	if not slot0.viewParam then
		return
	end

	slot0.viewParam.defaultTabIds = {
		[uv0.SubView] = slot0:getDefaultSelectedTab()
	}

	slot0:setContainerViewBuildingUid()
end

function slot0.getDefaultSelectedTab(slot0)
	slot1 = uv0.SubViewTabId.Manufacture

	if slot0:checkTabId(slot0.viewParam and slot0.viewParam.defaultTab) then
		slot1 = slot2
	end

	return slot1
end

function slot0.checkTabId(slot0, slot1)
	slot2 = false

	if slot1 then
		for slot6, slot7 in pairs(RoomCritterBuildingViewContainer.SubViewTabId) do
			if slot7 == slot1 then
				slot2 = true

				break
			end
		end
	end

	return slot2
end

function slot0.switchTab(slot0, slot1)
	if not slot0:checkTabId(slot1) then
		return
	end

	slot0:dispatchEvent(ViewEvent.ToSwitchTab, uv0.SubView, slot1)
end

function slot0.setContainerViewBuildingUid(slot0, slot1)
	slot0._viewBuildingUid = slot1
end

function slot0.getContainerViewBuilding(slot0, slot1)
	if not RoomMapBuildingModel.instance:getBuildingMOById(slot0._viewBuildingUid) and slot1 then
		logError(string.format("RoomOverViewContainer:getContainerViewBuilding error, buildingMO is nil, uid:%s", slot0._viewBuildingUid))
	end

	return slot0._viewBuildingUid, slot2
end

function slot0.onContainerClose(slot0)
	slot0:setContainerViewBuildingUid()
end

return slot0
