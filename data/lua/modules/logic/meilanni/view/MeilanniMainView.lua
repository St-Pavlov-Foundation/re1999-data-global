module("modules.logic.meilanni.view.MeilanniMainView", package.seeall)

slot0 = class("MeilanniMainView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg1 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg1")
	slot0._simageheroup1 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_hero_up1")
	slot0._simagehero = gohelper.findChildSingleImage(slot0.viewGO, "#simage_hero")
	slot0._goday = gohelper.findChild(slot0.viewGO, "remaintime/#go_day")
	slot0._txtremainday = gohelper.findChildText(slot0.viewGO, "remaintime/#go_day/#txt_remainday")
	slot0._gohour = gohelper.findChild(slot0.viewGO, "remaintime/#go_hour")
	slot0._txtremainhour = gohelper.findChildText(slot0.viewGO, "remaintime/#go_hour/#txt_remainhour")
	slot0._gofullscreen = gohelper.findChild(slot0.viewGO, "#go_fullscreen")
	slot0._gomaplist = gohelper.findChild(slot0.viewGO, "#go_maplist")
	slot0._btnend = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_maplist/#btn_end")
	slot0._golock = gohelper.findChild(slot0.viewGO, "#go_lock")
	slot0._imageremainday = gohelper.findChildImage(slot0.viewGO, "#go_lock/horizontal/part2/#image_remainday")
	slot0._btntask = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_task")
	slot0._gotaskredpoint = gohelper.findChild(slot0.viewGO, "#btn_task/#go_taskredpoint")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnend:AddClickListener(slot0._btnendOnClick, slot0)
	slot0._btntask:AddClickListener(slot0._btntaskOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnend:RemoveClickListener()
	slot0._btntask:RemoveClickListener()
end

function slot0._btnendOnClick(slot0)
	MeilanniMapItem.playStoryList(MeilanniEnum.endStoryBindIndex)
end

function slot0._btntaskOnClick(slot0)
	MeilanniController.instance:openMeilanniTaskView()
end

function slot0._editableInitView(slot0)
	slot0._simagebg1:LoadImage(ResUrl.getMeilanniIcon("full/bg_beijing"))
	slot0._simagehero:LoadImage(ResUrl.getMeilanniIcon("bg_renwu"))
	gohelper.addUIClickAudio(slot0._btntask.gameObject, AudioEnum.UI.play_ui_common_pause)
	RedDotController.instance:addRedDot(slot0._gotaskredpoint, RedDotEnum.DotNode.MeilanniTaskBtn)
	UIBlockMgr.instance:endAll()
end

function slot0._checkFinishAllMapStory(slot0)
	for slot4, slot5 in ipairs(lua_activity108_map.configList) do
		if MeilanniModel.instance:getMapHighestScore(slot5.id) <= 0 then
			slot0:_forceUpdateTime()

			return
		end
	end

	for slot5, slot6 in ipairs(MeilanniConfig.instance:getStoryList(MeilanniEnum.StoryType.finishAllMap)) do
		if not StoryModel.instance:isStoryFinished(slot6[1].story) then
			StoryController.instance:playStory(slot8, nil, slot0._finishAllMapCallback, slot0)

			return
		end
	end

	slot0:_forceUpdateTime()
end

function slot0._finishAllMapCallback(slot0)
	slot0:_forceUpdateTime()
end

function slot0._forceUpdateTime(slot0)
	if slot0:_getLockTime() > 0 then
		slot0:_showMapList()
	end

	slot0._openMeilanniView = false

	slot0:_updateTime()
end

function slot0._checkOpenDayAndFinishMapStory(slot0)
	if uv0.getOpenDayAndFinishMapStory() then
		StoryController.instance:playStory(slot1)
	end
end

function slot0.getOpenDayAndFinishMapStory()
	if ServerTime.now() - ActivityModel.instance:getActMO(MeilanniEnum.activityId):getRealStartTimeStamp() <= 0 then
		return
	end

	for slot7, slot8 in ipairs(MeilanniConfig.instance:getStoryList(MeilanniEnum.StoryType.openDayAndFinishMap)) do
		slot9 = MeilanniModel.instance:getMapInfo(slot8[3])

		if slot8[2] <= math.ceil(slot1 / 86400) and slot9 and (slot9:checkFinish() or slot9.highestScore > 0) then
			if not StoryModel.instance:isStoryFinished(slot8[1].story) then
				return slot11
			end

			break
		end
	end
end

function slot0._checkOpenDayStory(slot0)
	if ServerTime.now() - slot0._actMO:getRealStartTimeStamp() <= 0 then
		return
	end

	for slot7, slot8 in ipairs(MeilanniConfig.instance:getStoryList(MeilanniEnum.StoryType.openDay)) do
		if slot8[2] <= math.ceil(slot1 / 86400) then
			if not StoryModel.instance:isStoryFinished(slot8[1].story) then
				StoryController.instance:playStory(slot10)
			end

			break
		end
	end
end

function slot0._checkStory(slot0)
	if not (slot0.viewParam and slot0.viewParam.checkStory) then
		return
	end

	slot0:_checkOpenDayStory()
	slot0:_checkOpenDayAndFinishMapStory()
	slot0:_checkFinishAllMapStory()
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.MeilanniView then
		TaskDispatcher.runDelay(slot0._checkFinishAllMapStory, slot0, 0)
	end

	if slot1 == ViewName.StoryView and not slot0._hasOpenMeilanniView then
		slot0.viewGO:GetComponent(typeof(UnityEngine.Animator)):Play(UIAnimationName.Open, 0, 0)
	end
end

function slot0._onOpenViewFinish(slot0, slot1)
	if slot1 == ViewName.MeilanniView then
		slot0._openMeilanniView = true
		slot0._hasOpenMeilanniView = true
	end
end

function slot0.onOpen(slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, slot0._onOpenViewFinish, slot0)

	slot0._actMO = ActivityModel.instance:getActMO(MeilanniEnum.activityId)
	slot0._endTime = slot0._actMO:getRealEndTimeStamp()
	slot0._mapItemList = slot0:getUserDataTb_()

	slot0:_showMapList()

	slot0._unlockMapConfig = lua_activity108_map.configDict[MeilanniEnum.unlockMapId]
	slot0._unlockStartTime = slot0._actMO:getRealStartTimeStamp() + (slot0._unlockMapConfig.onlineDay - 1) * 86400

	slot0:_updateTime()
	TaskDispatcher.runRepeat(slot0._updateTime, slot0, 1)
	slot0:_checkStory()
	AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_cardappear)
