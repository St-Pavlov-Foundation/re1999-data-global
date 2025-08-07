module("modules.logic.sp01.assassin2.outside.model.AssassinBuildingMapMO", package.seeall)

local var_0_0 = pureTable("AssassinBuildingMapMO")

function var_0_0.clearData(arg_1_0)
	arg_1_0.unlockBuildIdMap = nil
	arg_1_0.buildingDict = nil
end

function var_0_0.setInfo(arg_2_0, arg_2_1)
	arg_2_0:_onGetBuildingInfos(arg_2_1.buildings)
	arg_2_0:_onGetUnlockBuildIds(arg_2_1.unlockBuildIds)
end

function var_0_0._onGetUnlockBuildIds(arg_3_0, arg_3_1)
	arg_3_0.unlockBuildIdMap = {}

	arg_3_0:updateUnlockBuildIds(arg_3_1)
end

function var_0_0.updateUnlockBuildIds(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		arg_4_0:_updateUnlockBuildId(iter_4_1)
	end
end

function var_0_0._updateUnlockBuildId(arg_5_0, arg_5_1)
	if not arg_5_1 then
		return
	end

	local var_5_0 = AssassinConfig.instance:getBuildingCo(arg_5_1)

	if not var_5_0 then
		return
	end

	arg_5_0.unlockBuildIdMap[arg_5_1] = true

	local var_5_1 = var_5_0.type
	local var_5_2, var_5_3 = arg_5_0:getOrCreateBuildingMo(var_5_1)

	if var_5_3 then
		var_5_2:initParams(var_5_1, 0)
	end
end

function var_0_0._onGetBuildingInfos(arg_6_0, arg_6_1)
	arg_6_0.buildingDict = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		arg_6_0:updateBuildingInfo(iter_6_1)
	end
end

function var_0_0.updateBuildingInfo(arg_7_0, arg_7_1)
	arg_7_0:getOrCreateBuildingMo(arg_7_1.type):init(arg_7_1)
end

function var_0_0.getBuildingMo(arg_8_0, arg_8_1)
	return arg_8_0.buildingDict and arg_8_0.buildingDict[arg_8_1]
end

function var_0_0.getOrCreateBuildingMo(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:getBuildingMo(arg_9_1)
	local var_9_1 = false

	if not var_9_0 then
		var_9_0 = AssassinBuildingMO.New()
		arg_9_0.buildingDict[arg_9_1] = var_9_0
		var_9_1 = true
	end

	return var_9_0, var_9_1
end

function var_0_0.getBuildingStatus(arg_10_0, arg_10_1)
	local var_10_0 = AssassinEnum.BuildingStatus.Locked

	if arg_10_0.unlockBuildIdMap[arg_10_1] then
		local var_10_1 = AssassinConfig.instance:getBuildingCo(arg_10_1)
		local var_10_2 = arg_10_0:getBuildingMo(var_10_1.type):getLv()

		if var_10_2 >= var_10_1.level then
			var_10_0 = AssassinEnum.BuildingStatus.LevelUp
		elseif var_10_2 == var_10_1.level - 1 then
			var_10_0 = AssassinEnum.BuildingStatus.Unlocked
		end
	end

	return var_10_0
end

function var_0_0.isBuildingUnlocked(arg_11_0, arg_11_1)
	return arg_11_1 and arg_11_0.unlockBuildIdMap[arg_11_1] == true
end

function var_0_0.isBuildingTypeUnlocked(arg_12_0, arg_12_1)
	return arg_12_0:getBuildingMo(arg_12_1) ~= nil
end

function var_0_0.isBuildingLevelUp2NextLv(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:getBuildingMo(arg_13_1)
	local var_13_1 = var_13_0 and var_13_0:getLv() or 0
	local var_13_2 = var_13_1 + 1
	local var_13_3 = var_13_0 and var_13_0:isMaxLv()

	if var_13_2 <= var_13_1 or var_13_3 then
		return
	end

	local var_13_4 = AssassinConfig.instance:getBuildingLvCo(arg_13_1, var_13_2)
	local var_13_5 = var_13_4 and var_13_4.id

	if not arg_13_0:isBuildingUnlocked(var_13_5) then
		return
	end

	if var_13_4.cost > AssassinController.instance:getCoinNum() then
		return
	end

	return true, var_13_5
end

function var_0_0.isAnyBuildingLevelUp2NextLv(arg_14_0)
	for iter_14_0, iter_14_1 in pairs(arg_14_0.buildingDict) do
		if arg_14_0:isBuildingLevelUp2NextLv(iter_14_1:getType()) then
			return true
		end
	end
end

return var_0_0
