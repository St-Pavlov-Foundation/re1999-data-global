module("modules.logic.fight.mgr.FightGameHelper", package.seeall)

local var_0_0 = {}

function var_0_0.initGameMgr()
	var_0_0.disposeGameMgr()

	var_0_0.lastMgr = FightGameMgr.New()
end

function var_0_0.disposeGameMgr()
	if var_0_0.lastMgr then
		var_0_0.lastMgr:disposeSelf()

		var_0_0.lastMgr = nil
	end
end

return var_0_0
