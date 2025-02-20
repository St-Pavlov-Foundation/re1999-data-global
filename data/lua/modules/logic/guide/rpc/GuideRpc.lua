module("modules.logic.guide.rpc.GuideRpc", package.seeall)

slot0 = class("GuideRpc", BaseRpc)

function slot0.sendGetGuideInfoRequest(slot0, slot1, slot2)
	return slot0:sendMsg(GuideModule_pb.GetGuideInfoRequest(), slot1, slot2)
end

function slot0.onReceiveGetGuideInfoReply(slot0, slot1, slot2)
	if slot1 == 0 then
		GuideModel.instance:setGuideList(slot2.guideInfos)
		GuideController.instance:dispatchEvent(GuideEvent.GetGuideInfoSuccess)
	end
end

function slot0.sendFinishGuideRequest(slot0, slot1, slot2)
	slot3 = GuideModule_pb.FinishGuideRequest()
	slot3.guideId = slot1
	slot3.stepId = slot2

	slot0:sendMsg(slot3)
end

function slot0.onReceiveFinishGuideReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		GuideController.instance:dispatchEvent(GuideEvent.FinishGuideFail)
	end
end

function slot0.onReceiveUpdateGuidePush(slot0, slot1, slot2)
	slot6 = slot2.guideInfos

	GuideModel.instance:updateGuideList(slot6)

	for slot6 = 1, #slot2.guideInfos do
		slot7 = slot2.guideInfos[slot6]

		logNormal(string.format("<color=#3E7E00>update guide push guide_%d_%d</color>", slot7.guideId, slot7.stepId))

		if slot2.guideInfos[slot6].stepId == 0 then
			GuideController.instance:dispatchEvent(GuideEvent.StartGuide, GuideModel.instance:getById(slot7.guideId).id)
		else
			GuideStepController.instance:clearFlow(slot8.id)

			if (slot8.serverStepId > 0 and slot8.serverStepId or slot8.clientStepId) == -1 then
				slot10 = GuideConfig.instance:getStepList(slot8.id)
				slot9 = slot10[#slot10].stepId
			end

			GuideController.instance:dispatchEvent(GuideEvent.FinishStep, slot8.id, slot9)

			if slot8.isFinish then
				GuideController.instance:dispatchEvent(GuideEvent.FinishGuide, slot8.id)
			end
		end

		GuideController.instance:statFinishStep(slot8.id, slot8.clientStepId, false)
		GuideController.instance:execNextStep(slot8.id)
	end
end

slot0.instance = slot0.New()

return slot0
