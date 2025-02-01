module("modules.logic.fight.view.FightSeasonDiceView", package.seeall)

slot0 = class("FightSeasonDiceView", BaseView)
slot1 = 3.27
slot2 = 1.66

function slot0.onInitView(slot0)
	slot0._godicemovie = gohelper.findChild(slot0.viewGO, "root/#go_dicemovie")
	slot0._imagewave = gohelper.findChildImage(slot0.viewGO, "root/#go_dicemovie/center/tv/#image_wave")
	slot0._txtvalue = gohelper.findChildText(slot0.viewGO, "root/#go_dicemovie/center/tv/#txt_value")
	slot0._txtvalueef = gohelper.findChildText(slot0.viewGO, "root/#go_dicemovie/center/tv/#txt_value_ef")
	slot0._godiceresult = gohelper.findChild(slot0.viewGO, "root/#go_diceresult")
	slot0._gofriend = gohelper.findChild(slot0.viewGO, "root/#go_diceresult/#go_friend")
	slot0._txtresultvalue = gohelper.findChildText(slot0.viewGO, "root/#go_diceresult/#go_friend/tv/#txt_resultvalue")
	slot0._txtresultvalueef = gohelper.findChildText(slot0.viewGO, "root/#go_diceresult/#go_friend/tv/#txt_resultvalueef")
	slot0._txteffectdesc = gohelper.findChildText(slot0.viewGO, "root/#go_diceresult/#go_friend/effect/layout/#txt_effectdesc")
	slot0._ani = gohelper.onceAddComponent(slot0.viewGO, typeof(UnityEngine.Animator))
end

function slot0.addEvents(slot0)
	slot0:addEventCb(FightController.instance, FightEvent.PushEndFight, slot0._onEndFight, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.SetIsShowUI, slot0._setIsShowUI, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnRoundSequenceStart, slot0._onRoundSequenceStart, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.PushEndFight, slot0._onEndFight, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.SetIsShowUI, slot0._setIsShowUI, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnRoundSequenceStart, slot0._onRoundSequenceStart, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
end

function slot0._onOpenView(slot0, slot1)
	if slot1 == ViewName.FightFocusView then
		gohelper.setActiveCanvasGroup(slot0._godicemovie, false)
		gohelper.setActiveCanvasGroup(slot0._godiceresult, false)
	end
end

function slot0._onCloseView(slot0, slot1)
	if slot1 == ViewName.FightFocusView then
		gohelper.setActiveCanvasGroup(slot0._godicemovie, true)
		gohelper.setActiveCanvasGroup(slot0._godiceresult, true)
	end
end

function slot0._onRoundSequenceStart(slot0)
	gohelper.setActive(slot0._godicemovie, false)
	gohelper.setActive(slot0._godiceresult, false)
end

function slot0._setIsShowUI(slot0, slot1)
	if not slot0._canvasGroup then
		slot0._canvasGroup = gohelper.onceAddComponent(slot0.viewGO, typeof(UnityEngine.CanvasGroup))
	end

	gohelper.setActiveCanvasGroup(slot0._canvasGroup, slot1)
end

function slot0._onEndFight(slot0)
	slot0:closeThis()
end

function slot0.onOpen(slot0)
	slot0:_setDiceInfo()
	slot0:_checkPlayDice()
end

function slot0.onUpdateParam(slot0)
	slot0:_setDiceInfo()
	slot0:_checkPlayDice()
end

function slot0._setDiceInfo(slot0)
	slot1 = 0
	slot2 = ""

	for slot6, slot7 in ipairs(slot0.viewParam) do
		slot9 = slot7[2]
		slot11 = lua_skill.configDict[slot9.effectNum]

		if slot7[1].fromId == FightEntityScene.MySideId then
			slot1 = slot9.effectNum % 10
			slot2 = slot11 and slot11.desc
		end
	end

	gohelper.setActive(slot0._godicemovie, slot1 > 0)
	gohelper.setActive(slot0._godiceresult, slot1 > 0)

	slot0._txtvalue.text = slot1
	slot0._txtvalueef.text = slot1
	slot0._txtresultvalue.text = slot1
	slot0._txtresultvalueef.text = slot1
	slot0._txteffectdesc.text = slot2
	slot0._fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._txteffectdesc.gameObject, FixTmpBreakLine)

	slot0._fixTmpBreakLine:refreshTmpContent(slot0._txteffectdesc)
end

function slot0._checkPlayDice(slot0)
	slot1 = FightModel.instance:getUISpeed()

	if not FightModel.instance:isStartFinish() then
		gohelper.setActive(slot0._godicemovie, true)
		gohelper.setActive(slot0._godiceresult, true)
		slot0._ani:Play("open", 0, 0)

		slot0._ani.speed = slot1

		TaskDispatcher.runDelay(slot0._delayFirstRoundDone, slot0, uv0 / slot1)
		AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_luckydice01)
	else
		gohelper.setActive(slot0._godicemovie, false)
		gohelper.setActive(slot0._godiceresult, true)
		slot0._ani:Play("result", 0, 0)

		slot0._ani.speed = slot1

		TaskDispatcher.runDelay(slot0._delayNotFirstRoundDone, slot0, uv1 / slot1)
		gohelper.setActiveCanvasGroup(slot0._godiceresult, false)
		TaskDispatcher.runDelay(slot0._nextFrameShow, slot0, 0.01)
		AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_luckydice02)
	end
end

function slot0._nextFrameShow(slot0)
	gohelper.setActiveCanvasGroup(slot0._godiceresult, true)
end

function slot0._delayFirstRoundDone(slot0)
	TaskDispatcher.cancelTask(slot0._delayFirstRoundDone, slot0)
	FightController.instance:dispatchEvent(FightEvent.OnDiceEnd)
end

function slot0._delayNotFirstRoundDone(slot0)
	TaskDispatcher.cancelTask(slot0._delayNotFirstRoundDone, slot0)
	FightController.instance:dispatchEvent(FightEvent.OnDiceEnd)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._delayFirstRoundDone, slot0)
	TaskDispatcher.cancelTask(slot0._delayNotFirstRoundDone, slot0)
	TaskDispatcher.cancelTask(slot0._nextFrameShow, slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
