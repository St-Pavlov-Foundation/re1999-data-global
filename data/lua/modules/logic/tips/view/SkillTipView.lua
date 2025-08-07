module("modules.logic.tips.view.SkillTipView", package.seeall)

local var_0_0 = class("SkillTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gonewskilltip = gohelper.findChild(arg_1_0.viewGO, "#go_newskilltip")
	arg_1_0._goassassinbg = gohelper.findChild(arg_1_0.viewGO, "#go_newskilltip/skillbgassassin")
	arg_1_0._gospecialitem = gohelper.findChild(arg_1_0.viewGO, "#go_newskilltip/skilltipScrollview/Viewport/Content/name/special/#go_specialitem")
	arg_1_0._goline = gohelper.findChild(arg_1_0.viewGO, "#go_newskilltip/skilltipScrollview/Viewport/Content/#go_line")
	arg_1_0._goskillspecialitem = gohelper.findChild(arg_1_0.viewGO, "#go_newskilltip/skilltipScrollview/Viewport/Content/skillspecial/#go_skillspecialitem")
	arg_1_0._goskilltipScrollviewContent = gohelper.findChild(arg_1_0.viewGO, "#go_newskilltip/skilltipScrollview/Viewport/Content")
	arg_1_0._scrollskilltipScrollview = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_newskilltip/skilltipScrollview")
	arg_1_0._goarrow = gohelper.findChild(arg_1_0.viewGO, "#go_newskilltip/bottombg/#go_arrow")
	arg_1_0._gostoryDesc = gohelper.findChild(arg_1_0.viewGO, "#go_newskilltip/skilltipScrollview/Viewport/Content/#go_storyDesc")
	arg_1_0._txtstory = gohelper.findChildText(arg_1_0.viewGO, "#go_newskilltip/skilltipScrollview/Viewport/Content/#go_storyDesc/#txt_story")
	arg_1_0._goBuffContainer = gohelper.findChild(arg_1_0.viewGO, "#go_buffContainer")
	arg_1_0._btnclosebuff = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_buffContainer/buff_bg")
	arg_1_0._goBuffItem = gohelper.findChild(arg_1_0.viewGO, "#go_buffContainer/#go_buffitem")
	arg_1_0._txtBuffName = gohelper.findChildText(arg_1_0.viewGO, "#go_buffContainer/#go_buffitem/title/txt_name")
	arg_1_0._goBuffTag = gohelper.findChild(arg_1_0.viewGO, "#go_buffContainer/#go_buffitem/title/txt_name/go_tag")
	arg_1_0._txtBuffTagName = gohelper.findChildText(arg_1_0.viewGO, "#go_buffContainer/#go_buffitem/title/txt_name/go_tag/bg/txt_tagname")
	arg_1_0._txtBuffDesc = gohelper.findChildText(arg_1_0.viewGO, "#go_buffContainer/#go_buffitem/txt_desc")
	arg_1_0._btnupgradeShow = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_newskilltip/#btn_upgradeShow")
	arg_1_0._goBtnNormal = gohelper.findChild(arg_1_0._btnupgradeShow.gameObject, "#go_normal")
	arg_1_0._goBtnUpgraded = gohelper.findChild(arg_1_0._btnupgradeShow.gameObject, "#go_upgraded")
	arg_1_0._goshowSelect = gohelper.findChild(arg_1_0.viewGO, "#go_newskilltip/#go_showSelect")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclosebuff:AddClickListener(arg_2_0._btnclosebuffOnClick, arg_2_0)
	arg_2_0._btnupgradeShow:AddClickListener(arg_2_0._btnUpgradeShowOnClock, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclosebuff:RemoveClickListener()
	arg_3_0._btnupgradeShow:RemoveClickListener()
end

var_0_0.skillTypeColor = {
	"#405874",
	"#8c4e31",
	"#9b7039"
}

function var_0_0._btnclosebuffOnClick(arg_4_0)
	gohelper.setActive(arg_4_0._goBuffContainer, false)
end

function var_0_0._refreshArrow(arg_5_0)
	if recthelper.getHeight(arg_5_0._goskilltipScrollviewContent.transform) > recthelper.getHeight(arg_5_0._scrollskilltipScrollview.transform) and arg_5_0._scrollskilltipScrollview.verticalNormalizedPosition > 0.01 then
		gohelper.setActive(arg_5_0._goarrow, true)
	else
		gohelper.setActive(arg_5_0._goarrow, false)
	end
end

function var_0_0._editableInitView(arg_6_0)
	gohelper.setActive(arg_6_0._goBuffContainer, false)
	arg_6_0._scrollskilltipScrollview:AddOnValueChanged(arg_6_0._refreshArrow, arg_6_0)

	arg_6_0._newskillitems = {}

	for iter_6_0 = 1, 3 do
		local var_6_0 = gohelper.findChild(arg_6_0._gonewskilltip, "normal/skillicon" .. tostring(iter_6_0))
		local var_6_1 = arg_6_0:getUserDataTb_()

		var_6_1.go = var_6_0
		var_6_1.icon = gohelper.findChildSingleImage(var_6_0, "imgIcon")
		var_6_1.btn = gohelper.findChildButtonWithAudio(var_6_0, "bg")
		var_6_1.selectframe = gohelper.findChild(var_6_0, "selectframe")
		var_6_1.selectarrow = gohelper.findChild(var_6_0, "selectarrow")
		var_6_1.aggrandizement = gohelper.findChild(var_6_0, "aggrandizement")
		var_6_1.index = iter_6_0

		var_6_1.btn:AddClickListener(arg_6_0._skillItemClick, arg_6_0, var_6_1.index)

		var_6_1.tag = gohelper.findChildSingleImage(var_6_0, "tag/tagIcon")
		arg_6_0._newskillitems[iter_6_0] = var_6_1
	end

	arg_6_0._newsuperskill = arg_6_0:getUserDataTb_()

	local var_6_2 = gohelper.findChild(arg_6_0._gonewskilltip, "super")

	arg_6_0._newsuperskill.icon = gohelper.findChildSingleImage(var_6_2, "imgIcon")
	arg_6_0._newsuperskill.tag = gohelper.findChildSingleImage(var_6_2, "tag/tagIcon")
	arg_6_0._newsuperskill.aggrandizement = gohelper.findChild(var_6_2, "aggrandizement")
	arg_6_0._newskilltips = arg_6_0:getUserDataTb_()
	arg_6_0._newskilltips[1] = gohelper.findChild(arg_6_0._gonewskilltip, "normal")
	arg_6_0._newskilltips[2] = gohelper.findChild(arg_6_0._gonewskilltip, "super")
	arg_6_0._newskillname = gohelper.findChildText(arg_6_0._goskilltipScrollviewContent, "name")
	arg_6_0._newskilldesc = gohelper.findChildText(arg_6_0._goskilltipScrollviewContent, "desc")
	arg_6_0._fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(arg_6_0._newskilldesc.gameObject, FixTmpBreakLine)

	SkillHelper.addHyperLinkClick(arg_6_0._newskilldesc, arg_6_0._onHyperLinkClick, arg_6_0)

	arg_6_0._skillTagGOs = arg_6_0:getUserDataTb_()
	arg_6_0._skillEffectGOs = arg_6_0:getUserDataTb_()

	gohelper.setActive(arg_6_0._gospecialitem, false)
	gohelper.setActive(arg_6_0._goskillspecialitem, false)

	arg_6_0._goarrow1 = gohelper.findChild(arg_6_0._gonewskilltip, "normal/arrow1")
	arg_6_0._goarrow2 = gohelper.findChild(arg_6_0._gonewskilltip, "normal/arrow2")
	arg_6_0._viewInitialized = true
	arg_6_0._upgradeSelectShow = false
	arg_6_0._canShowUpgradeBtn = true
end

function var_0_0._skillItemClick(arg_7_0, arg_7_1)
	if arg_7_1 == arg_7_0._curSkillLevel then
		return
	end

	arg_7_0:_refreshSkill(arg_7_1)
end

function var_0_0._setNewSkills(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_0._curSkillLevel = arg_8_0._curSkillLevel or nil
	arg_8_1 = arg_8_0:_checkReplaceSkill(arg_8_1)
	arg_8_0._skillIdList = arg_8_1
	arg_8_0._super = arg_8_2

	gohelper.setActive(arg_8_0._newskilltips[1], not arg_8_2)
	gohelper.setActive(arg_8_0._newskilltips[2], arg_8_2)

	if not arg_8_2 then
		local var_8_0 = #arg_8_1

		for iter_8_0 = 1, var_8_0 do
			local var_8_1 = lua_skill.configDict[arg_8_1[iter_8_0]]

			if var_8_1 then
				arg_8_0._newskillitems[iter_8_0].icon:LoadImage(ResUrl.getSkillIcon(var_8_1.icon))
				arg_8_0._newskillitems[iter_8_0].tag:LoadImage(ResUrl.getAttributeIcon("attribute_" .. var_8_1.showTag))
			else
				logError("找不到技能: " .. arg_8_1[iter_8_0])
			end

			gohelper.setActive(arg_8_0._newskillitems[iter_8_0].selectframe, false)
			gohelper.setActive(arg_8_0._newskillitems[iter_8_0].selectarrow, false)
			gohelper.setActive(arg_8_0._newskillitems[iter_8_0].go, true)
			gohelper.setActive(arg_8_0._newskillitems[iter_8_0].aggrandizement, arg_8_0._upgradeSelectShow)
		end

		for iter_8_1 = var_8_0 + 1, 3 do
			gohelper.setActive(arg_8_0._newskillitems[iter_8_1].go, false)
		end

		gohelper.setActive(arg_8_0._goarrow1, var_8_0 > 1)
		gohelper.setActive(arg_8_0._goarrow2, var_8_0 > 2)
		arg_8_0:_refreshSkill(arg_8_0._curSkillLevel or 1)
	else
		local var_8_2 = lua_skill.configDict[arg_8_1[1]]

		if var_8_2 then
			arg_8_0._newsuperskill.icon:LoadImage(ResUrl.getSkillIcon(var_8_2.icon))
			arg_8_0._newsuperskill.tag:LoadImage(ResUrl.getAttributeIcon("attribute_" .. var_8_2.showTag))

			arg_8_0._newskillname.text = var_8_2.name

			local var_8_3 = SkillHelper.getSkillDesc(arg_8_0.monsterName, var_8_2)

			arg_8_0._newskilldesc.text = var_8_3

			arg_8_0._fixTmpBreakLine:refreshTmpContent(arg_8_0._newskilldesc)
			gohelper.setActive(arg_8_0._newsuperskill.aggrandizement, arg_8_0._upgradeSelectShow)
			gohelper.setActive(arg_8_0._gostoryDesc, not string.nilorempty(var_8_2.desc_art))

			arg_8_0._txtstory.text = var_8_2.desc_art

			arg_8_0._txtstory:GetPreferredValues()

			arg_8_0._scrollskilltipScrollview.verticalNormalizedPosition = 1

			arg_8_0:_refreshSkillSpecial(var_8_2)
		else
			logError("找不到技能: " .. tostring(arg_8_1))
		end
	end

	local var_8_4 = arg_8_0._goBuffItem.transform

	if arg_8_0.viewName == ViewName.FightFocusView then
		if ViewMgr.instance:isOpen(ViewName.FightFocusView) then
			if arg_8_3 then
				transformhelper.setLocalPosXY(arg_8_0._gonewskilltip.transform, 460.9, -24.3)
				recthelper.setAnchorX(var_8_4, -38)
			else
				transformhelper.setLocalPosXY(arg_8_0._gonewskilltip.transform, 270, -24.3)
				recthelper.setAnchorX(var_8_4, -38)
			end
		else
			transformhelper.setLocalPosXY(arg_8_0._gonewskilltip.transform, 185.12, 49.85)
			recthelper.setAnchorX(var_8_4, -120)
		end
	else
		transformhelper.setLocalPosXY(arg_8_0._gonewskilltip.transform, 0.69, -0.54)
		recthelper.setAnchorX(var_8_4, -304)
	end
end

function var_0_0._checkReplaceSkill(arg_9_0, arg_9_1)
	if arg_9_1 then
		local var_9_0 = arg_9_0.viewParam and arg_9_0.viewParam.heroMo

		if var_9_0 then
			arg_9_1 = var_9_0:checkReplaceSkill(arg_9_1)
		end
	end

	return arg_9_1
end

function var_0_0._refreshSkill(arg_10_0, arg_10_1)
	if not arg_10_0._skillIdList[arg_10_1] then
		arg_10_1 = 1
	end

	arg_10_0._curSkillLevel = arg_10_1

	for iter_10_0 = 1, 3 do
		gohelper.setActive(arg_10_0._newskillitems[iter_10_0].selectframe, iter_10_0 == arg_10_1)
		gohelper.setActive(arg_10_0._newskillitems[iter_10_0].selectarrow, iter_10_0 == arg_10_1)
	end

	local var_10_0 = lua_skill.configDict[tonumber(arg_10_0._skillIdList[arg_10_1])]

	if var_10_0 then
		arg_10_0._newskillname.text = var_10_0.name
		arg_10_0._newskilldesc.text = SkillHelper.getSkillDesc(arg_10_0.monsterName, var_10_0)

		arg_10_0._fixTmpBreakLine:refreshTmpContent(arg_10_0._newskilldesc)
		gohelper.setActive(arg_10_0._gostoryDesc, not string.nilorempty(var_10_0.desc_art))

		arg_10_0._txtstory.text = var_10_0.desc_art

		arg_10_0._txtstory:GetPreferredValues()

		arg_10_0._scrollskilltipScrollview.verticalNormalizedPosition = 1

		arg_10_0:_refreshSkillSpecial(var_10_0)
	else
		logError("找不到技能: " .. tostring(arg_10_0._skillIdList[arg_10_1]))
	end
end

function var_0_0._refreshSkillSpecial(arg_11_0, arg_11_1)
	local var_11_0 = {}

	if arg_11_1.battleTag and arg_11_1.battleTag ~= "" then
		var_11_0 = string.split(arg_11_1.battleTag, "#")

		for iter_11_0 = 1, #var_11_0 do
			local var_11_1 = arg_11_0._skillTagGOs[iter_11_0]

			if not var_11_1 then
				var_11_1 = gohelper.cloneInPlace(arg_11_0._gospecialitem, "item" .. iter_11_0)

				table.insert(arg_11_0._skillTagGOs, var_11_1)
			end

			local var_11_2 = gohelper.findChildText(var_11_1, "name")
			local var_11_3 = HeroConfig.instance:getBattleTagConfigCO(var_11_0[iter_11_0])

			if var_11_3 then
				var_11_2.text = var_11_3.tagName
			else
				logError("找不到技能BattleTag: " .. tostring(var_11_0[iter_11_0]))
			end

			gohelper.setActive(var_11_1, true)
		end
	end

	for iter_11_1 = #var_11_0 + 1, #arg_11_0._skillTagGOs do
		gohelper.setActive(arg_11_0._skillTagGOs[iter_11_1], false)
	end

	gohelper.setActive(arg_11_0._goline, false)

	local var_11_4 = FightConfig.instance:getSkillEffectDesc(arg_11_0.monsterName, arg_11_1)
	local var_11_5 = HeroSkillModel.instance:getEffectTagIDsFromDescRecursion(var_11_4)

	for iter_11_2 = #var_11_5, 1, -1 do
		local var_11_6 = tonumber(var_11_5[iter_11_2])
		local var_11_7 = SkillConfig.instance:getSkillEffectDescCo(var_11_6)

		if var_11_7 then
			if not SkillHelper.canShowTag(var_11_7) then
				table.remove(var_11_5, iter_11_2)
			end
		else
			logError("找不到技能eff_desc: " .. tostring(var_11_6))
		end
	end

	local var_11_8 = 1

	for iter_11_3 = 1, #var_11_5 do
		local var_11_9 = tonumber(var_11_5[iter_11_3])
		local var_11_10 = SkillConfig.instance:getSkillEffectDescCo(var_11_9)

		if var_11_10.isSpecialCharacter == 1 then
			gohelper.setActive(arg_11_0._goline, true)

			local var_11_11 = arg_11_0._skillEffectGOs[var_11_8]

			if not var_11_11 then
				var_11_11 = gohelper.cloneInPlace(arg_11_0._goskillspecialitem, "item" .. var_11_8)

				table.insert(arg_11_0._skillEffectGOs, var_11_11)
			end

			local var_11_12 = gohelper.findChildImage(var_11_11, "titlebg/bg")
			local var_11_13 = gohelper.findChildText(var_11_11, "titlebg/bg/name")
			local var_11_14 = gohelper.findChildText(var_11_11, "desc")

			SkillHelper.addHyperLinkClick(var_11_14, arg_11_0._onHyperLinkClick, arg_11_0)

			local var_11_15 = MonoHelper.addNoUpdateLuaComOnceToGo(var_11_14.gameObject, FixTmpBreakLine)

			if var_11_10 then
				SLFramework.UGUI.GuiHelper.SetColor(var_11_12:GetComponent("Image"), var_0_0.skillTypeColor[var_11_10.color])

				var_11_13.text = SkillHelper.removeRichTag(var_11_10.name)
				var_11_14.text = SkillHelper.getSkillDesc(arg_11_0.monsterName, var_11_10)

				var_11_15:refreshTmpContent(var_11_14)
			else
				logError("找不到技能eff_desc: " .. tostring(var_11_9))
			end

			gohelper.setActive(var_11_11, true)

			var_11_8 = var_11_8 + 1
		end
	end

	for iter_11_4 = var_11_8, #arg_11_0._skillEffectGOs do
		gohelper.setActive(arg_11_0._skillEffectGOs[iter_11_4], false)
	end

	arg_11_0:_refreshArrow()
end

function var_0_0._onHyperLinkClick(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_0.viewParam and arg_12_0.viewParam.adjustBuffTip then
		CommonBuffTipController.instance:openCommonTipViewWithCustomPosCallback(tonumber(arg_12_1), arg_12_0.setTipPosCallback, arg_12_0)
	else
		CommonBuffTipController.instance:openCommonTipViewWithCustomPos(tonumber(arg_12_1), CommonBuffTipEnum.Anchor[arg_12_0.viewName], CommonBuffTipEnum.Pivot.Right)
	end
end

function var_0_0.setTipPosCallback(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = 10
	local var_13_1 = arg_13_0._gonewskilltip.transform
	local var_13_2, var_13_3 = recthelper.uiPosToScreenPos2(var_13_1)
	local var_13_4, var_13_5 = SLFramework.UGUI.RectTrHelper.ScreenPosXYToAnchorPosXY(var_13_2, var_13_3, arg_13_1, CameraMgr.instance:getUICamera(), nil, nil)
	local var_13_6 = recthelper.getWidth(var_13_1) / 2
	local var_13_7 = GameUtil.getViewSize() / 2 + var_13_4 - var_13_6 - var_13_0
	local var_13_8 = recthelper.getWidth(arg_13_2)
	local var_13_9 = var_13_8 <= var_13_7
	local var_13_10 = var_13_4

	if var_13_9 then
		var_13_10 = var_13_10 - var_13_6 - var_13_0
	else
		var_13_10 = var_13_10 + var_13_6 + var_13_0 + var_13_8
	end

	local var_13_11 = var_13_5 + recthelper.getHeight(var_13_1) / 2

	arg_13_2.pivot = CommonBuffTipEnum.Pivot.Right

	recthelper.setAnchor(arg_13_2, var_13_10, var_13_11)
end

function var_0_0.AutoEffectDescItem()
	return
end

function var_0_0.onUpdateParam(arg_15_0)
	if arg_15_0.viewName ~= ViewName.FightFocusView then
		arg_15_0:initView()
	end
end

function var_0_0.onOpen(arg_16_0)
	if arg_16_0.viewName ~= ViewName.FightFocusView then
		arg_16_0:initView()
	else
		arg_16_0:hideInfo()
	end
end

function var_0_0.initView(arg_17_0)
	local var_17_0 = arg_17_0.viewParam

	arg_17_0.srcSkillIdList = var_17_0.skillIdList
	arg_17_0.isSuper = var_17_0.super
	arg_17_0.isCharacter = true

	arg_17_0:updateMonsterName()
	arg_17_0:refreshUpgradeBtn(arg_17_0.isCharacter)
	arg_17_0:_setNewSkills(arg_17_0.srcSkillIdList, arg_17_0.isSuper, arg_17_0.isCharacter)

	local var_17_1 = arg_17_0.viewGO.transform
	local var_17_2 = var_17_0 and var_17_0.anchorX

	if var_17_2 then
		recthelper.setAnchorX(var_17_1, var_17_2)
	end

	local var_17_3 = var_17_0 and var_17_0.anchorY

	if var_17_3 then
		recthelper.setAnchorY(var_17_1, var_17_3)
	end

	gohelper.setActive(arg_17_0._goassassinbg, var_17_0 and var_17_0.showAssassinBg)
end

function var_0_0.updateMonsterName(arg_18_0)
	arg_18_0.monsterName = arg_18_0.viewParam.monsterName

	if string.nilorempty(arg_18_0.monsterName) then
		logError("SkillTipView 缺少 monsterName 参数")

		arg_18_0.monsterName = ""
	end
end

function var_0_0.showInfo(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	if not arg_19_0._viewInitialized then
		return
	end

	arg_19_0.entityMo = FightDataHelper.entityMgr:getById(arg_19_3)
	arg_19_0.monsterName = FightConfig.instance:getEntityName(arg_19_3)
	arg_19_0.entitySkillIndex = arg_19_1.skillIndex

	if string.nilorempty(arg_19_0.monsterName) then
		logError("SkillTipView monsterName 为 nil, entityId : " .. tostring(arg_19_3))

		arg_19_0.monsterName = ""
	end

	arg_19_0.srcSkillIdList = arg_19_1.skillIdList
	arg_19_0.isSuper = arg_19_1.super
	arg_19_0.isCharacter = arg_19_2

	gohelper.setActive(arg_19_0._gonewskilltip, true)

	arg_19_0._upgradeSelectShow = false

	arg_19_0:refreshUpgradeBtn(arg_19_0.isCharacter)
	arg_19_0:_setNewSkills(arg_19_0.srcSkillIdList, arg_19_0.isSuper, arg_19_0.isCharacter)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Tipsopen)
end

function var_0_0.hideInfo(arg_20_0)
	if not arg_20_0._viewInitialized then
		return
	end

	gohelper.setActive(arg_20_0._gonewskilltip, false)
end

function var_0_0.refreshUpgradeBtn(arg_21_0, arg_21_1)
	if not arg_21_0._canShowUpgradeBtn then
		gohelper.setActive(arg_21_0._btnupgradeShow.gameObject, false)

		return
	end

	if arg_21_0.viewName ~= ViewName.FightFocusView then
		arg_21_0:refreshHeroUpgrade()
	else
		arg_21_0:refreshEntityUpgrade(arg_21_1)
	end
end

function var_0_0.refreshHeroUpgrade(arg_22_0)
	local var_22_0 = arg_22_0.viewParam.heroMo
	local var_22_1 = arg_22_0.viewParam.skillIndex
	local var_22_2 = var_22_0 and var_22_0.exSkillLevel or 0

	arg_22_0.hasBreakLevelSkill, arg_22_0.upgradeSkillIdList = SkillConfig.instance:getHeroUpgradeSkill(arg_22_0.viewParam.heroId, var_22_2, var_22_1)

	arg_22_0:refreshUpgradeUI()
end

function var_0_0.refreshEntityUpgrade(arg_23_0, arg_23_1)
	if not arg_23_1 then
		arg_23_0:refreshUpgradeUI()

		return
	end

	local var_23_0 = arg_23_0.entityMo and arg_23_0.entityMo:getCO()
	local var_23_1 = var_23_0 and var_23_0.id

	if not var_23_1 then
		gohelper.setActive(arg_23_0._btnupgradeShow.gameObject, false)

		return
	end

	arg_23_0.hasBreakLevelSkill, arg_23_0.upgradeSkillIdList = SkillConfig.instance:getHeroUpgradeSkill(var_23_1, arg_23_0.entityMo.exSkillLevel, arg_23_0.entitySkillIndex)

	if arg_23_0.upgradeSkillIdList and arg_23_0.srcSkillIdList[1] == arg_23_0.upgradeSkillIdList[1] then
		arg_23_0.upgraded = true
	else
		arg_23_0.upgraded = false
	end

	arg_23_0:refreshUpgradeUI()
end

function var_0_0._btnUpgradeShowOnClock(arg_24_0)
	arg_24_0._upgradeSelectShow = not arg_24_0._upgradeSelectShow

	arg_24_0:refreshUpgradeUI()

	local var_24_0 = arg_24_0._upgradeSelectShow and arg_24_0.upgradeSkillIdList or arg_24_0.srcSkillIdList

	arg_24_0:_setNewSkills(var_24_0, arg_24_0.isSuper, arg_24_0.isCharacter)
end

function var_0_0.refreshUpgradeUI(arg_25_0)
	local var_25_0 = not arg_25_0.upgraded and arg_25_0.hasBreakLevelSkill
	local var_25_1 = arg_25_0.upgraded or arg_25_0._upgradeSelectShow

	gohelper.setActive(arg_25_0._btnupgradeShow, var_25_0)
	gohelper.setActive(arg_25_0._goshowSelect, var_25_1)
	gohelper.setActive(arg_25_0._goBtnUpgraded, arg_25_0._upgradeSelectShow)
	gohelper.setActive(arg_25_0._goBtnNormal, not arg_25_0._upgradeSelectShow)
end

function var_0_0.setUpgradebtnShowState(arg_26_0, arg_26_1)
	arg_26_0._canShowUpgradeBtn = arg_26_1
end

function var_0_0.onClose(arg_27_0)
	return
end

function var_0_0.onDestroyView(arg_28_0)
	arg_28_0._scrollskilltipScrollview:RemoveOnValueChanged()

	if arg_28_0._newskillitems then
		for iter_28_0, iter_28_1 in pairs(arg_28_0._newskillitems) do
			iter_28_1.icon:UnLoadImage()
			iter_28_1.btn:RemoveClickListener()
		end
	end
end

return var_0_0
