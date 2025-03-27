module("modules.logic.versionactivity2_4.warmup.view.V2a4_WarmUp_TaskItem", package.seeall)

slot0 = class("V2a4_WarmUp_TaskItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._gonormal = gohelper.findChild(slot0.viewGO, "#go_normal")
	slot0._simagenormalbg = gohelper.findChildSingleImage(slot0.viewGO, "#go_normal/#simage_normalbg")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "#go_normal/progress/#txt_num")
	slot0._txttotal = gohelper.findChildText(slot0.viewGO, "#go_normal/progress/#txt_num/#txt_total")
	slot0._txttaskdes = gohelper.findChildText(slot0.viewGO, "#go_normal/#txt_taskdes")
	slot0._scrollrewards = gohelper.findChildScrollRect(slot0.viewGO, "#go_normal/#scroll_rewards")
	slot0._gorewards = gohelper.findChild(slot0.viewGO, "#go_normal/#scroll_rewards/Viewport/#go_rewards")
	slot0._btnnotfinishbg = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_normal/#btn_notfinishbg")
	slot0._btnfinishbg = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_normal/#btn_finishbg")
	slot0._goallfinish = gohelper.findChild(slot0.viewGO, "#go_normal/#go_allfinish")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnnotfinishbg:AddClickListener(slot0._btnnotfinishbgOnClick, slot0)
	slot0._btnfinishbg:AddClickListener(slot0._btnfinishbgOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnnotfinishbg:RemoveClickListener()
	slot0._btnfinishbg:RemoveClickListener()
end

slot1 = "V2a4_WarmUp_TaskItem:_btnfinishbgOnClick()"

function slot0._btnnotfinishbgOnClick(slot0)
	if slot0._mo.config.jumpId ~= 0 then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_resources_open)

		if GameFacade.jump(slot0.co.jumpId) then
			ViewMgr.instance:closeView(ViewName.V2a4_WarmUp_TaskView)
		end
	end
end

function slot0._btnfinishbgOnClick(slot0)
	UIBlockMgr.instance:startBlock(uv0)

	slot0.animator.speed = 1

	slot0.animatorPlayer:Play(UIAnimationName.Finish, slot0._firstAnimationDone, slot0)
end

function slot0._editableInitView(slot0)
	slot0._rewardItemList = {}
	slot0._btnnotfinishbgGo = slot0._btnnotfinishbg.gameObject
	slot0._btnfinishbgGo = slot0._btnfinishbg.gameObject
	slot0._goallfinishGo = slot0._goallfinish.gameObject
	slot0._scrollrewardsGo = slot0._scrollrewards.gameObject
	slot0._gorewardsContentFilter = gohelper.onceAddComponent(slot0._gorewards, gohelper.Type_ContentSizeFitter)
	slot0.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(slot0.viewGO)
	slot0.animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function slot0.onDestroyView(slot0)
	slot0._simagenormalbg:UnLoadImage()
end

function slot0.initInternal(slot0, ...)
	uv0.super.initInternal(slot0, ...)

	slot0.scrollReward = slot0._scrollrewardsGo:GetComponent(typeof(ZProj.LimitedScrollRect))
	slot0.scrollReward.parentGameObject = slot0._view._csListScroll.gameObject
end

function slot0._viewContainer(slot0)
	return slot0._view.viewContainer
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	if slot1.getAll then
		slot0:_refreshGetAllUI()
	else
		slot0:_refreshNormalUI()
	end
end

function slot0._refreshGetAllUI(slot0)
end

function slot0._isReadTask(slot0)
	return slot0._mo.config.listenerType == "ReadTask"
end

