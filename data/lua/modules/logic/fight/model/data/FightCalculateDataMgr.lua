module("modules.logic.fight.model.data.FightCalculateDataMgr", package.seeall)

slot0 = FightDataClass("FightCalculateDataMgr")

function slot0.updateFightData(slot0, slot1)
	if not slot1 then
		return
	end

	for slot5, slot6 in ipairs(slot0.dataMgr.mgrList) do
		if slot6.updateData then
			slot6:updateData(slot1)
		end
	end
end

function slot0.beforePlayRoundProto(slot0, slot1)
	if not slot1 then
		return
	end

	slot0.dataMgr.handCardMgr:cacheDistributeCard(slot1)
end

function slot0.afterPlayRoundProto(slot0, slot1)
	if not slot1 then
		return
	end

	if slot1:HasField("actPoint") then
		slot0.dataMgr.fieldMgr.actPoint = slot1.actPoint
	end

	if slot1:HasField("moveNum") then
		slot0.dataMgr.fieldMgr.moveNum = slot1.moveNum
	end
end

function slot0.playEffect2(slot0, slot1)
	if not slot0:getTarEntityMO(slot1) then
		return
	end

	slot2:setHp(slot2.currentHp - slot1.effectNum)
end

function slot0.playEffect3(slot0, slot1)
	if not slot0:getTarEntityMO(slot1) then
		return
	end

	slot2:setHp(slot2.currentHp - slot1.effectNum)
end

function slot0.playEffect4(slot0, slot1)
	if not slot0:getTarEntityMO(slot1) then
		return
	end

	slot2:setHp(slot2.currentHp + slot1.effectNum)
end

function slot0.playEffect5(slot0, slot1)
	if not slot0:getTarEntityMO(slot1) then
		return
	end

	if not slot1.buff then
		return
	end

	slot2:addBuff(slot3)
end

function slot0.playEffect6(slot0, slot1)
	if not slot0:getTarEntityMO(slot1) then
		return
	end

	if not slot1.buff then
		return
	end

	slot2:delBuff(slot3.uid)
end

function slot0.playEffect7(slot0, slot1)
	if not slot0:getTarEntityMO(slot1) then
		return
	end

	if not slot1.buff then
		return
	end

	slot2:updateBuff(slot3)
end

function slot0.playEffect8(slot0, slot1)
end

function slot0.playEffect9(slot0, slot1)
	slot0.dataMgr.entityMgr:addDeadUid(slot1.targetId)

	if not slot0:getTarEntityMO(slot1) then
		return
	end

	slot2:setDead()
end

function slot0.playEffect12(slot0, slot1)
	if not slot0:getTarEntityMO(slot1) then
		return
	end

	slot2:setHp(slot2.currentHp + slot1.effectNum)
end

function slot0.playEffect13(slot0, slot1)
end

function slot0.playEffect14(slot0, slot1)
end

function slot0.playEffect15(slot0, slot1)
end

function slot0.playEffect16(slot0, slot1)
end

function slot0.playEffect17(slot0, slot1)
end

function slot0.playEffect18(slot0, slot1)
	if not slot0:getTarEntityMO(slot1) then
		return
	end

	slot2:setHp(slot2.currentHp - slot1.effectNum)
end

function slot0.playEffect19(slot0, slot1)
end

function slot0.playEffect20(slot0, slot1)
end

function slot0.playEffect21(slot0, slot1)
end

function slot0.playEffect22(slot0, slot1)
end

function slot0.playEffect23(slot0, slot1)
end

function slot0.playEffect24(slot0, slot1)
end

function slot0.playEffect25(slot0, slot1)
	if not slot0:getTarEntityMO(slot1) then
		return
	end

	slot2:setShield(slot1.effectNum)
end

function slot0.playEffect26(slot0, slot1)
end

function slot0.playEffect27(slot0, slot1)
end

function slot0.playEffect28(slot0, slot1)
end

function slot0.playEffect29(slot0, slot1)
end

function slot0.playEffect30(slot0, slot1)
end

function slot0.playEffect31(slot0, slot1)
end

function slot0.playEffect32(slot0, slot1)
end

function slot0.playEffect33(slot0, slot1)
end

function slot0.playEffect34(slot0, slot1)
end

function slot0.playEffect35(slot0, slot1)
end

function slot0.playEffect36(slot0, slot1)
end

function slot0.playEffect37(slot0, slot1)
end

function slot0.playEffect38(slot0, slot1)
	if not slot0:getTarEntityMO(slot1) then
		return
	end

	slot2:setHp(slot2.currentHp - slot1.effectNum)
end

function slot0.playEffect39(slot0, slot1)
end

function slot0.playEffect40(slot0, slot1)
	if not slot0:getTarEntityMO(slot1) then
		return
	end

	slot2:setHp(slot1.effectNum)
end

function slot0.playEffect41(slot0, slot1)
	if not slot0:getTarEntityMO(slot1) then
		return
	end

	slot2:setHp(slot2.currentHp + slot1.effectNum)
	slot2:setShield(0)
end

function slot0.playEffect42(slot0, slot1)
end

function slot0.playEffect43(slot0, slot1)
end

function slot0.playEffect44(slot0, slot1)
end

function slot0.playEffect45(slot0, slot1)
end

function slot0.playEffect46(slot0, slot1)
end

function slot0.playEffect47(slot0, slot1)
end

function slot0.playEffect48(slot0, slot1)
end

