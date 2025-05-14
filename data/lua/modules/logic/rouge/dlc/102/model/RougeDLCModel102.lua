module("modules.logic.rouge.dlc.102.model.RougeDLCModel102", package.seeall)

local var_0_0 = class("RougeDLCModel102", BaseModel)

function var_0_0.clear(arg_1_0)
	return
end

function var_0_0.getCanLevelUpSpCollectionsInSlotArea(arg_2_0)
	local var_2_0 = {}
	local var_2_1 = RougeCollectionModel.instance:getSlotAreaCollection()

	if var_2_1 then
		for iter_2_0, iter_2_1 in ipairs(var_2_1) do
			if arg_2_0:_checkIsSpCollection(iter_2_1) and not arg_2_0:_checkIsCollectionMaxLevelUp(iter_2_1) then
				table.insert(var_2_0, iter_2_1)
			end
		end
	end

	return var_2_0
end

function var_0_0._checkIsCollectionMaxLevelUp(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1:getAttrValueMap()

	if var_3_0 then
		for iter_3_0, iter_3_1 in pairs(var_3_0) do
			if iter_3_0 == RougeEnum.MaxLevelSpAttrId then
				return true
			end
		end
	end

	return false
end

function var_0_0._checkIsCollectionAllEffectActive(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in pairs(arg_4_1) do
		for iter_4_2, iter_4_3 in pairs(iter_4_1) do
			if not iter_4_3.isActive then
				return false
			end
		end
	end

	return true
end

function var_0_0._checkIsSpCollection(arg_5_0, arg_5_1)
	if arg_5_1 then
		local var_5_0 = arg_5_1:getCollectionCfgId()
		local var_5_1 = RougeCollectionConfig.instance:getCollectionCfg(var_5_0)

		return var_5_1 and var_5_1.type == RougeEnum.CollectionType.Special
	end
end

function var_0_0.getAllSpCollectionsInSlotArea(arg_6_0)
	local var_6_0 = {}
	local var_6_1 = RougeCollectionModel.instance:getSlotAreaCollection()

	if var_6_1 then
		for iter_6_0, iter_6_1 in ipairs(var_6_1) do
			if arg_6_0:_checkIsSpCollection(iter_6_1) then
				table.insert(var_6_0, iter_6_1)
			end
		end
	end

	return var_6_0
end

function var_0_0.getAllSpCollections(arg_7_0)
	local var_7_0 = {}
	local var_7_1 = RougeCollectionModel.instance:getAllCollections()

	if var_7_1 then
		for iter_7_0, iter_7_1 in ipairs(var_7_1) do
			if arg_7_0:_checkIsSpCollection(iter_7_1) then
				table.insert(var_7_0, iter_7_1)
			end
		end
	end

	return var_7_0
end

function var_0_0.getAllSpCollectionCount(arg_8_0)
	local var_8_0 = arg_8_0:getAllSpCollections()

	return var_8_0 and #var_8_0 or 0
end

function var_0_0.getAllCanLevelUpSpCollection(arg_9_0)
	local var_9_0 = {}
	local var_9_1 = RougeCollectionModel.instance:getAllCollections()

	if var_9_1 then
		for iter_9_0, iter_9_1 in ipairs(var_9_1) do
			if arg_9_0:_checkIsSpCollection(iter_9_1) and not arg_9_0:_checkIsCollectionMaxLevelUp(iter_9_1) then
				table.insert(var_9_0, iter_9_1)
			end
		end
	end

	return var_9_0
end

function var_0_0.getAllCanLevelUpSpCollectionCount(arg_10_0)
	local var_10_0 = arg_10_0:getAllCanLevelUpSpCollection()

	return var_10_0 and #var_10_0 or 0
end

var_0_0.instance = var_0_0.New()

return var_0_0
