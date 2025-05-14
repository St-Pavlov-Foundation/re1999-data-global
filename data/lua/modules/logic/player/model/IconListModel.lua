module("modules.logic.player.model.IconListModel", package.seeall)

local var_0_0 = class("IconListModel", ListScrollModel)

function var_0_0.setIconList(arg_1_0, arg_1_1)
	arg_1_0._moList = {}

	if arg_1_1 then
		arg_1_0._moList = arg_1_1

		table.sort(arg_1_0._moList, function(arg_2_0, arg_2_1)
			return arg_2_0.id < arg_2_1.id
		end)
	end

	arg_1_0:setList(arg_1_0._moList)
end

var_0_0.instance = var_0_0.New()

return var_0_0
