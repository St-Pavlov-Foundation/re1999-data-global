module("modules.common.others.SkillHelper", package.seeall)

slot0 = class("SkillHelper")

function slot0.getTagDescRecursion(slot0, slot1)
	slot1 = slot1 or "#6680bd"
	slot3 = ""
	slot4 = {}

	for slot8 = 1, #HeroSkillModel.instance:getEffectTagIDsFromDescRecursion(slot0) do
		if SkillConfig.instance:getSkillEffectDescCo(slot2[slot8]) then
			slot10 = slot9.name

			if (not slot9.notAddLink or slot9.notAddLink == 0) and not slot4[slot10] then
				slot4[slot10] = true
				slot11 = uv0.buildDesc(slot9.desc)
				slot3 = LangSettings.instance:isEn() and slot3 .. string.format("<color=%s>[%s]</color>: %s\n", slot1, slot10, slot11) or slot3 .. string.format("<color=%s>[%s]</color>: %s\n", slot1, slot10, slot11) .. string.format("<color=%s>[%s]</color>:%s\n", slot1, slot10, slot11)
			end
		end
	end

	return slot3
end

function slot0.addHyperLinkClick(slot0, slot1, slot2)
	if gohelper.isNil(slot0) then
		logError("textComp is nil, please check !!!")

		return
	end

	gohelper.onceAddComponent(slot0, typeof(ZProj.TMPHyperLinkClick)):SetClickListener(slot1 or uv0.defaultClick, slot2)
end

function slot0.defaultClick(slot0, slot1)
	CommonBuffTipController.instance:openCommonTipView(slot0, slot1)
end

function slot0.getSkillDesc(slot0, slot1, slot2, slot3)
	return uv0.buildDesc(FightConfig.instance:getSkillEffectDesc(slot0, slot1), slot2, slot3)
end

function slot0.buildDesc(slot0, slot1, slot2)
	return uv0.addColor(uv0.addLink(slot0), slot1, slot2)
end

function slot0.getEntityDescBySkillCo(slot0, slot1, slot2, slot3)
	return uv0.getSkillDesc(FightConfig.instance:getEntityName(slot0), slot1, slot2, slot3)
end

function slot0.getEntityDescBySkillId(slot0, slot1)
	if not lua_skill.configDict[slot1] then
		logError("技能表找不到id : " .. tostring(slot1))

		return ""
	end

	return uv0.getSkillDesc(FightConfig.instance:getEntityName(slot0), slot2)
end

function slot0.addColor(slot0, slot1, slot2)
	return uv0.addBracketColor(uv0.addNumColor(slot0, slot1), slot2)
end

function slot0.addBracketColor(slot0, slot1)
	if string.nilorempty(slot1) then
		slot1 = "#4e6698"
	end

	slot2 = uv0.getColorFormat(slot1, "%1")

	return string.gsub(string.gsub(slot0, "%[.-%]", slot2), "【.-】", slot2)
end

function slot0.addNumColor(slot0, slot1)
	if string.nilorempty(slot1) then
		slot1 = "#C66030"
	end

	slot2 = uv0.getColorFormat(slot1, "%1")

	return string.gsub(string.gsub(slot0, "[+-]?%d+%.%d+%%", slot2), "[+-]?%d+%%", slot2)
end

function slot0.getColorFormat(slot0, slot1)
	return string.format("<color=%s>%s</color>", slot0, slot1)
end

function slot0.addLink(slot0)
	return string.gsub(string.gsub(slot0, "%[(.-)%]", uv0._replaceDescTagFunc1), "【(.-)】", uv0._replaceDescTagFunc2)
end

function slot0._replaceDescTagFunc1(slot0)
	slot0 = uv0.removeRichTag(slot0)

	if not SkillConfig.instance:getSkillEffectDescCoByName(slot0) then
		return string.format("[%s]", slot0)
	end

	if not slot1.notAddLink or slot1.notAddLink == 0 then
		return string.format("[<u><link=%s>%s</link></u>]", slot1.id, slot0)
	end

	return string.format("[%s]", slot0)
end

function slot0._replaceDescTagFunc2(slot0)
	slot0 = uv0.removeRichTag(slot0)

	if not SkillConfig.instance:getSkillEffectDescCoByName(slot0) then
		return string.format("【%s】", slot0)
	end

	if not slot1.notAddLink or slot1.notAddLink == 0 then
		return string.format("【<u><link=%s>%s</link></u>】", slot1.id, slot0)
	end

	return string.format("【%s】", slot0)
end

function slot0.removeRichTag(slot0)
	return string.gsub(slot0, "<.->", "")
end

function slot0.canShowTag(slot0)
	return slot0 and (not slot0.notAddLink or slot0.notAddLink == 0)
end

return slot0
