module("modules.logic.versionactivity2_4.pinball.model.PinballCurrencyMo", package.seeall)

slot0 = pureTable("PinballCurrencyMo")

function slot0.init(slot0, slot1)
	slot0.type = slot1.type
	slot0.num = slot1.num
	slot0.changeNum = slot1.changeNum
end

return slot0
