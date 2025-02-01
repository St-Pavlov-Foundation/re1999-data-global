module("modules.logic.fight.view.FightDiceView", package.seeall)

slot0 = class("FightDiceView", BaseView)
slot1 = 3.27
slot2 = 1.66

function slot0.onInitView(slot0)
	slot0._movieGO = gohelper.findChild(slot0.viewGO, "dicemovie")
	slot0._resultGO = gohelper.findChild(slot0.viewGO, "diceresult")
	slot0._movieEnemyGO = gohelper.findChild(slot0.viewGO, "dicemovie/dice/#go_enemy")
	slot0._movieFriendGO = gohelper.findChild(slot0.viewGO, "dicemovie/dice/#go_friend")
	slot0._resultEnemyGO = gohelper.findChild(slot0.viewGO, "diceresult/#go_enemy")
	slot0._resultFriendGO = gohelper.findChild(slot0.viewGO, "diceresult/#go_friend")
	slot0._txtMovieEnemyDice = gohelper.findChildText(slot0.viewGO, "dicemovie/dice/#go_enemy/#txt_enemyroundcount")
	slot0._txtMovieEnemyDice2 = gohelper.findChildText(slot0.viewGO, "dicemovie/dice/#go_enemy/#txt_enemyroundcount_copy")
	slot0._txtMovieFriendDice = gohelper.findChildText(slot0.viewGO, "dicemovie/dice/#go_friend/#txt_friendroundcount")
	slot0._txtMovieFriendDice2 = gohelper.findChildText(slot0.viewGO, "dicemovie/dice/#go_friend/#txt_friendroundcount_copy")
	slot0._txtResultEnemyDice = gohelper.findChildText(slot0.viewGO, "diceresult/#go_enemy/#txt_enemyroundcount")
	slot0._txtResultEnemyDice2 = gohelper.findChildText(slot0.viewGO, "diceresult/#go_enemy/#txt_enemyroundcount_copy02")
	slot0._txtResultFriendDice = gohelper.findChildText(slot0.viewGO, "diceresult/#go_friend/#txt_friendroundcount")
	slot0._txtResultFriendDice2 = gohelper.findChildText(slot0.viewGO, "diceresult/#go_friend/#txt_friendroundcount_copy02")
	slot0._txtResultEnemyDesc = gohelper.findChildText(slot0.viewGO, "diceresult/#go_enemy/#txt_enemybuffdes")
	slot0._txtResultFriendDesc = gohelper.findChildText(slot0.viewGO, "diceresult/#go_friend/#txt_friendbuffdes")
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "dicemovie/#simage_bg")
	slot0._simageenemybg = gohelper.findChildSingleImage(slot0.viewGO, "dicemovie/dice/#go_enemy/#simage_enemybg")
	slot0._simagefriendbg = gohelper.findChildSingleImage(slot0.viewGO, "dicemovie/dice/#go_friend/#simage_friendbg")
	slot0._simageenemyresultbg = gohelper.findChildSingleImage(slot0.viewGO, "diceresult/#go_enemy/#simage_enemybg")
	slot0._simagefriendresultbg = gohelper.findChildSingleImage(slot0.viewGO, "diceresult/#go_friend/#simage_friendbg")

	slot0._simagebg:LoadImage(ResUrl.getFightDiceBg("full/bg_bj"))
	slot0._simageenemybg:LoadImage(ResUrl.getFightQuitResultIcon("zhandou_icon_di"))
	slot0._simagefriendbg:LoadImage(ResUrl.getFightQuitResultIcon("zhandou_icon_di"))
	slot0._simageenemyresultbg:LoadImage(ResUrl.getFightQuitResultIcon("zhandou_icon_di"))
	slot0._simagefriendresultbg:LoadImage(ResUrl.getFightQuitResultIcon("zhandou_icon_di"))

	slot0._firstRoundAnimation = gohelper.onceAddComponent(slot0.viewGO, typeof(UnityEngine.Animation))
	slot0._resultEnemyAnimation = gohelper.onceAddComponent(gohelper.findChild(slot0.viewGO, "diceresult/#go_enemy"), typeof(UnityEngine.Animation))
	slot0._resultFriendAnimation = gohelper.onceAddComponent(gohelper.findChild(slot0.viewGO, "diceresult/#go_friend"), typeof(UnityEngine.Animation))
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
		gohelper.setActiveCanvasGroup(slot0._movieGO, false)
		gohelper.setActiveCanvasGroup(slot0._resultGO, false)
	end
