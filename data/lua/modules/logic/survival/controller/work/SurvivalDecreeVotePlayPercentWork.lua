module("modules.logic.survival.controller.work.SurvivalDecreeVotePlayPercentWork", package.seeall)

local var_0_0 = class("SurvivalDecreeVotePlayPercentWork", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0:initParam(arg_1_1)
end

function var_0_0.initParam(arg_2_0, arg_2_1)
	arg_2_0.toastList = {}
	arg_2_0.goVoteFinish = arg_2_1.goVoteFinish
	arg_2_0.txtVotePercent = arg_2_1.txtVotePercent
	arg_2_0.txtVotePercentGlow = arg_2_1.txtVotePercentGlow
	arg_2_0.votePercent = arg_2_1.votePercent
	arg_2_0.anim = arg_2_0.goVoteFinish:GetComponent(gohelper.Type_Animator)
	arg_2_0.startValue = 0
	arg_2_0.endValue = math.floor(arg_2_0.votePercent * 100)
end

function var_0_0.onStart(arg_3_0)
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_binansuo_agree)
	gohelper.setActive(arg_3_0.goVoteFinish, true)

	arg_3_0.txtVotePercent.text = string.format("%s%%", arg_3_0.startValue)
	arg_3_0.txtVotePercentGlow.text = ""
	arg_3_0.tweenId = ZProj.TweenHelper.DOTweenFloat(arg_3_0.startValue, arg_3_0.endValue, 1.5, arg_3_0.setPercentValue, arg_3_0.onTweenFinish, arg_3_0, nil, EaseType.Linear)
end

function var_0_0.setPercentValue(arg_4_0, arg_4_1)
	local var_4_0 = string.format("%s%%", math.floor(arg_4_1))

	arg_4_0.txtVotePercent.text = var_4_0
	arg_4_0.txtVotePercentGlow.text = var_4_0
end

function var_0_0.onTweenFinish(arg_5_0)
	arg_5_0:setPercentValue(arg_5_0.endValue)
	arg_5_0.anim:Play("finish")
	arg_5_0:onPlayFinish()
end

function var_0_0.onPlayFinish(arg_6_0)
	arg_6_0:onDone(true)
end

function var_0_0.clearWork(arg_7_0)
	if arg_7_0.tweenId then
		ZProj.TweenHelper.KillById(arg_7_0.tweenId)

		arg_7_0.tweenId = nil
	end

	arg_7_0:setPercentValue(arg_7_0.endValue)
end

return var_0_0
