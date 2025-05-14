module("modules.logic.versionactivity2_4.pinball.entity.PinballMarblesDivisionEntity", package.seeall)

local var_0_0 = class("PinballMarblesDivisionEntity", PinballMarblesEntity)
local var_0_1 = {
	Done = 2,
	Hit = 1,
	None = 0
}

function var_0_0.initByCo(arg_1_0)
	var_0_0.super.initByCo(arg_1_0)

	arg_1_0._statu = var_0_1.None
	arg_1_0._canHitNum = 0
end

function var_0_0.onHitEnter(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	var_0_0.super.onHitEnter(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)

	local var_2_0 = PinballEntityMgr.instance:getEntity(arg_2_1)

	if not var_2_0 or not var_2_0:isResType() then
		return
	end

	if arg_2_0._statu == var_0_1.None then
		arg_2_0._statu = var_0_1.Hit
	end

	if arg_2_0._canHitNum > 0 then
		arg_2_0._canHitNum = arg_2_0._canHitNum - 1

		if arg_2_0._canHitNum == 0 then
			arg_2_0:markDead()
		end
	end
end

function var_0_0.onHitExit(arg_3_0, arg_3_1)
	var_0_0.super.onHitExit(arg_3_0, arg_3_1)

	if arg_3_0._statu == var_0_1.Hit then
		arg_3_0._statu = var_0_1.Done

		AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio17)

		for iter_3_0 = 1, arg_3_0.effectNum - 1 do
			local var_3_0 = math.random(0, 360)
			local var_3_1, var_3_2 = PinballHelper.rotateAngle(arg_3_0.width * 2.1, 0, var_3_0)
			local var_3_3 = PinballEntityMgr.instance:addEntity(PinballEnum.UnitType.MarblesDivision)

			var_3_3._statu = var_0_1.Done
			var_3_3.x = arg_3_0.x + var_3_1
			var_3_3.y = arg_3_0.y + var_3_2

			local var_3_4, var_3_5 = PinballHelper.rotateAngle(arg_3_0.vx, arg_3_0.vy, var_3_0)

			var_3_3.vx = var_3_4
			var_3_3.vy = var_3_5
			var_3_3._canHitNum = arg_3_0.effectNum2

			var_3_3:tick(0)
			var_3_3:playAnim("clone")
		end
	end
end

return var_0_0
