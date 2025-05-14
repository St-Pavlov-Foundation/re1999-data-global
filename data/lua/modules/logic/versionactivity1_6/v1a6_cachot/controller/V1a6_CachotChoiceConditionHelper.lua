module("modules.logic.versionactivity1_6.v1a6_cachot.controller.V1a6_CachotChoiceConditionHelper", package.seeall)

local var_0_0 = class("V1a6_CachotChoiceConditionHelper")

function var_0_0.getConditionToast(arg_1_0, ...)
	local var_1_0 = var_0_0["conditionType" .. arg_1_0]

	if not var_1_0 then
		logError("未处理当前条件类型")

		return
	end

	return var_1_0(...)
end

function var_0_0.conditionType1(arg_2_0)
	local var_2_0 = V1a6_CachotModel.instance:getRogueInfo()
	local var_2_1 = var_2_0 and var_2_0.collectionCfgMap
	local var_2_2 = var_2_0 and var_2_0.collectionBaseMap
	local var_2_3 = var_2_1 and var_2_1[arg_2_0]
	local var_2_4 = var_2_2 and var_2_2[arg_2_0]
	local var_2_5 = var_2_3 and #var_2_3 > 0
	local var_2_6 = var_2_4 and #var_2_4 > 0

	if not var_2_5 and not var_2_6 then
		return ToastEnum.V1a6CachotToast07, lua_rogue_collection.configDict[arg_2_0].name
	end
end

function var_0_0.conditionType2(arg_3_0, arg_3_1)
	local var_3_0 = V1a6_CachotModel.instance:getRogueInfo().heart

	if var_3_0 < arg_3_0 or arg_3_1 < var_3_0 then
		return ToastEnum.V1a6CachotToast08, arg_3_0, arg_3_1
	end
end

function var_0_0.conditionType3(arg_4_0)
	if arg_4_0 > V1a6_CachotModel.instance:getRogueInfo().coin then
		return ToastEnum.V1a6CachotToast24, arg_4_0
	end
end

function var_0_0.conditionType4(arg_5_0)
	local var_5_0 = V1a6_CachotModel.instance:getRogueInfo()
	local var_5_1 = var_5_0 and var_5_0.collections

	if arg_5_0 > (var_5_1 and #var_5_1 or 0) then
		return ToastEnum.V1a6CachotToast14, arg_5_0
	end
end

function var_0_0.conditionType5(arg_6_0)
	local var_6_0 = V1a6_CachotModel.instance:getRogueInfo()
	local var_6_1 = var_6_0 and var_6_0.collections

	if arg_6_0 < (var_6_1 and #var_6_1 or 0) then
		return ToastEnum.V1a6CachotToast15, arg_6_0
	end
end

function var_0_0.conditionType6(arg_7_0, arg_7_1)
	local var_7_0 = lua_rogue_collection_group.configDict[arg_7_1]
	local var_7_1 = var_0_0.getMatchCollectionNumInBag(arg_7_1)
	local var_7_2 = var_7_0 and var_7_0.dropGroupType or ""

	if var_7_1 < arg_7_0 then
		return ToastEnum.V1a6CachotToast16, arg_7_0, var_7_2
	end
end

function var_0_0.conditionType7(arg_8_0, arg_8_1)
	local var_8_0 = lua_rogue_collection_group.configDict[arg_8_1]
	local var_8_1 = var_0_0.getMatchCollectionNumInBag(arg_8_1)
	local var_8_2 = var_8_0 and var_8_0.dropGroupType or ""

	if arg_8_0 < var_8_1 then
		return ToastEnum.V1a6CachotToast17, arg_8_0, var_8_2
	end
end

function var_0_0.getMatchCollectionNumInBag(arg_9_0)
	local var_9_0 = 0

	if arg_9_0 and arg_9_0 ~= 0 then
		local var_9_1 = V1a6_CachotModel.instance:getRogueInfo()
		local var_9_2 = var_9_1 and var_9_1.collectionCfgMap
		local var_9_3 = V1a6_CachotCollectionConfig.instance:getCollectionsByGroupId(arg_9_0)

		if var_9_3 and var_9_2 then
			for iter_9_0, iter_9_1 in pairs(var_9_3) do
				local var_9_4 = var_9_2[iter_9_1.id]

				var_9_0 = var_9_0 + (var_9_4 and #var_9_4 or 0)
			end
		end
	end

	return var_9_0
end

function var_0_0.conditionType8(arg_10_0)
	local var_10_0 = V1a6_CachotModel.instance:getTeamInfo()

	if not var_10_0 then
		return
	end

	for iter_10_0, iter_10_1 in ipairs(var_10_0.lifes) do
		if arg_10_0 < iter_10_1.lifePercent then
			return ToastEnum.V1a6CachotToast18, arg_10_0
		end
	end
end

function var_0_0.conditionType9(arg_11_0)
	local var_11_0 = V1a6_CachotModel.instance:getTeamInfo()

	if not var_11_0 then
		return
	end

	for iter_11_0, iter_11_1 in ipairs(var_11_0.lifes) do
		if arg_11_0 > iter_11_1.lifePercent then
			return ToastEnum.V1a6CachotToast19, arg_11_0
		end
	end
end

function var_0_0.conditionType10(arg_12_0)
	local var_12_0 = V1a6_CachotModel.instance:getTeamInfo()

	if not var_12_0 then
		return
	end

	for iter_12_0, iter_12_1 in ipairs(var_12_0.lifes) do
		if arg_12_0 >= iter_12_1.lifePercent then
			return ToastEnum.V1a6CachotToast20, arg_12_0
		end
	end
end

function var_0_0.conditionType11(arg_13_0)
	local var_13_0 = V1a6_CachotModel.instance:getTeamInfo()

	if not var_13_0 then
		return
	end

	for iter_13_0, iter_13_1 in ipairs(var_13_0.lifes) do
		if arg_13_0 <= iter_13_1.lifePercent then
			return ToastEnum.V1a6CachotToast21, arg_13_0
		end
	end
end

function var_0_0.conditionType12(arg_14_0)
	if arg_14_0 > V1a6_CachotModel.instance:getRogueInfo().heart then
		return ToastEnum.V1a6CachotToast22, arg_14_0
	end
end

function var_0_0.conditionType13(arg_15_0)
	if arg_15_0 < V1a6_CachotModel.instance:getRogueInfo().heart then
		return ToastEnum.V1a6CachotToast23, arg_15_0
	end
end

return var_0_0
