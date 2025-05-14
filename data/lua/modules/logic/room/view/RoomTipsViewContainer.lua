module("modules.logic.room.view.RoomTipsViewContainer", package.seeall)

local var_0_0 = class("RoomTipsViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		RoomTipsView.New()
	}
end

return var_0_0
