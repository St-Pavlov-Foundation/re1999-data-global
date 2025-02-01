module("modules.logic.prototest.model.ProtoReqListModel", package.seeall)

slot0 = class("ProtoReqListModel", ListScrollModel)

function slot0.onInit(slot0)
	slot0._reqList = nil
end

function slot0.getFilterList(slot0, slot1)
	slot0:_checkInitReqList()

	slot2 = {}
	slot1 = string.lower(slot1)

	for slot6, slot7 in ipairs(slot0._reqList) do
		if string.nilorempty(slot1) or string.find(slot7.cmdStr, slot1) or string.find(slot7.reqLower, slot1) or string.find(slot7.moduleLower, slot1) then
			table.insert(slot2, slot7)
		end
	end

	return slot2
end

function slot0._checkInitReqList(slot0)
	if slot0._reqList then
		return
	end

	slot0._reqList = {}

	if LuaSocketMgr.instance:getCmdSettingDict() then
		for slot5, slot6 in pairs(slot1) do
			if #slot6 >= 3 then
				table.insert(slot0._reqList, {
					cmd = slot5,
					cmdStr = tostring(slot5),
					req = slot6[2],
					reqLower = string.lower(slot6[2]),
					module = slot6[1],
					moduleLower = string.lower(slot6[1])
				})
			end
		end
	else
		logError("init cmd RequestList fail, module_cmd not exist")
	end
end

slot0.instance = slot0.New()

return slot0
