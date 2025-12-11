module("modules.logic.survival.model.map.SurvivalHexCellMo", package.seeall)

local var_0_0 = class("SurvivalHexCellMo")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.pos = SurvivalHexNode.New(arg_1_1.hex.hex.q, arg_1_1.hex.hex.r)
	arg_1_0.dir = arg_1_1.hex.dir
	arg_1_0.style = arg_1_1.style

	local var_1_0 = lua_survival_walkable.configDict

	arg_1_0.co = var_1_0[arg_1_2] and var_1_0[arg_1_2][arg_1_0.style] or nil

	if not arg_1_0.co then
		logError("可走格子配置不存在" .. tostring(arg_1_2) .. " >> " .. tostring(arg_1_0.style))
	end
end

return var_0_0
