module("modules.logic.resonance.model.TalentStyle.TalentStyleModel", package.seeall)

slot0 = class("TalentStyleModel", BaseModel)

function slot0.openView(slot0, slot1)
	slot0._heroId = slot1
	slot0._heroMo = HeroModel.instance:getByHeroId(slot1)
	slot0._selectStyleId = nil
	slot0._unlockIdList = slot0:getUnlockStyle(slot1)
	slot0._newUnlockStyle = nil

	slot0:refreshNewState(slot1)
	TalentStyleListModel.instance:initData(slot1)
end

function slot0.getHeroMainCubeMo(slot0, slot1)
	return HeroModel.instance:getByHeroId(slot1) and slot2.talentCubeInfos:getMainCubeMo()
end

function slot0.getHeroUseCubeStyleId(slot0, slot1)
	return HeroModel.instance:getByHeroId(slot1) and slot2:getHeroUseCubeStyleId()
end

function slot0.getHeroUseCubeId(slot0, slot1)
	return HeroModel.instance:getByHeroId(slot1) and slot2:getHeroUseStyleCubeId()
end

function slot0.UseStyle(slot0, slot1, slot2)
	if slot2 then
		if slot2._isUnlock then
			if not slot2._isUse then
				HeroRpc.instance:setUseTalentStyleRequest(slot1, slot0:getTalentTemplateId(slot1), slot2._styleId)
				slot0:selectCubeStyle(slot1, slot2._styleId)
			end
		elseif HeroModel.instance:getByHeroId(slot1).config.heroType == 6 then
			GameFacade.showToast(ToastEnum.TalentStyleLock2)
		else
			GameFacade.showToast(ToastEnum.TalentStyleLock1)
		end
	end
end

function slot0.getTalentTemplateId(slot0, slot1)
	return HeroModel.instance:getByHeroId(slot1) and slot2.useTalentTemplateId
end

function slot0.getHeroUseCubeMo(slot0, slot1)
	return slot0:getCubeMoByStyle(slot1, slot0:getHeroUseCubeStyleId(slot1))
end

function slot0.getSelectStyleId(slot0, slot1)
	if not slot0._selectStyleId then
		slot0._selectStyleId = slot0:getHeroUseCubeStyleId(slot1)
	end

	return slot0._selectStyleId
end

function slot0.selectCubeStyle(slot0, slot1, slot2)
	if slot0._selectStyleId == slot2 then
		return
	end

	slot0._selectStyleId = slot2

	slot0:setNewSelectStyle(slot2)
	TalentStyleListModel.instance:refreshData(slot1, slot2)
	CharacterController.instance:dispatchEvent(CharacterEvent.onSelectTalentStyle, slot2)
end

function slot0.getSelectCubeMo(slot0, slot1)
	slot2 = slot0:getSelectStyleId(slot1)

	if slot0:getStyleCoList(slot1) and slot3[slot2] then
		return slot3[slot2]
	end

	slot0:selectCubeStyle(slot1, 0)
end

function slot0.clear(slot0)
	slot0:setHeroUseSelectId()
end

function slot0.getTalentStyle(slot0, slot1, slot2)
	if HeroResonanceConfig.instance:getTalentStyle(slot1) and slot3[slot2] then
		return slot3[slot2]
	end
end

function slot0.getStyleCoList(slot0, slot1)
	if slot0:getHeroMainCubeMo(slot1) and slot2 and slot2.id then
		return HeroResonanceConfig.instance:getTalentStyle(slot3)
	end
end

function slot0.getStyleMoList(slot0, slot1)
	return slot0:refreshMoList(slot1, slot0:getStyleCoList(slot1))
end

function slot0.refreshMoList(slot0, slot1, slot2)
	slot3 = {}

	if slot2 then
		slot6, slot7, slot8 = slot0:getCurInfo(slot1)

		for slot12, slot13 in pairs(slot2) do
			if slot13:isCanUnlock(HeroModel.instance:getByHeroId(slot1) and slot4.talent or 0) then
				slot13:onRefresh(slot6, slot7, LuaUtil.tableContains(slot8, slot13._styleId))
				table.insert(slot3, slot13)
			end
		end
	end

	return slot3
end

function slot0.refreshNewState(slot0, slot1)
	for slot7, slot8 in pairs(slot0:getStyleMoList(slot1)) do
		slot8:setNew(HeroModel.instance:getByHeroId(slot1).isShowTalentStyleRed)
	end
end

function slot0.hideNewState(slot0, slot1)
	for slot6, slot7 in pairs(slot0:getStyleMoList(slot1)) do
		slot7:setNew(false)
	end
end

function slot0.getCurInfo(slot0, slot1)
	return slot0:getHeroUseCubeStyleId(slot1), slot0:getSelectStyleId(slot1), slot0._unlockIdList
end

