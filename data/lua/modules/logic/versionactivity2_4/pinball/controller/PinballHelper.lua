module("modules.logic.versionactivity2_4.pinball.controller.PinballHelper", package.seeall)

local var_0_0 = class("PinballHelper")

function var_0_0.getHitInfo(arg_1_0, arg_1_1)
	if arg_1_0.shape == PinballEnum.Shape.Rect and arg_1_1.shape == PinballEnum.Shape.Rect then
		return var_0_0.getHitRectRect(arg_1_0, arg_1_1)
	elseif arg_1_0.shape == PinballEnum.Shape.Circle and arg_1_1.shape == PinballEnum.Shape.Circle then
		return var_0_0.getHitCirCleCirCle(arg_1_0, arg_1_1)
	elseif arg_1_0.shape == PinballEnum.Shape.Rect and arg_1_1.shape == PinballEnum.Shape.Circle then
		return var_0_0.getHitRectCircle(arg_1_0, arg_1_1)
	elseif arg_1_0.shape == PinballEnum.Shape.Circle and arg_1_1.shape == PinballEnum.Shape.Rect then
		local var_1_0, var_1_1, var_1_2 = var_0_0.getHitRectCircle(arg_1_1, arg_1_0)

		var_1_2 = var_1_2 and -var_1_2

		return var_1_0, var_1_1, var_1_2
	end
end

local var_0_1 = {
	width = 0,
	height = 0,
	angle = 0,
	y = 0,
	x = 0
}
local var_0_2 = {
	width = 0,
	height = 0,
	angle = 0,
	y = 0,
	x = 0
}
local var_0_3 = Vector2()

function var_0_0.getHitRectCircle(arg_2_0, arg_2_1)
	if arg_2_0.angle ~= 0 then
		var_0_3.x = arg_2_1.x - arg_2_0.x
		var_0_3.y = arg_2_1.y - arg_2_0.y
		var_0_1.x = arg_2_0.x + var_0_3.x * math.cos(-arg_2_0.angle * Mathf.Deg2Rad) - var_0_3.y * math.sin(-arg_2_0.angle * Mathf.Deg2Rad)
		var_0_1.y = arg_2_0.y + var_0_3.x * math.sin(-arg_2_0.angle * Mathf.Deg2Rad) + var_0_3.y * math.cos(-arg_2_0.angle * Mathf.Deg2Rad)
		var_0_1.width = arg_2_1.width
		var_0_1.height = arg_2_1.height
		var_0_2.x = arg_2_0.x
		var_0_2.y = arg_2_0.y
		var_0_2.width = arg_2_0.width
		var_0_2.height = arg_2_0.height

		local var_2_0, var_2_1 = var_0_0.getHitRectCircle(var_0_2, var_0_1)

		if var_2_0 then
			var_0_3.x = var_2_0 - arg_2_0.x
			var_0_3.y = var_2_1 - arg_2_0.y
			var_2_0 = arg_2_0.x + var_0_3.x * math.cos(arg_2_0.angle * Mathf.Deg2Rad) - var_0_3.y * math.sin(arg_2_0.angle * Mathf.Deg2Rad)
			var_2_1 = arg_2_0.y + var_0_3.x * math.sin(arg_2_0.angle * Mathf.Deg2Rad) + var_0_3.y * math.cos(arg_2_0.angle * Mathf.Deg2Rad)
		end

		return var_2_0, var_2_1, PinballEnum.Dir.None
	end

	local var_2_2 = math.abs(arg_2_0.x - arg_2_1.x)
	local var_2_3 = math.abs(arg_2_0.y - arg_2_1.y)

	if var_2_2 > arg_2_0.width + arg_2_1.width or var_2_3 > arg_2_0.height + arg_2_1.width then
		return
	end

	local var_2_4
	local var_2_5
	local var_2_6

	if var_2_2 <= arg_2_0.width and var_2_3 <= arg_2_0.height then
		if arg_2_0.width - var_2_2 > arg_2_0.height - var_2_3 then
			var_2_4 = arg_2_1.x
			var_2_5 = arg_2_1.y > arg_2_0.y and arg_2_0.y + arg_2_0.height or arg_2_0.y - arg_2_0.height
			var_2_6 = arg_2_1.y > arg_2_0.y and PinballEnum.Dir.Up or PinballEnum.Dir.Down
		else
			var_2_4 = arg_2_1.x > arg_2_0.x and arg_2_0.x + arg_2_0.width or arg_2_0.x - arg_2_0.width
			var_2_5 = arg_2_1.y
			var_2_6 = arg_2_1.x < arg_2_0.x and PinballEnum.Dir.Left or PinballEnum.Dir.Right
		end
	elseif var_2_2 <= arg_2_0.width then
		var_2_4 = arg_2_1.x
		var_2_5 = arg_2_1.y > arg_2_0.y and arg_2_0.y + arg_2_0.height or arg_2_0.y - arg_2_0.height
		var_2_6 = arg_2_1.y > arg_2_0.y and PinballEnum.Dir.Up or PinballEnum.Dir.Down
	elseif var_2_3 <= arg_2_0.height then
		var_2_4 = arg_2_1.x > arg_2_0.x and arg_2_0.x + arg_2_0.width or arg_2_0.x - arg_2_0.width
		var_2_5 = arg_2_1.y
		var_2_6 = arg_2_1.x < arg_2_0.x and PinballEnum.Dir.Left or PinballEnum.Dir.Right
	else
		for iter_2_0 = -1, 1, 2 do
			for iter_2_1 = -1, 1, 2 do
				local var_2_7 = arg_2_0.x + iter_2_0 * arg_2_0.width
				local var_2_8 = arg_2_0.y + iter_2_1 * arg_2_0.height

				if (var_2_7 - arg_2_1.x)^2 + (var_2_8 - arg_2_1.y)^2 <= arg_2_1.width^2 then
					var_2_4 = var_2_7
					var_2_5 = var_2_8
					var_2_6 = arg_2_1.y > arg_2_0.y and PinballEnum.Dir.Up or PinballEnum.Dir.Down

					break
				end
			end

			if var_2_4 then
				break
			end
		end
	end

	return var_2_4, var_2_5, var_2_6
