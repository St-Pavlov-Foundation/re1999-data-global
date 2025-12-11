module("modules.logic.necrologiststory.model.NecrologistV3A1MO", package.seeall)

local var_0_0 = class("NecrologistV3A1MO", NecrologistStoryGameBaseMO)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.onUpdateData(arg_2_0)
	local var_2_0 = arg_2_0:getData()
	local var_2_1 = NecrologistStoryV3A1Config.instance:getDefaultBaseId()

	arg_2_0.curBaseId = var_2_0.curBaseId or var_2_1
	arg_2_0.curTime = var_2_0.curTime
	arg_2_0.areaUnlockDict = {}

	if var_2_0.areaUnlockList then
		for iter_2_0, iter_2_1 in ipairs(var_2_0.areaUnlockList) do
			arg_2_0.areaUnlockDict[iter_2_1] = true
		end
	end

	local var_2_2 = NecrologistStoryV3A1Config.instance:getFugaorenBaseCo(arg_2_0.curBaseId)

	arg_2_0.areaUnlockDict[var_2_2.areaId] = true
	arg_2_0.hasEnterList = {}

	if var_2_0.hasEnterList then
		for iter_2_2, iter_2_3 in ipairs(var_2_0.hasEnterList) do
			arg_2_0.hasEnterList[iter_2_3] = true
		end
	end
end

function var_0_0.onSaveData(arg_3_0)
	local var_3_0 = arg_3_0:getData()

	var_3_0.curBaseId = arg_3_0.curBaseId
	var_3_0.curTime = arg_3_0.curTime
	var_3_0.areaUnlockList = {}

	for iter_3_0, iter_3_1 in pairs(arg_3_0.areaUnlockDict) do
		table.insert(var_3_0.areaUnlockList, iter_3_0)
	end

	var_3_0.hasEnterList = {}

	for iter_3_2, iter_3_3 in pairs(arg_3_0.hasEnterList) do
		table.insert(var_3_0.hasEnterList, iter_3_2)
	end
end

function var_0_0.setBaseEntered(arg_4_0, arg_4_1)
	if arg_4_0:isBaseEntered(arg_4_1) then
		return
	end

	NecrologistStoryRpc.instance:sendFinishNecrologistStoryModeRequest(arg_4_0.id, arg_4_1)

	arg_4_0.hasEnterList[arg_4_1] = true

	arg_4_0:setDataDirty()
end

function var_0_0.isBaseEntered(arg_5_0, arg_5_1)
	return arg_5_0.hasEnterList[arg_5_1] ~= nil
end

function var_0_0.getCurBaseId(arg_6_0)
	return arg_6_0.curBaseId
end

function var_0_0.setCurBaseId(arg_7_0, arg_7_1)
	if arg_7_0:getCurBaseId() == arg_7_1 then
		return
	end

	arg_7_0.curBaseId = arg_7_1

	NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.V3A1_MoveToBase, arg_7_1)
	arg_7_0:setDataDirty()
end

function var_0_0.getCurTime(arg_8_0)
	local var_8_0 = arg_8_0.curTime

	if var_8_0 == nil then
		local var_8_1 = arg_8_0:getCurBaseId()

		var_8_0 = NecrologistStoryV3A1Config.instance:getFugaorenBaseCo(var_8_1).startTime
		arg_8_0.curTime = var_8_0
	end

	return var_8_0
end

function var_0_0.setTime(arg_9_0, arg_9_1)
	if arg_9_1 == arg_9_0.curTime then
		return
	end

	arg_9_0.curTime = arg_9_1

	arg_9_0:setDataDirty()
end

function var_0_0.addTime(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:getCurTime()

	arg_10_0:setTime(var_10_0 + arg_10_1)
end

function var_0_0.isAreaUnlock(arg_11_0, arg_11_1)
	return arg_11_0.areaUnlockDict[arg_11_1] ~= nil
end

function var_0_0.setAreaUnlock(arg_12_0, arg_12_1)
	if arg_12_0:isAreaUnlock(arg_12_1) then
		return
	end

	arg_12_0.areaUnlockDict[arg_12_1] = true

	NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.V3A1_UnlockArea, arg_12_1)
	arg_12_0:setDataDirty()
end

