module("modules.logic.versionactivity2_3.act174.view.info.Act174CharacterInfo", package.seeall)

slot0 = class("Act174CharacterInfo", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0._view = slot1
end

slot0.AttrIdList = {
	CharacterEnum.AttrId.Attack,
	CharacterEnum.AttrId.Defense,
	CharacterEnum.AttrId.Technic,
	CharacterEnum.AttrId.Hp,
	CharacterEnum.AttrId.Mdefense
}

function slot0.init(slot0, slot1)
	slot0._go = slot1
	slot0.imageDmgType = gohelper.findChildImage(slot1, "go_characterinfo/image_dmgtype")
	slot0.imageRare = gohelper.findChildImage(slot1, "go_characterinfo/character/rare")
	slot0.heroIcon = gohelper.findChildSingleImage(slot1, "go_characterinfo/character/heroicon")
	slot0.imageCareer = gohelper.findChildImage(slot1, "go_characterinfo/character/career")
	slot0.txtName = gohelper.findChildText(slot1, "go_characterinfo/name/txt_name")
	slot0.goSkill = gohelper.findChild(slot1, "go_characterinfo/go_skill")
	slot0.txtPassiveName = gohelper.findChildText(slot1, "go_characterinfo/passiveskill/bg/txt_passivename")
	slot0.btnPassiveSkill = gohelper.findChildButtonWithAudio(slot1, "go_characterinfo/passiveskill/btn_passiveskill")
	slot5 = slot0.onClickPassiveSkill

	slot0:addClickCb(slot0.btnPassiveSkill, slot5, slot0)

	for slot5 = 1, 5 do
		slot6 = gohelper.findChild(slot1, "go_characterinfo/attribute/go_attribute/attribute" .. slot5)
		slot0["txtAttr" .. slot5] = gohelper.findChildText(slot6, "txt_attribute")
		slot0["txtAttrName" .. slot5] = gohelper.findChildText(slot6, "name")
	end

	for slot5 = 1, 3 do
		slot0["goPassiveSkill" .. slot5] = gohelper.findChild(slot1, "go_characterinfo/passiveskill/go_passiveskills/passiveskill" .. slot5)
	end

	slot0._detailPassiveTables = {}
	slot0.goDetail = gohelper.findChild(slot1, "go_characterinfo/go_detailView")

	if slot0.goDetail then
		slot0.btnCloseDetail = gohelper.findChildButtonWithAudio(slot1, "go_characterinfo/go_detailView/btn_detailClose")
		slot0.goDetailItem = gohelper.findChild(slot1, "go_characterinfo/go_detailView/scroll_content/viewport/content/go_detailpassiveitem")

		slot0:addClickCb(slot0.btnCloseDetail, slot0.onClickCloseDetail, slot0)
	end

	if slot0._view then
		if slot0._view.__cname == "Act174GameTeamView" then
			slot0.skillItem1 = slot0:getUserDataTb_()
			slot0.skillItem1.btnSkill = gohelper.findChildButtonWithAudio(slot0.goSkill, "line/go_skills/skillicon1/btn_first")
			slot0.skillItem1.gogray = gohelper.findChild(slot0.goSkill, "line/go_skills/skillicon1/btn_first/grey")
			slot0.skillItem1.gohighlight = gohelper.findChild(slot0.goSkill, "line/go_skills/skillicon1/btn_first/highlight")

			slot0:addClickCb(slot0.skillItem1.btnSkill, slot0.onClickSkill, slot0, 1)

			slot0.skillItem2 = slot0:getUserDataTb_()
			slot0.skillItem2.btnSkill = gohelper.findChildButtonWithAudio(slot0.goSkill, "line/go_skills/skillicon2/btn_first")
			slot0.skillItem2.gogray = gohelper.findChild(slot0.goSkill, "line/go_skills/skillicon2/btn_first/grey")
			slot0.skillItem2.gohighlight = gohelper.findChild(slot0.goSkill, "line/go_skills/skillicon2/btn_first/highlight")

			slot0:addClickCb(slot0.skillItem2.btnSkill, slot0.onClickSkill, slot0, 2)

			slot0.btnUnEquip = gohelper.findChildButtonWithAudio(slot1, "go_characterinfo/btn_unequip")

			slot0:addClickCb(slot0.btnUnEquip, slot0.onClickUnEquip, slot0)
		end

		slot0.goNoneCollection = gohelper.findChild(slot1, "go_characterinfo/go_collection/none")
		slot0.goCollection = gohelper.findChild(slot1, "go_characterinfo/go_collection/equip")
		slot0.colletionRare = gohelper.findChildImage(slot1, "go_characterinfo/go_collection/equip/rare")
		slot0.collectionIcon = gohelper.findChildSingleImage(slot1, "go_characterinfo/go_collection/equip/collectionicon")
		slot0.btnCollection = gohelper.findChildButtonWithAudio(slot1, "go_characterinfo/go_collection/equip/collectionicon")

		slot0:addClickCb(slot0.btnCollection, slot0.onClickCollection, slot0)
	end

	slot0._skillContainer = MonoHelper.addNoUpdateLuaComOnceToGo(slot0.goSkill, Act174SkillContainer)
end

function slot0.onDestroy(slot0)
	if slot0.heroIcon then
		slot0.heroIcon:UnLoadImage()
	end

	if slot0.collectionIcon then
		slot0.collectionIcon:UnLoadImage()
	end
end

function slot0.setData(slot0, slot1, slot2, slot3)
	slot0.config = slot1
	slot0.collectionId = slot2
	slot0.index = slot3

	if slot0.heroIcon then
		slot0.heroIcon:LoadImage(ResUrl.getHeadIconSmall(slot1.skinId))
		UISpriteSetMgr.instance:setCommonSprite(slot0.imageRare, "bgequip" .. tostring(CharacterEnum.Color[slot1.rare]))
		UISpriteSetMgr.instance:setCommonSprite(slot0.imageCareer, "lssx_" .. slot1.career)
	end

	if slot0.imageDmgType then
		UISpriteSetMgr.instance:setCommonSprite(slot0.imageDmgType, "dmgtype" .. tostring(slot1.dmgType))
	end

	slot0.txtName.text = slot1.name
	slot5 = lua_activity174_template.configDict[slot1.id]

	for slot9 = 1, 5 do
		slot0["txtAttrName" .. slot9].text = lua_character_attribute.configDict[uv0.AttrIdList[slot9]].name
	end

	slot0["txtAttr" .. 1].text = slot5.attack
	slot0["txtAttr" .. 2].text = slot5.defense
	slot0["txtAttr" .. 3].text = slot5.technic
	slot0["txtAttr" .. 4].text = slot5.life
	slot0["txtAttr" .. 5].text = slot5.mdefense
	slot0.txtPassiveName.text = lua_skill.configDict[string.splitToNumber(slot1.passiveSkill, "|")[1]].name
	slot7 = nil

	for slot11 = 1, 3 do
		gohelper.setActive(slot0["goPassiveSkill" .. slot11], slot11 <= (slot1.type == Activity174Enum.CharacterType.Hero and #SkillConfig.instance:getheroranksCO(slot1.heroId) - 1 or 0))
	end

	slot0._skillContainer:onUpdateMO(slot1)

	if slot0._view and slot0._view.__cname == "Act174GameTeamView" then
		slot0.skillIndex = slot0._view:getPriorSkill(slot0.config.id)
	end

	slot0:refreshSkillPrior()
	slot0:refreshCollectionInfo()
end

function slot0.onClickPassiveSkill(slot0)
	slot0:refreshPassiveDetail()
	gohelper.setActive(slot0.goDetail, true)
end

function slot0.onClickSkill(slot0, slot1)
	if slot1 == slot0.skillIndex then
		slot1 = nil
	end

	slot0._view:setPriorSkill(slot0.config.id, slot1)

	slot0.skillIndex = slot1

	slot0:refreshSkillPrior()
end

function slot0.refreshCollectionInfo(slot0)
	if slot0._view then
		if slot0.collectionId then
			slot1 = Activity174Config.instance:getCollectionCo(slot0.collectionId)

			UISpriteSetMgr.instance:setAct174Sprite(slot0.colletionRare, "act174_propitembg_" .. slot1.rare)
			slot0.collectionIcon:LoadImage(ResUrl.getRougeSingleBgCollection(slot1.icon))
		end

		gohelper.setActive(slot0.goCollection, slot0.collectionId)
		gohelper.setActive(slot0.goNoneCollection, not slot0.collectionId)
	else
		gohelper.setActive(slot0.goCollection, false)
		gohelper.setActive(slot0.goNoneCollection, true)
	end
end

function slot0.refreshSkillPrior(slot0)
	if slot0._view and slot0._view.__cname == "Act174GameTeamView" then
		slot1 = slot0.skillIndex == 1

		gohelper.setActive(slot0.skillItem1.gohighlight, slot1)
		gohelper.setActive(slot0.skillItem1.gogray, not slot1)

		slot2 = slot0.skillIndex == 2

		gohelper.setActive(slot0.skillItem2.gohighlight, slot2)
		gohelper.setActive(slot0.skillItem2.gogray, not slot2)
	end
end

function slot0.onClickCollection(slot0)
	if slot0.collectionId then
		Activity174Controller.instance:openItemTipView({
			type = Activity174Enum.ItemTipType.Collection,
			co = Activity174Config.instance:getCollectionCo(slot0.collectionId),
			showMask = true
		})
	end
end

function slot0.refreshPassiveDetail(slot0)
	for slot9 = 1, #Activity174Config.instance:getHeroPassiveSkillIdList(slot1, tabletool.indexOf(Activity174Model.instance:getActInfo():getGameInfo():getWarehouseInfo().enhanceRoleList, slot0.config.id) and true or false) do
		if lua_skill.configDict[tonumber(slot4[slot9])] then
			if not slot0._detailPassiveTables[slot9] then
				slot13 = gohelper.cloneInPlace(slot0.goDetailItem, "item" .. slot9)
				slot12 = slot0:getUserDataTb_()
				slot12.go = slot13
				slot12.name = gohelper.findChildText(slot13, "title/txt_name")
				slot12.icon = gohelper.findChildSingleImage(slot13, "title/simage_icon")
				slot12.desc = gohelper.findChildText(slot13, "txt_desc")

				SkillHelper.addHyperLinkClick(slot12.desc, slot0.onClickHyperLink, slot0)

				slot12.line = gohelper.findChild(slot13, "txt_desc/image_line")

				table.insert(slot0._detailPassiveTables, slot12)
			end

			slot12.name.text = slot11.name
			slot12.desc.text = SkillHelper.getSkillDesc(slot0.config.name, slot11)

			gohelper.setActive(slot12.go, true)
			gohelper.setActive(slot12.line, slot9 < slot5)
		else
			logError(string.format("被动技能配置没找到, id: %d", slot10))
		end
	end

	for slot9 = slot5 + 1, #slot0._detailPassiveTables do
		gohelper.setActive(slot0._detailPassiveTables[slot9].go, false)
	end
end

function slot0.onClickCloseDetail(slot0)
	gohelper.setActive(slot0.goDetail, false)
end

function slot0.onClickHyperLink(slot0, slot1, slot2)
	CommonBuffTipController:openCommonTipViewWithCustomPos(slot1, Vector2.New(0, 0))
end

function slot0.onClickUnEquip(slot0)
	if slot0._view and slot0._view.__cname == "Act174GameTeamView" then
		slot0._view:UnInstallHero(slot0.index)
		gohelper.setActive(slot0._go, false)
	end
end

return slot0