function slot0.playEffect49(slot0, slot1)
end

function slot0.playEffect50(slot0, slot1)
end

function slot0.playEffect51(slot0, slot1)
end

function slot0.playEffect52(slot0, slot1)
end

function slot0.playEffect53(slot0, slot1)
end

function slot0.playEffect54(slot0, slot1)
	slot2 = slot0:getHandCard()

	FightDataHelper.coverData(slot0.dataMgr.handCardMgr:getRedealCard(), slot2)
	FightCardDataHelper.combineCardListForLocal(slot2)
end

function slot0.playEffect55(slot0, slot1)
end

function slot0.playEffect56(slot0, slot1)
	if not slot0:getTarEntityMO(slot1) then
		return
	end

	if not slot1.buff then
		return
	end

	slot2:delBuff(slot3.uid)
end

function slot0.playEffect57(slot0, slot1)
	if not slot0:getTarEntityMO(slot1) then
		return
	end

	slot2:setHp(slot2.currentHp + slot1.effectNum)
end

function slot0.playEffect58(slot0, slot1)
	if not FightCardDataHelper.cardChangeIsMySide(slot1) then
		return
	end

	table.insert(slot0:getHandCard(), FightCardData.New({
		uid = "0",
		skillId = slot1.effectNum
	}))
end

function slot0.playEffect59(slot0, slot1)
	slot0.dataMgr.handCardMgr:distribute(slot0.dataMgr.handCardMgr.beforeCards1, slot0.dataMgr.handCardMgr.teamACards1)
end

function slot0.playEffect60(slot0, slot1)
	slot0.dataMgr.handCardMgr:distribute(slot0.dataMgr.handCardMgr.beforeCards2, slot0.dataMgr.handCardMgr.teamACards2)
end

function slot0.playEffect61(slot0, slot1)
end

function slot0.playEffect62(slot0, slot1)
	if not slot0:getTarEntityMO(slot1) then
		return
	end

	slot2:setShield(0)
end

function slot0.playEffect63(slot0, slot1)
end

function slot0.playEffect64(slot0, slot1)
end

function slot0.playEffect65(slot0, slot1)
end

function slot0.playEffect66(slot0, slot1)
end

function slot0.playEffect67(slot0, slot1)
	if not slot1.entityMO then
		return
	end

	if FightModel.instance:getVersion() >= 1 then
		slot0.dataMgr.entityMgr:replaceEntityMO(slot1.entityMO)
	else
		FightHelper.setEffectEntitySide(slot1)
		slot0.dataMgr.entityMgr:replaceEntityMO(slot1.entityMO)
	end
end

function slot0.playEffect68(slot0, slot1)
end

function slot0.playEffect69(slot0, slot1)
end

function slot0.playEffect70(slot0, slot1)
end

function slot0.playEffect71(slot0, slot1)
end

function slot0.playEffect72(slot0, slot1)
end

function slot0.playEffect73(slot0, slot1)
end

function slot0.playEffect74(slot0, slot1)
end

function slot0.playEffect75(slot0, slot1)
	if not FightCardDataHelper.cardChangeIsMySide(slot1) then
		return
	end

	if not (slot1.entityMO and slot1.entityMO.id) then
		return
	end

	if not slot0.dataMgr:getEntityById(slot2) then
		return
	end

	if FightModel.instance:getVersion() < 1 and slot3.side ~= FightEnum.EntitySide.MySide then
		return
	end

	slot7 = slot1.effectNum

	if not slot0:getHandCard()[tonumber(slot1.targetId)] then
		return
	end

	slot5[slot6].uid = slot2
	slot5[slot6].skillId = slot7

	if slot4 < 4 then
		FightCardDataHelper.combineCardListForLocal(slot5)
	end
end

function slot0.playEffect76(slot0, slot1)
end

function slot0.playEffect77(slot0, slot1)
	slot0.dataMgr.fieldMgr.extraMoveAct = slot1.effectNum
end

function slot0.playEffect78(slot0, slot1)
	if not FightCardDataHelper.cardChangeIsMySide(slot1) then
		return
	end

	table.insert(slot0:getHandCard(), FightCardData.New({
		uid = "0",
		skillId = slot1.effectNum
	}))
end

function slot0.playEffect79(slot0, slot1)
end

function slot0.playEffect80(slot0, slot1)
end

function slot0.playEffect81(slot0, slot1)
end

function slot0.playEffect82(slot0, slot1)
end

function slot0.playEffect83(slot0, slot1)
end

function slot0.playEffect84(slot0, slot1)
end

function slot0.playEffect85(slot0, slot1)
	if not FightCardDataHelper.cardChangeIsMySide(slot1) then
		return
	end

	for slot7, slot8 in ipairs(string.splitToNumber(slot1.reserveStr, "#")) do
		FightDataHelper.coverData(FightCardData.New(slot1.cardInfoList[slot7]), slot0:getHandCard()[slot8])
	end
end

function slot0.playEffect86(slot0, slot1)
	if not slot1.entityMO then
		return
	end

	if FightModel.instance:getVersion() >= 1 then
		slot3 = slot0.dataMgr.entityMgr:addEntityMO(slot1.entityMO)

		table.insert(slot0.dataMgr.entityMgr:getOriginNormalList(slot3.side), slot3)
	else
		FightHelper.setEffectEntitySide(slot1)
		slot0.dataMgr.entityMgr:addEntityMO(slot1.entityMO)
	end
