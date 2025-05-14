module("modules.logic.room.view.critter.train.RoomCritterTrainStoryViewContainer", package.seeall)

local var_0_0 = class("RoomCritterTrainStoryViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		RoomCritterTrainStoryView.New(),
		TabViewGroup.New(1, "#go_lefttopbtns")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0._navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		arg_2_0._navigateButtonView:setOverrideClose(arg_2_0.overrideOnCloseClick, arg_2_0)

		return {
			arg_2_0._navigateButtonView
		}
	end
end

function var_0_0.overrideOnCloseClick(arg_3_0)
	StoryController.instance:closeStoryView()
	arg_3_0:closeThis()
end

return var_0_0