function var_0_0.onStoryStateChange(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_2 == NecrologistStoryEnum.StoryState.Finish then
		local var_13_0 = NecrologistStoryV3A1Config.instance:getStoryConfig(arg_13_1)

		arg_13_0:tryFinishBase(var_13_0.baseId)
	end
end

function var_0_0.tryFinishBase(arg_14_0, arg_14_1)
	if arg_14_0:isBaseAllStoryFinish(arg_14_1) then
		local var_14_0 = NecrologistStoryV3A1Config.instance:getFugaorenBaseCo(arg_14_1)

		if var_14_0.unlockAreaId > 0 then
			arg_14_0:setAreaUnlock(var_14_0.unlockAreaId)
		end
	end
end

function var_0_0.isBaseCanFinish(arg_15_0, arg_15_1)
	if arg_15_0:isBaseAllStoryFinish(arg_15_1) then
		local var_15_0 = NecrologistStoryV3A1Config.instance:getFugaorenBaseCo(arg_15_1)

		if var_15_0.unlockAreaId > 0 and arg_15_0:isAreaUnlock(var_15_0.unlockAreaId) then
			return true
		end
	end
end

function var_0_0.isBaseFinish(arg_16_0, arg_16_1)
	if NecrologistStoryV3A1Config.instance:getFugaorenBaseCo(arg_16_1).type == NecrologistStoryEnum.BaseType.InteractiveBase then
		return false
	end

	return (arg_16_0:isBaseAllStoryFinish(arg_16_1))
end

function var_0_0.isBaseAllStoryFinish(arg_17_0, arg_17_1, arg_17_2)
	if not arg_17_1 or arg_17_1 == 0 then
		return true
	end

	local var_17_0 = NecrologistStoryV3A1Config.instance:getDefaultBaseId()
	local var_17_1 = NecrologistStoryV3A1Config.instance:getBaseStoryList(arg_17_1) or {}
	local var_17_2 = arg_17_1 == var_17_0 and var_17_1[#var_17_1]

	for iter_17_0, iter_17_1 in ipairs(var_17_1) do
		local var_17_3 = arg_17_0:getStoryState(iter_17_1)

		if iter_17_1 == var_17_2 and (arg_17_2 or not arg_17_0:isInEndBase()) then
			var_17_3 = NecrologistStoryEnum.StoryState.Finish
		end

		if var_17_3 ~= NecrologistStoryEnum.StoryState.Finish then
			return false
		end
	end

	return true
end

function var_0_0.getCurTargetData(arg_18_0)
	if arg_18_0:isInEndBase() then
		return nil
	end

	local var_18_0 = NecrologistStoryV3A1Config.instance:getBaseTargetList()
	local var_18_1 = arg_18_0:getCurBaseId()
	local var_18_2 = arg_18_0:getCurTime()
	local var_18_3

	for iter_18_0, iter_18_1 in ipairs(var_18_0) do
		if var_18_1 <= iter_18_1.id then
			var_18_3 = {
				isEnter = var_18_1 == iter_18_1.id
			}

			if var_18_3.isEnter then
				var_18_3.isFail = var_18_2 ~= iter_18_1.endTime
			else
				var_18_3.isFail = var_18_2 > iter_18_1.endTime
			end

			var_18_3.config = iter_18_1

			break
		end
	end

	return var_18_3
end

function var_0_0.isInEndBase(arg_19_0)
	if arg_19_0:getCurBaseId() ~= NecrologistStoryV3A1Config.instance:getDefaultBaseId() then
		return false
	end

	return arg_19_0:isAreaUnlock(4)
end

function var_0_0.getGameState(arg_20_0)
	local var_20_0 = arg_20_0:getCurTargetData()
	local var_20_1 = NecrologistStoryV3A1Config.instance:getDefaultBaseId()

	if var_20_0 and var_20_0.isFail then
		return NecrologistStoryEnum.GameState.Fail
	end

	local var_20_2 = arg_20_0:getCurBaseId()

	if arg_20_0:isInEndBase() and arg_20_0:isBaseAllStoryFinish(var_20_2) then
		return NecrologistStoryEnum.GameState.Win
	end

	return NecrologistStoryEnum.GameState.Normal
end

function var_0_0.resetProgressByFail(arg_21_0)
	local var_21_0 = arg_21_0:getCurBaseId()
	local var_21_1, var_21_2 = NecrologistStoryV3A1Config.instance:getCurStartTime(var_21_0)

	arg_21_0.curBaseId = var_21_1
	arg_21_0.curTime = var_21_2

	arg_21_0:setDataDirty()
	NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.V3A1_GameReset)
end

function var_0_0.canReset(arg_22_0)
	local var_22_0 = arg_22_0:getCurBaseId()
	local var_22_1, var_22_2 = NecrologistStoryV3A1Config.instance:getCurStartTime(var_22_0)

	return arg_22_0.curBaseId ~= var_22_1 or arg_22_0.curTime ~= var_22_2
end

function var_0_0.setIsExitGame(arg_23_0, arg_23_1)
	arg_23_0.isExitGame = arg_23_1
end

function var_0_0.getIsExitGame(arg_24_0)
	return arg_24_0.isExitGame
end

return var_0_0
