module("modules.logic.rouge.dlc.102.config.RougeDLCConfig102", package.seeall)

local var_0_0 = class("RougeDLCConfig102", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"rouge_spcollection_desc",
		"rouge_collection_trammels"
	}
end

function var_0_0.onConfigLoaded(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == "rouge_spcollection_desc" then
		arg_2_0:onSpCollectionDescConfigLoaded(arg_2_2)
	elseif arg_2_1 == "rouge_collection_trammels" then
		arg_2_0._trammelConfigTab = arg_2_2
	end
end

function var_0_0.onSpCollectionDescConfigLoaded(arg_3_0, arg_3_1)
	arg_3_0._descTab = arg_3_1
	arg_3_0._descMap = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.configList) do
		local var_3_0 = iter_3_1.id
		local var_3_1 = arg_3_0._descMap and arg_3_0._descMap[var_3_0]

		if not var_3_1 then
			var_3_1 = {}
			arg_3_0._descMap[var_3_0] = var_3_1
		end

		table.insert(var_3_1, iter_3_1)
	end

	for iter_3_2, iter_3_3 in pairs(arg_3_0._descMap) do
		table.sort(iter_3_3, arg_3_0._spCollectionDescSortFunc)
	end
end

function var_0_0._spCollectionDescSortFunc(arg_4_0, arg_4_1)
	if arg_4_0.effectId ~= arg_4_1.effectId then
		return arg_4_0.effectId < arg_4_1.effectId
	end
end

function var_0_0.getSpCollectionDescCos(arg_5_0, arg_5_1)
	return arg_5_0._descMap and arg_5_0._descMap[arg_5_1]
end

function var_0_0.getCollectionLevelUpCo(arg_6_0, arg_6_1)
	return arg_6_0._levelConfigTab and arg_6_0._levelConfigTab.configDict[arg_6_1]
end

function var_0_0.getAllCollectionTrammelCo(arg_7_0)
	return arg_7_0._trammelConfigTab and arg_7_0._trammelConfigTab.configList
end

function var_0_0.getCollectionOwnerCo(arg_8_0, arg_8_1)
	local var_8_0 = RougeCollectionConfig.instance:getCollectionCfg(arg_8_1)

	if not var_8_0 then
		return
	end

	local var_8_1 = var_8_0.ownerId

	if var_8_1 and var_8_1 ~= 0 then
		return (HeroConfig.instance:getHeroCO(var_8_1))
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
