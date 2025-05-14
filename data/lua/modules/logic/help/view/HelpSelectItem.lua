module("modules.logic.help.view.HelpSelectItem", package.seeall)

local var_0_0 = class("HelpSelectItem", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	return
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0._go = arg_2_1.go
	arg_2_0._pageIndex = arg_2_1.index
	arg_2_0._config = arg_2_1.config
	arg_2_0._selectGos = {}

	for iter_2_0 = 1, 2 do
		local var_2_0 = gohelper.findChild(arg_2_0._go, "item" .. tostring(iter_2_0))

		table.insert(arg_2_0._selectGos, var_2_0)
	end

	transformhelper.setLocalPos(arg_2_0._go.transform, arg_2_1.pos, 0, 0)
end

function var_0_0.updateItem(arg_3_0)
	local var_3_0 = arg_3_0._pageIndex == HelpModel.instance:getTargetPageIndex()

	gohelper.setActive(arg_3_0._selectGos[1], var_3_0)
	gohelper.setActive(arg_3_0._selectGos[2], not var_3_0)
end

function var_0_0.addEventListeners(arg_4_0)
	return
end

function var_0_0.removeEventListeners(arg_5_0)
	return
end

function var_0_0.destroy(arg_6_0)
	return
end

return var_0_0
