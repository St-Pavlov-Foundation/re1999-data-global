module("modules.logic.versionactivity2_7.lengzhou6.model.buff.PoisoningBuff", package.seeall)

local var_0_0 = class("PoisoningBuff", BuffBase)

function var_0_0.execute(arg_1_0)
	if var_0_0.super.execute(arg_1_0) and arg_1_0._triggerPoint == LengZhou6GameModel.instance:getCurGameStep() then
		local var_1_0 = LengZhou6GameModel.instance:getEnemy()

		if var_1_0 then
			var_1_0:changeHp(-arg_1_0._layerCount * 1)

			if isDebugBuild then
				logNormal("中毒伤害：" .. arg_1_0._layerCount * 1)
			end

			LengZhou6EliminateController.instance:dispatchEvent(LengZhou6Event.ShowEnemyEffect, LengZhou6Enum.BuffEffect.poison)
		end
	end
end

return var_0_0
