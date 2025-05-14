module("modules.logic.fight.view.FightTechniqueSelectItem", package.seeall)

local var_0_0 = class("FightTechniqueSelectItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._selectGos = arg_1_0:getUserDataTb_()

	for iter_1_0 = 1, 2 do
		local var_1_0 = gohelper.findChild(arg_1_1, "item" .. iter_1_0)

		table.insert(arg_1_0._selectGos, var_1_0)
	end

	arg_1_0._click = gohelper.getClickWithAudio(arg_1_0.go)
end

function var_0_0.updateItem(arg_2_0, arg_2_1)
	arg_2_0._index = arg_2_1.index
	arg_2_0._id = arg_2_1.id

	transformhelper.setLocalPos(arg_2_0.go.transform, arg_2_1.pos, 0, 0)
end

function var_0_0.setView(arg_3_0, arg_3_1)
	arg_3_0._view = arg_3_1
end

function var_0_0.setSelect(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0._index == arg_4_1

	gohelper.setActive(arg_4_0._selectGos[1], var_4_0)
	gohelper.setActive(arg_4_0._selectGos[2], not var_4_0)
end

function var_0_0.addEventListeners(arg_5_0)
	arg_5_0._click:AddClickListener(arg_5_0._onClickThis, arg_5_0)
end

function var_0_0.removeEventListeners(arg_6_0)
	arg_6_0._click:RemoveClickListener()
end

function var_0_0.onDestroy(arg_7_0)
	arg_7_0._view = nil
end

function var_0_0._onClickThis(arg_8_0)
	arg_8_0._view:setSelect(arg_8_0._index)
end

return var_0_0
