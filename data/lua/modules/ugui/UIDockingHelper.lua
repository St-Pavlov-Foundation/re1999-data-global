module("modules.ugui.UIDockingHelper", package.seeall)

local var_0_0 = SLFramework.UGUI.RectTrHelper
local var_0_1 = {
	__calcSudokuNilLocalPosV2 = function(arg_1_0, arg_1_1)
		local var_1_0 = CameraMgr.instance:getUICamera()
		local var_1_1 = var_1_0:WorldToScreenPoint(arg_1_1.position)

		return var_0_0.ScreenPosToAnchorPos(var_1_1, arg_1_0.parent, var_1_0)
	end
}
local var_0_2 = 16

var_0_1.Dock = {
	LB_RT = 10,
	RB_RT = 14,
	LB_RB = 8,
	RT_RT = 6,
	LT_LB = 1,
	LT_RB = 0,
	LT_LT = 3,
	RT_RB = 4,
	LB_LB = 9,
	RT_LB = 5,
	RB_LT = 15,
	LT_RT = 2,
	RB_LB = 13,
	RB_RB = 12,
	LB_LT = 11,
	RT_LT = 7,
	LT_U = 0 + var_0_2,
	MT_U = 3 + var_0_2,
	RT_U = 6 + var_0_2,
	LT_M = 1 + var_0_2,
	MT_M = 3 + var_0_2,
	RT_M = 7 + var_0_2,
	LT_D = 2 + var_0_2,
	MT_D = 5 + var_0_2,
	RT_D = 8 + var_0_2,
	ML_L = 9 + var_0_2,
	ML_M = 10 + var_0_2,
	ML_R = 11 + var_0_2,
	MR_L = 12 + var_0_2,
	MR_M = 13 + var_0_2,
	MR_R = 14 + var_0_2,
	LB_U = 15 + var_0_2,
	MB_U = 18 + var_0_2,
	RB_U = 21 + var_0_2,
	LB_M = 16 + var_0_2,
	MB_M = 19 + var_0_2,
	RB_M = 22 + var_0_2,
	LB_D = 17 + var_0_2,
	MB_D = 20 + var_0_2,
	RB_D = 23 + var_0_2
}

function var_0_1._calcDockSudokuLocalPosV2(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = var_0_1.__calcSudokuNilLocalPosV2(arg_2_1, arg_2_2)

	if not arg_2_0 then
		return var_2_0
	end

	local var_2_1 = 0
	local var_2_2 = 0
	local var_2_3 = math.modf(arg_2_0 / 3)
	local var_2_4 = arg_2_0 % 3 - 1
	local var_2_5 = arg_2_2.rect
	local var_2_6 = var_2_5.width * 0.5
	local var_2_7 = var_2_5.height * 0.5
	local var_2_8 = arg_2_1.rect
	local var_2_9 = var_2_8.width * 0.5
	local var_2_10 = var_2_8.height * 0.5

	if var_2_3 <= 2 then
		var_2_2 = var_2_2 + var_2_7 - var_2_10 * var_2_4
		var_2_3 = var_2_3 - 1
		var_2_1 = var_2_1 + var_2_6 * var_2_3
	elseif var_2_3 <= 4 then
		var_2_3 = var_2_3 * 2 - 7
		var_2_1 = var_2_1 + var_2_6 * var_2_3 + var_2_9 * var_2_4
	else
		var_2_2 = var_2_2 - var_2_7 - var_2_10 * var_2_4
		var_2_1 = var_2_1 + var_2_6 * (var_2_3 - 6)
	end

	var_2_0.x = var_2_0.x + var_2_1
	var_2_0.y = var_2_0.y + var_2_2

	return var_2_0
end

function var_0_1._calcDockCornorLocalPosV2(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = var_0_1.__calcSudokuNilLocalPosV2(arg_3_1, arg_3_2)

	if not arg_3_0 then
		return var_3_0
	end

	local var_3_1 = 0
	local var_3_2 = 0
	local var_3_3 = math.modf(arg_3_0 / 4)
	local var_3_4 = arg_3_0 % 4
	local var_3_5 = arg_3_2.rect
	local var_3_6 = var_3_5.width * 0.5
	local var_3_7 = var_3_5.height * 0.5

	if var_3_3 == 0 then
		var_3_1 = var_3_1 - var_3_6
		var_3_2 = var_3_2 + var_3_7
	elseif var_3_3 == 1 then
		var_3_1 = var_3_1 + var_3_6
		var_3_2 = var_3_2 + var_3_7
	elseif var_3_3 == 2 then
		var_3_1 = var_3_1 - var_3_6
		var_3_2 = var_3_2 - var_3_7
	elseif var_3_3 == 3 then
		var_3_1 = var_3_1 + var_3_6
		var_3_2 = var_3_2 - var_3_7
	end

	local var_3_8 = arg_3_1.rect
	local var_3_9 = var_3_8.width * 0.5
	local var_3_10 = var_3_8.height * 0.5

	if var_3_4 == 0 then
		var_3_1 = var_3_1 + var_3_9
		var_3_2 = var_3_2 - var_3_10
	elseif var_3_4 == 1 then
		var_3_1 = var_3_1 - var_3_9
		var_3_2 = var_3_2 - var_3_10
	elseif var_3_4 == 2 then
		var_3_1 = var_3_1 + var_3_9
		var_3_2 = var_3_2 + var_3_10
	elseif var_3_4 == 3 then
		var_3_1 = var_3_1 - var_3_9
		var_3_2 = var_3_2 + var_3_10
	end

	var_3_0.x = var_3_0.x + var_3_1
	var_3_0.y = var_3_0.y + var_3_2

	return var_3_0
end

function var_0_1.calcDockLocalPosV2(arg_4_0, arg_4_1, arg_4_2)
	if not arg_4_0 then
		return var_0_1.__calcSudokuNilLocalPosV2(arg_4_1, arg_4_2)
	end

	assert(arg_4_0 >= 0 and arg_4_0 <= 23 + var_0_2, "eDock=" .. tostring(arg_4_0))

	if arg_4_0 >= var_0_2 then
		return var_0_1._calcDockSudokuLocalPosV2(arg_4_0 - var_0_2, arg_4_1, arg_4_2)
	else
		return var_0_1._calcDockCornorLocalPosV2(arg_4_0, arg_4_1, arg_4_2)
	end
end

function var_0_1.setDock(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	arg_5_0 = arg_5_0 or var_0_1.Dock.MM_M

	local var_5_0 = var_0_1.calcDockLocalPosV2(arg_5_0, arg_5_1, arg_5_2)

	transformhelper.setLocalPos(arg_5_1, var_5_0.x + (arg_5_3 or 0), var_5_0.y + (arg_5_4 or 0), 0)
end

return var_0_1
