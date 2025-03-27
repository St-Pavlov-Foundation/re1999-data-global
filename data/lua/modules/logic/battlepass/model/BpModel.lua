module("modules.logic.battlepass.model.BpModel", package.seeall)

slot0 = class("BpModel", BaseModel)

function slot0.onInit(slot0)
	slot0.preStatus = nil
	slot0.animProcess = 0
	slot0.animData = nil
	slot0.isViewLoading = nil
	slot0.lockLevelUpShow = false
	slot0.cacheBonus = nil
	slot0.firstShowSp = nil
end

function slot0.reInit(slot0)
	slot0._hasGetInfo = nil
	slot0.firstShow = nil
	slot0.firstShowSp = nil
	slot0.lockAlertBonus = nil

	slot0:onInit()
end

function slot0.onGetInfo(slot0, slot1)
	slot0._hasGetInfo = true
	slot0.id = slot1.id
	slot0.score = slot1.score
	slot0.payStatus = slot1.payStatus
	slot0.startTime = slot1.startTime
	slot0.endTime = slot1.endTime
	slot0.weeklyScore = slot1.weeklyScore
	slot0.firstShow = slot1.firstShow
	slot0.firstShowSp = slot1.spFirstShow
end

function slot0.hasGetInfo(slot0)
	return slot0._hasGetInfo
end

function slot0.isEnd(slot0)
	if not slot0._hasGetInfo or slot0.endTime == 0 then
		return true
	end

	return false
end

function slot0.updateScore(slot0, slot1, slot2)
	slot0.score = slot1
	slot0.weeklyScore = slot2
end

function slot0.updatePayStatus(slot0, slot1)
	slot0.payStatus = slot1
end

function slot0.onBuyLevel(slot0, slot1)
	slot0.score = slot1
end

function slot0.buildChargeFlow(slot0)
	if not slot0._chargeFlow then
		slot0._chargeFlow = BpChargeFlow.New()
	end

	slot0._chargeFlow:registerDoneListener(slot0.clearFlow, slot0)
	slot0._chargeFlow:buildFlow()
end

function slot0.isInFlow(slot0)
	return slot0._chargeFlow and true or false
end

function slot0.clearFlow(slot0)
	if slot0._chargeFlow then
		slot0._chargeFlow:onDestroyInternal()

		slot0._chargeFlow = nil
	end
end

function slot0.isWeeklyScoreFull(slot0)
	return uv0.instance:getWeeklyMaxScore() <= (slot0.weeklyScore or 0)
end

function slot0.getBpChargeLeftSec(slot0)
	if not lua_bp.configDict[uv0.instance.id] then
		return
	end

	if not StoreConfig.instance:getChargeGoodsConfig(slot1.chargeId1) then
		return
	end

	if type(slot2.offlineTime) == "number" then
		return slot2.offlineTime - ServerTime.now()
	end
end

function slot0.isBpChargeEnd(slot0)
	if slot0:getBpChargeLeftSec() and slot1 < 0 then
		return true
	else
		return false
	end
end

function slot0.checkLevelUp(slot0, slot1, slot2)
	return math.floor((slot2 or slot0.score) / slot3) < math.floor(slot1 / BpConfig.instance:getLevelScore(slot0.id))
end

function slot0.getBpLv(slot0, slot1)
	return math.floor((slot1 or slot0.score or 0) / BpConfig.instance:getLevelScore(slot0.id))
end

function slot0.isShowExpUp(slot0)
	if not BpConfig.instance:getBpCO(slot0.id or 0) then
		return false
	end

	return slot1 and slot1.expUpShow or false
end

function slot0.getWeeklyMaxScore(slot0)
	if not BpConfig.instance:getBpCO(slot0.id or 0) then
		return CommonConfig.instance:getConstNum(ConstEnum.BpWeeklyMaxScore)
	end

	if 1000 + (slot2.weekLimitTimes or 0) > 1000 then
		slot1 = math.floor(slot3 * slot1 / 1000)
	end

	return slot1
end

function slot0.checkGet50FreeBonus(slot0, slot1)
	if slot0:isEnd() or slot0.payStatus ~= BpEnum.PayStatus.NotPay then
		return false
	end

	if BpBonusModel.instance.serverBonusModel:getById(50) and slot2.hasGetfreeBonus then
		return false
	end

	for slot6, slot7 in ipairs(slot1) do
		if slot7.level == 50 and slot7.hasGetfreeBonus then
			return true
		end
	end

	return false
end

slot0.instance = slot0.New()

return slot0
