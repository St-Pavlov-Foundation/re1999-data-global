module("modules.logic.rouge.model.RougeCollectionOverListModel", package.seeall)

local var_0_0 = class("RougeCollectionOverListModel", ListScrollModel)

function var_0_0.onInitData(arg_1_0)
	arg_1_0:onCollectionDataUpdate()
end

function var_0_0.onCollectionDataUpdate(arg_2_0)
	local var_2_0 = {}
	local var_2_1 = {}
	local var_2_2 = RougeCollectionModel.instance:getSlotAreaCollection()

	if var_2_2 then
		for iter_2_0, iter_2_1 in ipairs(var_2_2) do
			if not var_2_1[iter_2_1.id] then
				var_2_1[iter_2_1.id] = true

				table.insert(var_2_0, iter_2_1)
			end
		end
	end

	table.sort(var_2_0, arg_2_0.sortFunc)
	arg_2_0:setList(var_2_0)
end

function var_0_0.sortFunc(arg_3_0, arg_3_1)
	local var_3_0 = RougeCollectionConfig.instance:getCollectionCfg(arg_3_0.cfgId)
	local var_3_1 = RougeCollectionConfig.instance:getCollectionCfg(arg_3_1.cfgId)
	local var_3_2 = var_3_0 and var_3_0.showRare or 0
	local var_3_3 = var_3_1 and var_3_1.showRare or 0

	if var_3_2 ~= var_3_3 then
		return var_3_3 < var_3_2
	end

	local var_3_4 = RougeCollectionConfig.instance:getOriginEditorParam(arg_3_0.cfgId, RougeEnum.CollectionEditorParamType.Shape)
	local var_3_5 = RougeCollectionConfig.instance:getOriginEditorParam(arg_3_1.cfgId, RougeEnum.CollectionEditorParamType.Shape)
	local var_3_6 = var_3_4 and #var_3_4 or 0
	local var_3_7 = var_3_5 and #var_3_5 or 0

	if var_3_6 ~= var_3_7 then
		return var_3_7 < var_3_6
	end

	return arg_3_0.id < arg_3_1.id
end

function var_0_0.isBagEmpty(arg_4_0)
	return arg_4_0:getCount() <= 0
end

var_0_0.instance = var_0_0.New()

return var_0_0
