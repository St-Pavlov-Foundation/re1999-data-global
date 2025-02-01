module("modules.logic.versionactivity2_1.dungeon.view.task.VersionActivity2_1TaskItem", package.seeall)

slot0 = class("VersionActivity2_1TaskItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(slot0.viewGO)
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._gonormal = gohelper.findChild(slot0.viewGO, "#go_normal")
	slot0._gogetall = gohelper.findChild(slot0.viewGO, "#go_getall")
	slot0._simagenormalbg = gohelper.findChildSingleImage(slot0.viewGO, "#go_normal/#simage_normalbg")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "#go_normal/progress/#txt_num")
	slot0._txttotal = gohelper.findChildText(slot0.viewGO, "#go_normal/progress/#txt_num/#txt_total")
	slot0._txttaskdes = gohelper.findChildText(slot0.viewGO, "#go_normal/#txt_taskdes")
	slot0.scrollReward = gohelper.findChild(slot0.viewGO, "#go_normal/#scroll_rewards"):GetComponent(typeof(ZProj.LimitedScrollRect))
	slot0.goRewardContent = gohelper.findChild(slot0.viewGO, "#go_normal/#scroll_rewards/Viewport/#go_rewards")
	slot0.sizeFitterRewardContent = slot0.goRewardContent:GetComponent(typeof(UnityEngine.UI.ContentSizeFitter))
	slot0.goFinished = gohelper.findChild(slot0.viewGO, "#go_normal/#go_allfinish")
	slot0.btnNotFinish = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_normal/#btn_notfinishbg")
	slot0.btnFinish = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_normal/#btn_finishbg", AudioEnum.UI.play_ui_task_slide)
	slot0.btnFinishAll = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_getall/#btn_getall/#btn_getall", AudioEnum.UI.play_ui_task_slide)
	slot0._simagegetallbg = gohelper.findChildSingleImage(slot0.viewGO, "#go_getall/#simage_getallbg")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0.btnNotFinish:AddClickListener(slot0._btnNotFinishOnClick, slot0)
	slot0.btnFinish:AddClickListener(slot0._btnFinishOnClick, slot0)
	slot0.btnFinishAll:AddClickListener(slot0._btnAllFinishOnClick, slot0)
	slot0:addEventCb(VersionActivity2_1DungeonController.instance, VersionActivity2_1DungeonEvent.OnClickAllTaskFinish, slot0._OnClickAllTaskFinish, slot0)
end

function slot0.removeEvents(slot0)
	slot0.btnNotFinish:RemoveClickListener()
	slot0.btnFinish:RemoveClickListener()
	slot0.btnFinishAll:RemoveClickListener()
	slot0:removeEventCb(VersionActivity2_1DungeonController.instance, VersionActivity2_1DungeonEvent.OnClickAllTaskFinish, slot0._OnClickAllTaskFinish, slot0)
end

function slot0._btnNotFinishOnClick(slot0)
	if slot0.co.jumpId ~= 0 then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_resources_open)

		if GameFacade.jump(slot0.co.jumpId) then
			ViewMgr.instance:closeView(ViewName.VersionActivity2_1TaskView)
		end
	end
end

function slot0._btnFinishOnClick(slot0)
	UIBlockMgr.instance:startBlock(VersionActivity2_1DungeonEnum.BlockKey.TaskGetReward)

	slot0._animator.speed = 1

	slot0._animatorPlayer:Play(UIAnimationName.Finish, slot0.firstAnimationDone, slot0)
end

function slot0._btnAllFinishOnClick(slot0)
	VersionActivity2_1DungeonController.instance:dispatchEvent(VersionActivity2_1DungeonEvent.OnClickAllTaskFinish)
end

function slot0._OnClickAllTaskFinish(slot0)
	if slot0.taskMo then
		if slot0.taskMo.getAll then
			slot0:_btnFinishOnClick()
		elseif slot0.taskMo.finishCount < slot0.co.maxFinishCount and slot0.taskMo.hasFinished then
			slot0:getAnimator():Play(BossRushEnum.V1a6_BonusViewAnimName.Finish, 0, 0)
		end
	end
end

