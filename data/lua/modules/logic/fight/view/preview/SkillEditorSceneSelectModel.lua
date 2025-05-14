module("modules.logic.fight.view.preview.SkillEditorSceneSelectModel", package.seeall)

local var_0_0 = class("SkillEditorSceneSelectModel", ListScrollModel)

function var_0_0.setSelect(arg_1_0, arg_1_1)
	local var_1_0 = {}
	local var_1_1 = lua_scene_level.configList

	for iter_1_0, iter_1_1 in ipairs(var_1_1) do
		local var_1_2 = lua_scene.configDict[iter_1_1.sceneId]

		if string.find(tostring(iter_1_1.id), arg_1_1) or var_1_2 and string.find(var_1_2.name or "", arg_1_1) then
			local var_1_3 = {
				id = iter_1_0,
				co = iter_1_1
			}

			table.insert(var_1_0, var_1_3)
		end
	end

	arg_1_0:setList(var_1_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
