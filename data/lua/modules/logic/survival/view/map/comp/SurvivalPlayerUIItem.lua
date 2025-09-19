module("modules.logic.survival.view.map.comp.SurvivalPlayerUIItem", package.seeall)

local var_0_0 = class("SurvivalPlayerUIItem", SurvivalUnitUIItem)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._gohero = gohelper.findChild(arg_1_1, "hero")
	arg_1_0._imageprogress = gohelper.findChildImage(arg_1_1, "hero/#image_progress")
	arg_1_0._imageprogressbg = gohelper.findChildImage(arg_1_1, "hero/image_progressbg")

	var_0_0.super.init(arg_1_0, arg_1_1)
	arg_1_0:setIconEnable()
end

function var_0_0.addEventListeners(arg_2_0)
	var_0_0.super.addEventListeners(arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.ShowSurvivalHeroTick, arg_2_0._showHeroTick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	var_0_0.super.removeEventListeners(arg_3_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.ShowSurvivalHeroTick, arg_3_0._showHeroTick, arg_3_0)
end

function var_0_0.refreshInfo(arg_4_0)
	gohelper.setActive(arg_4_0._golevel, false)
	gohelper.setActive(arg_4_0._imageicon, false)
	gohelper.setActive(arg_4_0._imagebubble, false)
	gohelper.setActive(arg_4_0._imageprogressbg, false)
	gohelper.setActive(arg_4_0._imageprogress, false)
end

function var_0_0._showHeroTick(arg_5_0, arg_5_1, arg_5_2)
	gohelper.setActive(arg_5_0._imageprogressbg, true)
	gohelper.setActive(arg_5_0._imageprogress, true)

	arg_5_0._curVal = arg_5_1
	arg_5_0._totalVal = arg_5_2
	arg_5_0._imageprogress.fillAmount = (arg_5_1 - 1) / arg_5_2
	arg_5_0._tweenId = ZProj.TweenHelper.DOFillAmount(arg_5_0._imageprogress, arg_5_1 / arg_5_2, SurvivalEnum.MoveSpeed, arg_5_0._onTweenEnd, arg_5_0, nil, EaseType.Linear)
end

function var_0_0._onTweenEnd(arg_6_0)
	if arg_6_0._curVal == arg_6_0._totalVal then
		gohelper.setActive(arg_6_0._imageprogressbg, false)
		gohelper.setActive(arg_6_0._imageprogress, false)
	end

	arg_6_0._tweenId = nil
end

function var_0_0.setIconEnable(arg_7_0, arg_7_1)
	arg_7_0._isIconEnabled = arg_7_1

	arg_7_0:updateIconShow()
end

function var_0_0._onArrowChange(arg_8_0, arg_8_1)
	var_0_0.super._onArrowChange(arg_8_0, arg_8_1)
	gohelper.setActive(arg_8_0._imagebubble, false)
	arg_8_0:updateIconShow()
end

function var_0_0.updateIconShow(arg_9_0)
	gohelper.setActive(arg_9_0._gohero, arg_9_0._isIconEnabled or arg_9_0._isArrowShow)
end

function var_0_0.checkEnabled(arg_10_0)
	return
end

function var_0_0.onDestroy(arg_11_0)
	if arg_11_0._tweenId then
		ZProj.TweenHelper.KillById(arg_11_0._tweenId)

		arg_11_0._tweenId = nil
	end
end

return var_0_0