end

function var_0_0.rotateAngle(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0 * math.cos(arg_3_2 * Mathf.Deg2Rad) - arg_3_1 * math.sin(arg_3_2 * Mathf.Deg2Rad)
	local var_3_1 = arg_3_0 * math.sin(arg_3_2 * Mathf.Deg2Rad) + arg_3_1 * math.cos(arg_3_2 * Mathf.Deg2Rad)

	return var_3_0, var_3_1
end

function var_0_0.getHitRectRect(arg_4_0, arg_4_1)
	local var_4_0 = math.abs(arg_4_0.x - arg_4_1.x)
	local var_4_1 = math.abs(arg_4_0.y - arg_4_1.y)

	if var_4_0 > arg_4_0.width + arg_4_1.width or var_4_1 > arg_4_0.height + arg_4_1.height then
		return
	end

	local var_4_2
	local var_4_3
	local var_4_4
	local var_4_5 = (arg_4_1.x + arg_4_0.x) / 2
	local var_4_6 = (arg_4_1.y + arg_4_0.y) / 2

	if var_4_0 <= arg_4_0.width then
		var_4_4 = arg_4_1.y > arg_4_0.y and PinballEnum.Dir.Up or PinballEnum.Dir.Down
	elseif var_4_1 <= arg_4_0.height then
		var_4_4 = arg_4_1.x < arg_4_0.x and PinballEnum.Dir.Left or PinballEnum.Dir.Right
	end

	return var_4_5, var_4_6, var_4_4
end

function var_0_0.getHitCirCleCirCle(arg_5_0, arg_5_1)
	local var_5_0 = math.abs(arg_5_0.x - arg_5_1.x)
	local var_5_1 = math.abs(arg_5_0.y - arg_5_1.y)

	if var_5_0 > arg_5_0.width + arg_5_1.width or var_5_1 > arg_5_0.height + arg_5_1.height then
		return
	end

	if var_5_0^2 + var_5_1^2 > (arg_5_0.width + arg_5_1.width)^2 then
		return
	end

	local var_5_2
	local var_5_3
	local var_5_4
	local var_5_5 = (arg_5_1.x + arg_5_0.x) / 2
	local var_5_6 = (arg_5_1.y + arg_5_0.y) / 2

	if var_5_1 < var_5_0 then
		var_5_4 = arg_5_1.x < arg_5_0.x and PinballEnum.Dir.Left or PinballEnum.Dir.Right
	else
		var_5_4 = arg_5_1.y > arg_5_0.y and PinballEnum.Dir.Up or PinballEnum.Dir.Down
	end

	return var_5_5, var_5_6, var_5_4
end

function var_0_0.isResType(arg_6_0)
	return arg_6_0 == PinballEnum.UnitType.ResSmallFood or arg_6_0 == PinballEnum.UnitType.ResFood or arg_6_0 == PinballEnum.UnitType.ResMine or arg_6_0 == PinballEnum.UnitType.ResStone or arg_6_0 == PinballEnum.UnitType.ResWood
end

function var_0_0.isMarblesType(arg_7_0)
	return arg_7_0 == PinballEnum.UnitType.MarblesNormal or arg_7_0 == PinballEnum.UnitType.MarblesDivision or arg_7_0 == PinballEnum.UnitType.MarblesElasticity or arg_7_0 == PinballEnum.UnitType.MarblesExplosion or arg_7_0 == PinballEnum.UnitType.MarblesGlass
end

function var_0_0.isOtherType(arg_8_0)
	return not var_0_0.isResType(arg_8_0) and not var_0_0.isMarblesType(arg_8_0)
end

function var_0_0.getLimitTimeStr()
	local var_9_0 = ActivityModel.instance:getActMO(VersionActivity2_4Enum.ActivityId.Pinball)

	if not var_9_0 then
		return ""
	end

	local var_9_1 = var_9_0:getRealEndTimeStamp() - ServerTime.now()

	if var_9_1 > 0 then
		return TimeUtil.SecondToActivityTimeFormat(var_9_1)
	end

	return ""
end

function var_0_0.isBanOper()
	return GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.PinballBanOper)
end

return var_0_0
