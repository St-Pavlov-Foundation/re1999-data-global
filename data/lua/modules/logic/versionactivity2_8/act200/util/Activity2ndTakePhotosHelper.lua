module("modules.logic.versionactivity2_8.act200.util.Activity2ndTakePhotosHelper", package.seeall)

local var_0_0 = class("Activity2ndTakePhotosHelper")

function var_0_0.ClampPosition(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = arg_1_0.rect.width
	local var_1_1 = arg_1_0.rect.height
	local var_1_2 = arg_1_1.rect.width / 2
	local var_1_3 = arg_1_1.rect.height / 2
	local var_1_4 = -var_1_0 / 2 + var_1_2
	local var_1_5 = var_1_0 / 2 - var_1_2
	local var_1_6 = -var_1_1 / 2 + var_1_3
	local var_1_7 = var_1_1 / 2 - var_1_3

	return {
		x = Mathf.Clamp(arg_1_2.x, var_1_4, var_1_5),
		y = Mathf.Clamp(arg_1_2.y, var_1_6, var_1_7)
	}
end

function var_0_0.checkPhotoAreaMoreGoal(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0.rect.width / 2
	local var_2_1 = arg_2_0.rect.height / 2
	local var_2_2, var_2_3 = recthelper.getAnchor(arg_2_0)
	local var_2_4 = var_2_2 - var_2_0
	local var_2_5 = var_2_2 + var_2_0
	local var_2_6 = var_2_3 + var_2_1
	local var_2_7 = var_2_3 - var_2_1
	local var_2_8 = arg_2_1.x - var_2_0
	local var_2_9 = arg_2_1.x + var_2_0
	local var_2_10 = arg_2_1.y + var_2_1
	local var_2_11 = arg_2_1.y - var_2_1

	return math.max(0, math.min(var_2_5, var_2_9) - math.max(var_2_4, var_2_8)) * math.max(0, math.min(var_2_6, var_2_10) - math.max(var_2_7, var_2_11)) / (arg_2_0.rect.width * arg_2_0.rect.height) >= 0.7
end

return var_0_0
