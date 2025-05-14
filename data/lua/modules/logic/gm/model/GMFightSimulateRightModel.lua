module("modules.logic.gm.model.GMFightSimulateRightModel", package.seeall)

local var_0_0 = class("GMFightSimulateRightModel", ListScrollModel)

function var_0_0.setChapterId(arg_1_0, arg_1_1)
	local var_1_0 = {}

	for iter_1_0, iter_1_1 in ipairs(lua_episode.configList) do
		if iter_1_1.chapterId == arg_1_1 then
			table.insert(var_1_0, iter_1_1)
		end
	end

	arg_1_0:setList(var_1_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
