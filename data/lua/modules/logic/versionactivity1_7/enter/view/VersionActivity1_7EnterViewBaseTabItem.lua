module("modules.logic.versionactivity1_7.enter.view.VersionActivity1_7EnterViewBaseTabItem", package.seeall)

slot0 = class("VersionActivity1_7EnterViewBaseTabItem", UserDataDispose)

function slot0.init(slot0, slot1, slot2, slot3)
	slot0:__onInit()

	slot0.index = slot1
	slot0.actMo = slot2
	slot0.rootGo = slot3
	slot0.redDotUid = slot2.redDotUid or 0
	slot0.storeId = slot2.storeId

	slot0:updateActId()
	gohelper.setActive(slot0.rootGo, true)

	slot0.rectTr = slot0.rootGo:GetComponent(gohelper.Type_RectTransform)
	slot0.goSelected = gohelper.findChild(slot0.rootGo, "#go_select")
	slot0.goUnselected = gohelper.findChild(slot0.rootGo, "#go_unselect")
	slot0.imageUnSelectTabIcon = gohelper.findChildImage(slot0.rootGo, "#go_unselect/#image_tabicon")
	slot0.imageSelectTabIcon = gohelper.findChildImage(slot0.rootGo, "#go_select/#image_tabicon")
	slot0.goTag = gohelper.findChild(slot0.rootGo, "#go_tag")
	slot0.goTagNewAct = gohelper.findChild(slot0.rootGo, "#go_tag/#go_newact")
	slot0.goTagNewLevel = gohelper.findChild(slot0.rootGo, "#go_tag/#go_newlevel")
	slot0.goTagTime = gohelper.findChild(slot0.rootGo, "#go_tag/#go_time")
	slot0.goTagLock = gohelper.findChild(slot0.rootGo, "#go_tag/#go_lock")
	slot0.txtTime = gohelper.findChildText(slot0.goTagTime, "bg/#txt_time")
	slot0.txtLock = gohelper.findChildText(slot0.goTagLock, "bg/#txt_lock")
	slot0.goRedDot = gohelper.findChild(slot0.rootGo, "#go_reddot")
	slot0.click = gohelper.getClickWithDefaultAudio(slot0.rootGo)

	slot0.click:AddClickListener(slot0.onClickSelf, slot0)

	slot0.animator = slot0.rootGo:GetComponent(gohelper.Type_Animator)

	slot0:_editableInitView()
end

function slot0.updateActId(slot0)
	if VersionActivityEnterHelper.getActId(slot0.actMo) == slot0.actId then
		return false
	end

	slot0.actId = slot1
	slot0.activityCo = ActivityConfig.instance:getActivityCo(slot0.actId)

	return true
end

function slot0._editableInitView(slot0)
	slot1 = string.split(slot0.activityCo.tabBgPath, "#")

	UISpriteSetMgr.instance:setV1a7MainActivitySprite(slot0.imageSelectTabIcon, slot1[1])
	UISpriteSetMgr.instance:setV1a7MainActivitySprite(slot0.imageUnSelectTabIcon, slot1[2])

	slot0.redDotIcon = RedDotController.instance:addRedDot(slot0.goRedDot, slot0.activityCo.redDotId, slot0.redDotUid)

	slot0:addEventCb(RedDotController.instance, RedDotEvent.UpdateActTag, slot0.refreshTag, slot0)
	slot0:addEventCb(VersionActivityBaseController.instance, VersionActivityEnterViewEvent.SelectActId, slot0.refreshSelect, slot0)
	slot0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, slot0.onRefreshActivity, slot0)
	TaskDispatcher.runRepeat(slot0.refreshTag, slot0, TimeUtil.OneMinuteSecond)
end

