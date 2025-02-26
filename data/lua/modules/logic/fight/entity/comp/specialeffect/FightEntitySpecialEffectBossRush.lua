module("modules.logic.fight.entity.comp.specialeffect.FightEntitySpecialEffectBossRush", package.seeall)

slot0 = class("FightEntitySpecialEffectBossRush", UserDataDispose)
slot1 = "_STYLIZATIONMOSTER2_ON"
slot2 = "_NoiseMap3"
slot3 = "noise_02_manual"
slot4 = "_Pow"
slot5 = {
	0,
	0.75,
	0.85,
	0.95
}
slot6 = {
	[51400031.0] = true,
	[514000102.0] = true
}
slot7 = 1

function slot0.ctor(slot0, slot1)
	slot0:__onInit()

	slot0._entity = slot1
	slot0._textureAssetItem = nil
	slot0._texture = nil
	slot0._isLoadingTexture = false
	slot0._stageEffectList = {}

	TaskDispatcher.runDelay(slot0._delayCheckMat, slot0, 0.01)
	slot0:addEventCb(FightController.instance, FightEvent.OnBuffUpdate, slot0._onBuffUpdate, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnSpineLoaded, slot0._onSpineLoaded, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnSkillPlayStart, slot0._onSkillPlayStart, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0)
end

function slot0._onSkillPlayStart(slot0, slot1, slot2, slot3, slot4)
	if slot1 and slot0._entity ~= slot1 and slot1:getMO() and slot1:getMO():isUniqueSkill(slot2) then
		slot0._uniqueSkill = slot2

		slot0:hideSpecialEffects("UniqueSkill")
	end
end

function slot0._onSkillPlayFinish(slot0, slot1, slot2, slot3, slot4)
	if slot0._uniqueSkill and slot2 == slot0._uniqueSkill then
		slot0._uniqueSkill = nil

		slot0:showSpecialEffects("UniqueSkill")
	end
end

function slot0._onBuffUpdate(slot0, slot1, slot2, slot3, slot4)
	if slot1 ~= slot0._entity.id then
		return
	end

	if uv0[slot3] then
		if slot2 == FightEnum.EffectType.BUFFDEL then
			if slot0._entity.spineRenderer:getReplaceMat() then
				slot5:DisableKeyword(uv1)
			end

			slot0:_delayCheckMat()
		else
			TaskDispatcher.cancelTask(slot0._delayCheckMat, slot0)
			TaskDispatcher.runDelay(slot0._delayCheckMat, slot0, 0.5 / FightModel.instance:getSpeed())
		end
	end
end

function slot0._delayCheckMat(slot0)
	slot0._pow_w_Value = nil

	if not slot0._entity.spineRenderer:getReplaceMat() then
		return
	end

	slot2 = 0
	slot4 = false

	for slot8, slot9 in pairs(slot0._entity:getMO():getBuffDic()) do
		if uv0[slot9.buffId] then
			slot4 = true
			slot2 = 1

			break
		end
	end

	slot5 = nil
	slot6 = false

	if not slot4 and Mathf.Clamp((BossRushModel.instance:getMultiHpInfo() and slot7.multiHpIdx or 0) + 1, 1, 4) ~= 1 then
		slot6 = true
		slot2 = uv1[slot5]
	end

	slot0:_dealHangPointEffect(slot5, slot4)

	if not slot4 and not slot6 then
		return
	end

	slot0._pow_w_Value = slot2

	slot1:EnableKeyword(uv2)

	slot7 = slot1:GetVector(uv3)
	slot7.w = slot2

	slot1:SetVector(uv3, slot7)

	if slot0._isLoadingTexture then
		return
	end

	if slot0._texture then
		slot0:_setTexture()
	else
		loadAbAsset(ResUrl.getRoleSpineMatTex(uv4), false, slot0._onLoadCallback, slot0)
	end
end

function slot0._onLoadCallback(slot0, slot1)
	if slot1.IsLoadSuccess then
		slot0._isLoadingTexture = false
		slot0._textureAssetItem = slot1

		slot1:Retain()

		slot0._texture = slot1:GetResource()

		slot0:_setTexture()
	end
end