end

function slot0.playEffect87(slot0, slot1)
end

function slot0.playEffect88(slot0, slot1)
end

function slot0.playEffect89(slot0, slot1)
end

function slot0.playEffect90(slot0, slot1)
end

function slot0.playEffect91(slot0, slot1)
	if not slot0:getTarEntityMO(slot1) then
		return
	end

	if slot2:hasBuffFeature(FightEnum.BuffType_SpExPointMaxAdd) then
		return
	end

	slot2:changeExpointMaxAdd(slot1.effectNum)
end

function slot0.playEffect92(slot0, slot1)
end

function slot0.playEffect93(slot0, slot1)
end

function slot0.playEffect94(slot0, slot1)
end

function slot0.playEffect95(slot0, slot1)
end

function slot0.playEffect96(slot0, slot1)
	if not FightCardDataHelper.cardChangeIsMySide(slot1) then
		return
	end

	for slot6 = #slot0:getHandCard(), 1, -1 do
		if FightEnum.UniversalCard[slot2[slot6].skillId] then
			table.remove(slot2, slot6)
		end
	end

	if FightModel.instance:getVersion() < 4 then
		FightCardDataHelper.combineCardListForLocal(slot2)
	end
end

function slot0.playEffect97(slot0, slot1)
	if not slot0:getTarEntityMO(slot1) then
		return
	end

	slot2.career = slot1.effectNum
end

function slot0.playEffect98(slot0, slot1)
end

function slot0.playEffect99(slot0, slot1)
end

function slot0.playEffect100(slot0, slot1)
end

function slot0.playEffect101(slot0, slot1)
end

function slot0.playEffect102(slot0, slot1)
end

function slot0.playEffect103(slot0, slot1)
end

function slot0.playEffect104(slot0, slot1)
end

function slot0.playEffect105(slot0, slot1)
end

function slot0.playEffect106(slot0, slot1)
end

function slot0.playEffect107(slot0, slot1)
	if not slot1.entityMO then
		return
	end

	if FightModel.instance:getVersion() >= 1 then
		slot5 = slot0.dataMgr.entityMgr:getOriginSubList(slot0.dataMgr:getEntityById(slot1.entityMO.id).side)

		if slot0:getTarEntityMO(slot1) and slot6.id ~= FightEntityScene.MySideId and slot6.id ~= FightEntityScene.EnemySideId then
			slot6.position = slot3.position or -1

			for slot11, slot12 in ipairs(slot0.dataMgr.entityMgr:getOriginListById(slot6.uid)) do
				if slot12.uid == slot6.uid then
					table.remove(slot7, slot11)

					break
				end
			end

			table.insert(slot5, slot6)
		end

		for slot10, slot11 in ipairs(slot5) do
			if slot11.uid == slot3.uid then
				table.remove(slot5, slot10)

				break
			end
		end

		slot0.dataMgr.entityMgr:replaceEntityMO(slot1.entityMO)
		table.insert(slot0.dataMgr.entityMgr:getOriginNormalList(slot4), slot0.dataMgr.entityMgr:getById(slot3.uid))
	else
		FightHelper.setEffectEntitySide(slot1)
		slot0.dataMgr.entityMgr:replaceEntityMO(slot1.entityMO)
	end
end

function slot0.playEffect108(slot0, slot1)
	if not slot0:getTarEntityMO(slot1) then
		return
	end

	slot2.attrMO.hp = slot1.effectNum
end

function slot0.playEffect109(slot0, slot1)
	if not slot0:getTarEntityMO(slot1) then
		return
	end

	slot2:setHp(slot1.effectNum)
end

function slot0.playEffect110(slot0, slot1)
	if not slot0:getTarEntityMO(slot1) then
		return
	end

	slot2:setHp(0)
end

function slot0.playEffect111(slot0, slot1)
	if not slot0:getTarEntityMO(slot1) then
		return
	end

	slot2:setExPoint(slot2:getExPoint() + (slot1.effectNum or 0))
end

function slot0.playEffect112(slot0, slot1)
end

function slot0.playEffect113(slot0, slot1)
	if not slot0:getTarEntityMO(slot1) then
		return
	end

	slot2:changeServerUniqueCost(slot1.effectNum)
end

function slot0.playEffect114(slot0, slot1)
end

function slot0.playEffect115(slot0, slot1)
end

function slot0.playEffect116(slot0, slot1)
end

function slot0.playEffect117(slot0, slot1)
	slot2 = tonumber(slot1.targetId)
	slot3 = slot0.dataMgr.fieldMgr.indicatorDict

	if slot1.configEffect == FightWorkIndicatorChange.ConfigEffect.AddIndicator then
		if not slot3[slot2] then
			slot3[slot2] = {
				num = 0,
				id = slot2
			}
		end

		slot4.num = slot1.effectNum
	elseif slot1.configEffect == FightWorkIndicatorChange.ConfigEffect.ClearIndicator then
		slot3[slot2] = nil
	end
end

function slot0.playEffect118(slot0, slot1)
end

function slot0.playEffect119(slot0, slot1)
end

function slot0.playEffect120(slot0, slot1)
end

function slot0.playEffect121(slot0, slot1)
end

function slot0.playEffect122(slot0, slot1)
end

function slot0.playEffect123(slot0, slot1)
end

function slot0.playEffect124(slot0, slot1)
end

