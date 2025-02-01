module("modules.logic.prototest.core.ProtoTestPreSender", package.seeall)

slot0 = class("ProtoTestPreSender", BasePreSender)

function slot0.ctor(slot0)
end

function slot0.preSendSysMsg(slot0, slot1, slot2, slot3)
end

function slot0.preSendProto(slot0, slot1, slot2, slot3)
	if not ProtoEnum.IgnoreCmdList[slot1] then
		slot4 = ProtoTestCaseMO.New()

		slot4:initFromProto(slot1, slot2)
		ProtoTestCaseModel.instance:addAtLast(slot4)
	end
end

return slot0
