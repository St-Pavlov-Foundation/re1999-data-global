module("modules.logic.versionactivity1_5.dungeon.view.revivaltask.VersionActivity1_5SubHeroTaskItem", package.seeall)

local var_0_0 = class("VersionActivity1_5SubHeroTaskItem", UserDataDispose)

function var_0_0.createItem(arg_1_0)
	local var_1_0 = var_0_0.New()

	var_1_0:init(arg_1_0)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0:__onInit()

	arg_2_0.go = arg_2_1
	arg_2_0._gofinished = gohelper.findChild(arg_2_0.go, "#go_finished")
	arg_2_0._txttitle = gohelper.findChildText(arg_2_0.go, "#go_finished/#txt_title")
	arg_2_0._txtdes = gohelper.findChildText(arg_2_0.go, "#go_finished/#txt_des")
	arg_2_0._gofinishrewarditem = gohelper.findChild(arg_2_0.go, "#go_finished/#go_finishrewarditem")
	arg_2_0._goGainReward = gohelper.findChild(arg_2_0.go, "#go_finished/#go_gainReward")
	arg_2_0.tipClick = gohelper.findChildClickWithDefaultAudio(arg_2_0.go, "#go_finished/bg")
	arg_2_0._gohasget = gohelper.findChild(arg_2_0.go, "#go_finished/go_hasget")
	arg_2_0._finishAnimator = ZProj.ProjAnimatorPlayer.Get(arg_2_0._gofinished)
	arg_2_0._gonormal = gohelper.findChild(arg_2_0.go, "#go_normal")
	arg_2_0._txtnormaltitle = gohelper.findChildText(arg_2_0.go, "#go_normal/#txt_title")
	arg_2_0._txtnormaldes = gohelper.findChildText(arg_2_0.go, "#go_normal/#txt_des")
	arg_2_0._gonormalrewarditem = gohelper.findChild(arg_2_0.go, "#go_normal/#go_normalrewarditem")
	arg_2_0._btngo = gohelper.findChildButtonWithAudio(arg_2_0.go, "#go_normal/btn_go")
	arg_2_0._normalAnimator = ZProj.ProjAnimatorPlayer.Get(arg_2_0._gonormal)
	arg_2_0._golocked = gohelper.findChild(arg_2_0.go, "#go_locked")
	arg_2_0._txtlocked = gohelper.findChildText(arg_2_0.go, "#go_locked/#txt_locked")
	arg_2_0._golockrewarditem = gohelper.findChild(arg_2_0.go, "#go_locked/#go_lockrewarditem")
	arg_2_0._lockAnimator = ZProj.ProjAnimatorPlayer.Get(arg_2_0._golocked)
	arg_2_0._gainRewardClick = gohelper.getClickWithDefaultAudio(arg_2_0._goGainReward, AudioEnum.UI.UI_Common_Click)

	arg_2_0.tipClick:AddClickListener(arg_2_0.tipClickOnClick, arg_2_0)
	arg_2_0._btngo:AddClickListener(arg_2_0._btngoOnClick, arg_2_0)
	arg_2_0._gainRewardClick:AddClickListener(arg_2_0.onClickGainReward, arg_2_0)

	arg_2_0.openViewFinish = ViewMgr.instance:isOpenFinish(ViewName.VersionActivity1_5RevivalTaskView)

	arg_2_0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnGainedSubHeroTaskReward, arg_2_0.onGainedSubHeroTaskReward, arg_2_0)
	arg_2_0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OpenAnimPlayingStatusChange, arg_2_0.openAnimPlayingStatusChange, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, arg_2_0.onOpenViewFinish, arg_2_0)

	arg_2_0._txtdes.overflowMode = TMPro.TextOverflowModes.Ellipsis
end

function var_0_0.tipClickOnClick(arg_3_0)
	if arg_3_0.status < VersionActivity1_5DungeonEnum.SubHeroTaskStatus.Finished then
		return
	end

	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.ShowSubTaskDetail, arg_3_0.config)
end

function var_0_0._btngoOnClick(arg_4_0)
	if arg_4_0.status ~= VersionActivity1_5DungeonEnum.SubHeroTaskStatus.Normal then
		return
	end

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.elementList) do
		if not DungeonMapModel.instance:elementIsFinished(iter_4_1) then
			ViewMgr.instance:closeView(ViewName.VersionActivity1_5RevivalTaskView)
			VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.FocusElement, iter_4_1)

			return
		end
	end
