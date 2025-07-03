module("modules.logic.versionactivity2_7.act191.view.Act191CharacterTipView", package.seeall)

local var_0_0 = class("Act191CharacterTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gopassiveskilltip = gohelper.findChild(arg_1_0.viewGO, "#go_passiveskilltip")
	arg_1_0._simageshadow = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_passiveskilltip/mask/root/scrollview/#simage_shadow")
	arg_1_0._goeffectdesc = gohelper.findChild(arg_1_0.viewGO, "#go_passiveskilltip/mask/root/scrollview/viewport/content/#go_effectdesc")
	arg_1_0._goeffectdescitem = gohelper.findChild(arg_1_0.viewGO, "#go_passiveskilltip/mask/root/scrollview/viewport/content/#go_effectdesc/#go_effectdescitem")
	arg_1_0._scrollview = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_passiveskilltip/mask/root/scrollview")
	arg_1_0._gomask1 = gohelper.findChild(arg_1_0.viewGO, "#go_passiveskilltip/mask/root/scrollview/#go_mask1")
	arg_1_0._txtpassivename = gohelper.findChildText(arg_1_0.viewGO, "#go_passiveskilltip/name/bg/#txt_passivename")
	arg_1_0._btnclosepassivetip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_passiveskilltip/#btn_closepassivetip")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclosepassivetip:AddClickListener(arg_2_0._btnclosepassivetipOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclosepassivetip:RemoveClickListener()
end

function var_0_0._btnclosepassivetipOnClick(arg_4_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._passiveskilltipcontent = gohelper.findChild(arg_5_0._gopassiveskilltip, "mask/root/scrollview/viewport/content")
	arg_5_0._passiveskilltipmask = gohelper.findChild(arg_5_0._gopassiveskilltip, "mask"):GetComponent(typeof(UnityEngine.UI.RectMask2D))

	arg_5_0._simageshadow:LoadImage(ResUrl.getCharacterIcon("bg_shade"))

	arg_5_0._passiveskillitems = {}

	for iter_5_0 = 1, 3 do
		local var_5_0 = arg_5_0:getUserDataTb_()

		var_5_0.go = gohelper.findChild(arg_5_0._gopassiveskilltip, "mask/root/scrollview/viewport/content/talentstar" .. tostring(iter_5_0))
		var_5_0.desc = gohelper.findChildTextMesh(var_5_0.go, "desctxt")
		var_5_0.hyperLinkClick = SkillHelper.addHyperLinkClick(var_5_0.desc, arg_5_0._onHyperLinkClick, arg_5_0)
		var_5_0.fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(var_5_0.desc.gameObject, FixTmpBreakLine)
		var_5_0.on = gohelper.findChild(var_5_0.go, "#go_passiveskills/passiveskill/on")
		var_5_0.unlocktxt = gohelper.findChildText(var_5_0.go, "#go_passiveskills/passiveskill/unlocktxt")
		var_5_0.canvasgroup = gohelper.onceAddComponent(var_5_0.go, typeof(UnityEngine.CanvasGroup))
		var_5_0.connectline = gohelper.findChild(var_5_0.go, "line")
		arg_5_0._passiveskillitems[iter_5_0] = var_5_0
	end

	arg_5_0._txtpassivename = gohelper.findChildText(arg_5_0.viewGO, "#go_passiveskilltip/name/bg/#txt_passivename")
	arg_5_0._skillEffectDescItems = arg_5_0:getUserDataTb_()
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	local var_7_0 = arg_7_0.viewParam

	arg_7_0.config = Activity191Config.instance:getRoleCo(var_7_0.id)

	arg_7_0:_setPassiveSkill(var_7_0.anchorParams, var_7_0.tipPos)
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	return
end

function var_0_0._setPassiveSkill(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0._matchSkillNames = {}

	local var_10_0 = Activity191Config.instance:getHeroPassiveSkillIdList(arg_10_0.config.id)

	if arg_10_0.viewParam.stoneId then
		var_10_0 = Activity191Helper.replaceSkill(arg_10_0.viewParam.stoneId, var_10_0)
	end

	local var_10_1 = #var_10_0 <= 3 and #var_10_0 or 3
	local var_10_2 = var_10_0[1]

	arg_10_0._txtpassivename.text = lua_skill.configDict[var_10_2].name

	local var_10_3 = {}

	for iter_10_0 = 1, var_10_1 do
		local var_10_4 = var_10_0[iter_10_0]
		local var_10_5 = lua_skill.configDict[var_10_4]
		local var_10_6 = FightConfig.instance:getSkillEffectDesc(arg_10_0.config.name, var_10_5)

		table.insert(var_10_3, var_10_6)
	end

	local var_10_7 = HeroSkillModel.instance:getSkillEffectTagIdsFormDescTabRecursion(var_10_3)
	local var_10_8 = {}
	local var_10_9 = {}

	for iter_10_1 = 1, var_10_1 do
		local var_10_10 = var_10_0[iter_10_1]
		local var_10_11 = true
		local var_10_12 = lua_skill.configDict[var_10_10]
		local var_10_13 = FightConfig.instance:getSkillEffectDesc(arg_10_0.config.name, var_10_12)

		for iter_10_2, iter_10_3 in ipairs(var_10_7[iter_10_1]) do
			local var_10_14 = SkillConfig.instance:getSkillEffectDescCo(iter_10_3)
			local var_10_15 = var_10_14.name

			if HeroSkillModel.instance:canShowSkillTag(var_10_15, true) and not var_10_8[var_10_15] then
				var_10_8[var_10_15] = true

				if var_10_14.isSpecialCharacter == 1 then
					local var_10_16 = var_10_14.desc

					var_10_13 = string.format("%s", var_10_13)

					local var_10_17 = SkillHelper.buildDesc(var_10_16)

					table.insert(var_10_9, {
						desc = var_10_17,
						title = var_10_14.name
					})
				end
			end
		end

		local var_10_18 = SkillHelper.buildDesc(var_10_13)
		local var_10_19 = arg_10_0:_getTargetRankByEffect(arg_10_0.config.roleId, iter_10_1)

		arg_10_0._passiveskillitems[iter_10_1].unlocktxt.text = string.format(luaLang("character_passive_unlock"), GameUtil.getRomanNums(var_10_19))

		SLFramework.UGUI.GuiHelper.SetColor(arg_10_0._passiveskillitems[iter_10_1].unlocktxt, "#313B33")

		arg_10_0._passiveskillitems[iter_10_1].canvasgroup.alpha = var_10_11 and 1 or 0.83

		gohelper.setActive(arg_10_0._passiveskillitems[iter_10_1].on, var_10_11)

		arg_10_0._passiveskillitems[iter_10_1].desc.text = var_10_18

		arg_10_0._passiveskillitems[iter_10_1].fixTmpBreakLine:refreshTmpContent(arg_10_0._passiveskillitems[iter_10_1].desc)
		SLFramework.UGUI.GuiHelper.SetColor(arg_10_0._passiveskillitems[iter_10_1].desc, var_10_11 and "#272525" or "#3A3A3A")
		gohelper.setActive(arg_10_0._passiveskillitems[iter_10_1].go, true)
		gohelper.setActive(arg_10_0._passiveskillitems[iter_10_1].connectline, iter_10_1 ~= var_10_1)
	end

	for iter_10_4 = var_10_1 + 1, #arg_10_0._passiveskillitems do
		gohelper.setActive(arg_10_0._passiveskillitems[iter_10_4].go, false)
	end

	arg_10_0:_showSkillEffectDesc(var_10_9)
	arg_10_0:_refreshPassiveSkillScroll()
	arg_10_0:_setTipPos(arg_10_0._gopassiveskilltip.transform, arg_10_2, arg_10_1)
end

function var_0_0._getTargetRankByEffect(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = SkillConfig.instance:getheroranksCO(arg_11_1)

	for iter_11_0, iter_11_1 in pairs(var_11_0) do
		if CharacterModel.instance:getrankEffects(arg_11_1, iter_11_0)[2] == arg_11_2 then
			return iter_11_0 - 1
		end
	end

	return 0
end

function var_0_0._showSkillEffectDesc(arg_12_0, arg_12_1)
	gohelper.setActive(arg_12_0._goeffectdesc, arg_12_1 and #arg_12_1 > 0)

	for iter_12_0 = 1, #arg_12_1 do
		local var_12_0 = arg_12_1[iter_12_0]
		local var_12_1 = arg_12_0:_getSkillEffectDescItem(iter_12_0)

		var_12_1.desc.text = var_12_0.desc
		var_12_1.title.text = SkillHelper.removeRichTag(var_12_0.title)

		var_12_1.fixTmpBreakLine:refreshTmpContent(var_12_1.desc)
		gohelper.setActive(var_12_1.go, true)
	end

	for iter_12_1 = #arg_12_1 + 1, #arg_12_0._skillEffectDescItems do
		gohelper.setActive(arg_12_0._passiveskillitems[iter_12_1].go, false)
	end
end

function var_0_0._getSkillEffectDescItem(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0._skillEffectDescItems[arg_13_1]

	if not var_13_0 then
		var_13_0 = arg_13_0:getUserDataTb_()
		var_13_0.go = gohelper.cloneInPlace(arg_13_0._goeffectdescitem, "descitem" .. arg_13_1)
		var_13_0.desc = gohelper.findChildText(var_13_0.go, "effectdesc")
		var_13_0.title = gohelper.findChildText(var_13_0.go, "titlebg/bg/name")
		var_13_0.fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(var_13_0.desc.gameObject, FixTmpBreakLine)
		var_13_0.hyperLinkClick = SkillHelper.addHyperLinkClick(var_13_0.desc, arg_13_0._onHyperLinkClick, arg_13_0)

		table.insert(arg_13_0._skillEffectDescItems, arg_13_1, var_13_0)
	end

	return var_13_0
end

function var_0_0._refreshPassiveSkillScroll(arg_14_0)
	local var_14_0 = gohelper.findChild(arg_14_0._gopassiveskilltip, "mask/root")

	ZProj.UGUIHelper.RebuildLayout(var_14_0.transform)

	arg_14_0._couldScroll = recthelper.getHeight(arg_14_0._passiveskilltipcontent.transform) > recthelper.getHeight(arg_14_0._scrollview.transform)

	gohelper.setActive(arg_14_0._gomask1, arg_14_0._couldScroll and not (gohelper.getRemindFourNumberFloat(arg_14_0._scrollview.verticalNormalizedPosition) <= 0))

	arg_14_0._passiveskilltipmask.enabled = false

	local var_14_1 = gohelper.findChild(arg_14_0._gopassiveskilltip, "mask/root/scrollview/viewport")
	local var_14_2 = gohelper.onceAddComponent(var_14_1, gohelper.Type_VerticalLayoutGroup)
	local var_14_3 = gohelper.onceAddComponent(var_14_1, typeof(UnityEngine.UI.LayoutElement))
	local var_14_4 = recthelper.getHeight(var_14_1.transform)

	var_14_2.enabled = false
	var_14_3.enabled = true
	var_14_3.preferredHeight = var_14_4
end

function var_0_0._setTipPos(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	if not arg_15_1 then
		return
	end

	local var_15_0 = arg_15_3 and arg_15_3[1] or Vector2.New(0.5, 0.5)
	local var_15_1 = arg_15_3 and arg_15_3[2] or Vector2.New(0.5, 0.5)
	local var_15_2 = arg_15_2 and arg_15_2 or Vector2.New(0, 0)

	arg_15_0._gopassiveskilltip.transform.anchorMin = var_15_0
	arg_15_0._gopassiveskilltip.transform.anchorMax = var_15_1

	recthelper.setAnchor(arg_15_1, var_15_2.x, var_15_2.y)
end

var_0_0.LeftWidth = 470
var_0_0.RightWidth = 190
var_0_0.TopHeight = 292
var_0_0.Interval = 10

function var_0_0._onHyperLinkClick(arg_16_0, arg_16_1, arg_16_2)
	CommonBuffTipController.instance:openCommonTipViewWithCustomPosCallback(tonumber(arg_16_1), arg_16_0.setTipPosCallback, arg_16_0)
end

function var_0_0.setTipPosCallback(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0.rectTrPassive = arg_17_0.rectTrPassive or arg_17_0._gopassiveskilltip:GetComponent(gohelper.Type_RectTransform)

	local var_17_0 = GameUtil.getViewSize() / 2
	local var_17_1, var_17_2 = recthelper.uiPosToScreenPos2(arg_17_0.rectTrPassive)
	local var_17_3, var_17_4 = SLFramework.UGUI.RectTrHelper.ScreenPosXYToAnchorPosXY(var_17_1, var_17_2, arg_17_1, CameraMgr.instance:getUICamera(), nil, nil)
	local var_17_5 = var_17_0 + var_17_3 - var_0_0.LeftWidth - var_0_0.Interval
	local var_17_6 = recthelper.getWidth(arg_17_2)
	local var_17_7 = var_17_6 <= var_17_5

	arg_17_2.pivot = CommonBuffTipEnum.Pivot.Right

	local var_17_8 = var_17_3
	local var_17_9 = var_17_4

	if var_17_7 then
		var_17_8 = var_17_8 - var_0_0.LeftWidth - var_0_0.Interval
	else
		var_17_8 = var_17_8 + var_0_0.RightWidth + var_0_0.Interval + var_17_6
	end

	local var_17_10 = var_17_9 + var_0_0.TopHeight

	recthelper.setAnchor(arg_17_2, var_17_8, var_17_10)
end

return var_0_0
