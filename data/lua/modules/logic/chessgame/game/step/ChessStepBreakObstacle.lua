module("modules.logic.chessgame.game.step.ChessStepBreakObstacle", package.seeall)

local var_0_0 = class("ChessStepBreakObstacle", BaseWork)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.originData = arg_1_1
end

function var_0_0.onStart(arg_2_0)
	arg_2_0:breakObstacle()
end

function var_0_0.breakObstacle(arg_3_0)
	local var_3_0 = arg_3_0.originData.hunterId
	local var_3_1 = ChessGameController.instance.interactsMgr:get(var_3_0)
	local var_3_2 = arg_3_0.originData.obstacleId
	local var_3_3 = ChessGameController.instance.interactsMgr:get(var_3_2)

	if not var_3_1 or not var_3_3 then
		arg_3_0:onDone(true)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_1ChessGame.play_ui_wangshi_bad)
	var_3_1:getHandler():breakObstacle(var_3_3, arg_3_0._onFlowDone, arg_3_0)
end

function var_0_0._onFlowDone(arg_4_0)
	local var_4_0 = ChessGameModel.instance:getCatchObj()

	if var_4_0 and var_4_0.mo.id == arg_4_0.originData.obstacleId then
		ChessGameModel.instance:setCatchObj(nil)
	end

	ChessGameController.instance:deleteInteractObj(arg_4_0.originData.obstacleId)
	arg_4_0:onDone(true)
end

return var_0_0
