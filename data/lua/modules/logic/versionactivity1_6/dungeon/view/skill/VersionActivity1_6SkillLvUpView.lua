module("modules.logic.versionactivity1_6.dungeon.view.skill.VersionActivity1_6SkillLvUpView", package.seeall)

local var_0_0 = class("VersionActivity1_6SkillLvUpView", BaseView)
local var_0_1 = 570
local var_0_2 = "v1a6_talent_paint_line_%s_%s"

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnLvUp = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_skillDetailTipView/#btn_LvUp")
	arg_1_0._btnLvDown = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_skillDetailTipView/#btn_LvDown")
	arg_1_0._btnLvUpDisable = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_skillDetailTipView/#btn_LvUpDisable")
	arg_1_0._btnLvDownDisable = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_skillDetailTipView/#btn_LvDownDisable")
	arg_1_0._textLvUpCost = gohelper.findChildText(arg_1_0.viewGO, "#go_skillDetailTipView/#btn_LvUp/#txt_Num")
	arg_1_0._textLvDownCost = gohelper.findChildText(arg_1_0.viewGO, "#go_skillDetailTipView/#btn_LvDown/#txt_Num")
	arg_1_0._iamgeBtnLvUp = gohelper.findChildImage(arg_1_0.viewGO, "#go_skillDetailTipView/#btn_LvUp/#txt_Num/#simage_Prop")
	arg_1_0._imageBtnLvDown = gohelper.findChildImage(arg_1_0.viewGO, "#go_skillDetailTipView/#btn_LvDown/#txt_Num/#simage_Prop")
	arg_1_0._txtTitle = gohelper.findChildText(arg_1_0.viewGO, "Left/Title/txt_Title")
	arg_1_0._txtTitleEn = gohelper.findChildText(arg_1_0.viewGO, "Left/Title/txt_TitleEn")
	arg_1_0._imageIcon = gohelper.findChildImage(arg_1_0.viewGO, "Left/#image_Icon")
	arg_1_0._imageIconGold = gohelper.findChildImage(arg_1_0.viewGO, "Left/#image_Icon_gold")
	arg_1_0._imageIconSliver = gohelper.findChildImage(arg_1_0.viewGO, "Left/#image_Icon_sliver")
	arg_1_0._txtDesc = gohelper.findChildText(arg_1_0.viewGO, "Left/#txt_Descr")
	arg_1_0._btnSkillPointProp = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "SkillPoint/#btn_Info/Click")
	arg_1_0._btnSkillPointTips = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "SkillPoint/#btn_Info")
	arg_1_0._btnTipsClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "SkillPoint/#btn_Info/image_TipsBG/#btn_Tips_Close")
	arg_1_0._goSkilPointTips = gohelper.findChild(arg_1_0.viewGO, "SkillPoint/#btn_Info/image_TipsBG")
	arg_1_0._txtSkillPointNum = gohelper.findChildText(arg_1_0.viewGO, "SkillPoint/#btn_Info/image_TipsBG/txt_Tips_Num")
	arg_1_0._txtRemainSkillPointNum = gohelper.findChildText(arg_1_0.viewGO, "SkillPoint/txt_Skill_Num")
	arg_1_0._imageSkillPoint = gohelper.findChildImage(arg_1_0.viewGO, "SkillPoint/#simage_Prop")
	arg_1_0._goSkillIconEffect = gohelper.findChild(arg_1_0.viewGO, "Left/eff")
	arg_1_0._goSkillPointEffect = gohelper.findChild(arg_1_0.viewGO, "SkillPoint/eff")
	arg_1_0._goSkilPointAttrContent = gohelper.findChild(arg_1_0.viewGO, "#go_skillDetailTipView/skillDetailTipScroll/Viewport/#go_Content")
	arg_1_0._goSkilPointAttrItem = gohelper.findChild(arg_1_0.viewGO, "#go_skillDetailTipView/skillDetailTipScroll/Viewport/#go_Content/#go_descripteList")
	arg_1_0._goBuffContainer = gohelper.findChild(arg_1_0.viewGO, "#go_buffContainer")
	arg_1_0._buffBg = gohelper.findChild(arg_1_0.viewGO, "#go_buffContainer/buff_bg")
	arg_1_0._buffBgClick = gohelper.getClick(arg_1_0._buffBg)
	arg_1_0._goBuffItem = gohelper.findChild(arg_1_0.viewGO, "#go_buffContainer/#go_buffitem")
	arg_1_0._txtBuffName = gohelper.findChildText(arg_1_0.viewGO, "#go_buffContainer/#go_buffitem/title/txt_name")
	arg_1_0._goBuffTag = gohelper.findChild(arg_1_0.viewGO, "#go_buffContainer/#go_buffitem/title/txt_name/go_tag")
	arg_1_0._txtBuffTagName = gohelper.findChildText(arg_1_0.viewGO, "#go_buffContainer/#go_buffitem/title/txt_name/go_tag/bg/txt_tagname")
	arg_1_0._txtBuffDesc = gohelper.findChildText(arg_1_0.viewGO, "#go_buffContainer/#go_buffitem/txt_desc")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnLvUp:AddClickListener(arg_2_0._btnLvUpOnClick, arg_2_0)
	arg_2_0._btnLvUpDisable:AddClickListener(arg_2_0._btnLvUpOnClick, arg_2_0)
	arg_2_0._btnLvDown:AddClickListener(arg_2_0._btnLvDownOnClick, arg_2_0)
	arg_2_0._btnLvDownDisable:AddClickListener(arg_2_0._btnLvDownOnClick, arg_2_0)
	arg_2_0._btnSkillPointProp:AddClickListener(arg_2_0._btnSkillPointOnClick, arg_2_0)
	arg_2_0._btnSkillPointTips:AddClickListener(arg_2_0._btnSkillPointTipsOnClick, arg_2_0)
	arg_2_0._btnTipsClose:AddClickListener(arg_2_0._btnSkillPointTipsCloseOnClick, arg_2_0)
	arg_2_0._buffBgClick:AddClickDownListener(arg_2_0.hideBuffContainer, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnLvUp:RemoveClickListener()
	arg_3_0._btnLvDown:RemoveClickListener()
	arg_3_0._btnLvUpDisable:RemoveClickListener()
	arg_3_0._btnLvDownDisable:RemoveClickListener()
	arg_3_0._btnSkillPointTips:RemoveClickListener()
	arg_3_0._btnSkillPointProp:RemoveClickListener()
	arg_3_0._btnTipsClose:RemoveClickListener()
	arg_3_0._buffBgClick:RemoveClickDownListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0.skillAttrItemDict = {}

	gohelper.setActive(arg_4_0._goSkilPointAttrItem, false)
	gohelper.setActive(arg_4_0._goBuffContainer, false)
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:addEventCb(VersionActivity1_6DungeonController.instance, Act148Event.SkillLvDown, arg_6_0._onLvChange, arg_6_0)
	arg_6_0:addEventCb(VersionActivity1_6DungeonController.instance, Act148Event.SkillLvUp, arg_6_0._onLvChange, arg_6_0)
	arg_6_0:addEventCb(VersionActivity1_6DungeonController.instance, VersionActivity1_6DungeonEvent.SkillPointReturnBack, arg_6_0._skillPointReturnBack, arg_6_0)
	arg_6_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_6_0._onCurrencyChange, arg_6_0)
	arg_6_0:addEventCb(JumpController.instance, JumpEvent.BeforeJump, arg_6_0.closeThis, arg_6_0)

	arg_6_0._skillType = arg_6_0.viewParam and arg_6_0.viewParam.skillType
	arg_6_0._skillMo = VersionActivity1_6DungeonSkillModel.instance:getAct148SkillMo(arg_6_0._skillType)
	arg_6_0._curLv = arg_6_0._skillMo:getLevel()

	gohelper.setActive(arg_6_0._goSkilPointTips, false)
