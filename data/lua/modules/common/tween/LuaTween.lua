module("modules.common.tween.LuaTween", package.seeall)

local var_0_0 = _M

function var_0_0.getEaseFunc(arg_1_0)
	local var_1_0 = var_0_0.TweenFuncDict[arg_1_0]

	if var_1_0 then
		return var_1_0
	end

	return var_0_0.linear
end

function var_0_0.tween(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	return var_0_0.getEaseFunc(arg_2_4)(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
end

function var_0_0.linear(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	return arg_3_2 * arg_3_0 / arg_3_3 + arg_3_1
end

function var_0_0.inSine(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	return -arg_4_2 * Mathf.Cos(arg_4_0 / arg_4_3 * (Mathf.PI / 2)) + arg_4_2 + arg_4_1
end

function var_0_0.outSine(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	return arg_5_2 * Mathf.Sin(arg_5_0 / arg_5_3 * (Mathf.PI / 2)) + arg_5_1
end

function var_0_0.inOutSine(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	return -arg_6_2 / 2 * (Mathf.Cos(Mathf.PI * arg_6_0 / arg_6_3) - 1) + arg_6_1
end

function var_0_0.inQuad(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0 = arg_7_0 / arg_7_3

	return arg_7_2 * arg_7_0 * arg_7_0 + arg_7_1
end

function var_0_0.outQuad(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_0 = arg_8_0 / arg_8_3

	return -arg_8_2 * arg_8_0 * (arg_8_0 - 2) + arg_8_1
end

function var_0_0.inOutQuad(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	arg_9_0 = arg_9_0 / (arg_9_3 / 2)

	if arg_9_0 < 1 then
		return arg_9_2 / 2 * arg_9_0 * arg_9_0 + arg_9_1
	end

	arg_9_0 = arg_9_0 - 1

	return -arg_9_2 / 2 * (arg_9_0 * (arg_9_0 - 2) - 1) + arg_9_1
end

function var_0_0.inCubic(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	arg_10_0 = arg_10_0 / arg_10_3

	return arg_10_2 * arg_10_0 * arg_10_0 * arg_10_0 + arg_10_1
end

function var_0_0.outCubic(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	arg_11_0 = arg_11_0 / arg_11_3 - 1

	return arg_11_2 * (arg_11_0 * arg_11_0 * arg_11_0 + 1) + arg_11_1
end

function var_0_0.inOutCubic(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	arg_12_0 = arg_12_0 / (arg_12_3 / 2)

	if arg_12_0 < 1 then
		return arg_12_2 / 2 * arg_12_0 * arg_12_0 * arg_12_0 + arg_12_1
	end

	arg_12_0 = arg_12_0 - 2

	return arg_12_2 / 2 * (arg_12_0 * arg_12_0 * arg_12_0 + 2) + arg_12_1
end

function var_0_0.inQuart(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	arg_13_0 = arg_13_0 / arg_13_3

	return arg_13_2 * arg_13_0 * arg_13_0 * arg_13_0 * arg_13_0 + arg_13_1
end

function var_0_0.outQuart(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	arg_14_0 = arg_14_0 / arg_14_3 - 1

	return -arg_14_2 * (arg_14_0 * arg_14_0 * arg_14_0 * arg_14_0 - 1) + arg_14_1
end

function var_0_0.inOutQuart(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	arg_15_0 = arg_15_0 / (arg_15_3 / 2)

	if arg_15_0 < 1 then
		return arg_15_2 / 2 * arg_15_0 * arg_15_0 * arg_15_0 * arg_15_0 + arg_15_1
	end

	arg_15_0 = arg_15_0 - 2

	return -arg_15_2 / 2 * (arg_15_0 * arg_15_0 * arg_15_0 * arg_15_0 - 2) + arg_15_1
end

function var_0_0.inQuint(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	arg_16_0 = arg_16_0 / arg_16_3

	return arg_16_2 * arg_16_0 * arg_16_0 * arg_16_0 * arg_16_0 * arg_16_0 + arg_16_1
end

function var_0_0.outQuint(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	arg_17_0 = arg_17_0 / arg_17_3 - 1

	return arg_17_2 * (arg_17_0 * arg_17_0 * arg_17_0 * arg_17_0 * arg_17_0 + 1) + arg_17_1
end

function var_0_0.inOutQuint(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	arg_18_0 = arg_18_0 / (arg_18_3 / 2)

	if arg_18_0 < 1 then
		return arg_18_2 / 2 * arg_18_0 * arg_18_0 * arg_18_0 * arg_18_0 * arg_18_0 + arg_18_1
	end

	arg_18_0 = arg_18_0 - 2

	return arg_18_2 / 2 * (arg_18_0 * arg_18_0 * arg_18_0 * arg_18_0 * arg_18_0 + 2) + arg_18_1
end

function var_0_0.inExpo(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	if arg_19_0 == 0 then
		return arg_19_1
	else
		return arg_19_2 * Mathf.Pow(2, 10 * (arg_19_0 / arg_19_3 - 1)) + arg_19_1
	end
end

function var_0_0.outExpo(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	if arg_20_0 == arg_20_3 then
		return arg_20_1 + arg_20_2
	else
		return arg_20_2 * (-Mathf.Pow(2, -10 * arg_20_0 / arg_20_3) + 1) + arg_20_1
	end
end

function var_0_0.inOutExpo(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	if arg_21_0 == 0 then
		return arg_21_1
	end

	if arg_21_0 == arg_21_3 then
		return arg_21_1 + arg_21_2
	end

	arg_21_0 = arg_21_0 / (arg_21_3 / 2)

	if arg_21_0 < 1 then
		return arg_21_2 / 2 * Mathf.Pow(2, 10 * (arg_21_0 - 1)) + arg_21_1
	end

	arg_21_0 = arg_21_0 - 1

	return arg_21_2 / 2 * (-Mathf.Pow(2, -10 * arg_21_0) + 2) + arg_21_1
end

function var_0_0.inCirc(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	arg_22_0 = arg_22_0 / arg_22_3

	return -arg_22_2 * (Mathf.Sqrt(1 - arg_22_0 * arg_22_0) - 1) + arg_22_1
end

function var_0_0.outCirc(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	arg_23_0 = arg_23_0 / arg_23_3 - 1

	return arg_23_2 * Mathf.Sqrt(1 - arg_23_0 * arg_23_0) + arg_23_1
end

function var_0_0.inOutCirc(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	arg_24_0 = arg_24_0 / (arg_24_3 / 2)

	if arg_24_0 < 1 then
		return -arg_24_2 / 2 * (Mathf.Sqrt(1 - arg_24_0 * arg_24_0) - 1) + arg_24_1
	end

	arg_24_0 = arg_24_0 - 2

	return arg_24_2 / 2 * (Mathf.Sqrt(1 - arg_24_0 * arg_24_0) + 1) + arg_24_1
end

function var_0_0.inBack(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	local var_25_0 = 1.70158

	arg_25_0 = arg_25_0 / arg_25_3

	return arg_25_2 * arg_25_0 * arg_25_0 * ((var_25_0 + 1) * arg_25_0 - var_25_0) + arg_25_1
end

function var_0_0.outBack(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	local var_26_0 = 1.70158

	arg_26_0 = arg_26_0 / arg_26_3 - 1

	return arg_26_2 * (arg_26_0 * arg_26_0 * ((var_26_0 + 1) * arg_26_0 + var_26_0) + 1) + arg_26_1
end

function var_0_0.inOutBack(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	local var_27_0 = 1.70158

	arg_27_0 = arg_27_0 / (arg_27_3 / 2)

	local var_27_1 = var_27_0 * 1.525

	if arg_27_0 < 1 then
		return arg_27_2 / 2 * (arg_27_0 * arg_27_0 * ((var_27_1 + 1) * arg_27_0 - var_27_1)) + arg_27_1
	end

	arg_27_0 = arg_27_0 - 2

	local var_27_2 = var_27_1 * 1.525

	return arg_27_2 / 2 * (arg_27_0 * arg_27_0 * ((var_27_2 + 1) * arg_27_0 + var_27_2) + 2) + arg_27_1
end

function var_0_0.inElastic(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	if arg_28_0 == 0 then
		return arg_28_1
	end

	arg_28_0 = arg_28_0 / arg_28_3

	if arg_28_0 == 1 then
		return arg_28_1 + arg_28_2
	end

	local var_28_0 = arg_28_3 * 0.3
	local var_28_1 = arg_28_2
	local var_28_2 = var_28_0 / 4

	arg_28_0 = arg_28_0 - 1

	return -(var_28_1 * Mathf.Pow(2, 10 * arg_28_0) * Mathf.Sin((arg_28_0 * arg_28_3 - var_28_2) * (2 * Mathf.PI) / var_28_0)) + arg_28_1
end

function var_0_0.outElastic(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	if arg_29_0 == 0 then
		return arg_29_1
	end

	arg_29_0 = arg_29_0 / arg_29_3

	if arg_29_0 == 1 then
		return arg_29_1 + arg_29_2
	end

	local var_29_0 = arg_29_3 * 0.3
	local var_29_1 = arg_29_2
	local var_29_2 = var_29_0 / 4

	return var_29_1 * Mathf.Pow(2, -10 * arg_29_0) * Mathf.Sin((arg_29_0 * arg_29_3 - var_29_2) * (2 * Mathf.PI) / var_29_0) + arg_29_2 + arg_29_1
end

function var_0_0.inOutElastic(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	if arg_30_0 == 0 then
		return arg_30_1
	end

	arg_30_0 = arg_30_0 / (arg_30_3 / 2)

	if arg_30_0 == 2 then
		return arg_30_1 + arg_30_2
	end

	local var_30_0 = arg_30_3 * 0.44999999999999996
	local var_30_1 = arg_30_2
	local var_30_2 = var_30_0 / 4

	if arg_30_0 < 1 then
		arg_30_0 = arg_30_0 - 1

		return -0.5 * (var_30_1 * Mathf.Pow(2, 10 * arg_30_0) * Mathf.Sin((arg_30_0 * arg_30_3 - var_30_2) * (2 * Mathf.PI) / var_30_0)) + arg_30_1
	end

	arg_30_0 = arg_30_0 - 1

	return var_30_1 * Mathf.Pow(2, -10 * arg_30_0) * Mathf.Sin((arg_30_0 * arg_30_3 - var_30_2) * (2 * Mathf.PI) / var_30_0) * 0.5 + arg_30_2 + arg_30_1
end

function var_0_0.inBounce(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	return arg_31_2 - var_0_0.outBounce(arg_31_3 - arg_31_0, 0, arg_31_2, arg_31_3) + arg_31_1
end

function var_0_0.outBounce(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	arg_32_0 = arg_32_0 / arg_32_3

	if arg_32_0 < 0.36363636363636365 then
		return arg_32_2 * (7.5625 * arg_32_0 * arg_32_0) + arg_32_1
	end

	if arg_32_0 < 0.7272727272727273 then
		arg_32_0 = arg_32_0 - 0.5454545454545454

		return arg_32_2 * (7.5625 * arg_32_0 * arg_32_0 + 0.75) + arg_32_1
	end

	if arg_32_0 < 0.9090909090909091 then
		arg_32_0 = arg_32_0 - 0.8181818181818182

		return arg_32_2 * (7.5625 * arg_32_0 * arg_32_0 + 0.9375) + arg_32_1
	end

	arg_32_0 = arg_32_0 - 0.9545454545454546

	return arg_32_2 * (7.5625 * arg_32_0 * arg_32_0 + 0.984375) + arg_32_1
end

function var_0_0.inOutBounce(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	if arg_33_0 < arg_33_3 / 2 then
		return var_0_0.inBounce(arg_33_0 * 2, 0, arg_33_2, arg_33_3) * 0.5 + arg_33_1
	end

	return var_0_0.outBounce(arg_33_0 * 2 - arg_33_3, 0, arg_33_2, arg_33_3) * 0.5 + arg_33_2 * 0.5 + arg_33_1
end

var_0_0.TweenFuncDict = {
	[EaseType.Linear] = var_0_0.linear,
	[EaseType.InSine] = var_0_0.inSine,
	[EaseType.OutSine] = var_0_0.outSine,
	[EaseType.InOutSine] = var_0_0.inOutSine,
	[EaseType.InQuad] = var_0_0.inQuad,
	[EaseType.OutQuad] = var_0_0.outQuad,
	[EaseType.InOutQuad] = var_0_0.inOutQuad,
	[EaseType.InCubic] = var_0_0.inCubic,
	[EaseType.OutCubic] = var_0_0.outCubic,
	[EaseType.InOutCubic] = var_0_0.inOutCubic,
	[EaseType.InQuart] = var_0_0.inQuart,
	[EaseType.OutQuart] = var_0_0.outQuart,
	[EaseType.InOutQuart] = var_0_0.inOutQuart,
	[EaseType.InQuint] = var_0_0.inQuint,
	[EaseType.OutQuint] = var_0_0.outQuint,
	[EaseType.InOutQuint] = var_0_0.inOutQuint,
	[EaseType.InExpo] = var_0_0.inExpo,
	[EaseType.OutExpo] = var_0_0.outExpo,
	[EaseType.InOutExpo] = var_0_0.inOutExpo,
	[EaseType.InCirc] = var_0_0.inCirc,
	[EaseType.OutCirc] = var_0_0.outCirc,
	[EaseType.InOutCirc] = var_0_0.inOutCirc,
	[EaseType.InBack] = var_0_0.inBack,
	[EaseType.OutBack] = var_0_0.outBack,
	[EaseType.InOutBack] = var_0_0.inOutBack,
	[EaseType.InElastic] = var_0_0.inElastic,
	[EaseType.OutElastic] = var_0_0.outElastic,
	[EaseType.InOutElastic] = var_0_0.inOutElastic,
	[EaseType.InBounce] = var_0_0.inBounce,
	[EaseType.OutBounce] = var_0_0.outBounce,
	[EaseType.InOutBounce] = var_0_0.inOutBounce
}

return var_0_0