function slot0.playEffect125(slot0, slot1)
	if not slot1.entityMO then
		return
	end

	if FightModel.instance:getVersion() >= 1 then
		slot0.dataMgr.entityMgr:replaceEntityMO(slot1.entityMO)
	else
		FightHelper.setEffectEntitySide(slot1)
		slot0.dataMgr.entityMgr:replaceEntityMO(slot1.entityMO)
	end
end

function slot0.playEffect126(slot0, slot1)
end

function slot0.playEffect127(slot0, slot1)
	if not slot0:getTarEntityMO(slot1) then
		return
	end

	if slot2:getPowerInfo(slot1.configEffect) then
		slot2:changePowerMax(slot3, slot1.effectNum)
	end
end

function slot0.playEffect128(slot0, slot1)
	if not slot0:getTarEntityMO(slot1) then
		return
	end

	if slot2:getPowerInfo(slot1.configEffect) then
		slot4.num = slot4.num + slot1.effectNum
	end
end

function slot0.playEffect129(slot0, slot1)
end

function slot0.playEffect130(slot0, slot1)
	if not slot0:getTarEntityMO(slot1) then
		return
	end

	slot2:setHp(slot2.currentHp - slot1.effectNum)
end

function slot0.playEffect131(slot0, slot1)
	if not slot0:getTarEntityMO(slot1) then
		return
	end

	slot2:setHp(slot2.currentHp - slot1.effectNum)
end

function slot0.playEffect132(slot0, slot1)
end

function slot0.playEffect133(slot0, slot1)
	if not FightCardDataHelper.cardChangeIsMySide(slot1) then
		return
	end

	if #string.splitToNumber(slot1.reserveStr, "#") > 0 then
		slot3 = slot0:getHandCard()
		slot4 = {
			[slot9] = true
		}

		for slot8, slot9 in ipairs(slot2) do
			if slot3[slot9] then
				-- Nothing
			end
		end

		for slot8 = #slot3, 1, -1 do
			if slot3[slot8] and slot4[slot8] then
				table.remove(slot3, slot8)
			end
		end

		if FightModel.instance:getVersion() < 4 then
			FightCardDataHelper.combineCardListForLocal(slot3)
		end
	end
end

function slot0.playEffect134(slot0, slot1)
	if not slot0:getTarEntityMO(slot1) then
		return
	end

	if not slot1.summoned then
		return
	end

	slot2:getSummonedInfo():addData(slot1.summoned)
end

function slot0.playEffect135(slot0, slot1)
	if not slot0:getTarEntityMO(slot1) then
		return
	end

	if slot2:getSummonedInfo():getData(slot1.reserveId) then
		slot3:removeData(slot4)
	end
end

function slot0.playEffect136(slot0, slot1)
	if not slot0:getTarEntityMO(slot1) then
		return
	end

	if slot2:getSummonedInfo():getData(slot1.reserveId) then
		slot5.level = slot5.level + slot1.effectNum
	end
end

function slot0.playEffect137(slot0, slot1)
end

function slot0.playEffect138(slot0, slot1)
end

function slot0.playEffect139(slot0, slot1)
end

function slot0.playEffect140(slot0, slot1)
end

function slot0.playEffect141(slot0, slot1)
	if not FightCardDataHelper.cardChangeIsMySide(slot1) then
		return
	end

	if #string.splitToNumber(slot1.reserveStr, "#") > 0 then
		slot3 = slot0:getHandCard()

		for slot7, slot8 in ipairs(slot2) do
			if slot3[slot8] then
				slot3[slot8].tempCard = true
			end
		end
	end
end

function slot0.playEffect142(slot0, slot1)
end

function slot0.playEffect143(slot0, slot1)
end

function slot0.playEffect144(slot0, slot1)
end

function slot0.playEffect145(slot0, slot1)
end

function slot0.playEffect146(slot0, slot1)
end

function slot0.playEffect147(slot0, slot1)
end

function slot0.playEffect148(slot0, slot1)
end

function slot0.playEffect149(slot0, slot1)
	if not FightCardDataHelper.cardChangeIsMySide(slot1) then
		return
	end

	table.insert(slot0:getHandCard(), FightCardData.New(slot1.cardInfo))

	if FightModel.instance:getVersion() < 4 then
		FightCardDataHelper.combineCardListForLocal(slot3)
	end
end

function slot0.playEffect150(slot0, slot1)
end

function slot0.playEffect151(slot0, slot1)
end

function slot0.playEffect152(slot0, slot1)
	if not FightCardDataHelper.cardChangeIsMySide(slot1) then
		return
	end

	for slot6 = #slot0:getHandCard(), 1, -1 do
		if slot2[slot6].uid == slot1.targetId then
			table.remove(slot2, slot6)
		end
	end

	if FightModel.instance:getVersion() < 4 then
		FightCardDataHelper.combineCardListForLocal(slot2)
	end
end

function slot0.playEffect153(slot0, slot1)
	FightCardDataHelper.combineCardListForLocal(slot0:getHandCard())
end

function slot0.playEffect154(slot0, slot1)
	FightDataHelper.coverData(FightCardDataHelper.newCardList(slot1.cardInfoList), slot0:getHandCard())
end

