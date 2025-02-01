module("modules.logic.fight.model.data.FightCalculateDataMgr", package.seeall)

slot0 = class("FightCalculateDataMgr", FightBaseCalculateDataMgr)

function slot0.afterPlayStepProto(slot0, slot1)
	slot2 = slot0.dataMgr.fieldData
	slot3 = slot0.dataMgr.handCardData
	slot2.curRound = slot1.curRound
	slot2.isFinish = slot1.isFinish
	slot0.dataMgr.entityData.exPointInfo = {}

	for slot8, slot9 in ipairs(slot1.exPointInfo) do
		slot10 = {
			uid = slot9.uid,
			exPoint = slot9.exPoint,
			powerInfos = {}
		}

		for slot14, slot15 in ipairs(slot9.powerInfos) do
			slot10.powerInfos[slot14] = {
				powerId = slot15.powerId,
				num = slot15.num,
				max = slot15.max
			}
		end

		slot10.currentHp = slot9.currentHp
		slot4.exPointInfo[slot8] = slot10
	end

	slot3.aiUseCards = {}

	for slot8, slot9 in ipairs(slot1.aiUseCards) do
		slot10 = FightCardInfoMO.New()

		slot10:init(slot9)

		slot3.aiUseCards[slot8] = slot10
	end

	slot2.power = slot1.power
	slot2.skillInfos = {}

	for slot8, slot9 in ipairs(slot1.skillInfos) do
		slot10 = FightPlayerSkillInfoMO.New()

		slot10:init(slot9)

		slot2.skillInfos[slot8] = slot10
	end

	slot3.beforeCards1 = {}

	for slot8, slot9 in ipairs(slot1.beforeCards1) do
		slot10 = FightCardInfoMO.New()

		slot10:init(slot9)

		slot3.beforeCards1[slot8] = slot10
	end

	slot3.teamACards1 = {}

	for slot8, slot9 in ipairs(slot1.teamACards1) do
		slot10 = FightCardInfoMO.New()

		slot10:init(slot9)

		slot3.teamACards1[slot8] = slot10
	end

	slot3.beforeCards2 = {}

	for slot8, slot9 in ipairs(slot1.beforeCards2) do
		slot10 = FightCardInfoMO.New()

		slot10:init(slot9)

		slot3.beforeCards2[slot8] = slot10
	end

	slot3.teamACards2 = {}

	for slot8, slot9 in ipairs(slot1.teamACards2) do
		slot10 = FightCardInfoMO.New()

		slot10:init(slot9)

		slot3.teamACards2[slot8] = slot10
	end

	slot3.useCardList = {}

	for slot8, slot9 in ipairs(slot1.useCardList) do
		slot3.useCardList[slot8] = slot9
	end

	slot2.curRound = slot1.curRound
	slot4.heroSpAttributes = {}

	for slot8, slot9 in ipairs(slot1.heroSpAttributes) do
		slot10 = FightPlayerSkillInfoMO.New()

		slot10:init(slot9)

		slot4.heroSpAttributes[slot8] = slot10
	end

	slot2.lastChangeHeroUid = slot1.lastChangeHeroUid
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

	slot2:delBuff(slot2.buffModel:getById(slot3.uid))
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
	if not slot0:getTarEntityMO(slot1) then
		return
	end

	slot2.isDead = true
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
	tabletool.clear(slot0:getHandCard())

	if slot0.dataMgr:getHandCardDataMgr():getRedealProto() then
		tabletool.addValues(slot2, FightHelper.buildInfoMOs(slot3.dealCardGroup, FightCardInfoMO))
	end

	FightHandCardDataMgr.combineCardList(slot2)
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

	slot2:delBuff(slot2.buffModel:getById(slot3.uid))
end

function slot0.playEffect57(slot0, slot1)
	if not slot0:getTarEntityMO(slot1) then
		return
	end

	slot2:setHp(slot2.currentHp + slot1.effectNum)
end

function slot0.playEffect58(slot0, slot1)
	if not FightHandCardDataMgr.cardChangeIsMySide(slot1) then
		return
	end

	slot2 = FightCardInfoMO.New()

	slot2:init({
		uid = "0",
		skillId = slot1.effectNum
	})
	table.insert(slot0:getHandCard(), slot2)
end

function slot0.playEffect59(slot0, slot1)
	slot0.dataMgr.handCardData:distribute(slot0.dataMgr.handCardData.beforeCards1, slot0.dataMgr.handCardData.teamACards1)
