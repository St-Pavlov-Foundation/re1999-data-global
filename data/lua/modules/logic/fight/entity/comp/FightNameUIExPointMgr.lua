module("modules.logic.fight.entity.comp.FightNameUIExPointMgr", package.seeall)

slot0 = class("FightNameUIExPointMgr", UserDataDispose)
slot1 = {
	[141102.0] = true
}
slot0.LineCount = 6
slot0.linePrefixX = 12
slot0.lineTopY = 16

function slot0.initMgr(slot0, slot1, slot2)
	slot0:__onInit()

	slot0.goExPointContainer = slot1
	slot0.entity = slot2
	slot0.entityId = slot0.entity.id
	slot0.pointItemList = {}
	slot0.hideExPoint = slot0:checkNeedShieldExPoint()

	if slot0.hideExPoint then
		gohelper.setActive(slot1, false)

		return
	end

	slot0.totalMaxExPoint = 0
	slot0.entityConfig = slot0.entity:getMO():getCO()

	if not slot0.entityConfig then
		logError(string.format("entity 找不到配置表: entityType = %s  modelId = %s", slot0.entity:getMO().entityType, slot0.entity:getMO().modelId))
	end

	slot0.configMaxPoint = slot0.entityConfig and slot0.entityConfig.uniqueSkill_point or 5

	slot0:initExPointLine()
	slot0:createExPointItemList()
	slot0:createExtraExPointItemList()
	slot0:addCustomEvents()
	slot0:updateSelfExPoint()
end

slot2 = {
	[10212131.0] = true,
	[10222111.0] = true,
	[10222131.0] = true,
	[10212111.0] = true,
	[10222121.0] = true,
	[10212121.0] = true
}

function slot0.checkNeedShieldExPoint(slot0)
	if slot0.entity:getMO() and slot1.modelId and uv0[slot2] then
		return false
	end

	if uv1[slot2] then
		return true
	end

	slot4 = FightModel.instance:getCurMonsterGroupId() and lua_monster_group.configDict[slot3]
	slot5 = slot4 and slot4.bossId

	return BossRushController.instance:isInBossRushFight() and (slot5 and FightHelper.isBossId(slot5, slot2))
end

function slot0.initExPointLine(slot0)
	slot0.lineGroupList = slot0:getUserDataTb_()
	slot0.goLineGroupItem = gohelper.findChild(slot0.goExPointContainer, "exPointLine")

	gohelper.setActive(slot0.goLineGroupItem, false)

	slot0.initLineGroupAnchorX, slot0.initLineGroupAnchorY = recthelper.getAnchor(slot0.goLineGroupItem.transform)
end

function slot0.addLineGroup(slot0, slot1)
	slot2 = gohelper.cloneInPlace(slot0.goLineGroupItem)

	gohelper.setActive(slot2, true)
	table.insert(slot0.lineGroupList, slot1, slot2)
	recthelper.setAnchor(slot2:GetComponent(gohelper.Type_RectTransform), slot0.initLineGroupAnchorX + (slot1 - 1) * uv0.linePrefixX, slot0.initLineGroupAnchorY - (slot1 - 1) * uv0.lineTopY)

	return slot2
end

function slot0.getLineGroup(slot0, slot1)
	if slot1 < 1 then
		logError("激情点下标小于1 了？")

		return slot0.lineGroupList[1]
	end

	return slot0.lineGroupList[math.ceil(slot1 / uv0.LineCount)] or slot0:addLineGroup(slot1)
end

