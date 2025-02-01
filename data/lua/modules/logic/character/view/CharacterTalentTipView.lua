module("modules.logic.character.view.CharacterTalentTipView", package.seeall)

slot0 = class("CharacterTalentTipView", BaseView)

function slot0.onInitView(slot0)
	slot0._goroleAttributeTip = gohelper.findChild(slot0.viewGO, "#go_roleAttributeTip")
	slot0._scrollattribute = gohelper.findChildScrollRect(slot0.viewGO, "#go_roleAttributeTip/#scroll_attribute")
	slot0._goattributeContent = gohelper.findChild(slot0.viewGO, "#go_roleAttributeTip/#scroll_attribute/Viewport/#go_attributeContent")
	slot0._goattributeItem = gohelper.findChild(slot0.viewGO, "#go_roleAttributeTip/#scroll_attribute/Viewport/#go_attributeContent/#go_attributeItem")
	slot0._scrollreduce = gohelper.findChildScrollRect(slot0.viewGO, "#go_roleAttributeTip/#scroll_reduce")
	slot0._goreducetitle = gohelper.findChild(slot0.viewGO, "#go_roleAttributeTip/#go_reducetitle")
	slot0._godampingContent = gohelper.findChild(slot0.viewGO, "#go_roleAttributeTip/#scroll_reduce/Viewport/#go_dampingContent")
	slot0._goreduceItem = gohelper.findChild(slot0.viewGO, "#go_roleAttributeTip/#scroll_reduce/Viewport/#go_dampingContent/#go_reduceItem")
	slot0._gotip = gohelper.findChild(slot0.viewGO, "#go_tip")
	slot0._scrollattributetip = gohelper.findChildScrollRect(slot0.viewGO, "#go_tip/#scroll_attributetip")
	slot0._gosingleContent = gohelper.findChild(slot0.viewGO, "#go_tip/#scroll_attributetip/Viewport/layout/#go_singleContent")
	slot0._gosingleattributeItem = gohelper.findChild(slot0.viewGO, "#go_tip/#scroll_attributetip/Viewport/layout/#go_singleContent/#go_singleattributeItem")
	slot0._goempty = gohelper.findChild(slot0.viewGO, "#go_roleAttributeTip/#go_empty")
	slot0._gotrialAttributeTip = gohelper.findChild(slot0.viewGO, "#go_trialAttributeTip")
	slot0._gotrialattributeContent = gohelper.findChild(slot0.viewGO, "#go_trialAttributeTip/scrollview/viewport/content")
	slot0._gotrialattributeitem = gohelper.findChild(slot0.viewGO, "#go_trialAttributeTip/scrollview/viewport/content/attrnormalitem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addClickCb(gohelper.getClick(slot0.viewGO), slot0.closeThis, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.hero_id = slot0.viewParam.hero_id
	slot0.open_type = slot0.viewParam.open_type
	slot0.hero_mo_data = slot0.viewParam.hero_mo or HeroModel.instance:getByHeroId(slot0.hero_id)
	slot0._isOwnHero = slot0.viewParam.isOwnHero

	if slot0.viewParam.isTrial then
		gohelper.setActive(slot0._goroleAttributeTip, false)
		gohelper.setActive(slot0._gotip, false)
		gohelper.setActive(slot0._gotrialAttributeTip, true)
	else
		gohelper.setActive(slot0._goroleAttributeTip, slot0.open_type == 0)
		gohelper.setActive(slot0._gotrialAttributeTip, false)
		gohelper.setActive(slot0._gotip, slot0.open_type ~= 0)
	end

	if slot0.open_type == 0 then
		slot0:_showAllattr()
	else
		slot0:_showSingleCubeAttr(slot0.viewParam.cube_id)
	end
end

function slot0._showSingleCubeAttr(slot0, slot1)
	slot2 = {}

	slot0.hero_mo_data:getTalentStyleCubeAttr(slot1, slot2)

	slot3 = {}
	slot4 = slot0.hero_mo_data:getCurTalentLevelConfig(slot1)

	for slot8, slot9 in pairs(slot2) do
		table.insert(slot3, {
			key = slot8,
			value = slot9,
			is_special = slot4.calculateType == 1,
			config = slot4
		})
	end

	table.sort(slot3, function (slot0, slot1)
		return HeroConfig.instance:getIDByAttrType(slot0.key) < HeroConfig.instance:getIDByAttrType(slot1.key)
	end)
	table.insert(slot3, 1, {})
	table.insert(slot3, 1, {})
	gohelper.CreateObjList(slot0, slot0._onShowSingleCubeAttrTips, slot3, slot0._gosingleContent, slot0._gosingleattributeItem)
end

function slot0._onShowSingleCubeAttrTips(slot0, slot1, slot2, slot3)
	if slot3 ~= 1 and slot3 ~= 2 then
		slot4 = slot1.transform
		slot7 = slot4:Find("num"):GetComponent(gohelper.Type_TextMesh)
		slot8 = HeroConfig.instance:getHeroAttributeCO(HeroConfig.instance:getIDByAttrType(slot2.key))
		slot4:Find("name"):GetComponent(gohelper.Type_TextMesh).text = slot8.name

		UISpriteSetMgr.instance:setCommonSprite(slot4:Find("icon"):GetComponent(gohelper.Type_Image), "icon_att_" .. slot8.id)

		if slot8.type ~= 1 then
			slot2.value = slot2.value / 10 .. "%"
		elseif not slot2.is_special then
			slot2.value = slot2.config[slot2.key] / 10 .. "%"
		else
			slot2.value = math.floor(slot2.value)
		end

		slot7.text = slot2.value
	end
end

function slot0.isOwnHero(slot0)
	if slot0._isOwnHero ~= nil then
		return slot0._isOwnHero
	end

	return slot0.hero_mo_data and slot0.hero_mo_data:isOwnHero()
end

function slot0._showAllattr(slot0)
	slot2 = {}

	for slot6, slot7 in pairs(slot0.hero_mo_data:getTalentGain()) do
		table.insert(slot2, slot7)
	end

	table.sort(slot2, function (slot0, slot1)
		return HeroConfig.instance:getIDByAttrType(slot0.key) < HeroConfig.instance:getIDByAttrType(slot1.key)
	end)

	if not slot0:isOwnHero() then
		gohelper.CreateObjList(slot0, slot0._onItemShow, slot2, slot0._gotrialattributeContent, slot0._gotrialattributeitem)

		return
	end

	slot8 = slot0._goattributeItem

	gohelper.CreateObjList(slot0, slot0._onItemShow, slot2, slot0._goattributeContent, slot8)

	slot4 = {}

	for slot8, slot9 in ipairs(slot0.hero_mo_data.talentCubeInfos.data_list) do
		if not slot4[slot9.cubeId] then
			slot4[slot9.cubeId] = {}
		end

		table.insert(slot4[slot9.cubeId], slot9)
	end

	slot5 = SkillConfig.instance:getTalentDamping()
	slot6 = {}

	for slot10, slot11 in pairs(slot4) do
		if slot5[1][1] <= #slot11 and (slot5[2][1] <= #slot11 and slot5[2][2] or slot5[1][2]) or nil then
			table.insert(slot6, {
				cube_id = slot10,
				damping = slot12
			})
		end
	end

	gohelper.setActive(slot0._goreducetitle, GameUtil.getTabLen(slot6) > 0)
	gohelper.setActive(slot0._scrollreduce.gameObject, slot7 > 0)
	gohelper.setActive(slot0._goempty, slot7 <= 0 and #slot2 <= 0)
	gohelper.setActive(slot0._scrollattribute.gameObject, #slot2 > 0)
	gohelper.CreateObjList(slot0, slot0._onDampingItemShow, slot6, slot0._godampingContent, slot0._goreduceItem)
end

function slot0._onDampingItemShow(slot0, slot1, slot2, slot3)
	slot1.name = slot2.cube_id
	slot4 = slot1.transform

	UISpriteSetMgr.instance:setCharacterTalentSprite(slot4:Find("icon"):GetComponent(gohelper.Type_Image), HeroResonanceConfig.instance:getCubeConfig(slot2.cube_id).icon, true)

	slot4:Find("reduceNum"):GetComponent(gohelper.Type_TextMesh).text = slot2.damping / 10 .. "%"

	slot0:addClickCb(gohelper.getClick(slot4:Find("clickarea").gameObject), slot0._onDampingClick, slot0, slot1)
end

function slot0._onDampingClick(slot0, slot1)
	gohelper.setActive(slot0._gotip, true)
	slot0:_showSingleCubeAttr(tonumber(slot1.name))
end

function slot0._onItemShow(slot0, slot1, slot2, slot3)
	slot4 = slot1.transform
	slot5 = slot4:Find("icon"):GetComponent(gohelper.Type_Image)
	slot6 = slot4:Find("name"):GetComponent(gohelper.Type_TextMesh)
	slot7 = slot4:Find("num"):GetComponent(gohelper.Type_TextMesh)

	if HeroConfig.instance:getHeroAttributeCO(HeroConfig.instance:getIDByAttrType(slot2.key)).type ~= 1 then
		slot2.value = tonumber(string.format("%.3f", slot2.value / 10)) .. "%"
	else
		slot2.value = math.floor(slot2.value)
	end

	slot7.text = slot2.value
	slot6.text = slot8.name

	UISpriteSetMgr.instance:setCommonSprite(slot5, "icon_att_" .. slot8.id, true)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
