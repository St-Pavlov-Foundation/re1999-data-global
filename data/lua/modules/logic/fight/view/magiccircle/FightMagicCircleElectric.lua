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
	arg_2_0.goVxRoot = gohelper.findChild(arg_2_0.go, "go_survivalEffect")
	arg_2_0.upVx = gohelper.findChild(arg_2_0.goVxRoot, "up")
	arg_2_0.upDown = gohelper.findChild(arg_2_0.goVxRoot, "down")

	gohelper.setActive(arg_2_0.goVxRoot, true)
	gohelper.setActive(arg_2_0.upVx, false)
	gohelper.setActive(arg_2_0.upDown, false)

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
	arg_2_0.preRecordProgress = 0

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

function var_0_0.refreshUI(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0.magicMo = arg_6_1
	arg_6_0.magicConfig = arg_6_2

	arg_6_0:refreshRound(arg_6_1, arg_6_2)
	arg_6_0:refreshSlider(arg_6_1, arg_6_2)
	arg_6_0:refreshEnergy(arg_6_1, arg_6_2)
	arg_6_0:playProgressChangeAnim(arg_6_3)
end

var_0_0.ChangeProgressEffect = "buff/buff_dianneng_zr"
var_0_0.ChangeProgressEffectAudioId = 20280002
var_0_0.EffectDuration = 1

function var_0_0.playProgressChangeAnim(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.magicMo.electricProgress

	if arg_7_0.preRecordProgress == var_7_0 then
		return
	end

	if var_7_0 > arg_7_0.preRecordProgress then
		gohelper.setActive(arg_7_0.upVx, false)
		gohelper.setActive(arg_7_0.upVx, true)
	else
		gohelper.setActive(arg_7_0.upDown, false)
		gohelper.setActive(arg_7_0.upDown, true)
	end

	arg_7_0.preRecordProgress = arg_7_0.magicMo.electricProgress

	local var_7_1 = arg_7_1 and FightHelper.getEntity(arg_7_1)

	if not var_7_1 then
		return
	end

	local var_7_2 = var_7_1.effect:addHangEffect(var_0_0.ChangeProgressEffect, ModuleEnum.SpineHangPoint.mountbottom, nil, var_0_0.EffectDuration)

	var_7_2:setLocalPos(0, 0, 0)
	FightRenderOrderMgr.instance:onAddEffectWrap(arg_7_1, var_7_2)
	AudioMgr.instance:trigger(var_0_0.ChangeProgressEffectAudioId)
end

function var_0_0.refreshRound(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_1.round == -1 and "∞" or arg_8_1.round

	arg_8_0.roundNumHero.text = var_8_0
	arg_8_0.roundNumEnemy.text = var_8_0

	local var_8_1 = FightHelper.getMagicSide(arg_8_1.createUid)

	gohelper.setActive(arg_8_0.goRoundHero, var_8_1 == FightEnum.EntitySide.MySide)
	gohelper.setActive(arg_8_0.goRoundEnemy, var_8_1 == FightEnum.EntitySide.EnemySide)
end

var_0_0.FillAmountDuration = 0.5

function var_0_0.refreshSlider(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.curMaxProgress = arg_9_1.maxElectricProgress

	if not arg_9_0.preProgress then
		arg_9_0:refreshSliderByProgressAndLevel(arg_9_1.electricProgress, arg_9_1.electricLevel)
		arg_9_0:showCurLevelVx()

		arg_9_0.preProgress = arg_9_1.electricProgress
		arg_9_0.preLevel = arg_9_1.electricLevel

		return
	end

	local var_9_0 = arg_9_1.electricProgress
	local var_9_1 = arg_9_0.preProgress

	arg_9_0.preProgress = var_9_0

	arg_9_0:clearTween()

	arg_9_0.tweenId = ZProj.TweenHelper.DOTweenFloat(var_9_1, var_9_0, var_0_0.FillAmountDuration, arg_9_0.tweenProgress, arg_9_0.onTweenFinish, arg_9_0)
end

function var_0_0.tweenProgress(arg_10_0, arg_10_1)
	arg_10_1 = math.floor(arg_10_1)

	local var_10_0 = arg_10_0.magicMo.electricLevel

	arg_10_0:refreshSliderByProgressAndLevel(arg_10_1, var_10_0)
end

function var_0_0.refreshSliderByProgressAndLevel(arg_11_0, arg_11_1, arg_11_2)
	for iter_11_0, iter_11_1 in ipairs(arg_11_0.imageSlider) do
		if iter_11_0 == arg_11_2 then
			if iter_11_0 == 3 then
				arg_11_0.textSlider.text = "MAX"
				iter_11_1.fillAmount = 1
			else
				local var_11_0 = arg_11_0.curMaxProgress

				if not var_11_0 or var_11_0 < 1 then
					local var_11_1 = lua_fight_dnsz.configList[arg_11_2 + 1]

					var_11_0 = 0

					if var_11_1 then
						var_11_0 = var_11_1.progress
					else
						logError("not found fight_dnsz co, level : " .. tostring(arg_11_2))

						var_11_0 = 1
					end
				end

				iter_11_1.fillAmount = arg_11_1 / var_11_0
				arg_11_0.textSlider.text = string.format("%s/<#E3E3E3>%s</COLOR>", arg_11_1, var_11_0)
			end
		else
			iter_11_1.fillAmount = 0
		end
	end
end

function var_0_0.onTweenFinish(arg_12_0)
	arg_12_0:showCurLevelVx()
	arg_12_0:clearTween()
end

function var_0_0.showCurLevelVx(arg_13_0)
	local var_13_0 = arg_13_0.magicMo.electricLevel

	for iter_13_0, iter_13_1 in pairs(arg_13_0.levelVxDict) do
		gohelper.setActive(iter_13_1, iter_13_0 <= var_13_0)
	end
end

function var_0_0.refreshEnergy(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_1.electricLevel

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.energyList) do
		for iter_14_2, iter_14_3 in ipairs(iter_14_1) do
			gohelper.setActive(iter_14_3, iter_14_0 <= var_14_0 and iter_14_2 == var_14_0)
		end
	end
end

function var_0_0.getLevelByProgress(arg_15_0, arg_15_1)
	local var_15_0 = lua_fight_dnsz.configList

	for iter_15_0 = #var_15_0, 1, -1 do
		local var_15_1 = var_15_0[iter_15_0]

		if arg_15_1 >= var_15_1.progress then
			return var_15_1.level
		end
	end

	return 1
end

function var_0_0.getLevelCo(arg_16_0, arg_16_1)
	return lua_fight_dnsz.configDict[arg_16_1] or lua_fight_dnsz.configDict[1]
end

function var_0_0.clearTween(arg_17_0)
	if arg_17_0.tweenId then
		ZProj.TweenHelper.KillById(arg_17_0.tweenId)

		arg_17_0.tweenId = nil
	end
end

function var_0_0.destroy(arg_18_0)
	arg_18_0:clearTween()

	if arg_18_0._click then
		arg_18_0._click:RemoveClickListener()
	end

	var_0_0.super.destroy(arg_18_0)
end

return var_0_0
