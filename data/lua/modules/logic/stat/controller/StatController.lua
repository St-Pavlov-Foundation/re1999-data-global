module("modules.logic.stat.controller.StatController", package.seeall)

slot0 = class("StatController", BaseController)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.sendBaseProperties(slot0)
	slot1 = ""

	if string.nilorempty(SDKDataTrackMgr.instance:getDataTrackProperties()) then
		slot1 = cjson.encode(StatEnum.DefaultBaseProperties)
	end

	logNormal(slot1)
	StatModel.instance:updateBaseProperties(slot1)
	StatRpc.instance:sendClientStatBaseInfoRequest(slot1)
end

function slot0.onLogin(slot0)
	slot0:sendBaseProperties()
	SDKDataTrackMgr.instance:roleLogin(tostring(PlayerModel.instance:getMyUserId()))

	if not string.nilorempty(PlayerModel.instance:getPlayinfo().name) then
		SDKMgr.instance:enterGame(StatModel.instance:generateRoleInfo())
	end
end

function slot0.setUserProperties(slot0, slot1)
	SDKDataTrackMgr.instance:profileSet(slot1)
end

function slot0.track(slot0, slot1, slot2)
	slot2 = slot2 or {}

	for slot7, slot8 in pairs(StatModel.instance:getEventCommonProperties()) do
		slot2[slot7] = slot8
	end

	slot4 = {}

	for slot8, slot9 in pairs(slot2) do
		if not string.nilorempty(StatEnum.PropertyTypes[slot8]) and type(slot9) ~= SDKDataTrackMgr.DefinedTypeToLuaType[slot10] then
			logError(string.format("埋点 属性类型不一致, propertyName: %s, param: %s, currentType: %s, definedType: %s", tostring(slot8), tostring(slot9), type(slot9), SDKDataTrackMgr.DefinedTypeToLuaType[slot10]))
		end

		if slot10 == "array" or slot10 == "list" then
			JsonUtil.markAsArray(slot9)
		end

		if slot10 == "array" and #slot9 <= 0 then
			table.insert(slot4, slot8)
		end
	end

	for slot8, slot9 in ipairs(slot4) do
		slot2[slot9] = nil
	end

	SDKDataTrackMgr.instance:track(slot1, slot2)
end

function slot0.onInitFinish(slot0)
end

slot0.instance = slot0.New()

return slot0
