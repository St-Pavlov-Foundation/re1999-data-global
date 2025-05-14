module("modules.logic.critter.model.CritterMO", package.seeall)

local var_0_0 = pureTable("CritterMO")
local var_0_1 = {}

function var_0_0.ctor(arg_1_0)
	arg_1_0.id = 0
	arg_1_0.uid = 0
	arg_1_0.defineId = 0
	arg_1_0.createTime = 0
	arg_1_0.efficiency = 0
	arg_1_0.patience = 0
	arg_1_0.lucky = 0
	arg_1_0.efficiencyIncrRate = 0
	arg_1_0.patienceIncrRate = 0
	arg_1_0.luckyIncrRate = 0
	arg_1_0.currentMood = 0
	arg_1_0.specialSkin = false
	arg_1_0.lock = false
	arg_1_0.finishTrain = false
	arg_1_0.trainInfo = CritterTrainInfoMO.New()
	arg_1_0.skillInfo = CritterSkillInfoMO.New()
	arg_1_0.workInfo = CritterWorkInfoMO.New()
	arg_1_0.restInfo = CritterRestInfoMO.New()
	arg_1_0.tagAttributeRates = nil
	arg_1_0.isHighQuality = false
	arg_1_0.trainHeroId = 0
	arg_1_0.totalFinishCount = 0
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_1 = arg_2_1 or var_0_1
	arg_2_0.id = arg_2_1.uid or 0
	arg_2_0.uid = arg_2_1.uid or 0
	arg_2_0.defineId = arg_2_1.defineId or 0
	arg_2_0.createTime = arg_2_1.createTime or 0
	arg_2_0.efficiency = arg_2_1.efficiency or 0
	arg_2_0.patience = arg_2_1.patience or 0
	arg_2_0.lucky = arg_2_1.lucky or 0
	arg_2_0.efficiencyIncrRate = arg_2_1.efficiencyIncrRate or 0
	arg_2_0.patienceIncrRate = arg_2_1.patienceIncrRate or 0
	arg_2_0.luckyIncrRate = arg_2_1.luckyIncrRate or 0
	arg_2_0.currentMood = arg_2_1.currentMood or 0
	arg_2_0.specialSkin = arg_2_1.specialSkin == true
	arg_2_0.lock = arg_2_1.lock == true
	arg_2_0.finishTrain = arg_2_1.finishTrain == true
	arg_2_0.isHighQuality = arg_2_1.isHighQuality == true
	arg_2_0.trainHeroId = arg_2_1.trainHeroId or 0
	arg_2_0.totalFinishCount = arg_2_1.totalFinishCount or 0
	arg_2_0.name = arg_2_1.name or ""

	arg_2_0.trainInfo:init(arg_2_1.trainInfo or var_0_1)
	arg_2_0.skillInfo:init(arg_2_1.skillInfo or var_0_1)
	arg_2_0.workInfo:init(arg_2_1.workInfo or var_0_1)
	arg_2_0.restInfo:init(arg_2_1.restInfo or var_0_1)

	arg_2_0.tagAttributeRates = {}

	if arg_2_1.tagAttributeRates then
		for iter_2_0 = 1, #arg_2_1.tagAttributeRates do
			local var_2_0 = arg_2_1.tagAttributeRates[iter_2_0]

			arg_2_0.tagAttributeRates[var_2_0.attributeId] = var_2_0.rate
		end
	end

	arg_2_0:initAttributeInfo()

	local var_2_1 = arg_2_0:getDefineCfg()

	arg_2_0.trainInfo.trainTime = arg_2_0:getTainTime()

	arg_2_0.trainInfo:setCritterMO(arg_2_0)
end

function var_0_0.getId(arg_3_0)
	return arg_3_0.id
end

function var_0_0.getDefineId(arg_4_0)
	return arg_4_0.defineId
end

function var_0_0.refreshCfg(arg_5_0)
	arg_5_0:getDefineCfg()
end

function var_0_0.getTainTime(arg_6_0)
	local var_6_0 = arg_6_0:getDefineCfg()

	if var_6_0 then
		return var_6_0.trainTime * 60 * 60
	end

	return 0
end

function var_0_0.getDefineCfg(arg_7_0)
	if not arg_7_0.config or arg_7_0.config.id ~= arg_7_0.defineId then
		arg_7_0.config = CritterConfig.instance:getCritterCfg(arg_7_0.defineId)
	end

	return arg_7_0.config
end

function var_0_0.getSkinId(arg_8_0)
	local var_8_0 = arg_8_0:getDefineCfg()

	if arg_8_0:isMutate() then
		return var_8_0.mutateSkin
	else
		return var_8_0.normalSkin
	end

	return 0
end

function var_0_0.isCultivating(arg_9_0)
	if arg_9_0.trainInfo.heroId and arg_9_0.trainInfo.heroId ~= 0 and arg_9_0.finishTrain ~= true then
		return true
	end
end

function var_0_0.getWorkBuildingInfo(arg_10_0)
	return arg_10_0.workInfo:getBuildingInfo()
end

function var_0_0.getCultivator(arg_11_0)
	return arg_11_0.trainInfo.heroId
