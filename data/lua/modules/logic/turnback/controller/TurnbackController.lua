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

function slot0.openTurnbackBeginnerView(slot0, slot1)
	if GameUtil.getTabLen(TurnbackConfig.instance:getAllTurnbackSubModules(slot1.turnbackId)) > 0 then
		ViewMgr.instance:openView(ViewName.TurnbackBeginnerView, slot1)
	else
		GameFacade.showToast(ToastEnum.ActivityNormalView)
	end
end

function slot0._onUpdateTaskList(slot0, slot1)
	if TurnbackTaskModel.instance:updateInfo(slot1.taskInfo) then
		TurnbackTaskModel.instance:refreshList(TurnbackTaskModel.instance.curTaskLoopType)
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

	slot5 = tonumber(RedDotConfig.instance:getRedDotCO(TurnbackConfig.instance:getTurnbackSubModuleCo(slot2).reddotId).parent)

	if not slot1.show and slot4.canLoad == 0 then
		slot1.show = TimeUtil.getDayFirstLoginRed(TurnbackModel.instance:getCurTurnbackId() .. "_" .. slot2)

		slot1:showRedDot(slot3 ~= 0 and slot4.style or RedDotEnum.Style.Normal)
	end
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

slot0.instance = slot0.New()

return slot0
