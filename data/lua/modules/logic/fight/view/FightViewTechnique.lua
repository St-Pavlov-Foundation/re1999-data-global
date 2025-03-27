module("modules.logic.fight.view.FightViewTechnique", package.seeall)

slot0 = class("FightViewTechnique", BaseView)
slot1, slot2, slot3, slot4, slot5, slot6 = nil

function slot0.onInitView(slot0)
	if not uv0 then
		uv0 = {}
		uv1 = {}
		uv2 = {}
		uv3 = {}
		uv4 = {}

		for slot4, slot5 in ipairs(lua_fight_technique.configList) do
			for slot10, slot11 in ipairs(string.split(slot5.condition, "|")) do
				if string.split(slot11, "#")[1] == "1" then
					uv0[tonumber(slot12[2])] = slot5.id
				elseif slot12[1] == "2" then
					uv1[tonumber(slot12[2])] = slot5.id
				elseif slot12[1] == "3" then
					uv5 = slot5.id
				elseif slot12[1] == "4" then
					table.insert(uv2, slot5.id)
				elseif slot12[1] == "5" then
					table.insert(uv3, slot5.id)
				elseif slot12[1] == "6" then
					table.insert(uv4, slot5.id)
				end
			end
		end
	end

	slot0._scrollGO = gohelper.findChild(slot0.viewGO, "root/#scroll_effecttips")
	slot0._originY = recthelper.getAnchorY(slot0._scrollGO.transform)
end

function slot0.addEvents(slot0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightTechnique) then
		return
	end

	slot0:addEventCb(FightController.instance, FightEvent.OnBuffUpdate, slot0._onBuffUpdate, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnDistributeCards, slot0._onDistributeCards, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.BeforePlaySkill, slot0._beforePlaySkill, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0)
	slot0:addEventCb(PlayerController.instance, PlayerEvent.UpdateSimpleProperty, slot0._updateSimpleProperty, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.SetStateForDialogBeforeStartFight, slot0._onSetStateForDialogBeforeStartFight, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.TriggerCardShowResistanceTag, slot0.onTriggerCardShowResistanceTag, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.ASFD_StartAllocateCardEnergy, slot0.onStartAllocateCardEnergy, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.AddUseCard, slot0.AddUseCard, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnBuffUpdate, slot0._onBuffUpdate, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnDistributeCards, slot0._onDistributeCards, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.BeforePlaySkill, slot0._beforePlaySkill, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0)
	slot0:removeEventCb(PlayerController.instance, PlayerEvent.UpdateSimpleProperty, slot0._updateSimpleProperty, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.SetStateForDialogBeforeStartFight, slot0._onSetStateForDialogBeforeStartFight, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.TriggerCardShowResistanceTag, slot0.onTriggerCardShowResistanceTag, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.ASFD_StartAllocateCardEnergy, slot0.onStartAllocateCardEnergy, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.AddUseCard, slot0.AddUseCard, slot0)
end

function slot0.onOpen(slot0)
	FightViewTechniqueModel.instance:initFromSimpleProperty()
	slot0:_udpateAnchorY()
end

function slot0.onTriggerCardShowResistanceTag(slot0)
	for slot4, slot5 in ipairs(uv0) do
		slot0:_checkAdd(slot5)
	end
end

function slot0.onStartAllocateCardEnergy(slot0)
	for slot4, slot5 in ipairs(uv0) do
		slot0:_checkAdd(slot5)
	end
end

function slot0.AddUseCard(slot0, slot1)
	if FightPlayCardModel.instance:getUsedCards()[slot1] and FightHelper.isASFDSkill(slot3.skillId) then
		for slot7, slot8 in ipairs(uv0) do
			slot0:_checkAdd(slot8)
		end
	end
end

function slot0._onBuffUpdate(slot0, slot1, slot2, slot3)
	if slot2 ~= FightEnum.EffectType.BUFFADD then
		return
	end

	if not lua_skill_buff.configDict[slot3] then
		return
	end

	if not uv0[slot4.typeId] then
		return
	end

	slot0:_checkAdd(slot5)
end

