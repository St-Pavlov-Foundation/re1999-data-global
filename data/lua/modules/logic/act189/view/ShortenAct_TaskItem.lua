module("modules.logic.act189.view.ShortenAct_TaskItem", package.seeall)

slot0 = class("ShortenAct_TaskItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._gonormal = gohelper.findChild(slot0.viewGO, "#go_normal")
	slot0._simagenormalbg = gohelper.findChildSingleImage(slot0.viewGO, "#go_normal/#simage_normalbg")
	slot0._txttaskdes = gohelper.findChildText(slot0.viewGO, "#go_normal/#txt_taskdes")
	slot0._golimit = gohelper.findChild(slot0.viewGO, "#go_normal/#go_limit")
	slot0._txtlimittext = gohelper.findChildText(slot0.viewGO, "#go_normal/#go_limit/limitinfobg/#txt_limittext")
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

slot1 = string.format

function slot0.initInternal(slot0, ...)
	uv0.super.initInternal(slot0, ...)

	slot0.scrollReward = slot0._scrollrewardsGo:GetComponent(typeof(ZProj.LimitedScrollRect))
	slot0.scrollReward.parentGameObject = slot0._view._csListScroll.gameObject
end

function slot0._btnnotfinishbgOnClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_resources_open)

	slot2 = slot0._mo.config
	slot4 = slot2.id

	if slot2.jumpId == 0 then
		return
	end

	if slot0._isLimit then
		slot0:_showToast()

		return
	end

	if GameFacade.jump(slot3) then
		if ViewMgr.instance:isOpen(ViewName.ShortenAct_PanelView) then
			ViewMgr.instance:closeView(ViewName.ShortenAct_PanelView)
		end

		Activity189Controller.instance:trySendFinishReadTaskRequest_jump(slot4)
	end
end

slot2 = "ShortenAct_TaskItem:_btnfinishbgOnClick()"

function slot0._btnfinishbgOnClick(slot0)
	slot0:_startBlock()

	slot0.animator.speed = 1

	slot0.animatorPlayer:Play(UIAnimationName.Finish, slot0._firstAnimationDone, slot0)
end

function slot0._editableInitView(slot0)
	slot0._rewardItemList = {}
	slot0._btnnotfinishbgGo = slot0._btnnotfinishbg.gameObject
	slot0._btnfinishbgGo = slot0._btnfinishbg.gameObject
	slot0._goallfinishGo = slot0._goallfinish.gameObject
	slot0._scrollrewardsGo = slot0._scrollrewards.gameObject
	slot0._gorewardsContentFilter = gohelper.onceAddComponent(slot0._gorewards, typeof(UnityEngine.UI.ContentSizeFitter))
	slot0.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(slot0.viewGO)
	slot0.animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function slot0.onDestroyView(slot0)
	slot0._simagenormalbg:UnLoadImage()
end

function slot0._viewContainer(slot0)
	return slot0._view.viewContainer
end

function slot0.getAnimator(slot0)
	return slot0.animator
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
	slot1 = Activity189Enum.TaskTag
	slot3 = slot0._mo.config
	slot4 = slot3.id
	slot5 = slot3.activityId

	return 0
end

function slot0._getMaxProgressReadTask(slot0)
	return 1
end

function slot0._refreshNormalUI(slot0)
	slot1 = slot0._mo
	slot2 = slot1.config
	slot3 = slot1.progress
	slot4 = slot2.maxProgress
	slot5 = slot2.openLimitActId
	slot7 = JumpConfig.instance:getJumpConfig(slot2.jumpId)

	if slot0:_isReadTask() then
		slot3 = slot0:_getProgressReadTask()
		slot4 = slot0:_getMaxProgressReadTask()
	end

	slot0._txttaskdes.text = slot2.desc

	gohelper.setActive(slot0._btnnotfinishbgGo, slot1:isUnfinished())
	gohelper.setActive(slot0._goallfinishGo, slot1:isClaimed())
	gohelper.setActive(slot0._btnfinishbgGo, slot1:isClaimable())
	slot0:_setActive_limite(false)

	slot9 = false

	if slot5 > 0 then
		slot10, slot11, slot12 = ActivityHelper.getActivityStatusAndToast(slot5, true)

		slot0:_setActive_limite(slot10 ~= ActivityEnum.ActivityStatus.Normal)

		if slot10 == ActivityEnum.ActivityStatus.NotOpen then
			slot0._txtlimittext.text = uv0(luaLang("ShortenAct_TaskItem_remain_open"), TimeUtil.getFormatTime(Activity189Model.instance:getActMO(slot5):getRealStartTimeStamp() - ServerTime.now()))
			slot0._limitDesc = slot0:_getStrByToast(ToastEnum.ActivityNotOpen)
		elseif slot10 == ActivityEnum.ActivityStatus.Expired or slot10 == ActivityEnum.ActivityStatus.NotOnLine or slot10 == ActivityEnum.ActivityStatus.None then
			slot0:_setLimitDesc(luaLang("turnback_end"))
		elseif slot10 == ActivityEnum.ActivityStatus.NotUnlock then
			slot0:_setLimitTextByToast(slot11, slot12)
		end
	end

	if slot7 and not slot9 then
		slot10, slot11, slot12 = JumpController.instance:canJumpNew(slot7.param)

		slot0:_setActive_limite(not slot10)
		slot0:_setLimitTextByToast(slot11, slot12)
	end

	GameUtil.loadSImage(slot0._simagenormalbg, ResUrl.getShortenActSingleBg(slot8 and "shortenact_taskitembg2" or "shortenact_taskitembg1"))
	slot0:_refreshRewardItems()
end

function slot0._showToast(slot0)
	ToastController.instance:showToastWithString(slot0._limitDesc)
end

function slot0._setLimitDesc(slot0, slot1)
	slot1 = slot1 or ""
	slot0._txtlimittext.text = slot1
	slot0._limitDesc = slot1
end

function slot0._getStrByToast(slot0, slot1, slot2)
	return ToastController.instance:getToastMsgWithTableParam(slot1, slot2)
end

function slot0._setLimitTextByToast(slot0, slot1, slot2)
	slot0:_setLimitDesc(slot0:_getStrByToast(slot1, slot2))
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

	slot0.animatorPlayer:Play(UIAnimationName.Idle)
	slot0:_endBlock()

	if slot2.getAll then
		slot0:_viewContainer():sendFinishAllTaskRequest()
	else
		slot1:sendFinishTaskRequest(slot4)
	end
end

function slot0._setActive_limite(slot0, slot1)
	slot0._isLimit = slot1

	gohelper.setActive(slot0._golimit, slot1)
end

function slot0._startBlock(slot0)
	UIBlockMgr.instance:startBlock(uv0)
	UIBlockMgrExtend.setNeedCircleMv(false)
end

function slot0._endBlock(slot0)
	UIBlockMgr.instance:endBlock(uv0)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

return slot0