end

function var_0_0.onOpenFinish(arg_7_0)
	arg_7_0:initCenterSkillNodes()
	arg_7_0:refreshCenterSkillNodes()
	arg_7_0:_refreshSkillPointNum()
	arg_7_0:refreshSkillInfo()
	arg_7_0:refreshSkillIcon()
	arg_7_0:initSkillAttrItems()
	arg_7_0:refreshSkillAttrs()
	arg_7_0:refreshBtnCost()
	arg_7_0:_refreshSkillPointIcon()
	arg_7_0:_refreshBtnVisible()
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	return
end

function var_0_0._onLvChange(arg_10_0, arg_10_1)
	arg_10_0._skillMo = VersionActivity1_6DungeonSkillModel.instance:getAct148SkillMo(arg_10_0._skillType)

	local var_10_0 = arg_10_1 < arg_10_0._curLv

	AudioMgr.instance:trigger(var_10_0 and AudioEnum.UI.Act1_6DungeonSkillViewLvDown or AudioEnum.UI.Act1_6DungeonSkillViewLvUp)

	arg_10_0._curLv = arg_10_1

	arg_10_0:doSkillLvChangeView(arg_10_1)
	arg_10_0:refreshSkillAttrs(var_10_0)
	arg_10_0:refreshCenterSkillNodes()
	arg_10_0:_refreshSkillNodeEffect(var_10_0)
	arg_10_0:_refreshSkillPointNum()
	arg_10_0:refreshBtnCost()
	arg_10_0:refreshSkillIcon()
	arg_10_0:_refreshBtnVisible()
