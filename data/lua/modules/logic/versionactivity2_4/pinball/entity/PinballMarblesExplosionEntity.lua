module("modules.logic.versionactivity2_4.pinball.entity.PinballMarblesExplosionEntity", package.seeall)

local var_0_0 = class("PinballMarblesExplosionEntity", PinballMarblesEntity)

function var_0_0.initByCo(arg_1_0)
	var_0_0.super.initByCo(arg_1_0)

	arg_1_0._totalExplosion = arg_1_0.effectNum
	arg_1_0._range = arg_1_0.width * arg_1_0.effectNum2
	arg_1_0._curExplosionNum = 0
end

function var_0_0.onHitExit(arg_2_0, arg_2_1)
	var_0_0.super.onHitExit(arg_2_0, arg_2_1)

	local var_2_0 = PinballEntityMgr.instance:getEntity(arg_2_1)

	if not var_2_0 then
		return
	end

	if arg_2_0._curExplosionNum < arg_2_0._totalExplosion and var_2_0:isResType() then
		arg_2_0:doExplosion()
	end
end

function var_0_0.doExplosion(arg_3_0)
	AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio15)

	local var_3_0 = PinballEntityMgr.instance:addEntity(PinballEnum.UnitType.CommonEffect)

	var_3_0:setDelayDispose(2)

	var_3_0.x = arg_3_0.x
	var_3_0.y = arg_3_0.y

	var_3_0:tick(0)
	var_3_0:setScale(arg_3_0.effectNum2 * 0.4 * arg_3_0.scale / 3)
	var_3_0:playAnim("explode")

	local var_3_1 = PinballEntityMgr.instance:getAllEntity()
	local var_3_2 = arg_3_0.width
	local var_3_3 = arg_3_0.height

	arg_3_0.width = arg_3_0._range
	arg_3_0.height = arg_3_0._range

	for iter_3_0, iter_3_1 in pairs(var_3_1) do
		if iter_3_1:isResType() and not iter_3_1.isDead and PinballHelper.getHitInfo(arg_3_0, iter_3_1) then
			iter_3_1:doHit(arg_3_0.hitNum)
		end
	end

	arg_3_0.width, arg_3_0.height = var_3_2, var_3_3
	arg_3_0._curExplosionNum = arg_3_0._curExplosionNum + 1
end

return var_0_0
