module("modules.logic.main.model.MainSwitchCategoryListModel", package.seeall)

local var_0_0 = class("MainSwitchCategoryListModel", ListScrollModel)

function var_0_0.setCategoryId(arg_1_0, arg_1_1)
	arg_1_0.categoryId = arg_1_1

	arg_1_0:onModelUpdate()
end

function var_0_0.getCategoryId(arg_2_0)
	return arg_2_0.categoryId
end

function var_0_0.initCategoryList(arg_3_0)
	arg_3_0.categoryId = MainEnum.SwitchType.Character

	local var_3_0 = {
		{
			id = MainEnum.SwitchType.Character
		},
		{
			id = MainEnum.SwitchType.Scene
		}
	}

	if FightUISwitchModel.instance:isOpenFightUISwitchSystem() then
		table.insert(var_3_0, {
			id = MainEnum.SwitchType.FightUI
		})
	end

	arg_3_0:setList(var_3_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
