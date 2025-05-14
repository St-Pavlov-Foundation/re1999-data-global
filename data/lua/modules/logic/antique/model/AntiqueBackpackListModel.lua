module("modules.logic.antique.model.AntiqueBackpackListModel", package.seeall)

local var_0_0 = class("AntiqueBackpackListModel", ListScrollModel)

function var_0_0.init(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._antiqueList = {}
end

function var_0_0.updateModel(arg_3_0)
	arg_3_0:setList(arg_3_0._antiqueList)
end

function var_0_0.getCount(arg_4_0)
	return arg_4_0._antiqueList and #arg_4_0._antiqueList or 0
end

function var_0_0.setAntiqueList(arg_5_0, arg_5_1)
	arg_5_0._antiqueList = arg_5_1

	table.sort(arg_5_0._antiqueList, function(arg_6_0, arg_6_1)
		return arg_6_0.id < arg_6_1.id
	end)
	arg_5_0:setList(arg_5_0._antiqueList)
end

function var_0_0._getAntiqueList(arg_7_0)
	return arg_7_0._antiqueList
end

function var_0_0.clearAntiqueList(arg_8_0)
	arg_8_0._antiqueList = nil

	arg_8_0:clear()
end

var_0_0.instance = var_0_0.New()

return var_0_0
