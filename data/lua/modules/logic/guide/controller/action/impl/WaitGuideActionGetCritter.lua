module("modules.logic.guide.controller.action.impl.WaitGuideActionGetCritter", package.seeall)

slot0 = class("WaitGuideActionGetCritter", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)
	CritterController.instance:registerCallback(CritterEvent.CritterGuideReply, slot0._onCritterGuideReply, slot0)
	CritterRpc.instance:sendGainGuideCritterRequest(slot0.guideId, slot0.stepId)

	slot0.noOpenView = tonumber(slot0.actionParam) == 1
end

function slot0._check(slot0)
	slot0:onDone(true)
end

function slot0._onCritterGuideReply(slot0, slot1)
	if not slot0.noOpenView then
		for slot6 = 1, #slot1.uids do
			if CritterModel.instance:getCritterMOByUid(slot2[slot6]) then
				ViewMgr.instance:openView(ViewName.RoomGetCritterView, {
					mode = RoomSummonEnum.SummonType.Summon,
					critterMo = slot7
				})

				break
			end
		end
	end

	slot0:_check()
end

function slot0.clearWork(slot0)
	CritterController.instance:unregisterCallback(CritterEvent.CritterGuideReply, slot0._onCritterGuideReply, slot0)
end

return slot0
