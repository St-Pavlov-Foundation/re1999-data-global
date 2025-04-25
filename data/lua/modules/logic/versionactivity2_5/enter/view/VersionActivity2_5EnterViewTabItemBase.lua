module("modules.logic.versionactivity2_5.enter.view.VersionActivity2_5EnterViewTabItemBase", package.seeall)

slot0 = class("VersionActivity2_5EnterViewTabItemBase", VersionActivityEnterViewBaseTabItem)

function slot0._editableInitView(slot0)
	slot0.goSelected = gohelper.findChild(slot0.go, "#go_select")
	slot0.imageSelectTabIcon = gohelper.findChildImage(slot0.go, "#go_select/#image_tabicon")
	slot0.goUnselected = gohelper.findChild(slot0.go, "#go_unselect")
	slot0.imageUnSelectTabIcon = gohelper.findChildImage(slot0.go, "#go_unselect/#image_tabicon")
	slot1 = slot0:_getTagPath()
	slot0.goTag = gohelper.findChild(slot0.go, slot1)
	slot0.goTagNewAct = gohelper.findChild(slot0.go, slot1 .. "/#go_newact")
	slot0.goTagNewLevel = gohelper.findChild(slot0.go, slot1 .. "/#go_newlevel")
	slot0.goTagTime = gohelper.findChild(slot0.go, slot1 .. "/#go_time")
	slot0.goTagLock = gohelper.findChild(slot0.go, slot1 .. "/#go_lock")
	slot0.txtTime = gohelper.findChildText(slot0.goTagTime, "bg/#txt_time")
	slot0.txtLock = gohelper.findChildText(slot0.goTagLock, "bg/#txt_lock")
	slot0.goRedDot = gohelper.findChild(slot0.go, "#go_reddot")
	slot0.animator = slot0.go:GetComponent(gohelper.Type_Animator)

	if not slot0.goTag or not slot0.goTagNewAct or not slot0.goTagNewLevel or not slot0.goTagTime or not slot0.goTagLock then
		logError("error node:", tostring(slot0.goTag), tostring(slot0.goTagNewAct), tostring(slot0.goTagNewLevel), tostring(slot0.goTagTime), tostring(slot0.goTagLock))
	end

	if not slot0.txtTime or not slot0.txtLock then
		logError("error node txt:", tostring(slot0.txtTime), tostring(slot0.txtLock))
	end
end

function slot0._getTagPath(slot0)
	return "#txt_name/#go_tag"
end

function slot0.afterSetData(slot0)
	if slot0.actId then
		slot0.activityCo = ActivityConfig.instance:getActivityCo(slot0.actId)
	end

	if not slot0.activityCo then
		gohelper.setActive(slot0.go, false)
		logError("VersionActivity2_5EnterViewTabItemBase.afterSetData error, no act config, actId:%s", slot0.actId)

		return
	end

	if not string.nilorempty(string.split(slot0.activityCo.tabBgPath, "#")[1]) then
		UISpriteSetMgr.instance:setV2a5MainActivitySprite(slot0.imageSelectTabIcon, slot2)
	end

	if not string.nilorempty(slot1[2]) then
		UISpriteSetMgr.instance:setV2a5MainActivitySprite(slot0.imageUnSelectTabIcon, slot3)
	end

	slot0.redDotIcon = RedDotController.instance:addRedDot(slot0.goRedDot, slot0.activityCo.redDotId, slot0.redDotUid)
end

function slot0.childRefreshSelect(slot0)
	gohelper.setActive(slot0.goSelected, slot0.isSelect)
	gohelper.setActive(slot0.goUnselected, not slot0.isSelect)
end

function slot0.childRefreshUI(slot0)
	gohelper.setActive(slot0.goRedDot, ActivityHelper.getActivityStatus(slot0.actId) == ActivityEnum.ActivityStatus.Normal)
end

function slot0.refreshTag(slot0)
	slot0:clearTag()

	if not slot0.actId then
		return
	end

	if ActivityHelper.getActivityStatus(slot0.actId) == ActivityEnum.ActivityStatus.Normal then
		slot0:refreshNormalTag()
	elseif slot1 == ActivityEnum.ActivityStatus.NotUnlock then
		slot0:refreshNotUnlockTag()
	else
		slot0:refreshLockTag()
	end
end

function slot0.clearTag(slot0)
	gohelper.setActive(slot0.goTagNewAct, false)
	gohelper.setActive(slot0.goTagNewLevel, false)
	gohelper.setActive(slot0.goTagTime, false)
	gohelper.setActive(slot0.goTagLock, false)
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

	if VersionActivity2_5EnterHelper.GetIsShowTabRemainTime(slot0.actId) and slot1 then
		if VersionActivity2_5Enum.MaxShowTimeOffset < slot1:getRealEndTimeStamp() - ServerTime.now() then
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

function slot0.refreshLockTag(slot0)
	gohelper.setActive(slot0.goTagLock, true)

	if ActivityHelper.getActivityStatus(slot0.actId) == ActivityEnum.ActivityStatus.NotOpen then
		slot0.txtLock.text = ActivityModel.instance:getActivityInfo()[slot0.actId]:getRemainTimeStr2ByOpenTime()
	else
		gohelper.setActive(slot0.goTagLock, false)
	end
end

function slot0.isShowRedDot(slot0)
	return slot0.redDotIcon and slot0.redDotIcon.show
end

return slot0
