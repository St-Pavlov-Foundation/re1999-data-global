module("modules.logic.bossrush.view.v1a6.taskachievement.V1a6_BossRush_ScheduleItem", package.seeall)

slot0 = class("V1a6_BossRush_ScheduleItem", ListScrollCellExtend)

function slot0._initScollParentGameObject(slot0)
	if not slot0._isSetParent then
		slot0._scrollrewardLimitScollRect.parentGameObject = slot0._view:getCsListScroll().gameObject
		slot0._isSetParent = true
	end
end

function slot0.onInitView(slot0)
	slot0._goNormal = gohelper.findChild(slot0.viewGO, "#go_Normal")
	slot0._txtDescr = gohelper.findChildText(slot0.viewGO, "#go_Normal/#txt_Descr")
	slot0._imgIcon = gohelper.findChildImage(slot0.viewGO, "#go_Normal/image_Icon")
	slot0._scrollRewards = gohelper.findChildScrollRect(slot0.viewGO, "#go_Normal/#scroll_Rewards")
	slot0._gorewards = gohelper.findChild(slot0.viewGO, "#go_Normal/#scroll_Rewards/Viewport/#go_rewards")
	slot0._btnNotFinish = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_Normal/#btn_NotFinish")
	slot0._btnFinished = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_Normal/#btn_Finished")
	slot0._goAllFinished = gohelper.findChild(slot0.viewGO, "#go_Normal/#go_AllFinished")
	slot0._goGetAll = gohelper.findChild(slot0.viewGO, "#go_GetAll")
	slot0._btngetall = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_GetAll/#btn_getall/click")
	slot0.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(slot0._goNormal)
	slot0.animator = slot0._goNormal:GetComponent(typeof(UnityEngine.Animator))
	slot0.animatorGetAll = slot0._goGetAll:GetComponent(typeof(UnityEngine.Animator))
	slot0.animatorPlayerGetAll = ZProj.ProjAnimatorPlayer.Get(slot0._goGetAll)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnNotFinish:AddClickListener(slot0._btnNotFinishOnClick, slot0)
	slot0._btnFinished:AddClickListener(slot0._btnFinishedOnClick, slot0)
	slot0._btngetall:AddClickListener(slot0._btngetallOnClick, slot0)
	slot0:addEventCb(BossRushController.instance, BossRushEvent.OnClickGetAllScheduleBouns, slot0._OnClickGetAllScheduleBouns, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnNotFinish:RemoveClickListener()
	slot0._btnFinished:RemoveClickListener()
	slot0._btngetall:RemoveClickListener()
	slot0:removeEventCb(BossRushController.instance, BossRushEvent.OnClickGetAllScheduleBouns, slot0._OnClickGetAllScheduleBouns, slot0)
end

slot0.UI_CLICK_BLOCK_KEY = "V1a6_BossRush_ScheduleItemClick"

function slot0._btngetallOnClick(slot0)
	slot0:_btnFinishedOnClick()
	BossRushController.instance:dispatchEvent(BossRushEvent.OnClickGetAllScheduleBouns)
end

function slot0._btnNotFinishOnClick(slot0)
end

function slot0._btnFinishedOnClick(slot0)
	UIBlockMgr.instance:startBlock(uv0.UI_CLICK_BLOCK_KEY)
	slot0:getAnimatorPlayer():Play(BossRushEnum.V1a6_BonusViewAnimName.Finish, slot0.firstAnimationDone, slot0)
end

function slot0._OnClickGetAllScheduleBouns(slot0)
	if slot0._mo and slot0._mo.isCanClaim then
		slot0:getAnimator():Play(BossRushEnum.V1a6_BonusViewAnimName.Finish, 0, 0)
	end
end

function slot0._editableInitView(slot0)
	slot0._scrollrewardLimitScollRect = slot0._scrollRewards:GetComponent(gohelper.Type_LimitedScrollRect)
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0:_initScollParentGameObject()

	slot0._mo = slot1

	if not slot1.getAll then
		slot0:refreshNormalUI(slot1)
	else
		slot0:refreshGetAllUI(slot1)
	end
end

function slot0.refreshNormalUI(slot0, slot1)
	slot2 = slot1.isGot
	slot3 = slot1.stageRewardCO
	slot6 = slot3.rewardPointNum <= BossRushModel.instance:getLastPointInfo(slot3.stage).cur
	slot0._imgIcon.color = slot6 and GameUtil.parseColor("#c48152") or GameUtil.parseColor("#919191")
	slot0._mo.isCanClaim = not slot2 and slot6

	gohelper.setActive(slot0._goAllFinished, slot2)
	gohelper.setActive(slot0._btnFinished.gameObject, slot0._mo.isCanClaim)
	gohelper.setActive(slot0._btnNotFinish.gameObject, not slot2 and not slot6)
	gohelper.setActive(slot0._goGetAll, false)
	gohelper.setActive(slot0._goNormal, true)
	IconMgr.instance:getCommonPropItemIconList(slot0, slot0._onRewardItemShow, ItemModel.instance:getItemDataListByConfigStr(slot3.reward), slot0._gorewards)

	slot0._txtDescr.text = string.format(luaLang("v1a6_bossrush_scheduleview_desc"), slot3.rewardPointNum)
end

function slot0.refreshGetAllUI(slot0, slot1)
	gohelper.setActive(slot0._goGetAll, true)
	gohelper.setActive(slot0._goNormal, false)
end

function slot0._onRewardItemShow(slot0, slot1, slot2, slot3)
	slot1:onUpdateMO(slot2)
	slot1:showStackableNum2()
	slot1:setCountFontSize(48)
end

function slot0.onSelect(slot0, slot1)
end

function slot0.onDestroyView(slot0)
end

function slot0.firstAnimationDone(slot0)
	if slot0._view.viewContainer:getScrollAnimRemoveItem(BossRushEnum.BonusViewTab.ScheduleTab) then
		slot1:removeByIndex(slot0._index, slot0.secondAnimationDone, slot0)
	else
		slot0:secondAnimationDone()
	end
end

function slot0.secondAnimationDone(slot0)
	if slot0._mo then
		if slot0._mo.getAll then
			BossRushRpc.instance:sendAct128GetTotalRewardsRequest(slot0._mo.stage)
		elseif slot0._mo.stageRewardCO then
			BossRushRpc.instance:sendAct128GetTotalSingleRewardRequest(slot0._mo.stage, slot0._mo.stageRewardCO.id)
		end

		UIBlockMgr.instance:endBlock(uv0.UI_CLICK_BLOCK_KEY)
	end
end

function slot0.getAnimator(slot0)
	return slot0._mo.getAll and slot0.animatorGetAll or slot0.animator
end

function slot0.getAnimatorPlayer(slot0)
	return slot0._mo.getAll and slot0.animatorPlayerGetAll or slot0.animatorPlayer
end

return slot0
