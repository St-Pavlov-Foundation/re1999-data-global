module("modules.logic.room.view.critter.RoomCritterTrainReportViewContainer", package.seeall)

local var_0_0 = class("RoomCritterTrainReportViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, RoomCritterTrainReportView.New())

	return var_1_0
end

function var_0_0.playCloseTransition(arg_2_0)
	ZProj.ProjAnimatorPlayer.Get(arg_2_0.viewGO):Play(UIAnimationName.Close, arg_2_0.onCloseAnimDone, arg_2_0)
end

function var_0_0.onCloseAnimDone(arg_3_0)
	arg_3_0:onPlayCloseTransitionFinish()
end

return var_0_0
