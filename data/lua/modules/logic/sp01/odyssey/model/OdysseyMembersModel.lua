module("modules.logic.sp01.odyssey.model.OdysseyMembersModel", package.seeall)

local var_0_0 = class("OdysseyMembersModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInitData()
end

function var_0_0.reInitData(arg_2_0)
	arg_2_0.hasClickReligionIdMap = {}
end

function var_0_0.initLocalClueUnlockState(arg_3_0)
	arg_3_0.curClueSaveStrList = {}

	local var_3_0 = OdysseyDungeonController.instance:getPlayerPrefs(OdysseyEnum.LocalSaveKey.ReligionClue, "")

	if not string.nilorempty(var_3_0) then
		arg_3_0.curClueSaveStrList = cjson.decode(var_3_0)
	end
end

function var_0_0.setHasClickReglionId(arg_4_0, arg_4_1)
	arg_4_0.hasClickReligionIdMap[arg_4_1] = arg_4_1
end

function var_0_0.getHasClickReglionId(arg_5_0, arg_5_1)
	return arg_5_0.hasClickReligionIdMap[arg_5_1]
end

function var_0_0.checkReligionMemberCanExpose(arg_6_0, arg_6_1)
	local var_6_0 = OdysseyConfig.instance:getReligionConfig(arg_6_1)
	local var_6_1 = string.splitToNumber(var_6_0.clueList, "#")

	for iter_6_0, iter_6_1 in ipairs(var_6_1) do
		local var_6_2 = OdysseyConfig.instance:getReligionClueConfig(iter_6_1).unlockCondition

		if not OdysseyDungeonModel.instance:checkConditionCanUnlock(var_6_2) then
			return false
		end
	end

	return true
end

function var_0_0.saveLocalNewClueUnlockState(arg_7_0)
	local var_7_0 = OdysseyConfig.instance:getReligionConfigList()

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		local var_7_1 = {}

		if arg_7_0.hasClickReligionIdMap[iter_7_1.id] then
			local var_7_2 = arg_7_0:getCanUnlockClueList(iter_7_1)
			local var_7_3 = string.format("%s|%s|%s", iter_7_1.id, table.concat(var_7_2, "#"), #var_7_2)

			arg_7_0:removeHasSaveData(iter_7_1.id)
			table.insert(arg_7_0.curClueSaveStrList, var_7_3)
		end
	end

	OdysseyDungeonController.instance:setPlayerPrefs(OdysseyEnum.LocalSaveKey.ReligionClue, cjson.encode(arg_7_0.curClueSaveStrList))

	arg_7_0.hasClickReligionIdMap = {}
end

function var_0_0.getCanUnlockClueList(arg_8_0, arg_8_1)
	local var_8_0 = {}
	local var_8_1 = string.splitToNumber(arg_8_1.clueList, "#")

	for iter_8_0, iter_8_1 in ipairs(var_8_1) do
		local var_8_2 = OdysseyConfig.instance:getReligionClueConfig(iter_8_1).unlockCondition

		if OdysseyDungeonModel.instance:checkConditionCanUnlock(var_8_2) then
			table.insert(var_8_0, iter_8_1)
		end
	end

	return var_8_0
end

function var_0_0.removeHasSaveData(arg_9_0, arg_9_1)
	for iter_9_0 = #arg_9_0.curClueSaveStrList, 1, -1 do
		local var_9_0 = string.split(arg_9_0.curClueSaveStrList[iter_9_0], "|")

		if tonumber(var_9_0[1]) == arg_9_1 then
			table.remove(arg_9_0.curClueSaveStrList, iter_9_0)
		end
	end
end

function var_0_0.checkHasNewClue(arg_10_0, arg_10_1)
	local var_10_0 = OdysseyConfig.instance:getReligionConfig(arg_10_1)
	local var_10_1 = arg_10_0:getCanUnlockClueList(var_10_0)

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.curClueSaveStrList) do
		local var_10_2 = string.split(iter_10_1, "|")

		if tonumber(var_10_2[1]) == arg_10_1 then
			return #var_10_1 > tonumber(var_10_2[3])
		end
	end

	return #var_10_1 > 0
end

function var_0_0.getNewClueIdList(arg_11_0, arg_11_1)
	local var_11_0 = {}
	local var_11_1 = OdysseyConfig.instance:getReligionConfig(arg_11_1)
	local var_11_2 = arg_11_0:getCanUnlockClueList(var_11_1)

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.curClueSaveStrList) do
		local var_11_3 = string.split(iter_11_1, "|")

		if tonumber(var_11_3[1]) == arg_11_1 then
			local var_11_4 = string.splitToNumber(var_11_3[2], "#")

			for iter_11_2, iter_11_3 in ipairs(var_11_2) do
				if not tabletool.indexOf(var_11_4, iter_11_3) then
					table.insert(var_11_0, iter_11_3)
				end
			end

			return var_11_0
		end
	end

	return var_11_2
end

function var_0_0.checkCanShowNewDot(arg_12_0)
	arg_12_0:initLocalClueUnlockState()

	local var_12_0 = OdysseyConfig.instance:getReligionConfigList()

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		local var_12_1 = OdysseyModel.instance:getReligionInfoData(iter_12_1.id)
		local var_12_2 = arg_12_0:checkHasNewClue(iter_12_1.id)
		local var_12_3 = arg_12_0:checkReligionMemberCanExpose(iter_12_1.id)

		if not var_12_1 and (var_12_2 or var_12_3) then
			return true
		end
	end

	return false
end

var_0_0.instance = var_0_0.New()

return var_0_0
