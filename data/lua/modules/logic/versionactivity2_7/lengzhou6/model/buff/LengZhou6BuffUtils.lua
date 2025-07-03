module("modules.logic.versionactivity2_7.lengzhou6.model.buff.LengZhou6BuffUtils", package.seeall)

local var_0_0 = class("LengZhou6BuffUtils")
local var_0_1 = {
	[1001] = PoisoningBuff,
	[1002] = StiffBuff,
	[1003] = DamageBuff
}

function var_0_0.createBuff(arg_1_0)
	if var_0_1[arg_1_0] == nil then
		logError("LengZhou6BuffUtils.createBuff: buffIdToBuff[id] == nil, id = " .. arg_1_0)
	end

	return var_0_1[arg_1_0]:New()
end

var_0_0.instance = var_0_0.New()

return var_0_0