function slot0.checkRemoveLineGroup(slot0)
	slot2 = #slot0.lineGroupList

	while math.ceil(#slot0.pointItemList / uv0.LineCount) < slot2 do
		table.remove(slot0.lineGroupList)
		gohelper.destroy(slot0.lineGroupList[slot2])

		slot2 = slot2 - 1
	end
end

function slot0.createExPointItemList(slot0)
	slot0.exPointItemList = {}
	slot0.maxExPoint = slot0.configMaxPoint
	slot0.goPointItem = gohelper.findChild(slot0.goExPointContainer, "empty")

	gohelper.setActive(slot0.goPointItem, false)

	if slot0.maxExPoint <= 0 then
		return
	end

	slot0.totalMaxExPoint = slot0.totalMaxExPoint + slot0.maxExPoint

	for slot4 = 1, slot0.maxExPoint do
		slot0:addPointItem()
	end
end

function slot0.addPointItem(slot0)
	slot3 = FightNameUIExPointItem.GetExPointItem(gohelper.clone(slot0.goPointItem, slot0:getLineGroup(#slot0.pointItemList + 1)))
	slot3.entityName = slot0.entity:getMO():getEntityName()

	table.insert(slot0.exPointItemList, slot3)
	table.insert(slot0.pointItemList, slot3)
	slot3:setIndex(#slot0.pointItemList)
	slot3:setMgr(slot0)
end

function slot0.removePointItem(slot0)
	slot1 = table.remove(slot0.exPointItemList)

	slot0:assetPointItem(slot1)

	if slot1 then
		slot1:destroy()
	end

	tabletool.removeValue(slot0.pointItemList, slot1)
	slot0:checkRemoveLineGroup()
end

function slot0.createExtraExPointItemList(slot0)
	slot0.extraExPointItemList = {}
	slot1 = gohelper.findChild(slot0.goExPointContainer, "extra")

	gohelper.setActive(slot1, false)

	slot0.goExtraPointItem = slot1
	slot0.extraMaxExPoint = slot0.entity:getMO().expointMaxAdd or 0

	if slot0.extraMaxExPoint <= 0 then
		return
	end

	slot0.totalMaxExPoint = slot0.totalMaxExPoint + slot0.extraMaxExPoint

	for slot5 = 1, slot0.extraMaxExPoint do
		slot0:addExtraPointItem()
	end
end

function slot0.addExtraPointItem(slot0)
	if slot0.entity:getMO():hasBuffFeature(FightEnum.BuffType_SpExPointMaxAdd) then
		slot0:addPointItem()

		return
	end

	slot4 = FightNameUIExPointExtraItem.GetExtraExPointItem(gohelper.clone(slot0.goExtraPointItem, slot0:getLineGroup(#slot0.pointItemList + 1)))
	slot4.entityName = slot0.entity:getMO():getEntityName()

	table.insert(slot0.extraExPointItemList, slot4)
	table.insert(slot0.pointItemList, slot4)
	slot4:setIndex(#slot0.pointItemList)
	slot4:setMgr(slot0)
end

function slot0.removeExtraPointItem(slot0)
	if slot0.entity:getMO():hasBuffFeature(FightEnum.BuffType_SpExPointMaxAdd) then
		slot0:removePointItem()

		return
	end

	slot2 = table.remove(slot0.extraExPointItemList)

	slot0:assetPointItem(slot2)

	if slot2 then
		slot2:destroy()
	end

	tabletool.removeValue(slot0.pointItemList, slot2)
	slot0:checkRemoveLineGroup()
end

function slot0.addCustomEvents(slot0)
	slot0:addEventCb(FightController.instance, FightEvent.AddPlayCardClientExPoint, slot0.addPlayCardClientExPoint, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.UpdateExPoint, slot0.updateExPoint, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnExpointMaxAdd, slot0.onExPointMaxAdd, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnBuffUpdate, slot0.onBuffUpdate, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnExPointChange, slot0.onExPointChange, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.MultiHpChange, slot0.onMultiHpChange, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnExSkillPointChange, slot0.onExSkillPointChange, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnStoreExPointChange, slot0.onStoreExPointChange, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.BeContract, slot0.onBeContract, slot0)
end

function slot0.onBeContract(slot0, slot1)
	if slot0.entityId ~= slot1 then
		return
	end

	AudioMgr.instance:trigger(20220175)

	slot2 = gohelper.findChild(slot0.goExPointContainer, "#go_tianshinana")

	gohelper.setActive(slot2, false)
	gohelper.setActive(slot2, true)
	gohelper.setAsLastSibling(slot2)
	slot0:updateSelfExPoint()
	TaskDispatcher.cancelTask(slot0.hideTsnnEffect, slot0)
	TaskDispatcher.runDelay(slot0.hideTsnnEffect, slot0, 1)
end

function slot0.hideTsnnEffect(slot0)
	gohelper.setActive(gohelper.findChild(slot0.goExPointContainer, "#go_tianshinana"), false)
end

function slot0.getClientExPoint(slot0)
	slot1 = slot0.entity:getMO()

	return slot1.exPoint + slot1.moveCardExPoint + slot1.playCardExPoint
end

function slot0.getServerExPoint(slot0)
	return slot0.entity:getMO().exPoint
end

function slot0.getUsedExPoint(slot0)
	return FightHelper.getPredeductionExpoint(slot0.entityId)
end

function slot0.getUniqueSkillNeedExPoint(slot0)
	slot0:log("大招需要激情点：" .. slot0.entity:getMO():getUniqueSkillPoint())

	return slot0.entity:getMO():getUniqueSkillPoint()
end

function slot0.getStoredExPoint(slot0)
	return slot0.entity:getMO():getStoredExPoint()
end

function slot0.updateSelfExPoint(slot0)
	if slot0.hideExPoint then
		return
	end

	slot0:updateExPoint(slot0.entityId)
end

function slot0.getPointCurState(slot0, slot1)
	if slot0:getUsedExPoint() > 0 then
		return slot0:getUsedPointCurState(slot1)
	else
		return slot0:getNoUsePointCurState(slot1)
	end
end

function slot0.getUsedPointCurState(slot0, slot1)
	if slot1 <= math.min(slot0:getStoredExPoint(), slot0:getUniqueSkillNeedExPoint()) then
		return FightEnum.ExPointState.Stored
	end

	slot4 = slot0:getClientExPoint()

	if slot1 <= math.min(slot0.totalMaxExPoint, slot2 + slot0:getServerExPoint() - slot0:getUsedExPoint()) then
		return FightEnum.ExPointState.Server
	end

	if slot1 <= math.min(slot0.totalMaxExPoint, slot2 + slot4 - slot6) then
		return FightEnum.ExPointState.Client
	end

	if slot1 <= math.min(slot0.totalMaxExPoint, math.max(slot7, slot8) + slot3) then
		return FightEnum.ExPointState.UsingUnique
	end

	return FightEnum.ExPointState.Empty
end

function slot0.getNoUsePointCurState(slot0, slot1)
	slot2 = slot0:getClientExPoint()
	slot3 = slot0:getServerExPoint()

	if slot1 <= math.min(slot0:getStoredExPoint(), slot0:getUniqueSkillNeedExPoint()) then
		return FightEnum.ExPointState.Stored
	end

	if slot0.entity:getMO():getMaxExPoint() <= slot3 then
		return FightEnum.ExPointState.ServerFull
	end

	if not FightHelper.canAddPoint(slot6) then
		if slot1 <= slot3 then
			return FightEnum.ExPointState.Server
		end

		return FightEnum.ExPointState.Lock
	else
		if slot1 <= slot3 then
			return FightEnum.ExPointState.Server
		end

		if slot1 <= slot2 then
			return FightEnum.ExPointState.Client
		end

		return FightEnum.ExPointState.Empty
	end
end

function slot0.updateExPoint(slot0, slot1)
	if slot0.entityId ~= slot1 then
		return
	end

	slot0:log("updateExPoint")

	if slot0:getUsedExPoint() > 0 then
		slot0:_updateUsedPointStatus()
	else
		slot0:_updateNoUsedPointStatus()
	end

	slot0.preClientExPoint = slot0:getClientExPoint()
end

function slot0._updateUsedPointStatus(slot0)
	slot1 = slot0:getClientExPoint()
	slot2 = slot0:getServerExPoint()
	slot3 = slot0:getUsedExPoint()
	slot6 = 0

	for slot10 = 1, math.min(slot0:getStoredExPoint(), slot0:getUniqueSkillNeedExPoint()) do
		slot11 = slot0.pointItemList[slot6 + 1]

		slot0:assetPointItem(slot11)

		if slot11 then
			slot11:directSetState(FightEnum.ExPointState.Stored)
		end
	end

	for slot12 = slot6 + 1, math.min(slot0.totalMaxExPoint, slot4 + slot2 - slot3) do
		slot13 = slot0.pointItemList[slot6 + 1]

		slot0:assetPointItem(slot13)

		if slot13 then
			slot13:directSetState(FightEnum.ExPointState.Server)
		end
	end

	for slot14 = slot6 + 1, math.min(slot0.totalMaxExPoint, slot4 + slot1 - slot3) do
		slot15 = slot0.pointItemList[slot6 + 1]

		slot0:assetPointItem(slot15)

		if slot15 then
			slot15:directSetState(FightEnum.ExPointState.Client)
		end
	end

	for slot15 = slot6 + 1, math.min(slot0.totalMaxExPoint, slot6 + slot5) do
		slot16 = slot0.pointItemList[slot6 + 1]

		slot0:assetPointItem(slot16)

		if slot16 then
			slot16:directSetState(FightEnum.ExPointState.UsingUnique)
		end
	end

	for slot15 = slot6 + 1, slot0.totalMaxExPoint do
		slot6 = slot6 + 1
		slot16 = slot0.pointItemList[slot15]

		slot0:assetPointItem(slot16)

		if slot16 then
			slot16:directSetState(FightEnum.ExPointState.Empty)
		end
	end
end

function slot0._updateNoUsedPointStatus(slot0)
	slot1 = slot0:getClientExPoint()
	slot2 = slot0:getServerExPoint()
	slot5 = 0

	for slot9 = 1, math.min(slot0:getStoredExPoint(), slot0:getUniqueSkillNeedExPoint()) do
		slot10 = slot0.pointItemList[slot5 + 1]

		slot0:assetPointItem(slot10)

		if slot10 then
			slot10:directSetState(FightEnum.ExPointState.Stored)
		end
	end

	for slot9 = slot5 + 1, slot2 do
		slot10 = slot0.pointItemList[slot5 + 1]

		slot0:assetPointItem(slot10)

		if slot10 then
			slot10:directSetState(FightEnum.ExPointState.Server)
		end
	end

	slot6 = slot0.entity:getMO()

	if slot0.totalMaxExPoint <= slot2 then
		slot0:playFullAnim()

		return
	end

	if not FightHelper.canAddPoint(slot6) then
		for slot11 = slot5 + 1, slot0.totalMaxExPoint do
			slot12 = slot0.pointItemList[slot5 + 1]

			slot0:assetPointItem(slot12)

			if slot12 then
				slot12:directSetState(FightEnum.ExPointState.Lock)
			end
		end
	else
		for slot11 = slot5 + 1, slot1 do
			slot12 = slot0.pointItemList[slot5 + 1]

			slot0:assetPointItem(slot12)

			if slot12 then
				slot12:directSetState(FightEnum.ExPointState.Client)
			end
		end

		for slot11 = slot5 + 1, slot0.totalMaxExPoint do
			slot12 = slot0.pointItemList[slot5 + 1]

			slot0:assetPointItem(slot12)

			if slot12 then
				slot12:directSetState(FightEnum.ExPointState.Empty)
			end
		end
	end
end

function slot0.onExPointMaxAdd(slot0, slot1, slot2)
	if slot0.entityId ~= slot1 then
		return
	end

	if slot0.entity:getMO():getMaxExPoint() == #slot0.pointItemList then
		return
	end

	slot0:log("激情点上限增加")

	slot0.totalMaxExPoint = slot4

	if slot5 < slot4 then
		for slot9 = slot5 + 1, slot4 do
			if slot0.configMaxPoint < slot9 then
				slot0:addExtraPointItem()
			else
				slot0:addPointItem()
			end
		end
	else
		for slot9 = slot5, slot4 + 1, -1 do
			if slot0.configMaxPoint < slot9 then
				slot0:removeExtraPointItem()
			else
				slot0:removePointItem()
			end
		end
	end

	slot0:updateSelfExPoint()
end

function slot0.onBuffUpdate(slot0, slot1, slot2, slot3)
	if slot1 ~= slot0.entityId then
		return
	end

	slot0:log("更新buff")

	slot4 = nil

	if slot2 == FightEnum.EffectType.BUFFADD then
		if FightBuffHelper.hasCantAddExPointFeature(slot3) then
			slot4 = FightEnum.ExPointState.Lock
		end
	elseif slot2 == FightEnum.EffectType.BUFFDEL then
		if FightBuffHelper.hasCantAddExPointFeature(slot3) and FightHelper.canAddPoint(slot0.entity:getMO()) then
			slot4 = FightEnum.ExPointState.Empty
		end
	end

	if slot4 then
		for slot11 = math.max(slot0.entity:getMO().exPoint, slot0:getStoredExPoint()) + 1, slot0.totalMaxExPoint do
			slot12 = slot0.pointItemList[slot11]

			slot0:assetPointItem(slot12)

			if slot12 then
				slot12:switchToState(slot4)
			end
		end
	end
end

function slot0.onExPointChange(slot0, slot1, slot2, slot3)
	if slot1 ~= slot0.entityId then
		return
	end

	if slot2 == slot3 then
		return
	end

	slot0:log("激情点改变")

	if slot2 < slot3 then
		slot0:playAddPointEffect(slot2, slot3)
	else
		slot0:playRemovePointEffect(slot2, slot3)
	end
end

function slot0.playAddPointEffect(slot0, slot1, slot2)
	slot4 = slot0:getStoredExPoint()

	if slot0.entity:getMO():getMaxExPoint() <= slot2 then
		for slot10 = math.max(slot4 + 1, 1), slot1 do
			slot11 = slot0.pointItemList[slot10]

			slot0:assetPointItem(slot11)

			if slot11 then
				slot11:delaySwitchToNextState(FightEnum.ExPointState.ServerFull, FightNameUIExPointBaseItem.AnimNameDuration[FightNameUIExPointBaseItem.AnimName.Add] + 0.13 * (slot10 - 1))
			end
		end

		for slot10 = math.max(slot4 + 1, slot1 + 1), slot2 do
			slot11 = slot0.pointItemList[slot10]

			slot0:assetPointItem(slot11)

			if slot11 then
				slot11:playAddPointEffect(FightEnum.ExPointState.ServerFull, slot5 + 0.13 * (slot10 - 1))
			end
		end
	else
		for slot9 = math.max(slot4 + 1, slot1 + 1), slot2 do
			slot10 = slot0.pointItemList[slot9]

			slot0:assetPointItem(slot10)

			if slot10 then
				slot10:playAddPointEffect()
			end
		end
	end
end

function slot0.playRemovePointEffect(slot0, slot1, slot2)
	if slot0.entity:getMO():getMaxExPoint() <= slot1 then
		for slot6, slot7 in ipairs(slot0.pointItemList) do
			slot7:directSetState(FightEnum.ExPointState.Server)
		end
	end

	for slot6 = slot2 + 1, slot1 do
		slot7 = slot0.pointItemList[slot6]

		slot0:assetPointItem(slot7)

		if slot7 then
			slot7:playAnim(FightNameUIExPointBaseItem.AnimName.Lost)
		end
	end
end

function slot0.playFullAnim(slot0)
	for slot7 = slot0:getStoredExPoint() + 1, slot0.entity:getMO().exPoint do
		slot8 = slot0.pointItemList[slot0.curPlayFullIndex]

		slot0:assetPointItem(slot8)

		if slot8 then
			slot8:delaySwitchToNextState(FightEnum.ExPointState.ServerFull, 0.13 * (slot7 - slot3))
		end
	end
end

function slot0.onMultiHpChange(slot0)
	slot0:log("onMultiHpChange")
	slot0:updateSelfExPoint()
end

function slot0.onExSkillPointChange(slot0, slot1, slot2, slot3)
	if slot0.entity and slot1 == slot0.entity.id then
		slot0:log("大招需求激情变化")
		slot0:updateSelfExPoint()
	end
end

function slot0.addPlayCardClientExPoint(slot0, slot1)
	if slot1 ~= slot0.entityId then
		return
	end

	slot0:log("增加客户端激情点")

	if slot0.entity:getMO():getMaxExPoint() <= slot0.preClientExPoint then
		slot0:updateSelfExPoint()

		return
	end

	if slot0:getClientExPoint() == slot2 then
		for slot7, slot8 in ipairs(slot0.pointItemList) do
			slot8:playAnim(FightNameUIExPointBaseItem.AnimName.Explosion)
		end
	else
		slot0:updateSelfExPoint()
	end
end

function slot0.onStoreExPointChange(slot0, slot1, slot2)
	if slot1 ~= slot0.entityId then
		return
	end

	if slot2 == slot0:getStoredExPoint() then
		return
	end

	slot0:log("溢出激情变化")

	if slot2 < slot3 then
		FightAudioMgr.instance:playAudio(20211401)
		slot0:playAddStoredPointEffect(slot2, slot3)
	else
		FightAudioMgr.instance:playAudio(20211402)
		slot0:playRemoveStoredPointEffect(slot2, slot3)
	end
end

function slot0.playAddStoredPointEffect(slot0, slot1, slot2)
	for slot6 = slot1 + 1, slot2 do
		if slot0.pointItemList[slot6] then
			slot7:switchToState(FightEnum.ExPointState.Stored)
		end
	end
end

function slot0.playRemoveStoredPointEffect(slot0, slot1, slot2)
	for slot6 = slot2 + 1, slot1 do
		if slot0.pointItemList[slot6] then
			slot7:playRemoveStoredEffect()
		end
	end
end

function slot0.assetPointItem(slot0, slot1)
end

function slot0.log(slot0, slot1)
end

function slot0.beforeDestroy(slot0)
	TaskDispatcher.cancelTask(slot0.hideTsnnEffect, slot0)

	for slot4, slot5 in ipairs(slot0.pointItemList) do
		slot5:destroy()
	end

	slot0.exPointItemList = nil
	slot0.extraExPointItemList = nil

	slot0:__onDispose()
end

return slot0
