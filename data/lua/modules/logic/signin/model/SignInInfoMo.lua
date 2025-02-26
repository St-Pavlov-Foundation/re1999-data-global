module("modules.logic.signin.model.SignInInfoMo", package.seeall)

slot0 = pureTable("SignInInfoMo")

function slot0.ctor(slot0)
	slot0.hasSignInDays = {}
	slot0.addupSignInDay = 0
	slot0.hasGetAddupBonus = {}
	slot0.openFunctionTime = 0
	slot0.hasMonthCardDays = {}
	slot0.monthCardHistory = {}
	slot0.birthdayHeroIds = {}
end

function slot0.init(slot0, slot1)
	slot0.hasSignInDays = slot0:_getListInfo(slot1.hasSignInDays)
	slot0.addupSignInDay = slot1.addupSignInDay
	slot0.hasGetAddupBonus = slot0:_getListInfo(slot1.hasGetAddupBonus)
	slot0.openFunctionTime = slot1.openFunctionTime
	slot0.hasMonthCardDays = slot0:_getListInfo(slot1.hasMonthCardDays)
	slot0.monthCardHistory = slot0:_getListInfo(slot1.monthCardHistory, SignInMonthCardHistoryMo)
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

function slot0.addSignInfo(slot0, slot1)
	table.insert(slot0.hasSignInDays, slot1.day)

	for slot5, slot6 in ipairs(slot1.birthdayHeroIds) do
		table.insert(slot0.birthdayHeroIds, slot6)
	end
end

function slot0.getSignDays(slot0)
	return slot0.hasSignInDays
end

function slot0.clearSignInDays(slot0)
	slot0.hasSignInDays = {}
end

function slot0.addSignTotalIds(slot0, slot1)
	table.insert(slot0.hasGetAddupBonus, slot1)
end

function slot0.addBirthdayHero(slot0, slot1)
	table.insert(slot0.birthdayHeroIds, slot1)
end

return slot0