end

function var_0_0.initCenterSkillNodes(arg_11_0)
	arg_11_0._skillLvPoints = arg_11_0:getUserDataTb_()

	local var_11_0 = VersionActivity1_6DungeonEnum.skillTypeNum

	for iter_11_0 = 1, var_11_0 do
		local var_11_1 = gohelper.findChild(arg_11_0.viewGO, "#go_Paint" .. iter_11_0)

		gohelper.setActive(var_11_1, iter_11_0 == arg_11_0._skillType)
	end

	local var_11_2 = gohelper.findChild(arg_11_0.viewGO, "#go_Paint" .. arg_11_0._skillType)

	arg_11_0._imageSkillNodeLine = gohelper.findChildImage(var_11_2, "image_PaintLineFG")
	arg_11_0._animatorSkillNodeLine = arg_11_0._imageSkillNodeLine:GetComponent(typeof(UnityEngine.Animator))

	local var_11_3 = VersionActivity1_6DungeonEnum.skillPointMaxNum
	local var_11_4 = gohelper.findChild(var_11_2, "#go_Lv")

	for iter_11_1 = 1, var_11_3 do
		local var_11_5 = gohelper.findChild(var_11_2, "#go_Lv" .. iter_11_1)
		local var_11_6 = gohelper.clone(var_11_4, var_11_5, "node")

		gohelper.setActive(var_11_6, true)

		arg_11_0._skillLvPoints[iter_11_1] = arg_11_0:getUserDataTb_()
		arg_11_0._skillLvPoints[iter_11_1].normalPointDark = gohelper.findChild(var_11_6, "#go_Point1-1")
		arg_11_0._skillLvPoints[iter_11_1].normalPoint = gohelper.findChild(var_11_6, "#go_Point1-2")
		arg_11_0._skillLvPoints[iter_11_1].keyPointDark = gohelper.findChild(var_11_6, "#go_Point2-1")
		arg_11_0._skillLvPoints[iter_11_1].keyPoint = gohelper.findChild(var_11_6, "#go_Point2-2")
		arg_11_0._skillLvPoints[iter_11_1].effect = gohelper.findChild(var_11_6, "eff")
	end
