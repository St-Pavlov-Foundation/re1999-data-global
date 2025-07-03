module("modules.logic.versionactivity2_7.lengzhou6.model.buff.DamageBuff", package.seeall)

local var_0_0 = class("DamageBuff", BuffBase)

function var_0_0.execute(arg_1_0)
	if var_0_0.super.execute(arg_1_0) and arg_1_0._triggerPoint == LengZhou6GameModel.instance:getCurGameStep() then
		local var_1_0 = LengZhou6GameModel.instance:getPlayer()

		if var_1_0 then
			local var_1_1 = var_1_0:getDamageComp()

			if var_1_1 then
				var_1_1:setExDamage(arg_1_0._layerCount * 1)
			end
		end
	end
end

return var_0_0
