module("modules.logic.fight.system.work.FightWorkEndLose", package.seeall)

local var_0_0 = class("FightWorkEndLose", BaseWork)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = FightHelper.getAllEntitys()

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		if iter_1_1.nameUI then
			iter_1_1.nameUI:setActive(false)
		end
	end

	arg_1_0:onDone(true)
end

return var_0_0