end

function var_0_0.refreshCenterSkillNodes(arg_12_0)
	local var_12_0 = VersionActivity1_6DungeonEnum.SkillKeyPointIdxs
	local var_12_1 = VersionActivity1_6DungeonEnum.skillPointMaxNum

	for iter_12_0 = 1, var_12_1 do
		local var_12_2 = var_12_0[iter_12_0]
		local var_12_3 = iter_12_0 > arg_12_0._curLv
		local var_12_4 = iter_12_0 > arg_12_0._curLv
		local var_12_5 = iter_12_0 <= arg_12_0._curLv
		local var_12_6 = iter_12_0 <= arg_12_0._curLv

		if var_12_2 then
			var_12_3 = false
			var_12_5 = false
		else
			var_12_6 = false
			var_12_4 = false
		end

		gohelper.setActive(arg_12_0._skillLvPoints[iter_12_0].normalPoint, var_12_5)
		gohelper.setActive(arg_12_0._skillLvPoints[iter_12_0].normalPointDark, var_12_3)
		gohelper.setActive(arg_12_0._skillLvPoints[iter_12_0].keyPoint, var_12_6)
		gohelper.setActive(arg_12_0._skillLvPoints[iter_12_0].keyPointDark, var_12_4)
	end

	gohelper.setActive(arg_12_0._imageSkillNodeLine.gameObject, arg_12_0._curLv > 1)

	if arg_12_0._curLv > 1 then
		local var_12_7 = string.format(var_0_2, arg_12_0._skillType, arg_12_0._curLv - 1)

		UISpriteSetMgr.instance:setV1a6DungeonSkillSprite(arg_12_0._imageSkillNodeLine, var_12_7)

		if arg_12_0._animatorSkillNodeLine then
			arg_12_0._animatorSkillNodeLine:Play(UIAnimationName.Open, 0, 0)
		end
	end
end

function var_0_0._refreshSkillNodeEffect(arg_13_0, arg_13_1)
	if arg_13_1 then
		gohelper.setActive(arg_13_0._goSkillPointEffect, false)
		gohelper.setActive(arg_13_0._goSkillPointEffect, true)
	end

	gohelper.setActive(arg_13_0._goSkillIconEffect, false)
	gohelper.setActive(arg_13_0._goSkillIconEffect, true)

	local var_13_0 = VersionActivity1_6DungeonEnum.SkillKeyPointIdxs
	local var_13_1 = VersionActivity1_6DungeonEnum.skillPointMaxNum

	for iter_13_0 = 1, var_13_1 do
		if not arg_13_1 then
			gohelper.setActive(arg_13_0._skillLvPoints[iter_13_0].effect, arg_13_0._curLv == iter_13_0)
		end
	end
end

local var_0_3 = "#E4C599"

function var_0_0._refreshSkillPointNum(arg_14_0)
	local var_14_0 = Activity148Config.instance:getAct148ConstValue(VersionActivity1_6Enum.ActivityId.DungeonSkillTree, VersionActivity1_6DungeonEnum.DungeonConstId.MaxSkillPointNum)
	local var_14_1 = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V1a6DungeonSkill)
	local var_14_2 = var_14_1 and var_14_1.quantity or 0

	if LangSettings.instance:isEn() then
		arg_14_0._txtRemainSkillPointNum.text = " " .. var_14_2
	else
		arg_14_0._txtRemainSkillPointNum.text = var_14_2
	end

	SLFramework.UGUI.GuiHelper.SetColor(arg_14_0._txtRemainSkillPointNum, var_0_3)

	local var_14_3 = VersionActivity1_6DungeonSkillModel.instance:getTotalGotSkillPointNum()
	local var_14_4 = string.format("<color=#EB5F34>%s</color>/%s", var_14_3 or 0, var_14_0)

	arg_14_0._txtSkillPointNum.text = var_14_4
