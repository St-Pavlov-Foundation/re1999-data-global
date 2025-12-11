module("modules.logic.versionactivity2_7.act191.view.Act191HeroEditView", package.seeall)

local var_0_0 = class("Act191HeroEditView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gononecharacter = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_nonecharacter")
	arg_1_0._gocharacterinfo = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_characterinfo")
	arg_1_0._imagedmgtype = gohelper.findChildImage(arg_1_0.viewGO, "characterinfo/#go_characterinfo/#image_dmgtype")
	arg_1_0._imagecareericon = gohelper.findChildImage(arg_1_0.viewGO, "characterinfo/#go_characterinfo/career/#image_careericon")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "characterinfo/#go_characterinfo/name/#txt_name")
	arg_1_0._txtnameen = gohelper.findChildText(arg_1_0.viewGO, "characterinfo/#go_characterinfo/name/#txt_nameen")
	arg_1_0._txtpassivename = gohelper.findChildText(arg_1_0.viewGO, "characterinfo/#go_characterinfo/passiveskill/bg/#txt_passivename")
	arg_1_0._gopassiveskills = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_characterinfo/passiveskill/#go_passiveskills")
	arg_1_0._btnpassiveskill = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "characterinfo/#go_characterinfo/passiveskill/#btn_passiveskill")
	arg_1_0._goattribute = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_characterinfo/attribute/#go_attribute")
	arg_1_0._goskill = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_characterinfo/#go_skill")
	arg_1_0._btnExSkill = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "characterinfo/#go_characterinfo/quality/exSkill/#btn_ExSkill")
	arg_1_0._goFetterIcon = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_characterinfo/fetters/Viewport/Content/#go_FetterIcon")
	arg_1_0._goDestiny = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_characterinfo/#go_Destiny")
	arg_1_0._goDestinyLock = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_characterinfo/#go_Destiny/stone/#go_DestinyLock")
	arg_1_0._goDestinyUnLock = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_characterinfo/#go_Destiny/stone/#go_DestinyUnLock")
	arg_1_0._btnDestiny = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "characterinfo/#go_characterinfo/#go_Destiny/#btn_Destiny")
	arg_1_0._goAttrUp = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_characterinfo/#go_AttrUp")
	arg_1_0._goAttrUpFetter = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_characterinfo/#go_AttrUp/attribute/#go_AttrUpFetter")
	arg_1_0._gorolecontainer = gohelper.findChild(arg_1_0.viewGO, "#go_rolecontainer")
	arg_1_0._gorolesort = gohelper.findChild(arg_1_0.viewGO, "#go_rolecontainer/#go_rolesort")
	arg_1_0._btnrarerank = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_rarerank")
	arg_1_0._goRareArrow = gohelper.findChild(arg_1_0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_rarerank/txt/#go_RareArrow")
	arg_1_0._btnquickedit = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_quickedit")
	arg_1_0._btnclassify = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_classify")
	arg_1_0._goFetterContent = gohelper.findChild(arg_1_0.viewGO, "#go_rolecontainer/layout/#go_FetterContent")
	arg_1_0._scrollcard = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_rolecontainer/layout/#scroll_card")
	arg_1_0._scrollquickedit = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_rolecontainer/layout/#scroll_quickedit")
	arg_1_0._goDetail = gohelper.findChild(arg_1_0.viewGO, "#go_Detail")
	arg_1_0._btnCloseDetail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_Detail/#btn_CloseDetail")
	arg_1_0._goDetailPassiveItem = gohelper.findChild(arg_1_0.viewGO, "#go_Detail/scroll_content/viewport/content/#go_DetailPassiveItem")
	arg_1_0._goops = gohelper.findChild(arg_1_0.viewGO, "#go_ops")
	arg_1_0._btnconfirm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_ops/#btn_confirm")
	arg_1_0._btncancel = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_ops/#btn_cancel")
	arg_1_0._gosearchfilter = gohelper.findChild(arg_1_0.viewGO, "#go_searchfilter")
	arg_1_0._btnclosefilterview = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_searchfilter/#btn_closefilterview")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnpassiveskill:AddClickListener(arg_2_0._btnpassiveskillOnClick, arg_2_0)
	arg_2_0._btnExSkill:AddClickListener(arg_2_0._btnExSkillOnClick, arg_2_0)
	arg_2_0._btnDestiny:AddClickListener(arg_2_0._btnDestinyOnClick, arg_2_0)
	arg_2_0._btnrarerank:AddClickListener(arg_2_0._btnrarerankOnClick, arg_2_0)
	arg_2_0._btnquickedit:AddClickListener(arg_2_0._btnquickeditOnClick, arg_2_0)
	arg_2_0._btnclassify:AddClickListener(arg_2_0._btnclassifyOnClick, arg_2_0)
	arg_2_0._btnCloseDetail:AddClickListener(arg_2_0._btnCloseDetailOnClick, arg_2_0)
	arg_2_0._btnconfirm:AddClickListener(arg_2_0._btnconfirmOnClick, arg_2_0)
	arg_2_0._btncancel:AddClickListener(arg_2_0._btncancelOnClick, arg_2_0)
	arg_2_0._btnclosefilterview:AddClickListener(arg_2_0._btnclosefilterviewOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnpassiveskill:RemoveClickListener()
	arg_3_0._btnExSkill:RemoveClickListener()
	arg_3_0._btnDestiny:RemoveClickListener()
	arg_3_0._btnrarerank:RemoveClickListener()
	arg_3_0._btnquickedit:RemoveClickListener()
	arg_3_0._btnclassify:RemoveClickListener()
	arg_3_0._btnCloseDetail:RemoveClickListener()
	arg_3_0._btnconfirm:RemoveClickListener()
	arg_3_0._btncancel:RemoveClickListener()
	arg_3_0._btnclosefilterview:RemoveClickListener()
end

function var_0_0._btnDestinyOnClick(arg_4_0)
	ViewMgr.instance:openView(ViewName.Act191CharacterDestinyView, arg_4_0.config)
end

function var_0_0._btnExSkillOnClick(arg_5_0)
	local var_5_0 = Activity191Config.instance:getRoleCoByNativeId(arg_5_0._heroMo.heroId, arg_5_0._heroMo.star)

	if var_5_0 then
		ViewMgr.instance:openView(ViewName.Act191CharacterExSkillView, {
			config = var_5_0
		})
	end
end

function var_0_0._btnclosefilterviewOnClick(arg_6_0)
	gohelper.setActive(arg_6_0._gosearchfilter, false)
end

function var_0_0._btnCloseDetailOnClick(arg_7_0)
	gohelper.setActive(arg_7_0._goDetail, false)
end

function var_0_0._btncloseFilterViewOnClick(arg_8_0)
	gohelper.setActive(arg_8_0._gosearchfilter, false)
end

function var_0_0._btnclassifyOnClick(arg_9_0)
	gohelper.setActive(arg_9_0._gosearchfilter, true)
end

function var_0_0._btnpassiveskillOnClick(arg_10_0)
	if not arg_10_0.config then
		return
	end

	if arg_10_0.config.type == Activity191Enum.CharacterType.Hero then
		local var_10_0 = {
			id = arg_10_0.config.id,
			tipPos = Vector2.New(851, -59)
		}

		var_10_0.buffTipsX = 1603
		var_10_0.anchorParams = {
			Vector2.New(0, 0.5),
			Vector2.New(0, 0.5)
		}
		var_10_0.stoneId = arg_10_0.stoneId

		ViewMgr.instance:openView(ViewName.Act191CharacterTipView, var_10_0)
	else
		arg_10_0:refreshPassiveDetail()
		gohelper.setActive(arg_10_0._goDetail, true)
	end
end

function var_0_0.refreshPassiveDetail(arg_11_0)
	local var_11_0 = #arg_11_0.passiveSkillIds

	for iter_11_0 = 1, var_11_0 do
		local var_11_1 = tonumber(arg_11_0.passiveSkillIds[iter_11_0])
		local var_11_2 = lua_skill.configDict[var_11_1]

		if var_11_2 then
			local var_11_3 = arg_11_0._detailPassiveTables[iter_11_0]

			if not var_11_3 then
				local var_11_4 = gohelper.cloneInPlace(arg_11_0._goDetailPassiveItem, "item" .. iter_11_0)

				var_11_3 = arg_11_0:getUserDataTb_()
				var_11_3.go = var_11_4
				var_11_3.name = gohelper.findChildText(var_11_4, "title/txt_name")
				var_11_3.icon = gohelper.findChildSingleImage(var_11_4, "title/simage_icon")
				var_11_3.desc = gohelper.findChildText(var_11_4, "txt_desc")

				SkillHelper.addHyperLinkClick(var_11_3.desc, arg_11_0.onClickHyperLink, arg_11_0)

				var_11_3.line = gohelper.findChild(var_11_4, "txt_desc/image_line")

				table.insert(arg_11_0._detailPassiveTables, var_11_3)
			end

			var_11_3.name.text = var_11_2.name
			var_11_3.desc.text = SkillHelper.getSkillDesc(arg_11_0.config.name, var_11_2)

			gohelper.setActive(var_11_3.go, true)
			gohelper.setActive(var_11_3.line, iter_11_0 < var_11_0)
		else
			logError(string.format("被动技能配置没找到, id: %d", var_11_1))
		end
	end

	for iter_11_1 = var_11_0 + 1, #arg_11_0._detailPassiveTables do
		gohelper.setActive(arg_11_0._detailPassiveTables[iter_11_1].go, false)
	end
end

function var_0_0._btnconfirmOnClick(arg_12_0)
	if arg_12_0._isShowQuickEdit then
		local var_12_0 = Act191HeroQuickEditListModel.instance:getHeroIdMap()

		arg_12_0.gameInfo:saveQuickGroupInfo(var_12_0)
	else
		local var_12_1 = Act191HeroEditListModel.instance.specialHero
		local var_12_2 = Activity191Model.instance:getActInfo():getGameInfo()

		if arg_12_0._heroMo then
			if arg_12_0._heroMo.heroId ~= var_12_1 then
				var_12_2:replaceHeroInTeam(arg_12_0._heroMo.heroId, arg_12_0.curSlotIndex)
			end
		elseif var_12_1 then
			var_12_2:removeHeroInTeam(var_12_1)
		end
	end

	arg_12_0:closeThis()
end

function var_0_0._btncancelOnClick(arg_13_0)
	arg_13_0:closeThis()
end

function var_0_0._btnrarerankOnClick(arg_14_0)
	arg_14_0.sortRule = math.abs(arg_14_0.sortRule - 3)

	arg_14_0:refreshBtnRare()

	if arg_14_0._isShowQuickEdit then
		Act191HeroQuickEditListModel.instance:filterData(arg_14_0.filterTag, arg_14_0.sortRule)
	else
		Act191HeroEditListModel.instance:filterData(arg_14_0.filterTag, arg_14_0.sortRule)
	end
end

function var_0_0._btnquickeditOnClick(arg_15_0)
	arg_15_0._isShowQuickEdit = not arg_15_0._isShowQuickEdit

	arg_15_0:_refreshEditMode()

	if arg_15_0._isShowQuickEdit then
		Act191HeroQuickEditListModel.instance:filterData(arg_15_0.filterTag, arg_15_0.sortRule)
		arg_15_0:_onHeroItemClick(arg_15_0._quickHeroMo)
	else
		Act191HeroEditListModel.instance:filterData(arg_15_0.filterTag, arg_15_0.sortRule)
		arg_15_0:_onHeroItemClick(arg_15_0._normalHeroMo)
	end
end

function var_0_0._editableInitView(arg_16_0)
	arg_16_0.actId = Activity191Model.instance:getCurActId()
	arg_16_0._detailPassiveTables = {}
	arg_16_0._goScrollContent = gohelper.findChild(arg_16_0.viewGO, "#go_rolecontainer/#scroll_card/scrollcontent")
	arg_16_0._imgBg = gohelper.findChildSingleImage(arg_16_0.viewGO, "bg/bgimg")

	arg_16_0._imgBg:LoadImage(ResUrl.getCommonViewBg("full/biandui_di"))

	arg_16_0._classifyBtns = arg_16_0:getUserDataTb_()

	for iter_16_0 = 1, 2 do
		arg_16_0._classifyBtns[iter_16_0] = gohelper.findChild(arg_16_0._btnclassify.gameObject, "btn" .. tostring(iter_16_0))
	end

	arg_16_0._goBtnEditQuickMode = gohelper.findChild(arg_16_0._btnquickedit.gameObject, "btn2")
	arg_16_0._goBtnEditNormalMode = gohelper.findChild(arg_16_0._btnquickedit.gameObject, "btn1")
	arg_16_0._attributevalues = {}

	for iter_16_1 = 1, 5 do
		local var_16_0 = arg_16_0:getUserDataTb_()

		var_16_0.txtAttr = gohelper.findChildText(arg_16_0._goattribute, "attribute" .. tostring(iter_16_1) .. "/txt_attribute")
		var_16_0.txtUp = gohelper.findChildText(arg_16_0._goattribute, "attribute" .. tostring(iter_16_1) .. "/txt_up")
		arg_16_0._attributevalues[iter_16_1] = var_16_0
	end

	for iter_16_2 = 1, 3 do
		arg_16_0["goPassiveSkill" .. iter_16_2] = gohelper.findChild(arg_16_0._gopassiveskills, "passiveskill" .. tostring(iter_16_2))
	end

	arg_16_0._skillContainer = MonoHelper.addNoUpdateLuaComOnceToGo(arg_16_0._goskill, Act191SkillContainer)
	arg_16_0.exGoList = arg_16_0:getUserDataTb_()

	for iter_16_3 = 1, 5 do
		local var_16_1 = "characterinfo/#go_characterinfo/quality/exSkill/go_ex" .. iter_16_3

		arg_16_0.exGoList[iter_16_3] = gohelper.findChild(arg_16_0.viewGO, var_16_1)
	end

	arg_16_0.fetterIconItemList = {}
	arg_16_0.fetterItemList = {}
	arg_16_0._animator = arg_16_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(arg_16_0._gononecharacter, true)
	gohelper.setActive(arg_16_0._gocharacterinfo, false)
	arg_16_0:_initFilterView()
end

function var_0_0.onOpen(arg_17_0)
	arg_17_0.gameInfo = Activity191Model.instance:getActInfo():getGameInfo()
	arg_17_0.sortRule = Activity191Enum.SortRule.Down

	Act191HeroEditListModel.instance:initData(arg_17_0.viewParam)
	Act191HeroQuickEditListModel.instance:initData()

	arg_17_0.curSlotIndex = arg_17_0.viewParam.index
	arg_17_0._isShowQuickEdit = false
	arg_17_0._scrollcard.verticalNormalizedPosition = 1
	arg_17_0._scrollquickedit.verticalNormalizedPosition = 1

	arg_17_0:_refreshEditMode()
	arg_17_0:_refreshCharacterInfo()
	arg_17_0:addEventCb(Activity191Controller.instance, Activity191Event.ClickHeroEditItem, arg_17_0._onHeroItemClick, arg_17_0)
	gohelper.addUIClickAudio(arg_17_0._btnrarerank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(arg_17_0._btnpassiveskill.gameObject, AudioEnum.UI.UI_Common_Click)
	arg_17_0:refreshFetter()

	arg_17_0.filterTag = nil

	arg_17_0:refreshBtnRare()
	arg_17_0:_refreshBtnClassify()
end

function var_0_0.onClose(arg_18_0)
	arg_18_0._heroMo = nil
	arg_18_0.config = nil
end

function var_0_0.onDestroyView(arg_19_0)
	Act191HeroEditListModel.instance:clear()
	Act191HeroQuickEditListModel.instance:clear()
	arg_19_0._imgBg:UnLoadImage()

	arg_19_0._imgBg = nil
end

function var_0_0.refreshBtnRare(arg_20_0)
	local var_20_0 = arg_20_0.sortRule == Activity191Enum.SortRule.Down and 0 or 180

	transformhelper.setLocalRotation(arg_20_0._goRareArrow.transform, 1, 1, var_20_0)
end

function var_0_0.refreshDestiny(arg_21_0)
	if string.nilorempty(arg_21_0.config.facetsId) then
		gohelper.setActive(arg_21_0._goDestiny, false)
	else
		gohelper.setActive(arg_21_0._goDestiny, true)
	end
end

function var_0_0._onHeroItemClick(arg_22_0, arg_22_1)
	if arg_22_0._isShowQuickEdit then
		arg_22_0._quickHeroMo = arg_22_1
	else
		arg_22_0._normalHeroMo = arg_22_1
	end

	arg_22_0:refreshFetter()

	if arg_22_0._heroMo and arg_22_1 and arg_22_0._heroMo.heroId == arg_22_1.heroId then
		return
	end

	arg_22_0._heroMo = arg_22_1
	arg_22_0.config = arg_22_1 and arg_22_1.config or nil

	arg_22_0:_refreshCharacterInfo()
end

function var_0_0._refreshCharacterInfo(arg_23_0)
	if arg_23_0.config then
		arg_23_0.attrUpDic, arg_23_0.attrUpFetterList = arg_23_0.gameInfo:getAttrUpDicByRoleId(arg_23_0.config.roleId)

		gohelper.setActive(arg_23_0._gononecharacter, false)
		gohelper.setActive(arg_23_0._gocharacterinfo, true)
		UISpriteSetMgr.instance:setCommonSprite(arg_23_0._imagecareericon, "sx_biandui_" .. tostring(arg_23_0.config.career))
		UISpriteSetMgr.instance:setCommonSprite(arg_23_0._imagedmgtype, "dmgtype" .. tostring(arg_23_0.config.dmgType))

		arg_23_0._txtname.text = arg_23_0.config.name

		gohelper.setActive(arg_23_0._goAttrUp, next(arg_23_0.attrUpDic))

		for iter_23_0, iter_23_1 in ipairs(arg_23_0.attrUpFetterList) do
			local var_23_0 = gohelper.cloneInPlace(arg_23_0._goAttrUpFetter)
			local var_23_1 = gohelper.findChildImage(var_23_0, "image_icon")
			local var_23_2 = Activity191Config.instance:getRelationCo(iter_23_1)

			Activity191Helper.setFetterIcon(var_23_1, var_23_2.icon)
		end

		gohelper.setActive(arg_23_0._goAttrUpFetter, false)

		for iter_23_2, iter_23_3 in ipairs(CharacterEnum.BaseAttrIdList) do
			local var_23_3 = arg_23_0._attributevalues[iter_23_2].txtUp
			local var_23_4 = arg_23_0.attrUpDic[iter_23_3]

			if var_23_4 then
				var_23_3.text = var_23_4 / 10 .. "%"
			end

			gohelper.setActive(var_23_3, var_23_4)
		end

		local var_23_5 = lua_activity191_template.configDict[arg_23_0.config.id]

		arg_23_0._attributevalues[1].txtAttr.text = var_23_5.attack
		arg_23_0._attributevalues[2].txtAttr.text = var_23_5.life
		arg_23_0._attributevalues[3].txtAttr.text = var_23_5.defense
		arg_23_0._attributevalues[4].txtAttr.text = var_23_5.mdefense
		arg_23_0._attributevalues[5].txtAttr.text = var_23_5.technic
		arg_23_0.passiveSkillIds = Activity191Config.instance:getHeroPassiveSkillIdList(arg_23_0.config.id)
		arg_23_0._txtpassivename.text = lua_skill.configDict[arg_23_0.passiveSkillIds[1]].name

		local var_23_6 = 0

		if arg_23_0.config.type == Activity191Enum.CharacterType.Hero then
			var_23_6 = #SkillConfig.instance:getheroranksCO(arg_23_0.config.roleId) - 1
		end

		for iter_23_4 = 1, 3 do
			local var_23_7 = arg_23_0["goPassiveSkill" .. iter_23_4]

			gohelper.setActive(var_23_7, iter_23_4 <= var_23_6)
		end

		for iter_23_5, iter_23_6 in ipairs(arg_23_0.exGoList) do
			gohelper.setActive(iter_23_6, iter_23_5 <= arg_23_0.config.exLevel)
		end

		arg_23_0:refreshFetterIcon()
		arg_23_0._skillContainer:setData(arg_23_0.config)

		arg_23_0.stoneId = arg_23_0.gameInfo:getStoneId(arg_23_0.config)

		if arg_23_0.stoneId then
			arg_23_0.passiveSkillIds = Activity191Helper.replaceSkill(arg_23_0.stoneId, arg_23_0.passiveSkillIds)
		end

		arg_23_0:refreshDestiny()
	else
		gohelper.setActive(arg_23_0._gononecharacter, true)
		gohelper.setActive(arg_23_0._gocharacterinfo, false)
	end
end

function var_0_0.refreshFetterIcon(arg_24_0)
	for iter_24_0, iter_24_1 in ipairs(arg_24_0.fetterIconItemList) do
		gohelper.setActive(iter_24_1.go, false)
	end

	local var_24_0 = string.split(arg_24_0.config.tag, "#")

	for iter_24_2, iter_24_3 in ipairs(var_24_0) do
		local var_24_1 = arg_24_0.fetterIconItemList[iter_24_2]

		if not var_24_1 then
			local var_24_2 = gohelper.cloneInPlace(arg_24_0._goFetterIcon)

			var_24_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_24_2, Act191FetterIconItem)
			arg_24_0.fetterIconItemList[iter_24_2] = var_24_1
		end

		var_24_1:setData(iter_24_3)
		gohelper.setActive(var_24_1.go, true)
	end
end

function var_0_0._initFilterView(arg_25_0)
	arg_25_0.filterItemMap = {}

	local var_25_0 = gohelper.findChild(arg_25_0._gosearchfilter, "container/ScrollView/Viewport/Content/attrContainer/go_attr")
	local var_25_1 = lua_activity191_relation_select.configDict[arg_25_0.actId]

	table.sort(var_25_1, function(arg_26_0, arg_26_1)
		return arg_26_0.sortIndex < arg_26_1.sortIndex
	end)

	for iter_25_0, iter_25_1 in pairs(var_25_1) do
		local var_25_2 = Activity191Config.instance:getRelationCo(iter_25_1.tag)

		if var_25_2 then
			local var_25_3 = arg_25_0:getUserDataTb_()
			local var_25_4 = gohelper.cloneInPlace(var_25_0, iter_25_1.tag)

			var_25_3.goUnselect = gohelper.findChild(var_25_4, "unselected")
			var_25_3.goSelect = gohelper.findChild(var_25_4, "selected")
			gohelper.findChildText(var_25_4, "unselected/info1").text = var_25_2.name

			local var_25_5 = gohelper.findChildImage(var_25_4, "unselected/attrIcon1")

			Activity191Helper.setFetterIcon(var_25_5, var_25_2.icon)

			gohelper.findChildText(var_25_4, "selected/info2").text = var_25_2.name

			local var_25_6 = gohelper.findChildImage(var_25_4, "selected/attrIcon2")

			Activity191Helper.setFetterIcon(var_25_6, var_25_2.icon)

			local var_25_7 = gohelper.findChildButtonWithAudio(var_25_4, "click")

			arg_25_0:addClickCb(var_25_7, arg_25_0._filterItemClick, arg_25_0, iter_25_1.tag)

			arg_25_0.filterItemMap[iter_25_1.tag] = var_25_3
		end
	end

	gohelper.setActive(var_25_0, false)
end

function var_0_0._filterItemClick(arg_27_0, arg_27_1)
	if arg_27_0.filterTag == arg_27_1 then
		arg_27_0.filterTag = nil
	else
		arg_27_0.filterTag = arg_27_1
	end

	arg_27_0:_refreshBtnClassify()

	if arg_27_0._isShowQuickEdit then
		Act191HeroQuickEditListModel.instance:filterData(arg_27_0.filterTag, arg_27_0.sortRule)
	else
		Act191HeroEditListModel.instance:filterData(arg_27_0.filterTag, arg_27_0.sortRule)
	end
end

function var_0_0._refreshBtnClassify(arg_28_0)
	gohelper.setActive(arg_28_0._classifyBtns[1], not arg_28_0.filterTag)
	gohelper.setActive(arg_28_0._classifyBtns[2], arg_28_0.filterTag)

	for iter_28_0, iter_28_1 in pairs(arg_28_0.filterItemMap) do
		gohelper.setActive(iter_28_1.goUnselect, iter_28_0 ~= arg_28_0.filterTag)
		gohelper.setActive(iter_28_1.goSelect, iter_28_0 == arg_28_0.filterTag)
	end
end

function var_0_0._refreshEditMode(arg_29_0)
	gohelper.setActive(arg_29_0._scrollquickedit.gameObject, arg_29_0._isShowQuickEdit)
	gohelper.setActive(arg_29_0._scrollcard.gameObject, not arg_29_0._isShowQuickEdit)
	gohelper.setActive(arg_29_0._goBtnEditQuickMode.gameObject, arg_29_0._isShowQuickEdit)
	gohelper.setActive(arg_29_0._goBtnEditNormalMode.gameObject, not arg_29_0._isShowQuickEdit)
end

function var_0_0.onClickHyperLink(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = Vector2.New(0, 0)

	CommonBuffTipController:openCommonTipViewWithCustomPos(arg_30_1, var_30_0)
end

function var_0_0.refreshFetter(arg_31_0)
	local var_31_0

	if arg_31_0._isShowQuickEdit then
		local var_31_1 = Act191HeroQuickEditListModel.instance:getHeroIdMap()

		var_31_0 = arg_31_0.gameInfo:getPreviewFetterCntDic(var_31_1)
	else
		local var_31_2 = Act191HeroEditListModel.instance:getHeroIdMap()

		var_31_0 = arg_31_0.gameInfo:getPreviewFetterCntDic(var_31_2)
	end

	for iter_31_0, iter_31_1 in ipairs(arg_31_0.fetterItemList) do
		gohelper.setActive(iter_31_1.go, false)
	end

	local var_31_3 = Activity191Helper.getActiveFetterInfoList(var_31_0)

	for iter_31_2, iter_31_3 in ipairs(var_31_3) do
		local var_31_4 = arg_31_0.fetterItemList[iter_31_2]

		if not var_31_4 then
			local var_31_5 = arg_31_0:getResInst(Activity191Enum.PrefabPath.FetterItem, arg_31_0._goFetterContent)

			var_31_4 = MonoHelper.addNoUpdateLuaComOnceToGo(var_31_5, Act191FetterItem)
			arg_31_0.fetterItemList[iter_31_2] = var_31_4
		end

		var_31_4:setData(iter_31_3.config, iter_31_3.count)
		gohelper.setActive(var_31_4.go, true)
	end

	gohelper.setActive(arg_31_0._goFetterContent, #var_31_3 ~= 0)
end

return var_0_0
