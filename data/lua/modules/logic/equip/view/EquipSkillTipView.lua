module("modules.logic.equip.view.EquipSkillTipView", package.seeall)

slot0 = class("EquipSkillTipView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._goskill = gohelper.findChild(slot0.viewGO, "#go_skill")
	slot0._btnclosedetail = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_skill/#btn_closedetail")
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "#go_skill/Scroll View/Viewport/#go_content")
	slot0._txtattributelv = gohelper.findChildText(slot0.viewGO, "#go_skill/Scroll View/Viewport/#go_content/attributename/#txt_attributelv")
	slot0._txtmeshcurlevel = gohelper.findChildText(slot0.viewGO, "#go_skill/Scroll View/Viewport/#go_content/#go_suiteffect/#txt_meshcurlevel")
	slot0._txtmeshalllevel = gohelper.findChildTextMesh(slot0.viewGO, "#go_skill/Scroll View/Viewport/#go_content/allleveldesc/#txtmesh_alllevel")
	slot0._gocharacter = gohelper.findChild(slot0.viewGO, "#go_character")
	slot0._scrollcharacter = gohelper.findChildScrollRect(slot0.viewGO, "#go_character/#scroll_character")
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "#go_character/#txt_title")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnclosedetail:AddClickListener(slot0._btnclosedetailOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btnclosedetail:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnclosedetailOnClick(slot0)
	slot0:hideCharacter()
end

function slot0._editableInitView(slot0)
	slot0._hyperLinkClick = gohelper.onceAddComponent(slot0._txtmeshalllevel.gameObject, typeof(ZProj.TMPHyperLinkClick))

	slot0._hyperLinkClick:SetClickListener(slot0._onHyperLinkClick, slot0)

	slot0._hyperLinkClick2 = gohelper.onceAddComponent(slot0._txtmeshcurlevel.gameObject, typeof(ZProj.TMPHyperLinkClick))

	slot0._hyperLinkClick2:SetClickListener(slot0._onHyperLinkClick, slot0)
end

function slot0._onHyperLinkClick(slot0)
	slot0:showCharacter()
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._equipMO = slot0.viewParam[1]
	slot0._equipId = slot0._equipMO and slot0._equipMO.config.id or slot0.viewParam[2]
	slot0._showCharacter = slot0.viewParam[3]
	slot0._characterScreenPos = slot0.viewParam[4]
	slot0._config = slot0._equipMO and slot0._equipMO.config or EquipConfig.instance:getEquipCo(slot0._equipId)
	slot0._breakLv = slot0._equipMO and slot0._equipMO.breakLv or EquipConfig.instance:getMaxBreakLevel()
	slot0._level = slot0._equipMO and slot0._equipMO.level or EquipConfig.instance:getMaxLevel(slot0._breakLv)
	slot0._refineLv = slot0._equipMO and slot0._equipMO.refineLv or 1
	slot0._equipSkillCo = EquipConfig.instance:getEquipSkillCfg(slot0._config.skillType, slot0._refineLv)

	gohelper.setActive(slot0._gocharacter, false)
	gohelper.setActive(slot0._goskill, false)
	gohelper.setActive(slot0._btnclosedetail.gameObject, false)

	if slot0._showCharacter then
		slot0:showCharacter()
	else
		slot0:showSkill()
	end

	NavigateMgr.instance:addEscape(ViewName.EquipSkillTipView, slot0._btncloseOnClick, slot0)
end

function slot0.showCharacter(slot0)
	gohelper.setActive(slot0._gocharacter, true)

	slot0._txttitle.text = string.format(luaLang("equip_suitable_characters"), slot0._config.feature)

	if not string.nilorempty(slot0._config.cardGroup) then
		slot2 = {}

		for slot6, slot7 in ipairs(string.split(slot0._config.cardGroup, "|")) do
			table.insert(slot2, {
				id = tonumber(slot7)
			})
		end

		EquipSkillCharacterListModel.instance:setList(slot2)
	end

	if slot0._characterScreenPos then
		slot1 = recthelper.screenPosToAnchorPos(slot0._characterScreenPos, slot0.viewGO.transform)

		recthelper.setAnchor(slot0._gocharacter.transform, slot1.x, slot1.y)
	end

	gohelper.setActive(slot0._btnclosedetail.gameObject, true)
end

function slot0.hideCharacter(slot0)
	gohelper.setActive(slot0._gocharacter, false)
	gohelper.setActive(slot0._btnclosedetail.gameObject, false)
end

function slot0.showSkill(slot0)
	gohelper.setActive(slot0._goskill, true)
	slot0:showCurLevel()
	slot0:showAllLevel()
end

function slot0.showCurLevel(slot0)
	slot1 = EquipConfig.instance:getEquipSkillCfg(slot0._config.skillType, slot0._refineLv)
	slot0._txtattributelv.text = slot1.skillLv + 1
	slot0._txtmeshcurlevel.text = string.format("%s", HeroSkillModel.instance:spotSkillAttribute(slot1.baseDesc))
end

function slot0.showAllLevel(slot0)
	if slot0._config.skillType <= 0 then
		return
	end

	slot2 = slot0._txtmeshalllevel.preferredHeight
	slot3 = ""
	slot7 = slot1
	slot8 = slot0._refineLv
	slot0._curSkillCfg = EquipConfig.instance:getEquipSkillCfg(slot7, slot8)

	for slot7, slot8 in pairs(lua_equip_skill.configDict[slot1]) do
		if slot7 > 0 then
			if not LuaUtil.isEmptyStr(slot8.spUpDesc) then
				slot9 = string.format("%s\n<#4b93d6><u><link='%s'>[%s]</link></u></color>:%s", string.format("Lv.%s:%s", slot7 + 1, HeroSkillModel.instance:spotSkillAttribute(slot8.upDesc)), slot7, slot0._config.feature, HeroSkillModel.instance:spotSkillAttribute(slot8.spUpDesc))
			end

			if slot8 == slot0._curSkillCfg then
				slot9 = string.format("<#805e00>%s</color>", slot9)
			end

			slot3 = slot3 == "" and slot9 or string.format("%s\n%s", slot9, slot9)
		end
	end

	slot0._txtmeshalllevel.text = slot3

	recthelper.setHeight(slot0._gocontent.transform, recthelper.getHeight(slot0._gocontent.transform) + slot0._txtmeshalllevel.preferredHeight - slot2)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
