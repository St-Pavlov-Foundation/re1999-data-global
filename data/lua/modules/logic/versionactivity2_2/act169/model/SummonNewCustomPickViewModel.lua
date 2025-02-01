module("modules.logic.versionactivity2_2.act169.model.SummonNewCustomPickViewModel", package.seeall)

slot0 = class("SummonNewCustomPickViewModel", BaseModel)
slot0.DEFAULT_HERO_ID = 0
slot0.MAX_SELECT_COUNT = 1

function slot0.onInit(slot0)
	slot0._activityMoDic = {}
	slot0._showFx = {}
end

function slot0.reInit(slot0)
	slot0._activityMoDic = {}
	slot0._showFx = {}
end

function slot0.onGetInfo(slot0, slot1, slot2)
	slot0:setReward(slot1, slot2)
end

function slot0.getHaveFirstDayLogin(slot0, slot1)
	return TimeUtil.getDayFirstLoginRed(slot0:getDaliyLoginKey(slot1))
end

function slot0.setHaveFirstDayLogin(slot0, slot1)
	TimeUtil.setDayFirstLoginRed(slot0:getDaliyLoginKey(slot1))
end

function slot0.getDaliyLoginKey(slot0, slot1)
	return PlayerPrefsKey.Version2_2SummonNewCustomPatFace .. tostring(slot1)
end

function slot0.setCurActId(slot0, slot1)
	slot0._actId = slot1

	SummonNewCustomPickChoiceController.instance:onSelectActivity(slot1)
end

function slot0.getCurActId(slot0)
	return slot0._actId
end

function slot0.setReward(slot0, slot1, slot2)
	if slot0:getActivityInfo(slot1) then
		slot3.heroId = slot2
	end

	slot0._activityMoDic[slot1] = SummonNewCustomPickViewMo.New(slot1, slot2)
end

function slot0.setSelect(slot0, slot1, slot2)
	if not slot0:getActivityInfo(slot1) then
		return
	end

	if slot0:isSelect(slot3) then
		return
	end

	slot3.selectId = slot2
end

function slot0.getMaxSelectCount(slot0)
	return slot0.MAX_SELECT_COUNT
end

function slot0.getSummonPickScope(slot0, slot1)
	return SummonNewCustomPickViewConfig.instance:getSummonConfigById(slot1).heroIds
end

function slot0.getSummonInfo(slot0, slot1)
	SummonNewCustomPickViewRpc.instance:sendGet169InfoRequest(slot1)
end

function slot0.isSelect(slot0, slot1)
	if slot0:getActivityInfo(slot1) == nil then
		return false
	end

	return slot0:isMoSelect(slot2)
end

function slot0.isActivityOpen(slot0, slot1)
	slot2 = ServerTime.now() * 1000

	if not slot1 or not ActivityModel.instance:isActOnLine(slot1) then
		return false
	end

	if slot2 < ActivityModel.instance:getActStartTime(slot1) then
		return false
	end

	if ActivityModel.instance:getActEndTime(slot1) <= slot2 then
		return false
	end

	return true
end

function slot0.isMoSelect(slot0, slot1)
	return slot1.activityId ~= uv0.DEFAULT_HERO_ID
end

function slot0.isNewbiePoolExist(slot0)
	return SummonMainModel.instance:getNewbiePoolExist()
end

function slot0.isGetReward(slot0, slot1)
	if slot0:getActivityInfo(slot1) == nil then
		return false
	end

	return slot2.heroId ~= slot0.DEFAULT_HERO_ID
end

function slot0.getActivityInfo(slot0, slot1)
	return slot0._activityMoDic[slot1]
end

function slot0.setGetRewardFxState(slot0, slot1, slot2)
	slot0._showFx[slot1] = slot2
end

function slot0.getGetRewardFxState(slot0, slot1)
	return slot0._showFx[slot1] and true or false
end

slot0.instance = slot0.New()

return slot0
