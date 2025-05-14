module("modules.logic.activity.controller.chessmap.step.ActivityChessStepMove", package.seeall)

local var_0_0 = class("ActivityChessStepMove", ActivityChessStepBase)

function var_0_0.start(arg_1_0)
	local var_1_0 = arg_1_0.originData.id
	local var_1_1 = arg_1_0.originData.x
	local var_1_2 = arg_1_0.originData.y
	local var_1_3 = arg_1_0.originData.direction
	local var_1_4 = ActivityChessGameController.instance.interacts

	if var_1_4 then
		local var_1_5 = var_1_4:get(var_1_0)

		arg_1_0:startMove(var_1_5, var_1_1, var_1_2)

		if var_1_3 ~= nil then
			var_1_5:getHandler():faceTo(var_1_3)
		end
	end
end

function var_0_0.startMove(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	if arg_2_1 and arg_2_1:getHandler() then
		ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.SetAlwayUpdateRenderOrder, true)

		if arg_2_1.config.interactType == ActivityChessEnum.InteractType.Player then
			arg_2_1:getHandler():moveTo(arg_2_2, arg_2_3, arg_2_0.finish, arg_2_0)
			AudioMgr.instance:trigger(AudioEnum.ChessGame.PlayerMove)
		else
			arg_2_1:getHandler():moveTo(arg_2_2, arg_2_3)

			local var_2_0 = ActivityChessGameController.instance.event

			arg_2_0:playEnemyMoveAudio()
			arg_2_0:finish()
		end
	else
		arg_2_0:finish()
	end
end

var_0_0.lastEnemyMoveTime = nil
var_0_0.minSkipAudioTime = 0.01

function var_0_0.playEnemyMoveAudio(arg_3_0)
	local var_3_0 = Time.realtimeSinceStartup

	if not (var_0_0.lastEnemyMoveTime ~= nil and var_3_0 - var_0_0.lastEnemyMoveTime <= var_0_0.minSkipAudioTime) then
		AudioMgr.instance:trigger(AudioEnum.ChessGame.EnemyMove)

		var_0_0.lastEnemyMoveTime = var_3_0
	end
end

function var_0_0.finish(arg_4_0)
	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.SetAlwayUpdateRenderOrder, false)
	var_0_0.super.finish(arg_4_0)
end

return var_0_0
