module("modules.logic.bgmswitch.model.BGMSwitchInfoMo", package.seeall)

slot0 = pureTable("BGMSwitchInfoMo")

function slot0.ctor(slot0)
	slot0.bgmId = 0
	slot0.unlock = 0
	slot0.favorite = false
	slot0.isRead = false
end

function slot0.init(slot0, slot1)
	slot0.bgmId = slot1.bgmId
	slot0.unlock = slot1.unlock
	slot0.favorite = slot1.favorite
	slot0.isRead = slot1.isRead
end

function slot0.reset(slot0, slot1)
	slot0.bgmId = slot1.bgmId
	slot0.unlock = slot1.unlock
	slot0.favorite = slot1.favorite
	slot0.isRead = slot1.isRead
end

return slot0
