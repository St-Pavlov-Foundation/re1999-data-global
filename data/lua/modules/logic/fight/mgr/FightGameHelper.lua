module("modules.logic.fight.mgr.FightGameHelper", package.seeall)

local var_0_0 = {}
local var_0_1

function var_0_0.initGameMgr()
	var_0_0.disposeGameMgr()

	var_0_1 = FightGameMgr.New()
end

function var_0_0.disposeGameMgr()
	if var_0_1 then
		var_0_1:disposeSelf()

		var_0_1 = nil
	end
end

return var_0_0