end

function var_0_0.refreshSkillInfo(arg_15_0)
	local var_15_0 = arg_15_0._skillMo and arg_15_0._skillMo:getLevel() or 0
	local var_15_1 = Activity148Config.instance:getAct148CfgByTypeLv(arg_15_0._skillType, var_15_0)
	local var_15_2 = Activity148Config.instance:getAct148SkillTypeCfg(arg_15_0._skillType)

	if var_15_0 == 0 then
		local var_15_3 = Activity148Config.instance:getAct148CfgByTypeLv(arg_15_0._skillType, 1)
	end

	arg_15_0._txtTitle.text = var_15_2.skillName
	arg_15_0._txtTitleEn.text = var_15_2.skillNameEn
	arg_15_0._txtDesc.text = var_15_2.skillInfoDesc
end

function var_0_0.refreshSkillIcon(arg_16_0)
	local var_16_0 = arg_16_0._skillMo and arg_16_0._skillMo:getLevel() or 0
	local var_16_1 = Activity148Config.instance:getAct148CfgByTypeLv(arg_16_0._skillType, var_16_0)
	local var_16_2 = Activity148Config.instance:getAct148SkillTypeCfg(arg_16_0._skillType)
	local var_16_3

	if var_16_0 == 0 then
		var_16_3 = Activity148Config.instance:getAct148ConstValue(VersionActivity1_6Enum.ActivityId.DungeonSkillTree, VersionActivity1_6DungeonEnum.SkillOriginIcon[arg_16_0._skillType])
	else
		var_16_3 = var_16_1.skillSmallIcon
	end

	UISpriteSetMgr.instance:setV1a6DungeonSkillSprite(arg_16_0._imageIcon, var_16_3)

	local var_16_4 = Activity148Config.instance:getAct148ConstValue(VersionActivity1_6Enum.ActivityId.DungeonSkillTree, VersionActivity1_6DungeonEnum.DungeonConstId.SilverEffectSkillLv)
	local var_16_5 = Activity148Config.instance:getAct148ConstValue(VersionActivity1_6Enum.ActivityId.DungeonSkillTree, VersionActivity1_6DungeonEnum.DungeonConstId.GoldEffectSkillLv)

	UISpriteSetMgr.instance:setV1a6DungeonSkillSprite(arg_16_0._imageIconGold, var_16_3)
	UISpriteSetMgr.instance:setV1a6DungeonSkillSprite(arg_16_0._imageIconSliver, var_16_3)

	local var_16_6 = var_16_0 >= tonumber(var_16_5)
	local var_16_7 = var_16_0 >= tonumber(var_16_4)

	if var_16_6 then
		gohelper.setActive(arg_16_0._imageIconSliver.gameObject, false)
		gohelper.setActive(arg_16_0._imageIconGold.gameObject, true)
	elseif var_16_7 then
		gohelper.setActive(arg_16_0._imageIconSliver.gameObject, true)
		gohelper.setActive(arg_16_0._imageIconGold.gameObject, false)
	else
		gohelper.setActive(arg_16_0._imageIconSliver.gameObject, false)
		gohelper.setActive(arg_16_0._imageIconGold.gameObject, false)
	end
end

function var_0_0.initSkillAttrItems(arg_17_0)
	local var_17_0 = Activity148Config.instance:getAct148CfgDictByType(arg_17_0._skillType)

	for iter_17_0, iter_17_1 in pairs(var_17_0) do
		local var_17_1 = gohelper.cloneInPlace(arg_17_0._goSkilPointAttrItem, "item" .. iter_17_0)

		gohelper.setActive(var_17_1, true)

		local var_17_2 = arg_17_0:createSkillAttrItem(var_17_1, iter_17_1)

		arg_17_0.skillAttrItemDict[iter_17_1.id] = var_17_2
	end
end

