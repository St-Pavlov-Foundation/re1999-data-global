module("modules.logic.fight.view.FightSurvivalTalent2View", package.seeall)

local var_0_0 = class("FightSurvivalTalent2View", FightBaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.imageProgress = gohelper.findChildImage(arg_1_0.viewGO, "root/progress/#image_progress")
	arg_1_0.txtProgress = gohelper.findChildText(arg_1_0.viewGO, "root/progress/#txt_progress")
	arg_1_0.goFull = gohelper.findChild(arg_1_0.viewGO, "root/#go_full")

	gohelper.setActive(arg_1_0.goFull, false)

	arg_1_0.powerType = FightEnum.PowerType.SurvivalDot
	arg_1_0.entityMo = FightDataHelper.entityMgr:getVorpalith()
	arg_1_0.entityId = arg_1_0.entityMo.id
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.PowerChange, arg_2_0.onPowerChange, arg_2_0)
end

function var_0_0.onPowerChange(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	if arg_3_1 ~= arg_3_0.entityId then
		return
	end

	if arg_3_2 ~= arg_3_0.powerType then
		return
	end

	arg_3_0:changePower()
end

var_0_0.TweenDuration = 0.5

function var_0_0.changePower(arg_4_0)
	local var_4_0 = arg_4_0.entityMo and arg_4_0.entityMo:getPowerInfo(arg_4_0.powerType)

	if not var_4_0 then
		return
	end

	arg_4_0:killTween()

	local var_4_1 = var_4_0.num / var_4_0.max
	local var_4_2 = arg_4_0.imageProgress.fillAmount

	arg_4_0.tweenId = ZProj.TweenHelper.DOTweenFloat(var_4_2, var_4_1, arg_4_0.TweenDuration, arg_4_0.onFrameCallback, arg_4_0.onDoneCallback, arg_4_0)
end

function var_0_0.onFrameCallback(arg_5_0, arg_5_1)
	arg_5_0:directSetProgress(arg_5_1)
end

function var_0_0.onDoneCallback(arg_6_0)
	arg_6_0.tweenId = nil

	arg_6_0:refreshProgress()
	arg_6_0:tryPlayFullAnim()
end

function var_0_0.tryPlayFullAnim(arg_7_0)
	if arg_7_0:checkTriggerEffect() then
		gohelper.setActive(arg_7_0.goFull, false)
		gohelper.setActive(arg_7_0.goFull, true)
		AudioMgr.instance:trigger(410000031)
	end
end

function var_0_0.checkTriggerEffect(arg_8_0)
	local var_8_0 = arg_8_0.entityMo and arg_8_0.entityMo:getPowerInfo(arg_8_0.powerType)

	if not var_8_0 then
		return
	end

	local var_8_1 = var_8_0.max

	if arg_8_0.entityMo:hasBuffId(107311008) then
		var_8_1 = 0.8 * var_8_1
	end

	return var_8_1 <= var_8_0.num
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0:refreshProgress()
end

function var_0_0.directSetProgress(arg_10_0, arg_10_1)
	arg_10_0.imageProgress.fillAmount = arg_10_1
	arg_10_0.txtProgress.text = string.format("%s%%", math.floor(arg_10_1 * 100))
end

function var_0_0.refreshProgress(arg_11_0)
	local var_11_0 = arg_11_0.entityMo and arg_11_0.entityMo:getPowerInfo(arg_11_0.powerType)

	if not var_11_0 then
		return
	end

	local var_11_1 = var_11_0.num / var_11_0.max

	arg_11_0:directSetProgress(var_11_1)
end

function var_0_0.killTween(arg_12_0)
	if arg_12_0.tweenId then
		ZProj.TweenHelper.KillById(arg_12_0.tweenId)

		arg_12_0.tweenId = nil
	end
end

function var_0_0.onDestroyView(arg_13_0)
	arg_13_0:killTween()
end

return var_0_0
