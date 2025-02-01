module("modules.logic.signin.model.SignInHeroBirthdayInfoMo", package.seeall)

slot0 = pureTable("SignInHeroBirthdayInfoMo")

function slot0.ctor(slot0)
	slot0.heroId = 0
	slot0.birthdayCount = 0
end

function slot0.init(slot0, slot1)
	slot0.heroId = slot1.heroId
	slot0.birthdayCount = slot1.birthdayCount
end

function slot0.reset(slot0, slot1)
	slot0.heroId = slot1.heroId
	slot0.birthdayCount = slot1.birthdayCount
end

function slot0.addBirthdayCount(slot0)
	slot0.birthdayCount = slot0.birthdayCount + 1
end

return slot0
