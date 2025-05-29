module("modules.logic.rouge.model.RougeGameRecordInfoMO", package.seeall)

local var_0_0 = pureTable("RougeGameRecordInfoMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.maxDifficulty = arg_1_1.maxDifficulty
	arg_1_0.passEndIdMap = arg_1_0:_listToMap(arg_1_1.passEndId)
	arg_1_0.passLayerIdMap = arg_1_0:_listToMap(arg_1_1.passLayerId)
	arg_1_0.passEventIdMap = arg_1_0:_listToMap(arg_1_1.passEventId)
	arg_1_0.passEndIdMap = arg_1_0:_listToMap(arg_1_1.passEndId)
	arg_1_0.passEntrustMap = arg_1_0:_listToMap(arg_1_1.passEntrustId)
	arg_1_0.lastGameTime = math.ceil((tonumber(arg_1_1.lastGameTime) or 0) / 1000)
	arg_1_0.passCollections = arg_1_0:_listToMap(arg_1_1.passCollections)
	arg_1_0.unlockStoryIds = arg_1_0:_listToMap(arg_1_1.unlockStoryIds)

	arg_1_0:_updateVersionIds(arg_1_1.dlcVersionIds)

	arg_1_0.unlockSkillMap = GameUtil.rpcInfosToMap(arg_1_1.unlockSkills, RougeUnlockSkillMO, "type")
end

function var_0_0._listToMap(arg_2_0, arg_2_1)
	if not arg_2_1 then
		return {}
	end

	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		var_2_0[iter_2_1] = iter_2_1
	end

	return var_2_0
end

function var_0_0.collectionIsPass(arg_3_0, arg_3_1)
	return arg_3_0.passCollections[arg_3_1]
end

function var_0_0.storyIsPass(arg_4_0, arg_4_1)
	return arg_4_0.unlockStoryIds[arg_4_1]
end

function var_0_0.passedLayerId(arg_5_0, arg_5_1)
	return arg_5_0.passLayerIdMap and arg_5_0.passLayerIdMap[arg_5_1]
end

function var_0_0.passedEventId(arg_6_0, arg_6_1)
	return arg_6_0.passEventIdMap and arg_6_0.passEventIdMap[arg_6_1]
end

function var_0_0.passAnyOneEnd(arg_7_0)
	return tabletool.len(arg_7_0.passEndIdMap) > 0
end

function var_0_0.passEndId(arg_8_0, arg_8_1)
	return arg_8_0.passEndIdMap and arg_8_0.passEndIdMap[arg_8_1]
end

function var_0_0.passEntrustId(arg_9_0, arg_9_1)
	return arg_9_0.passEntrustMap and arg_9_0.passEntrustMap[arg_9_1]
end

function var_0_0.passLayerId(arg_10_0, arg_10_1)
	return arg_10_0.passLayerIdMap and arg_10_0.passLayerIdMap[arg_10_1]
end

function var_0_0.lastGameEndTimestamp(arg_11_0)
	return arg_11_0.lastGameTime
end

function var_0_0.isSelectDLC(arg_12_0, arg_12_1)
	return arg_12_0.versionIdMap and arg_12_0.versionIdMap[arg_12_1] ~= nil
end

function var_0_0._updateVersionIds(arg_13_0, arg_13_1)
	arg_13_0.versionIds = {}
	arg_13_0.versionIdMap = {}

	if arg_13_1 then
		for iter_13_0, iter_13_1 in ipairs(arg_13_1) do
			table.insert(arg_13_0.versionIds, iter_13_1)

			arg_13_0.versionIdMap[iter_13_1] = iter_13_1
		end
	end
end

function var_0_0.getVersionIds(arg_14_0)
	local var_14_0 = {}

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.versionIds) do
		table.insert(var_14_0, iter_14_1)
	end

	return var_14_0
end

function var_0_0.isSkillUnlock(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0.unlockSkillMap and arg_15_0.unlockSkillMap[arg_15_1]

	return var_15_0 and var_15_0:isSkillUnlock(arg_15_2)
end

function var_0_0.updateSkillUnlockInfo(arg_16_0, arg_16_1, arg_16_2)
	if not arg_16_1 and arg_16_2 then
		return
	end

	local var_16_0 = arg_16_0.unlockSkillMap and arg_16_0.unlockSkillMap[arg_16_1]

	if not var_16_0 then
		var_16_0 = RougeUnlockSkillMO.New()

		var_16_0:init({
			type = arg_16_1,
			ids = {}
		})

		arg_16_0.unlockSkillMap[arg_16_1] = var_16_0
	end

	var_16_0:onNewSkillUnlock(arg_16_2)
end

return var_0_0
