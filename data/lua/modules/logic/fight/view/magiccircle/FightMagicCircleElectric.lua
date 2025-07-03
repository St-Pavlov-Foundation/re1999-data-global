module("modules.logic.fight.view.magiccircle.FightMagicCircleElectric", package.seeall)

local var_0_0 = class("FightMagicCircleElectric", FightMagicCircleBaseItem)

function var_0_0.getUIType(arg_1_0)
	return FightEnum.MagicCircleUIType.Electric
end

function var_0_0.initView(arg_2_0)
	arg_2_0.rectTr = arg_2_0.go:GetComponent(gohelper.Type_RectTransform)
	arg_2_0.sliderAnimator = gohelper.findChildComponent(arg_2_0.go, "slider", gohelper.Type_Animator)
	arg_2_0.textSlider = gohelper.findChildText(arg_2_0.go, "slider/sliderbg/#txt_slidernum")
	arg_2_0.goRoundHero = gohelper.findChild(arg_2_0.go, "slider/round/hero")
	arg_2_0.roundNumHero = gohelper.findChildText(arg_2_0.go, "slider/round/hero/#txt_round")
	arg_2_0.goRoundEnemy = gohelper.findChild(arg_2_0.go, "slider/round/enemy")
	arg_2_0.roundNumEnemy = gohelper.findChildText(arg_2_0.go, "slider/round/enemy/#txt_round")
	arg_2_0.imageSliderFlash = gohelper.findChildImage(arg_2_0.go, "slider/sliderbg/slider_flashbg")
	arg_2_0.imageSliderFlash.fillAmount = 0
	arg_2_0.imageSlider = arg_2_0:getUserDataTb_()

	for iter_2_0 = 1, 3 do
		local var_2_0 = gohelper.findChildImage(arg_2_0.go, "slider/sliderbg/slider_level" .. iter_2_0)

		arg_2_0.imageSlider[iter_2_0] = var_2_0
		var_2_0.fillAmount = 0

		gohelper.setActive(var_2_0.gameObject, true)
	end

	arg_2_0.energyList = {}

	for iter_2_1 = 1, 3 do
		local var_2_1 = arg_2_0:getUserDataTb_()

		arg_2_0.energyList[iter_2_1] = var_2_1

		local var_2_2 = gohelper.findChild(arg_2_0.go, "slider/energy/" .. iter_2_1)

		for iter_2_2 = 1, 3 do
			table.insert(var_2_1, gohelper.findChild(var_2_2, "light" .. iter_2_2))
		end
	end

	arg_2_0._click = gohelper.findChildClickWithDefaultAudio(arg_2_0.go, "btn")

	arg_2_0._click:AddClickListener(arg_2_0.onClickSelf, arg_2_0)

	arg_2_0.levelVxDict = arg_2_0:getUserDataTb_()
	arg_2_0.levelVxDict[1] = gohelper.findChild(arg_2_0.go, "slider/vx/1")
	arg_2_0.levelVxDict[2] = gohelper.findChild(arg_2_0.go, "slider/vx/2")
	arg_2_0.levelVxDict[3] = gohelper.findChild(arg_2_0.go, "slider/vx/3")

	arg_2_0:addEventCb(FightController.instance, FightEvent.UpgradeMagicCircile, arg_2_0.onUpgradeMagicCircle, arg_2_0)
end

var_0_0.Upgrade2AnimatorName = {
	[2] = "upgrade_01",
	[3] = "upgrade_02"
}

function var_0_0.onUpgradeMagicCircle(arg_3_0, arg_3_1)
	local var_3_0 = lua_magic_circle.configDict[arg_3_1.magicCircleId]
	local var_3_1 = arg_3_1.electricLevel
	local var_3_2 = arg_3_0.Upgrade2AnimatorName[var_3_1]

	if var_3_2 then
		arg_3_0.sliderAnimator:Play(var_3_2, 0, 0)
	end

	arg_3_0.preProgress = 0

	arg_3_0:refreshUI(arg_3_1, var_3_0)
	AudioMgr.instance:trigger(20270001)
end

function var_0_0.onClickSelf(arg_4_0)
	local var_4_0 = recthelper.getHeight(arg_4_0.rectTr)
	local var_4_1 = arg_4_0.rectTr.position

	FightController.instance:dispatchEvent(FightEvent.OnClickMagicCircleText, var_4_0, var_4_1)
end

function var_0_0.onCreateMagic(arg_5_0, arg_5_1, arg_5_2)
	var_0_0.super.onCreateMagic(arg_5_0, arg_5_1, arg_5_2)
	AudioMgr.instance:trigger(20270001)
end

