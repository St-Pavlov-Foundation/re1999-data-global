module("modules.versionactivitybase.enterview.view.VersionActivityEnterViewTabItem", package.seeall)

slot0 = class("VersionActivityEnterViewTabItem", UserDataDispose)
slot1 = VersionActivityEnterViewTabEnum.ActTabFlag
slot0.activityRemainTimeColor = "#9DD589"

function slot0.init(slot0, slot1, slot2, slot3)
	slot0.index = slot1
	slot0.actId = slot2
	slot0.rootGo = slot3
	slot0.go_selected = gohelper.findChild(slot0.rootGo, "#go_select")
	slot0.go_unselected = gohelper.findChild(slot0.rootGo, "#go_normal")
	slot0.activityNameTexts = slot0:getUserDataTb_()
	slot0.activityNameTexts.select = gohelper.findChildText(slot0.go_selected, "#txt_name")
	slot0.activityNameTexts.normal = gohelper.findChildText(slot0.go_unselected, "#txt_name")
	slot0.txtLockGo = gohelper.findChild(slot3, "lockContainer/lock")
	slot0.txtLock = gohelper.findChildText(slot3, "lockContainer/lock/txt_lock")
	slot0.redPoints = slot0:getUserDataTb_()
	slot0.redPoints.select = gohelper.findChild(slot0.go_selected, "#image_reddot")
	slot0.redPoints.normal = gohelper.findChild(slot0.go_unselected, "#image_reddot")
	slot0.newActivityFlags = slot0:getUserDataTb_()
	slot0.newActivityFlags.select = gohelper.findChild(slot0.go_selected, "#go_newact")
	slot0.newActivityFlags.normal = gohelper.findChild(slot0.go_unselected, "#go_newact")
	slot0.newEpisodeFlags = slot0:getUserDataTb_()
	slot0.newEpisodeFlags.select = gohelper.findChild(slot0.go_selected, "#go_newlevel")
	slot0.newEpisodeFlags.normal = gohelper.findChild(slot0.go_unselected, "#go_newlevel")
	slot0.rewardunlock = slot0:getUserDataTb_()
	slot0.rewardunlock.select = gohelper.findChild(slot0.go_selected, "#go_rewardunlock")
	slot0.rewardunlock.normal = gohelper.findChild(slot0.go_unselected, "#go_rewardunlock")
	slot0.timeObjs = slot0:getUserDataTb_()
	slot0.timeObjs.goTime = slot0:getUserDataTb_()
	slot0.timeObjs.goTime.select = gohelper.findChild(slot0.go_selected, "#go_time")
	slot0.timeObjs.goTime.normal = gohelper.findChild(slot0.go_unselected, "#go_time")
	slot0.timeObjs.txtTime = slot0:getUserDataTb_()
	slot0.timeObjs.txtTime.select = gohelper.findChildText(slot0.go_selected, "#go_time/bg/#txt_timelimit")
	slot0.timeObjs.txtTime.normal = gohelper.findChildText(slot0.go_unselected, "#go_time/bg/#txt_timelimit")
	slot0.timeObjs.timeIcon = slot0:getUserDataTb_()
	slot0.timeObjs.timeIcon.select = gohelper.findChildImage(slot0.go_selected, "#go_time/bg/#txt_timelimit/#image_timeicon")
	slot0.timeObjs.timeIcon.normal = gohelper.findChildImage(slot0.go_unselected, "#go_time/bg/#txt_timelimit/#image_timeicon")
	slot0.imageIcons = slot0:getUserDataTb_()
	slot0.imageIcons.select = gohelper.findChildImage(slot0.go_selected, "#simage_icon_select")
	slot0.imageIcons.normal = gohelper.findChildImage(slot0.go_unselected, "#simage_icon_normal")
	slot0.click = SLFramework.UGUI.ButtonWrap.Get(gohelper.findChild(slot0.rootGo, "#btn_self"))
	slot0.redPointTagAnimator = slot0.goRedPointTag and slot0.goRedPointTag:GetComponent(typeof(UnityEngine.Animator))
	slot0.openId = ActivityConfig.instance:getActivityCo(slot2) and slot5.openId
	slot0.redDotId = slot5 and slot5.redDotId
	slot0.redDotUid = 0
	slot0._redDotIconSelect = nil
	slot0._redDotIconNormal = nil
end

function slot0.setClickFunc(slot0, slot1, slot2)
	slot0.click:AddClickListener(slot1, slot2, slot0)
end

function slot0.setShowRemainDayToggle(slot0, slot1, slot2)
	slot0._showOpenRemainDayThreshold = slot2
	slot0._showOpenRemainDay = slot1
