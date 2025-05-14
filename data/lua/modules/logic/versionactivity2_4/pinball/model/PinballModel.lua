module("modules.logic.versionactivity2_4.pinball.model.PinballModel", package.seeall)

local var_0_0 = class("PinballModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._buildingInfo = {}
	arg_1_0._resInfo = {}
	arg_1_0._unlockTalents = {}
	arg_1_0.day = 0
	arg_1_0.restCdDay = 0
	arg_1_0.maxProsperity = 0
	arg_1_0.isGuideAddGrain = false
	arg_1_0.gameAddResDict = {}
	arg_1_0.leftEpisodeId = 0
	arg_1_0.marblesLvDict = {}
	arg_1_0._gmball = 0
	arg_1_0._gmUnlockAll = false
	arg_1_0._gmkey = false
	arg_1_0._talentRedDict = {}
	arg_1_0.guideHole = 1
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._buildingInfo = {}
	arg_2_0._resInfo = {}
	arg_2_0._unlockTalents = {}
	arg_2_0.day = 0
	arg_2_0.gameAddResDict = {}
end

function var_0_0.isOpen(arg_3_0)
	return ActivityHelper.getActivityStatus(VersionActivity2_4Enum.ActivityId.Pinball, true) == ActivityEnum.ActivityStatus.Normal
end

function var_0_0.initData(arg_4_0, arg_4_1)
	arg_4_0.day = arg_4_1.day
	arg_4_0.oper = arg_4_1.oper
	arg_4_0.restCdDay = arg_4_1.restCdDay
	arg_4_0.maxProsperity = arg_4_1.maxProsperity
	arg_4_0.isGuideAddGrain = arg_4_1.isGuideAddGrain
	arg_4_0._buildingInfo = {}
	arg_4_0._resInfo = {}
	arg_4_0._unlockTalents = {}
	arg_4_0.gameAddResDict = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1.buildings) do
		arg_4_0._buildingInfo[iter_4_1.index] = PinballBuildingMo.New()

		arg_4_0._buildingInfo[iter_4_1.index]:init(iter_4_1)
	end

	for iter_4_2, iter_4_3 in ipairs(arg_4_1.currencys) do
		arg_4_0._resInfo[iter_4_3.type] = PinballCurrencyMo.New()

		arg_4_0._resInfo[iter_4_3.type]:init(iter_4_3)
	end

	for iter_4_4, iter_4_5 in ipairs(arg_4_1.talentIds) do
		local var_4_0 = PinballTalentMo.New()

		var_4_0:init(iter_4_5)

		arg_4_0._unlockTalents[iter_4_5] = var_4_0
	end

	arg_4_0:checkTalentRed()
	PinballController.instance:dispatchEvent(PinballEvent.DataInited)
end

function var_0_0.unlockTalent(arg_5_0, arg_5_1)
	local var_5_0 = PinballTalentMo.New()

	var_5_0:init(arg_5_1)

	arg_5_0._unlockTalents[arg_5_1] = var_5_0

	arg_5_0:checkTalentRed()
end

function var_0_0.getTalentMo(arg_6_0, arg_6_1)
	return arg_6_0._unlockTalents[arg_6_1]
end

function var_0_0.getBuildingNum(arg_7_0, arg_7_1)
	local var_7_0 = 0

	for iter_7_0, iter_7_1 in pairs(arg_7_0._buildingInfo) do
		if iter_7_1.baseCo.id == arg_7_1 then
			var_7_0 = var_7_0 + 1
		end
	end

	return var_7_0
end

