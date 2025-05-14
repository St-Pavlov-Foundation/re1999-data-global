module("modules.logic.versionactivity1_6.v1a6_cachot.config.V1a6_CachotCollectionConfig", package.seeall)

local var_0_0 = class("V1a6_CachotCollectionConfig", BaseConfig)

function var_0_0.onInit(arg_1_0)
	arg_1_0._collectionConfigTable = nil
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"rogue_collection",
		"rogue_collection_enchant",
		"rogue_collecion_unlock_task"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "rogue_collection" then
		arg_3_0:onRogueCollectionConfigLoaded(arg_3_2)
	elseif arg_3_1 == "rogue_collection_enchant" then
		arg_3_0._enchantConfigTable = arg_3_2
	end
end

function var_0_0.onRogueCollectionConfigLoaded(arg_4_0, arg_4_1)
	arg_4_0._collectionConfigTable = arg_4_1
	arg_4_0._collectionTypeMap = arg_4_0._collectionTypeMap or {}
	arg_4_0._collectionGroupMap = arg_4_0._collectionGroupMap or {}

	if arg_4_1.configDict then
		for iter_4_0, iter_4_1 in ipairs(arg_4_1.configList) do
			arg_4_0._collectionTypeMap[iter_4_1.type] = arg_4_0._collectionTypeMap[iter_4_1.type] or {}
			arg_4_0._collectionGroupMap[iter_4_1.group] = arg_4_0._collectionGroupMap[iter_4_1.group] or {}

			table.insert(arg_4_0._collectionTypeMap[iter_4_1.type], iter_4_1)
			table.insert(arg_4_0._collectionGroupMap[iter_4_1.group], iter_4_1)
		end
	end
end

function var_0_0.getAllConfig(arg_5_0)
	return arg_5_0._collectionConfigTable.configList
end

function var_0_0.getCollectionConfig(arg_6_0, arg_6_1)
	if arg_6_0._collectionConfigTable.configDict then
		return arg_6_0._collectionConfigTable.configDict[arg_6_1]
	end
end

function var_0_0.getCollectionConfigsByType(arg_7_0, arg_7_1)
	return arg_7_0._collectionTypeMap and arg_7_0._collectionTypeMap[arg_7_1]
end

function var_0_0.getCollectionSkillsByConfig(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1 and arg_8_1.skills

	if var_8_0 then
		local var_8_1 = {}
		local var_8_2 = GameUtil.splitString2(var_8_0, true)

		if var_8_2 then
			for iter_8_0 = 1, #var_8_2 do
				local var_8_3 = var_8_2[iter_8_0][3]

				table.insert(var_8_1, var_8_3)
			end
		end

		return var_8_1
	end
end

function var_0_0.getCollectionSkillsInfo(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1 and arg_9_1.skills
	local var_9_1 = {}
	local var_9_2 = {}
	local var_9_3 = {}

	if var_9_0 then
		local var_9_4 = GameUtil.splitString2(var_9_0, true)

		if var_9_4 then
			for iter_9_0 = 1, #var_9_4 do
				local var_9_5 = var_9_4[iter_9_0][3]
				local var_9_6 = lua_rule.configDict[var_9_5]
				local var_9_7 = var_9_6 and var_9_6.desc
				local var_9_8 = HeroSkillModel.instance:getEffectTagDescIdList(var_9_7)

				table.insert(var_9_1, var_9_5)

				if var_9_8 then
					for iter_9_1, iter_9_2 in ipairs(var_9_8) do
						if not var_9_3[iter_9_2] then
							table.insert(var_9_2, iter_9_2)

							var_9_3[iter_9_2] = true
						end
					end
				end
			end
		end
	end

	return var_9_1, var_9_2
end

function var_0_0.getCollectionSkillsContent(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	arg_10_2 = arg_10_2 or "#4e6698"

	local var_10_0 = arg_10_1 and arg_10_1.skills
	local var_10_1 = ""

	if var_10_0 then
		local var_10_2 = {}
		local var_10_3 = GameUtil.splitString2(var_10_0, true)

		if var_10_3 then
			for iter_10_0 = 1, #var_10_3 do
				local var_10_4 = var_10_3[iter_10_0][3]
				local var_10_5 = lua_rule.configDict[var_10_4]

				if var_10_5 then
					table.insert(var_10_2, var_10_5.desc)
				end
			end
		end

		var_10_1 = table.concat(var_10_2, "\n")
	end

	local var_10_6 = HeroSkillModel.instance:getEffectTagDescFromDescRecursion(var_10_1, arg_10_2)

	if not string.nilorempty(var_10_6) then
		var_10_1 = var_10_1 .. "\n" .. var_10_6
	end

	return (HeroSkillModel.instance:skillDesToSpot(var_10_1, arg_10_3, arg_10_4))
end

function var_0_0.getCollectionSpDescsByConfig(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1 and arg_11_1.spdesc
	local var_11_1 = {}

	if not string.nilorempty(var_11_0) then
		var_11_1 = string.split(var_11_0, "#")
	end

	return var_11_1
end

function var_0_0.getCollectionsByGroupId(arg_12_0, arg_12_1)
	return arg_12_0._collectionGroupMap and arg_12_0._collectionGroupMap[arg_12_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