end

function slot0.playEffect60(slot0, slot1)
	slot0.dataMgr.handCardData:distribute(slot0.dataMgr.handCardData.beforeCards2, slot0.dataMgr.handCardData.teamACards2)
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
		slot0.dataMgr:getEntityDataMgr():replaceEntityMO(slot1.entityMO)
	else
		FightHelper.setEffectEntitySide(slot1)
		slot0.dataMgr:getEntityDataMgr():replaceEntityMO(slot1.entityMO)
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
	if not FightHandCardDataMgr.cardChangeIsMySide(slot1) then
		return
	end

	if not (slot1.entityMO and slot1.entityMO.id) then
		return
	end

	if not slot0.dataMgr:getEntityMO(slot2) then
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
		FightHandCardDataMgr.combineCardList(slot5)
	end
end

function slot0.playEffect76(slot0, slot1)
end

function slot0.playEffect77(slot0, slot1)
end

function slot0.playEffect78(slot0, slot1)
	if not FightHandCardDataMgr.cardChangeIsMySide(slot1) then
		return
	end

	slot2 = FightCardInfoMO.New()

	slot2:init({
		uid = "0",
		skillId = slot1.effectNum
	})
	table.insert(slot0:getHandCard(), slot2)
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
	if not FightHandCardDataMgr.cardChangeIsMySide(slot1) then
		return
	end

	for slot7, slot8 in ipairs(string.splitToNumber(slot1.reserveStr, "#")) do
		slot0:getHandCard()[slot8]:init(slot1.cardInfoList[slot7])
	end
end

function slot0.playEffect86(slot0, slot1)
	if not slot1.entityMO then
		return
	end

	if FightModel.instance:getVersion() >= 1 then
		slot0.dataMgr:getEntityDataMgr():replaceEntityMO(slot1.entityMO)
	else
		FightHelper.setEffectEntitySide(slot1)
		slot0.dataMgr:getEntityDataMgr():replaceEntityMO(slot1.entityMO)
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
	if not FightHandCardDataMgr.cardChangeIsMySide(slot1) then
		return
	end

	for slot6 = #slot0:getHandCard(), 1, -1 do
		if FightEnum.UniversalCard[slot2[slot6].skillId] then
			table.remove(slot2, slot6)
		end
	end

	if FightModel.instance:getVersion() < 4 then
		FightHandCardDataMgr.combineCardList(slot2)
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
		if slot0:getTarEntityMO(slot1) then
			slot3.position = slot0.dataMgr:getEntityMO(slot1.entityMO.id).position or -1
		end

		slot0.dataMgr:getEntityDataMgr():replaceEntityMO(slot1.entityMO)
	else
		FightHelper.setEffectEntitySide(slot1)
		slot0.dataMgr:getEntityDataMgr():replaceEntityMO(slot1.entityMO)
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
		slot0.dataMgr:getEntityDataMgr():replaceEntityMO(slot1.entityMO)
	else
		FightHelper.setEffectEntitySide(slot1)
		slot0.dataMgr:getEntityDataMgr():replaceEntityMO(slot1.entityMO)
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
	if not FightHandCardDataMgr.cardChangeIsMySide(slot1) then
		return
	end

	if #string.splitToNumber(slot1.reserveStr, "#") > 0 then
		slot3 = slot0:getHandCard()

		for slot7, slot8 in ipairs(slot2) do
			if slot3[slot8] then
				slot9.C_REMOVE = true
			end
		end

		for slot7 = #slot3, 1, -1 do
			if slot3[slot7] and slot8.C_REMOVE then
				table.remove(slot3, slot7)
			end
		end

		if FightModel.instance:getVersion() < 4 then
			FightHandCardDataMgr.combineCardList(slot3)
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
	if not FightHandCardDataMgr.cardChangeIsMySide(slot1) then
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
	if not FightHandCardDataMgr.cardChangeIsMySide(slot1) then
		return
	end

	slot2 = FightCardInfoMO.New()

	slot2:init(slot1.cardInfo)
	table.insert(slot0:getHandCard(), slot2)

	if FightModel.instance:getVersion() < 4 then
		FightHandCardDataMgr.combineCardList(slot3)
	end
end

function slot0.playEffect150(slot0, slot1)
end

function slot0.playEffect151(slot0, slot1)
end

