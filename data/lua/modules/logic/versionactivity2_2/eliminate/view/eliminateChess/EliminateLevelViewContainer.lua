module("modules.logic.versionactivity2_2.eliminate.view.eliminateChess.EliminateLevelViewContainer", package.seeall)

local var_0_0 = class("EliminateLevelViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	arg_1_0._sceneView = EliminateSceneView.New()
	arg_1_0._teamChessView = EliminateTeamChessView.New()
	arg_1_0._eliminateView = EliminateView.New()
	arg_1_0._eliminateLevelView = EliminateLevelView.New()

	return {
		arg_1_0._sceneView,
		arg_1_0._teamChessView,
		arg_1_0._eliminateView,
		arg_1_0._eliminateLevelView
	}
end

function var_0_0.setTeamChessViewParent(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._eliminateLevelView:setParent(arg_2_1, arg_2_2)
end

function var_0_0.setTeamChessTipViewParent(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._teamChessView:setTipViewParent(arg_3_1, arg_3_2)
end

function var_0_0.setVisibleInternal(arg_4_0, arg_4_1)
	if arg_4_0._sceneView ~= nil then
		arg_4_0._sceneView:setSceneVisible(arg_4_1)
		var_0_0.super.setVisibleInternal(arg_4_0, arg_4_1)
	end
end

function var_0_0.onContainerOpenFinish(arg_5_0)
	return
end

return var_0_0
