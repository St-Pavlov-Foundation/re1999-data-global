module("modules.logic.versionactivity1_5.dungeon.view.revivaltask.VersionActivity1_5SubHeroTaskItem", package.seeall)

slot0 = class("VersionActivity1_5SubHeroTaskItem", UserDataDispose)

function slot0.createItem(slot0)
	slot1 = uv0.New()

	slot1:init(slot0)

	return slot1
end

function slot0.init(slot0, slot1)
	slot0:__onInit()

	slot0.go = slot1
	slot0._gofinished = gohelper.findChild(slot0.go, "#go_finished")
	slot0._txttitle = gohelper.findChildText(slot0.go, "#go_finished/#txt_title")
	slot0._txtdes = gohelper.findChildText(slot0.go, "#go_finished/#txt_des")
	slot0._gofinishrewarditem = gohelper.findChild(slot0.go, "#go_finished/#go_finishrewarditem")
	slot0._goGainReward = gohelper.findChild(slot0.go, "#go_finished/#go_gainReward")
	slot0.tipClick = gohelper.findChildClickWithDefaultAudio(slot0.go, "#go_finished/bg")
	slot0._gohasget = gohelper.findChild(slot0.go, "#go_finished/go_hasget")
	slot0._finishAnimator = ZProj.ProjAnimatorPlayer.Get(slot0._gofinished)
	slot0._gonormal = gohelper.findChild(slot0.go, "#go_normal")
	slot0._txtnormaltitle = gohelper.findChildText(slot0.go, "#go_normal/#txt_title")
	slot0._txtnormaldes = gohelper.findChildText(slot0.go, "#go_normal/#txt_des")
	slot0._gonormalrewarditem = gohelper.findChild(slot0.go, "#go_normal/#go_normalrewarditem")
	slot0._btngo = gohelper.findChildButtonWithAudio(slot0.go, "#go_normal/btn_go")
	slot0._normalAnimator = ZProj.ProjAnimatorPlayer.Get(slot0._gonormal)
	slot0._golocked = gohelper.findChild(slot0.go, "#go_locked")
	slot0._txtlocked = gohelper.findChildText(slot0.go, "#go_locked/#txt_locked")
	slot0._golockrewarditem = gohelper.findChild(slot0.go, "#go_locked/#go_lockrewarditem")
	slot0._lockAnimator = ZProj.ProjAnimatorPlayer.Get(slot0._golocked)
	slot0._gainRewardClick = gohelper.getClickWithDefaultAudio(slot0._goGainReward, AudioEnum.UI.UI_Common_Click)

	slot0.tipClick:AddClickListener(slot0.tipClickOnClick, slot0)
	slot0._btngo:AddClickListener(slot0._btngoOnClick, slot0)
	slot0._gainRewardClick:AddClickListener(slot0.onClickGainReward, slot0)

	slot0.openViewFinish = ViewMgr.instance:isOpenFinish(ViewName.VersionActivity1_5RevivalTaskView)

	slot0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnGainedSubHeroTaskReward, slot0.onGainedSubHeroTaskReward, slot0)
	slot0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OpenAnimPlayingStatusChange, slot0.openAnimPlayingStatusChange, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, slot0.onOpenViewFinish, slot0)

	slot0._txtdes.overflowMode = TMPro.TextOverflowModes.Ellipsis
end

function slot0.tipClickOnClick(slot0)
	if slot0.status < VersionActivity1_5DungeonEnum.SubHeroTaskStatus.Finished then
		return
	end

	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.ShowSubTaskDetail, slot0.config)
end

function slot0._btngoOnClick(slot0)
	if slot0.status ~= VersionActivity1_5DungeonEnum.SubHeroTaskStatus.Normal then
		return
	end

	for slot4, slot5 in ipairs(slot0.elementList) do
		if not DungeonMapModel.instance:elementIsFinished(slot5) then
			ViewMgr.instance:closeView(ViewName.VersionActivity1_5RevivalTaskView)
			VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.FocusElement, slot5)

			return
		end
	end
end

function slot0.onClickGainReward(slot0)
	VersionActivity1_5DungeonRpc.instance:sendAct139GainSubHeroTaskRewardRequest(slot0.id)
end

function slot0.show(slot0)
	gohelper.setActive(slot0.go, true)
end

function slot0.hide(slot0)
	gohelper.setActive(slot0.go, false)
end

function slot0.updateData(slot0, slot1)
	slot0.id = slot1.id
	slot0.config = slot1
	slot0.elementList = string.splitToNumber(slot0.config.elementIds, "#")
	slot2 = string.splitToNumber(slot0.config.reward, "#")
	slot0.rewardType = slot2[1]
	slot0.rewardId = slot2[2]
	slot0.rewardQuantity = slot2[3]

	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot0.status = VersionActivity1_5RevivalTaskModel.instance:getSubHeroTaskStatus(slot0.config)

	gohelper.setActive(slot0._gofinished, VersionActivity1_5DungeonEnum.SubHeroTaskStatus.Finished <= slot0.status)
	gohelper.setActive(slot0._gonormal, slot0.status == VersionActivity1_5DungeonEnum.SubHeroTaskStatus.Normal)
	gohelper.setActive(slot0._golocked, slot0.status == VersionActivity1_5DungeonEnum.SubHeroTaskStatus.Lock)

	if VersionActivity1_5DungeonEnum.SubHeroTaskStatus.Finished <= slot0.status then
		slot0:refreshFinishedUI()
	elseif slot0.status == VersionActivity1_5DungeonEnum.SubHeroTaskStatus.Normal then
		slot0:refreshNormalUI()
	elseif slot0.status == VersionActivity1_5DungeonEnum.SubHeroTaskStatus.Lock then
		slot0:refreshLockUI()
	end

	slot0.icon:setMOValue(slot0.rewardType, slot0.rewardId, slot0.rewardQuantity)
	slot0.icon:setScale(0.6, 0.6, 0.6)
