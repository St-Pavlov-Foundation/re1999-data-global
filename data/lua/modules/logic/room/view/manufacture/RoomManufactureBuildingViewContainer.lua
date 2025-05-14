module("modules.logic.room.view.manufacture.RoomManufactureBuildingViewContainer", package.seeall)

local var_0_0 = class("RoomManufactureBuildingViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, RoomManufactureBuildingView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_BackBtns"))
	table.insert(var_1_0, TabViewGroup.New(2, "go_detailBanner"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		}, nil, arg_2_0._closeCallback, nil, nil, arg_2_0)

		return {
			arg_2_0.navigateView
		}
	elseif arg_2_1 == 2 then
		arg_2_0.detailBanner = RoomManufactureBuildingDetailBanner.New()

		return {
			arg_2_0.detailBanner
		}
	end
end

function var_0_0._closeCallback(arg_3_0)
	ManufactureController.instance:resetCameraOnCloseView()
end

function var_0_0.onContainerInit(arg_4_0)
	arg_4_0:setContainerViewBuildingUid()
end

function var_0_0.onContainerClose(arg_5_0)
	arg_5_0:setContainerViewBuildingUid()
end

function var_0_0.setContainerViewBuildingUid(arg_6_0, arg_6_1)
	arg_6_0._viewBuildingUid = arg_6_1
end

function var_0_0.getContainerViewBuilding(arg_7_0, arg_7_1)
	local var_7_0 = RoomMapBuildingModel.instance:getBuildingMOById(arg_7_0._viewBuildingUid)

	if not var_7_0 and arg_7_1 then
		logError(string.format("RoomManufactureBuildingViewContainer:getContainerViewBuilding error, buildingMO is nil, uid:%s", arg_7_0._viewBuildingUid))
	end

	return arg_7_0._viewBuildingUid, var_7_0
end

return var_0_0
