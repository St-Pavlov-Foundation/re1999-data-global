module("modules.logic.bossrush.model.v1a6.V1a6_BossRush_StoreModel", package.seeall)

slot0 = class("V1a6_BossRush_StoreModel", BaseModel)

function slot0.onInit(slot0)
	slot0.goodsInfosDict = nil
end

function slot0.reInit(slot0)
	slot0:onInit()
end

function slot0.getCurrencyIcon(slot0, slot1)
	if CurrencyEnum.CurrencyType.BossRushStore and CurrencyConfig.instance:getCurrencyCo(slot2) then
		return slot3.icon .. "_1"
	end
end

function slot0.getCurrencyCount(slot0, slot1)
	if CurrencyEnum.CurrencyType.BossRushStore and CurrencyModel.instance:getCurrency(slot2) then
		return slot3.quantity
	end

	return 0
end

function slot0.getStoreGroupMO(slot0)
	for slot5, slot6 in pairs(StoreEnum.BossRushStore) do
		-- Nothing
	end

	return {
		[slot6] = StoreModel.instance:getStoreMO(slot6)
	}
end

function slot0.getStoreGroupName(slot0, slot1)
	if StoreConfig.instance:getTabConfig(slot1) then
		return slot2.name, slot2.nameEn
	end
end

function slot0.getUpdateStoreRemainTime(slot0)
	if slot0:getUpdateStoreActivityMo() then
		return slot1:getRemainTimeStr2ByEndTime()
	end

	return ""
end

function slot0.getUpdateStoreActivityMo(slot0)
	if ActivityModel.instance:getActivityInfo()[slot0:checkUpdateStoreActivity()] and ActivityHelper.getActivityStatus(slot1) == ActivityEnum.ActivityStatus.Normal then
		return slot2
	end
end

function slot0.checkUpdateStoreActivity(slot0)
	slot2 = nil

	if slot0:getStoreGroupMO() and slot1[StoreEnum.BossRushStore.UpdateStore] then
		slot8 = slot3

		for slot7, slot8 in pairs(slot3.getGoodsList(slot8)) do
			if not slot2 then
				if slot8.config.activityId ~= 0 then
					slot2 = slot8.config.activityId
				end
			elseif slot2 ~= slot8.config.activityId then
				logError("鬃毛信托特约期汇绑定活动id不一致：" .. "  " .. slot8.config.id)

				return
			end
		end
	end

	return slot2
end

function slot0.checkStoreNewGoods(slot0)
	slot1 = slot0:checkUpdateStoreActivity()

	if slot0:isHasNewGoods() then
		slot0._isHasNewGoods = true
	elseif slot1 then
		slot0._isHasNewGoods = not ActivityEnterMgr.instance:isEnteredActivity(slot1)

		if not slot0._isHasNewGoods then
			slot0._isHasNewGoods = PlayerPrefsHelper.getNumber(slot0:getStoreNewGoodsPrefKey(), 0) == 0
		end
	else
		slot0._isHasNewGoods = false
	end

	return slot0._isHasNewGoods
end

function slot0.setNotNewStoreGoods(slot0)
	PlayerPrefsHelper.setNumber(slot0:getStoreNewGoodsPrefKey(), 1)

	slot0._isHasNewGoods = false
end

function slot0.isHasNewGoodsInStore(slot0)
	return slot0._isHasNewGoods
end

function slot0.getStoreNewGoodsPrefKey(slot0)
	return "V1a6_BossRush_StoreModel_StoreNewGoods_" .. (PlayerModel.instance:getPlayinfo() and slot2.userId or 1999) .. "|" .. (slot0:checkUpdateStoreActivity() or BossRushConfig.instance:getActivityId())
end

function slot0.getStore(slot0)
	return {
		StoreEnum.BossRushStore.NormalStore,
		StoreEnum.BossRushStore.UpdateStore
	}
end

function slot0.saveAllStoreGroupNewData(slot0)
	slot1 = StoreEnum.BossRushStore.NormalStore

	slot0:clearStoreGroupMo(slot1)
	slot0:saveStoreGroupNewMo(slot1)
end

function slot0.readAllStoreGroupNewData(slot0)
	slot0:readStoreGroupNewMo(StoreEnum.BossRushStore.NormalStore)
end

function slot0.saveStoreGroupNewMo(slot0, slot1)
	if not slot0._storeGroupGoodsMo then
		PlayerPrefsHelper.setString(slot0:getStoreGoodsNewDataPrefKey(slot1), "")

		return
	end

	if slot0._storeGroupGoodsMo[slot1] then
		for slot8, slot9 in pairs(slot4) do
			slot3 = slot3 .. string.format("%s#%s#%s|", slot9.goodsId, slot9.limitCount, slot9.isNew and 0 or 1)
		end
	end

	PlayerPrefsHelper.setString(slot2, slot3)
end

function slot0.readStoreGroupNewMo(slot0, slot1)
	slot3 = PlayerPrefsHelper.getString(slot0:getStoreGoodsNewDataPrefKey(slot1), "")

	if not slot0._storeGroupGoodsMo then
		slot0._storeGroupGoodsMo = {}
	end

	slot0._storeGroupGoodsMo[slot1] = {}

	if not slot0:getStoreGroupMO() then
		return
	end

	if not slot4[slot1] then
		return
	end

	for slot10, slot11 in pairs(slot5:getGoodsList()) do
		slot14 = {
			goodsId = slot11.goodsId,
			limitCount = slot11.config.maxBuyCount - slot11.buyCount
		}

		if not string.nilorempty(slot3) then
			slot20 = "#"
			slot16 = nil

			for slot20, slot21 in pairs(GameUtil.splitString2(slot3, true, "|", slot20)) do
				if slot21 and slot21[1] == slot12 then
					if slot21[2] ~= slot13 then
						slot14.isNew = true
					else
						slot14.isNew = slot21[3] == 0
						slot16 = true
					end
				end
			end

			if not slot16 then
				slot14.isNew = true
			end
		else
			slot14.isNew = true
		end

		slot0._storeGroupGoodsMo[slot1][slot12] = slot14
	end
end

function slot0.clearStoreGroupMo(slot0, slot1)
	if slot0._storeGroupGoodsMo and slot0._storeGroupGoodsMo[slot1] then
		for slot6, slot7 in pairs(slot2) do
			slot7.isNew = false
		end
	end
end

function slot0.getStoreGoodsNewData(slot0, slot1, slot2)
	slot3 = slot0._storeGroupGoodsMo and slot0._storeGroupGoodsMo[slot1]

	return slot3 and slot3[slot2]
end

function slot0.isHasNewGoods(slot0)
	if slot0._storeGroupGoodsMo and slot0._storeGroupGoodsMo[StoreEnum.BossRushStore.NormalStore] then
		for slot6, slot7 in pairs(slot2) do
			if slot7.isNew then
				return true
			end
		end
	end
end

function slot0.onClickGoodsItem(slot0, slot1, slot2)
	if slot0:getStoreGoodsNewData(slot1, slot2) then
		slot3.isNew = false
	end
end

function slot0.getStoreGoodsNewDataPrefKey(slot0, slot1)
	return "V1a6_BossRush_StoreModel_StoreGoodsNewData_" .. slot1 .. "_" .. (PlayerModel.instance:getPlayinfo() and slot2.userId or 1999)
end

slot0.instance = slot0.New()

return slot0
