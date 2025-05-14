module("modules.logic.fight.view.FightDiceView", package.seeall)

local var_0_0 = class("FightDiceView", BaseView)
local var_0_1 = 3.27
local var_0_2 = 1.66

function var_0_0.onInitView(arg_1_0)
	arg_1_0._movieGO = gohelper.findChild(arg_1_0.viewGO, "dicemovie")
	arg_1_0._resultGO = gohelper.findChild(arg_1_0.viewGO, "diceresult")
	arg_1_0._movieEnemyGO = gohelper.findChild(arg_1_0.viewGO, "dicemovie/dice/#go_enemy")
	arg_1_0._movieFriendGO = gohelper.findChild(arg_1_0.viewGO, "dicemovie/dice/#go_friend")
	arg_1_0._resultEnemyGO = gohelper.findChild(arg_1_0.viewGO, "diceresult/#go_enemy")
	arg_1_0._resultFriendGO = gohelper.findChild(arg_1_0.viewGO, "diceresult/#go_friend")
	arg_1_0._txtMovieEnemyDice = gohelper.findChildText(arg_1_0.viewGO, "dicemovie/dice/#go_enemy/#txt_enemyroundcount")
	arg_1_0._txtMovieEnemyDice2 = gohelper.findChildText(arg_1_0.viewGO, "dicemovie/dice/#go_enemy/#txt_enemyroundcount_copy")
	arg_1_0._txtMovieFriendDice = gohelper.findChildText(arg_1_0.viewGO, "dicemovie/dice/#go_friend/#txt_friendroundcount")
	arg_1_0._txtMovieFriendDice2 = gohelper.findChildText(arg_1_0.viewGO, "dicemovie/dice/#go_friend/#txt_friendroundcount_copy")
	arg_1_0._txtResultEnemyDice = gohelper.findChildText(arg_1_0.viewGO, "diceresult/#go_enemy/#txt_enemyroundcount")
	arg_1_0._txtResultEnemyDice2 = gohelper.findChildText(arg_1_0.viewGO, "diceresult/#go_enemy/#txt_enemyroundcount_copy02")
	arg_1_0._txtResultFriendDice = gohelper.findChildText(arg_1_0.viewGO, "diceresult/#go_friend/#txt_friendroundcount")
	arg_1_0._txtResultFriendDice2 = gohelper.findChildText(arg_1_0.viewGO, "diceresult/#go_friend/#txt_friendroundcount_copy02")
	arg_1_0._txtResultEnemyDesc = gohelper.findChildText(arg_1_0.viewGO, "diceresult/#go_enemy/#txt_enemybuffdes")
	arg_1_0._txtResultFriendDesc = gohelper.findChildText(arg_1_0.viewGO, "diceresult/#go_friend/#txt_friendbuffdes")
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "dicemovie/#simage_bg")
	arg_1_0._simageenemybg = gohelper.findChildSingleImage(arg_1_0.viewGO, "dicemovie/dice/#go_enemy/#simage_enemybg")
	arg_1_0._simagefriendbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "dicemovie/dice/#go_friend/#simage_friendbg")
	arg_1_0._simageenemyresultbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "diceresult/#go_enemy/#simage_enemybg")
	arg_1_0._simagefriendresultbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "diceresult/#go_friend/#simage_friendbg")

	arg_1_0._simagebg:LoadImage(ResUrl.getFightDiceBg("full/bg_bj"))
	arg_1_0._simageenemybg:LoadImage(ResUrl.getFightQuitResultIcon("zhandou_icon_di"))
	arg_1_0._simagefriendbg:LoadImage(ResUrl.getFightQuitResultIcon("zhandou_icon_di"))
	arg_1_0._simageenemyresultbg:LoadImage(ResUrl.getFightQuitResultIcon("zhandou_icon_di"))
	arg_1_0._simagefriendresultbg:LoadImage(ResUrl.getFightQuitResultIcon("zhandou_icon_di"))

	arg_1_0._firstRoundAnimation = gohelper.onceAddComponent(arg_1_0.viewGO, typeof(UnityEngine.Animation))
	arg_1_0._resultEnemyAnimation = gohelper.onceAddComponent(gohelper.findChild(arg_1_0.viewGO, "diceresult/#go_enemy"), typeof(UnityEngine.Animation))
	arg_1_0._resultFriendAnimation = gohelper.onceAddComponent(gohelper.findChild(arg_1_0.viewGO, "diceresult/#go_friend"), typeof(UnityEngine.Animation))
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
		gohelper.setActiveCanvasGroup(arg_4_0._movieGO, false)
		gohelper.setActiveCanvasGroup(arg_4_0._resultGO, false)
	end
