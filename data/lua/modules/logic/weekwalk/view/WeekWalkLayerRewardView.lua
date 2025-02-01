module("modules.logic.weekwalk.view.WeekWalkLayerRewardView", package.seeall)

slot0 = class("WeekWalkLayerRewardView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._txttitlecn = gohelper.findChildText(slot0.viewGO, "#txt_titlecn")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#txt_titlecn/#txt_name")
	slot0._txtstar = gohelper.findChildText(slot0.viewGO, "#txt_star")
	slot0._scrollreward = gohelper.findChildScrollRect(slot0.viewGO, "right/#scroll_reward")
	slot0._gorewardcontent = gohelper.findChild(slot0.viewGO, "right/#scroll_reward/viewport/#go_rewardcontent")
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._txtdeeptip = gohelper.findChildText(slot0.viewGO, "#txt_deeptip")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnWeekwalkTaskUpdate, slot0._onWeekwalkTaskUpdate, slot0)
	slot0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnGetTaskReward, slot0._getTaskBouns, slot0)
	slot0._simagebg:LoadImage(ResUrl.getWeekWalkBg("img_bg_black.png"))
end

function slot0._updateTask(slot0)
	WeekWalkTaskListModel.instance:showLayerTaskList(WeekWalkRewardView.getTaskType(slot0._mapId), slot0._mapId)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._mapId = slot0.viewParam.mapId

	gohelper.setActive(slot0._txtdeeptip.gameObject, not WeekWalkModel.isShallowMap(slot0._mapId))
	slot0:_updateTask()
	slot0:_updateInfo()
end

function slot0._onWeekwalkTaskUpdate(slot0)
	if not slot0._getTaskBonusItem then
		return
	end

	slot0._getTaskBonusItem:playOutAnim()

	slot0._getTaskBonusItem = nil

	UIBlockMgr.instance:startBlock("WeekWalkLayerRewardView bonus")
	TaskDispatcher.runDelay(slot0._showRewards, slot0, 0.3)
end

function slot0._getTaskBouns(slot0, slot1)
	slot0._getTaskBonusItem = slot1
end

function slot0._showRewards(slot0)
	slot0:_updateTask()
	slot0:_updateInfo()
	UIBlockMgr.instance:endBlock("WeekWalkLayerRewardView bonus")
	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, WeekWalkTaskListModel.instance:getTaskRewardList())
end

function slot0._updateInfo(slot0)
	slot2 = 0

	for slot7, slot8 in ipairs(WeekWalkTaskListModel.instance:getList()) do
		if slot8.maxProgress then
			slot3 = math.max(0, slot8.maxProgress)
		end
	end

	slot0._txtname.text = lua_weekwalk_scene.configDict[lua_weekwalk.configDict[slot0._mapId].sceneId].name
	slot0._txttitlecn.text = luaLang(WeekWalkModel.instance.isShallowMap(slot0._mapId) and "p_weekwalklayerrewardview_shallowtitle" or "p_weekwalklayerrewardview_deeptitle")
	slot0._mapInfo = WeekWalkModel.instance:getMapInfo(slot0._mapId)

	if slot0._mapInfo then
		slot2 = slot0._mapInfo:getCurStarInfo()
	end

	slot0._txtstar.text = string.format("%s/%s", slot2, slot3)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._showRewards, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
end

return slot0
