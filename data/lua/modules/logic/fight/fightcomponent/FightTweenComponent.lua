module("modules.logic.fight.fightcomponent.FightTweenComponent", package.seeall)

local var_0_0 = class("FightTweenComponent", FightBaseClass)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0.TweenHelper = ZProj.TweenHelper
	arg_1_0.index = 0
	arg_1_0.tweenList = {}
end

function var_0_0.DOTweenFloat(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6, arg_2_7, arg_2_8)
	arg_2_8 = EaseType.Str2Type(arg_2_8)

	local var_2_0 = arg_2_0.TweenHelper.DOTweenFloat(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6, arg_2_7, arg_2_8)

	arg_2_0.index = arg_2_0.index + 1
	arg_2_0.tweenList[arg_2_0.index] = var_2_0
end

function var_0_0.DOAnchorPos(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, arg_3_6, arg_3_7, arg_3_8)
	arg_3_8 = EaseType.Str2Type(arg_3_8)

	local var_3_0 = arg_3_0.TweenHelper.DOAnchorPos(arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, arg_3_6, arg_3_7, arg_3_8)

	arg_3_0.index = arg_3_0.index + 1
	arg_3_0.tweenList[arg_3_0.index] = var_3_0
end

function var_0_0.DOAnchorPosX(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6, arg_4_7)
	arg_4_7 = EaseType.Str2Type(arg_4_7)

	local var_4_0 = arg_4_0.TweenHelper.DOAnchorPosX(arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6, arg_4_7)

	arg_4_0.index = arg_4_0.index + 1
	arg_4_0.tweenList[arg_4_0.index] = var_4_0
end

function var_0_0.DOAnchorPosY(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5, arg_5_6, arg_5_7)
	arg_5_7 = EaseType.Str2Type(arg_5_7)

	local var_5_0 = arg_5_0.TweenHelper.DOAnchorPosY(arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5, arg_5_6, arg_5_7)

	arg_5_0.index = arg_5_0.index + 1
	arg_5_0.tweenList[arg_5_0.index] = var_5_0
end

function var_0_0.DOWidth(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5, arg_6_6, arg_6_7)
	arg_6_7 = EaseType.Str2Type(arg_6_7)

	local var_6_0 = arg_6_0.TweenHelper.DOWidth(arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5, arg_6_6, arg_6_7)

	arg_6_0.index = arg_6_0.index + 1
	arg_6_0.tweenList[arg_6_0.index] = var_6_0
end

function var_0_0.DOHeight(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5, arg_7_6, arg_7_7)
	arg_7_7 = EaseType.Str2Type(arg_7_7)

	local var_7_0 = arg_7_0.TweenHelper.DOHeight(arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5, arg_7_6, arg_7_7)

	arg_7_0.index = arg_7_0.index + 1
	arg_7_0.tweenList[arg_7_0.index] = var_7_0
end

function var_0_0.DOSizeDelta(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5, arg_8_6, arg_8_7, arg_8_8)
	arg_8_8 = EaseType.Str2Type(arg_8_8)

	local var_8_0 = arg_8_0.TweenHelper.DOSizeDelta(arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5, arg_8_6, arg_8_7, arg_8_8)

	arg_8_0.index = arg_8_0.index + 1
	arg_8_0.tweenList[arg_8_0.index] = var_8_0
end

function var_0_0.DOMove(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5, arg_9_6, arg_9_7, arg_9_8, arg_9_9)
	arg_9_9 = EaseType.Str2Type(arg_9_9)

	local var_9_0 = arg_9_0.TweenHelper.DOMove(arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5, arg_9_6, arg_9_7, arg_9_8, arg_9_9)

	arg_9_0.index = arg_9_0.index + 1
	arg_9_0.tweenList[arg_9_0.index] = var_9_0
end

