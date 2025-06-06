﻿module("modules.logic.room.view.RoomMiniMapViewContainer", package.seeall)

local var_0_0 = class("RoomMiniMapViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, TabViewGroup.New(1, "#go_navigatebuttonscontainer"))
	table.insert(var_1_0, RoomMiniMapView.New())

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigationView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			arg_2_0.navigationView
		}
	end
end

function var_0_0.onContainerOpenFinish(arg_3_0)
	arg_3_0.navigationView:resetCloseBtnAudioId(AudioEnum.UI.play_ui_checkpoint_story_close)
end

return var_0_0