function slot0.playEffect152(slot0, slot1)
	if not FightHandCardDataMgr.cardChangeIsMySide(slot1) then
		return
	end

	for slot6 = #slot0:getHandCard(), 1, -1 do
		if slot2[slot6].uid == slot1.targetId then
			table.remove(slot2, slot6)
		end
	end

	if FightModel.instance:getVersion() < 4 then
		FightHandCardDataMgr.combineCardList(slot2)
	end
end

function slot0.playEffect153(slot0, slot1)
	FightHandCardDataMgr.combineCardList(slot0:getHandCard())
end

function slot0.playEffect154(slot0, slot1)
	slot4 = false

	if #slot0:getHandCard() ~= #FightHelper.buildInfoMOs(slot1.cardInfoList, FightCardInfoMO) then
		slot4 = true
		slot5 = "前后端卡牌数据不一致,卡牌数量不一致。请保存行为复现找开发看看,卡牌数量不同 \n服务器数据 = %s, \n本地数据 = %s"
	else
		slot5, slot6, slot7, slot8 = FightHelper.compareData(slot3, slot2)

		if not slot5 then
			slot4 = true
			slot9 = "前后端卡牌数据不一致,请保存行为复现找开发看看 key = %s, \n服务器数据 = %s, \n本地数据 = %s"
		end
	end

	if slot4 then
		tabletool.clear(slot2)
		tabletool.addValues(slot2, slot3)
	end
end

function slot0.playEffect155(slot0, slot1)
	if not FightHandCardDataMgr.cardChangeIsMySide(slot1) then
		return
	end

	if #string.splitToNumber(slot1.reserveStr, "#") > 0 then
		slot3 = slot0:getHandCard()

		for slot7, slot8 in ipairs(slot2) do
			if slot3[slot8] then
				slot9.C_REMOVE = true
			end
		end

		for slot7 = #slot3, 1, -1 do
			if slot3[slot7] and slot8.C_REMOVE then
				table.remove(slot3, slot7)
			end
		end
	end
end

function slot0.playEffect156(slot0, slot1)
	if not FightHandCardDataMgr.cardChangeIsMySide(slot1) then
		return
	end

	if slot0:getHandCard()[slot1.effectNum] then
		slot4:init(slot1.cardInfo)
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
	if not FightHandCardDataMgr.cardChangeIsMySide(slot1) then
		return
	end

	if slot0:getHandCard()[slot1.effectNum] then
		slot4:init(slot1.cardInfo)
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
		slot0.dataMgr:getEntityDataMgr():replaceEntityMO(slot1.entityMO)
	else
		FightHelper.setEffectEntitySide(slot1)
		slot0.dataMgr:getEntityDataMgr():replaceEntityMO(slot1.entityMO)
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
	slot4[1] = string.splitToNumber(slot0.dataMgr.fieldData.exTeamStr, "#")[1] or 0
	slot4[2] = slot4[2] or 0
	slot4[3] = slot4[3] or 0
	slot4[slot1] = slot2
	slot0.dataMgr.fieldData.exTeamStr = string.format("%s#%s#%s", slot4[1], slot4[2], slot4[3])
end

function slot0.getRougeExData(slot0, slot1)
	return string.splitToNumber(slot0.dataMgr.fieldData.exTeamStr, "#")[slot1] or 0
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
	if not FightHandCardDataMgr.cardChangeIsMySide(slot1) then
		return
	end

	slot2 = FightCardInfoMO.New()

	slot2:init({
		uid = "0",
		skillId = slot1.effectNum
	})
	table.insert(slot0:getHandCard(), slot2)
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
	if not FightHandCardDataMgr.cardChangeIsMySide(slot1) then
		return
	end

	if #string.splitToNumber(slot1.reserveStr, "#") > 0 then
		slot3 = slot0:getHandCard()

		for slot7, slot8 in ipairs(slot2) do
			if slot3[slot8] then
				slot9.C_REMOVE = true
			end
		end

		for slot7 = #slot3, 1, -1 do
			if slot3[slot7] and slot8.C_REMOVE then
				table.remove(slot3, slot7)
			end
		end

		if FightModel.instance:getVersion() < 4 then
			FightHandCardDataMgr.combineCardList(slot3)
		end
	end
end

