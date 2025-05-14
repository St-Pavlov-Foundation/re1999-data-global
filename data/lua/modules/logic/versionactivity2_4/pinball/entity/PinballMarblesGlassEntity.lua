module("modules.logic.versionactivity2_4.pinball.entity.PinballMarblesGlassEntity", package.seeall)

local var_0_0 = class("PinballMarblesGlassEntity", PinballMarblesEntity)

function var_0_0.onHitEnter(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	local var_1_0 = PinballEntityMgr.instance:getEntity(arg_1_1)

	if not var_1_0 then
		return
	end

	if var_1_0:isResType() then
		if var_1_0.unitType == PinballEnum.UnitType.ResMine and var_1_0.totalHitCount > arg_1_0.hitNum then
			var_0_0.super.onHitEnter(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
		else
			AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio16)
			var_1_0:doHit(arg_1_0.hitNum)
		end
	else
		var_0_0.super.onHitEnter(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	end
end

function var_0_0.getHitResCount(arg_2_0)
	return arg_2_0.hitNum
end

return var_0_0
