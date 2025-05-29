module("modules.logic.versionactivity2_6.dicehero.view.DiceHeroMainView", package.seeall)

local var_0_0 = class("DiceHeroMainView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnTask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Task")
	arg_1_0._gotaskred = gohelper.findChild(arg_1_0.viewGO, "#btn_Task/#go_reddot")
	arg_1_0._taskAnimator = gohelper.findChildAnim(arg_1_0.viewGO, "#btn_Task/ani")

	for iter_1_0 = 1, 5 do
		arg_1_0["_btnstage" .. iter_1_0] = gohelper.findChildButton(arg_1_0.viewGO, "#btn_stage" .. iter_1_0)
		arg_1_0["_lockAnim" .. iter_1_0] = gohelper.findChildAnim(arg_1_0.viewGO, "#btn_stage" .. iter_1_0 .. "/lock")
	end

	arg_1_0._lockAnim5 = gohelper.findChildAnim(arg_1_0.viewGO, "#btn_stage5")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnTask:AddClickListener(arg_2_0._onClickTask, arg_2_0)

	for iter_2_0 = 1, 5 do
		arg_2_0["_btnstage" .. iter_2_0]:AddClickListener(arg_2_0._onClickStage, arg_2_0, iter_2_0)
	end

	DiceHeroController.instance:registerCallback(DiceHeroEvent.InfoUpdate, arg_2_0._onInfoUpdate, arg_2_0)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateRelateDotInfo, arg_2_0._refreshTask, arg_2_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_2_0._onCloseViewFinish, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnTask:RemoveClickListener()

	for iter_3_0 = 1, 5 do
		arg_3_0["_btnstage" .. iter_3_0]:RemoveClickListener()
	end

	DiceHeroController.instance:unregisterCallback(DiceHeroEvent.InfoUpdate, arg_3_0._onInfoUpdate, arg_3_0)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateRelateDotInfo, arg_3_0._refreshTask, arg_3_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_3_0._onCloseViewFinish, arg_3_0)
end

function var_0_0.onOpen(arg_4_0)
	arg_4_0:_refreshTask()

	DiceHeroModel.instance.isUnlockNewChapter = false

	RedDotController.instance:addRedDot(arg_4_0._gotaskred, RedDotEnum.DotNode.V2a6DiceHero)
	arg_4_0:_onInfoUpdate()
end

function var_0_0._refreshTask(arg_5_0)
	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.V2a6DiceHero, 0) then
		arg_5_0._taskAnimator:Play("loop", 0, 0)
	else
		arg_5_0._taskAnimator:Play("idle", 0, 0)
	end
end

function var_0_0._onClickTask(arg_6_0)
	ViewMgr.instance:openView(ViewName.DiceHeroTaskView)
end

function var_0_0._onCloseViewFinish(arg_7_0, arg_7_1)
	if arg_7_1 == ViewName.DiceHeroLevelView and DiceHeroModel.instance.isUnlockNewChapter then
		AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_unclockchapter)

		DiceHeroModel.instance.isUnlockNewChapter = false

		arg_7_0:_onInfoUpdate()
		UIBlockHelper.instance:startBlock("DiceHeroMainView_PlayUnlock", 1.5)

		local var_7_0 = #DiceHeroModel.instance.unlockChapterIds

		if var_7_0 == 5 then
			arg_7_0._lockAnim5:Play("open", 0, 0)
		else
			gohelper.setActive(arg_7_0["_lockAnim" .. var_7_0], true)
			arg_7_0["_lockAnim" .. var_7_0]:Play("unlock", 0, 0)
		end

		TaskDispatcher.runDelay(arg_7_0._delayRefreshAnim, arg_7_0, 1.5)
	end
end

function var_0_0._delayRefreshAnim(arg_8_0)
	local var_8_0 = #DiceHeroModel.instance.unlockChapterIds

	if var_8_0 == 5 then
		arg_8_0._lockAnim5:Play("loop", 0, 0)
	else
		gohelper.setActive(arg_8_0["_lockAnim" .. var_8_0], false)
	end
end

function var_0_0._onInfoUpdate(arg_9_0)
	if DiceHeroModel.instance.isUnlockNewChapter then
		return
	end

	local var_9_0 = DiceHeroModel.instance.unlockChapterIds

	for iter_9_0 = 1, 5 do
		local var_9_1 = DiceHeroModel.instance:getGameInfo(iter_9_0)
		local var_9_2 = arg_9_0["_btnstage" .. iter_9_0].gameObject
		local var_9_3 = gohelper.findChild(var_9_2, "normal")
		local var_9_4 = gohelper.findChild(var_9_2, "lock")
		local var_9_5 = gohelper.findChild(var_9_2, "challenge")
		local var_9_6 = gohelper.findChildTextMesh(var_9_2, "Name/#txt_name") or gohelper.findChildTextMesh(var_9_2, "#txt_name")
		local var_9_7 = gohelper.findChild(var_9_2, "Name")

		gohelper.setActive(var_9_3, var_9_0[iter_9_0] and var_9_1.allPass)
		gohelper.setActive(var_9_4, not var_9_0[iter_9_0])
		gohelper.setActive(var_9_7, var_9_0[iter_9_0])
		gohelper.setActive(var_9_5, var_9_0[iter_9_0] and not var_9_1.allPass)

		if iter_9_0 == 5 then
			gohelper.setActive(var_9_2, var_9_0[iter_9_0])
		end

		local var_9_8 = DiceHeroConfig.instance:getLevelCo(iter_9_0, 1)

		if var_9_8 and var_9_6 then
			var_9_6.text = GameUtil.setFirstStrSize(var_9_8.chapterName, 70)
		end
	end
end

function var_0_0._onClickStage(arg_10_0, arg_10_1)
	if not DiceHeroModel.instance.unlockChapterIds[arg_10_1] then
		GameFacade.showToast(ToastEnum.DiceHeroLockChapter)

		return
	end

	arg_10_0._enterChapterId = arg_10_1

	arg_10_0:_enterChapter()
end

function var_0_0._enterChapter(arg_11_0)
	if not arg_11_0._enterChapterId then
		return
	end

	local var_11_0 = DiceHeroConfig.instance:getLevelCo(arg_11_0._enterChapterId, 1)

	if not var_11_0 then
		return
	end

	ViewMgr.instance:openView(ViewName.DiceHeroLevelView, {
		chapterId = arg_11_0._enterChapterId,
		isInfinite = var_11_0.mode == 2
	})
end

function var_0_0.onDestroyView(arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0._delayRefreshAnim, arg_12_0)
end

return var_0_0
