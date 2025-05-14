module("modules.logic.versionactivity2_4.pinball.entity.PinballTriggerBlackHoleEntity", package.seeall)

local var_0_0 = class("PinballTriggerBlackHoleEntity", PinballTriggerEntity)

function var_0_0.onInitByCo(arg_1_0)
	arg_1_0.groupId = tonumber(arg_1_0.spData) or 0
end

function var_0_0.init(arg_2_0, arg_2_1)
	var_0_0.super.init(arg_2_0, arg_2_1)

	local var_2_0 = gohelper.findChild(arg_2_1, "vx_blackhole")

	gohelper.setActive(var_2_0, true)
end

function var_0_0.isBounce(arg_3_0)
	return false
end

function var_0_0.onHitEnter(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	local var_4_0 = PinballEntityMgr.instance:getEntity(arg_4_1)

	if not var_4_0 or var_4_0.inBlackHoleId then
		return
	end

	local var_4_1

	for iter_4_0, iter_4_1 in pairs(PinballEntityMgr.instance:getAllEntity()) do
		if iter_4_1 ~= arg_4_0 and iter_4_1.unitType == arg_4_0.unitType and iter_4_1.groupId == arg_4_0.groupId then
			var_4_1 = iter_4_1

			break
		end
	end

	if var_4_1 then
		var_4_0.x = var_4_1.x
		var_4_0.y = var_4_1.y

		var_4_0:tick(0)

		var_4_0.inBlackHoleId = arg_4_0.id

		var_4_0:onEnterHole()
	end
end

function var_0_0.onHitExit(arg_5_0, arg_5_1)
	local var_5_0 = PinballEntityMgr.instance:getEntity(arg_5_1)

	if not var_5_0 or not var_5_0.inBlackHoleId or var_5_0.inBlackHoleId == arg_5_0.id then
		return
	end

	var_5_0.inBlackHoleId = nil

	var_5_0:onExitHole()
end

return var_0_0
