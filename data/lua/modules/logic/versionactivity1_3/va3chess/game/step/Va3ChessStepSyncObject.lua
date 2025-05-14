module("modules.logic.versionactivity1_3.va3chess.game.step.Va3ChessStepSyncObject", package.seeall)

local var_0_0 = class("Va3ChessStepSyncObject", Va3ChessStepBase)

function var_0_0.start(arg_1_0)
	local var_1_0 = arg_1_0.originData.object
	local var_1_1 = var_1_0.id
	local var_1_2 = var_1_0.data
	local var_1_3 = var_1_0.direction

	if Va3ChessGameModel.instance:getObjectDataById(var_1_1) then
		arg_1_0:_syncObject(var_1_1, var_1_2, var_1_3)
	end

	arg_1_0:finish()
end

function var_0_0._syncObject(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = Va3ChessGameModel.instance:syncObjectData(arg_2_1, arg_2_2)

	if var_2_0 == nil then
		return
	end

	if arg_2_0:dataHasChanged(var_2_0, "alertArea") then
		Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.RefreshAlarmArea)
	end

	if arg_2_0:dataHasChanged(var_2_0, "goToObject") then
		local var_2_1 = Va3ChessGameController.instance.interacts:get(arg_2_1)

		if var_2_1 then
			var_2_1.goToObject:updateGoToObject()
		end
	end

	if arg_2_0:dataHasChanged(var_2_0, "lostTarget") then
		local var_2_2 = Va3ChessGameController.instance.interacts:get(arg_2_1)

		if var_2_2 then
			var_2_2.effect:refreshSearchFailed()
			var_2_2.goToObject:refreshTarget()
		end
	end

	if arg_2_0:dataHasChanged(var_2_0, "pedalStatus") then
		local var_2_3 = Va3ChessGameController.instance.interacts:get(arg_2_1)

		if var_2_3 and var_2_3:getHandler().refreshPedalStatus then
			var_2_3:getHandler():refreshPedalStatus()
		end
	end

	local var_2_4 = Va3ChessGameController.instance.interacts:get(arg_2_1)

	if not var_2_4 or not var_2_4.chessEffectObj then
		return
	end

	if arg_2_2.attributes and arg_2_2.attributes.sleep and var_2_4.chessEffectObj.setSleep then
		var_2_4.chessEffectObj:setSleep(arg_2_2.attributes.sleep)
	end

	if var_2_4.chessEffectObj.refreshKillEffect then
		var_2_4.chessEffectObj:refreshKillEffect()
	end

	if arg_2_3 then
		var_2_4:getHandler():faceTo(arg_2_3)
	end
end

function var_0_0.dataHasChanged(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1[arg_3_2] ~= nil or arg_3_1.__deleteFields and arg_3_1.__deleteFields[arg_3_2] then
		return true
	end

	return false
end

return var_0_0
