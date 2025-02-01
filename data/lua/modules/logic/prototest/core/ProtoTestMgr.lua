module("modules.logic.prototest.core.ProtoTestMgr", package.seeall)

slot0 = class("ProtoTestMgr")

function slot0.ctor(slot0)
	slot0.isShowFiles = false
	slot0._isRecording = false
	slot0._preSender = ProtoTestPreSender.New()

	LuaEventSystem.addEventMechanism(slot0)
end

function slot0.startRecord(slot0)
	slot0._isRecording = true

	LuaSocketMgr.instance:registerPreSender(slot0._preSender)
end

function slot0.endRecord(slot0)
	slot0._isRecording = false

	LuaSocketMgr.instance:unregisterPreSender(slot0._preSender)
end

function slot0.isRecording(slot0)
	return slot0._isRecording
end

function slot0.readFromFile(slot0, slot1)
	SLFramework.FileHelper.EnsureDir(ProtoFileHelper.DirPath)

	slot5 = {}

	for slot9, slot10 in ipairs(cjson.decode(SLFramework.FileHelper.ReadText(ProtoFileHelper.getFullPathByFileName(slot1)))) do
		slot11 = ProtoTestCaseMO.New()

		slot11:deserialize(slot10)
		table.insert(slot5, slot11)
	end

	return slot5
end

function slot0.saveToFile(slot0, slot1, slot2)
	SLFramework.FileHelper.EnsureDir(ProtoFileHelper.DirPath)

	slot3 = ProtoFileHelper.getFullPathByFileName(slot1)
	slot4 = {}

	for slot8, slot9 in ipairs(slot2) do
		table.insert(slot4, slot9:serialize())
	end

	SLFramework.FileHelper.WriteTextToPath(slot3, cjson.encode(slot4))
end

slot0.instance = slot0.New()

return slot0
