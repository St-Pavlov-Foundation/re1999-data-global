module("modules.logic.room.view.common.RoomMaterialTipViewContainer", package.seeall)

local var_0_0 = class("RoomMaterialTipViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, RoomMaterialTipView.New())
	table.insert(var_1_0, RoomMaterialTipViewBanner.New())

	return var_1_0
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	arg_2_0:closeThis()
end

function var_0_0.onContainerOpen(arg_3_0)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_firmup_open)
end

return var_0_0