function var_0_0.createSkillAttrItem(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = VersionActivity1_6SkillDescItem.New()

	var_18_0:init(arg_18_1, arg_18_2, arg_18_0)
	var_18_0:refreshInfo()

	return var_18_0
end

function var_0_0.refreshSkillAttrs(arg_19_0, arg_19_1)
	local var_19_0 = Activity148Config.instance:getAct148CfgDictByType(arg_19_0._skillType)

	for iter_19_0, iter_19_1 in pairs(var_19_0) do
		local var_19_1 = arg_19_0.skillAttrItemDict[iter_19_1.id]

		var_19_1.canvasGroup.alpha = arg_19_0._curLv < var_19_1.lv and 0.5 or 1
		var_19_1.txtlvcanvasGroup.alpha = arg_19_0._curLv < var_19_1.lv and 0.5 or 1

		gohelper.setActive(var_19_1.goCurLvFlag, arg_19_0._curLv == var_19_1.lv - 1)
	end

	local var_19_2 = 3
	local var_19_3 = 5

	if arg_19_1 and var_19_3 > arg_19_0._curLv or not arg_19_1 and arg_19_0._curLv > 3 then
		local var_19_4 = 0
		local var_19_5 = 0

		for iter_19_2 = 1, VersionActivity1_6DungeonEnum.skillMaxLv do
			local var_19_6 = var_19_0[iter_19_2]
			local var_19_7 = arg_19_0.skillAttrItemDict[var_19_6.id].height

			if iter_19_2 == arg_19_0._curLv then
				var_19_5 = var_19_4
			end

			var_19_4 = var_19_4 + var_19_7
		end

		recthelper.setAnchorY(arg_19_0._goSkilPointAttrContent.transform, var_19_5)
	end
end

function var_0_0.doSkillLvChangeView(arg_20_0, arg_20_1)
	for iter_20_0, iter_20_1 in pairs(arg_20_0.skillAttrItemDict) do
		gohelper.setActive(iter_20_1.vx, arg_20_1 == iter_20_1.lv)
	end
end

function var_0_0.refreshBtnCost(arg_21_0)
	local var_21_0 = arg_21_0._curLv
	local var_21_1 = var_21_0 - 1
	local var_21_2 = var_21_0 + 1
	local var_21_3 = Activity148Config.instance:getAct148CfgByTypeLv(arg_21_0._skillType, var_21_0)
	local var_21_4 = ""

	if var_21_3 then
		local var_21_5 = var_21_3.cost
		local var_21_6 = string.splitToNumber(var_21_5, "#")[3]

		var_21_4 = "+" .. var_21_6
	end

	arg_21_0._textLvDownCost.text = var_21_4

	local var_21_7 = ""
	local var_21_8 = Activity148Config.instance:getAct148CfgByTypeLv(arg_21_0._skillType, var_21_2)

	if var_21_8 then
		local var_21_9 = var_21_8.cost
		local var_21_10 = string.splitToNumber(var_21_9, "#")[3]

		var_21_7 = "-" .. var_21_10
	end

	arg_21_0._textLvUpCost.text = var_21_7
end

function var_0_0._refreshBtnVisible(arg_22_0)
	local var_22_0 = arg_22_0._curLv
	local var_22_1 = var_22_0 + 1
	local var_22_2 = var_22_0 - 1
	local var_22_3 = Activity148Config.instance:getAct148CfgByTypeLv(arg_22_0._skillType, var_22_1) ~= nil
	local var_22_4 = var_22_2 >= 0

	gohelper.setActive(arg_22_0._btnLvUp, var_22_3)
	gohelper.setActive(arg_22_0._btnLvUpDisable, not var_22_3)
	gohelper.setActive(arg_22_0._btnLvDown, var_22_4)
	gohelper.setActive(arg_22_0._btnLvDownDisable, not var_22_4)
end

function var_0_0._refreshSkillPointIcon(arg_23_0)
	local var_23_0 = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.V1a6DungeonSkill)
	local var_23_1 = string.format("%s_1", var_23_0 and var_23_0.icon)

	UISpriteSetMgr.instance:setCurrencyItemSprite(arg_23_0._imageSkillPoint, var_23_1)
	UISpriteSetMgr.instance:setCurrencyItemSprite(arg_23_0._iamgeBtnLvUp, var_23_1)
	UISpriteSetMgr.instance:setCurrencyItemSprite(arg_23_0._imageBtnLvDown, var_23_1)
