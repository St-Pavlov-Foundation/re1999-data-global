module("modules.logic.settings.model.SettingsKeyTopListModel", package.seeall)

local var_0_0 = class("SettingsKeyTopListModel", ListScrollModel)
local var_0_1 = {
	{
		id = PCInputModel.Activity.MainActivity
	},
	{
		id = PCInputModel.Activity.thrityDoor
	},
	{
		id = PCInputModel.Activity.battle
	},
	{
		id = PCInputModel.Activity.room
	}
}

function var_0_0.InitList(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = pcInputConfig.instance:getKeyBlock()

	for iter_1_0, iter_1_1 in ipairs(var_0_1) do
		local var_1_2 = var_1_1[iter_1_1.id]

		if var_1_2 then
			table.insert(var_1_0, {
				id = iter_1_1.id,
				name = var_1_2.name
			})
		end
	end

	arg_1_0:setList(var_1_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