function slot0._setTexture(slot0)
	slot0._entity.spineRenderer:getReplaceMat():SetTexture(uv0, slot0._texture)

	for slot6, slot7 in ipairs(FightHelper.getSideEntitys(slot0._entity:getSide())) do
		if slot7 ~= slot0._entity then
			slot0:_setOtherPartMat(slot7)
		end
	end
end

function slot0._onSpineLoaded(slot0, slot1)
	if not slot0._pow_w_Value or slot0._pow_w_Value == 1 then
		return
	end

	if slot1.unitSpawn:getSide() == slot0._entity:getSide() and slot2 ~= slot0._entity then
		slot0:_setOtherPartMat(slot2)
	end
end

function slot0._setOtherPartMat(slot0, slot1)
	if not slot0._pow_w_Value or slot0._pow_w_Value == 1 then
		return
	end

	if slot1.spineRenderer and slot1.spineRenderer:getReplaceMat() then
		slot2:EnableKeyword(uv0)

		slot3 = slot2:GetVector(uv1)
		slot3.w = slot0._pow_w_Value

		slot2:SetVector(uv1, slot3)
		slot2:SetTexture(uv2, slot0._texture)
	end
end

function slot0._dealHangPointEffect(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot0._stageEffectList) do
		FightEffectPool.returnEffect(slot7)
		FightEffectPool.returnEffectToPoolContainer(slot7)
		FightRenderOrderMgr.instance:onRemoveEffectWrap(slot0._entity.id, slot7)
	end

	tabletool.clear(slot0._stageEffectList)

	if slot2 then
		return
	end

	if lua_bossrush_skin_effect.configDict[slot0._entity:getMO().skin] then
		slot5 = slot0._entity:getSide()

		for slot9, slot10 in pairs(slot4) do
			if slot1 == slot10.stage then
				for slot17, slot18 in ipairs(string.split(slot10.effects, "#")) do
					slot22 = FightEffectPool.getEffect(FightHelper.getEffectUrlWithLod(slot18), slot5, nil, , slot0._entity:getHangPoint(string.split(slot10.hangpoints, "#")[slot17] or ModuleEnum.SpineHangPointRoot))

					FightRenderOrderMgr.instance:onAddEffectWrap(slot0._entity.id, slot22)
					slot22:setLocalPos(0, 0, 0)
					slot22:setEffectScale(string.splitToNumber(string.split(slot10.scales, "#")[slot17], ",")[1] or 1, slot23[2] or 1, slot23[3] or 1)
					table.insert(slot0._stageEffectList, slot22)
				end

				break
			end
		end
	end
end

function slot0.showSpecialEffects(slot0, slot1)
	if not slot0._stageEffectList then
		return
	end

	slot0:_clearMissingEffect()

	for slot5, slot6 in ipairs(slot0._stageEffectList) do
		slot6:setActive(true, slot1 or slot0.__cname)
	end
end

function slot0.hideSpecialEffects(slot0, slot1)
	if not slot0._stageEffectList then
		return
	end

	slot0:_clearMissingEffect()

	for slot5, slot6 in ipairs(slot0._stageEffectList) do
		slot6:setActive(false, slot1 or slot0.__cname)
	end
end

function slot0._clearMissingEffect(slot0)
	for slot4 = #slot0._stageEffectList, 1, -1 do
		if gohelper.isNil(slot0._stageEffectList[slot4].containerGO) then
			table.remove(slot0._stageEffectList, slot4)
		end
	end
end

function slot0.releaseSelf(slot0)
	if slot0._stageEffectList then
		for slot4, slot5 in ipairs(slot0._stageEffectList) do
			FightEffectPool.returnEffect(slot5)
			FightEffectPool.returnEffectToPoolContainer(slot5)
			FightRenderOrderMgr.instance:onRemoveEffectWrap(slot0._entity.id, slot5)
		end
	end

	slot0._stageEffectList = nil

	TaskDispatcher.cancelTask(slot0._delayCheckMat, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnBuffUpdate, slot0._onBuffUpdate, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnSpineLoaded, slot0._onSpineLoaded, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnSkillPlayStart, slot0._onSkillPlayStart, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0)

	if slot0._textureAssetItem then
		slot0._textureAssetItem:Release()

		slot0._textureAssetItem = nil
	end

	slot0._texture = nil

	slot0:__onDispose()
end

function slot0.disposeSelf(slot0)
	slot0:releaseSelf()
end

return slot0
