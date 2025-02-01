module("modules.logic.versionactivity2_4.act181.model.Activity181Model", package.seeall)

slot0 = class("Activity181Model", BaseModel)

function slot0.onInit(slot0)
	slot0._activityInfoDic = {}
end

function slot0.reInit(slot0)
	slot0._activityInfoDic = {}
end

function slot0.setActInfo(slot0, slot1, slot2)
	if not slot2 or not slot1 then
		return
	end

	if not slot0._activityInfoDic[slot1] then
		slot0._activityInfoDic[slot1] = Activity181MO.New()
	end

	slot3:setInfo(slot2)
end

function slot0.getActivityInfo(slot0, slot1)
	return slot0._activityInfoDic[slot1]
end

function slot0.setBonusInfo(slot0, slot1, slot2)
	if not slot2 or not slot1 then
		return
	end

	if not slot0:getActivityInfo(slot1) then
		return
	end

	slot3:setBonusInfo(slot2.pos, slot2.id)
end

function slot0.setSPBonusInfo(slot0, slot1)
	if not slot1 then
		return
	end

	if not slot0:getActivityInfo(slot1) then
		return
	end

	slot2:setSPBonusInfo()
end

function slot0.addBonusTimes(slot0, slot1)
	if not slot1 then
		return
	end

	if not slot0:getActivityInfo(slot1) then
		return
	end

	slot2:setBonusTimes(slot2:getBonusTimes() + 1)
	Activity181Controller.instance:dispatchEvent(Activity181Event.BonusTimesChange, slot1)
end

function slot0.isActivityInTime(slot0, slot1)
	if not ActivityModel.instance:getActMO(slot1) then
		return false
	end

	if not slot2:isOpen() or slot2:isExpired() then
		return false
	end

	return true
end

function slot0.getHaveFirstDayLogin(slot0, slot1)
	return TimeUtil.getDayFirstLoginRed(slot0:getDaliyLoginKey(slot1))
end

function slot0.setHaveFirstDayLogin(slot0, slot1)
	TimeUtil.setDayFirstLoginRed(slot0:getDaliyLoginKey(slot1))
end

function slot0.getDaliyLoginKey(slot0, slot1)
	return PlayerPrefsKey.Version2_4_Act181FirstOpen .. tostring(slot1)
end

function slot0.setPopUpPauseState(slot0, slot1)
	slot0._popUpState = slot1

	PopupController.instance:setPause("Activity181MainView_bonus", slot1)
end

function slot0.getPopUpPauseState(slot0)
	return slot0._popUpState
end

slot0.instance = slot0.New()

return slot0
