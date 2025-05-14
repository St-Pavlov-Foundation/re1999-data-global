module("modules.logic.character.model.CharacterSkinTagListModel", package.seeall)

local var_0_0 = class("CharacterSkinTagListModel", ListScrollModel)

function var_0_0.updateList(arg_1_0, arg_1_1)
	local var_1_0 = {}

	if string.nilorempty(arg_1_1.storeTag) == false then
		local var_1_1 = string.splitToNumber(arg_1_1.storeTag, "|")

		for iter_1_0, iter_1_1 in ipairs(var_1_1) do
			table.insert(var_1_0, SkinConfig.instance:getSkinStoreTagConfig(iter_1_1))
		end
	end

	arg_1_0:setList(var_1_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
