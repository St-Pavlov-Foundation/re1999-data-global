module("modules.logic.versionactivity1_2.jiexika.controller.Activity114Controller", package.seeall)

slot0 = class("Activity114Controller", BaseController)

function slot0.onInit(slot0)
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, slot0._checkActivityInfo, slot0)
	GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, slot0.onFightSceneEnter, slot0)
end

function slot0.reInit(slot0)
	slot0:markStoryFinish()
end

function slot0._checkActivityInfo(slot0, slot1)
	slot2 = nil

	if slot1 then
		slot2 = ActivityModel.instance:getActMO(slot1)
	else
		for slot6 in pairs(Activity114Config.instance:getAllActivityIds()) do
			if ActivityModel.instance:isActOnLine(slot6) then
				slot2 = ActivityModel.instance:getActMO(slot6)

				break
			end
		end
	end

	if not slot2 then
		return
	end

	if slot2.actType ~= ActivityEnum.ActivityTypeID.JieXiKa then
		return
	end

	if not slot2.online and slot2.id == Activity114Model.instance.id then
		Activity114Model.instance:setEnd()
	end
end

function slot0.onFightSceneEnter(slot0, slot1)
	if slot1 ~= SceneType.Fight then
		return
	end

	if not FightModel.instance:getFightParam() or slot2.episodeId ~= Activity114Enum.episodeId then
		return
	end

	if Activity114Helper.getEventCoByBattleId(slot2.battleId) then
		Activity114Model.instance:buildFlowAndSkipWork({
			type = slot3.config.eventType,
			eventId = slot3.config.id
		})
	end
end

function slot0.alertActivityEndMsgBox(slot0)
	if not Activity114Model.instance:isEnd() then
		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, function ()
		if GameSceneMgr.instance:isFightScene() then
			uv0:dispatchEvent(Activity114Event.OnEventProcessEnd)
		else
			NavigateButtonsView.homeClick()
		end
	end)
end

function slot0.openAct114View(slot0)
	slot1 = nil

	for slot5 in pairs(Activity114Config.instance:getAllActivityIds()) do
		if ActivityModel.instance:isActOnLine(slot5) then
			slot1 = ActivityModel.instance:getActMO(slot5)

			break
		end
	end

	if not slot1 then
		GameFacade.showToast(ToastEnum.ActivityEnd)

		return
	end

	Activity114Rpc.instance:sendGet114InfosRequest(slot1.id, slot0._openAct114View, slot0)
end

function slot0._openAct114View(slot0)
	if Activity114Model.instance:isEnd() then
		GameFacade.showToast(ToastEnum.ActivityEnd)

		return
	end

	if Activity114Model.instance.serverData.battleEventId > 0 then
		slot0:enterActivityFight(Activity114Config.instance:getEventCoById(Activity114Model.instance.id, Activity114Model.instance.serverData.battleEventId).config.battleId)

		return
	end

	ViewMgr.instance:openView(ViewName.Activity114View)
end

function slot0.enterActivityFight(slot0, slot1)
	if not slot1 or slot1 <= 0 then
		error("battleId : " .. tostring(slot1))

		return
	end

	Activity114Rpc.instance:beforeBattle(Activity114Model.instance.id)

	slot2 = Activity114Enum.episodeId

	DungeonFightController.instance:enterFightByBattleId(DungeonConfig.instance:getEpisodeCO(slot2).chapterId, slot2, slot1)
end

function slot0.markStoryWillFinish(slot0)
	Activity114Model.instance.waitStoryFinish = true

	ViewMgr.instance:registerCallback(ViewEvent.DestroyViewFinish, slot0._onCloseViewFinish, slot0)
	StoryController.instance:registerCallback(StoryEvent.Finish, slot0.markStoryFinish, slot0)
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.StoryView then
		slot0:markStoryFinish()
	end
end

function slot0.markStoryFinish(slot0)
	Activity114Model.instance.waitStoryFinish = false

	ViewMgr.instance:unregisterCallback(ViewEvent.DestroyViewFinish, slot0._onCloseViewFinish, slot0)
	StoryController.instance:unregisterCallback(StoryEvent.Finish, slot0.markStoryFinish, slot0)
	slot0:dispatchEvent(Activity114Event.StoryFinish)
end

slot0.instance = slot0.New()

return slot0
