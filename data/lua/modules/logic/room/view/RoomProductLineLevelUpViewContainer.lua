module("modules.logic.room.view.RoomProductLineLevelUpViewContainer", package.seeall)

local var_0_0 = class("RoomProductLineLevelUpViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, RoomProductLineLevelUpView.New())

	return var_1_0
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	ViewMgr.instance:closeView(ViewName.RoomProductLineLevelUpView, nil, true)
end

return var_0_0