function slot0.playEffect155(slot0, slot1)
	if not FightCardDataHelper.cardChangeIsMySide(slot1) then
		return
	end

	if #string.splitToNumber(slot1.reserveStr, "#") > 0 then
		slot3 = slot0:getHandCard()
		slot4 = {
			[slot9] = true
		}

		for slot8, slot9 in ipairs(slot2) do
			if slot3[slot9] then
				-- Nothing
			end
		end

		for slot8 = #slot3, 1, -1 do
			if slot3[slot8] and slot4[slot8] then
				table.remove(slot3, slot8)
			end
		end
	end
end

function slot0.playEffect156(slot0, slot1)
	if not FightCardDataHelper.cardChangeIsMySide(slot1) then
		return
	end

	if slot0:getHandCard()[slot1.effectNum] then
		FightDataHelper.coverData(FightCardData.New(slot1.cardInfo), slot4)
	end
end

function slot0.playEffect157(slot0, slot1)
	if FightModel.instance:getVersion() >= 1 and slot1.teamType ~= FightEnum.TeamType.MySide then
		return
	end

	if slot0:getHandCard()[slot1.effectNum] then
		table.remove(slot3, slot4)
	end
end

function slot0.playEffect158(slot0, slot1)
end

function slot0.playEffect159(slot0, slot1)
end

function slot0.playEffect160(slot0, slot1)
end

function slot0.playEffect161(slot0, slot1)
end

function slot0.playEffect162(slot0, slot1)
	if slot0:isPerformanceData() then
		return
	end

	slot2 = FightStepMO.New()

	slot2:init(slot1.fightStep, true)
	slot0:playStepData(slot2)
end

function slot0.playEffect163(slot0, slot1)
end

function slot0.playEffect164(slot0, slot1)
end

function slot0.playEffect165(slot0, slot1)
end

function slot0.playEffect166(slot0, slot1)
end

function slot0.playEffect167(slot0, slot1)
	if not slot0:getTarEntityMO(slot1) then
		return
	end

	if not slot1.buff then
		return
	end

	slot2:updateBuff(slot3)
end

function slot0.playEffect168(slot0, slot1)
end

function slot0.playEffect169(slot0, slot1)
end

function slot0.playEffect170(slot0, slot1)
	if not FightCardDataHelper.cardChangeIsMySide(slot1) then
		return
	end

	if slot0:getHandCard()[slot1.effectNum] then
		FightDataHelper.coverData(FightCardData.New(slot1.cardInfo), slot4)
	end
end

function slot0.playEffect171(slot0, slot1)
	if not slot0:getTarEntityMO(slot1) then
		return
	end

	if not slot1.entityMO then
		return
	end

	if FightModel.instance:getVersion() >= 1 then
		slot0.dataMgr.entityMgr:replaceEntityMO(slot1.entityMO)
	else
		FightHelper.setEffectEntitySide(slot1)
		slot0.dataMgr.entityMgr:replaceEntityMO(slot1.entityMO)
	end
end

function slot0.playEffect172(slot0, slot1)
end

function slot0.playEffect173(slot0, slot1)
end

function slot0.playEffect174(slot0, slot1)
	if not slot0:getTarEntityMO(slot1) then
		return
	end

	slot2.canUpgradeIds[slot1.effectNum] = slot1.effectNum
end

function slot0.setRougeExData(slot0, slot1, slot2)
	slot4[1] = string.splitToNumber(slot0.dataMgr.fieldMgr.exTeamStr, "#")[1] or 0
	slot4[2] = slot4[2] or 0
	slot4[3] = slot4[3] or 0
	slot4[slot1] = slot2
	slot0.dataMgr.fieldMgr.exTeamStr = string.format("%s#%s#%s", slot4[1], slot4[2], slot4[3])
end

function slot0.getRougeExData(slot0, slot1)
	return string.splitToNumber(slot0.dataMgr.fieldMgr.exTeamStr, "#")[slot1] or 0
end

function slot0.playEffect188(slot0, slot1)
	slot0:setRougeExData(FightEnum.ExIndexForRouge.MagicLimit, slot0:getRougeExData(FightEnum.ExIndexForRouge.MagicLimit) + slot1.effectNum)
end

function slot0.playEffect189(slot0, slot1)
	slot0:setRougeExData(FightEnum.ExIndexForRouge.Magic, slot0:getRougeExData(FightEnum.ExIndexForRouge.Magic) + slot1.effectNum)
end

function slot0.playEffect190(slot0, slot1)
	slot0:setRougeExData(FightEnum.ExIndexForRouge.Coin, slot0:getRougeExData(FightEnum.ExIndexForRouge.Coin) + slot1.effectNum)
end

function slot0.playEffect191(slot0, slot1)
	if not FightCardDataHelper.cardChangeIsMySide(slot1) then
		return
	end

	table.insert(slot0:getHandCard(), FightCardData.New({
		uid = "0",
		skillId = slot1.effectNum
	}))
end

function slot0.playEffect192(slot0, slot1)
	if not slot0:getTarEntityMO(slot1) then
		return
	end

	slot2:setHp(slot2.currentHp - slot1.effectNum)
end

function slot0.playEffect193(slot0, slot1)
	if not slot0:getTarEntityMO(slot1) then
		return
	end

	slot2:setHp(slot2.currentHp - slot1.effectNum)
end

function slot0.playEffect195(slot0, slot1)
	if not slot0:getTarEntityMO(slot1) then
		return
	end

	slot2:setHp(slot2.currentHp + slot1.effectNum)
end

