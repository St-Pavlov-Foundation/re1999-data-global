module("modules.logic.critter.controller.CritterSummonController", package.seeall)

slot0 = class("CritterSummonController", BaseController)

function slot0.onInit(slot0)
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0.reInit(slot0)
end

function slot0.summonCritterInfoReply(slot0, slot1)
	CritterSummonModel.instance:initSummonPools(slot1.poolInfos)
end

function slot0.summonCritterReply(slot0, slot1)
	slot3 = {}

	if slot1.critterInfos then
		for slot7, slot8 in ipairs(slot2) do
			table.insert(slot3, CritterModel.instance:addCritter(slot8))
		end
	end

	if slot3 and #slot3 > 0 then
		CritterSummonModel.instance:onSummon(slot1.poolId, slot1.hasSummonCritter)
		slot0:dispatchEvent(CritterSummonEvent.onStartSummon, {
			mode = RoomSummonEnum.SummonType.Summon,
			poolId = slot1.poolId,
			critterMo = slot3[1],
			critterMOList = slot3
		})
	end
end

function slot0.resetSummonCritterPoolReply(slot0, slot1)
	slot0:dispatchEvent(CritterSummonEvent.onResetSummon, slot1.poolId, slot1.poolId)
end

function slot0.refreshSummon(slot0, slot1, slot2, slot3)
	CritterRpc.instance:sendSummonCritterInfoRequest(slot2, slot3)
end

function slot0.openSummonRuleTipView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.RoomCritterSummonRuleTipsView, {
		type = slot1
	})
end

function slot0.openSummonView(slot0, slot1, slot2)
	if slot1 and slot2 then
		RoomCameraController.instance:tweenCameraFocusBuildingUseCameraId(slot1, RoomSummonEnum.SummonMode[slot2.mode].CameraId, function ()
			uv0:_reallyOpenSummonView(uv1)
		end)
	else
		slot0:_reallyOpenSummonView(slot2)
	end
end

function slot0._reallyOpenSummonView(slot0, slot1)
	slot0:dispatchEvent(CritterSummonEvent.onStartSummonAnim, slot1)
	ViewMgr.instance:openView(ViewName.RoomCritterSummonSkipView, slot1)
end

function slot0.openSummonGetCritterView(slot0, slot1, slot2)
	slot1 = slot1 or {}
	slot1.isSkip = slot2

	ViewMgr.instance:openView(ViewName.RoomGetCritterView, slot1)
end

function slot0.onCanDrag(slot0)
	slot0:dispatchEvent(CritterSummonEvent.onCanDrag)
end

function slot0.onSummonDragEnd(slot0, slot1, slot2)
	slot0:dispatchEvent(CritterSummonEvent.onDragEnd, slot1, slot2)
end

function slot0.onFinishSummonAnim(slot0, slot1)
	slot0:dispatchEvent(CritterSummonEvent.onEndSummon, slot1)
end

slot0.instance = slot0.New()

return slot0
