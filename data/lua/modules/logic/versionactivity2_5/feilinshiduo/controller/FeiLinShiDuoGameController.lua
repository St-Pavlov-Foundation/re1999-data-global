module("modules.logic.versionactivity2_5.feilinshiduo.controller.FeiLinShiDuoGameController", package.seeall)

slot0 = class("FeiLinShiDuoGameController", BaseController)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.openTaskView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.FeiLinShiDuoTaskView, slot1)
end

function slot0.openGameView(slot0, slot1)
	FeiLinShiDuoGameModel.instance:setCurMapId(slot1.mapId)
	ViewMgr.instance:openView(ViewName.FeiLinShiDuoGameView, slot1)
end

function slot0.enterEpisodeLevelView(slot0, slot1)
	Activity185Rpc.instance:sendGetAct185InfoRequest(slot1, slot0._onReceiveInfo, slot0)
end

function slot0._onReceiveInfo(slot0, slot1, slot2, slot3)
	if slot2 == 0 then
		if ActivityModel.instance:getActMO(slot3.activityId) and slot5.config and slot5.config.storyId and not StoryModel.instance:isStoryFinished(slot6) then
			StoryController.instance:playStory(slot6, {
				mark = true
			}, slot0.openEpisodeLevelView, slot0)
		else
			ViewMgr.instance:openView(ViewName.FeiLinShiDuoEpisodeLevelView)
		end
	end
end

function slot0.openEpisodeLevelView(slot0)
	ViewMgr.instance:openView(ViewName.FeiLinShiDuoEpisodeLevelView)
end

function slot0.finishEpisode(slot0, slot1, slot2)
	Activity185Rpc.instance:sendAct185FinishEpisodeRequest(slot1, slot2)
end

function slot0.openGameResultView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.FeiLinShiDuoResultView, slot1)
end

slot0.instance = slot0.New()

return slot0
