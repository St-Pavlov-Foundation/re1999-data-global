module("modules.logic.versionactivity2_4.pinball.entity.PinballMarblesEntity", package.seeall)

local var_0_0 = class("PinballMarblesEntity", PinballColliderEntity)

function var_0_0.onInit(arg_1_0)
	arg_1_0.ay = PinballConst.Const5
	arg_1_0.shape = PinballEnum.Shape.Circle
	arg_1_0.speedScale = 1
	arg_1_0.path = "v2a4_tutushizi_ball_0"
	arg_1_0.decx = PinballConst.Const14
	arg_1_0.decy = PinballConst.Const14
	arg_1_0._isTemp = false
	arg_1_0._hitDict = {}
end

function var_0_0.initByCo(arg_2_0)
	arg_2_0.co = lua_activity178_marbles.configDict[VersionActivity2_4Enum.ActivityId.Pinball][arg_2_0.unitType]
	arg_2_0.path = arg_2_0.co.icon
	arg_2_0.lv = PinballModel.instance:getMarblesLvCache(arg_2_0.unitType)

	local var_2_0 = string.splitToNumber(arg_2_0.co.radius, "#") or {}

	arg_2_0.scale = (var_2_0[arg_2_0.lv] or var_2_0[#var_2_0] or 1000) / 1000 * PinballConst.Const7
	arg_2_0.width = PinballConst.Const6 * arg_2_0.scale
	arg_2_0.height = PinballConst.Const6 * arg_2_0.scale

	local var_2_1 = string.splitToNumber(arg_2_0.co.elasticity, "#") or {}
	local var_2_2 = (var_2_1[arg_2_0.lv] or var_2_1[#var_2_1] or 1000) / 1000

	arg_2_0.baseForceX = var_2_2
	arg_2_0.baseForceY = var_2_2
	arg_2_0.speedScale = arg_2_0.co.velocity / 1000

	local var_2_3 = string.splitToNumber(arg_2_0.co.detectTime, "#") or {}

	arg_2_0.hitNum = var_2_3[arg_2_0.lv] or var_2_3[#var_2_3] or 1

	local var_2_4 = string.splitToNumber(arg_2_0.co.effectTime, "#") or {}

	arg_2_0.effectNum = var_2_4[arg_2_0.lv] or var_2_4[#var_2_4] or 1

	local var_2_5 = string.splitToNumber(arg_2_0.co.effectTime2, "#") or {}

	arg_2_0.effectNum2 = var_2_5[arg_2_0.lv] or var_2_5[#var_2_5] or 1
end

function var_0_0.fixedPos(arg_3_0)
	if arg_3_0.y < PinballConst.Const2 and arg_3_0.vy < 0 then
		arg_3_0:markDead()
	end

	if arg_3_0.y > PinballConst.Const1 and arg_3_0.vy > 0 then
		arg_3_0.vy = -arg_3_0.vy
	end

	if arg_3_0.x + arg_3_0.width > PinballConst.Const3 and arg_3_0.vx > 0 then
		arg_3_0.vx = -arg_3_0.vx

		local var_3_0 = PinballEntityMgr.instance:addEntity(PinballEnum.UnitType.CommonEffect)

		var_3_0:setDelayDispose(2)

		var_3_0.x = arg_3_0.x + arg_3_0.width
		var_3_0.y = arg_3_0.y

		var_3_0:tick(0)
		var_3_0:playAnim("hit")

		if arg_3_0.unitType == PinballEnum.UnitType.MarblesElasticity then
			AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio18)
		else
			AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio13)
		end
	end

	if arg_3_0.x - arg_3_0.width < PinballConst.Const4 and arg_3_0.vx < 0 then
		arg_3_0.vx = -arg_3_0.vx

		local var_3_1 = PinballEntityMgr.instance:addEntity(PinballEnum.UnitType.CommonEffect)

		var_3_1:setDelayDispose(2)

		var_3_1.x = arg_3_0.x - arg_3_0.width
		var_3_1.y = arg_3_0.y

		var_3_1:tick(0)
		var_3_1:playAnim("hit")

		if arg_3_0.unitType == PinballEnum.UnitType.MarblesElasticity then
			AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio18)
		else
			AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio13)
		end
	end
end

function var_0_0.onTick(arg_4_0, arg_4_1)
	if arg_4_0._isTemp then
		return
	end

	arg_4_0.vx = Mathf.Clamp(arg_4_0.vx, PinballConst.Const8, PinballConst.Const9)
	arg_4_0.vy = Mathf.Clamp(arg_4_0.vy, PinballConst.Const10, PinballConst.Const11)

	if math.abs(arg_4_0.vx) < PinballConst.Const12 and math.abs(arg_4_0.vy) < PinballConst.Const12 then
		if not arg_4_0.stopDt then
			arg_4_0.stopDt = 0
		else
			arg_4_0.stopDt = arg_4_0.stopDt + arg_4_1
		end

		if arg_4_0.stopDt > PinballConst.Const13 then
			arg_4_0:markDead()
		end
	else
		arg_4_0.stopDt = nil
	end
end

function var_0_0.canHit(arg_5_0)
	return not arg_5_0._isTemp
end

function var_0_0.isCheckHit(arg_6_0)
	return not arg_6_0._isTemp
end

function var_0_0.setTemp(arg_7_0)
	arg_7_0._isTemp = true
	arg_7_0.ay = 0
end

function var_0_0.getHitResCount(arg_8_0)
	return 1
end

function var_0_0.onHitEnter(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	local var_9_0 = PinballEntityMgr.instance:getEntity(arg_9_1)

	if not var_9_0 then
		return
	end

	if var_9_0:isResType() then
		var_9_0:doHit(arg_9_0:getHitResCount())
	end

	if var_9_0.unitType == PinballEnum.UnitType.TriggerElasticity then
		AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio14)
	elseif arg_9_0.unitType == PinballEnum.UnitType.MarblesElasticity then
		AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio18)
	else
		AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio13)
	end

	if not var_9_0:isBounce() then
		return
	end

	arg_9_0.vx = arg_9_0.vx * arg_9_0.baseForceX * var_9_0.baseForceX
	arg_9_0.vy = arg_9_0.vy * arg_9_0.baseForceY * var_9_0.baseForceY

	local var_9_1 = 0
	local var_9_2 = next(arg_9_0._hitDict)

	if var_9_2 then
		if PinballEntityMgr.instance:getEntity(var_9_2):isOtherType() and not var_9_0:isOtherType() then
			return
		end

		local var_9_3 = arg_9_2 - arg_9_0.x
		local var_9_4 = arg_9_3 - arg_9_0.y

		for iter_9_0, iter_9_1 in pairs(arg_9_0._hitDict) do
			var_9_3 = var_9_3 + iter_9_1.x
			var_9_4 = var_9_4 + iter_9_1.y
		end

		var_9_1 = math.deg(math.atan2(var_9_4, var_9_3))
	else
		local var_9_5 = math.deg(math.atan2(arg_9_0.y - arg_9_3, arg_9_0.x - arg_9_2))
		local var_9_6 = (180 + math.deg(math.atan2(arg_9_0.vy, arg_9_0.vx))) % 360

		var_9_1 = var_9_5 * 2 - var_9_6
		var_9_1 = var_9_1 + math.random(0, 20) - 10
	end

	local var_9_7 = math.sqrt(arg_9_0.vx * arg_9_0.vx + arg_9_0.vy * arg_9_0.vy)

	arg_9_0.vx, arg_9_0.vy = PinballHelper.rotateAngle(var_9_7, 0, var_9_1)

	local var_9_8 = arg_9_0.width - math.sqrt((arg_9_2 - arg_9_0.x)^2 + (arg_9_3 - arg_9_0.y)^2)
	local var_9_9 = math.max(var_9_8, 0.1)

	arg_9_0._hitDict[arg_9_1] = {
		x = arg_9_2 - arg_9_0.x,
		y = arg_9_3 - arg_9_0.y
	}
	arg_9_0.ay = 0
end

function var_0_0.onHitExit(arg_10_0, arg_10_1)
	arg_10_0._hitDict[arg_10_1] = nil

	if not next(arg_10_0._hitDict) then
		arg_10_0.ay = PinballConst.Const5
	end
end

return var_0_0
