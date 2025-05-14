module("modules.logic.versionactivity1_3.va3chess.game.step.Va3ChessStepMove", package.seeall)

local var_0_0 = class("Va3ChessStepMove", Va3ChessStepBase)

function var_0_0.start(arg_1_0)
	local var_1_0 = arg_1_0.originData.id
	local var_1_1 = arg_1_0.originData.x
	local var_1_2 = arg_1_0.originData.y
	local var_1_3 = arg_1_0.originData.direction
	local var_1_4 = Va3ChessGameController.instance.interacts

	if var_1_4 then
		local var_1_5 = var_1_4:get(var_1_0)

		Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.ObjMoveStep, var_1_0, var_1_1, var_1_2)
		arg_1_0:updatePosInfo(var_1_5, var_1_1, var_1_2)
		arg_1_0:startMove(var_1_5, var_1_1, var_1_2)

		if var_1_3 ~= nil then
			var_1_5:getHandler():faceTo(var_1_3)
		end
	end
end

function var_0_0.updatePosInfo(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	if arg_2_1 and arg_2_1:getHandler() then
		arg_2_1:getHandler():updatePos(arg_2_2, arg_2_3)
	else
		arg_2_0:finish()
	end
end

function var_0_0.startMove(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_1 and arg_3_1:getHandler() then
		local var_3_0 = arg_3_1.config.interactType
		local var_3_1 = arg_3_1.config and arg_3_1.config.moveAudioId

		if var_3_1 and var_3_1 ~= 0 then
			arg_3_0:playEnemyMoveAudio(var_3_1)
		end

		if var_3_0 == Va3ChessEnum.InteractType.Player or var_3_0 == Va3ChessEnum.InteractType.AssistPlayer then
			arg_3_1:getHandler():moveTo(arg_3_2, arg_3_3, arg_3_0.onMainPlayerMoveEnd, arg_3_0)
		else
			arg_3_1:getHandler():moveTo(arg_3_2, arg_3_3, arg_3_0.onOtherObjMoveEnd, arg_3_0)
		end
	else
		arg_3_0:finish()
	end
end

function var_0_0.onMainPlayerMoveEnd(arg_4_0)
	arg_4_0:onObjMoveEnd()
	arg_4_0:finish()
end

function var_0_0.onOtherObjMoveEnd(arg_5_0)
	local var_5_0 = arg_5_0.originData.id
	local var_5_1 = arg_5_0.originData.x
	local var_5_2 = arg_5_0.originData.y

	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.ObjMoveEnd, var_5_0, var_5_1, var_5_2)
	arg_5_0:finish()
end

function var_0_0.onObjMoveEnd(arg_6_0)
	local var_6_0 = arg_6_0.originData.id
	local var_6_1 = arg_6_0.originData.x
	local var_6_2 = arg_6_0.originData.y

	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.ObjMoveEnd, var_6_0, var_6_1, var_6_2)
end

var_0_0.lastEnemyMoveTime = {}
var_0_0.minSkipAudioTime = 0.01

function var_0_0.playEnemyMoveAudio(arg_7_0, arg_7_1)
	if arg_7_1 and arg_7_1 ~= 0 then
		local var_7_0 = Time.realtimeSinceStartup

		if var_7_0 >= (var_0_0.lastEnemyMoveTime[arg_7_1] or -1) then
			var_0_0.lastEnemyMoveTime[arg_7_1] = var_7_0 + var_0_0.minSkipAudioTime

			AudioMgr.instance:trigger(arg_7_1)
		end
	end
end

function var_0_0.finish(arg_8_0)
	var_0_0.super.finish(arg_8_0)
end

return var_0_0