function slot0.playEffect197(slot0, slot1)
	if not FightHandCardDataMgr.cardChangeIsMySide(slot1) then
		return
	end

	slot2 = FightCardInfoMO.New()

	slot2:init(slot1.cardInfo)
	table.insert(slot0:getHandCard(), slot2)

	if FightModel.instance:getVersion() < 4 then
		FightHandCardDataMgr.combineCardList(slot3)
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

			if slot0.dataMgr:getEntityMO(slot8[1]) then
				slot11.position = tonumber(slot8[2]) or 1
			end
		end
	end
end

function slot0.playEffect207(slot0, slot1)
	if slot0.dataMgr:getEntityMO(slot1.targetId) then
		slot3.position = slot1.effectNum
	end

	if #string.split(slot1.reserveStr, "|") > 0 then
		for slot8, slot9 in ipairs(slot4) do
			slot10 = string.split(slot9, "#")

			if slot0.dataMgr:getEntityMO(slot10[1]) then
				slot13.position = tonumber(slot10[2]) or 1
			end
		end
	end
end

function slot0.playEffect208(slot0, slot1)
	if slot0.dataMgr:getEntityMO(slot1.targetId) then
		slot3.position = slot1.effectNum
	end

	if #string.split(slot1.reserveStr, "|") > 0 then
		for slot8, slot9 in ipairs(slot4) do
			slot10 = string.split(slot9, "#")

			if slot0.dataMgr:getEntityMO(slot10[1]) then
				slot13.position = tonumber(slot10[2]) or 1
			end
		end
	end
end

function slot0.playEffect212(slot0, slot1)
	slot0.dataMgr.fieldData.curRound = (slot0.dataMgr.fieldData.curRound or 1) + 1

	for slot6, slot7 in pairs(slot0.dataMgr.entityData:getAllEntityMO()) do
		slot7.subCd = 0
	end
end

function slot0.playEffect214(slot0, slot1)
	if slot0.dataMgr:getEntityMO(slot1.targetId) then
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
	slot0.dataMgr.handCardData:distribute(slot0.dataMgr.handCardData.beforeCards1, slot0.dataMgr.handCardData.teamACards1)
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
	slot0.dataMgr:getEntityDataMgr():replaceEntityMO(slot1.entityMO)
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

function slot0.playUndefineEffect(slot0)
end

function slot0.dealExPointInfo(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		if slot0.dataMgr:getEntityMO(slot6.uid) then
			slot7:setHp(slot6.currentHp)

			if not isDebugBuild then
				slot7:setExPoint(slot6.exPoint)
				slot7:setPowerInfos(slot6.powerInfos)
			end
		end
	end
end

function slot0.playChangeWave(slot0)
	if slot0.dataMgr:getCacheFightDataMgr():getAndRemove() then
		slot0.dataMgr:updateFightData(slot2)
	end
end

function slot0.playChangeHero(slot0, slot1)
	if not slot0.dataMgr:getEntityMO(slot1.toId) then
		return
	end

	if not slot0.dataMgr:getEntityMO(slot1.fromId) then
		return
	end

	slot3.position = slot2.position

	for slot7, slot8 in ipairs(slot1.actEffectMOs) do
		if slot8.effectType == FightEnum.EffectType.CHANGEHERO then
			if FightModel.instance:getVersion() >= 1 then
				slot0.dataMgr:getEntityDataMgr():replaceEntityMO(slot8.entityMO)
			else
				FightHelper.setEffectEntitySide(slot8)
				slot0.dataMgr:getEntityDataMgr():replaceEntityMO(slot8.entityMO)
			end
		end
	end
end

function slot0.getTarEntityMO(slot0, slot1)
	return slot0.dataMgr:getEntityMO(slot1.targetId)
end

function slot0.getHandCard(slot0)
	return slot0.dataMgr:getHandCardDataMgr():getHandCard()
end

slot1 = {
	class = true
}

function slot0.coverData(slot0, slot1, slot2)
	for slot6, slot7 in pairs(slot0) do
		if slot1[slot6] == nil then
			slot0[slot6] = nil
		end
	end

	for slot6, slot7 in pairs(slot1) do
		slot8 = false

		if uv0[slot6] then
			slot8 = true
		end

		if slot2 and slot2[slot6] then
			slot8 = true
		end

		if not slot8 then
			if type(slot7) == "table" then
				uv1.coverDataFromData(slot0[slot6], slot1[slot6], slot2)
			else
				slot0[slot6] = slot1[slot6]
			end
		end
	end
end

return slot0
