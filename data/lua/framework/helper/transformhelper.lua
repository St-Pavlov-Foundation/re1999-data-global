module("framework.helper.transformhelper", package.seeall)

local var_0_0 = _M
local var_0_1 = SLFramework.TransformHelper

function var_0_0.setPos(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_1.SetPos(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
end

function var_0_0.setPosLerp(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	var_0_1.SetPosLerp(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
end

function var_0_0.setPosXY(arg_3_0, arg_3_1, arg_3_2)
	var_0_1.SetPosXY(arg_3_0, arg_3_1, arg_3_2)
end

function var_0_0.getPos(arg_4_0)
	return var_0_1.GetPos(arg_4_0, 0, 0, 0)
end

function var_0_0.setLocalPos(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	var_0_1.SetLocalPos(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
end

function var_0_0.setLocalLerp(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	var_0_1.SetLocalPosLerp(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
end

function var_0_0.setLocalPosXY(arg_7_0, arg_7_1, arg_7_2)
	var_0_1.SetLocalPosXY(arg_7_0, arg_7_1, arg_7_2)
end

function var_0_0.getLocalPos(arg_8_0)
	return var_0_1.GetLocalPos(arg_8_0, 0, 0, 0)
end

function var_0_0.setLocalScale(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	var_0_1.SetLocalScale(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
end

function var_0_0.setLocalScaleLerp(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	var_0_1.SetLocalScaleLerp(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
end

function var_0_0.getLocalScale(arg_11_0)
	return var_0_1.GetLocalScale(arg_11_0, 0, 0, 0)
end

function var_0_0.setLocalRotation(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	var_0_1.SetLocalEulerAngles(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
end

function var_0_0.getLocalRotation(arg_13_0)
	return var_0_1.GetLocalEulerAngles(arg_13_0, 0, 0, 0)
end

function var_0_0.setRotation(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	var_0_1.SetRotation(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
end

function var_0_0.setLocalRotation2(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	var_0_1.SetLocalRotation(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
end

function var_0_0.setLocalRotationLerp(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	var_0_1.SetLocalRotationLerp(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
end

function var_0_0.setRotationLerp(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	var_0_1.SetRotationLerp(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
end

function var_0_0.getForward(arg_18_0)
	return var_0_1.GetForward(arg_18_0, 0, 0, 0)
end

function var_0_0.getRight(arg_19_0)
	return var_0_1.GetRight(arg_19_0, 0, 0, 0)
end

function var_0_0.getUp(arg_20_0)
	return var_0_1.GetUp(arg_20_0, 0, 0, 0)
end

function var_0_0.getEulerAngles(arg_21_0)
	return var_0_1.GetEulerAngles(arg_21_0, 0, 0, 0)
end

function var_0_0.setEulerAngles(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	var_0_1.SetEulerAngles(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
end

function var_0_0.getLossyScale(arg_23_0)
	return var_0_1.GetLossyScale(arg_23_0, 0, 0, 0)
end

return var_0_0
