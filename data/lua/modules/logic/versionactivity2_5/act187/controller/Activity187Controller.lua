module("modules.logic.versionactivity2_5.act187.controller.Activity187Controller", package.seeall)

slot0 = class("Activity187Controller", BaseController)

function slot0.onInit(slot0)
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0.reInit(slot0)
end

function slot0.openAct187View(slot0)
	slot0:getAct187Info(slot0._realOpenAct187View, slot0, true)
end

function slot0.getAct187Info(slot0, slot1, slot2, slot3)
	if not Activity187Model.instance:isAct187Open(slot3) then
		return
	end

	Activity187Rpc.instance:sendGet187InfoRequest(Activity187Model.instance:getAct187Id(), slot1, slot2)
end

function slot0._realOpenAct187View(slot0)
	ViewMgr.instance:openView(ViewName.Activity187View)
end

function slot0.finishPainting(slot0, slot1, slot2)
	Activity187Rpc.instance:sendAct187FinishGameRequest(Activity187Model.instance:getAct187Id(), slot1, slot2)
end

function slot0.getAccrueReward(slot0, slot1, slot2)
	Activity187Rpc.instance:sendAct187AcceptRewardRequest(Activity187Model.instance:getAct187Id(), slot1, slot2)
end

slot0.instance = slot0.New()

return slot0
