module("modules.logic.room.view.manufacture.RoomOverViewContainer", package.seeall)

local var_0_0 = class("RoomOverViewContainer", BaseViewContainer)
local var_0_1 = {
	Navigate = 1,
	SubView = 2
}

var_0_0.SubViewTabId = {
	Manufacture = 1,
	Transport = 2
}

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, RoomOverView.New())
	table.insert(var_1_0, TabViewGroup.New(var_0_1.Navigate, "#go_BackBtns"))
	table.insert(var_1_0, TabViewGroup.New(var_0_1.SubView, "#go_subView"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == var_0_1.Navigate then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			arg_2_0.navigateView
		}
	elseif arg_2_1 == var_0_1.SubView then
		local var_2_0 = RoomManufactureOverView.New()

		return {
			var_2_0,
			RoomTransportOverView.New()
		}
	end
end

function var_0_0.onContainerInit(arg_3_0)
	if not arg_3_0.viewParam then
		return
	end

	local var_3_0 = arg_3_0:getDefaultSelectedTab()

	arg_3_0.viewParam.defaultTabIds = {}
	arg_3_0.viewParam.defaultTabIds[var_0_1.SubView] = var_3_0

	arg_3_0:setContainerViewBuildingUid()
end

function var_0_0.getDefaultSelectedTab(arg_4_0)
	local var_4_0 = var_0_0.SubViewTabId.Manufacture
	local var_4_1 = arg_4_0.viewParam and arg_4_0.viewParam.defaultTab

	if arg_4_0:checkTabId(var_4_1) then
		var_4_0 = var_4_1
	end

	return var_4_0
end

function var_0_0.checkTabId(arg_5_0, arg_5_1)
	local var_5_0 = false

	if arg_5_1 then
		for iter_5_0, iter_5_1 in pairs(RoomCritterBuildingViewContainer.SubViewTabId) do
			if iter_5_1 == arg_5_1 then
				var_5_0 = true

				break
			end
		end
	end

	return var_5_0
end

function var_0_0.switchTab(arg_6_0, arg_6_1)
	if not arg_6_0:checkTabId(arg_6_1) then
		return
	end

	arg_6_0:dispatchEvent(ViewEvent.ToSwitchTab, var_0_1.SubView, arg_6_1)
end

function var_0_0.setContainerViewBuildingUid(arg_7_0, arg_7_1)
	arg_7_0._viewBuildingUid = arg_7_1
end

function var_0_0.getContainerViewBuilding(arg_8_0, arg_8_1)
	local var_8_0 = RoomMapBuildingModel.instance:getBuildingMOById(arg_8_0._viewBuildingUid)

	if not var_8_0 and arg_8_1 then
		logError(string.format("RoomOverViewContainer:getContainerViewBuilding error, buildingMO is nil, uid:%s", arg_8_0._viewBuildingUid))
	end

	return arg_8_0._viewBuildingUid, var_8_0
end

function var_0_0.onContainerClose(arg_9_0)
	arg_9_0:setContainerViewBuildingUid()
end

return var_0_0
