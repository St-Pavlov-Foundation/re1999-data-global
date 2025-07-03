module("modules.logic.versionactivity2_7.lengzhou6.model.buff.LengZhou6BuffSystem", package.seeall)

local var_0_0 = class("LengZhou6BuffSystem")
local var_0_1 = 0

local function var_0_2()
	var_0_1 = var_0_1 + 1

	return var_0_1
end

function var_0_0.addBuffToPlayer(arg_2_0, arg_2_1)
	local var_2_0 = LengZhou6GameModel.instance:getPlayer()

	if var_2_0 then
		local var_2_1 = var_2_0:getBuffByConfigId(arg_2_1)

		if var_2_1 ~= nil then
			var_2_1:addCount(1)
		else
			local var_2_2 = LengZhou6BuffUtils.instance.createBuff(arg_2_1)

			var_2_2:init(var_0_2(), arg_2_1)
			var_2_0:addBuff(var_2_2)
		end
	end

	LengZhou6GameController.instance:dispatchEvent(LengZhou6Event.RefreshBuffItem)
end

function var_0_0.addBuffToEnemy(arg_3_0, arg_3_1)
	local var_3_0 = LengZhou6GameModel.instance:getEnemy()

	if var_3_0 then
		local var_3_1 = var_3_0:getBuffByConfigId(arg_3_1)

		if var_3_1 ~= nil then
			var_3_1:addCount(1)
		else
			local var_3_2 = LengZhou6BuffUtils.instance.createBuff(arg_3_1)

			var_3_2:init(var_0_2(), arg_3_1)
			var_3_0:addBuff(var_3_2)
		end
	end

	LengZhou6GameController.instance:dispatchEvent(LengZhou6Event.RefreshBuffItem)
end

var_0_0.instance = var_0_0.New()

return var_0_0
