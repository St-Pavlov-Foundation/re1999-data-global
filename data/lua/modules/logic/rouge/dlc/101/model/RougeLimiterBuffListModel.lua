module("modules.logic.rouge.dlc.101.model.RougeLimiterBuffListModel", package.seeall)

local var_0_0 = class("RougeLimiterBuffListModel", ListScrollModel)

function var_0_0.onInit(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0:getBuffCosByType(arg_1_1)

	arg_1_0:setList(var_1_0)
	arg_1_0:try2SelectEquipedBuff()
end

function var_0_0.getBuffCosByType(arg_2_0, arg_2_1)
	local var_2_0 = RougeModel.instance:getVersion()
	local var_2_1 = RougeDLCConfig101.instance:getAllLimiterBuffCosByType(var_2_0, arg_2_1)
	local var_2_2 = {}

	if var_2_1 then
		for iter_2_0, iter_2_1 in ipairs(var_2_1) do
			table.insert(var_2_2, iter_2_1)
		end
	end

	table.sort(var_2_2, arg_2_0._buffSortFunc)

	return var_2_2
end

function var_0_0._buffSortFunc(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0.blank == 1

	if var_3_0 ~= (arg_3_1.blank == 1) then
		return var_3_0
	end

	return arg_3_0.id < arg_3_1.id
end

function var_0_0.try2SelectEquipedBuff(arg_4_0)
	local var_4_0, var_4_1 = arg_4_0:getEquipedBuffId()

	arg_4_0:selectCell(var_4_0, true)
	RougeDLCController101.instance:dispatchEvent(RougeDLCEvent101.OnSelectBuff, var_4_1, true)
end

function var_0_0.getEquipedBuffId(arg_5_0)
	local var_5_0 = arg_5_0:getList()

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		if RougeDLCModel101.instance:getLimiterBuffState(iter_5_1.id) == RougeDLCEnum101.BuffState.Equiped then
			return iter_5_0, iter_5_1.id
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
