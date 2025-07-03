module("modules.logic.fight.system.work.FightWorkTriggerResistance", package.seeall)

local var_0_0 = class("FightWorkTriggerResistance", FightEffectBase)

var_0_0.effectPath = "buff/buff_streamer"
var_0_0.hangPoint = "mountroot"
var_0_0.relaseTime = 2

function var_0_0.onStart(arg_1_0)
	local var_1_0 = FightHelper.getEntity(arg_1_0.actEffectData.targetId)

	if not var_1_0 then
		arg_1_0:onDone(true)

		return
	end

	local var_1_1 = var_1_0.effect:addHangEffect(var_0_0.effectPath, var_0_0.hangPoint, nil, var_0_0.relaseTime)

	var_1_1:setLocalPos(0, 0, 0)
	FightRenderOrderMgr.instance:onAddEffectWrap(var_1_0.id, var_1_1)
	arg_1_0:onDone(true)
end

return var_0_0
