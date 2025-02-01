module("modules.logic.fight.controller.FightBuffGetDescHelper", package.seeall)

slot0 = _M

function slot0.getBuffDesc(slot0)
	if not slot0 then
		return ""
	end

	if not lua_skill_buff.configDict[slot0.buffId] then
		return ""
	end

	if string.nilorempty(slot0.actCommonParams) then
		return uv0.buildDesc(slot1.desc)
	end

	for slot6, slot7 in ipairs(string.split(slot0.actCommonParams, "|")) do
		if lua_buff_act.configDict[tonumber(string.split(slot7, "#")[1])] and uv0.getBuffFeatureHandle(slot10.type) then
			return uv0.buildDesc(slot11(slot0, slot1, slot10, slot8))
		end
	end

	return uv0.buildDesc(slot1.desc)
end

function slot0.buildDesc(slot0)
	return SkillHelper.buildDesc(slot0, "#D65F3C", "#485E92")
end

function slot0.getBuffFeatureHandle(slot0)
	if not uv0.FeatureHandleDict then
		uv0.FeatureHandleDict = {
			[FightEnum.BuffFeature.InjuryBank] = uv0.getInjuryBankDesc,
			[FightEnum.BuffFeature.AttrFixFromInjuryBank] = uv0.getAttrFixFromInjuryBankDesc,
			[FightEnum.BuffFeature.ModifyAttrByBuffLayer] = uv0.getModifyAttrByBuffLayerDesc,
			[FightEnum.BuffFeature.ResistancesAttr] = uv0.getResistancesAttrDesc
		}
	end

	return uv0.FeatureHandleDict[slot0]
end

function slot0.getInjuryBankDesc(slot0, slot1, slot2, slot3)
	return GameUtil.getSubPlaceholderLuaLangTwoParam(slot1.desc, slot3[2], slot3[3])
end

function slot0.getAttrFixFromInjuryBankDesc(slot0, slot1, slot2, slot3)
	slot4 = tonumber(slot3[2]) or 0

	return GameUtil.getSubPlaceholderLuaLangOneParam(slot1.desc, slot4 < 1 and 1 or math.floor(slot4))
end

function slot0.getModifyAttrByBuffLayerDesc(slot0, slot1, slot2, slot3)
	if tonumber(slot3[2] or 0) < 1 then
		slot4 = 1
	end

	return GameUtil.getSubPlaceholderLuaLangOneParam(slot1.desc, math.floor(slot4))
end

function slot0.getResistancesAttrDesc(slot0, slot1, slot2, slot3)
	return GameUtil.getSubPlaceholderLuaLangOneParam(slot1.desc, math.floor(tonumber(slot3[3]) / 10) .. "%%")
end

return slot0