end

function var_0_0.onClickGainReward(arg_5_0)
	VersionActivity1_5DungeonRpc.instance:sendAct139GainSubHeroTaskRewardRequest(arg_5_0.id)
end

function var_0_0.show(arg_6_0)
	gohelper.setActive(arg_6_0.go, true)
end

function var_0_0.hide(arg_7_0)
	gohelper.setActive(arg_7_0.go, false)
end

function var_0_0.updateData(arg_8_0, arg_8_1)
	arg_8_0.id = arg_8_1.id
	arg_8_0.config = arg_8_1
	arg_8_0.elementList = string.splitToNumber(arg_8_0.config.elementIds, "#")

	local var_8_0 = string.splitToNumber(arg_8_0.config.reward, "#")

	arg_8_0.rewardType = var_8_0[1]
	arg_8_0.rewardId = var_8_0[2]
	arg_8_0.rewardQuantity = var_8_0[3]

	arg_8_0:refreshUI()
end

function var_0_0.refreshUI(arg_9_0)
	arg_9_0.status = VersionActivity1_5RevivalTaskModel.instance:getSubHeroTaskStatus(arg_9_0.config)

	gohelper.setActive(arg_9_0._gofinished, arg_9_0.status >= VersionActivity1_5DungeonEnum.SubHeroTaskStatus.Finished)
	gohelper.setActive(arg_9_0._gonormal, arg_9_0.status == VersionActivity1_5DungeonEnum.SubHeroTaskStatus.Normal)
	gohelper.setActive(arg_9_0._golocked, arg_9_0.status == VersionActivity1_5DungeonEnum.SubHeroTaskStatus.Lock)

	if arg_9_0.status >= VersionActivity1_5DungeonEnum.SubHeroTaskStatus.Finished then
		arg_9_0:refreshFinishedUI()
	elseif arg_9_0.status == VersionActivity1_5DungeonEnum.SubHeroTaskStatus.Normal then
		arg_9_0:refreshNormalUI()
	elseif arg_9_0.status == VersionActivity1_5DungeonEnum.SubHeroTaskStatus.Lock then
		arg_9_0:refreshLockUI()
	end

	arg_9_0.icon:setMOValue(arg_9_0.rewardType, arg_9_0.rewardId, arg_9_0.rewardQuantity)
	arg_9_0.icon:setScale(0.6, 0.6, 0.6)
end

function var_0_0.refreshFinishedUI(arg_10_0)
	arg_10_0._txttitle.text = arg_10_0.config.title

	if LangSettings.instance:isEn() then
		arg_10_0._txtdes.text = arg_10_0.config.desc .. " " .. arg_10_0.config.descSuffix, VersionActivity1_5DungeonEnum.HeroTaskDescShowCount, VersionActivity1_5DungeonEnum.Suffix
	else
		arg_10_0._txtdes.text = arg_10_0.config.desc .. arg_10_0.config.descSuffix, VersionActivity1_5DungeonEnum.HeroTaskDescShowCount, VersionActivity1_5DungeonEnum.Suffix
	end

	if not arg_10_0.finishRewardIcon then
		arg_10_0.finishRewardIcon = IconMgr.instance:getCommonItemIcon(arg_10_0._gofinishrewarditem)
	end

	arg_10_0.icon = arg_10_0.finishRewardIcon

	arg_10_0:refreshGainedReward()
	arg_10_0:playUnlockAnimation(arg_10_0.playFinishOpenAnim)
end

function var_0_0.refreshGainedReward(arg_11_0)
	local var_11_0 = VersionActivity1_5RevivalTaskModel.instance:checkSubHeroTaskGainedReward(arg_11_0.config)

	gohelper.setActive(arg_11_0._gohasget, var_11_0)
	gohelper.setActive(arg_11_0._goGainReward, not var_11_0)
end

function var_0_0.onGainedSubHeroTaskReward(arg_12_0, arg_12_1)
	if arg_12_0.id ~= arg_12_1 then
		return
	end

	arg_12_0:refreshGainedReward()
end

