module("modules.logic.pushbox.controller.PushBoxController", package.seeall)

slot0 = class("PushBoxController", BaseController)

function slot0.onInit(slot0)
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0.reInit(slot0)
end

function slot0.enterPushBoxGame(slot0)
	PushBoxRpc.instance:sendGet111InfosRequest(function ()
		GameSceneMgr.instance:startScene(SceneType.PushBox, 1, 1)
	end, slot0)
end

slot0.instance = slot0.New()

return slot0
