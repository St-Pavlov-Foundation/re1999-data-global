module("modules.logic.sdk.model.SDKModel", package.seeall)

slot0 = class("SDKModel", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()

	slot0._isDmm = SDKMgr.instance:getChannelId() == "301"
end

function slot0.reInit(slot0)
	slot0._baseProperties = {}

	slot0:_modifyTrackDefine()
end

function slot0.isDmm(slot0)
	return slot0._isDmm
end

function slot0._updateBaseProperties(slot0)
	if string.nilorempty(SDKDataTrackMgr.instance:getDataTrackProperties()) then
		slot1 = cjson.encode(StatEnum.DefaultBaseProperties)
	end

	slot0._baseProperties = cjson.decode(slot1)

	StatRpc.instance:sendUpdateClientStatBaseInfoRequest(slot1)
end

function slot0.updateBaseProperties(slot0, slot1, slot2)
	slot0:_updateBaseProperties()
	SDKController.instance:dispatchEvent(SDKEvent.BasePropertiesChange, slot1, slot2)
end

function slot0.isVistor(slot0)
	return SDKMgr.instance:getUserType() == SDKEnum.AccountType.Guest
end

function slot0.setAccountBindBonus(slot0, slot1)
	slot0.accountBindBonus = slot1

	if slot0.accountBindBonus and slot2 ~= slot1 then
		SDKController.instance:dispatchEvent(SDKEvent.UpdateAccountBindBonus, slot2, slot1)
	end
end

function slot0.getAccountBindBonus(slot0)
	return slot0.accountBindBonus or SDKEnum.RewardType.None
end

function slot0._modifyTrackDefine(slot0)
	slot0:_modifyTrackDefine_EventName()
	slot0:_modifyTrackDefine_EventProperties()
	slot0:_modifyTrackDefine_PropertyTypes()
end

function slot0._modifyTrackDefine_EventName(slot0)
	SDKDataTrackMgr.EventName.summon_client = "summon_client"
end

function slot0._modifyTrackDefine_EventProperties(slot0)
	slot1 = SDKDataTrackMgr.EventProperties
	slot1.poolid = "poolid"
	slot1.entrance = "entrance"
	slot1.position_list = "position_list"
end

function slot0._modifyTrackDefine_PropertyTypes(slot0)
	slot1 = SDKDataTrackMgr.PropertyTypes
	slot2 = SDKDataTrackMgr.EventProperties
	slot1[slot2.poolid] = "number"
	slot1[slot2.entrance] = "string"
	slot1[slot2.position_list] = "string"
end

slot0.instance = slot0.New()

return slot0