end

function slot0._onCloseView(slot0, slot1)
	if slot1 == ViewName.FightFocusView then
		gohelper.setActiveCanvasGroup(slot0._movieGO, true)
		gohelper.setActiveCanvasGroup(slot0._resultGO, true)
	end
end

function slot0._onRoundSequenceStart(slot0)
	gohelper.setActive(slot0._movieGO, false)
	gohelper.setActive(slot0._resultGO, false)
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
	slot2 = 0
	slot3 = ""
	slot4 = ""

	for slot8, slot9 in ipairs(slot0.viewParam) do
		slot11 = slot9[2]

		if slot9[1].fromId == FightEntityScene.MySideId then
			slot2 = slot11.effectNum % 10
			slot4 = FightConfig.instance:getSkillEffectDesc(nil, lua_skill.configDict[slot11.effectNum])
		elseif slot10.fromId == FightEntityScene.EnemySideId then
			slot1 = slot12
			slot3 = FightConfig.instance:getSkillEffectDesc(nil, slot13)
		end
	end

	gohelper.setActive(slot0._movieEnemyGO, slot1 > 0)
	gohelper.setActive(slot0._movieFriendGO, slot2 > 0)
	gohelper.setActive(slot0._resultEnemyGO, slot1 > 0)
	gohelper.setActive(slot0._resultFriendGO, slot2 > 0)

	slot0._txtMovieEnemyDice.text = slot1
	slot0._txtMovieEnemyDice2.text = slot1
	slot0._txtMovieFriendDice.text = slot2
	slot0._txtMovieFriendDice2.text = slot2
	slot0._txtResultEnemyDice.text = slot1
	slot0._txtResultEnemyDice2.text = slot1
	slot0._txtResultFriendDice.text = slot2
	slot0._txtResultFriendDice2.text = slot2
	slot0._txtResultEnemyDesc.text = slot3
	slot0._txtResultFriendDesc.text = slot4
end

function slot0._checkPlayDice(slot0)
	slot1 = FightModel.instance:getUISpeed()

	if not FightModel.instance:isStartFinish() then
		gohelper.setActive(slot0._movieGO, true)
		gohelper.setActive(slot0._resultGO, true)
		slot0._firstRoundAnimation:Play()
		gohelper.onceAddComponent(slot0._firstRoundAnimation.gameObject, typeof(ZProj.EffectTimeScale)):SetTimeScale(slot1)
		TaskDispatcher.runDelay(slot0._delayFirstRoundDone, slot0, uv0 / slot1)
		AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_luckydice01)
	else
		gohelper.setActive(slot0._movieGO, false)
		gohelper.setActive(slot0._resultGO, true)
		slot0._resultEnemyAnimation:Play()
		slot0._resultFriendAnimation:Play()
		gohelper.onceAddComponent(slot0._resultEnemyAnimation.gameObject, typeof(ZProj.EffectTimeScale)):SetTimeScale(slot1)
		gohelper.onceAddComponent(slot0._resultFriendAnimation.gameObject, typeof(ZProj.EffectTimeScale)):SetTimeScale(slot1)
		TaskDispatcher.runDelay(slot0._delayNotFirstRoundDone, slot0, uv1 / slot1)
		gohelper.setActiveCanvasGroup(slot0._resultGO, false)
		TaskDispatcher.runDelay(slot0._nextFrameShow, slot0, 0.01)
		AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_luckydice02)
	end
end

function slot0._nextFrameShow(slot0)
	gohelper.setActiveCanvasGroup(slot0._resultGO, true)
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
	slot0._simagebg:UnLoadImage()
	slot0._simageenemybg:UnLoadImage()
	slot0._simagefriendbg:UnLoadImage()
	slot0._simageenemyresultbg:UnLoadImage()
	slot0._simagefriendresultbg:UnLoadImage()
end

return slot0