function slot0.getCubeMoByStyle(slot0, slot1, slot2)
	if slot0:getStyleCoList(slot1) and slot3[slot2] then
		return slot3[slot2]
	end

	return slot3 and slot3[0]
end

function slot0.refreshUnlockInfo(slot0, slot1)
	slot0:refreshUnlockList(slot1)

	slot3, slot4, slot5 = slot0:getCurInfo(slot1)

	for slot9, slot10 in pairs(slot0:getStyleCoList(slot1)) do
		slot10:onRefresh(slot3, slot4, LuaUtil.tableContains(slot5, slot10._styleId))
	end
end

function slot0.getUnlockStyle(slot0, slot1)
	slot3 = 0

	if slot0:getStyleCoList(slot1) then
		for slot7, slot8 in pairs(slot2) do
			slot3 = math.max(slot7, slot3)
		end
	end

	return slot0:parseUnlock(HeroModel.instance:getByHeroId(slot1).talentStyleUnlock, slot3)
end

function slot0.refreshUnlockList(slot0, slot1)
	slot0._unlockIdList = slot0:getUnlockStyle(slot1)
end

function slot0.parseUnlock(slot0, slot1, slot2)
	slot4 = slot1

	for slot8 = slot2, 0, -1 do
		if slot4 >= 2^slot8 then
			table.insert({}, slot8)

			if slot4 - slot9 == 0 then
				break
			end
		end
	end

	if slot4 ~= 0 then
		logError("解锁数据计算错误：" .. slot1)
	end

	return slot3
end

function slot0.getLevelUnlockStyle(slot0, slot1, slot2)
	for slot7, slot8 in pairs(HeroResonanceConfig.instance:getTalentStyle(slot1)) do
		if slot8._styleCo.level == slot2 then
			return true
		end
	end
end

function slot0.isUnlockStyleSystem(slot0, slot1)
	return slot1 >= 10
end

function slot0.setNewUnlockStyle(slot0, slot1)
	slot0._newUnlockStyle = slot1
end

function slot0.getNewUnlockStyle(slot0)
	return slot0._newUnlockStyle
end

function slot0.setNewSelectStyle(slot0, slot1)
	slot0._newSelectStyle = slot1
end

function slot0.getNewSelectStyle(slot0)
	return slot0._newSelectStyle
end

function slot0.isPlayAnim(slot0, slot1, slot2)
	return GameUtil.playerPrefsGetNumberByUserId(slot0:getPlayUnlockAnimKey(slot1, slot2), 0) == 0
end

function slot0.setPlayAnim(slot0, slot1, slot2)
	return GameUtil.playerPrefsSetNumberByUserId(slot0:getPlayUnlockAnimKey(slot1, slot2), 1)
end

function slot0.getPlayUnlockAnimKey(slot0, slot1, slot2)
	return "TalentStyleModel_PlayUnlockAnim_" .. slot1 .. "_" .. slot2
end

function slot0.isPlayStyleEnterBtnAnim(slot0, slot1)
	return GameUtil.playerPrefsGetNumberByUserId(slot0:getPlayStyleEnterBtnAnimKey(slot1), 0) == 0
end

function slot0.setPlayStyleEnterBtnAnim(slot0, slot1)
	return GameUtil.playerPrefsSetNumberByUserId(slot0:getPlayStyleEnterBtnAnimKey(slot1), 1)
end

function slot0.getPlayStyleEnterBtnAnimKey(slot0, slot1)
	return "PlayStyleEnterBtnAnimKey_" .. slot1
end

function slot0.setHeroTalentStyleStatInfo(slot0, slot1)
	if not slot0.unlockStateInfo then
		slot0.unlockStateInfo = {}
	end

	if not slot0.unlockStateInfo[slot1.heroId] then
		slot0.unlockStateInfo[slot1.heroId] = {}
	end

	slot2 = 0

	if slot1.stylePercentList then
		for slot6 = 1, #slot1.stylePercentList do
			slot7 = slot1.stylePercentList[slot6]
			slot8 = slot0:getCubeMoByStyle(slot1.heroId, slot7.style)

			slot8:setUnlockPercent(slot7.percent)

			slot0.unlockStateInfo[slot1.heroId][slot7.style] = slot8
			slot2 = math.max(slot7.percent, slot2)
		end
	end

	if slot0.unlockStateInfo[slot1.heroId] then
		for slot6, slot7 in pairs(slot0.unlockStateInfo[slot1.heroId]) do
			slot7:setHotUnlockStyle(slot2 == slot7:getUnlockPercent())
		end
	end
end

function slot0.sortUnlockPercent(slot0, slot1)
	return slot1:getUnlockPercent() < slot0:getUnlockPercent()
end

function slot0.getHeroTalentStyleStatInfo(slot0, slot1)
	return slot0.unlockStateInfo and slot0.unlockStateInfo[slot1]
end

slot0.instance = slot0.New()

return slot0
