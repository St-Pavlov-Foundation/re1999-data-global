module("modules.logic.seasonver.act123.model.Season123EntryModel", package.seeall)

slot0 = class("Season123EntryModel", BaseModel)

function slot0.release(slot0)
end

function slot0.init(slot0, slot1)
	slot0.activityId = slot1
	slot0._currentStage = 1
	slot0._currentStageIndex = 1

	slot0:initDatas()
	slot0:initDefaultStage()
end

function slot0.getActId(slot0)
	return slot0.activityId
end

function slot0.initDatas(slot0)
	slot0.userId = PlayerModel.instance:getMyUserId()

	if not Season123Model.instance:getActInfo(slot0.activityId) then
		logError("Not available season123 data! actId = " .. tostring(slot0.activityId))

		return
	end

	if Season123Config.instance:getStageCos(slot0.activityId) and #slot2 > 0 then
		slot3 = 1
		slot0._currentStage = slot2[slot3].stage
		slot0._currentStageIndex = slot3
	end
end

function slot0.initDefaultStage(slot0)
	if not Season123Model.instance:getActInfo(slot0.activityId) then
		return
	end

	if slot1.stage ~= 0 and Season123ProgressUtils.stageInChallenge(slot0.activityId, slot1.stage) then
		slot0:setCurrentStage(slot1.stage)
	else
		for slot6, slot7 in ipairs(Season123Config.instance:getStageCos(slot0.activityId)) do
			if slot1:getStageMO(slot7.stage) and slot8:isNeverTry() then
				slot0:setCurrentStage(slot7.stage)
			end
		end
	end
end

function slot0.getStageMO(slot0, slot1)
	if not Season123Model.instance:getActInfo(slot0.activityId) then
		return nil
	end

	return slot2:getStageMO(slot1)
end

function slot0.getPrevStage(slot0)
	if not Season123Config.instance:getStageCos(slot0.activityId) then
		return
	end

	if slot0._currentStageIndex > 1 then
		return slot1[slot0._currentStageIndex - 1].stage
	end
end

function slot0.getNextStage(slot0)
	if not Season123Config.instance:getStageCos(slot0.activityId) then
		return
	end

	if slot0._currentStageIndex < #slot1 then
		return slot1[slot0._currentStageIndex + 1].stage
	end
end

function slot0.getCurrentStage(slot0)
	return slot0._currentStage
end

function slot0.getCurrentStageIndex(slot0)
	return slot0._currentStageIndex
end

function slot0.setCurrentStage(slot0, slot1)
	if slot0._currentStage == slot1 then
		return
	end

	if not Season123Config.instance:getStageCos(slot0.activityId) then
		return
	end

	for slot6 = 1, #slot2 do
		if slot2[slot6].stage == slot1 then
			slot0._currentStageIndex = slot6
			slot0._currentStage = slot1

			return
		end
	end
end

function slot0.getUTTUTicketNum(slot0)
	if CurrencyConfig.instance:getCurrencyCo(Season123Config.instance:getEquipItemCoin(slot0.activityId, Activity123Enum.Const.UttuTicketsCoin)) then
		return ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Currency, slot1), slot2.recoverLimit
	else
		return nil, 
	end
end

function slot0.isFirstOpen(slot0)
	if not string.nilorempty(slot0:getLocalKey()) then
		return string.nilorempty(PlayerPrefsHelper.getString(slot1, ""))
	end
end

function slot0.setAlreadyVisited(slot0, slot1)
	if not string.nilorempty(slot0:getLocalKey(slot1)) then
		PlayerPrefsHelper.setString(slot2, "1")
	end
end

function slot0.getLocalKey(slot0, slot1)
	if not slot0._localKey then
		if not PlayerModel.instance:getPlayinfo() or slot2.userId == 0 then
			return nil
		end

		slot0._localKey = "Season123EntryModel#FirstEntry#" .. tostring(slot2.userId) .. "#" .. tostring(slot1)
	end

	return slot0._localKey
end

function slot0.getTrialCO(slot0)
	if Season123Model.instance:getActInfo(slot0.activityId) and slot1.trial ~= 0 then
		return Season123Config.instance:getTrialCO(slot0.activityId, slot1.trial)
	end

	return nil
end

function slot0.isRetailOpen(slot0)
	slot1 = Season123Config.instance:getSeasonConstNum(slot0.activityId, Activity123Enum.Const.RetailOpenStage)

	if not Season123Model.instance:getActInfo(slot0.activityId) then
		return false
	end

	if slot2:getStageMO(slot1) then
		return slot3.isPass
	else
		return false
	end
end

function slot0.getRandomRetailRes(slot0)
	slot1 = slot0 % #SeasonEntryEnum.ResPath + 1

	return slot1, SeasonEntryEnum.ResPath[slot1]
end

function slot0.stageIsPassed(slot0, slot1)
	if not Season123Model.instance:getActInfo(slot0.activityId) then
		return false
	end

	return slot2.stageMap[slot1] and slot3.isPass
end

function slot0.needPlayUnlockAnim(slot0, slot1, slot2)
	if not string.nilorempty(slot0:getUnlockKey(slot1, slot2)) then
		return string.nilorempty(PlayerPrefsHelper.getString(slot3, ""))
	end
end

function slot0.setAlreadyUnLock(slot0, slot1, slot2)
	if not string.nilorempty(slot0:getUnlockKey(slot1, slot2)) then
		PlayerPrefsHelper.setString(slot3, "1")
	end
end

function slot0.getUnlockKey(slot0, slot1, slot2)
	return "EntryViewStageUnlock" .. tostring(slot0.userId) .. "#" .. tostring(slot1) .. tostring(slot2)
end

function slot0.needPlayUnlockAnim1(slot0, slot1, slot2)
	if not string.nilorempty(slot0:getUnlockKey1(slot1, slot2)) then
		return string.nilorempty(PlayerPrefsHelper.getString(slot3, ""))
	end
end

function slot0.setAlreadyUnLock1(slot0, slot1, slot2)
	if not string.nilorempty(slot0:getUnlockKey1(slot1, slot2)) then
		PlayerPrefsHelper.setString(slot3, "1")
	end
end

function slot0.getUnlockKey1(slot0, slot1, slot2)
	return "EntryOverviewStageUnlock" .. tostring(slot0.userId) .. "#" .. tostring(slot1) .. tostring(slot2)
end

slot0.instance = slot0.New()

return slot0
