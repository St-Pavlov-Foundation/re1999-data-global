module("modules.logic.prototest.model.ProtoTestCaseMO", package.seeall)

slot0 = pureTable("ProtoTestCaseMO")

function slot0.ctor(slot0)
	slot0.cmd = nil
	slot0.time = nil
	slot0.struct = nil
	slot0.value = nil
end

function slot0.initFromProto(slot0, slot1, slot2)
	slot0.cmd = slot1
	slot0.time = ServerTime.now()
	slot0.struct = slot2.__cname
	slot0.value = ProtoParamHelper.buildProtoParamsByProto(slot2)
end

function slot0.initFromJson(slot0, slot1)
end

function slot0.clone(slot0)
	slot1 = uv0.New()
	slot1.cmd = slot0.cmd
	slot1.time = ServerTime.now()
	slot1.struct = slot0.struct
	slot1.value = {}

	for slot5, slot6 in ipairs(slot0.value) do
		table.insert(slot1.value, slot6:clone())
	end

	return slot1
end

function slot0.buildProtoMsg(slot0)
	if not LuaSocketMgr.instance:getCmdSetting(slot0.cmd) then
		logError("module not exist, cmd = " .. slot0.cmd)

		return
	end

	if not (getGlobal(slot1[1] .. "Module_pb") or addGlobalModule("modules.proto." .. slot2, slot2)) then
		logError(string.format("pb not exist: %s.%s", slot2, slot0.struct))

		return
	end

	slot5 = slot3[slot0.struct]()

	for slot9, slot10 in ipairs(slot0.value) do
		slot10:fillProtoMsg(slot5)
	end

	return slot5
end

function slot0.serialize(slot0)
	slot1 = {
		cmd = slot0.cmd,
		time = slot0.time,
		struct = slot0.struct,
		value = {}
	}

	for slot5, slot6 in ipairs(slot0.value) do
		table.insert(slot1.value, slot6:serialize())
	end

	return slot1
end

function slot0.deserialize(slot0, slot1)
	slot0.cmd = slot1.cmd
	slot0.time = slot1.time
	slot0.struct = slot1.struct
	slot0.value = {}

	for slot5, slot6 in ipairs(slot1.value) do
		slot7 = ProtoTestCaseParamMO.New()

		slot7:deserialize(slot6)
		table.insert(slot0.value, slot7)
	end
end

return slot0