function slot0.firstAnimationDone(slot0)
	slot0._view.viewContainer.taskAnimRemoveItem:removeByIndex(slot0._index, slot0.secondAnimationDone, slot0)
end

function slot0.secondAnimationDone(slot0)
	UIBlockMgr.instance:endBlock(VersionActivity2_1DungeonEnum.BlockKey.TaskGetReward)

	if slot0.taskMo.getAll then
		TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.ActivityDungeon, nil, , , , VersionActivity2_1Enum.ActivityId.Dungeon)
	else
		TaskRpc.instance:sendFinishTaskRequest(slot0.co.id)
	end
end

function slot0._editableInitView(slot0)
	slot0.rewardItemList = {}
end

function slot0.onUpdateMO(slot0, slot1)
	slot0.taskMo = slot1
	slot0.scrollReward.parentGameObject = slot0._view._csListScroll.gameObject

	gohelper.setActive(slot0._gonormal, not slot0.taskMo.getAll)
	gohelper.setActive(slot0._gogetall, slot0.taskMo.getAll)

	if slot0.taskMo.getAll then
		slot0:refreshGetAllUI()
	else
		slot0:refreshNormalUI()
	end
end

function slot0.refreshGetAllUI(slot0)
end

function slot0.refreshNormalUI(slot0)
	slot0.co = slot0.taskMo.config
	slot0._txttaskdes.text = slot0.co.desc
	slot0._txtnum.text = slot0.taskMo.progress
	slot0._txttotal.text = slot0.co.maxProgress

	if slot0.co.maxFinishCount <= slot0.taskMo.finishCount then
		gohelper.setActive(slot0.btnFinish.gameObject, false)
		gohelper.setActive(slot0.btnNotFinish.gameObject, false)
		gohelper.setActive(slot0.goFinished, true)
	elseif slot0.taskMo.hasFinished then
		gohelper.setActive(slot0.btnFinish.gameObject, true)
		gohelper.setActive(slot0.btnNotFinish.gameObject, false)
		gohelper.setActive(slot0.goFinished, false)
	else
		gohelper.setActive(slot0.btnFinish.gameObject, false)
		gohelper.setActive(slot0.btnNotFinish.gameObject, true)
		gohelper.setActive(slot0.goFinished, false)
	end

	slot0:refreshRewardItems()
end

slot1 = 26

function slot0.refreshRewardItems(slot0)
	if string.nilorempty(slot0.co.bonus) then
		gohelper.setActive(slot0.scrollReward.gameObject, false)

		return
	end

	gohelper.setActive(slot0.scrollReward.gameObject, true)

	slot0.sizeFitterRewardContent.enabled = #GameUtil.splitString2(slot1, true, "|", "#") > 2

	for slot6, slot7 in ipairs(slot2) do
		if not slot0.rewardItemList[slot6] then
			slot11 = IconMgr.instance:getCommonPropItemIcon(slot0.goRewardContent)

			slot11:setMOValue(slot7[1], slot7[2], slot7[3], nil, true)
			slot11:setCountFontSize(uv0)
			slot11:showStackableNum2()
			slot11:isShowEffect(true)
			transformhelper.setLocalScale(slot11:getItemIcon():getCountBg().transform, 1, 1.5, 1)
			transformhelper.setLocalScale(slot11:getItemIcon():getCount().transform, 1.5, 1.5, 1)
			table.insert(slot0.rewardItemList, slot11)
		else
			slot11:setMOValue(slot8, slot9, slot10, nil, true)
		end

		gohelper.setActive(slot11.go, true)
	end

	for slot6 = #slot2 + 1, #slot0.rewardItemList do
		gohelper.setActive(slot0.rewardItemList[slot6].go, false)
	end

	slot0.scrollReward.horizontalNormalizedPosition = 0
end

function slot0.getAnimator(slot0)
	return slot0._animator
end

function slot0.onDestroyView(slot0)
	slot0._simagenormalbg:UnLoadImage()
	slot0._simagegetallbg:UnLoadImage()

	slot0.rewardItemList = {}

	UIBlockMgr.instance:endBlock(VersionActivity2_1DungeonEnum.BlockKey.TaskGetReward)
end

return slot0
