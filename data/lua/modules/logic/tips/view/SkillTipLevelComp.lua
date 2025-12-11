module("modules.logic.tips.view.SkillTipLevelComp", package.seeall)

local var_0_0 = class("SkillTipLevelComp", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.viewComp = arg_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0._gonewskilltip = arg_2_1
	arg_2_0._scrollSkilltip = gohelper.findChildScrollRect(arg_2_1, "skilltipScrollview")
	arg_2_0._goContentSkilltip = gohelper.findChild(arg_2_1, "skilltipScrollview/Viewport/Content")
	arg_2_0._gospecialitem = gohelper.findChild(arg_2_0._goContentSkilltip, "name/special/#go_specialitem")
	arg_2_0._goline = gohelper.findChild(arg_2_0._goContentSkilltip, "#go_line")
	arg_2_0._goskillspecial = gohelper.findChild(arg_2_0._goContentSkilltip, "skillspecial")
	arg_2_0._goskillspecialitem = gohelper.findChild(arg_2_0._goContentSkilltip, "skillspecial/#go_skillspecialitem")
	arg_2_0._goarrow = gohelper.findChild(arg_2_1, "bottombg/#go_arrow")
	arg_2_0._gostoryDesc = gohelper.findChild(arg_2_0._goContentSkilltip, "#go_storyDesc")
	arg_2_0._txtstory = gohelper.findChildText(arg_2_0._goContentSkilltip, "#go_storyDesc/#txt_story")
	arg_2_0._btnupgradeShow = gohelper.findChildButtonWithAudio(arg_2_1, "#btn_upgradeShow")
	arg_2_0._goBtnNormal = gohelper.findChild(arg_2_0._btnupgradeShow.gameObject, "#go_normal")
	arg_2_0._goBtnUpgraded = gohelper.findChild(arg_2_0._btnupgradeShow.gameObject, "#go_upgraded")
	arg_2_0._goshowSelect = gohelper.findChild(arg_2_1, "#go_showSelect")
	arg_2_0._btnsupplement = gohelper.findChildButtonWithAudio(arg_2_1, "#btn_supplement")
	arg_2_0._goBtnsupplementNormal = gohelper.findChild(arg_2_0._btnsupplement.gameObject, "#go_normal")
	arg_2_0._goBtnsupplement = gohelper.findChild(arg_2_0._btnsupplement.gameObject, "#go_supplement")

	if arg_2_0._editableInitView then
		arg_2_0:_editableInitView()
	end
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0._btnupgradeShow:AddClickListener(arg_3_0._btnUpgradeShowOnClick, arg_3_0)
	arg_3_0._btnsupplement:AddClickListener(arg_3_0._btnSupplementOnClick, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	arg_4_0._btnupgradeShow:RemoveClickListener()
	arg_4_0._btnsupplement:RemoveClickListener()
end

var_0_0.skillTypeColor = {
	"#405874",
	"#8c4e31",
	"#9b7039"
}

function var_0_0._refreshArrow(arg_5_0)
	if recthelper.getHeight(arg_5_0._goContentSkilltip.transform) > recthelper.getHeight(arg_5_0._scrollSkilltip.transform) and arg_5_0._scrollSkilltip.verticalNormalizedPosition > 0.01 then
		gohelper.setActive(arg_5_0._goarrow, true)
	else
		gohelper.setActive(arg_5_0._goarrow, false)
	end
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._scrollSkilltip:AddOnValueChanged(arg_6_0._refreshArrow, arg_6_0)

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
	arg_6_0._newskillname = gohelper.findChildText(arg_6_0._goContentSkilltip, "name")
	arg_6_0._newskilldesc = gohelper.findChildText(arg_6_0._goContentSkilltip, "desc")
	arg_6_0._fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(arg_6_0._newskilldesc.gameObject, FixTmpBreakLine)

	SkillHelper.addHyperLinkClick(arg_6_0._newskilldesc, arg_6_0._onHyperLinkClick, arg_6_0)

	arg_6_0._skillTagGOs = arg_6_0:getUserDataTb_()
	arg_6_0._skillEffectGOs = arg_6_0:getUserDataTb_()

	gohelper.setActive(arg_6_0._gospecialitem, false)
	gohelper.setActive(arg_6_0._goskillspecialitem, false)
	gohelper.setActive(arg_6_0._btnsupplement.gameObject, false)

	arg_6_0._goarrow1 = gohelper.findChild(arg_6_0._gonewskilltip, "normal/arrow1")
	arg_6_0._goarrow2 = gohelper.findChild(arg_6_0._gonewskilltip, "normal/arrow2")
	arg_6_0._upgradeSelectShow = false
	arg_6_0._canShowUpgradeBtn = true
	arg_6_0._canShowUpgradeBtn = true
	arg_6_0._supplement = false

	arg_6_0:_refreshSupplementUI()
end

function var_0_0._skillItemClick(arg_7_0, arg_7_1)
	if arg_7_1 == arg_7_0._curSkillLevel then
		return
	end

	if arg_7_0.viewComp then
		arg_7_0.viewComp:onClickSkillItem(arg_7_1)
	else
		arg_7_0:_refreshSkill(arg_7_1)
	end
end

function var_0_0._setNewSkills(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_0._curSkillLevel = arg_8_0._curSkillLevel or nil
	arg_8_1 = arg_8_0:_checkReplaceSkill(arg_8_1)

	if arg_8_0._upgradeSelectShow then
		arg_8_0.hasBreakLevelSkill, arg_8_0.upgradeSkillIdList = SkillConfig.instance:getHeroUpgradeSkill(arg_8_1)
		arg_8_1 = arg_8_0.upgradeSkillIdList
	end

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
			arg_8_0._scrollSkilltip.verticalNormalizedPosition = 1

			arg_8_0:_refreshSkillSpecial(var_8_2)
		else
			logError("找不到技能: " .. tostring(arg_8_1[1]))
		end
	end

	gohelper.setActive(arg_8_0._gonewskilltip, true)
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
		arg_10_0._scrollSkilltip.verticalNormalizedPosition = 1

		arg_10_0:_refreshSkillSpecial(var_10_0)
	else
		logError("找不到技能: " .. tostring(arg_10_0._skillIdList[arg_10_1]))
		gohelper.setActive(arg_10_0._btnsupplement.gameObject, false)
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
	arg_11_0:_refreshSupplement(arg_11_1.id)
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

function var_0_0.initInfo(arg_14_0, arg_14_1)
	arg_14_0.viewParam = arg_14_1
	arg_14_0.srcSkillIdList = arg_14_1.skillIdList
	arg_14_0.isSuper = arg_14_1.super
	arg_14_0.viewName = arg_14_1.viewName

	arg_14_0:updateMonsterName()

	arg_14_0.srcSkillIdList = arg_14_1.skillIdList
	arg_14_0.isSuper = arg_14_1.super
	arg_14_0.isCharacter = true
	arg_14_0.entityMo = FightDataHelper.entityMgr:getById(arg_14_1.entityId)
	arg_14_0.entitySkillIndex = arg_14_1.entitySkillIndex
	arg_14_0._supplement = false

	arg_14_0:refreshUpgradeBtn(arg_14_0.isCharacter)
	arg_14_0:_setNewSkills(arg_14_0.srcSkillIdList, arg_14_0.isSuper, arg_14_0.isCharacter)
end

function var_0_0.updateMonsterName(arg_15_0)
	arg_15_0.monsterName = arg_15_0.viewParam.monsterName

	if string.nilorempty(arg_15_0.monsterName) then
		logError("SkillTipLevelComp 缺少 monsterName 参数")

		arg_15_0.monsterName = ""
	end
end

function var_0_0.refreshUpgradeBtn(arg_16_0, arg_16_1)
	if not arg_16_0._canShowUpgradeBtn then
		gohelper.setActive(arg_16_0._btnupgradeShow.gameObject, false)

		return
	end

	if arg_16_0.viewName ~= ViewName.FightFocusView then
		arg_16_0:refreshHeroUpgrade()
	else
		arg_16_0:refreshEntityUpgrade(arg_16_1)
	end
end

function var_0_0.refreshHeroUpgrade(arg_17_0)
	local var_17_0 = arg_17_0.viewParam.heroMo
	local var_17_1 = arg_17_0.viewParam.skillIndex

	if not var_17_0 or not var_17_0.exSkillLevel then
		local var_17_2 = 0
	end

	arg_17_0.hasBreakLevelSkill, arg_17_0.upgradeSkillIdList = SkillConfig.instance:getHeroUpgradeSkill(arg_17_0.srcSkillIdList)

	arg_17_0:refreshUpgradeUI()
end

function var_0_0.refreshEntityUpgrade(arg_18_0, arg_18_1)
	if not arg_18_1 then
		arg_18_0:refreshUpgradeUI()

		return
	end

	local var_18_0 = arg_18_0.entityMo and arg_18_0.entityMo:getCO()

	if not (var_18_0 and var_18_0.id) then
		gohelper.setActive(arg_18_0._btnupgradeShow.gameObject, false)

		return
	end

	arg_18_0.hasBreakLevelSkill, arg_18_0.upgradeSkillIdList = SkillConfig.instance:getHeroUpgradeSkill(arg_18_0.srcSkillIdList)

	if arg_18_0.upgradeSkillIdList and arg_18_0.srcSkillIdList[1] == arg_18_0.upgradeSkillIdList[1] then
		arg_18_0.upgraded = true
	else
		arg_18_0.upgraded = false
	end

	arg_18_0:refreshUpgradeUI()
end

function var_0_0._btnUpgradeShowOnClick(arg_19_0)
	arg_19_0._upgradeSelectShow = not arg_19_0._upgradeSelectShow

	arg_19_0:refreshUpgradeUI()
	arg_19_0:_setNewSkills(arg_19_0.srcSkillIdList, arg_19_0.isSuper, arg_19_0.isCharacter)
end

function var_0_0.refreshUpgradeUI(arg_20_0)
	local var_20_0 = not arg_20_0.upgraded and arg_20_0.hasBreakLevelSkill
	local var_20_1 = arg_20_0.upgraded or arg_20_0._upgradeSelectShow

	gohelper.setActive(arg_20_0._btnupgradeShow, var_20_0)
	gohelper.setActive(arg_20_0._goshowSelect, var_20_1)
	gohelper.setActive(arg_20_0._goBtnUpgraded, arg_20_0._upgradeSelectShow)
	gohelper.setActive(arg_20_0._goBtnNormal, not arg_20_0._upgradeSelectShow)
end

function var_0_0.setUpgradebtnShowState(arg_21_0, arg_21_1)
	arg_21_0._canShowUpgradeBtn = arg_21_1
end

function var_0_0._btnSupplementOnClick(arg_22_0)
	arg_22_0._supplement = not arg_22_0._supplement

	arg_22_0:_refreshSupplementUI()
end

function var_0_0._refreshSupplement(arg_23_0, arg_23_1)
	local var_23_0 = SkillConfig.instance:getFightCardFootnoteConfig(arg_23_1)

	if not arg_23_0._footnoteItem then
		arg_23_0._footnoteItem = arg_23_0:getUserDataTb_()

		local var_23_1 = gohelper.findChild(arg_23_0._goskillspecial, "footnoteItem") or gohelper.cloneInPlace(arg_23_0._goskillspecialitem, "footnoteItem")

		arg_23_0._footnoteItem.go = var_23_1
		arg_23_0._footnoteItem.gonameBg = gohelper.findChild(var_23_1, "titlebg")
		arg_23_0._footnoteItem.desc = gohelper.findChildText(var_23_1, "desc")
	end

	gohelper.setActive(arg_23_0._footnoteItem.gonameBg.gameObject, false)

	if var_23_0 then
		arg_23_0._footnoteItem.desc.text = var_23_0.desc
	else
		arg_23_0._supplement = false
	end

	gohelper.setActive(arg_23_0._btnsupplement.gameObject, var_23_0 ~= nil)
	arg_23_0:_refreshSupplementUI()
end

function var_0_0._refreshSupplementUI(arg_24_0)
	gohelper.setActive(arg_24_0._goBtnsupplementNormal, not arg_24_0._supplement)
	gohelper.setActive(arg_24_0._goBtnsupplement, arg_24_0._supplement)
	gohelper.setActive(arg_24_0._goline.gameObject, arg_24_0._supplement)

	if arg_24_0._footnoteItem then
		gohelper.setActive(arg_24_0._footnoteItem.go, arg_24_0._supplement)
	end
end

function var_0_0.onDestroyView(arg_25_0)
	arg_25_0._scrollSkilltip:RemoveOnValueChanged()

	if arg_25_0._newskillitems then
		for iter_25_0, iter_25_1 in pairs(arg_25_0._newskillitems) do
			iter_25_1.icon:UnLoadImage()
			iter_25_1.btn:RemoveClickListener()
		end
	end
end

function var_0_0.SetParent(arg_26_0, arg_26_1)
	arg_26_0._gonewskilltip.transform:SetParent(arg_26_1.transform)
end

function var_0_0.hideInfo(arg_27_0)
	gohelper.setActive(arg_27_0._gonewskilltip, false)
end

return var_0_0