end

function var_0_0._onCloseView(arg_5_0, arg_5_1)
	if arg_5_1 == ViewName.FightFocusView then
		gohelper.setActiveCanvasGroup(arg_5_0._movieGO, true)
		gohelper.setActiveCanvasGroup(arg_5_0._resultGO, true)
	end
end

function var_0_0._onRoundSequenceStart(arg_6_0)
	gohelper.setActive(arg_6_0._movieGO, false)
	gohelper.setActive(arg_6_0._resultGO, false)
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
	local var_11_1 = 0
	local var_11_2 = ""
	local var_11_3 = ""

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.viewParam) do
		local var_11_4 = iter_11_1[1]
		local var_11_5 = iter_11_1[2]
		local var_11_6 = var_11_5.effectNum % 10
		local var_11_7 = lua_skill.configDict[var_11_5.effectNum]

		if var_11_4.fromId == FightEntityScene.MySideId then
			var_11_1 = var_11_6
			var_11_3 = FightConfig.instance:getSkillEffectDesc(nil, var_11_7)
		elseif var_11_4.fromId == FightEntityScene.EnemySideId then
			var_11_0 = var_11_6
			var_11_2 = FightConfig.instance:getSkillEffectDesc(nil, var_11_7)
		end
	end

	gohelper.setActive(arg_11_0._movieEnemyGO, var_11_0 > 0)
	gohelper.setActive(arg_11_0._movieFriendGO, var_11_1 > 0)
	gohelper.setActive(arg_11_0._resultEnemyGO, var_11_0 > 0)
	gohelper.setActive(arg_11_0._resultFriendGO, var_11_1 > 0)

	arg_11_0._txtMovieEnemyDice.text = var_11_0
	arg_11_0._txtMovieEnemyDice2.text = var_11_0
	arg_11_0._txtMovieFriendDice.text = var_11_1
	arg_11_0._txtMovieFriendDice2.text = var_11_1
	arg_11_0._txtResultEnemyDice.text = var_11_0
	arg_11_0._txtResultEnemyDice2.text = var_11_0
	arg_11_0._txtResultFriendDice.text = var_11_1
	arg_11_0._txtResultFriendDice2.text = var_11_1
	arg_11_0._txtResultEnemyDesc.text = var_11_2
	arg_11_0._txtResultFriendDesc.text = var_11_3
end

function var_0_0._checkPlayDice(arg_12_0)
	local var_12_0 = FightModel.instance:getUISpeed()

	if not FightModel.instance:isStartFinish() then
		gohelper.setActive(arg_12_0._movieGO, true)
		gohelper.setActive(arg_12_0._resultGO, true)
		arg_12_0._firstRoundAnimation:Play()
		gohelper.onceAddComponent(arg_12_0._firstRoundAnimation.gameObject, typeof(ZProj.EffectTimeScale)):SetTimeScale(var_12_0)
		TaskDispatcher.runDelay(arg_12_0._delayFirstRoundDone, arg_12_0, var_0_1 / var_12_0)
		AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_luckydice01)
	else
		gohelper.setActive(arg_12_0._movieGO, false)
		gohelper.setActive(arg_12_0._resultGO, true)
		arg_12_0._resultEnemyAnimation:Play()
		arg_12_0._resultFriendAnimation:Play()
		gohelper.onceAddComponent(arg_12_0._resultEnemyAnimation.gameObject, typeof(ZProj.EffectTimeScale)):SetTimeScale(var_12_0)
		gohelper.onceAddComponent(arg_12_0._resultFriendAnimation.gameObject, typeof(ZProj.EffectTimeScale)):SetTimeScale(var_12_0)
		TaskDispatcher.runDelay(arg_12_0._delayNotFirstRoundDone, arg_12_0, var_0_2 / var_12_0)
		gohelper.setActiveCanvasGroup(arg_12_0._resultGO, false)
		TaskDispatcher.runDelay(arg_12_0._nextFrameShow, arg_12_0, 0.01)
		AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_luckydice02)
	end
end

function var_0_0._nextFrameShow(arg_13_0)
	gohelper.setActiveCanvasGroup(arg_13_0._resultGO, true)
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
	arg_17_0._simagebg:UnLoadImage()
	arg_17_0._simageenemybg:UnLoadImage()
	arg_17_0._simagefriendbg:UnLoadImage()
	arg_17_0._simageenemyresultbg:UnLoadImage()
	arg_17_0._simagefriendresultbg:UnLoadImage()
end

return var_0_0