function slot0._getProgressReadTask(slot0)
	slot3 = slot0._mo.config

	if Activity125Config.instance:getTaskCO_ReadTask_Tag(slot3.activityId, ActivityWarmUpEnum.Activity125TaskTag.sum_help_npc)[slot3.id] then
		return slot0:_progress_sum_help_npc()
	end

	if Activity125Config.instance:getTaskCO_ReadTask_Tag(slot5, slot1.help_npc)[slot4] then
		return slot2.progress
	end

	if Activity125Config.instance:getTaskCO_ReadTask_Tag(slot5, slot1.perfect_win)[slot4] then
		return slot2.progress
	end
end

function slot0._getMaxProgressReadTask(slot0)
	slot2 = slot0._mo.config

	if Activity125Config.instance:getTaskCO_ReadTask_Tag(slot2.activityId, ActivityWarmUpEnum.Activity125TaskTag.sum_help_npc)[slot2.id] then
		return tonumber(slot2.clientlistenerParam) or 0
	else
		return 1
	end
end

function slot0._progress_sum_help_npc(slot0)
	return Activity125Controller.instance:get_V2a4_WarmUp_sum_help_npc(0)
end

function slot0._refreshNormalUI(slot0)
	slot1 = slot0._mo
	slot3 = slot1.progress
	slot4 = slot1.config.maxProgress

	if slot0:_isReadTask() then
		slot3 = slot0:_getProgressReadTask()
		slot4 = slot0:_getMaxProgressReadTask()
	end

	slot0._txtnum.text = math.min(slot3, slot4)
	slot0._txttaskdes.text = slot2.desc
	slot0._txttotal.text = slot4

	gohelper.setActive(slot0._btnnotfinishbgGo, slot1:isUnfinished())
	gohelper.setActive(slot0._goallfinishGo, slot1:isClaimed())
	gohelper.setActive(slot0._btnfinishbgGo, slot1:isClaimable())
	slot0:_refreshRewardItems()
end

function slot0._refreshRewardItems(slot0)
	if string.nilorempty(slot0._mo.config.bonus) then
		gohelper.setActive(slot0.scrollReward.gameObject, false)

		return
	end

	gohelper.setActive(slot0.scrollReward.gameObject, true)

	slot0._gorewardsContentFilter.enabled = #GameUtil.splitString2(slot3, true, "|", "#") > 2

	for slot8, slot9 in ipairs(slot4) do
		if not slot0._rewardItemList[slot8] then
			slot13 = IconMgr.instance:getCommonPropItemIcon(slot0._gorewards)

			slot13:setMOValue(slot9[1], slot9[2], slot9[3], nil, true)
			slot13:setCountFontSize(26)
			slot13:showStackableNum2()
			slot13:isShowEffect(true)
			table.insert(slot0._rewardItemList, slot13)

			if slot13:getItemIcon().getCountBg then
				transformhelper.setLocalScale(slot14:getCountBg().transform, 1, 1.5, 1)
			end

			if slot14.getCount then
				transformhelper.setLocalScale(slot14:getCount().transform, 1.5, 1.5, 1)
			end
		else
			slot13:setMOValue(slot10, slot11, slot12, nil, true)
		end

		gohelper.setActive(slot13.go, true)
	end

	for slot8 = #slot4 + 1, #slot0._rewardItemList do
		gohelper.setActive(slot0._rewardItemList[slot8].go, false)
	end

	slot0.scrollReward.horizontalNormalizedPosition = 0
end

function slot0._firstAnimationDone(slot0)
	slot0:_viewContainer():removeByIndex(slot0._index, slot0._secondAnimationDone, slot0)
end

function slot0._secondAnimationDone(slot0)
	slot2 = slot0._mo
	slot4 = slot2.config.id

	UIBlockMgr.instance:endBlock(uv0)
	slot0.animatorPlayer:Play(UIAnimationName.Idle)

	if slot2.getAll then
		slot0:_viewContainer():sendFinishAllTaskRequest()
	else
		slot1:sendFinishTaskRequest(slot4)
	end
end

function slot0.getAnimator(slot0)
	return slot0.animator
end

return slot0
