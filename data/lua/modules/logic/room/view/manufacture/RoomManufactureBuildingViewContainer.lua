module("modules.logic.room.view.manufacture.RoomManufactureBuildingViewContainer", package.seeall)

slot0 = class("RoomManufactureBuildingViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoomManufactureBuildingView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_BackBtns"))
	table.insert(slot1, TabViewGroup.New(2, "go_detailBanner"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		}, nil, slot0._closeCallback, nil, , slot0)

		return {
			slot0.navigateView
		}
	elseif slot1 == 2 then
		slot0.detailBanner = RoomManufactureBuildingDetailBanner.New()

		return {
			slot0.detailBanner
		}
	end
end

function slot0._closeCallback(slot0)
	ManufactureController.instance:resetCameraOnCloseView()
end

function slot0.onContainerInit(slot0)
	slot0:setContainerViewBuildingUid()
end

function slot0.onContainerClose(slot0)
	slot0:setContainerViewBuildingUid()
end

function slot0.setContainerViewBuildingUid(slot0, slot1)
	slot0._viewBuildingUid = slot1
end

function slot0.getContainerViewBuilding(slot0, slot1)
	if not RoomMapBuildingModel.instance:getBuildingMOById(slot0._viewBuildingUid) and slot1 then
		logError(string.format("RoomManufactureBuildingViewContainer:getContainerViewBuilding error, buildingMO is nil, uid:%s", slot0._viewBuildingUid))
	end

	return slot0._viewBuildingUid, slot2
end

return slot0