end

function var_0_0.showBuffContainer(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	gohelper.setActive(arg_24_0._goBuffContainer, true)

	arg_24_0.buffItemWidth = GameUtil.getTextWidthByLine(arg_24_0._txtBuffDesc, arg_24_2, 24)
	arg_24_0.buffItemWidth = arg_24_0.buffItemWidth + 70

	if arg_24_0.buffItemWidth > var_0_1 then
		arg_24_0.buffItemWidth = var_0_1
	end

	arg_24_0._txtBuffName.text = arg_24_1
	arg_24_0._txtBuffDesc.text = arg_24_2

	local var_24_0 = FightConfig.instance:getBuffTag(arg_24_1)

	gohelper.setActive(arg_24_0._goBuffTag, not string.nilorempty(var_24_0))

	arg_24_0._txtBuffTagName.text = var_24_0

	local var_24_1 = recthelper.screenPosToAnchorPos(arg_24_3, arg_24_0.viewGO.transform)

	recthelper.setAnchor(arg_24_0._goBuffItem.transform, var_24_1.x - 20, var_24_1.y)
end

function var_0_0.hideBuffContainer(arg_25_0)
	gohelper.setActive(arg_25_0._goBuffContainer, false)
end

function var_0_0._btnLvUpOnClick(arg_26_0)
	local var_26_0 = arg_26_0._curLv + 1
	local var_26_1 = Activity148Config.instance:getAct148CfgByTypeLv(arg_26_0._skillType, var_26_0)

	if not var_26_1 then
		GameFacade.showToast(ToastEnum.Act1_6DungeonToast60201)
	else
		local var_26_2 = var_26_1.cost
		local var_26_3 = string.splitToNumber(var_26_2, "#")
		local var_26_4 = var_26_3[2]

		if var_26_3[3] > CurrencyModel.instance:getCurrency(var_26_4).quantity then
			GameFacade.showToast(ToastEnum.Act1_6DungeonToast60203)

			return
		end

		VersionActivity1_6DungeonRpc.instance:sendAct148UpLevelRequest(arg_26_0._skillType)
	end
end

function var_0_0._btnLvDownOnClick(arg_27_0)
	if arg_27_0._curLv - 1 < 0 then
		GameFacade.showToast(ToastEnum.Act1_6DungeonToast60202)
	else
		VersionActivity1_6DungeonRpc.instance:sendAct148DownLevelRequest(arg_27_0._skillType)
	end
end

function var_0_0._btnSkillPointOnClick(arg_28_0)
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Currency, CurrencyEnum.CurrencyType.V1a6DungeonSkill, false, nil, false)
end

function var_0_0._btnSkillPointTipsOnClick(arg_29_0)
	arg_29_0:refreshSkillPointTips(true)
end

function var_0_0._btnSkillPointTipsCloseOnClick(arg_30_0)
	arg_30_0:refreshSkillPointTips(false)
end

function var_0_0.refreshSkillPointTips(arg_31_0, arg_31_1)
	gohelper.setActive(arg_31_0._goSkilPointTips, arg_31_1)
end

function var_0_0._skillPointReturnBack(arg_32_0)
	arg_32_0:_refreshSkillPointNum()
end

function var_0_0._onCurrencyChange(arg_33_0)
	arg_33_0:_refreshSkillPointNum()
end

return var_0_0
