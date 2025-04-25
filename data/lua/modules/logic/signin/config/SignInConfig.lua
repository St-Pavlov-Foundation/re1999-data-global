module("modules.logic.signin.config.SignInConfig", package.seeall)

slot0 = class("SignInConfig", BaseConfig)

function slot0.ctor(slot0)
	slot0._signMonthRewards = nil
	slot0._signRewards = nil
	slot0._signDesc = nil
	slot0._goldRewards = nil
end

function slot0.reqConfigNames(slot0)
	return {
		"sign_in_addup_bonus",
		"sign_in_bonus",
		"sign_in_word",
		"activity143_bonus",
		"sign_in_lifetime_bonus"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "sign_in_addup_bonus" then
		slot0._signMonthRewards = slot2
	elseif slot1 == "sign_in_bonus" then
		slot0._signRewards = slot2
	elseif slot1 == "sign_in_word" then
		slot0._signDesc = slot2
	elseif slot1 == "activity143_bonus" then
		slot0._goldRewards = slot2
	end
end

function slot0.getSignMonthReward(slot0, slot1)
	return slot0._signMonthRewards.configDict[slot1]
end

function slot0.getSignMonthRewards(slot0)
	return slot0._signMonthRewards.configDict
end

function slot0.getSignRewards(slot0, slot1)
	return slot0._signRewards.configDict[slot1]
end

function slot0.getSignDesc(slot0, slot1)
	return slot0._signDesc.configDict[slot1]
end

function slot0.getGoldReward(slot0, slot1)
	for slot5, slot6 in pairs(slot0._goldRewards.configDict[ActivityEnum.Activity.DailyAllowance]) do
		if slot6.day == slot1 then
			return slot6.bonus
		end
	end
end

function slot0.getSignDescByDate(slot0, slot1)
	for slot6, slot7 in pairs(slot0._signDesc.configDict) do
		if slot7.signindate == os.date("%Y-%m-%d 00:00:00", slot1) then
			return slot7.signinword
		end
	end
end

function slot0.getSignInLifeTimeBonusCO(slot0, slot1)
	return lua_sign_in_lifetime_bonus.configList[slot1]
end

function slot0.getSignInLifeTimeBonusCount(slot0)
	return #lua_sign_in_lifetime_bonus.configList
end

slot0.instance = slot0.New()

return slot0