function var_0_0.onCurrencyChange(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
		arg_8_0._resInfo[iter_8_1.type] = arg_8_0._resInfo[iter_8_1.type] or PinballCurrencyMo.New()

		arg_8_0._resInfo[iter_8_1.type]:init(iter_8_1)
	end

	arg_8_0:checkTalentRed()
end

function var_0_0.getScoreLevel(arg_9_0)
	local var_9_0 = arg_9_0:getResNum(PinballEnum.ResType.Score)

	return PinballConfig.instance:getScoreLevel(VersionActivity2_4Enum.ActivityId.Pinball, var_9_0)
end

function var_0_0.setCurrency(arg_10_0, arg_10_1)
	if not arg_10_0._resInfo[arg_10_1.type] then
		arg_10_0._resInfo[arg_10_1.type] = PinballCurrencyMo.New()
	end

	arg_10_0._resInfo[arg_10_1.type]:init(arg_10_1)
end

function var_0_0.getResNum(arg_11_0, arg_11_1)
	if not arg_11_0._resInfo[arg_11_1] then
		return 0, 0
	end

	return arg_11_0._resInfo[arg_11_1].num, arg_11_0._resInfo[arg_11_1].changeNum
end

function var_0_0.getTotalFoodCost(arg_12_0)
	local var_12_0 = 0

	for iter_12_0, iter_12_1 in pairs(arg_12_0._buildingInfo) do
		var_12_0 = var_12_0 + iter_12_1:getFoodCost()
	end

	return var_12_0
end

function var_0_0.getTotalPlayDemand(arg_13_0)
	local var_13_0 = 0

	for iter_13_0, iter_13_1 in pairs(arg_13_0._buildingInfo) do
		var_13_0 = var_13_0 + iter_13_1:getPlayDemand()
	end

	local var_13_1 = var_13_0 - arg_13_0:getPlayDec()

	return (math.max(0, var_13_1))
end

function var_0_0.getCostDec(arg_14_0)
	local var_14_0 = 0

	for iter_14_0, iter_14_1 in pairs(arg_14_0._unlockTalents) do
		var_14_0 = var_14_0 + iter_14_1:getCostDec()
	end

	return var_14_0
end

function var_0_0.getResAdd(arg_15_0, arg_15_1)
	local var_15_0 = 0

	for iter_15_0, iter_15_1 in pairs(arg_15_0._unlockTalents) do
		var_15_0 = var_15_0 + iter_15_1:getResAdd(arg_15_1)
	end

	return var_15_0
end

function var_0_0.checkTalentRed(arg_16_0)
	arg_16_0._talentRedDict = {}

	for iter_16_0, iter_16_1 in pairs(arg_16_0._buildingInfo) do
		if iter_16_1.baseCo.type == PinballEnum.BuildingType.Talent then
			local var_16_0 = iter_16_1.level
			local var_16_1 = 1
			local var_16_2 = GameUtil.splitString2(iter_16_1.baseCo.effect, true) or {}

			for iter_16_2, iter_16_3 in pairs(var_16_2) do
				if iter_16_3[1] == PinballEnum.BuildingEffectType.UnlockTalent then
					var_16_1 = iter_16_3[2]

					break
				end
			end

			local var_16_3 = PinballConfig.instance:getTalentCoByRoot(VersionActivity2_4Enum.ActivityId.Pinball, var_16_1)

			for iter_16_4, iter_16_5 in pairs(var_16_3) do
				local var_16_4 = iter_16_5.needLv

				if not arg_16_0:getTalentMo(iter_16_5.id) and var_16_4 <= var_16_0 then
					local var_16_5 = string.splitToNumber(iter_16_5.condition, "#") or {}
					local var_16_6 = true

					for iter_16_6, iter_16_7 in pairs(var_16_5) do
						if not arg_16_0:getTalentMo(iter_16_7) then
							var_16_6 = false

							break
						end
					end

					if var_16_6 then
						local var_16_7 = iter_16_5.cost

						if not string.nilorempty(var_16_7) then
							local var_16_8 = GameUtil.splitString2(var_16_7, true)

							for iter_16_8, iter_16_9 in pairs(var_16_8) do
								if iter_16_9[2] > arg_16_0:getResNum(iter_16_9[1]) then
									var_16_6 = false

									break
								end
							end
						end
					end

					if var_16_6 then
						arg_16_0._talentRedDict[iter_16_1.baseCo.id] = true

						break
					end
				end
			end
		end
	end

	PinballController.instance:dispatchEvent(PinballEvent.TalentRedChange)
end

function var_0_0.getTalentRed(arg_17_0, arg_17_1)
	return arg_17_0._talentRedDict[arg_17_1] or false
end

function var_0_0.getPlayDec(arg_18_0)
	local var_18_0 = 0

	for iter_18_0, iter_18_1 in pairs(arg_18_0._unlockTalents) do
		var_18_0 = var_18_0 + iter_18_1:getPlayDec()
	end

	return var_18_0
end

function var_0_0.getMarblesLv(arg_19_0, arg_19_1)
	local var_19_0 = 1

	for iter_19_0, iter_19_1 in pairs(arg_19_0._unlockTalents) do
		var_19_0 = math.max(iter_19_1:getMarblesLv(arg_19_1), var_19_0)
	end

	return var_19_0
end

function var_0_0.getMarblesIsUnlock(arg_20_0, arg_20_1)
	for iter_20_0, iter_20_1 in pairs(arg_20_0._unlockTalents) do
		if iter_20_1:getIsUnlockMarbles(arg_20_1) then
			return true
		end
	end

	return false
end

function var_0_0.getAllMarblesNum(arg_21_0)
	local var_21_0 = {}
	local var_21_1 = {}
	local var_21_2 = PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.DefaultMarblesHoleNum)
	local var_21_3, var_21_4 = PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.DefaultMarblesNum)
	local var_21_5 = GameUtil.splitString2(var_21_4, true) or {}

	for iter_21_0, iter_21_1 in pairs(var_21_5) do
		var_21_0[iter_21_1[1]] = iter_21_1[2]
	end

	for iter_21_2 = 1, 5 do
		var_21_0[iter_21_2] = var_21_0[iter_21_2] or 0

		if arg_21_0:getMarblesIsUnlock(iter_21_2) then
			local var_21_6 = arg_21_0:getMarblesLv(iter_21_2)

			var_21_1[iter_21_2] = var_21_6

			local var_21_7 = lua_activity178_marbles.configDict[VersionActivity2_4Enum.ActivityId.Pinball][iter_21_2]
			local var_21_8 = string.splitToNumber(var_21_7.limit, "#") or {}

			var_21_0[iter_21_2] = var_21_0[iter_21_2] + (var_21_8[var_21_6] or var_21_8[#var_21_8] or 0)
		end
	end

	if arg_21_0._gmUnlockAll then
		for iter_21_3 = 1, 5 do
			var_21_0[iter_21_3] = 5
			var_21_1[iter_21_3] = 4
		end
	end

	local var_21_9 = var_21_2
	local var_21_10 = var_0_0.instance:getResNum(PinballEnum.ResType.Complaint)

	if var_21_10 >= PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.ComplaintLimit) then
		var_21_2 = var_21_2 - PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.ComplaintMaxSubHoleNum)
	elseif var_21_10 >= PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.ComplaintThreshold) then
		var_21_2 = var_21_2 - PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.ComplaintThresholdSubHoleNum)
	end

	arg_21_0.marblesLvDict = var_21_1

	return var_21_0, var_21_2, var_21_9