end

function slot0.refreshFinishedUI(slot0)
	slot0._txttitle.text = slot0.config.title

	if LangSettings.instance:isEn() then
		slot3 = VersionActivity1_5DungeonEnum.HeroTaskDescShowCount
		slot4 = VersionActivity1_5DungeonEnum.Suffix
		slot0._txtdes.text = slot0.config.desc .. " " .. slot0.config.descSuffix
	else
		slot3 = VersionActivity1_5DungeonEnum.HeroTaskDescShowCount
		slot4 = VersionActivity1_5DungeonEnum.Suffix
		slot0._txtdes.text = slot0.config.desc .. slot0.config.descSuffix
	end

	if not slot0.finishRewardIcon then
		slot0.finishRewardIcon = IconMgr.instance:getCommonItemIcon(slot0._gofinishrewarditem)
	end

	slot0.icon = slot0.finishRewardIcon

	slot0:refreshGainedReward()
	slot0:playUnlockAnimation(slot0.playFinishOpenAnim)
end

function slot0.refreshGainedReward(slot0)
	slot1 = VersionActivity1_5RevivalTaskModel.instance:checkSubHeroTaskGainedReward(slot0.config)

	gohelper.setActive(slot0._gohasget, slot1)
	gohelper.setActive(slot0._goGainReward, not slot1)
end

function slot0.onGainedSubHeroTaskReward(slot0, slot1)
	if slot0.id ~= slot1 then
		return
	end

	slot0:refreshGainedReward()
end

function slot0.refreshNormalUI(slot0)
	slot0._txtnormaltitle.text = slot0.config.title
	slot0._txtnormaldes.text = GameUtil.getBriefName(slot0.config.desc, VersionActivity1_5DungeonEnum.HeroTaskDescShowCount, VersionActivity1_5DungeonEnum.Suffix)

	if not slot0.normalRewardIcon then
		slot0.normalRewardIcon = IconMgr.instance:getCommonItemIcon(slot0._gonormalrewarditem)
	end

	slot0.icon = slot0.normalRewardIcon

	slot0:playUnlockAnimation(slot0.playNormalOpenAnim)
end

function slot0.refreshLockUI(slot0)
	slot0._txtlocked.text = slot0.config.lockDesc

	if not slot0.lockRewardIcon then
		slot0.lockRewardIcon = IconMgr.instance:getCommonItemIcon(slot0._golockrewarditem)
	end

	slot0.icon = slot0.lockRewardIcon

	slot0._lockAnimator:Play("idle")
end

function slot0.playUnlockAnimation(slot0, slot1)
	if not VersionActivity1_5RevivalTaskModel.instance:checkIsPlayedUnlockAnimation(slot0.config.id) then
		gohelper.setActive(slot0._gofinished, false)
		gohelper.setActive(slot0._gonormal, false)
		gohelper.setActive(slot0._golocked, true)

		slot0._txtlocked.text = slot0.config.lockDesc

		if not slot0.lockRewardIcon then
			slot0.lockRewardIcon = IconMgr.instance:getCommonItemIcon(slot0._golockrewarditem)
		end

		slot0.lockRewardIcon:setMOValue(slot0.rewardType, slot0.rewardId, slot0.rewardQuantity)
		slot0.lockRewardIcon:setScale(0.6, 0.6, 0.6)

		slot0.unlockCallback = slot1

		slot0:_playUnlockAnimation()
	end
end

function slot0._playUnlockAnimation(slot0)
	if slot0.status == VersionActivity1_5DungeonEnum.SubHeroTaskStatus.Lock then
		return
	end

	if VersionActivity1_5RevivalTaskModel.instance:checkIsPlayedUnlockAnimation(slot0.config.id) then
		return
	end

	if not slot0.openViewFinish then
		return
	end

	if VersionActivity1_5RevivalTaskModel.instance:getIsPlayingOpenAnim() then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_quest_unlock)
	slot0._lockAnimator:Play("unlock", slot0.unLockAnimationDone, slot0)
end

function slot0.unLockAnimationDone(slot0)
	VersionActivity1_5RevivalTaskModel.instance:playedUnlockAnimation(slot0.config.id)
	gohelper.setActive(slot0._golocked, false)

	if slot0.unlockCallback then
		slot0:unlockCallback()

		slot0.unlockCallback = nil
	end
end

function slot0.playNormalOpenAnim(slot0)
	gohelper.setActive(slot0._gonormal, true)
	slot0._normalAnimator:Play("open")
end

function slot0.playFinishOpenAnim(slot0)
	gohelper.setActive(slot0._gofinished, true)
	slot0._finishAnimator:Play("open")
end

function slot0.onOpenViewFinish(slot0, slot1)
	if slot1 == ViewName.VersionActivity1_5RevivalTaskView then
		slot0.openViewFinish = true

		slot0:_playUnlockAnimation()
	end
end

function slot0.openAnimPlayingStatusChange(slot0, slot1)
	if not slot1 then
		slot0:_playUnlockAnimation()
	end
end

function slot0.destroy(slot0)
	slot0.tipClick:RemoveClickListener()
	slot0._btngo:RemoveClickListener()
	slot0._gainRewardClick:RemoveClickListener()
	slot0:__onDispose()
end

return slot0
