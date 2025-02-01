module("modules.logic.signin.model.SignInMonthCardHistoryMo", package.seeall)

slot0 = pureTable("SignInMonthCardHistoryMo")

function slot0.ctor(slot0)
	slot0.id = 0
	slot0.startTime = 0
	slot0.endTime = 0
end

function slot0.init(slot0, slot1)
	slot0.id = slot1.id
	slot0.startTime = slot1.startTime
	slot0.endTime = slot1.endTime
end

return slot0