end

function var_0_0.getMarblesLvCache(arg_22_0, arg_22_1)
	return arg_22_0.marblesLvDict[arg_22_1] or 1
end

function var_0_0.addGameRes(arg_23_0, arg_23_1, arg_23_2)
	arg_23_0.gameAddResDict[arg_23_1] = arg_23_0.gameAddResDict[arg_23_1] or 0
	arg_23_0.gameAddResDict[arg_23_1] = arg_23_0.gameAddResDict[arg_23_1] + arg_23_2

	PinballController.instance:dispatchEvent(PinballEvent.GameResChange)
end

function var_0_0.getGameRes(arg_24_0, arg_24_1)
	local var_24_0 = 0

	if not arg_24_1 or arg_24_1 == 0 then
		for iter_24_0, iter_24_1 in pairs(arg_24_0.gameAddResDict) do
			var_24_0 = var_24_0 + iter_24_1
		end
	else
		var_24_0 = arg_24_0.gameAddResDict[arg_24_1] or 0
	end

	return var_24_0
end

function var_0_0.clearGameRes(arg_25_0)
	arg_25_0.gameAddResDict = {}
end

function var_0_0.getBuildingInfo(arg_26_0, arg_26_1)
	return arg_26_0._buildingInfo[arg_26_1]
end

function var_0_0.getBuildingInfoById(arg_27_0, arg_27_1)
	for iter_27_0, iter_27_1 in pairs(arg_27_0._buildingInfo) do
		if iter_27_1.baseCo.id == arg_27_1 then
			return iter_27_1
		end
	end
end

function var_0_0.getAllTalentBuildingId(arg_28_0)
	local var_28_0 = {}

	for iter_28_0, iter_28_1 in pairs(arg_28_0._buildingInfo) do
		if iter_28_1.baseCo.type == PinballEnum.BuildingType.Talent then
			table.insert(var_28_0, iter_28_1.baseCo.id)
		end
	end

	table.sort(var_28_0)

	return var_28_0
end

function var_0_0.addBuilding(arg_29_0, arg_29_1, arg_29_2)
	if arg_29_0._buildingInfo[arg_29_2] then
		logError("建筑已存在？？" .. arg_29_2)
	end

	local var_29_0 = {
		food = 0,
		interact = 0,
		level = 1,
		configId = arg_29_1,
		index = arg_29_2
	}

	arg_29_0._buildingInfo[arg_29_2] = PinballBuildingMo.New()

	arg_29_0._buildingInfo[arg_29_2]:init(var_29_0)
	arg_29_0:checkTalentRed()
	PinballController.instance:dispatchEvent(PinballEvent.AddBuilding, arg_29_2)
end

function var_0_0.upgradeBuilding(arg_30_0, arg_30_1)
	if not arg_30_0._buildingInfo[arg_30_1] then
		logError("建筑不存在？？" .. arg_30_1)

		return
	end

	arg_30_0._buildingInfo[arg_30_1]:upgrade()
	arg_30_0:checkTalentRed()
	PinballController.instance:dispatchEvent(PinballEvent.UpgradeBuilding, arg_30_1)
end

function var_0_0.removeBuilding(arg_31_0, arg_31_1)
	if not arg_31_0._buildingInfo[arg_31_1] then
		logError("建筑不存在？？" .. arg_31_1)
	end

	arg_31_0._buildingInfo[arg_31_1] = nil

	PinballController.instance:dispatchEvent(PinballEvent.RemoveBuilding, arg_31_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
