module("modules.logic.character.model.HeroSkillModel", package.seeall)

slot0 = class("HeroSkillModel", BaseModel)

function slot0.formatDescWithColor_overseas(slot0, slot1, slot2, slot3, slot4)
	slot2 = slot2 or "#d7a270"
	slot3 = slot3 or "#5f7197"

	if slot4 ~= true then
		slot6 = {}
		slot7 = 0

		if LangSettings.instance:isEn() then
			slot5 = string.gsub(string.gsub(string.gsub(string.gsub(slot1, "(%[.-%])", function (slot0)
				uv0 = uv0 + 1
				uv1[uv0] = slot0

				return "{" .. uv0 .. "}"
			end), "(【.-】)", function (slot0)
				uv0 = uv0 + 1
				uv1[uv0] = slot0

				return "{" .. uv0 .. "}"
			end), "%b<>", function (slot0)
				uv0 = uv0 + 1
				uv1[uv0] = slot0

				return "{" .. uv0 .. "}"
			end), "%w+%-%w+", function (slot0)
				uv0 = uv0 + 1
				uv1[uv0] = slot0

				return "{" .. uv0 .. "}"
			end)
		end

		slot5 = string.gsub(string.gsub(slot5, "([%d%-%+%%%./]+)", string.format("<color=%s>%%1</color>", slot2)), "%b{}", function (slot0)
			return uv0[tonumber(string.sub(string.gsub(slot0, "%b<>", ""), 2, -2))] or ""
		end)
	end

	return string.gsub(string.gsub(slot5, "(%[.-%])", string.format("<color=%s>%%1</color>", slot3)), "(【.-】)", string.format("<color=%s>%%1</color>", slot3))
end

function slot0.onInit(slot0)
	slot0._skillTagInfos = {}
end

function slot0._initSkillTagInfos(slot0)
	slot0._skillTagInfos = {}

	for slot5, slot6 in pairs(SkillConfig.instance:getSkillEffectDescsCo()) do
		slot0._skillTagInfos[slot6.name] = slot6
	end
end

function slot0.isTagSkillInfo(slot0, slot1)
	return slot0._skillTagInfos[slot1]
end

function slot0.getSkillTagInfoColorType(slot0, slot1)
	return slot0._skillTagInfos[slot1].color
end

function slot0.getSkillTagInfoDesc(slot0, slot1)
	return slot0._skillTagInfos[slot1].desc
end

function slot0.getEffectTagIDsFromDescNotRecursion(slot0, slot1)
	slot0:_initSkillTagInfos()

	slot2 = {}
	slot1 = slot1 or ""
	slot6 = "]"

	for slot6 in string.gmatch(string.gsub(string.gsub(slot1, "【", "["), "】", slot6), "%[(.-)%]") do
		if string.nilorempty(slot6) or slot0._skillTagInfos[slot6] == nil then
			logError(string.format(" '%s' 技能描述中， '%s' tag 不存在", slot1, slot6))
		else
			table.insert(slot2, slot0._skillTagInfos[slot6].id)
		end
	end

	return slot2
end

function slot0.getEffectTagIDsFromDescRecursion(slot0, slot1)
	return slot0:treeLevelTraversal(slot0:getEffectTagIDsFromDescNotRecursion(slot1), {}, {})
end

function slot0.getEffectTagDescFromDescRecursion(slot0, slot1, slot2)
	slot4 = ""
	slot5 = {}

	for slot9 = 1, #uv0.instance:getEffectTagIDsFromDescRecursion(slot1) do
		if SkillConfig.instance:getSkillEffectDescCo(slot3[slot9]) and uv0.instance:canShowSkillTag(slot10.name) and not slot5[slot11] then
			slot5[slot11] = true
			slot4 = (LangSettings.instance:isZh() or LangSettings.instance:isTw()) and slot4 .. string.format("<color=%s>[%s]</color>：%s\n", slot2, slot11, slot10.desc) or slot4 .. string.format("<color=%s>[%s]</color>：%s\n", slot2, slot11, slot10.desc) .. string.format("<color=%s>[%s]</color>: %s\n", slot2, slot11, slot10.desc)
		end
	end

	return slot4
end

