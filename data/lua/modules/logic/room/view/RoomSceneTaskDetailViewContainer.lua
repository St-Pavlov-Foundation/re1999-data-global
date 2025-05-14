module("modules.logic.room.view.RoomSceneTaskDetailViewContainer", package.seeall)

local var_0_0 = class("RoomSceneTaskDetailViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, RoomSceneTaskDetailView.New())
	table.insert(var_1_0, RoomViewTopRight.New())

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0._navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			arg_2_0._navigateButtonView
		}
	end
end

function var_0_0.onContainerClickModalMask(arg_3_0)
	arg_3_0:closeThis()
end

return var_0_0