end

function var_0_0.getCultivateProcess(arg_12_0)
	return arg_12_0.trainInfo:getProcess()
end

function var_0_0.isMutate(arg_13_0)
	return arg_13_0.specialSkin == true
end

function var_0_0.getAttributeInfos(arg_14_0)
	return arg_14_0.attributeInfo
end

function var_0_0.getAttributeInfoByType(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0:getAttributeInfos()

	return var_15_0 and var_15_0[arg_15_1]
end

function var_0_0.getAddValuePerHourByType(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0.trainInfo:getEventOptions(CritterEnum.NormalEventId.NormalGrow)
	local var_16_1 = var_16_0 and var_16_0[1]

	if not var_16_1 then
		return 0
	end

	local var_16_2 = var_16_1:getAddAttriuteInfoById(arg_16_1)

	return var_16_2 and var_16_2.value or 0
end

function var_0_0.initAttributeInfo(arg_17_0)
	arg_17_0.attributeInfo = {}

	local var_17_0 = 10000
	local var_17_1 = CritterAttributeInfoMO.New()
	local var_17_2 = CritterEnum.AttributeType.Efficiency
	local var_17_3 = {
		attributeId = var_17_2,
		value = arg_17_0.efficiency * var_17_0,
		rate = arg_17_0.efficiencyIncrRate,
		addRate = arg_17_0.tagAttributeRates[var_17_2]
	}

	var_17_1:init(var_17_3)

	arg_17_0.attributeInfo[var_17_2] = var_17_1

	local var_17_4 = CritterAttributeInfoMO.New()
	local var_17_5 = CritterEnum.AttributeType.Patience
	local var_17_6 = {
		attributeId = var_17_5,
		value = arg_17_0.patience * var_17_0,
		rate = arg_17_0.patienceIncrRate,
		addRate = arg_17_0.tagAttributeRates[var_17_5]
	}

	var_17_4:init(var_17_6)

	arg_17_0.attributeInfo[var_17_5] = var_17_4

	local var_17_7 = CritterAttributeInfoMO.New()
	local var_17_8 = CritterEnum.AttributeType.Lucky
	local var_17_9 = {
		attributeId = var_17_8,
		value = arg_17_0.lucky * var_17_0,
		rate = arg_17_0.luckyIncrRate,
		addRate = arg_17_0.tagAttributeRates[var_17_8]
	}

	var_17_7:init(var_17_9)

	arg_17_0.attributeInfo[var_17_8] = var_17_7
end

function var_0_0.getAdditionAttr(arg_18_0)
	local var_18_0 = {}

	for iter_18_0, iter_18_1 in pairs(arg_18_0:getAttributeInfos()) do
		if iter_18_1:getIsAddition() then
			table.insert(var_18_0, iter_18_0)
		end
	end

	return var_18_0
end

function var_0_0.isAddition(arg_19_0, arg_19_1)
	local var_19_0 = false
	local var_19_1 = arg_19_0:getAttributeInfoByType(arg_19_1)

	if var_19_1 then
		var_19_0 = var_19_1:getIsAddition()
	end

	return var_19_0
end

function var_0_0.getTotalAttrValue(arg_20_0)
	return arg_20_0.efficiency + arg_20_0.patience + arg_20_0.lucky
end

function var_0_0.getMoodValue(arg_21_0)
	local var_21_0 = arg_21_0.currentMood or 0

	return (math.ceil(var_21_0 / CritterEnum.MoodFactor))
end

function var_0_0.isNoMood(arg_22_0)
	return arg_22_0:getMoodValue() <= 0
end

function var_0_0.isNoMoodWorking(arg_23_0)
	local var_23_0 = false
	local var_23_1 = ManufactureModel.instance:getCritterWorkingBuilding(arg_23_0.uid)
	local var_23_2 = RoomMapTransportPathModel.instance:getTransportPathMOByCritterUid(arg_23_0.uid)

	if var_23_1 or var_23_2 then
		var_23_0 = true
	end

	local var_23_3 = arg_23_0:isNoMood()

	return var_23_0 and var_23_3
end

function var_0_0.isLock(arg_24_0)
	return arg_24_0.lock
end

function var_0_0.getIsHighQuality(arg_25_0)
	return arg_25_0.isHighQuality
end

function var_0_0.getSkillInfo(arg_26_0)
	return arg_26_0.skillInfo:getTags()
end

function var_0_0.isMaturity(arg_27_0)
	return arg_27_0.finishTrain
end

function var_0_0.getName(arg_28_0)
	if not string.nilorempty(arg_28_0.name) then
		return arg_28_0.name
	end

	return arg_28_0:getDefineCfg().name
end

function var_0_0.getCatalogueName(arg_29_0)
	local var_29_0 = arg_29_0:getDefineCfg().catalogue
	local var_29_1 = CritterConfig.instance:getCritterCatalogueCfg(var_29_0)

	return var_29_1 and var_29_1.name or ""
end

function var_0_0.getDesc(arg_30_0)
	return arg_30_0:getDefineCfg().desc
end

return var_0_0
