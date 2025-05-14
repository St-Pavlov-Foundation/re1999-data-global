module("modules.logic.versionactivity2_3.act174.view.info.Act174CharacterInfo", package.seeall)

local var_0_0 = class("Act174CharacterInfo", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._view = arg_1_1
end

var_0_0.AttrIdList = {
	CharacterEnum.AttrId.Attack,
	CharacterEnum.AttrId.Defense,
	CharacterEnum.AttrId.Technic,
	CharacterEnum.AttrId.Hp,
	CharacterEnum.AttrId.Mdefense
}

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0._go = arg_2_1
	arg_2_0.imageDmgType = gohelper.findChildImage(arg_2_1, "go_characterinfo/image_dmgtype")
	arg_2_0.imageRare = gohelper.findChildImage(arg_2_1, "go_characterinfo/character/rare")
	arg_2_0.heroIcon = gohelper.findChildSingleImage(arg_2_1, "go_characterinfo/character/heroicon")
	arg_2_0.imageCareer = gohelper.findChildImage(arg_2_1, "go_characterinfo/character/career")
	arg_2_0.txtName = gohelper.findChildText(arg_2_1, "go_characterinfo/name/txt_name")
	arg_2_0.goSkill = gohelper.findChild(arg_2_1, "go_characterinfo/go_skill")
	arg_2_0.txtPassiveName = gohelper.findChildText(arg_2_1, "go_characterinfo/passiveskill/bg/txt_passivename")
	arg_2_0.btnPassiveSkill = gohelper.findChildButtonWithAudio(arg_2_1, "go_characterinfo/passiveskill/btn_passiveskill")

	arg_2_0:addClickCb(arg_2_0.btnPassiveSkill, arg_2_0.onClickPassiveSkill, arg_2_0)

	for iter_2_0 = 1, 5 do
		local var_2_0 = gohelper.findChild(arg_2_1, "go_characterinfo/attribute/go_attribute/attribute" .. iter_2_0)

		arg_2_0["txtAttr" .. iter_2_0] = gohelper.findChildText(var_2_0, "txt_attribute")
		arg_2_0["txtAttrName" .. iter_2_0] = gohelper.findChildText(var_2_0, "name")
	end

	for iter_2_1 = 1, 3 do
		arg_2_0["goPassiveSkill" .. iter_2_1] = gohelper.findChild(arg_2_1, "go_characterinfo/passiveskill/go_passiveskills/passiveskill" .. iter_2_1)
	end

	arg_2_0._detailPassiveTables = {}
	arg_2_0.goDetail = gohelper.findChild(arg_2_1, "go_characterinfo/go_detailView")

	if arg_2_0.goDetail then
		arg_2_0.btnCloseDetail = gohelper.findChildButtonWithAudio(arg_2_1, "go_characterinfo/go_detailView/btn_detailClose")
		arg_2_0.goDetailItem = gohelper.findChild(arg_2_1, "go_characterinfo/go_detailView/scroll_content/viewport/content/go_detailpassiveitem")

		arg_2_0:addClickCb(arg_2_0.btnCloseDetail, arg_2_0.onClickCloseDetail, arg_2_0)
	end

	if arg_2_0._view then
		if arg_2_0._view.__cname == "Act174GameTeamView" then
			arg_2_0.skillItem1 = arg_2_0:getUserDataTb_()
			arg_2_0.skillItem1.btnSkill = gohelper.findChildButtonWithAudio(arg_2_0.goSkill, "line/go_skills/skillicon1/btn_first")
			arg_2_0.skillItem1.gogray = gohelper.findChild(arg_2_0.goSkill, "line/go_skills/skillicon1/btn_first/grey")
			arg_2_0.skillItem1.gohighlight = gohelper.findChild(arg_2_0.goSkill, "line/go_skills/skillicon1/btn_first/highlight")

			arg_2_0:addClickCb(arg_2_0.skillItem1.btnSkill, arg_2_0.onClickSkill, arg_2_0, 1)

			arg_2_0.skillItem2 = arg_2_0:getUserDataTb_()
			arg_2_0.skillItem2.btnSkill = gohelper.findChildButtonWithAudio(arg_2_0.goSkill, "line/go_skills/skillicon2/btn_first")
			arg_2_0.skillItem2.gogray = gohelper.findChild(arg_2_0.goSkill, "line/go_skills/skillicon2/btn_first/grey")
			arg_2_0.skillItem2.gohighlight = gohelper.findChild(arg_2_0.goSkill, "line/go_skills/skillicon2/btn_first/highlight")

			arg_2_0:addClickCb(arg_2_0.skillItem2.btnSkill, arg_2_0.onClickSkill, arg_2_0, 2)

			arg_2_0.btnUnEquip = gohelper.findChildButtonWithAudio(arg_2_1, "go_characterinfo/btn_unequip")

			arg_2_0:addClickCb(arg_2_0.btnUnEquip, arg_2_0.onClickUnEquip, arg_2_0)
		end

		arg_2_0.goNoneCollection = gohelper.findChild(arg_2_1, "go_characterinfo/go_collection/none")
		arg_2_0.goCollection = gohelper.findChild(arg_2_1, "go_characterinfo/go_collection/equip")
		arg_2_0.colletionRare = gohelper.findChildImage(arg_2_1, "go_characterinfo/go_collection/equip/rare")
		arg_2_0.collectionIcon = gohelper.findChildSingleImage(arg_2_1, "go_characterinfo/go_collection/equip/collectionicon")
		arg_2_0.btnCollection = gohelper.findChildButtonWithAudio(arg_2_1, "go_characterinfo/go_collection/equip/collectionicon")

		arg_2_0:addClickCb(arg_2_0.btnCollection, arg_2_0.onClickCollection, arg_2_0)
	end

	arg_2_0._skillContainer = MonoHelper.addNoUpdateLuaComOnceToGo(arg_2_0.goSkill, Act174SkillContainer)
end

function var_0_0.onDestroy(arg_3_0)
	if arg_3_0.heroIcon then
		arg_3_0.heroIcon:UnLoadImage()
	end

	if arg_3_0.collectionIcon then
		arg_3_0.collectionIcon:UnLoadImage()
	end
end

function var_0_0.setData(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0.config = arg_4_1
	arg_4_0.collectionId = arg_4_2
	arg_4_0.index = arg_4_3

	local var_4_0 = ResUrl.getHeadIconSmall(arg_4_1.skinId)

	if arg_4_0.heroIcon then
		arg_4_0.heroIcon:LoadImage(var_4_0)
		UISpriteSetMgr.instance:setCommonSprite(arg_4_0.imageRare, "bgequip" .. tostring(CharacterEnum.Color[arg_4_1.rare]))
		UISpriteSetMgr.instance:setCommonSprite(arg_4_0.imageCareer, "lssx_" .. arg_4_1.career)
	end

	if arg_4_0.imageDmgType then
		UISpriteSetMgr.instance:setCommonSprite(arg_4_0.imageDmgType, "dmgtype" .. tostring(arg_4_1.dmgType))
	end

	arg_4_0.txtName.text = arg_4_1.name

	local var_4_1 = lua_activity174_template.configDict[arg_4_1.id]

	for iter_4_0 = 1, 5 do
		local var_4_2 = var_0_0.AttrIdList[iter_4_0]
		local var_4_3 = lua_character_attribute.configDict[var_4_2].name

		arg_4_0["txtAttrName" .. iter_4_0].text = var_4_3
	end

	arg_4_0["txtAttr" .. 1].text = var_4_1.attack
	arg_4_0["txtAttr" .. 2].text = var_4_1.defense
	arg_4_0["txtAttr" .. 3].text = var_4_1.technic
	arg_4_0["txtAttr" .. 4].text = var_4_1.life
	arg_4_0["txtAttr" .. 5].text = var_4_1.mdefense

	local var_4_4 = string.splitToNumber(arg_4_1.passiveSkill, "|")

	arg_4_0.txtPassiveName.text = lua_skill.configDict[var_4_4[1]].name

	local var_4_5

	if arg_4_1.type == Activity174Enum.CharacterType.Hero then
		var_4_5 = #SkillConfig.instance:getheroranksCO(arg_4_1.heroId) - 1
	else
		var_4_5 = 0
	end

	for iter_4_1 = 1, 3 do
		local var_4_6 = arg_4_0["goPassiveSkill" .. iter_4_1]

		gohelper.setActive(var_4_6, iter_4_1 <= var_4_5)
	end

	arg_4_0._skillContainer:onUpdateMO(arg_4_1)

	if arg_4_0._view and arg_4_0._view.__cname == "Act174GameTeamView" then
		arg_4_0.skillIndex = arg_4_0._view:getPriorSkill(arg_4_0.config.id)
	end

	arg_4_0:refreshSkillPrior()
	arg_4_0:refreshCollectionInfo()
end

function var_0_0.onClickPassiveSkill(arg_5_0)
	arg_5_0:refreshPassiveDetail()
	gohelper.setActive(arg_5_0.goDetail, true)
end

function var_0_0.onClickSkill(arg_6_0, arg_6_1)
	if arg_6_1 == arg_6_0.skillIndex then
		arg_6_1 = nil
	end

	arg_6_0._view:setPriorSkill(arg_6_0.config.id, arg_6_1)

	arg_6_0.skillIndex = arg_6_1

	arg_6_0:refreshSkillPrior()
end

function var_0_0.refreshCollectionInfo(arg_7_0)
	if arg_7_0._view then
		if arg_7_0.collectionId then
			local var_7_0 = Activity174Config.instance:getCollectionCo(arg_7_0.collectionId)

			UISpriteSetMgr.instance:setAct174Sprite(arg_7_0.colletionRare, "act174_propitembg_" .. var_7_0.rare)
			arg_7_0.collectionIcon:LoadImage(ResUrl.getRougeSingleBgCollection(var_7_0.icon))
		end

		gohelper.setActive(arg_7_0.goCollection, arg_7_0.collectionId)
		gohelper.setActive(arg_7_0.goNoneCollection, not arg_7_0.collectionId)
	else
		gohelper.setActive(arg_7_0.goCollection, false)
		gohelper.setActive(arg_7_0.goNoneCollection, true)
	end
end

function var_0_0.refreshSkillPrior(arg_8_0)
	if arg_8_0._view and arg_8_0._view.__cname == "Act174GameTeamView" then
		local var_8_0 = arg_8_0.skillIndex == 1

		gohelper.setActive(arg_8_0.skillItem1.gohighlight, var_8_0)
		gohelper.setActive(arg_8_0.skillItem1.gogray, not var_8_0)

		local var_8_1 = arg_8_0.skillIndex == 2

		gohelper.setActive(arg_8_0.skillItem2.gohighlight, var_8_1)
		gohelper.setActive(arg_8_0.skillItem2.gogray, not var_8_1)
	end
end

function var_0_0.onClickCollection(arg_9_0)
	if arg_9_0.collectionId then
		local var_9_0 = {
			type = Activity174Enum.ItemTipType.Collection,
			co = Activity174Config.instance:getCollectionCo(arg_9_0.collectionId)
		}

		var_9_0.showMask = true

		Activity174Controller.instance:openItemTipView(var_9_0)
	end
end

function var_0_0.refreshPassiveDetail(arg_10_0)
	local var_10_0 = arg_10_0.config.id
	local var_10_1 = Activity174Model.instance:getActInfo():getGameInfo():getWarehouseInfo()
	local var_10_2 = tabletool.indexOf(var_10_1.enhanceRoleList, var_10_0) and true or false
	local var_10_3 = Activity174Config.instance:getHeroPassiveSkillIdList(var_10_0, var_10_2)
	local var_10_4 = #var_10_3

	for iter_10_0 = 1, var_10_4 do
		local var_10_5 = tonumber(var_10_3[iter_10_0])
		local var_10_6 = lua_skill.configDict[var_10_5]

		if var_10_6 then
			local var_10_7 = arg_10_0._detailPassiveTables[iter_10_0]

			if not var_10_7 then
				local var_10_8 = gohelper.cloneInPlace(arg_10_0.goDetailItem, "item" .. iter_10_0)

				var_10_7 = arg_10_0:getUserDataTb_()
				var_10_7.go = var_10_8
				var_10_7.name = gohelper.findChildText(var_10_8, "title/txt_name")
				var_10_7.icon = gohelper.findChildSingleImage(var_10_8, "title/simage_icon")
				var_10_7.desc = gohelper.findChildText(var_10_8, "txt_desc")

				SkillHelper.addHyperLinkClick(var_10_7.desc, arg_10_0.onClickHyperLink, arg_10_0)

				var_10_7.line = gohelper.findChild(var_10_8, "txt_desc/image_line")

				table.insert(arg_10_0._detailPassiveTables, var_10_7)
			end

			var_10_7.name.text = var_10_6.name
			var_10_7.desc.text = SkillHelper.getSkillDesc(arg_10_0.config.name, var_10_6)

			gohelper.setActive(var_10_7.go, true)
			gohelper.setActive(var_10_7.line, iter_10_0 < var_10_4)
		else
			logError(string.format("被动技能配置没找到, id: %d", var_10_5))
		end
	end

	for iter_10_1 = var_10_4 + 1, #arg_10_0._detailPassiveTables do
		gohelper.setActive(arg_10_0._detailPassiveTables[iter_10_1].go, false)
	end
end

function var_0_0.onClickCloseDetail(arg_11_0)
	gohelper.setActive(arg_11_0.goDetail, false)
end

function var_0_0.onClickHyperLink(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = Vector2.New(0, 0)

	CommonBuffTipController:openCommonTipViewWithCustomPos(arg_12_1, var_12_0)
end

function var_0_0.onClickUnEquip(arg_13_0)
	if arg_13_0._view and arg_13_0._view.__cname == "Act174GameTeamView" then
		arg_13_0._view:UnInstallHero(arg_13_0.index)
		gohelper.setActive(arg_13_0._go, false)
	end
end

return var_0_0
