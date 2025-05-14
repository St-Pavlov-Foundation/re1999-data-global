module("modules.logic.gm.model.GMFightSimulateLeftModel", package.seeall)

local var_0_0 = class("GMFightSimulateLeftModel", ListScrollModel)

function var_0_0.onOpen(arg_1_0)
	local var_1_0 = {}

	for iter_1_0, iter_1_1 in ipairs(lua_chapter.configList) do
		if iter_1_1.type == DungeonEnum.ChapterType.Simulate then
			table.insert(var_1_0, iter_1_1)
		end
	end

	arg_1_0:setList(var_1_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
