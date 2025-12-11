module("modules.logic.fight.model.data.FightStateDataMgr", package.seeall)

local var_0_0 = FightDataClass("FightStateDataMgr", FightDataMgrBase)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0.isAuto = false
	arg_1_0.forceAuto = false
	arg_1_0.isReplay = false
	arg_1_0.isFinish = false
	arg_1_0.buffForceAuto = false
	arg_1_0.playingEnd = false
end

function var_0_0.initReplayState(arg_2_0)
	local var_2_0 = FightDataHelper.fieldMgr.version
	local var_2_1 = FightDataHelper.fieldMgr.isRecord

	if var_2_0 >= 1 then
		if var_2_1 then
			arg_2_0.isReplay = true
		end
	else
		local var_2_2 = FightModel.instance:getFightParam()

		if var_2_2 and var_2_2.isReplay then
			arg_2_0.isReplay = true
		end
	end
end

function var_0_0.initAutoState(arg_3_0)
	if arg_3_0.isReplay then
		arg_3_0:setAutoState(false)

		return
	end

	local var_3_0 = FightDataHelper.fieldMgr.customData

	if var_3_0 then
		local var_3_1 = var_3_0[FightCustomData.CustomDataType.Act191]

		if var_3_1 and var_3_1.auto then
			arg_3_0.forceAuto = true

			arg_3_0:setAutoState(true)

			return
		end
	end

	if FightDataHelper.fieldMgr:isDouQuQu() then
		arg_3_0:setAutoState(false)

		return
	end

	local var_3_2 = lua_battle.configDict[FightDataHelper.fieldMgr.battleId]
	local var_3_3 = var_3_2 and (not var_3_2.noAutoFight or var_3_2.noAutoFight == 0)

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightForbidAutoFight) then
		arg_3_0:setAutoState(false)
	elseif not var_3_3 then
		arg_3_0:setAutoState(false)
	else
		local var_3_4 = FightController.instance:getPlayerPrefKeyAuto(0)

		arg_3_0:setAutoState(var_3_4)
	end
end

function var_0_0.setAutoState(arg_4_0, arg_4_1)
	if not arg_4_1 and arg_4_0.isAuto then
		FightDataHelper.operationDataMgr:setCurSelectEntityId(0)
		FightDataHelper.operationDataMgr:resetCurSelectEntityIdDefault()
	end

	arg_4_0.isAuto = arg_4_1

	arg_4_0:com_sendMsg(FightMsgId.SetAutoState, arg_4_1)
	arg_4_0:com_sendFightEvent(FightEvent.SetAutoState, arg_4_1)
end

function var_0_0.setBuffForceAuto(arg_5_0, arg_5_1)
	arg_5_0.buffForceAuto = arg_5_1

	local var_5_0 = arg_5_0:getIsAuto()

	arg_5_0:com_sendMsg(FightMsgId.SetAutoState, var_5_0)
	arg_5_0:com_sendFightEvent(FightEvent.SetAutoState, var_5_0)
end

function var_0_0.getIsAuto(arg_6_0)
	if arg_6_0.buffForceAuto then
		return true
	end

	return arg_6_0.isAuto
end

function var_0_0.setPlayingEnd(arg_7_0, arg_7_1)
	arg_7_0.playingEnd = arg_7_1
end

function var_0_0.isPlayingEnd(arg_8_0)
	return arg_8_0.playingEnd
end

return var_0_0