function var_0_0.refreshNormalUI(arg_13_0)
	arg_13_0._txtnormaltitle.text = arg_13_0.config.title
	arg_13_0._txtnormaldes.text = GameUtil.getBriefName(arg_13_0.config.desc, VersionActivity1_5DungeonEnum.HeroTaskDescShowCount, VersionActivity1_5DungeonEnum.Suffix)

	if not arg_13_0.normalRewardIcon then
		arg_13_0.normalRewardIcon = IconMgr.instance:getCommonItemIcon(arg_13_0._gonormalrewarditem)
	end

	arg_13_0.icon = arg_13_0.normalRewardIcon

	arg_13_0:playUnlockAnimation(arg_13_0.playNormalOpenAnim)
end

function var_0_0.refreshLockUI(arg_14_0)
	arg_14_0._txtlocked.text = arg_14_0.config.lockDesc

	if not arg_14_0.lockRewardIcon then
		arg_14_0.lockRewardIcon = IconMgr.instance:getCommonItemIcon(arg_14_0._golockrewarditem)
	end

	arg_14_0.icon = arg_14_0.lockRewardIcon

	arg_14_0._lockAnimator:Play("idle")
end

function var_0_0.playUnlockAnimation(arg_15_0, arg_15_1)
	if not VersionActivity1_5RevivalTaskModel.instance:checkIsPlayedUnlockAnimation(arg_15_0.config.id) then
		gohelper.setActive(arg_15_0._gofinished, false)
		gohelper.setActive(arg_15_0._gonormal, false)
		gohelper.setActive(arg_15_0._golocked, true)

		arg_15_0._txtlocked.text = arg_15_0.config.lockDesc

		if not arg_15_0.lockRewardIcon then
			arg_15_0.lockRewardIcon = IconMgr.instance:getCommonItemIcon(arg_15_0._golockrewarditem)
		end

		arg_15_0.lockRewardIcon:setMOValue(arg_15_0.rewardType, arg_15_0.rewardId, arg_15_0.rewardQuantity)
		arg_15_0.lockRewardIcon:setScale(0.6, 0.6, 0.6)

		arg_15_0.unlockCallback = arg_15_1

		arg_15_0:_playUnlockAnimation()
	end
end

function var_0_0._playUnlockAnimation(arg_16_0)
	if arg_16_0.status == VersionActivity1_5DungeonEnum.SubHeroTaskStatus.Lock then
		return
	end

	if VersionActivity1_5RevivalTaskModel.instance:checkIsPlayedUnlockAnimation(arg_16_0.config.id) then
		return
	end

	if not arg_16_0.openViewFinish then
		return
	end

	if VersionActivity1_5RevivalTaskModel.instance:getIsPlayingOpenAnim() then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_quest_unlock)
	arg_16_0._lockAnimator:Play("unlock", arg_16_0.unLockAnimationDone, arg_16_0)
end

function var_0_0.unLockAnimationDone(arg_17_0)
	VersionActivity1_5RevivalTaskModel.instance:playedUnlockAnimation(arg_17_0.config.id)
	gohelper.setActive(arg_17_0._golocked, false)

	if arg_17_0.unlockCallback then
		arg_17_0.unlockCallback(arg_17_0)

		arg_17_0.unlockCallback = nil
	end
end

function var_0_0.playNormalOpenAnim(arg_18_0)
	gohelper.setActive(arg_18_0._gonormal, true)
	arg_18_0._normalAnimator:Play("open")
end

function var_0_0.playFinishOpenAnim(arg_19_0)
	gohelper.setActive(arg_19_0._gofinished, true)
	arg_19_0._finishAnimator:Play("open")
end

function var_0_0.onOpenViewFinish(arg_20_0, arg_20_1)
	if arg_20_1 == ViewName.VersionActivity1_5RevivalTaskView then
		arg_20_0.openViewFinish = true

		arg_20_0:_playUnlockAnimation()
	end
end

function var_0_0.openAnimPlayingStatusChange(arg_21_0, arg_21_1)
	if not arg_21_1 then
		arg_21_0:_playUnlockAnimation()
	end
end

function var_0_0.destroy(arg_22_0)
	arg_22_0.tipClick:RemoveClickListener()
	arg_22_0._btngo:RemoveClickListener()
	arg_22_0._gainRewardClick:RemoveClickListener()
	arg_22_0:__onDispose()
end

return var_0_0