function slot0.playEffect196(slot0, slot1)
	if not FightCardDataHelper.cardChangeIsMySide(slot1) then
		return
	end

	if #string.splitToNumber(slot1.reserveStr, "#") > 0 then
		slot3 = slot0:getHandCard()
		slot4 = {
			[slot9] = true
		}

		for slot8, slot9 in ipairs(slot2) do
			if slot3[slot9] then
				-- Nothing
			end
		end

		for slot8 = #slot3, 1, -1 do
			if slot3[slot8] and slot4[slot8] then
				table.remove(slot3, slot8)
			end
		end

		if FightModel.instance:getVersion() < 4 then
			FightCardDataHelper.combineCardListForLocal(slot3)
		end
	end
end

function slot0.playEffect197(slot0, slot1)
	if not FightCardDataHelper.cardChangeIsMySide(slot1) then
		return
	end

	table.insert(slot0:getHandCard(), FightCardData.New(slot1.cardInfo))

	if FightModel.instance:getVersion() < 4 then
		FightCardDataHelper.combineCardListForLocal(slot3)
	end
end

function slot0.playEffect202(slot0, slot1)
	if not slot0:getTarEntityMO(slot1) then
		return
	end

	slot2:setHp(slot2.currentHp - slot1.effectNum)
end

function slot0.playEffect206(slot0, slot1)
	if #string.split(slot1.reserveStr, "|") > 0 then
		for slot6, slot7 in ipairs(slot2) do
			slot8 = string.split(slot7, "#")

			if slot0.dataMgr:getEntityById(slot8[1]) then
				slot11.position = tonumber(slot8[2]) or 1
			end
		end
	end
end

function slot0.playEffect207(slot0, slot1)
	if slot0.dataMgr:getEntityById(slot1.targetId) then
		slot3.position = slot1.effectNum
	end

	if #string.split(slot1.reserveStr, "|") > 0 then
		for slot8, slot9 in ipairs(slot4) do
			slot10 = string.split(slot9, "#")

			if slot0.dataMgr:getEntityById(slot10[1]) then
				slot13.position = tonumber(slot10[2]) or 1
			end
		end
	end
end

function slot0.playEffect208(slot0, slot1)
	if slot0.dataMgr:getEntityById(slot1.targetId) then
		slot3.position = slot1.effectNum
	end

	if #string.split(slot1.reserveStr, "|") > 0 then
		for slot8, slot9 in ipairs(slot4) do
			slot10 = string.split(slot9, "#")

			if slot0.dataMgr:getEntityById(slot10[1]) then
				slot13.position = tonumber(slot10[2]) or 1
			end
		end
	end
end

function slot0.playEffect212(slot0, slot1)
	slot0.dataMgr.fieldMgr.curRound = (slot0.dataMgr.fieldMgr.curRound or 1) + 1

	for slot6, slot7 in pairs(slot0.dataMgr.entityMgr:getAllEntityMO()) do
		slot7.subCd = 0
	end
end

function slot0.playEffect214(slot0, slot1)
	if slot0.dataMgr:getEntityById(slot1.targetId) then
		slot3:changeStoredExPoint(slot1.effectNum)

		if slot1.buff then
			slot3:updateBuff(slot1.buff)
		end
	end
end

function slot0.playEffect228(slot0, slot1)
	if not slot0:getTarEntityMO(slot1) then
		return
	end

	slot2:setShield(slot1.effectNum)
end

function slot0.playEffect233(slot0, slot1)
	slot0.dataMgr.handCardMgr:distribute(slot0.dataMgr.handCardMgr.beforeCards1, slot0.dataMgr.handCardMgr.teamACards1)
end

function slot0.playEffect234(slot0, slot1)
	if not slot0:getTarEntityMO(slot1) then
		return
	end

	if not slot1.buff then
		return
	end

	slot2:updateBuff(slot3)
end

function slot0.playEffect235(slot0, slot1)
	if not slot0:getTarEntityMO(slot1) then
		return
	end

	slot2.currentHp = slot2.currentHp + slot1.effectNum
end

function slot0.playEffect236(slot0, slot1)
	if not slot0:getTarEntityMO(slot1) then
		return
	end

	slot2.guard = slot2.guard + slot1.effectNum
end

function slot0.playEffect238(slot0, slot1)
	slot0.dataMgr.entityMgr:replaceEntityMO(slot1.entityMO)
end

function slot0.playEffect244(slot0, slot1)
	if not slot0:getTarEntityMO(slot1) then
		return
	end

	if not slot2:hasBuffFeature(FightEnum.BuffType_SpExPointMaxAdd) then
		return
	end

	slot3 = string.splitToNumber(slot1.reserveStr, "#")

	slot2:changeExpointMaxAdd(slot3[1] - slot2:getExpointMaxAddNum())
	slot2:changeServerUniqueCost(slot3[2] - slot2:getExpointCostOffsetNum())
end

