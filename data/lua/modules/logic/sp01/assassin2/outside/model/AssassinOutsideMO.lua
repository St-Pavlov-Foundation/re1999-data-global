module("modules.logic.sp01.assassin2.outside.model.AssassinOutsideMO", package.seeall)

local var_0_0 = class("AssassinOutsideMO")

function var_0_0.ctor(arg_1_0)
	arg_1_0:clearData()
end

function var_0_0.clearData(arg_2_0)
	if arg_2_0._buildingMapMo then
		arg_2_0._buildingMapMo:clearData()
	end

	arg_2_0:clearAllQuestData()

	arg_2_0.questMapDict = {}
	arg_2_0._coin = nil
end

function var_0_0.clearAllQuestData(arg_3_0)
	if arg_3_0.questMapDict then
		for iter_3_0, iter_3_1 in pairs(arg_3_0.questMapDict) do
			iter_3_1:clearQuestData()
		end
	end

	arg_3_0:setProcessingQuest()
end

function var_0_0.updateAllInfo(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	arg_4_0:clearData()
	arg_4_0:getBuildingMap():setInfo(arg_4_1)
	arg_4_0:unlockQuestMapByList(arg_4_2)
	arg_4_0:updateAllQuestInfo(arg_4_3)

	arg_4_0._coin = arg_4_4
end

function var_0_0.updateAllQuestInfo(arg_5_0, arg_5_1)
	arg_5_0:clearAllQuestData()
	arg_5_0:finishQuestByList(arg_5_1.finishQuestIds)
	arg_5_0:unlockQuestByList(arg_5_1.currentQuestIds)
	arg_5_0:setProcessingQuest(arg_5_1.assassinQuestId)
end

function var_0_0.getBuildingMap(arg_6_0)
	if not arg_6_0._buildingMapMo then
		arg_6_0._buildingMapMo = AssassinBuildingMapMO.New()
	end

	return arg_6_0._buildingMapMo
end

function var_0_0.unlockQuestMapByList(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		arg_7_0:unlockQuestMap(iter_7_1)
	end
end

function var_0_0.unlockQuestMap(arg_8_0, arg_8_1)
	if arg_8_0.questMapDict[arg_8_1] then
		return
	end

	local var_8_0 = AssassinQuestMapMO.New(arg_8_1)

	arg_8_0.questMapDict[arg_8_1] = var_8_0
end

function var_0_0.finishQuestByList(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		arg_9_0:finishQuest(iter_9_1)
	end
end

function var_0_0.finishQuest(arg_10_0, arg_10_1)
	local var_10_0 = AssassinConfig.instance:getQuestMapId(arg_10_1)
	local var_10_1 = var_10_0 and arg_10_0:getQuestMap(var_10_0)

	if not var_10_1 then
		logError(string.format("AssassinOutsideMO:finishQuest error, no mapMo, questId:%s", arg_10_1))

		return
	end

	var_10_1:finishQuest(arg_10_1)
end

function var_0_0.unlockQuestByList(arg_11_0, arg_11_1)
	for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
		arg_11_0:unlockQuest(iter_11_1)
	end
end

function var_0_0.unlockQuest(arg_12_0, arg_12_1)
	local var_12_0 = AssassinConfig.instance:getQuestMapId(arg_12_1)
	local var_12_1 = var_12_0 and arg_12_0:getQuestMap(var_12_0)

	if not var_12_1 then
		logError(string.format("AssassinOutsideMO:unlockQuest error, no mapMo, questId:%s", arg_12_1))

		return
	end

	var_12_1:unlockQuest(arg_12_1)
end

function var_0_0.updateCoinNum(arg_13_0, arg_13_1)
	arg_13_0._coin = arg_13_1
end

function var_0_0.setProcessingQuest(arg_14_0, arg_14_1)
	arg_14_0._processingQuest = arg_14_1
end

function var_0_0.getQuestMap(arg_15_0, arg_15_1)
	return arg_15_0.questMapDict[arg_15_1]
end

function var_0_0.getQuestMapStatus(arg_16_0, arg_16_1)
	local var_16_0 = AssassinEnum.MapStatus.Locked
	local var_16_1 = arg_16_0:getQuestMap(arg_16_1)

	if var_16_1 then
		var_16_0 = var_16_1:getStatus()
	end

	return var_16_0
end

function var_0_0.getQuestMapProgress(arg_17_0, arg_17_1)
	local var_17_0 = 0
	local var_17_1 = arg_17_0:getQuestMap(arg_17_1)

	if var_17_1 then
		var_17_0 = var_17_1:getProgress()
	end

	local var_17_2 = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("percent"), var_17_0 * 100)

	return var_17_0, var_17_2
end

function var_0_0.getQuestTypeProgressStr(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = 0
	local var_18_1 = 0
	local var_18_2 = arg_18_0:getQuestMap(arg_18_1)

	if var_18_2 then
		var_18_0 = var_18_2:getFinishQuestCount(arg_18_2)
		var_18_1 = #AssassinConfig.instance:getQuestListInMap(arg_18_1, arg_18_2)
	end

	return string.format("%s/%s", var_18_0, var_18_1)
end

function var_0_0.getMapUnlockQuestIdList(arg_19_0, arg_19_1)
	local var_19_0 = {}
	local var_19_1 = arg_19_0:getQuestMap(arg_19_1)

	if var_19_1 then
		var_19_0 = var_19_1:getMapUnlockQuestIdList()
	end

	return var_19_0
end

function var_0_0.getMapFinishQuestIdList(arg_20_0, arg_20_1)
	local var_20_0 = {}
	local var_20_1 = arg_20_0:getQuestMap(arg_20_1)

	if var_20_1 then
		var_20_0 = var_20_1:getMapFinishQuestIdList()
	end

	return var_20_0
end

function var_0_0.isUnlockQuest(arg_21_0, arg_21_1)
	local var_21_0 = false
	local var_21_1 = AssassinConfig.instance:getQuestMapId(arg_21_1)
	local var_21_2 = arg_21_0:getQuestMap(var_21_1)

	if var_21_2 then
		var_21_0 = var_21_2:isUnlockQuest(arg_21_1)
	end

	return var_21_0
end

function var_0_0.isFinishQuest(arg_22_0, arg_22_1)
	local var_22_0 = false
	local var_22_1 = AssassinConfig.instance:getQuestMapId(arg_22_1)
	local var_22_2 = arg_22_0:getQuestMap(var_22_1)

	if var_22_2 then
		var_22_0 = var_22_2:isFinishQuest(arg_22_1)
	end

	return var_22_0
end

function var_0_0.getCoinNum(arg_23_0)
	return arg_23_0._coin
end

function var_0_0.getProcessingQuest(arg_24_0)
	return arg_24_0._processingQuest
end

return var_0_0
