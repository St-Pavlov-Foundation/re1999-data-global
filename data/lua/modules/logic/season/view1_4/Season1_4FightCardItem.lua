module("modules.logic.season.view1_4.Season1_4FightCardItem", package.seeall)

slot0 = class("Season1_4FightCardItem", UserDataDispose)

function slot0.ctor(slot0, slot1)
	slot0:__onInit()

	slot0.go = slot1
	slot0.goTop = gohelper.findChild(slot1, "go_top")
	slot0.imageHead = gohelper.findChildImage(slot1, "go_top/headiconbg/image_headicon")
	slot0.txtName = gohelper.findChildTextMesh(slot1, "go_top/headiconbg/txt_owner")
	slot0.goSpecialCardBg = gohelper.findChild(slot1, "bottom/left/go_specialcardbg")
	slot0.goCardPos = gohelper.findChild(slot1, "bottom/left/go_cardpos")
	slot0.goSpecialCardName = gohelper.findChild(slot1, "bottom/right/righttop/go_special")
	slot0.txtSpecialCardName = gohelper.findChildTextMesh(slot0.goSpecialCardName, "txt_specialcardname")
	slot0.goNormalName = gohelper.findChild(slot1, "bottom/right/righttop/go_normal")
	slot0.txtNormalCardName = gohelper.findChildTextMesh(slot0.goNormalName, "txt_normalcardname")
	slot0._goDesc = gohelper.findChild(slot1, "bottom/right/desclist/txt_descitem")
	slot0.layoutElement = gohelper.findChild(slot1, "bottom"):GetComponent(typeof(UnityEngine.UI.LayoutElement))
end

slot0.MainRoleItemMinHeight = 390
slot0.NormalRoleItemMinHeight = 315
slot0.RoleCardPos = {
	Vector2(-16.5, 0.5),
	Vector2(-16.5, 0.5),
	Vector2(-16.5, -6.5),
	Vector2(-16.5, -17),
	Vector2(-16.5, -1)
}

function slot0.setData(slot0, slot1)
	if not slot1 then
		gohelper.setActive(slot0.go, false)

		return
	end

	gohelper.setActive(slot0.go, true)

	slot0.trialId = slot1.trialId
	slot0.equipId = slot1.equipId
	slot0.heroUid = slot1.heroUid
	slot0.isMainRole = not slot0.heroUid or slot0.heroUid == "-100000"

	gohelper.setActive(slot0.goSpecialCardBg, slot0.isMainRole)

	slot0.layoutElement.minHeight = slot0.isMainRole and uv0.MainRoleItemMinHeight or uv0.NormalRoleItemMinHeight

	gohelper.setActive(slot0.goTop, slot1.count == 1)
	slot0:_setName()
	slot0:_setHead()
	slot0:_setCard(slot0.equipId)
	slot0:_setDesc(slot0.equipId)
end

function slot0._setName(slot0)
	if slot0.isMainRole then
		slot0.txtName.text = luaLang("seasonmainrolecardname")
	else
		slot1 = HeroModel.instance:getById(slot0.heroUid) or HeroGroupTrialModel.instance:getById(slot0.heroUid)
		slot2 = slot1 and slot1.config and slot1.config.name or ""

		if slot0.trialId and lua_hero_trial.configDict[slot0.trialId] and lua_hero_trial.configDict[slot0.trialId][0] then
			slot2 = HeroConfig.instance:getHeroCO(slot3.heroId).name or ""
		end

		slot0.txtName.text = formatLuaLang("seasoncardnames", slot2)
	end
end

function slot0._setHead(slot0)
	slot1 = Activity104Enum.MainRoleHeadIconID

	if not slot0.isMainRole then
		if (HeroModel.instance:getById(slot0.heroUid) or HeroGroupTrialModel.instance:getById(slot0.heroUid)) and slot2.skin then
			slot1 = SkinConfig.instance:getSkinCo(slot2.skin) and slot3.headIcon
		end

		if slot0.trialId and lua_hero_trial.configDict[slot0.trialId] and lua_hero_trial.configDict[slot0.trialId][0] then
			slot5 = nil
			slot5 = (slot3.skin <= 0 or SkinConfig.instance:getSkinCo(slot3.skin)) and SkinConfig.instance:getSkinCo(HeroConfig.instance:getHeroCO(slot3.heroId).skinId)
			slot1 = slot5 and slot5.headIcon
		end
	end

	gohelper.getSingleImage(slot0.imageHead.gameObject):LoadImage(ResUrl.roomHeadIcon(slot1))
end

function slot0._setCard(slot0, slot1)
	if not slot0.cardItem then
		slot0.cardItem = Season1_4CelebrityCardItem.New()

		slot0.cardItem:init(slot0.goCardPos, slot1, {
			noClick = true
		})
	else
		slot0.cardItem:reset(slot1)
	end

	slot3 = uv0.RoleCardPos[tonumber(SeasonConfig.instance:getSeasonEquipCo(slot1).rare)] or Vector2(0, 0)

	recthelper.setAnchor(slot0.goCardPos.transform, slot3.x, slot3.y)
end

function slot0._setDesc(slot0, slot1)
	if slot0.isMainRole then
		gohelper.setActive(slot0.goSpecialCardName, true)
		gohelper.setActive(slot0.goNormalName, false)

		slot0.txtSpecialCardName.text = SeasonConfig.instance:getSeasonEquipCo(slot1).name
	else
		gohelper.setActive(slot0.goNormalName, true)
		gohelper.setActive(slot0.goSpecialCardName, false)

		slot0.txtNormalCardName.text = slot2.name
	end

	slot3 = SeasonEquipMetaUtils.getSkillEffectStrList(slot2)

	for slot9, slot10 in ipairs(SeasonEquipMetaUtils.getEquipPropsStrList(slot2.attrId)) do
		table.insert({}, slot10)
	end

	for slot9, slot10 in ipairs(slot3) do
		table.insert(slot5, slot10)
	end

	if not slot0.itemList then
		slot0.itemList = slot0:getUserDataTb_()
	end

	slot9 = #slot0.itemList

	for slot9 = 1, math.max(slot9, #slot5) do
		slot0:updateDescItem(slot0.itemList[slot9] or slot0:createDescItem(slot9), slot5[slot9])
	end
end

function slot0.createDescItem(slot0, slot1)
	slot2 = {
		go = slot3,
		txtDesc = slot3:GetComponent(typeof(TMPro.TMP_Text))
	}
	slot3 = gohelper.cloneInPlace(slot0._goDesc, string.format("desc%s", slot1))
	slot0.itemList[slot1] = slot2

	return slot2
end

function slot0.updateDescItem(slot0, slot1, slot2)
	if not slot2 then
		gohelper.setActive(slot1.go, false)

		return
	end

	gohelper.setActive(slot1.go, true)

	slot1.txtDesc.text = slot2 or ""
end

function slot0.destroyDescItem(slot0, slot1)
end

function slot0.destroy(slot0)
	if slot0.itemList then
		for slot4, slot5 in ipairs(slot0.itemList) do
			slot0:destroyDescItem(slot5)
		end

		slot0.itemList = nil
	end

	if slot0.cardItem then
		slot0.cardItem:destroy()

		slot0.cardItem = nil
	end

	slot0:__onDispose()
end

return slot0