function slot0.playEffect247(slot0, slot1)
	slot0.dataMgr.fieldMgr:changeDeckNum(slot1.cardInfoList and #slot2)
end

function slot0.playEffect248(slot0, slot1)
	slot0.dataMgr.fieldMgr:changeDeckNum(-(slot1.cardInfoList and #slot2))
end

function slot0.playEffect251(slot0, slot1)
	slot0.dataMgr.fieldMgr.progress = slot0.dataMgr.fieldMgr.progress + slot1.effectNum
end

function slot0.playEffect252(slot0, slot1)
	slot0.dataMgr.paTaMgr:setCurrCD(slot1.effectNum)
end

function slot0.playEffect253(slot0, slot1)
	if not slot0:getTarEntityMO(slot1) then
		return
	end

	slot2:setHp(slot2.currentHp - slot1.effectNum)
end

function slot0.playEffect256(slot0, slot1)
	slot0.dataMgr.fieldMgr.progressMax = slot0.dataMgr.fieldMgr.progressMax + slot1.effectNum
	slot0.dataMgr.fieldMgr.param[FightParamData.ParamKey.ProgressSkill] = tonumber(slot1.reserveStr)
	slot0.dataMgr.fieldMgr.param[FightParamData.ParamKey.ProgressId] = slot1.effectNum1
end

function slot0.playEffect258(slot0, slot1)
	if slot1.teamType ~= FightEnum.TeamType.MySide then
		return
	end

	if slot0:getHandCard()[slot1.effectNum] then
		table.remove(slot2, slot3)
	end
end

function slot0.playEffect260(slot0, slot1)
	slot0.dataMgr.entityMgr:replaceEntityMO(slot1.entityMO)
end

function slot0.playEffect265(slot0, slot1)
	slot0.dataMgr.paTaMgr:switchBossSkill(slot1.assistBossInfo)
end

function slot0.playEffect267(slot0, slot1)
	if not slot0:getTarEntityMO(slot1) then
		return
	end

	slot2:setHp(slot2.currentHp - slot1.effectNum)
end

function slot0.playEffect268(slot0, slot1)
	if not slot0:getTarEntityMO(slot1) then
		return
	end

	slot2:setHp(slot2.currentHp - slot1.effectNum)
end

function slot0.playEffect269(slot0, slot1)
end

function slot0.playEffect270(slot0, slot1)
	for slot7 = #slot0:getHandCard(), 1, -1 do
		if tabletool.indexOf(string.splitToNumber(slot1.reserveStr, "#"), slot7) then
			table.remove(slot2, slot7)
		end
	end
end

function slot0.playEffect271(slot0, slot1)
	if not slot0:getTarEntityMO(slot1) then
		return
	end

	slot2:setShield(slot2.shieldValue + slot1.effectNum)
end

function slot0.playEffect272(slot0, slot1)
	if not slot0.dataMgr.fieldMgr.indicatorDict[FightEnum.IndicatorId.PaTaScore] then
		slot0.dataMgr.fieldMgr.indicatorDict[slot2] = {
			num = 0,
			id = slot2
		}
	end

	slot3.num = slot3.num + slot1.effectNum
end

function slot0.playEffect273(slot0, slot1)
	slot0.dataMgr.playCardMgr:setAct174EnemyCard(slot1.cardInfoList)
end

function slot0.playEffect274(slot0, slot1)
	FightDataHelper.coverData(FightCardDataHelper.newCardList(slot1.cardInfoList), slot0:getHandCard())
end

function slot0.playEffect275(slot0, slot1)
	slot0.dataMgr.ASFDDataMgr:changeEnergy(slot1.effectNum, slot1.effectNum1)
end

function slot0.playEffect276(slot0, slot1)
	FightDataHelper.coverData(FightCardDataHelper.newCardList(slot1.cardInfoList), slot0:getHandCard())
end

function slot0.playEffect277(slot0, slot1)
	slot0.dataMgr.ASFDDataMgr:changeEmitterEnergy(slot1.effectNum, slot1.effectNum1)
end

function slot0.playEffect280(slot0, slot1)
	slot2 = slot0.dataMgr.entityMgr:addEntityMO(slot1.entityMO)

	table.insert(slot0.dataMgr.entityMgr:getOriginASFDEmitterList(slot2.side), slot2)
	slot0.dataMgr.ASFDDataMgr:setEmitterInfo(slot2.side, slot1.emitterInfo)
end

function slot0.playEffect282(slot0, slot1)
	if not slot0:getTarEntityMO(slot1) then
		return
	end

	slot2:setHp(slot2.currentHp - slot1.effectNum)
end

function slot0.playEffect283(slot0, slot1)
	slot0.dataMgr.fieldMgr:setPlayerFinisherInfo(slot1.playerFinisherInfo)
end

function slot0.playEffect287(slot0, slot1)
	if slot0.dataMgr.entityMgr:getASFDEntityMo(slot1.effectNum) then
		slot0.dataMgr.entityMgr:removeEntity(slot3.id)
	end
end

function slot0.playEffect289(slot0, slot1)
end

function slot0.playEffect291(slot0, slot1)
	slot0.dataMgr.tempMgr.simplePolarizationLevel = slot1.effectNum
end

function slot0.playEffect293(slot0, slot1)
	if not slot0.dataMgr.entityMgr:getOriginSubList(slot1.teamType == FightEnum.TeamType.MySide and FightEnum.EntitySide.MySide or FightEnum.EntitySide.EnemySide) then
		return
	end

	table.insert(slot4, slot0.dataMgr.entityMgr:addEntityMO(slot1.entityMO))
end

function slot0.playEffect294(slot0, slot1)
end

function slot0.playEffect295(slot0, slot1)
	if not slot0:getTarEntityMO(slot1) then
		return
	end

	if not slot1.powerInfo then
		return
	end

	slot2:refreshPowerInfo(slot1.powerInfo)
end

function slot0.playEffect308(slot0, slot1)
	slot2 = slot0.dataMgr.teamDataMgr[slot1.teamType]
	slot3 = slot1.cardHeatValue.id
	slot2.cardHeat.values[slot3] = FightDataHelper.coverData(FightDataCardHeatValue.New(slot1.cardHeatValue), slot2.cardHeat.values[slot3])
end

function slot0.playEffect309(slot0, slot1)
	if not slot0.dataMgr.teamDataMgr[slot1.teamType].cardHeat.values[slot1.effectNum] then
		return
	end

	slot4.value = slot4.value + slot1.effectNum1
end

function slot0.playEffect310(slot0, slot1)
	slot0.dataMgr.fieldMgr:dirSetDeckNum(slot1.effectNum)
end

function slot0.playEffect314(slot0, slot1)
	if not slot0:getTarEntityMO(slot1) then
		return
	end

	slot2:setHp(slot2.currentHp - slot1.effectNum)
end

function slot0.playEffect316(slot0, slot1)
	if not slot1.entityMO then
		return
	end

	slot0.dataMgr.entityMgr:replaceEntityMO(slot1.entityMO)
end

function slot0.playEffect320(slot0, slot1)
	if not FightCardDataHelper.cardChangeIsMySide(slot1) then
		return
	end

	table.insert(slot0:getHandCard(), FightCardData.New(slot1.cardInfo))
end

function slot0.playUndefineEffect(slot0)
end

function slot0.dealExPointInfo(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		if slot0.dataMgr:getEntityById(slot6.uid) then
			slot7:setHp(slot6.currentHp)

			if not isDebugBuild then
				slot7:setExPoint(slot6.exPoint)
				slot7:setPowerInfos(slot6.powerInfos)
			end
		end
	end
end

function slot0.playChangeWave(slot0)
	if slot0.dataMgr.cacheFightMgr:getAndRemove() then
		slot0.dataMgr:updateFightData(slot2)
	end
end

function slot0.playChangeHero(slot0, slot1)
	slot2 = slot0.dataMgr:getEntityById(slot1.toId)

	if not slot0.dataMgr:getEntityById(slot1.fromId) then
		return
	end

	if slot2 and slot2.id ~= FightEntityScene.MySideId then
		slot3.position = slot2.position
		slot2.position = -1
	end

	if slot1.actEffectMOs then
		for slot7, slot8 in ipairs(slot1.actEffectMOs) do
			if slot8.effectType == FightEnum.EffectType.CHANGEHERO then
				if FightModel.instance:getVersion() >= 1 then
					if slot8.entityMO then
						slot0.dataMgr.entityMgr:replaceEntityMO(slot8.entityMO)
					end
				else
					FightHelper.setEffectEntitySide(slot8)

					if slot8.entityMO then
						slot0.dataMgr.entityMgr:replaceEntityMO(slot8.entityMO)
					end
				end
			end
		end
	end

	slot4 = slot3.side

	for slot9, slot10 in ipairs(slot0.dataMgr.entityMgr:getOriginListById(slot1.toId)) do
		if slot10.uid == slot1.toId then
			table.remove(slot5, slot9)

			break
		end
	end

	for slot9, slot10 in ipairs(slot0.dataMgr.entityMgr:getOriginSubList(slot4)) do
		if slot10.uid == slot1.fromId then
			table.remove(slot5, slot9)

			break
		end
	end

	table.insert(slot0.dataMgr.entityMgr:getOriginNormalList(slot4), slot0.dataMgr.entityMgr:getById(slot1.fromId))
end

function slot0.getTarEntityMO(slot0, slot1)
	return slot0.dataMgr:getEntityById(slot1.targetId)
end

function slot0.getHandCard(slot0)
	return slot0.dataMgr.handCardMgr:getHandCard()
end

function slot0.needLogError(slot0)
	if slot0:isPerformanceData() then
		return
	end

	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.DouQuQu) then
		return
	end

	return true
end

function slot0.isLocalData(slot0)
	return slot0.dataMgr.__cname == FightLocalDataMgr.__cname
end

function slot0.isPerformanceData(slot0)
	return slot0.dataMgr.__cname == FightDataMgr.__cname
end

function slot0.onConstructor(slot0)
	slot0._type2FuncName = {}
end

function slot0.playStepProto(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		slot8 = FightStepMO.New()

		slot8:init(slot7, true)
		table.insert(slot2, slot8)
	end

	for slot6, slot7 in ipairs(slot2) do
		slot0:playStepData(slot7)
	end
end

function slot0.playStepData(slot0, slot1)
	if slot1.actType == FightEnum.ActType.SKILL or slot1.actType == FightEnum.ActType.EFFECT then
		for slot5, slot6 in ipairs(slot1.actEffectMOs) do
			slot0:playActEffectData(slot6)
		end
	elseif slot1.actType == FightEnum.ActType.CHANGEWAVE then
		slot0:playChangeWave()
	elseif slot1.actType == FightEnum.ActType.CHANGEHERO then
		slot0:playChangeHero(slot1)
	end
end

function slot0.playActEffectData(slot0, slot1)
	if not slot0._type2FuncName[slot1.effectType] then
		slot0._type2FuncName[slot1.effectType] = slot0["playEffect" .. slot1.effectType] or slot0.playUndefineEffect
	end

	if slot0:isPerformanceData() then
		slot1:setDone()
		xpcall(slot2, uv0.ingoreLogError, slot0, slot1)
	else
		xpcall(slot2, __G__TRACKBACK__, slot0, slot1)
	end
end

function slot0.ingoreLogError(slot0)
end

return slot0
