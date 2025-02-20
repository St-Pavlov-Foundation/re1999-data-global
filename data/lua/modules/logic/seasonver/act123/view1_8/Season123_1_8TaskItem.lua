module("modules.logic.seasonver.act123.view1_8.Season123_1_8TaskItem", package.seeall)

slot0 = class("Season123_1_8TaskItem", ListScrollCell)
slot0.BlockKey = "Season123_1_8TaskItemAni"

function slot0.init(slot0, slot1)
	slot0._viewGO = slot1
	slot0._simageBg = gohelper.findChildSingleImage(slot1, "#simage_bg")
	slot0._goNormal = gohelper.findChild(slot1, "#goNormal")
	slot0._goTotal = gohelper.findChild(slot1, "#goTotal")
	slot0._animator = slot1:GetComponent(typeof(UnityEngine.Animator))

	slot0:initNormal()
	slot0:initTotal()

	slot0.firstEnter = true
end

function slot0.addEventListeners(slot0)
	slot0._btnGoto:AddClickListener(slot0.onClickGoto, slot0)
	slot0._btnReceive:AddClickListener(slot0.onClickReceive, slot0)
	slot0._btnGetTotal:AddClickListener(slot0.onClickGetTotal, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnGoto:RemoveClickListener()
	slot0._btnReceive:RemoveClickListener()
	slot0._btnGetTotal:RemoveClickListener()
end

function slot0.initNormal(slot0)
	slot0._txtCurCount = gohelper.findChildTextMesh(slot0._goNormal, "#txt_curcount")
	slot0._txtMaxCount = gohelper.findChildTextMesh(slot0._goNormal, "#txt_curcount/#txt_maxcount")
	slot0._txtDesc = gohelper.findChildTextMesh(slot0._goNormal, "#txt_desc")
	slot0._scrollreward = gohelper.findChild(slot0._goNormal, "#scroll_rewards"):GetComponent(typeof(ZProj.LimitedScrollRect))
	slot0._gocontent = gohelper.findChild(slot0._goNormal, "#scroll_rewards/Viewport/Content")
	slot0._goRewardTemplate = gohelper.findChild(slot0._gocontent, "#go_rewarditem")

	gohelper.setActive(slot0._goRewardTemplate, false)

	slot0._goMask = gohelper.findChild(slot0._goNormal, "#go_blackmask")
	slot0._goFinish = gohelper.findChild(slot0._goNormal, "#go_finish")
	slot0._goGoto = gohelper.findChild(slot0._goNormal, "#btn_goto")
	slot0._btnGoto = gohelper.findChildButtonWithAudio(slot0._goNormal, "#btn_goto")
	slot0._goReceive = gohelper.findChild(slot0._goNormal, "#btn_receive")
	slot0._btnReceive = gohelper.findChildButtonWithAudio(slot0._goNormal, "#btn_receive")
	slot0._goUnfinish = gohelper.findChild(slot0._goNormal, "#go_unfinish")
	slot0._goType1 = gohelper.findChild(slot0._goGoto, "#go_gotype1")
	slot0._goEffect1 = gohelper.findChild(slot0._goGoto, "#go_gotype1/#go_effect1")
	slot0._goType3 = gohelper.findChild(slot0._goGoto, "#go_gotype3")
	slot0._goEffect3 = gohelper.findChild(slot0._goGoto, "#go_gotype3/#go_effect3")
	slot0._goreward = gohelper.findChild(slot0._goNormal, "rewardstar/#go_reward")
	slot0._gorewardCanvasGroup = slot0._goreward:GetComponent(typeof(UnityEngine.CanvasGroup))
	slot0._gorewardredicon = gohelper.findChild(slot0._goNormal, "rewardstar/#go_reward/red")
	slot0._gorewardlighticon = gohelper.findChild(slot0._goNormal, "rewardstar/#go_reward/light")
	slot0._gorewarddardicon = gohelper.findChild(slot0._goNormal, "rewardstar/#go_reward/dark")
end

function slot0.initTotal(slot0)
	slot0._btnGetTotal = gohelper.findChildButtonWithAudio(slot0._goTotal, "#btn_getall")
end

slot0.TaskMaskTime = 0.65
slot0.ColumnCount = 1
slot0.AnimRowCount = 7
slot0.OpenAnimTime = 0.06
slot0.OpenAnimStartTime = 0

function slot0.onUpdateMO(slot0, slot1)
	if slot1 == nil then
		return
	end

	slot0.mo = slot1
	slot0._scrollreward.parentGameObject = slot0._view._csListScroll.gameObject

	if slot0.mo.canGetAll then
		gohelper.setActive(slot0._goNormal, false)
		gohelper.setActive(slot0._goTotal, true)
		slot0._simageBg:LoadImage(ResUrl.getSeasonIcon("tap2.png"))
	else
		gohelper.setActive(slot0._goNormal, true)
		gohelper.setActive(slot0._goTotal, false)
		slot0:refreshNormal()
	end

	slot0:checkPlayAnim()
end

function slot0.endPlayOpenAnim(slot0)
	gohelper.setActive(slot0._goEffect1, false)
	gohelper.setActive(slot0._goEffect3, false)

	slot0._ani.enabled = true
	slot0.firstEnter = false
end

function slot0.checkPlayAnim(slot0)
	TaskDispatcher.cancelTask(slot0.onDelayPlayOpen, slot0)

	if Season123TaskModel.instance:getDelayPlayTime(slot0.mo) == -1 then
		slot0._animator:Play("idle", 0, 0)

		slot0._animator.speed = 1

		gohelper.setActive(slot0._goEffect1, false)
		gohelper.setActive(slot0._goEffect3, false)
	else
		slot0._animator:Play("open", 0, 0)

		slot0._animator.speed = 0

		gohelper.setActive(slot0._goEffect1, true)
		gohelper.setActive(slot0._goEffect3, true)
		TaskDispatcher.runDelay(slot0.onDelayPlayOpen, slot0, slot1)
	end
end

function slot0.onDelayPlayOpen(slot0)
	TaskDispatcher.cancelTask(slot0.onDelayPlayOpen, slot0)
	slot0._animator:Play("open", 0, 0)

	slot0._animator.speed = 1
end

function slot0.refreshNormal(slot0)
	slot0.taskId = slot0.mo.id
	slot0.jumpId = slot0.mo.config.jumpId

	slot0:refreshReward()
	slot0:refreshDesc()
	slot0:refreshProgress()
	slot0:refreshState()
end

function slot0.refreshReward(slot0)
	for slot7, slot8 in ipairs(string.split(slot0.mo.config.bonus, "|")) do
		if not string.nilorempty(slot8) then
			slot9 = string.splitToNumber(slot8, "#")

			table.insert({}, {
				isIcon = true,
				materilType = slot9[1],
				materilId = slot9[2],
				quantity = slot9[3]
			})
		end
	end

	if slot1.equipBonus > 0 then
		table.insert(slot3, {
			equipId = slot1.equipBonus
		})
	end

	if not slot0._rewardItems then
		slot0._rewardItems = {}
	end

	slot7 = #slot0._rewardItems

	for slot7 = 1, math.max(slot7, #slot3) do
		slot0:refreshRewardItem(slot0._rewardItems[slot7] or slot0:createRewardItem(slot7), slot3[slot7])
	end
end

function slot0.createRewardItem(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot3 = gohelper.clone(slot0._goRewardTemplate, slot0._gocontent, "reward_" .. tostring(slot1))
	slot2.go = slot3
	slot2.itemParent = gohelper.findChild(slot3, "go_prop")
	slot2.cardParent = gohelper.findChild(slot3, "go_card")
	slot0._rewardItems[slot1] = slot2

	return slot2
end

function slot0.refreshRewardItem(slot0, slot1, slot2)
	if not slot2 then
		gohelper.setActive(slot1.go, false)

		return
	end

	gohelper.setActive(slot1.go, true)

	if slot2.equipId then
		gohelper.setActive(slot1.cardParent, true)
		gohelper.setActive(slot1.itemParent, false)

		if not slot1.equipIcon then
			slot1.equipIcon = Season123_1_8CelebrityCardItem.New()

			slot1.equipIcon:init(slot1.cardParent, slot2.equipId)
		end

		slot1.equipIcon:reset(slot2.equipId)

		return
	end

	gohelper.setActive(slot1.cardParent, false)
	gohelper.setActive(slot1.itemParent, true)

	if not slot1.itemIcon then
		slot1.itemIcon = IconMgr.instance:getCommonPropItemIcon(slot1.itemParent)
	end

	slot1.itemIcon:onUpdateMO(slot2)
	slot1.itemIcon:isShowCount(true)
	slot1.itemIcon:setCountFontSize(40)
	slot1.itemIcon:showStackableNum2()
	slot1.itemIcon:setHideLvAndBreakFlag(true)
	slot1.itemIcon:hideEquipLvAndBreak(true)
end

function slot0.getAnimator(slot0)
	return slot0._ani
end

function slot0.destroyRewardItem(slot0, slot1)
	if slot1.itemIcon then
		slot1.itemIcon:onDestroy()

		slot1.itemIcon = nil
	end

	if slot1.equipIcon then
		slot1.equipIcon:destroy()

		slot1.equipIcon = nil
	end
end

function slot0.refreshDesc(slot0)
	slot0._simageBg:LoadImage(ResUrl.getSeasonIcon(string.format("tap%s.png", slot0.mo.config.bgType == 1 and 3 or 4)))

	slot0._txtDesc.text = slot1.desc
end

function slot0.refreshProgress(slot0)
	slot0._txtCurCount.text = slot0.mo.progress
	slot0._txtMaxCount.text = slot0.mo.config.maxProgress

	gohelper.setActive(slot0._goreward, Season123TaskModel.instance.curTaskType == Activity123Enum.TaskRewardViewType)
	gohelper.setActive(slot0._txtCurCount.gameObject, slot3 == Activity123Enum.TaskNormalType)
end

function slot0.refreshState(slot0)
	if slot0.mo.config.maxFinishCount <= slot0.mo.finishCount then
		gohelper.setActive(slot0._goMask, true)
		gohelper.setActive(slot0._goFinish, true)
		gohelper.setActive(slot0._goGoto, false)
		gohelper.setActive(slot0._goReceive, false)
		gohelper.setActive(slot0._goUnfinish, false)
		gohelper.setActive(slot0._gorewardredicon, slot0.mo.config.bgType == Activity123Enum.TaskHardType.Hard)
		gohelper.setActive(slot0._gorewardlighticon, slot0.mo.config.bgType == Activity123Enum.TaskHardType.Normal)
		gohelper.setActive(slot0._gorewarddardicon, false)

		slot0._gorewardCanvasGroup.alpha = 0.3
	elseif slot0.mo.hasFinished then
		gohelper.setActive(slot0._goMask, false)
		gohelper.setActive(slot0._goFinish, false)
		gohelper.setActive(slot0._goGoto, false)
		gohelper.setActive(slot0._goReceive, true)
		gohelper.setActive(slot0._goUnfinish, false)
		gohelper.setActive(slot0._gorewardredicon, slot0.mo.config.bgType == Activity123Enum.TaskHardType.Hard)
		gohelper.setActive(slot0._gorewardlighticon, slot0.mo.config.bgType == Activity123Enum.TaskHardType.Normal)
		gohelper.setActive(slot0._gorewarddardicon, false)

		slot0._gorewardCanvasGroup.alpha = 1
	else
		gohelper.setActive(slot0._goMask, false)
		gohelper.setActive(slot0._goFinish, false)
		gohelper.setActive(slot0._goReceive, false)

		if slot0.jumpId and slot0.jumpId > 0 then
			gohelper.setActive(slot0._goGoto, true)
			gohelper.setActive(slot0._goUnfinish, false)
			gohelper.setActive(slot0._goType1, slot0.mo.config.bgType ~= 1)
			gohelper.setActive(slot0._goType3, slot0.mo.config.bgType == 1)
		else
			gohelper.setActive(slot0._goGoto, false)
			gohelper.setActive(slot0._goUnfinish, true)
		end

		gohelper.setActive(slot0._gorewardredicon, false)
		gohelper.setActive(slot0._gorewardlighticon, false)
		gohelper.setActive(slot0._gorewarddardicon, true)

		slot0._gorewardCanvasGroup.alpha = 1
	end
end

function slot0.onClickGoto(slot0)
	if not slot0.jumpId then
		return
	end

	GameFacade.jump(slot0.jumpId)
end

function slot0.onClickReceive(slot0)
	if not slot0.taskId and not slot0.mo.canGetAll then
		return
	end

	gohelper.setActive(slot0._goMask, true)
	slot0._animator:Play(UIAnimationName.Finish)
	UIBlockMgr.instance:startBlock(uv0.BlockKey)
	Season123Controller.instance:dispatchEvent(Season123Event.OnTaskRewardGetFinish, slot0._index)
	TaskDispatcher.runDelay(slot0._onPlayActAniFinished, slot0, uv0.TaskMaskTime)
end

function slot0._onPlayActAniFinished(slot0)
	TaskDispatcher.cancelTask(slot0._onPlayActAniFinished, slot0)

	if slot0.mo.canGetAll then
		TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Season123, 0, Season123TaskModel.instance:getAllCanGetList(), nil, , 0)
	else
		TaskRpc.instance:sendFinishTaskRequest(slot0.taskId)
	end

	UIBlockMgr.instance:endBlock(uv0.BlockKey)
end

function slot0.onClickGetTotal(slot0)
	slot0:onClickReceive()
end

function slot0.onDestroy(slot0)
	TaskDispatcher.cancelTask(slot0._onPlayActAniFinished, slot0)
	TaskDispatcher.cancelTask(slot0.onDelayPlayOpen, slot0)

	if slot0._rewardItems then
		for slot4, slot5 in pairs(slot0._rewardItems) do
			slot0:destroyRewardItem(slot5)
		end

		slot0._rewardItems = nil
	end

	TaskDispatcher.cancelTask(slot0._onPlayActAniFinished, slot0)
end

return slot0
