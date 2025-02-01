module("modules.logic.voyage.controller.VoyageController", package.seeall)

slot0 = class("VoyageController", BaseController)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0._model = VoyageModel.instance
end

function slot0.addConstEvents(slot0)
end

function slot0._onReceiveAct1001GetInfoReply(slot0, slot1)
	slot0._model:onReceiveAct1001GetInfoReply(slot1)
	slot0:dispatchEvent(VoyageEvent.OnReceiveAct1001GetInfoReply)
end

function slot0._onReceiveAct1001UpdatePush(slot0, slot1)
	slot0._model:onReceiveAct1001UpdatePush(slot1)
	slot0:dispatchEvent(VoyageEvent.OnReceiveAct1001UpdatePush)
end

function slot0.jump(slot0)
	if slot0._model:hasAnyRewardAvailable() then
		MailController.instance:open()
	else
		DungeonController.instance:enterDungeonView(true)
		DungeonController.instance:openDungeonChapterView({
			chapterId = 101
		})
	end
end

slot0.instance = slot0.New()

return slot0
