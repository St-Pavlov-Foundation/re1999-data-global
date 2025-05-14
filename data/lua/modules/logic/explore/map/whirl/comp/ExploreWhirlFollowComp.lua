module("modules.logic.explore.map.whirl.comp.ExploreWhirlFollowComp", package.seeall)

local var_0_0 = class("ExploreWhirlFollowComp", LuaCompBase)
local var_0_1 = {
	Down = -1,
	Up = 1
}

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._whirl = arg_1_1
	arg_1_0._isPause = false
end

function var_0_0.setup(arg_2_0, arg_2_1)
	arg_2_0._go = arg_2_1
	arg_2_0._trans = arg_2_1.transform
	arg_2_0._minHeight = 0.6
	arg_2_0._maxHeight = 0.8
	arg_2_0._radius = 0.4
	arg_2_0._upDownSpeed = 0.003
	arg_2_0._moveSpeed = 0.05
	arg_2_0._rotateSpeed = 1
	arg_2_0._nowHeight = 0.7
	arg_2_0._nowDir = var_0_1.Up
end

function var_0_0.start(arg_3_0)
	arg_3_0._isPause = false

	arg_3_0:onUpdatePos()
end

function var_0_0.pause(arg_4_0)
	arg_4_0._isPause = true
end

function var_0_0.onUpdate(arg_5_0)
	if not arg_5_0._go or arg_5_0._isPause then
		return
	end

	arg_5_0:onUpdatePos()
end

function var_0_0._getHero(arg_6_0)
	return ExploreController.instance:getMap():getHero()
end

function var_0_0.onUpdatePos(arg_7_0)
	local var_7_0 = arg_7_0:_getHero()._displayTr
	local var_7_1 = var_7_0.position
	local var_7_2 = -var_7_0.forward:Mul(arg_7_0._radius) + var_7_1

	if arg_7_0._nowDir == var_0_1.Up then
		arg_7_0._nowHeight = arg_7_0._nowHeight + arg_7_0._upDownSpeed

		if arg_7_0._nowHeight >= arg_7_0._maxHeight then
			arg_7_0._nowDir = var_0_1.Down
		end
	else
		arg_7_0._nowHeight = arg_7_0._nowHeight - arg_7_0._upDownSpeed

		if arg_7_0._nowHeight <= arg_7_0._minHeight then
			arg_7_0._nowDir = var_0_1.Up
		end
	end

	var_7_2.y = arg_7_0._nowHeight

	arg_7_0._trans:Rotate(0, arg_7_0._rotateSpeed, 0)

	local var_7_3 = arg_7_0._trans.position:Sub(var_7_2):SqrMagnitude()

	if var_7_3 > arg_7_0._moveSpeed * arg_7_0._moveSpeed then
		var_7_2 = Vector3.Lerp(arg_7_0._trans.position, var_7_2, arg_7_0._moveSpeed / math.sqrt(var_7_3))

		local var_7_4 = var_7_2 - var_7_1

		var_7_4.y = 0

		if var_7_4:SqrMagnitude() > 1 then
			local var_7_5 = var_7_4:SetNormalize():Add(var_7_1)

			var_7_5.y = var_7_2.y
			var_7_2 = var_7_5
		end

		arg_7_0._trans.position = var_7_2
	else
		arg_7_0._trans.position = var_7_2
	end
end

function var_0_0.onDestroy(arg_8_0)
	arg_8_0._go = nil
	arg_8_0._trans = nil
	arg_8_0._whirl = nil
	arg_8_0._isPause = false
end

return var_0_0
