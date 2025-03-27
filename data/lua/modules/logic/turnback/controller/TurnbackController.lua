module("modules.logic.turnback.controller.TurnbackController", package.seeall)

slot0 = class("TurnbackController", BaseController)

function slot0.onInit(slot0)
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, slot0._onUpdateTaskList, slot0)
	slot0:registerCallback(TurnbackEvent.AdditionCountChange, slot0._onAdditionCountChange, slot0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, slot0._dailyRefresh, slot0)
end

function slot0.reInit(slot0)
end

function slot0._dailyRefresh(slot0)
	if TurnbackModel.instance:isInOpenTime() then
		TurnbackRpc.instance:sendGetTurnbackInfoRequest()
	else
		ViewMgr.instance:closeView(ViewName.TurnbackNewBeginnerView)
		ViewMgr.instance:closeView(ViewName.TurnbackBeginnerView)
	end
end

function slot0.hasPlayedStoryVideo(slot0, slot1)
	if not TurnbackConfig.instance:getTurnbackCo(slot1) then
		return true
	end

	if slot2.startStory == 0 then
		return true
	end

	return StoryModel.instance:isStoryFinished(slot2.startStory)
end

function slot0.checkFirstOpenLatter(slot0, slot1)
	if string.nilorempty(PlayerPrefsHelper.getString(string.format("%s#%s#%s", PlayerPrefsKey.TurnbackSigninLatterFirstOpen, slot1, PlayerModel.instance:getPlayinfo().userId), "")) then
		ViewMgr.instance:openView(ViewName.TurnbackNewLatterView, {
			isNormal = true,
			day = slot1
		})
		PlayerPrefsHelper.setString(slot2, "opened")
	end
end

function slot0.openTurnbackBeginnerView(slot0, slot1)
	if GameUtil.getTabLen(TurnbackConfig.instance:getAllTurnbackSubModules(slot1.turnbackId)) > 0 then
		if TurnbackModel.instance:getCurTurnbackMo():isNewType() then
			ViewMgr.instance:openView(ViewName.TurnbackNewBeginnerView, slot1)
		else
			ViewMgr.instance:openView(ViewName.TurnbackBeginnerView, slot1)
		end
	else
		GameFacade.showToast(ToastEnum.ActivityNormalView)
	end
end

function slot0._onUpdateTaskList(slot0, slot1)
	if not TurnbackModel.instance:getCurTurnbackMo() then
		return
	end

	if TurnbackTaskModel.instance:updateInfo(slot1.taskInfo) then
		if not TurnbackModel.instance:isNewType() then
			TurnbackTaskModel.instance:refreshList(TurnbackTaskModel.instance.curTaskLoopType)
		else
			TurnbackTaskModel.instance:refreshListNewTaskList()
		end

		uv0.instance:dispatchEvent(TurnbackEvent.RefreshTaskRedDot)
	end
end

function slot0.setSignInList(slot0)
	TurnbackSignInModel.instance:setSignInList()
end

function slot0._onAdditionCountChange(slot0)
	slot1, slot2 = TurnbackModel.instance:getAdditionCountInfo()

	GameFacade.showToast(ToastEnum.TurnBackAdditionTimesChange, string.format("%s/%s", slot1, slot2))
end

function slot0._checkCustomShowRedDotData(slot0, slot1, slot2)
	slot1:defaultRefreshDot()

	if not slot1.show then
		if not RedDotConfig.instance:getRedDotCO(TurnbackConfig.instance:getTurnbackSubModuleCo(slot2).reddotId) then
			return
		end

		slot1.show = slot0:checkIsShowCustomRedDot(slot2)

		slot1:showRedDot(slot3 ~= 0 and slot4.style or RedDotEnum.Style.Normal)
	end
end

function slot0.checkIsShowCustomRedDot(slot0, slot1)
	if not RedDotConfig.instance:getRedDotCO(TurnbackConfig.instance:getTurnbackSubModuleCo(slot1).reddotId) then
		return
	end

	if slot3.canLoad == 0 then
		return TimeUtil.getDayFirstLoginRed(TurnbackModel.instance:getCurTurnbackId() .. "_" .. slot1)
	end

	return false
end

function slot0.refreshRemainTime(slot0, slot1)
	slot2, slot3, slot4 = TurnbackModel.instance:getRemainTime(slot1)
	slot7 = string.format("%02d", slot4)
	slot8 = ""

	if slot2 >= 1 then
		slot8 = GameUtil.getSubPlaceholderLuaLang(luaLang("remaintime_day_hour"), {
			string.format("%02d", slot2),
			string.format("%02d", slot3)
		})
	elseif slot2 == 0 and slot3 >= 1 then
		slot8 = GameUtil.getSubPlaceholderLuaLang(luaLang("remaintime_hour_minute"), {
			slot6,
			slot7
		})
	elseif slot2 == 0 and slot3 < 1 and slot4 >= 1 then
		slot8 = GameUtil.getSubPlaceholderLuaLang(luaLang("remaintime_minute"), {
			slot7
		})
	elseif slot2 == 0 and slot3 < 1 and slot4 < 1 then
		slot8 = luaLang("lessOneMinute")
	elseif slot2 < 0 or not TurnbackModel.instance:isInOpenTime() then
		slot8 = luaLang("turnback_end")
	end

	return slot8
end

function slot0.showPopupView(slot0, slot1)
	if slot1 ~= nil and MaterialRpc.receiveMaterial({
		dataList = slot1
	}) and #slot3 > 0 then
		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, slot3)
	end
end

slot1 = PlayerPrefsKey.PlayerPrefsKey.TurnbackOnlineTaskUnlock .. "#"

function slot0.isPlayFirstUnlockToday(slot0, slot1)
	slot4 = os.date("*t", ServerTime.nowInLocal())

	if PlayerPrefsHelper.hasKey(uv0 .. tostring(PlayerModel.instance:getPlayinfo().userId) .. slot1) then
		slot4.hour = 5
		slot4.min = 0
		slot4.sec = 0
		slot6 = os.time(slot4)

		if tonumber(PlayerPrefsHelper.getString(slot2, slot3)) and TimeUtil.getDiffDay(slot3, slot5) < 1 and (slot3 - slot6) * (slot5 - slot6) > 0 then
			return false
		end
	end

	return true
end

function slot0.savePlayUnlockAnim(slot0, slot1)
	PlayerPrefsHelper.setString(uv0 .. tostring(PlayerModel.instance:getPlayinfo().userId) .. slot1, tostring(ServerTime.nowInLocal()))
end

slot0.instance = slot0.New()

return slot0
