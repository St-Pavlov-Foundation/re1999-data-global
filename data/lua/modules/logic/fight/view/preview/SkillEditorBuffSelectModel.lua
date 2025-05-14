module("modules.logic.fight.view.preview.SkillEditorBuffSelectModel", package.seeall)

local var_0_0 = class("SkillEditorBuffSelectModel", ListScrollModel)

function var_0_0.setSelect(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.attacker = arg_1_1

	local var_1_0 = {}

	for iter_1_0, iter_1_1 in ipairs(lua_skill_buff.configList) do
		if string.find(tostring(iter_1_1.id), arg_1_2) or string.find(iter_1_1.name, arg_1_2) then
			table.insert(var_1_0, {
				id = iter_1_0,
				co = iter_1_1
			})
		end
	end

	arg_1_0:setList(var_1_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
