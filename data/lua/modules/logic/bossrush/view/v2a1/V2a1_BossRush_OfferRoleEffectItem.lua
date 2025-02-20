module("modules.logic.bossrush.view.v2a1.V2a1_BossRush_OfferRoleEffectItem", package.seeall)

slot0 = class("V2a1_BossRush_OfferRoleEffectItem", BaseChildView)

function slot0.onInitView(slot0)
	slot0._goline = gohelper.findChild(slot0.viewGO, "image_Line")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._txt = slot0.viewGO:GetComponent(gohelper.Type_TextMesh)
end

slot1 = "OfferRoleEffectItem_skillNameDesc"

function slot0.activeLine(slot0, slot1)
	gohelper.setActive(slot0._goline, slot1)
end

function slot0.updateInfo(slot0, slot1, slot2, slot3)
	slot0.parentView = slot1
	slot0._needUseSkillEffDescList = {}
	slot0._needUseSkillEffDescList2 = {}
	slot0._heroId = slot3
	slot4, slot5, slot0._skillIndex = slot0:_parseDesc(slot2)
	slot0._hyperLinkClick = slot0.viewGO:GetComponent(typeof(ZProj.TMPHyperLinkClick))

	slot0._hyperLinkClick:SetClickListener(slot0._onHyperLinkClick, slot0)

	slot0._txt.text = string.gsub(slot0:addNumColor(string.gsub(slot0:addLink(slot2), "▩(%d)%%s", uv0)), uv0, slot0:_buildSkillNameLinkTag(slot5))
	slot0._fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(slot0.viewGO.gameObject, FixTmpBreakLine)

	slot0._fixTmpBreakLine:refreshTmpContent(slot0.viewGO)
end

function slot0._parseDesc(slot0, slot1)
	slot2, slot3, slot4 = string.find(slot1, "▩(%d)%%s")

	if not slot4 then
		return slot1
	end

	slot5 = nil

	if not ((tonumber(slot4) ~= 0 or SkillConfig.instance:getpassiveskillsCO(slot0._heroId)[1].skillPassive) and SkillConfig.instance:getHeroBaseSkillIdDict(slot0._heroId)[slot4]) then
		return slot1
	end

	return slot1, lua_skill.configDict[slot5].name, slot4
end

slot2 = "#7e99d0"

function slot0._buildSkillNameLinkTag(slot0, slot1)
	return slot1 and string.format(luaLang("V2a1_BossRush_OfferRoleEffectItem_skillname_link_overseas"), uv0, slot1) or ""
end

function slot0.addLink(slot0, slot1)
	return string.gsub(string.gsub(slot1, "%[(.-)%]", slot0.addLinkCb1), "【(.-)】", slot0.addLinkCb2)
end

function slot3(slot0, slot1)
	slot1 = SkillHelper.removeRichTag(slot1)

	if not SkillConfig.instance:getSkillEffectDescCoByName(slot1) then
		return slot1
	end

	slot3 = uv0
	slot1 = string.format(slot0, slot1)

	if not slot2.notAddLink or slot2.notAddLink == 0 then
		return string.format("<color=%s><u><link=%s>%s</link></u></color>", slot3, slot2.id, slot1)
	end

	return string.format("<color=%s>%s</color>", slot3, slot1)
end

function slot0.addLinkCb1(slot0)
	return uv0("[%s]", slot0)
end

function slot0.addLinkCb2(slot0)
	return uv0("【%s】", slot0)
end

function slot0.addNumColor(slot0, slot1)
	return slot0:revertRichText(string.gsub(slot0:filterRichText(slot1), "[+-]?[%d%./%%]+", SkillHelper.getColorFormat("#deaa79", "%1")))
end

function slot0.replaceColorFunc(slot0)
	if string.find(slot0, "[<>]") then
		return slot0
	end
end

slot0.richTextList = {}
slot0.replaceText = "▩replace▩"
slot0.replaceIndex = 0

function slot0.filterRichText(slot0, slot1)
	tabletool.clear(uv0.richTextList)

	return string.gsub(slot1, "(<.->)", slot0._filterRichText)
end

function slot0._filterRichText(slot0)
	table.insert(uv0.richTextList, slot0)

	return uv0.replaceText
end

function slot0.revertRichText(slot0, slot1)
	uv0.replaceIndex = 0

	tabletool.clear(uv0.richTextList)

	return string.gsub(slot1, uv0.replaceText, slot0._revertRichText)
end

function slot0._revertRichText(slot0)
	uv0.replaceIndex = uv0.replaceIndex + 1

	return uv0.richTextList[uv0.replaceIndex] or ""
end

function slot0._onHyperLinkClick(slot0, slot1, slot2)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	if slot1 ~= "skillIndex" then
		CommonBuffTipController.instance:openCommonTipViewWithCustomPos(tonumber(slot1), CommonBuffTipEnum.Anchor[ViewName.CharacterExSkillView], CommonBuffTipEnum.Pivot.Right)
	elseif slot0._skillIndex == 0 then
		slot4 = HeroMo.New()
		slot9 = {
			tag = "passiveskill",
			heroid = slot0._heroId,
			tipPos = Vector2.New(-292, -51.1),
			anchorParams = {
				Vector2.New(1, 0.5),
				Vector2.New(1, 0.5)
			},
			buffTipsX = -776
		}

		slot4:init(slot9, HeroConfig.instance:getHeroCO(slot0._heroId))

		slot4.passiveSkillLevel = {}

		for slot9 = 1, 3 do
			table.insert(slot4.passiveSkillLevel, slot9)
		end

		slot3.heroMo = slot4

		CharacterController.instance:openCharacterTipView(slot3)
	else
		ViewMgr.instance:openView(ViewName.SkillTipView, {
			super = slot0._skillIndex == 3,
			skillIdList = SkillConfig.instance:getHeroAllSkillIdDictByExSkillLevel(slot0._heroId)[slot0._skillIndex],
			monsterName = HeroConfig.instance:getHeroCO(slot0._heroId).name,
			anchorX = -500
		})
	end
end

function slot0.onOpen(slot0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