function var_0_0.DOMoveX(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5, arg_10_6, arg_10_7)
	arg_10_7 = EaseType.Str2Type(arg_10_7)

	local var_10_0 = arg_10_0.TweenHelper.DOMoveX(arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5, arg_10_6, arg_10_7)

	arg_10_0.index = arg_10_0.index + 1
	arg_10_0.tweenList[arg_10_0.index] = var_10_0
end

function var_0_0.DOMoveY(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5, arg_11_6, arg_11_7)
	arg_11_7 = EaseType.Str2Type(arg_11_7)

	local var_11_0 = arg_11_0.TweenHelper.DOMoveY(arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5, arg_11_6, arg_11_7)

	arg_11_0.index = arg_11_0.index + 1
	arg_11_0.tweenList[arg_11_0.index] = var_11_0
end

function var_0_0.DOLocalMove(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5, arg_12_6, arg_12_7, arg_12_8, arg_12_9)
	arg_12_9 = EaseType.Str2Type(arg_12_9)

	local var_12_0 = arg_12_0.TweenHelper.DOLocalMove(arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5, arg_12_6, arg_12_7, arg_12_8, arg_12_9)

	arg_12_0.index = arg_12_0.index + 1
	arg_12_0.tweenList[arg_12_0.index] = var_12_0
end

function var_0_0.DOLocalMoveX(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5, arg_13_6, arg_13_7)
	arg_13_7 = EaseType.Str2Type(arg_13_7)

	local var_13_0 = arg_13_0.TweenHelper.DOLocalMoveX(arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5, arg_13_6, arg_13_7)

	arg_13_0.index = arg_13_0.index + 1
	arg_13_0.tweenList[arg_13_0.index] = var_13_0
end

function var_0_0.DOLocalMoveY(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4, arg_14_5, arg_14_6, arg_14_7)
	arg_14_7 = EaseType.Str2Type(arg_14_7)

	local var_14_0 = arg_14_0.TweenHelper.DOLocalMoveY(arg_14_1, arg_14_2, arg_14_3, arg_14_4, arg_14_5, arg_14_6, arg_14_7)

	arg_14_0.index = arg_14_0.index + 1
	arg_14_0.tweenList[arg_14_0.index] = var_14_0
end

function var_0_0.DOScale(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5, arg_15_6, arg_15_7, arg_15_8, arg_15_9)
	arg_15_9 = EaseType.Str2Type(arg_15_9)

	local var_15_0 = arg_15_0.TweenHelper.DOScale(arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5, arg_15_6, arg_15_7, arg_15_8, arg_15_9)

	arg_15_0.index = arg_15_0.index + 1
	arg_15_0.tweenList[arg_15_0.index] = var_15_0
end

function var_0_0.DORotate(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5, arg_16_6, arg_16_7, arg_16_8, arg_16_9)
	arg_16_9 = EaseType.Str2Type(arg_16_9)

	local var_16_0 = arg_16_0.TweenHelper.DORotate(arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5, arg_16_6, arg_16_7, arg_16_8, arg_16_9)

	arg_16_0.index = arg_16_0.index + 1
	arg_16_0.tweenList[arg_16_0.index] = var_16_0
end

function var_0_0.DOLocalRotate(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4, arg_17_5, arg_17_6, arg_17_7, arg_17_8, arg_17_9)
	arg_17_9 = EaseType.Str2Type(arg_17_9)

	local var_17_0 = arg_17_0.TweenHelper.DOLocalRotate(arg_17_1, arg_17_2, arg_17_3, arg_17_4, arg_17_5, arg_17_6, arg_17_7, arg_17_8, arg_17_9)

	arg_17_0.index = arg_17_0.index + 1
	arg_17_0.tweenList[arg_17_0.index] = var_17_0
end

