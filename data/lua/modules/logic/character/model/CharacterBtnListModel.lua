module("modules.logic.character.model.CharacterBtnListModel", package.seeall)

local var_0_0 = class("CharacterBtnListModel", ListScrollModel)

function var_0_0.setCharacterBtnList(arg_1_0, arg_1_1)
	local var_1_0 = {}

	if arg_1_1 then
		for iter_1_0, iter_1_1 in LuaUtil.pairsByKeys(arg_1_1) do
			local var_1_1 = CharacterBtnMo.New()

			var_1_1:init(iter_1_1)
			table.insert(var_1_0, var_1_1)
		end
	end

	arg_1_0:setList(var_1_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
