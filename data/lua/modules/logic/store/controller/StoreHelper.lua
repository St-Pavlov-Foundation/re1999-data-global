module("modules.logic.store.controller.StoreHelper", package.seeall)

slot0 = class("StoreHelper", BaseController)

function slot0.getRecommendStoreSecondTabConfig()
	slot1 = {}
	slot2 = {}

	if StoreModel.instance:getRecommendSecondTabs(StoreEnum.RecommendStore, true) and #slot0 > 0 then
		slot4 = {
			[slot9.id] = slot9
		}

		for slot8, slot9 in ipairs(SummonMainModel.getValidPools()) do
			-- Nothing
		end

		for slot8 = 1, #slot0 do
			if StoreConfig.instance:getStoreRecommendConfig(slot0[slot8].id) == nil then
				table.insert(slot1, slot0[slot8])
			elseif uv0._inOpenTime(slot9) then
				slot10, slot11, slot12 = uv0._checkRelations(slot9.relations, slot0, slot4)

				for slot16, slot17 in pairs(slot12) do
					slot2[slot16] = true
				end

				if slot10 then
					table.insert(slot1, slot0[slot8])
				end
			end
		end
	end

	slot3 = {}

	for slot7, slot8 in pairs(slot2) do
		table.insert(slot3, slot7)
	end

	return slot1, slot3
end

function slot0._inOpenTime(slot0)
	slot1 = ServerTime.now()

	return slot0.isOffline == 0 and (string.nilorempty(slot0.onlineTime) and slot1 or TimeUtil.stringToTimestamp(slot0.onlineTime)) <= slot1 and slot1 <= (string.nilorempty(slot0.offlineTime) and slot1 or TimeUtil.stringToTimestamp(slot0.offlineTime))
end

function slot0.getRecommendStoreGroup(slot0, slot1)
	if slot1 then
		if slot0.topType == StoreEnum.AdjustOrderType.MonthCard then
			if StoreModel.instance:getMonthCardInfo() ~= nil and StoreEnum.MonthCardStatus.NotPurchase <= slot3:getRemainDay() then
				return StoreEnum.GroupOrderType.GroupD
			end
		elseif slot2 == StoreEnum.AdjustOrderType.BattlePass and BpModel.instance.payStatus ~= BpEnum.PayStatus.NotPay then
			return StoreEnum.GroupOrderType.GroupD
		end
	end

	if slot0.topDay < 0 then
		return StoreEnum.GroupOrderType.GroupA
	elseif slot0.topDay == 0 then
		return StoreEnum.GroupOrderType.GroupC
	elseif not uv0._inRecommendGroupBTopTime(slot0) then
		return StoreEnum.GroupOrderType.GroupC
	end

	return StoreEnum.GroupOrderType.GroupB
end

function slot0.getRecommendStoreGroupAndOrder(slot0, slot1)
	slot2 = uv0.getRecommendStoreGroup(slot0, slot1)

	if not string.nilorempty(slot0.adjustOrder) then
		for slot7, slot8 in ipairs(string.split(slot0.adjustOrder, "|")) do
			if slot2 == tonumber(string.split(slot8, "#")[2]) then
				return slot2, tonumber(slot9[1])
			end
		end
	end

	return slot2, slot0.order
end

function slot0.checkMonthCardLevelUpTagOpen()
	slot0 = ServerTime.now()

	return slot0 <= (string.nilorempty(CommonConfig.instance:getConstStr(ConstEnum.MonthCardLevelUpTime)) and slot0 or TimeUtil.stringToTimestamp(slot1))
end

function slot0.checkNewMatUpTagOpen(slot0)
	if not slot0 then
		return false
	end

	if string.nilorempty(CommonConfig.instance:getConstStr(ConstEnum.StorePackageNewMatChargeGoodIds)) then
		return false
	end

	slot2 = false

	for slot7, slot8 in ipairs(string.split(slot1, "#") or {}) do
		if tonumber(slot8) == slot0 then
			slot2 = true

			break
		end
	end

	if not slot2 then
		return false
	end

	if string.nilorempty(CommonConfig.instance:getConstStr(ConstEnum.StorePackageNewMatTime)) then
		return false
	end

	return ServerTime.now() <= TimeUtil.stringToTimestamp(slot4)
end

function slot0._checkRelations(slot0, slot1, slot2)
	slot3 = GameUtil.splitString2(slot0, true)
	slot4 = false
	slot5 = false
	slot6 = {}

	if string.nilorempty(slot0) == false and slot3 and #slot3 > 0 then
		for slot10, slot11 in ipairs(slot3) do
			slot12 = true

			if slot11[1] == StoreEnum.RecommendRelationType.Summon then
				if slot2[slot11[2]] == nil then
					slot12 = false
				end
			elseif slot13 == StoreEnum.RecommendRelationType.PackageStoreGoods then
				if StoreModel.instance:getGoodsMO(slot14) == nil or slot15:isSoldOut() then
					slot12 = false
				end

				slot4 = true
			elseif slot13 == StoreEnum.RecommendRelationType.StoreGoods then
				if StoreModel.instance:getGoodsMO(slot14) == nil or slot15:isSoldOut() or slot15:alreadyHas() then
					slot12 = false
				end

				if StoreConfig.instance:getGoodsConfig(slot14) then
					slot6[slot16.storeId] = true
				end
			elseif slot13 == StoreEnum.RecommendRelationType.OtherRecommendClose then
				if uv0._inOpenTime(StoreConfig.instance:getStoreRecommendConfig(slot14)) and uv0._checkRelations(slot15.relations, slot1, slot2) then
					slot12 = false
				end
			elseif slot13 == StoreEnum.RecommendRelationType.BattlePass then
				if BpModel.instance:isEnd() then
					slot12 = false
				end
			elseif slot13 == StoreEnum.RecommendRelationType.PackageStoreGoodsNoBuy and StoreModel.instance:getGoodsMO(slot14) and not slot15:isSoldOut() then
				slot5 = false
				slot12 = false

				break
			end

			slot5 = slot5 or slot12
		end
	else
		slot5 = true
	end

	return slot5, slot4, slot6
end

function slot0.getRemainExpireTime(slot0)
	if type(slot0.endTime) == "string" and not string.nilorempty(slot1) then
		return TimeUtil.stringToTimestamp(slot1) - ServerTime.now()
	elseif type(slot1) == "number" then
		return slot1 * 0.001 - ServerTime.now()
	end

	return 0
end

function slot0.checkIsShowCoBrandedTag(slot0)
	if not slot0 then
		return false
	end

	if string.nilorempty(CommonConfig.instance:getConstStr(ConstEnum.StorePackageShowCoBradedTagGoodIds)) then
		return false
	end

	for slot6, slot7 in ipairs(string.split(slot1, "#") or {}) do
		if tonumber(slot7) == slot0 then
			return true
		end
	end

	return false
end

return slot0
