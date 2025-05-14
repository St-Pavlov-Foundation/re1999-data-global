module("modules.logic.fight.fightcomponent.FightTweenComponent", package.seeall)

local var_0_0 = class("FightTweenComponent", FightBaseClass)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0.TweenHelper = ZProj.TweenHelper
	arg_1_0._tweenDic = {}
end

function var_0_0.playTween(arg_2_0, arg_2_1, ...)
	arg_2_0._tweenDic[arg_2_1] = arg_2_0._tweenDic[arg_2_1] or {}

	local var_2_0 = arg_2_0[arg_2_1](arg_2_0, ...)

	table.insert(arg_2_0._tweenDic[arg_2_1], var_2_0)

	return var_2_0
end

function var_0_0.DOTweenFloat(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, arg_3_6, arg_3_7, arg_3_8)
	arg_3_8 = EaseType.Str2Type(arg_3_8)

	return arg_3_0.TweenHelper.DOTweenFloat(arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, arg_3_6, arg_3_7, arg_3_8)
end

function var_0_0.DOAnchorPos(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6, arg_4_7, arg_4_8)
	arg_4_8 = EaseType.Str2Type(arg_4_8)

	return arg_4_0.TweenHelper.DOAnchorPos(arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6, arg_4_7, arg_4_8)
end

function var_0_0.DOAnchorPosX(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5, arg_5_6, arg_5_7)
	arg_5_7 = EaseType.Str2Type(arg_5_7)

	return arg_5_0.TweenHelper.DOAnchorPosX(arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5, arg_5_6, arg_5_7)
end

function var_0_0.DOAnchorPosY(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5, arg_6_6, arg_6_7)
	arg_6_7 = EaseType.Str2Type(arg_6_7)

	return arg_6_0.TweenHelper.DOAnchorPosY(arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5, arg_6_6, arg_6_7)
end

function var_0_0.DOWidth(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5, arg_7_6, arg_7_7)
	arg_7_7 = EaseType.Str2Type(arg_7_7)

	return arg_7_0.TweenHelper.DOWidth(arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5, arg_7_6, arg_7_7)
end

function var_0_0.DOHeight(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5, arg_8_6, arg_8_7)
	arg_8_7 = EaseType.Str2Type(arg_8_7)

	return arg_8_0.TweenHelper.DOHeight(arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5, arg_8_6, arg_8_7)
end

function var_0_0.DOSizeDelta(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5, arg_9_6, arg_9_7, arg_9_8)
	arg_9_8 = EaseType.Str2Type(arg_9_8)

	return arg_9_0.TweenHelper.DOSizeDelta(arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5, arg_9_6, arg_9_7, arg_9_8)
end

function var_0_0.DOMove(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5, arg_10_6, arg_10_7, arg_10_8, arg_10_9)
	arg_10_9 = EaseType.Str2Type(arg_10_9)

	return arg_10_0.TweenHelper.DOMove(arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5, arg_10_6, arg_10_7, arg_10_8, arg_10_9)
end

function var_0_0.DOMoveX(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5, arg_11_6, arg_11_7)
	arg_11_7 = EaseType.Str2Type(arg_11_7)

	return arg_11_0.TweenHelper.DOMoveX(arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5, arg_11_6, arg_11_7)
end

function var_0_0.DOMoveY(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5, arg_12_6, arg_12_7)
	arg_12_7 = EaseType.Str2Type(arg_12_7)

	return arg_12_0.TweenHelper.DOMoveY(arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5, arg_12_6, arg_12_7)
end

function var_0_0.DOLocalMove(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5, arg_13_6, arg_13_7, arg_13_8, arg_13_9)
	arg_13_9 = EaseType.Str2Type(arg_13_9)

	return arg_13_0.TweenHelper.DOLocalMove(arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5, arg_13_6, arg_13_7, arg_13_8, arg_13_9)
end

function var_0_0.DOLocalMoveX(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4, arg_14_5, arg_14_6, arg_14_7)
	arg_14_7 = EaseType.Str2Type(arg_14_7)

	return arg_14_0.TweenHelper.DOLocalMoveX(arg_14_1, arg_14_2, arg_14_3, arg_14_4, arg_14_5, arg_14_6, arg_14_7)
