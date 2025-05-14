module("framework.helper.recthelper", package.seeall)

local var_0_0 = {}
local var_0_1 = SLFramework.UGUI.RectTrHelper

function var_0_0.setHeight(arg_1_0, arg_1_1)
	var_0_1.SetHeight(arg_1_0, arg_1_1)
end

function var_0_0.getHeight(arg_2_0)
	return var_0_1.GetHeight(arg_2_0)
end

function var_0_0.setWidth(arg_3_0, arg_3_1)
	var_0_1.SetWidth(arg_3_0, arg_3_1)
end

function var_0_0.getWidth(arg_4_0)
	return var_0_1.GetWidth(arg_4_0)
end

function var_0_0.setSize(arg_5_0, arg_5_1, arg_5_2)
	var_0_1.SetSize(arg_5_0, arg_5_1, arg_5_2)
end

function var_0_0.getAnchorX(arg_6_0)
	return var_0_1.GetAnchorX(arg_6_0)
end

function var_0_0.getAnchorY(arg_7_0)
	return var_0_1.GetAnchorY(arg_7_0)
end

function var_0_0.getAnchor(arg_8_0)
	return var_0_1.GetAnchor(arg_8_0, 0, 0)
end

function var_0_0.setAnchorX(arg_9_0, arg_9_1)
	var_0_1.SetAnchorX(arg_9_0, arg_9_1)
end

function var_0_0.setAnchorY(arg_10_0, arg_10_1)
	var_0_1.SetAnchorY(arg_10_0, arg_10_1)
end

function var_0_0.setAnchor(arg_11_0, arg_11_1, arg_11_2)
	var_0_1.SetAnchor(arg_11_0, arg_11_1, arg_11_2)
end

function var_0_0.screenPosToAnchorPos(arg_12_0, arg_12_1)
	local var_12_0 = CameraMgr.instance:getUICamera()

	return var_0_1.ScreenPosToAnchorPos(arg_12_0, arg_12_1, var_12_0)
end

function var_0_0.screenPosToAnchorPos2(arg_13_0, arg_13_1)
	local var_13_0 = CameraMgr.instance:getUICamera()

	return var_0_1.ScreenPosToAnchorPos2(arg_13_0, arg_13_1, var_13_0, nil, nil)
end

function var_0_0.rectToRelativeAnchorPos(arg_14_0, arg_14_1)
	local var_14_0 = CameraMgr.instance:getUICamera()
	local var_14_1 = var_14_0:WorldToScreenPoint(arg_14_0)

	return var_0_1.ScreenPosToAnchorPos(var_14_1, arg_14_1, var_14_0)
end

function var_0_0.rectToRelativeAnchorPos2(arg_15_0, arg_15_1)
	local var_15_0 = CameraMgr.instance:getUICamera()
	local var_15_1 = var_15_0:WorldToScreenPoint(arg_15_0)

	return var_0_1.ScreenPosToAnchorPos2(var_15_1, arg_15_1, var_15_0, nil, nil)
end

function var_0_0.worldPosToAnchorPos(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	arg_16_2 = arg_16_2 or CameraMgr.instance:getUICamera()
	arg_16_3 = arg_16_3 or CameraMgr.instance:getMainCamera()

	return var_0_1.WorldPosToAnchorPos(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
end

function var_0_0.worldPosToAnchorPos2(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	arg_17_2 = arg_17_2 or CameraMgr.instance:getUICamera()
	arg_17_3 = arg_17_3 or CameraMgr.instance:getMainCamera()

	return var_0_1.WorldPosToAnchorPos2(arg_17_0, arg_17_1, arg_17_2, arg_17_3, nil, nil)
end

function var_0_0.worldPosToAnchorPosXYZ(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4, arg_18_5)
	arg_18_4 = arg_18_4 or CameraMgr.instance:getUICamera()
	arg_18_5 = arg_18_5 or CameraMgr.instance:getMainCamera()

	return var_0_1.WorldPosToAnchorPosXYZ(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4, arg_18_5, nil, nil)
end

function var_0_0.screenPosToWorldPos(arg_19_0, arg_19_1, arg_19_2)
	arg_19_1 = arg_19_1 or CameraMgr.instance:getMainCamera()

	return var_0_1.ScreenPosToWorldPos(arg_19_0, arg_19_1, arg_19_2)
end

function var_0_0.screenPosToWorldPos3(arg_20_0, arg_20_1, arg_20_2)
	arg_20_1 = arg_20_1 or CameraMgr.instance:getMainCamera()

	return var_0_1.ScreenPosToWorldPos3(arg_20_0, arg_20_1, arg_20_2, nil, nil, nil)
end

function var_0_0.uiPosToScreenPos(arg_21_0, arg_21_1)
	arg_21_1 = arg_21_1 or ViewMgr.instance:getUICanvas()

	return var_0_1.UIPosToScreenPos(arg_21_0, arg_21_1)
end

function var_0_0.uiPosToScreenPos2(arg_22_0, arg_22_1)
	arg_22_1 = arg_22_1 or ViewMgr.instance:getUICanvas()

	return var_0_1.UIPosToScreenPos2(arg_22_0, arg_22_1, nil, nil)
end

function var_0_0.screenPosInRect(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	arg_23_1 = arg_23_1 or CameraMgr.instance:getUICamera()

	return var_0_1.ScreenPosInRect(arg_23_0, arg_23_1, arg_23_2, arg_23_3, nil)
end

function var_0_0.worldPosToScreenPoint(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	arg_24_0 = arg_24_0 or CameraMgr.instance:getMainCamera()

	return var_0_1.WorldPosToScreenPoint(arg_24_0, arg_24_1, arg_24_2, arg_24_3, nil, nil, nil)
end

return var_0_0
