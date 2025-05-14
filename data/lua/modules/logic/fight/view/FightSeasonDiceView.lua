module("modules.logic.fight.view.FightSeasonDiceView", package.seeall)

local var_0_0 = class("FightSeasonDiceView", BaseView)
local var_0_1 = 3.27
local var_0_2 = 1.66

function var_0_0.onInitView(arg_1_0)
	arg_1_0._godicemovie = gohelper.findChild(arg_1_0.viewGO, "root/#go_dicemovie")
	arg_1_0._imagewave = gohelper.findChildImage(arg_1_0.viewGO, "root/#go_dicemovie/center/tv/#image_wave")
	arg_1_0._txtvalue = gohelper.findChildText(arg_1_0.viewGO, "root/#go_dicemovie/center/tv/#txt_value")
	arg_1_0._txtvalueef = gohelper.findChildText(arg_1_0.viewGO, "root/#go_dicemovie/center/tv/#txt_value_ef")
	arg_1_0._godiceresult = gohelper.findChild(arg_1_0.viewGO, "root/#go_diceresult")
	arg_1_0._gofriend = gohelper.findChild(arg_1_0.viewGO, "root/#go_diceresult/#go_friend")
	arg_1_0._txtresultvalue = gohelper.findChildText(arg_1_0.viewGO, "root/#go_diceresult/#go_friend/tv/#txt_resultvalue")
	arg_1_0._txtresultvalueef = gohelper.findChildText(arg_1_0.viewGO, "root/#go_diceresult/#go_friend/tv/#txt_resultvalueef")
	arg_1_0._txteffectdesc = gohelper.findChildText(arg_1_0.viewGO, "root/#go_diceresult/#go_friend/effect/layout/#txt_effectdesc")
	arg_1_0._ani = gohelper.onceAddComponent(arg_1_0.viewGO, typeof(UnityEngine.Animator))
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.PushEndFight, arg_2_0._onEndFight, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.SetIsShowUI, arg_2_0._setIsShowUI, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnRoundSequenceStart, arg_2_0._onRoundSequenceStart, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_2_0._onOpenView, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_2_0._onCloseView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.PushEndFight, arg_3_0._onEndFight, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.SetIsShowUI, arg_3_0._setIsShowUI, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.OnRoundSequenceStart, arg_3_0._onRoundSequenceStart, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_3_0._onOpenView, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_3_0._onCloseView, arg_3_0)
end

function var_0_0._onOpenView(arg_4_0, arg_4_1)
	if arg_4_1 == ViewName.FightFocusView then
		gohelper.setActiveCanvasGroup(arg_4_0._godicemovie, false)
		gohelper.setActiveCanvasGroup(arg_4_0._godiceresult, false)
	end
end

function var_0_0._onCloseView(arg_5_0, arg_5_1)
	if arg_5_1 == ViewName.FightFocusView then
		gohelper.setActiveCanvasGroup(arg_5_0._godicemovie, true)
		gohelper.setActiveCanvasGroup(arg_5_0._godiceresult, true)
	end
end

function var_0_0._onRoundSequenceStart(arg_6_0)
	gohelper.setActive(arg_6_0._godicemovie, false)
	gohelper.setActive(arg_6_0._godiceresult, false)
end

function var_0_0._setIsShowUI(arg_7_0, arg_7_1)
	if not arg_7_0._canvasGroup then
		arg_7_0._canvasGroup = gohelper.onceAddComponent(arg_7_0.viewGO, typeof(UnityEngine.CanvasGroup))
	end

	gohelper.setActiveCanvasGroup(arg_7_0._canvasGroup, arg_7_1)
end

function var_0_0._onEndFight(arg_8_0)
	arg_8_0:closeThis()
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0:_setDiceInfo()
	arg_9_0:_checkPlayDice()
end

function var_0_0.onUpdateParam(arg_10_0)
	arg_10_0:_setDiceInfo()
	arg_10_0:_checkPlayDice()
end

function var_0_0._setDiceInfo(arg_11_0)
	local var_11_0 = 0
	local var_11_1 = ""

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.viewParam) do
		local var_11_2 = iter_11_1[1]
		local var_11_3 = iter_11_1[2]
		local var_11_4 = var_11_3.effectNum % 10
		local var_11_5 = lua_skill.configDict[var_11_3.effectNum]

		if var_11_2.fromId == FightEntityScene.MySideId then
			var_11_0 = var_11_4
			var_11_1 = var_11_5 and var_11_5.desc
		end
	end

	gohelper.setActive(arg_11_0._godicemovie, var_11_0 > 0)
	gohelper.setActive(arg_11_0._godiceresult, var_11_0 > 0)

	arg_11_0._txtvalue.text = var_11_0
	arg_11_0._txtvalueef.text = var_11_0
	arg_11_0._txtresultvalue.text = var_11_0
	arg_11_0._txtresultvalueef.text = var_11_0
	arg_11_0._txteffectdesc.text = var_11_1
	arg_11_0._fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(arg_11_0._txteffectdesc.gameObject, FixTmpBreakLine)

	arg_11_0._fixTmpBreakLine:refreshTmpContent(arg_11_0._txteffectdesc)
end

function var_0_0._checkPlayDice(arg_12_0)
	local var_12_0 = FightModel.instance:getUISpeed()

	if not FightModel.instance:isStartFinish() then
		gohelper.setActive(arg_12_0._godicemovie, true)
		gohelper.setActive(arg_12_0._godiceresult, true)
		arg_12_0._ani:Play("open", 0, 0)

		arg_12_0._ani.speed = var_12_0

		TaskDispatcher.runDelay(arg_12_0._delayFirstRoundDone, arg_12_0, var_0_1 / var_12_0)
		AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_luckydice01)
	else
		gohelper.setActive(arg_12_0._godicemovie, false)
		gohelper.setActive(arg_12_0._godiceresult, true)
		arg_12_0._ani:Play("result", 0, 0)

		arg_12_0._ani.speed = var_12_0

		TaskDispatcher.runDelay(arg_12_0._delayNotFirstRoundDone, arg_12_0, var_0_2 / var_12_0)
		gohelper.setActiveCanvasGroup(arg_12_0._godiceresult, false)
		TaskDispatcher.runDelay(arg_12_0._nextFrameShow, arg_12_0, 0.01)
		AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_luckydice02)
	end
end

function var_0_0._nextFrameShow(arg_13_0)
	gohelper.setActiveCanvasGroup(arg_13_0._godiceresult, true)
end

function var_0_0._delayFirstRoundDone(arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0._delayFirstRoundDone, arg_14_0)
	FightController.instance:dispatchEvent(FightEvent.OnDiceEnd)
end

function var_0_0._delayNotFirstRoundDone(arg_15_0)
	TaskDispatcher.cancelTask(arg_15_0._delayNotFirstRoundDone, arg_15_0)
	FightController.instance:dispatchEvent(FightEvent.OnDiceEnd)
end

function var_0_0.onClose(arg_16_0)
	TaskDispatcher.cancelTask(arg_16_0._delayFirstRoundDone, arg_16_0)
	TaskDispatcher.cancelTask(arg_16_0._delayNotFirstRoundDone, arg_16_0)
	TaskDispatcher.cancelTask(arg_16_0._nextFrameShow, arg_16_0)
end

function var_0_0.onDestroyView(arg_17_0)
	return
end

return var_0_0
