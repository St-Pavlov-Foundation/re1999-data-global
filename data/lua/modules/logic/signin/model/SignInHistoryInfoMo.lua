module("modules.logic.signin.model.SignInHistoryInfoMo", package.seeall)

slot0 = pureTable("SignInHistoryInfoMo")

function slot0.ctor(slot0)
	slot0.month = 1
	slot0.hasSignInDays = {}
	slot0.hasMonthCardDays = {}
	slot0.birthdayHeroIds = {}
end

function slot0.init(slot0, slot1)
	slot0.month = slot1.month
	slot0.hasSignInDays = slot0:_getListInfo(slot1.hasSignInDays)
	slot0.hasMonthCardDays = slot0:_getListInfo(slot1.hasMonthCardDays)
	slot0.birthdayHeroIds = slot0:_getListInfo(slot1.birthdayHeroIds)
end

function slot0._getListInfo(slot0, slot1, slot2)
	slot3 = {}

	for slot8 = 1, slot1 and #slot1 or 0 do
		slot9 = slot1[slot8]

		if slot2 then
			slot2.New():init(slot1[slot8])
		end

		table.insert(slot3, slot9)
	end

	return slot3
end

return slot0