function var_0_0.DoFade(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4, arg_18_5, arg_18_6, arg_18_7, arg_18_8)
	arg_18_8 = EaseType.Str2Type(arg_18_8)

	local var_18_0 = arg_18_0.TweenHelper.DoFade(arg_18_1, arg_18_2, arg_18_3, arg_18_4, arg_18_5, arg_18_6, arg_18_7, arg_18_8)

	arg_18_0.index = arg_18_0.index + 1
	arg_18_0.tweenList[arg_18_0.index] = var_18_0
end

function var_0_0.DOColor(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4, arg_19_5, arg_19_6, arg_19_7)
	arg_19_7 = EaseType.Str2Type(arg_19_7)

	local var_19_0 = arg_19_0.TweenHelper.DOColor(arg_19_1, arg_19_2, arg_19_3, arg_19_4, arg_19_5, arg_19_6, arg_19_7)

	arg_19_0.index = arg_19_0.index + 1
	arg_19_0.tweenList[arg_19_0.index] = var_19_0
end

function var_0_0.DOText(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4, arg_20_5, arg_20_6, arg_20_7)
	arg_20_7 = EaseType.Str2Type(arg_20_7)

	local var_20_0 = arg_20_0.TweenHelper.DOText(arg_20_1, arg_20_2, arg_20_3, arg_20_4, arg_20_5, arg_20_6, arg_20_7)

	arg_20_0.index = arg_20_0.index + 1
	arg_20_0.tweenList[arg_20_0.index] = var_20_0
end

function var_0_0.DOFadeCanvasGroup(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4, arg_21_5, arg_21_6, arg_21_7, arg_21_8)
	arg_21_8 = EaseType.Str2Type(arg_21_8)

	local var_21_0 = arg_21_0.TweenHelper.DOFadeCanvasGroup(arg_21_1, arg_21_2, arg_21_3, arg_21_4, arg_21_5, arg_21_6, arg_21_7, arg_21_8)

	arg_21_0.index = arg_21_0.index + 1
	arg_21_0.tweenList[arg_21_0.index] = var_21_0
end

function var_0_0.DOFillAmount(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4, arg_22_5, arg_22_6, arg_22_7)
	arg_22_7 = EaseType.Str2Type(arg_22_7)

	local var_22_0 = arg_22_0.TweenHelper.DOFillAmount(arg_22_1, arg_22_2, arg_22_3, arg_22_4, arg_22_5, arg_22_6, arg_22_7)

	arg_22_0.index = arg_22_0.index + 1
	arg_22_0.tweenList[arg_22_0.index] = var_22_0
end

function var_0_0.scrollNumTween(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4, arg_23_5)
	arg_23_5 = EaseType.Str2Type(arg_23_5)

	local var_23_0 = arg_23_1:GetInstanceID()

	if not arg_23_0.scrollNumtweenList then
		arg_23_0.scrollNumtweenList = {}
	end

	arg_23_0:killTween(arg_23_0.scrollNumtweenList[var_23_0])

	local var_23_1 = arg_23_0:DOTweenFloat(arg_23_2, arg_23_3, arg_23_4, arg_23_0.onScrollNumFrame, nil, arg_23_0, arg_23_1, arg_23_5)

	arg_23_0.scrollNumtweenList[var_23_0] = var_23_1

	return var_23_1
end

function var_0_0.onScrollNumFrame(arg_24_0, arg_24_1, arg_24_2)
	arg_24_2.text = math.ceil(arg_24_1)
end

function var_0_0.killTween(arg_25_0, arg_25_1)
	if not arg_25_1 then
		return
	end

	return arg_25_0.TweenHelper.KillById(arg_25_1)
end

function var_0_0.KillTweenByObj(arg_26_0, arg_26_1, arg_26_2)
	return arg_26_0.TweenHelper.KillByObj(arg_26_1, arg_26_2)
end

function var_0_0.onDestructor(arg_27_0)
	for iter_27_0 = 1, arg_27_0.index do
		arg_27_0.TweenHelper.KillById(arg_27_0.tweenList[iter_27_0])
	end
end

return var_0_0
