module("modules.logic.versionactivity2_2.act101.view.VersionActivity2_2RoomSignItem", package.seeall)

slot0 = class("VersionActivity2_2RoomSignItem", ListScrollCellExtend)

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1
	slot0._anim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._txtTitle = gohelper.findChildTextMesh(slot0.viewGO, "Root/#txt_title")
	slot0._goLock = gohelper.findChild(slot0.viewGO, "Root/lock")
	slot0._txtTime = gohelper.findChildTextMesh(slot0.viewGO, "Root/lock/#txt_LimitTime")
	slot0._goUnlock = gohelper.findChild(slot0.viewGO, "Root/unlock")
	slot0._simagePic = gohelper.findChildSingleImage(slot0.viewGO, "Root/unlock/#image_pic")
	slot0._txtDesc = gohelper.findChildTextMesh(slot0.viewGO, "Root/unlock/#scroll_ItemList/Viewport/Content/#txt_dec")
	slot0._goIcon = gohelper.findChild(slot0.viewGO, "Root/unlock/#go_reward/go_icon")
	slot0._goHasGet = gohelper.findChild(slot0.viewGO, "Root/unlock/#go_reward/hasget")
	slot0._goCanGet = gohelper.findChild(slot0.viewGO, "Root/unlock/#go_reward/canget")
	slot0._btnLock = gohelper.findChildButtonWithAudio(slot0.viewGO, "Root/lock/btn_click")
	slot0._btnGetReward = gohelper.findChildButtonWithAudio(slot0.viewGO, "Root/unlock/#go_reward/canget")
end

function slot0.addEventListeners(slot0)
	slot0:addClickCb(slot0._btnLock, slot0.onClickBtnLock, slot0)
	slot0:addClickCb(slot0._btnGetReward, slot0.onClickBtnReward, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0:removeClickCb(slot0._btnLock)
	slot0:removeClickCb(slot0._btnGetReward)
end

function slot0.onClickBtnLock(slot0)
	slot0:onClickBtn()
end

function slot0.onClickBtnReward(slot0)
	slot0:onClickBtn()
end

function slot0.onClickBtn(slot0)
	if not slot0.id then
		return
	end

	slot1, slot2 = slot0.actInfo:isEpisodeDayOpen(slot0.id)

	if slot1 and not slot0.actInfo:isEpisodeFinished(slot0.id) then
		Activity125Rpc.instance:sendFinishAct125EpisodeRequest(slot0.activityId, slot0.id, slot0.config.targetFrequency)
	end

	if not slot1 then
		GameFacade.showToastString(formatLuaLang("versionactivity_1_2_119_unlock", slot2))
	end
end

function slot0.onUpdateMO(slot0, slot1, slot2)
	slot0.config = slot1
	slot0.actInfo = slot2
	slot0.activityId = nil
	slot0.id = nil

	gohelper.setActive(slot0.viewGO, slot1 ~= nil)

	if not slot1 then
		TaskDispatcher.cancelTask(slot0._onRefreshDeadline, slot0)

		return
	end

	slot0.activityId = slot0.config.activityId
	slot0.id = slot0.config.id

	if slot0.actInfo:isEpisodeDayOpen(slot0.id) and not slot0.actInfo:checkLocalIsPlay(slot0.id) then
		slot0:refreshItem(false)
		TaskDispatcher.runDelay(slot0.refreshItem, slot0, 0.4)
	else
		slot0:refreshItem()
	end
end

function slot0.refreshItem(slot0, slot1)
	recthelper.setAnchor(slot0.viewGO.transform, 506 * slot0._index - 488, -28)
	transformhelper.setEulerAngles(slot0.viewGO.transform, 0, 0, slot0._index % 2 == 1 and -1.64 or 0)

	slot0._txtTitle.text = slot0.config.name
	slot0._txtDesc.text = slot0.config.text

	if slot1 == nil then
		slot1 = slot0.actInfo:isEpisodeDayOpen(slot0.id)
	end

	if slot1 and not slot0.actInfo:checkLocalIsPlay(slot0.id) then
		slot0.actInfo:setLocalIsPlay(slot0.id)
		slot0._anim:Play("unlock")
	end

	gohelper.setActive(slot0._goLock, not slot1)
	gohelper.setActive(slot0._txtTime, not slot1)
	gohelper.setActive(slot0._goUnlock, slot1)

	slot4 = slot0.actInfo:isEpisodeFinished(slot0.id)

	gohelper.setActive(slot0._goHasGet, slot4)
	gohelper.setActive(slot0._goCanGet, slot1 and not slot4)

	if slot1 then
		slot0._simagePic:LoadImage(string.format("singlebg/v2a2_mainactivity_singlebg/v2a2_room_pic%s.png", slot0.id))
		slot0:refreshIcon()
	end

	slot0:_showDeadline()
end

function slot0.refreshIcon(slot0)
	slot1 = GameUtil.splitString2(slot0.config.bonus, true)

	if not slot0.itemIcon then
		slot0.itemIcon = IconMgr.instance:getCommonPropItemIcon(slot0._goIcon)
	end

	if slot1[1] then
		slot0.itemIcon:setMOValue(slot2[1], slot2[2], slot2[3], nil, true)
		slot0.itemIcon:setScale(0.5)
	end
end

function slot0._showDeadline(slot0)
	slot0:_onRefreshDeadline()
	TaskDispatcher.cancelTask(slot0._onRefreshDeadline, slot0)
	TaskDispatcher.runRepeat(slot0._onRefreshDeadline, slot0, 1)
end

function slot0._onRefreshDeadline(slot0)
	slot1, slot2, slot3 = slot0.actInfo:isEpisodeDayOpen(slot0.id)

	if slot1 then
		TaskDispatcher.cancelTask(slot0._onRefreshDeadline, slot0)
		gohelper.setActive(slot0._txtTime, false)

		return
	end

	if slot3 < TimeUtil.OneDaySecond then
		slot0._txtTime.text = formatLuaLang("season123_overview_unlocktime_custom", TimeUtil.getFormatTime_overseas(slot3))
	else
		slot0._txtTime.text = formatLuaLang("season123_overview_unlocktime", slot2)
	end
end

function slot0.onDestroy(slot0)
	TaskDispatcher.cancelTask(slot0.refreshItem, slot0)
	TaskDispatcher.cancelTask(slot0._onRefreshDeadline, slot0)
	slot0._simagePic:UnLoadImage()
end

return slot0