end

function var_0_0.DOLocalMoveY(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5, arg_15_6, arg_15_7)
	arg_15_7 = EaseType.Str2Type(arg_15_7)

	return arg_15_0.TweenHelper.DOLocalMoveY(arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5, arg_15_6, arg_15_7)
end

function var_0_0.DOScale(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5, arg_16_6, arg_16_7, arg_16_8, arg_16_9)
	arg_16_9 = EaseType.Str2Type(arg_16_9)

	return arg_16_0.TweenHelper.DOScale(arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5, arg_16_6, arg_16_7, arg_16_8, arg_16_9)
end

function var_0_0.DORotate(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4, arg_17_5, arg_17_6, arg_17_7, arg_17_8, arg_17_9)
	arg_17_9 = EaseType.Str2Type(arg_17_9)

	return arg_17_0.TweenHelper.DORotate(arg_17_1, arg_17_2, arg_17_3, arg_17_4, arg_17_5, arg_17_6, arg_17_7, arg_17_8, arg_17_9)
end

function var_0_0.DOLocalRotate(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4, arg_18_5, arg_18_6, arg_18_7, arg_18_8, arg_18_9)
	arg_18_9 = EaseType.Str2Type(arg_18_9)

	return arg_18_0.TweenHelper.DOLocalRotate(arg_18_1, arg_18_2, arg_18_3, arg_18_4, arg_18_5, arg_18_6, arg_18_7, arg_18_8, arg_18_9)
end

function var_0_0.DoFade(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4, arg_19_5, arg_19_6, arg_19_7, arg_19_8)
	arg_19_8 = EaseType.Str2Type(arg_19_8)

	return arg_19_0.TweenHelper.DoFade(arg_19_1, arg_19_2, arg_19_3, arg_19_4, arg_19_5, arg_19_6, arg_19_7, arg_19_8)
end

function var_0_0.DOColor(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4, arg_20_5, arg_20_6, arg_20_7)
	arg_20_7 = EaseType.Str2Type(arg_20_7)

	return arg_20_0.TweenHelper.DOColor(arg_20_1, arg_20_2, arg_20_3, arg_20_4, arg_20_5, arg_20_6, arg_20_7)
end

function var_0_0.DOText(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4, arg_21_5, arg_21_6, arg_21_7)
	arg_21_7 = EaseType.Str2Type(arg_21_7)

	return arg_21_0.TweenHelper.DOText(arg_21_1, arg_21_2, arg_21_3, arg_21_4, arg_21_5, arg_21_6, arg_21_7)
end

function var_0_0.DOFadeCanvasGroup(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4, arg_22_5, arg_22_6, arg_22_7, arg_22_8)
	arg_22_8 = EaseType.Str2Type(arg_22_8)

	return arg_22_0.TweenHelper.DOFadeCanvasGroup(arg_22_1, arg_22_2, arg_22_3, arg_22_4, arg_22_5, arg_22_6, arg_22_7, arg_22_8)
end

function var_0_0.DOFillAmount(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4, arg_23_5, arg_23_6, arg_23_7)
	arg_23_7 = EaseType.Str2Type(arg_23_7)

	return arg_23_0.TweenHelper.DOFillAmount(arg_23_1, arg_23_2, arg_23_3, arg_23_4, arg_23_5, arg_23_6, arg_23_7)
end

function var_0_0.killTween(arg_24_0, arg_24_1)
	if not arg_24_1 then
		return
	end

	return arg_24_0.TweenHelper.KillById(arg_24_1)
end

function var_0_0.KillTweenByObj(arg_25_0, arg_25_1, arg_25_2)
	return arg_25_0.TweenHelper.KillByObj(arg_25_1, arg_25_2)
end

function var_0_0.onDestructor(arg_26_0)
	for iter_26_0, iter_26_1 in pairs(arg_26_0._tweenDic) do
		for iter_26_2, iter_26_3 in ipairs(iter_26_1) do
			arg_26_0.TweenHelper.KillById(iter_26_3)
		end
	end
end

return var_0_0
