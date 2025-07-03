module("modules.logic.fight.system.work.FightWorkDelCardAndDamage", package.seeall)

local var_0_0 = class("FightWorkDelCardAndDamage", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0

	if arg_1_0.actEffectData.teamType == FightEnum.TeamType.EnemySide then
		var_1_0 = FightHelper.getEntity(FightEntityScene.EnemySideId)
	else
		var_1_0 = FightHelper.getEntity(FightEntityScene.MySideId)
	end

	if var_1_0 then
		local var_1_1 = var_1_0.effect:addGlobalEffect("v2a2_znps/znps_unique_03_hit", nil, 1)

		var_1_1:setRenderOrder(20000)

		local var_1_2 = arg_1_0.actEffectData.teamType == FightEnum.TeamType.EnemySide and -6.14 or 6.14

		var_1_1:setLocalPos(var_1_2, 1.65, -1.74)
		AudioMgr.instance:trigger(410000104)
	end

	arg_1_0:onDone(true)
end

function var_0_0.clearWork(arg_2_0)
	return
end

return var_0_0