function slot0.onClickSelf(slot0)
	if slot0.isSelect then
		return
	end

	if slot0.handleFunc then
		slot0.handleFunc(slot0.handleFuncObj, slot0)

		return
	end

	slot2, slot3, slot4 = ActivityHelper.getActivityStatusAndToast(slot0.storeId or slot0.actId)

	if slot2 == ActivityEnum.ActivityStatus.Normal or slot2 == ActivityEnum.ActivityStatus.NotUnlock then
		slot0.animator:Play("click", 0, 0)
		VersionActivityBaseController.instance:dispatchEvent(VersionActivityEnterViewEvent.SelectActId, slot0.actId, slot0)

		return
	end

	if slot3 then
		GameFacade.showToastWithTableParam(slot3, slot4)
	end

	AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_closehouse)
end

function slot0.overrideOnClickHandle(slot0, slot1, slot2)
	slot0.handleFunc = slot1
	slot0.handleFuncObj = slot2
end

function slot0.refreshSelect(slot0, slot1)
	slot0.isSelect = slot1 == slot0.actId

	gohelper.setActive(slot0.goSelected, slot0.isSelect)
	gohelper.setActive(slot0.goUnselected, not slot0.isSelect)
end

function slot0.refreshUI(slot0)
	gohelper.setActive(slot0.goRedDot, ActivityHelper.getActivityStatus(slot0.actId) == ActivityEnum.ActivityStatus.Normal)
	slot0:refreshTag()
end

function slot0.refreshTag(slot0)
	slot0:clearTag()

	if ActivityHelper.getActivityStatus(slot0.actId) == ActivityEnum.ActivityStatus.Normal then
		slot0:refreshNormalTag()
	elseif slot1 == ActivityEnum.ActivityStatus.NotUnlock then
		slot0:refreshNotUnlockTag()
	else
		slot0:refreshLockTag()
	end
end

function slot0.refreshLockTag(slot0)
	gohelper.setActive(slot0.goTagLock, true)

	if ActivityHelper.getActivityStatus(slot0.actId) == ActivityEnum.ActivityStatus.NotOpen then
		slot0.txtLock.text = ActivityModel.instance:getActivityInfo()[slot0.actId]:getRemainTimeStr2ByOpenTime()
	else
		gohelper.setActive(slot0.goTagLock, false)
	end
end

function slot0.refreshNormalTag(slot0)
	if not ActivityEnterMgr.instance:isEnteredActivity(slot0.actId) then
		gohelper.setActive(slot0.goTagNewAct, true)

		return
	end

	if ActivityModel.instance:getActivityInfo()[slot0.actId] and slot1:isNewStageOpen() then
		gohelper.setActive(slot0.goTagNewLevel, true)

		return
	end

	if VersionActivity1_7Enum.ActId2ShowRemainTimeDict[slot0.actId] and slot1 then
		if VersionActivity1_7Enum.MaxShowTimeOffset < slot1:getRealEndTimeStamp() - ServerTime.now() then
			return
		end

		gohelper.setActive(slot0.goTagTime, true)

		slot0.txtTime.text = slot1:getRemainTimeStr2ByEndTime()
	end
end

function slot0.refreshNotUnlockTag(slot0)
	gohelper.setActive(slot0.goTagLock, false)

	if not ActivityEnterMgr.instance:isEnteredActivity(slot0.actId) then
		gohelper.setActive(slot0.goTagNewAct, true)
	end
end

function slot0.clearTag(slot0)
	gohelper.setActive(slot0.goTagNewAct, false)
	gohelper.setActive(slot0.goTagNewLevel, false)
	gohelper.setActive(slot0.goTagTime, false)
	gohelper.setActive(slot0.goTagLock, false)
end

function slot0.onRefreshActivity(slot0, slot1)
	if slot0.actId ~= slot1 then
		return
	end

	slot0:refreshTag()
end

function slot0.isShowRedDot(slot0)
	return slot0.redDotIcon and slot0.redDotIcon.show
end

function slot0.getAnchorY(slot0)
	return recthelper.getAnchorY(slot0.rectTr)
end

function slot0.dispose(slot0)
	TaskDispatcher.cancelTask(slot0.refreshTag, slot0)
	slot0.click:RemoveClickListener()
	slot0:__onDispose()
end

return slot0
