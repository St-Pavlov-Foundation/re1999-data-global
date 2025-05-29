module("modules.logic.versionactivity2_6.dicehero.view.DiceHeroStageItem", package.seeall)

local var_0_0 = class("DiceHeroStageItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._btnClick = gohelper.findChildButton(arg_1_1, "")
	arg_1_0.viewGo = gohelper.findChild(arg_1_1, "#go_levelitem")
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGo, "#go_normal")
	arg_1_0._golock = gohelper.findChild(arg_1_0.viewGo, "#go_lock")
	arg_1_0._gochallenge = gohelper.findChild(arg_1_0.viewGo, "#go_challenge")
	arg_1_0._gocompleted = gohelper.findChild(arg_1_0.viewGo, "#go_completed")
	arg_1_0._gopart = gohelper.findChild(arg_1_1, "Part")
	arg_1_0._gobossicon1 = gohelper.findChild(arg_1_1, "Part/#go_BossIcon")
	arg_1_0._gobossicon2 = gohelper.findChild(arg_1_1, "Part/#go_BigBossIcon")
	arg_1_0._lockAnim = gohelper.findChildAnim(arg_1_0.viewGo, "#go_lock")
	arg_1_0._completedAnim = gohelper.findChildAnim(arg_1_0.viewGo, "#go_completed")
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnClick:AddClickListener(arg_2_0._onClickStage, arg_2_0)
	DiceHeroController.instance:registerCallback(DiceHeroEvent.InfoUpdate, arg_2_0._onInfoUpdate, arg_2_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_2_0._onCloseViewFinish, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnClick:RemoveClickListener()
	DiceHeroController.instance:unregisterCallback(DiceHeroEvent.InfoUpdate, arg_3_0._onInfoUpdate, arg_3_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_3_0._onCloseViewFinish, arg_3_0)
end

function var_0_0.initData(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._co = arg_4_1
	arg_4_0.isInfinite = arg_4_2

	gohelper.setActive(arg_4_0._gobossicon1, arg_4_1.enemyType == 1)
	gohelper.setActive(arg_4_0._gobossicon2, arg_4_1.enemyType == 2)
	arg_4_0:_onInfoUpdate()
end

function var_0_0._onCloseViewFinish(arg_5_0)
	if not ViewHelper.instance:checkViewOnTheTop(ViewName.DiceHeroLevelView) then
		return
	end

	arg_5_0:_onInfoUpdate()

	if arg_5_0._showUnlockAnim then
		gohelper.setActive(arg_5_0._lockAnim, true)
		arg_5_0._lockAnim:Play("unlock", 0, 0)
		TaskDispatcher.runDelay(arg_5_0._hideLock, arg_5_0, 2.4)
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockHelper.instance:startBlock("DiceHeroStageItem_Unlock", 2)
		AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_unclockglass)
	end

	if arg_5_0._showPassAnim then
		arg_5_0._showPassAnim = false

		arg_5_0._completedAnim:Play("completeglow", 0, 0)
	end
end

function var_0_0._hideLock(arg_6_0)
	UIBlockMgrExtend.setNeedCircleMv(true)
	gohelper.setActive(arg_6_0._lockAnim, false)

	arg_6_0._showUnlockAnim = false
end

function var_0_0._onInfoUpdate(arg_7_0)
	local var_7_0 = DiceHeroModel.instance:getGameInfo(arg_7_0._co.chapter)

	if arg_7_0._unLockStatu ~= nil and not ViewHelper.instance:checkViewOnTheTop(ViewName.DiceHeroLevelView) then
		local var_7_1 = arg_7_0._co.room - var_7_0.co.room

		if var_7_1 ~= arg_7_0._unLockStatu then
			if var_7_1 == 0 then
				arg_7_0._showUnlockAnim = true
			elseif var_7_1 == -1 and arg_7_0.isInfinite then
				arg_7_0._showPassAnim = true
			end
		end

		return
	end

	gohelper.setActive(arg_7_0._gonormal, not arg_7_0.isInfinite and (arg_7_0._co.room < var_7_0.co.room or var_7_0.allPass) or false)
	gohelper.setActive(arg_7_0._gocompleted, arg_7_0.isInfinite and (arg_7_0._co.room < var_7_0.co.room or var_7_0.allPass) or false)
	gohelper.setActive(arg_7_0._gochallenge, arg_7_0._co.room == var_7_0.co.room and not var_7_0.allPass)
	gohelper.setActive(arg_7_0._golock, arg_7_0._co.room > var_7_0.co.room)
	gohelper.setActive(arg_7_0._gopart, arg_7_0._co.room <= var_7_0.co.room)

	arg_7_0._unLockStatu = arg_7_0._co.room - var_7_0.co.room
end

function var_0_0._onClickStage(arg_8_0)
	if not arg_8_0._co then
		return
	end

	local var_8_0 = DiceHeroModel.instance:getGameInfo(arg_8_0._co.chapter)

	if var_8_0.co.room > arg_8_0._co.room then
		if arg_8_0.isInfinite then
			GameFacade.showToast(ToastEnum.DiceHeroPassLevel)

			return
		end

		AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_glassclick)

		if arg_8_0._co.type == DiceHeroEnum.LevelType.Story then
			ViewMgr.instance:openView(ViewName.DiceHeroTalkView, {
				co = arg_8_0._co
			})
		else
			DiceHeroRpc.instance:sendDiceHeroEnterFight(arg_8_0._co.id, arg_8_0._onEnterFight, arg_8_0)
		end

		return
	elseif var_8_0.co.room < arg_8_0._co.room then
		GameFacade.showToast(ToastEnum.DiceHeroLockLevel)

		return
	end

	AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_glassclick)

	if arg_8_0._co.type == DiceHeroEnum.LevelType.Story then
		if DiceHeroModel.instance:hasReward(arg_8_0._co.chapter) or arg_8_0._co.rewardSelectType == DiceHeroEnum.GetRewardType.None then
			arg_8_0:_onOpenDialog()
		else
			DiceHeroRpc.instance:sendDiceHeroEnterStory(arg_8_0._co.id, arg_8_0._co.chapter, arg_8_0._onEnterStory, arg_8_0)
		end
	elseif arg_8_0._co.type == DiceHeroEnum.LevelType.Fight then
		if DiceHeroModel.instance:hasReward(arg_8_0._co.chapter) then
			arg_8_0:_onOpenDialog()
		else
			DiceHeroRpc.instance:sendDiceHeroEnterFight(arg_8_0._co.id, arg_8_0._onEnterFight, arg_8_0)
		end
	end
end

function var_0_0._onEnterStory(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if arg_9_2 ~= 0 then
		return
	end

	arg_9_0:_onOpenDialog()
end

function var_0_0._onOpenDialog(arg_10_0)
	if not arg_10_0._co then
		return
	end

	ViewMgr.instance:openView(ViewName.DiceHeroTalkView, {
		co = arg_10_0._co
	})
end

function var_0_0._onEnterFight(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if arg_11_2 ~= 0 then
		return
	end

	ViewMgr.instance:openView(ViewName.DiceHeroGameView)
end

function var_0_0.onDestroy(arg_12_0)
	UIBlockMgrExtend.setNeedCircleMv(true)
	TaskDispatcher.cancelTask(arg_12_0._hideLock, arg_12_0)
end

return var_0_0