end

function slot0._updateTime(slot0)
	if slot0._endTime - ServerTime.now() <= 0 then
		ViewMgr.instance:closeView(ViewName.MeilanniTaskView)
		ViewMgr.instance:closeView(ViewName.MeilanniEntrustView)
		ViewMgr.instance:closeView(ViewName.MeilanniView)
		ViewMgr.instance:closeView(ViewName.MeilanniSettlementView)
		ViewMgr.instance:closeView(ViewName.MeilanniMainView)

		return
	end

	if slot0._openMeilanniView then
		return
	end

	slot2, slot3 = TimeUtil.secondsToDDHHMMSS(slot1)

	if slot2 > 0 then
		slot0._txtremainday.text = slot2
	else
		slot0._txtremainhour.text = slot3
	end

	gohelper.setActive(slot0._goday, slot4)
	gohelper.setActive(slot0._gohour, not slot4)

	if slot0:_getLockTime() > 0 then
		UISpriteSetMgr.instance:setMeilanniSprite(slot0._imageremainday, "bg_daojishi_" .. math.max(math.min(math.ceil(slot5 / 86400), 6), 1))
		slot0._simageheroup1:LoadImage(ResUrl.getMeilanniIcon("bg_renwu_2"))
	else
		gohelper.setActive(slot0._golock, false)
		slot0._simageheroup1:LoadImage(ResUrl.getMeilanniIcon("bg_renwu_1"))
		slot0:_showMapList()
	end
end

function slot0._getLockTime(slot0)
	return slot0._unlockStartTime - ServerTime.now()
end

function slot0._showMapList(slot0)
	for slot4, slot5 in ipairs(lua_activity108_map.configList) do
		slot7 = slot0._mapItemList[slot5.id] or slot0:_getMapItem(gohelper.findChild(slot0._gomaplist, "pos" .. slot4), slot5)
		slot0._mapItemList[slot5.id] = slot7

		slot7:updateLockStatus()

		if slot5.id == 104 then
			gohelper.setActive(slot0._btnend, MeilanniModel.instance:getMapInfo(slot5.id) and slot8.highestScore > 0)
		end
	end
end

function slot0._getMapItem(slot0, slot1, slot2)
	return MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.findChild(slot1, "item"), MeilanniMapItem, slot2)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._updateTime, slot0)
	TaskDispatcher.cancelTask(slot0._checkFinishAllMapStory, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg1:UnLoadImage()
	slot0._simageheroup1:UnLoadImage()
	slot0._simagehero:UnLoadImage()
end

return slot0
