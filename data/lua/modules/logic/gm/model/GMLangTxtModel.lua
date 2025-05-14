module("modules.logic.gm.model.GMLangTxtModel", package.seeall)

local var_0_0 = class("GMLangTxtModel", ListScrollModel)

function var_0_0.ctor(arg_1_0)
	var_0_0.super.ctor(arg_1_0)

	arg_1_0._allText = {}
	arg_1_0._txtIndex = 1
	arg_1_0.search = ""
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._hasInit = nil
end

function var_0_0.setSearch(arg_3_0, arg_3_1)
	arg_3_0.search = arg_3_1

	arg_3_0:reInit()
	arg_3_0:updateModel()
end

function var_0_0.getSearch(arg_4_0)
	return arg_4_0.search
end

function var_0_0.clearAll(arg_5_0, arg_5_1)
	arg_5_0._allText = {}
	arg_5_0._txtIndex = 1

	arg_5_0:setList({})
end

function var_0_0.addLangTxt(arg_6_0, arg_6_1)
	if arg_6_0._allText[arg_6_1] then
		return
	end

	arg_6_0._allText[arg_6_1] = {
		id = arg_6_0._txtIndex,
		txt = arg_6_1
	}
	arg_6_0._txtIndex = arg_6_0._txtIndex + 1

	arg_6_0:addAtLast(arg_6_0._allText[arg_6_1])
end

function var_0_0.updateModel(arg_7_0)
	if not arg_7_0._hasInit then
		arg_7_0._hasInit = true

		local var_7_0 = {}

		for iter_7_0, iter_7_1 in pairs(arg_7_0._allText) do
			local var_7_1 = true

			if arg_7_0.search then
				var_7_1 = string.find(iter_7_0, arg_7_0.search)
			end

			if var_7_1 then
				table.insert(var_7_0, iter_7_1)
			end
		end

		table.sort(var_7_0, function(arg_8_0, arg_8_1)
			return arg_8_0.id < arg_8_1.id
		end)
		arg_7_0:setList(var_7_0)
	else
		arg_7_0:onModelUpdate()
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
