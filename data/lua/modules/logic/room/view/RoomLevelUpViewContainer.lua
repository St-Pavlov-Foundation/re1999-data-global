module("modules.logic.room.view.RoomLevelUpViewContainer", package.seeall)

local var_0_0 = class("RoomLevelUpViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, RoomLevelUpView.New())
	table.insert(var_1_0, RoomViewTopRight.New())

	return var_1_0
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	ViewMgr.instance:closeView(ViewName.RoomLevelUpView, nil, true)
end

return var_0_0
