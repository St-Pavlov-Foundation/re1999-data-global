module("modules.logic.backpack.model.BackpackMo", package.seeall)

slot0 = pureTable("BackpackMo")

function slot0.ctor(slot0)
	slot0.id = 0
	slot0.uid = 0
	slot0.type = 0
	slot0.subType = 0
	slot0.icon = ""
	slot0.quantity = 0
	slot0.icon = ""
	slot0.rare = 0
	slot0.isStackable = false
	slot0.isShow = false
	slot0.isTimeShow = 0
	slot0.deadline = 0
	slot0.expireTime = -1
end

function slot0.init(slot0, slot1)
	slot0.id = slot1.id
	slot0.uid = slot1.uid
	slot0.type = slot1.type
	slot0.subType = slot1.subType == nil and 0 or slot1.subType
	slot0.quantity = slot1.quantity
	slot0.icon = slot1.icon
	slot0.rare = slot1.rare
	slot0.isStackable = slot1.isStackable == nil and 1 or slot1.isStackable
	slot0.isShow = slot1.isShow == nil and 1 or slot1.isShow
	slot0.isTimeShow = slot1.isTimeShow == nil and 0 or slot1.isTimeShow
	slot0.expireTime = slot1.expireTime and slot1.expireTime or -1
end

function slot0.itemExpireTime(slot0)
	if slot0.expireTime == nil or slot0.expireTime == -1 or slot0.expireTime == "" then
		return -1
	end

	if type(slot0.expireTime) == "number" then
		return slot0.expireTime
	else
		return TimeUtil.stringToTimestamp(slot0.expireTime)
	end
end

return slot0
