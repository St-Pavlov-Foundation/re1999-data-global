module("modules.logic.chessgame.game.step.ChessStepMove", package.seeall)

local var_0_0 = class("ChessStepMove", BaseWork)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.originData = arg_1_1
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0.originData.id
	local var_2_1 = arg_2_0.originData.x
	local var_2_2 = arg_2_0.originData.y
	local var_2_3 = arg_2_0.originData.direction

	arg_2_0._catchObj = arg_2_1

	local var_2_4 = ChessGameController.instance.interactsMgr

	if var_2_4 then
		local var_2_5 = var_2_4:get(var_2_0)

		if not var_2_5 then
			arg_2_0:onDone(true)

			return
		end

		arg_2_0:updatePosInfo(var_2_5, var_2_1, var_2_2)
		arg_2_0:startMove(var_2_5, var_2_1, var_2_2)

		if var_2_3 ~= nil then
			var_2_5:getHandler():faceTo(var_2_3)
		end
	end
end

function var_0_0.updatePosInfo(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_1 and arg_3_1:getHandler() then
		arg_3_1:getHandler():updatePos(arg_3_2, arg_3_3)
	else
		arg_3_0:onDone(true)
	end
end

function var_0_0.startMove(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if arg_4_1 and arg_4_1:getHandler() then
		local var_4_0 = arg_4_1.config.interactType

		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_1ChessGame.play_ui_molu_jlbn_move)

		if var_4_0 == ChessGameEnum.InteractType.Role then
			if arg_4_0._catchObj then
				local var_4_1, var_4_2 = arg_4_0._catchObj.mo:getXY()
				local var_4_3 = (arg_4_2 + var_4_1) / 2
				local var_4_4 = (arg_4_3 + var_4_2) / 2

				arg_4_1:getHandler():moveTo(var_4_3, var_4_4, arg_4_0.onMainPlayerMoveEnd, arg_4_0)
			else
				arg_4_1:getHandler():moveTo(arg_4_2, arg_4_3, arg_4_0.onMainPlayerMoveEnd, arg_4_0)
			end
		else
			arg_4_1:getHandler():moveTo(arg_4_2, arg_4_3, arg_4_0.onOtherObjMoveEnd, arg_4_0)
		end
	else
		arg_4_0:onDone(true)
	end
end

function var_0_0.onMainPlayerMoveEnd(arg_5_0)
	arg_5_0:onObjMoveEnd()
	arg_5_0:onDone(true)
end

function var_0_0.onOtherObjMoveEnd(arg_6_0)
	local var_6_0 = arg_6_0.originData.id
	local var_6_1 = arg_6_0.originData.x
	local var_6_2 = arg_6_0.originData.y

	ChessGameController.instance:dispatchEvent(ChessGameEvent.ObjMoveEnd, var_6_0, var_6_1, var_6_2)
	arg_6_0:onDone(true)
end

function var_0_0.onObjMoveEnd(arg_7_0)
	local var_7_0 = arg_7_0.originData.id
	local var_7_1 = arg_7_0.originData.x
	local var_7_2 = arg_7_0.originData.y

	ChessGameController.instance:dispatchEvent(ChessGameEvent.ObjMoveEnd, var_7_0, var_7_1, var_7_2)
end

var_0_0.lastEnemyMoveTime = {}
var_0_0.minSkipAudioTime = 0.01

function var_0_0.playEnemyMoveAudio(arg_8_0, arg_8_1)
	if arg_8_1 and arg_8_1 ~= 0 then
		local var_8_0 = Time.realtimeSinceStartup

		if var_8_0 >= (var_0_0.lastEnemyMoveTime[arg_8_1] or -1) then
			var_0_0.lastEnemyMoveTime[arg_8_1] = var_8_0 + var_0_0.minSkipAudioTime

			AudioMgr.instance:trigger(arg_8_1)
		end
	end
end

return var_0_0