end

function slot0.onClick(slot0)
end

function slot0.refreshSelectState(slot0, slot1)
	gohelper.setActive(slot0.go_selected, slot1)
	gohelper.setActive(slot0.go_unselected, not slot1)
end

function slot0.refreshNameText(slot0)
	if slot0.activityNameTexts then
		slot2 = ActivityModel.instance:getActMO(slot0.actId).config.tabName
		slot0.activityNameTexts.select.text = slot2
		slot0.activityNameTexts.normal.text = slot2
	end
end

function slot0.addRedDot(slot0)
	if slot0._redDotIconNormal ~= nil then
		return
	end

	if ActivityHelper.getActivityStatus(slot0.actId) == ActivityEnum.ActivityStatus.Normal and slot0.redDotId and slot0.redDotId ~= 0 then
		slot0._redDotIconSelect = RedDotController.instance:addRedDot(slot0.redPoints.select, slot0.redDotId, slot0.redDotUid)
		slot0._redDotIconNormal = RedDotController.instance:addRedDot(slot0.redPoints.normal, slot0.redDotId, slot0.redDotUid)
	end
end

function slot0.refreshActivityItemTag(slot0)
	gohelper.setActive(slot0.newActivityFlags.select, false)
	gohelper.setActive(slot0.newActivityFlags.normal, false)
	gohelper.setActive(slot0.newEpisodeFlags.select, false)
	gohelper.setActive(slot0.newEpisodeFlags.normal, false)

	slot0.showTag = nil

	if ActivityHelper.getActivityStatus(slot0.actId) == ActivityEnum.ActivityStatus.Normal or slot1 == ActivityEnum.ActivityStatus.NotUnlock then
		slot3 = ActivityModel.instance:getActMO(slot0.actId)

		if not ActivityEnterMgr.instance:isEnteredActivity(slot0.actId) then
			slot0.showTag = uv0.ShowNewAct
		elseif slot3:isNewStageOpen() then
			slot0.showTag = uv0.ShowNewStage
		end

		if slot0.actId == VersionActivity1_6Enum.ActivityId.Cachot then
			gohelper.setActive(slot0.rewardunlock.select, V1a6_CachotProgressListModel.instance:checkRewardStageChange() and not slot4)
			gohelper.setActive(slot0.rewardunlock.normal, slot5 and not slot4)
		end
	end
end

function slot0.refreshTimeInfo(slot0)
	if slot0.showTag == uv0.ShowNewAct or slot0.showTag == uv0.ShowNewStage then
		slot0:_setItemObjActive(slot0.timeObjs.goTime, false)

		return
	end

	slot2 = "#FFFFFF"
	slot3 = ""
	slot4 = ActivityModel.instance:getActMO(slot0.actId)

	if (ActivityHelper.getActivityStatus(slot0.actId) == ActivityEnum.ActivityStatus.Normal or slot1 == ActivityEnum.ActivityStatus.NotUnlock) and slot0._showOpenRemainDay then
		if slot4:getRemainDay() < slot0._showOpenRemainDayThreshold then
			slot0:_setItemObjActive(slot0.timeObjs.goTime, true)

			slot2 = uv1.activityRemainTimeColor
			slot3 = slot4:getRemainTimeStr2ByEndTime()
			slot0.timeObjs.txtTime.select.text = slot3
			slot0.timeObjs.txtTime.normal.text = slot3

			SLFramework.UGUI.GuiHelper.SetColor(slot0.timeObjs.timeIcon.select, slot2)
			SLFramework.UGUI.GuiHelper.SetColor(slot0.timeObjs.timeIcon.normal, slot2)
		else
			slot0:_setItemObjActive(slot0.timeObjs.goTime, false)
		end
	elseif slot1 == ActivityEnum.ActivityStatus.NotOpen then
		slot5 = slot4:getRemainOpeningDay()

		slot0:_setItemObjActive(slot0.timeObjs.goTime, true)

		slot3 = slot4:getRemainTimeStr2ByOpenTime()
		slot0.timeObjs.txtTime.select.text = slot3
		slot0.timeObjs.txtTime.normal.text = slot3

		SLFramework.UGUI.GuiHelper.SetColor(slot0.timeObjs.timeIcon.select, slot2)
		SLFramework.UGUI.GuiHelper.SetColor(slot0.timeObjs.timeIcon.normal, slot2)
	else
		slot0:_setItemObjActive(slot0.timeObjs.goTime, false)
	end
end

function slot0._setItemObjActive(slot0, slot1, slot2)
	for slot6, slot7 in pairs(slot1) do
		gohelper.setActive(slot7.gameObject, slot2)
	end
end

return slot0
