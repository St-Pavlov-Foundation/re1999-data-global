module("modules.logic.room.view.building.RoomCommonStrengthViewContainer", package.seeall)

local var_0_0 = class("RoomCommonStrengthViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, RoomCommonStrengthView.New())
	table.insert(var_1_0, RoomViewTopRight.New("#go_topright", arg_1_0._viewSetting.otherRes[1], {
		{
			strengthId = 190007,
			strengthShowType = 0,
			classDefine = RoomViewTopRightStrengthItem
		},
		{
			strengthId = 190008,
			strengthShowType = 1,
			classDefine = RoomViewTopRightStrengthItem
		}
	}))

	return var_1_0
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	return
end

return var_0_0
