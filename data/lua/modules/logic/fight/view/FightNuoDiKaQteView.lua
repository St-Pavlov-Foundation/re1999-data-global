module("modules.logic.fight.view.FightNuoDiKaQteView", package.seeall)

local var_0_0 = class("FightNuoDiKaQteView", FightBaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.level0 = gohelper.findChild(arg_1_0.viewGO, "operate/root/level0")
	arg_1_0.level1 = gohelper.findChild(arg_1_0.viewGO, "operate/root/level1")
	arg_1_0.level2 = gohelper.findChild(arg_1_0.viewGO, "operate/root/level2")
	arg_1_0.level3 = gohelper.findChild(arg_1_0.viewGO, "operate/root/level3")
	arg_1_0.countText = gohelper.findChildText(arg_1_0.viewGO, "operate/root/num/#txt_num")
	arg_1_0.countEffectText = gohelper.findChildText(arg_1_0.viewGO, "operate/root/num/#txt_num_effect")
	arg_1_0.text1 = gohelper.findChildText(arg_1_0.viewGO, "operate/root/level1/#txt_num")
	arg_1_0.text2 = gohelper.findChildText(arg_1_0.viewGO, "operate/root/level2/#txt_num")
	arg_1_0.text3 = gohelper.findChildText(arg_1_0.viewGO, "operate/root/level3/#txt_num")
	arg_1_0.btnClick = gohelper.findChildClick(arg_1_0.viewGO, "operate/root/#btn_click")
	arg_1_0.ani = gohelper.onceAddComponent(arg_1_0.viewGO, typeof(UnityEngine.Animator))
	arg_1_0.numAni = gohelper.findChildComponent(arg_1_0.viewGO, "operate/root/num", typeof(UnityEngine.Animator))
	arg_1_0._longPress = SLFramework.UGUI.UILongPressListener.Get(arg_1_0.btnClick.gameObject)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:com_registClick(arg_2_0.btnClick, arg_2_0.onBtnClick)
	arg_2_0:com_registLongPress(arg_2_0._longPress, arg_2_0._onLongPress)
	arg_2_0._longPress:SetLongPressTime({
		0.1
	})
	arg_2_0:com_registFightEvent(FightEvent.PlayOnceQteWhenTimeout, arg_2_0.onPlayOnceQteWhenTimeout)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onConstructor(arg_4_0)
	return
end

function var_0_0.onPlayOnceQteWhenTimeout(arg_5_0)
	arg_5_0:clickFunc()
end

function var_0_0.onBtnClick(arg_6_0)
	if arg_6_0.clickCount == arg_6_0.maxCount then
		return
	end

	local var_6_0 = Time.time

	arg_6_0.time = arg_6_0.time or var_6_0

	if var_6_0 - arg_6_0.time > arg_6_0.timeLimit then
		arg_6_0.time = var_6_0

		arg_6_0:clickFunc()
	end
end

function var_0_0._onLongPress(arg_7_0)
	arg_7_0:onBtnClick()
end

function var_0_0.clickFunc(arg_8_0)
	if arg_8_0:com_sendMsg(FightMsgId.OperationForPlayEffect, arg_8_0.effectType) then
		arg_8_0.clickCount = arg_8_0.clickCount + 1

		local var_8_0 = arg_8_0:refreshBtn()
		local var_8_1 = var_8_0 == 1 and "click" or "click" .. var_8_0

		arg_8_0.ani:Play(var_8_1, 0, 0)
		arg_8_0.numAni:Play("update", 0, 0)
		AudioMgr.instance:trigger(20280402)

		if arg_8_0.clickCount == 1 then
			AudioMgr.instance:trigger(20280401)
		end
	end
end

function var_0_0.refreshText(arg_9_0)
	local var_9_0 = arg_9_0.maxCount - arg_9_0.clickCount

	arg_9_0.countText.text = var_9_0
	arg_9_0.countEffectText.text = var_9_0
end

function var_0_0.refreshBtn(arg_10_0)
	arg_10_0:refreshText()

	if arg_10_0.clickCount <= arg_10_0.levelCount[1] then
		gohelper.setActive(arg_10_0.level0, false)
		gohelper.setActive(arg_10_0.level1, true)
		gohelper.setActive(arg_10_0.level2, false)
		gohelper.setActive(arg_10_0.level3, false)

		return 1
	end

	if arg_10_0.clickCount <= arg_10_0.levelCount[2] then
		gohelper.setActive(arg_10_0.level0, false)
		gohelper.setActive(arg_10_0.level1, false)
		gohelper.setActive(arg_10_0.level2, true)
		gohelper.setActive(arg_10_0.level3, false)

		return 2
	end

	if arg_10_0.clickCount <= arg_10_0.levelCount[3] then
		gohelper.setActive(arg_10_0.level0, false)
		gohelper.setActive(arg_10_0.level1, false)
		gohelper.setActive(arg_10_0.level2, false)
		gohelper.setActive(arg_10_0.level3, true)

		return 3
	end

	return 3
end

function var_0_0.onOpen(arg_11_0)
	arg_11_0.time = 0
	arg_11_0.effectType = arg_11_0.viewParam.effectType
	arg_11_0.timeLimit = arg_11_0.viewParam.timeLimit
	arg_11_0.paramsArr = arg_11_0.viewParam.paramsArr
	arg_11_0.fightStepData = arg_11_0.viewParam.fightStepData
	arg_11_0.maxCount = 0

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.fightStepData.actEffect) do
		if iter_11_1.effectType == arg_11_0.effectType then
			arg_11_0.maxCount = string.splitToNumber(iter_11_1.reserveStr, "#")[2] or 0

			break
		end
	end

	local var_11_0 = GameUtil.splitString2(arg_11_0.paramsArr[2], false, ",", "#") or {}

	arg_11_0.levelCount = {}
	arg_11_0.clickCount = 0

	for iter_11_2, iter_11_3 in ipairs(var_11_0) do
		local var_11_1 = tonumber(iter_11_3[1])

		arg_11_0.levelCount[iter_11_2] = var_11_1
	end

	gohelper.setActive(arg_11_0.level0, true)
	gohelper.setActive(arg_11_0.level1, false)
	gohelper.setActive(arg_11_0.level2, false)
	gohelper.setActive(arg_11_0.level3, false)
	arg_11_0:refreshText()
	arg_11_0:com_registUpdate(arg_11_0.onUpdate)
	arg_11_0:com_sendFightEvent(FightEvent.SetBossHpVisibleWhenHidingFightView, true)

	arg_11_0.showBtnNames = {
		"btnSpeed",
		"btnAuto"
	}

	arg_11_0:com_sendFightEvent(FightEvent.SetBtnListVisibleWhenHidingFightView, true, arg_11_0.showBtnNames)
end

function var_0_0.onUpdate(arg_12_0)
	if FightDataHelper.stateMgr:getIsAuto() or FightDataHelper.stateMgr.isReplay then
		arg_12_0:onBtnClick()
	end
end

function var_0_0.onClose(arg_13_0)
	arg_13_0:com_sendFightEvent(FightEvent.SetBossHpVisibleWhenHidingFightView, false)
	arg_13_0:com_sendFightEvent(FightEvent.SetBtnListVisibleWhenHidingFightView, false, arg_13_0.showBtnNames)
end

function var_0_0.onDestroyView(arg_14_0)
	return
end

return var_0_0