function slot0.getEffectTagDescIdList(slot0, slot1)
	slot3 = {}
	slot4 = {}

	for slot8 = 1, #uv0.instance:getEffectTagIDsFromDescRecursion(slot1) do
		if SkillConfig.instance:getSkillEffectDescCo(slot2[slot8]) and uv0.instance:canShowSkillTag(slot9.name) and not slot4[slot10] then
			slot4[slot10] = true

			table.insert(slot3, slot9.id)
		end
	end

	return slot3
end

function slot0.canShowSkillTag(slot0, slot1, slot2)
	return SkillHelper.canShowTag(SkillConfig.instance:getSkillEffectDescCoByName(slot1))
end

function slot0.getSkillEffectTagIdsFormDescTabRecursion(slot0, slot1)
	slot3 = {}

	for slot8 = 1, #slot1 do
	end

	return {
		[slot8] = slot0:treeLevelTraversal(slot0:getEffectTagIDsFromDescNotRecursion(slot1[slot8]), {}, {})
	}
end

function slot0.treeLevelTraversal(slot0, slot1, slot2, slot3)
	if #slot1 == 0 then
		return slot2
	end

	for slot7 = 1, #slot1 do
		if not slot3[table.remove(slot1, 1)] then
			slot3[slot8] = true

			table.insert(slot2, slot8)

			slot13 = slot8

			for slot13, slot14 in ipairs(slot0:getEffectTagIDsFromDescNotRecursion(SkillConfig.instance:getSkillEffectDescCo(slot13).desc)) do
				if not slot3[slot14] then
					table.insert(slot1, slot14)
				end
			end
		end
	end

	return slot0:treeLevelTraversal(slot1, slot2, slot3)
end

function slot0.skillDesToSpot(slot0, slot1, slot2, slot3, slot4)
	if string.nilorempty(slot2) then
		slot2 = "#C66030"
	end

	if string.nilorempty(slot3) then
		slot3 = "#4e6698"
	end

	return SkillConfig.instance:processSkillDesKeyWords(slot0:spotSkillAttribute(string.gsub(string.gsub(string.gsub(string.gsub(string.gsub(string.gsub(string.gsub(string.gsub(string.gsub(string.gsub(slot1, "(%-%d+%%)", "{%1}"), "(%+%d+%%)", "{%1}"), "(%-%d+%.*%d*%%)", "{%1}"), "(%d+%.*%d*%%)", "{%1}"), "%[", string.format("<color=%s>[", slot3)), "%【", string.format("<color=%s>[", slot3)), "%]", "]</color>"), "%】", "]</color>"), "%{", string.format("<color=%s>", slot2)), "%}", "</color>"), slot4))
end

function slot0.spotSkillAttribute(slot0, slot1, slot2)
	for slot8, slot9 in pairs(HeroConfig.instance:getHeroAttributesCO()) do
		if slot9.showcolor == 1 and not slot2 then
			slot3 = string.gsub(slot1, slot9.name, string.format("<u>%s</u>", slot9.name))
		end
	end

	return slot3
end

function slot0.formatDescWithColor_local(slot0, slot1, slot2, slot3, slot4)
	slot3 = slot3 or "#5f7197"

	if slot4 ~= true then
		slot6 = {}
		slot7 = 0
		slot8 = 0
		slot5 = string.gsub(string.gsub(string.gsub(string.gsub(slot1, "(%[.-%])", function (slot0)
			uv0 = uv0 + 1
			uv1[uv0] = slot0

			return "▩replace▩"
		end), "(【.-】)", function (slot0)
			uv0 = uv0 + 1
			uv1[uv0] = slot0

			return "▩replace▩"
		end), "([%d%-%+%%%./]+)", string.format("<color=%s>%%1</color>", slot2 or "#d7a270")), "▩replace▩", function ()
			uv0 = uv0 + 1

			return uv1[uv0]
		end)
	end

	return string.gsub(string.gsub(slot5, "(%[.-%])", string.format("<color=%s>%%1</color>", slot3)), "(【.-】)", string.format("<color=%s>%%1</color>", slot3))
end

function slot0.formatDescWithColor(slot0, slot1, slot2, slot3, slot4)
	return slot0:formatDescWithColor_overseas(slot1, slot2, slot3, slot4)
end

slot0.instance = slot0.New()

return slot0
