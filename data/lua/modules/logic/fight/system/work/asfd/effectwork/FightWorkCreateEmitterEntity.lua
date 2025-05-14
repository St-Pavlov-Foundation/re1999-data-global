module("modules.logic.fight.system.work.asfd.effectwork.FightWorkCreateEmitterEntity", package.seeall)

local var_0_0 = class("FightWorkCreateEmitterEntity", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = GameSceneMgr.instance:getCurScene()
	local var_1_1 = var_1_0 and var_1_0.entityMgr

	if not var_1_1 then
		return arg_1_0:onDone(true)
	end

	var_1_1:addASFDUnit()
	arg_1_0:onDone(true)
end

return var_0_0