function slot0._onDistributeCards(slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnDistributeCards, slot0._onDistributeCards, slot0)

	if not (FightModel.instance:getFightParam().battleId and uv0[slot1]) then
		return
	end

	slot0:_checkAdd(slot2)
end

function slot0._beforePlaySkill(slot0, slot1, slot2, slot3)
	if not slot1:getMO() then
		return
	end

	slot0._rejectTypes = nil
	slot0._rejectIds = nil

	for slot8, slot9 in pairs(slot1:getMO():getBuffDic()) do
		if not string.nilorempty(lua_skill_bufftype.configDict[lua_skill_buff.configDict[slot9.buffId].typeId].rejectTypes) then
			slot12 = string.split(slot11.rejectTypes, "#")
			slot13 = string.split(slot12[2], ",")
			slot14 = nil

			if slot12[1] == "1" then
				slot0._rejectTypes = slot0._rejectTypes or {}
				slot14 = slot0._rejectTypes
			elseif slot12[1] == "2" then
				slot0._rejectIds = slot0._rejectIds or {}
				slot14 = slot0._rejectIds
			end

			if slot14 then
				for slot18, slot19 in ipairs(slot14) do
					slot14[slot19] = true
				end
			end
		end
	end
end

function slot0._onSkillPlayFinish(slot0, slot1, slot2, slot3)
	if not uv0 then
		return
	end

	if not slot1:isMySide() then
		return
	end

	if slot1.id == FightEntityScene.MySideId or slot1.id == FightEntityScene.EnemySideId then
		return
	end

	if not lua_skill.configDict[slot2] then
		return
	end

	slot5 = {
		[slot10.buff.buffId] = true
	}

	for slot9, slot10 in ipairs(slot3.actEffectMOs) do
		if (slot10.effectType == FightEnum.EffectType.BUFFADD or slot10.effectType == FightEnum.EffectType.BUFFUPDATE) and slot10.buff then
			-- Nothing
		end
	end

	for slot9 = 1, FightEnum.MaxBehavior do
		if not string.nilorempty(slot4["behavior" .. slot9]) then
			slot11 = FightStrUtil.instance:getSplitToNumberCache(slot10, "#")

			if slot11[1] == 1 and not slot5[slot13] and not (slot0._rejectTypes and slot0._rejectTypes[lua_skill_buff.configDict[slot11[2]].typeId] or slot0._rejectIds and slot0._rejectIds[slot13]) then
				slot0:_checkAdd(uv0)

				break
			end
		end
	end
end

function slot0._checkAdd(slot0, slot1)
	if not FightViewTechniqueModel.instance:addUnread(slot1) then
		return
	end

	PlayerRpc.instance:sendSetSimplePropertyRequest(PlayerEnum.SimpleProperty.FightTechnique, FightViewTechniqueModel.instance:getPropertyStr())
	slot0:_udpateAnchorY()
end

function slot0._updateSimpleProperty(slot0, slot1)
	if slot1 == PlayerEnum.SimpleProperty.FightTechnique then
		slot0:_udpateAnchorY()
	end
end

function slot0._udpateAnchorY(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(FightViewTechniqueModel.instance:getList()) do
		if lua_fight_technique.configDict[slot6.id] and slot7.iconShow == "1" then
			table.insert(slot1, slot6)

			if #slot1 >= 3 then
				break
			end
		end
	end

	FightViewTechniqueListModel.instance:showUnreadFightViewTechniqueList(slot1)

	if #slot1 >= 3 then
		recthelper.setAnchorY(slot0._scrollGO.transform, slot0._originY)
	elseif slot2 > 0 then
		recthelper.setAnchorY(slot0._scrollGO.transform, slot0._originY - (3 - slot2) * 140 / 2)
	end

	gohelper.setActive(slot0._scrollGO, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.FightTechnique) and slot2 > 0)
end

function slot0._onSetStateForDialogBeforeStartFight(slot0, slot1)
	gohelper.setActive(slot0._scrollGO, not slot1)

	if not slot1 then
		slot0:_udpateAnchorY()
	end
end

return slot0