function var_0_0.refreshUI(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.magicMo = arg_6_1
	arg_6_0.magicConfig = arg_6_2

	arg_6_0:refreshRound(arg_6_1, arg_6_2)
	arg_6_0:refreshSlider(arg_6_1, arg_6_2)
	arg_6_0:refreshEnergy(arg_6_1, arg_6_2)
end

function var_0_0.refreshRound(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_1.round == -1 and "∞" or arg_7_1.round

	arg_7_0.roundNumHero.text = var_7_0
	arg_7_0.roundNumEnemy.text = var_7_0

	local var_7_1 = FightHelper.getMagicSide(arg_7_1.createUid)

	gohelper.setActive(arg_7_0.goRoundHero, var_7_1 == FightEnum.EntitySide.MySide)
	gohelper.setActive(arg_7_0.goRoundEnemy, var_7_1 == FightEnum.EntitySide.EnemySide)
end

var_0_0.FillAmountDuration = 0.5

function var_0_0.refreshSlider(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_0.preProgress then
		arg_8_0:refreshSliderByProgressAndLevel(arg_8_1.electricProgress, arg_8_1.electricLevel)
		arg_8_0:showCurLevelVx()

		arg_8_0.preProgress = arg_8_1.electricProgress
		arg_8_0.preLevel = arg_8_1.electricLevel

		return
	end

	local var_8_0 = arg_8_1.electricProgress
	local var_8_1 = arg_8_0.preProgress

	arg_8_0.preProgress = var_8_0

	arg_8_0:clearTween()

	arg_8_0.tweenId = ZProj.TweenHelper.DOTweenFloat(var_8_1, var_8_0, var_0_0.FillAmountDuration, arg_8_0.tweenProgress, arg_8_0.onTweenFinish, arg_8_0)
end

function var_0_0.tweenProgress(arg_9_0, arg_9_1)
	arg_9_1 = math.floor(arg_9_1)

	local var_9_0 = arg_9_0.magicMo.electricLevel

	arg_9_0:refreshSliderByProgressAndLevel(arg_9_1, var_9_0)
end

function var_0_0.refreshSliderByProgressAndLevel(arg_10_0, arg_10_1, arg_10_2)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0.imageSlider) do
		if iter_10_0 == arg_10_2 then
			if iter_10_0 == 3 then
				arg_10_0.textSlider.text = "MAX"
				iter_10_1.fillAmount = 1
			else
				local var_10_0 = lua_fight_dnsz.configList[arg_10_2 + 1]
				local var_10_1 = 0

				if var_10_0 then
					var_10_1 = var_10_0.progress
				end

				iter_10_1.fillAmount = arg_10_1 / var_10_1
				arg_10_0.textSlider.text = string.format("%s/<#E3E3E3>%s</COLOR>", arg_10_1, var_10_1)
			end
		else
			iter_10_1.fillAmount = 0
		end
	end
end

function var_0_0.onTweenFinish(arg_11_0)
	arg_11_0:showCurLevelVx()
	arg_11_0:clearTween()
end

function var_0_0.showCurLevelVx(arg_12_0)
	local var_12_0 = arg_12_0.magicMo.electricLevel

	for iter_12_0, iter_12_1 in pairs(arg_12_0.levelVxDict) do
		gohelper.setActive(iter_12_1, iter_12_0 <= var_12_0)
	end
end

function var_0_0.refreshEnergy(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_1.electricLevel

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.energyList) do
		for iter_13_2, iter_13_3 in ipairs(iter_13_1) do
			gohelper.setActive(iter_13_3, iter_13_0 <= var_13_0 and iter_13_2 == var_13_0)
		end
	end
end

function var_0_0.getLevelByProgress(arg_14_0, arg_14_1)
	local var_14_0 = lua_fight_dnsz.configList

	for iter_14_0 = #var_14_0, 1, -1 do
		local var_14_1 = var_14_0[iter_14_0]

		if arg_14_1 >= var_14_1.progress then
			return var_14_1.level
		end
	end

	return 1
end

function var_0_0.getLevelCo(arg_15_0, arg_15_1)
	return lua_fight_dnsz.configDict[arg_15_1] or lua_fight_dnsz.configDict[1]
end

function var_0_0.clearTween(arg_16_0)
	if arg_16_0.tweenId then
		ZProj.TweenHelper.KillById(arg_16_0.tweenId)

		arg_16_0.tweenId = nil
	end
end

function var_0_0.destroy(arg_17_0)
	arg_17_0:clearTween()

	if arg_17_0._click then
		arg_17_0._click:RemoveClickListener()
	end

	var_0_0.super.destroy(arg_17_0)
end

return var_0_0
