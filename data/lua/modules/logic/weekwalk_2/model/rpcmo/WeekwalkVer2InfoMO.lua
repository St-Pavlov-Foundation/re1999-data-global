module("modules.logic.weekwalk_2.model.rpcmo.WeekwalkVer2InfoMO", package.seeall)

local var_0_0 = pureTable("WeekwalkVer2InfoMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.timeId = arg_1_1.timeId
	arg_1_0.startTime = arg_1_1.startTime / 1000
	arg_1_0.endTime = arg_1_1.endTime / 1000
	arg_1_0.popRule = arg_1_1.popRule
	arg_1_0.layerInfos = GameUtil.rpcInfosToMap(arg_1_1.layerInfos, WeekwalkVer2LayerInfoMO)
	arg_1_0.prevSettle = nil

	if arg_1_1:HasField("prevSettle") then
		arg_1_0.prevSettle = WeekwalkVer2PrevSettleInfoMO.New()

		arg_1_0.prevSettle:init(arg_1_1.prevSettle)
	end

	arg_1_0.isPopSettle = arg_1_0.prevSettle and arg_1_0.prevSettle.show
	arg_1_0.snapshotInfos = GameUtil.rpcInfosToMap(arg_1_1.snapshotInfos or {}, WeekwalkVer2SnapshotInfoMO, "no")
	arg_1_0._layerInfosMap = {}

	for iter_1_0, iter_1_1 in pairs(arg_1_0.layerInfos) do
		arg_1_0._layerInfosMap[iter_1_1:getLayer()] = iter_1_1
	end

	local var_1_0 = lua_weekwalk_ver2_time.configDict[arg_1_0.timeId]

	arg_1_0.issueId = var_1_0 and var_1_0.issueId

	if not arg_1_0.issueId then
		logError("WeekwalkVer2InfoMO weekwalk_ver2_time configDict not find timeId:" .. tostring(arg_1_0.timeId))
	end
end

function var_0_0.getOptionSkills(arg_2_0)
	if arg_2_0._skillList and arg_2_0._skillList._timeId == arg_2_0.timeId then
		return arg_2_0._skillList
	end

	local var_2_0 = lua_weekwalk_ver2_time.configDict[arg_2_0.timeId]

	arg_2_0._skillList = string.splitToNumber(var_2_0.optionalSkills, "#")
	arg_2_0._skillList._timeId = arg_2_0.timeId

	return arg_2_0._skillList
end

function var_0_0.getHeroGroupSkill(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0.snapshotInfos[arg_3_1]

	return var_3_0 and var_3_0:getChooseSkillId()
end

function var_0_0.setHeroGroupSkill(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0.snapshotInfos[arg_4_1]

	if not var_4_0 then
		var_4_0 = WeekwalkVer2SnapshotInfoMO.New()
		var_4_0.no = arg_4_1
		arg_4_0.snapshotInfos[arg_4_1] = var_4_0
	end

	var_4_0:setChooseSkillId(arg_4_2)
end

function var_0_0.isOpen(arg_5_0)
	local var_5_0 = ServerTime.now()

	return var_5_0 >= arg_5_0.startTime and var_5_0 <= arg_5_0.endTime
end

function var_0_0.allLayerPass(arg_6_0)
	for iter_6_0, iter_6_1 in pairs(arg_6_0.layerInfos) do
		if not iter_6_1.allPass then
			return false
		end
	end

	return true
end

function var_0_0.setLayerInfo(arg_7_0, arg_7_1)
	arg_7_0.layerInfos[arg_7_1.id]:init(arg_7_1)
end

function var_0_0.getLayerInfo(arg_8_0, arg_8_1)
	return arg_8_0.layerInfos[arg_8_1]
end

function var_0_0.getLayerInfoByLayerIndex(arg_9_0, arg_9_1)
	return arg_9_0._layerInfosMap[arg_9_1]
end

function var_0_0.getNotFinishedMap(arg_10_0)
	for iter_10_0 = WeekWalk_2Enum.MaxLayer, 1, -1 do
		local var_10_0 = arg_10_0._layerInfosMap[iter_10_0]

		if var_10_0 and var_10_0.unlock then
			return var_10_0, iter_10_0
		end
	end
end

return var_0_0
