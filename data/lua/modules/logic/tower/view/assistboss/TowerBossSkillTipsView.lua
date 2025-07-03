module("modules.logic.tower.view.assistboss.TowerBossSkillTipsView", package.seeall)

local var_0_0 = class("TowerBossSkillTipsView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtpassivename = gohelper.findChildText(arg_1_0.viewGO, "#go_passiveskilltip/root/content/skills/name/bg/#txt_passivename")
	arg_1_0._gopassiveskilltip = gohelper.findChild(arg_1_0.viewGO, "#go_passiveskilltip")
	arg_1_0._goeffectdesc = gohelper.findChild(arg_1_0.viewGO, "#go_passiveskilltip/root/content/skills/#go_effectContent/#go_effectdesc")
	arg_1_0._goeffectdescitem = gohelper.findChild(arg_1_0.viewGO, "#go_passiveskilltip/root/content/skills/#go_effectContent/#go_effectdesc/#go_effectdescitem")
	arg_1_0._btnclosepassivetip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_passiveskilltip/#btn_closepassivetip")
	arg_1_0._rectbg = gohelper.findChild(arg_1_0.viewGO, "#go_passiveskilltip/root/bg"):GetComponent(gohelper.Type_RectTransform)
	arg_1_0._canvasGroupTeachSkills = gohelper.findChild(arg_1_0.viewGO, "#go_passiveskilltip/root/content/teachSkills"):GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_1_0._goTeachSkills = gohelper.findChild(arg_1_0.viewGO, "#go_passiveskilltip/root/content/teachSkills/#go_teachSkills")
	arg_1_0._txtTeachSkillTitle = gohelper.findChildText(arg_1_0.viewGO, "#go_passiveskilltip/root/content/teachSkills/#txt_teachSkillTitle")
	arg_1_0._txtTeachDesc = gohelper.findChildText(arg_1_0.viewGO, "#go_passiveskilltip/root/content/teachSkills/#go_teachSkills/#txt_teachDesc")
	arg_1_0._passiveskillitems = {}

	for iter_1_0 = 1, 3 do
		local var_1_0 = arg_1_0:getUserDataTb_()

		var_1_0.go = gohelper.findChild(arg_1_0._gopassiveskilltip, "root/content/skills/#go_effectContent/talentstar" .. tostring(iter_1_0))
		var_1_0.desc = gohelper.findChildTextMesh(var_1_0.go, "desctxt")
		var_1_0.hyperLinkClick = SkillHelper.addHyperLinkClick(var_1_0.desc, arg_1_0._onHyperLinkClick, arg_1_0)
		var_1_0.fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(var_1_0.desc.gameObject, FixTmpBreakLine)
		var_1_0.on = gohelper.findChild(var_1_0.go, "#go_passiveskills/passiveskill/on")
		var_1_0.unlocktxt = gohelper.findChildText(var_1_0.go, "#go_passiveskills/passiveskill/unlocktxt")
		var_1_0.canvasgroup = gohelper.onceAddComponent(var_1_0.go, typeof(UnityEngine.CanvasGroup))
		var_1_0.connectline = gohelper.findChild(var_1_0.go, "line")
		arg_1_0._passiveskillitems[iter_1_0] = var_1_0
	end

	arg_1_0._skillEffectDescItems = arg_1_0:getUserDataTb_()

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0._btnclosepassivetip, arg_2_0._btnclosepassivetipOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeClickCb(arg_3_0._btnclosepassivetip)
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0.teachSkillTab = arg_4_0:getUserDataTb_()
end

function var_0_0._onHyperLinkClick(arg_5_0, arg_5_1, arg_5_2)
	CommonBuffTipController.instance:openCommonTipViewWithCustomPosCallback(tonumber(arg_5_1), arg_5_0.setTipPosCallback, arg_5_0)
end

var_0_0.LeftWidth = 910
var_0_0.RightWidth = 390
var_0_0.TopHeightOffset = 25
var_0_0.Interval = 10

function var_0_0.setTipPosCallback(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.rectTrPassive = arg_6_0.rectTrPassive or arg_6_0._gopassiveskilltip:GetComponent(gohelper.Type_RectTransform)

	local var_6_0 = GameUtil.getViewSize() / 2
	local var_6_1, var_6_2 = recthelper.uiPosToScreenPos2(arg_6_0.rectTrPassive)
	local var_6_3, var_6_4 = SLFramework.UGUI.RectTrHelper.ScreenPosXYToAnchorPosXY(var_6_1, var_6_2, arg_6_1, CameraMgr.instance:getUICamera(), nil, nil)
	local var_6_5 = var_6_0 + var_6_3 - var_0_0.LeftWidth - var_0_0.Interval
	local var_6_6 = recthelper.getWidth(arg_6_2)
	local var_6_7 = var_6_6 <= var_6_5

	arg_6_2.pivot = CommonBuffTipEnum.Pivot.Right

	local var_6_8 = var_6_3
	local var_6_9 = var_6_4

	if var_6_7 then
		var_6_8 = var_6_8 - var_0_0.LeftWidth - var_0_0.Interval
	else
		var_6_8 = var_6_8 + var_0_0.RightWidth + var_0_0.Interval + var_6_6
	end

	local var_6_10 = var_6_9 + recthelper.getHeight(arg_6_0._rectbg) / 2 - var_0_0.TopHeightOffset

	recthelper.setAnchor(arg_6_2, var_6_8, var_6_10)
end

function var_0_0._btnclosepassivetipOnClick(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	arg_7_0:closeThis()
end

function var_0_0.onUpdateParam(arg_8_0)
	arg_8_0:refreshParam()
	arg_8_0:refreshView()
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0:refreshParam()
	arg_9_0:refreshView()
end

function var_0_0.refreshParam(arg_10_0)
	arg_10_0.bossId = arg_10_0.viewParam.bossId
	arg_10_0.bossMo = TowerAssistBossModel.instance:getById(arg_10_0.bossId)
	arg_10_0.config = TowerConfig.instance:getAssistBossConfig(arg_10_0.bossId)
end

function var_0_0.refreshView(arg_11_0)
	arg_11_0:refreshPassiveSkill()
	arg_11_0:refreshTeachSkill()
end

function var_0_0.refreshPassiveSkill(arg_12_0)
	local var_12_0 = TowerConfig.instance:getPassiveSKills(arg_12_0.bossId)

	arg_12_0._txtpassivename.text = arg_12_0.config.passiveSkillName

	local var_12_1 = {}

	for iter_12_0 = 1, #var_12_0 do
		local var_12_2 = var_12_0[iter_12_0][1]
		local var_12_3 = lua_skill.configDict[var_12_2]

		var_12_1[iter_12_0] = FightConfig.instance:getSkillEffectDesc(arg_12_0.config.name, var_12_3)
	end

	local var_12_4 = HeroSkillModel.instance:getSkillEffectTagIdsFormDescTabRecursion(var_12_1)
	local var_12_5 = {}
	local var_12_6 = {}
	local var_12_7 = arg_12_0.bossMo and arg_12_0.bossMo.trialLevel > 0 and arg_12_0.bossMo.trialLevel or arg_12_0.bossMo and arg_12_0.bossMo.level or 0

	for iter_12_1, iter_12_2 in ipairs(arg_12_0._passiveskillitems) do
		local var_12_8 = var_12_0[iter_12_1] and var_12_0[iter_12_1][1]

		if var_12_8 then
			gohelper.setActive(iter_12_2.go, true)

			local var_12_9 = TowerConfig.instance:isSkillActive(arg_12_0.bossId, var_12_8, var_12_7)
			local var_12_10 = lua_skill.configDict[var_12_8]

			for iter_12_3, iter_12_4 in ipairs(var_12_4[iter_12_1]) do
				local var_12_11 = SkillConfig.instance:getSkillEffectDescCo(iter_12_4)
				local var_12_12 = var_12_11.name

				if HeroSkillModel.instance:canShowSkillTag(var_12_12) and not var_12_6[var_12_12] then
					var_12_6[var_12_12] = true

					if var_12_11.isSpecialCharacter == 1 then
						local var_12_13 = var_12_11.desc
						local var_12_14 = SkillHelper.buildDesc(var_12_13)

						table.insert(var_12_5, {
							desc = var_12_14,
							title = var_12_11.name
						})
					end
				end
			end

			local var_12_15 = SkillHelper.buildDesc(var_12_1[iter_12_1])

			if not var_12_9 then
				local var_12_16 = TowerConfig.instance:getPassiveSkillActiveLev(arg_12_0.bossId, var_12_8)

				iter_12_2.unlocktxt.text = formatLuaLang("towerboss_skill_get", var_12_16)
			else
				iter_12_2.unlocktxt.text = formatLuaLang("towerboss_skill_order", GameUtil.getRomanNums(iter_12_1))
			end

			iter_12_2.canvasgroup.alpha = var_12_9 and 1 or 0.5

			gohelper.setActive(iter_12_2.on, var_12_9)

			iter_12_2.desc.text = var_12_15

			iter_12_2.fixTmpBreakLine:refreshTmpContent(iter_12_2.desc)
			gohelper.setActive(iter_12_2.go, true)
			gohelper.setActive(iter_12_2.connectline, iter_12_1 ~= #var_12_0)
		else
			gohelper.setActive(iter_12_2.go, false)
		end
	end

	arg_12_0:_showSkillEffectDesc(var_12_5)
end

function var_0_0._showSkillEffectDesc(arg_13_0, arg_13_1)
	gohelper.setActive(arg_13_0._goeffectdesc, arg_13_1 and #arg_13_1 > 0)

	for iter_13_0 = 1, #arg_13_1 do
		local var_13_0 = arg_13_1[iter_13_0]
		local var_13_1 = arg_13_0:_getSkillEffectDescItem(iter_13_0)

		var_13_1.desc.text = var_13_0.desc
		var_13_1.title.text = SkillHelper.removeRichTag(var_13_0.title)

		var_13_1.fixTmpBreakLine:refreshTmpContent(var_13_1.desc)
		gohelper.setActive(var_13_1.go, true)
	end

	for iter_13_1 = #arg_13_1 + 1, #arg_13_0._skillEffectDescItems do
		gohelper.setActive(arg_13_0._passiveskillitems[iter_13_1].go, false)
	end
end

function var_0_0._getSkillEffectDescItem(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0._skillEffectDescItems[arg_14_1]

	if not var_14_0 then
		var_14_0 = arg_14_0:getUserDataTb_()
		var_14_0.go = gohelper.cloneInPlace(arg_14_0._goeffectdescitem, "descitem" .. arg_14_1)
		var_14_0.desc = gohelper.findChildText(var_14_0.go, "effectdesc")
		var_14_0.title = gohelper.findChildText(var_14_0.go, "titlebg/bg/name")
		var_14_0.fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(var_14_0.desc.gameObject, FixTmpBreakLine)
		var_14_0.hyperLinkClick = SkillHelper.addHyperLinkClick(var_14_0.desc, arg_14_0._onHyperLinkClick, arg_14_0)

		table.insert(arg_14_0._skillEffectDescItems, arg_14_1, var_14_0)
	end

	return var_14_0
end

function var_0_0.refreshTeachSkill(arg_15_0)
	local var_15_0 = TowerBossTeachModel.instance:isAllEpisodeFinish(arg_15_0.bossId)

	arg_15_0._canvasGroupTeachSkills.alpha = var_15_0 and 1 or 0.5
	arg_15_0._txtTeachSkillTitle.text = var_15_0 and formatLuaLang("towerboss_skill_order", GameUtil.getRomanNums(4)) or luaLang("towerboss_teachskill_unlock")

	local var_15_1 = string.splitToNumber(arg_15_0.config.teachSkills, "#")

	gohelper.CreateObjList(arg_15_0, arg_15_0.showTeachSkill, var_15_1, arg_15_0._goTeachSkills, arg_15_0._txtTeachDesc.gameObject)
end

function var_0_0.showTeachSkill(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = lua_skill.configDict[arg_16_2]
	local var_16_1 = FightConfig.instance:getSkillEffectDesc(arg_16_0.config.name, var_16_0)
	local var_16_2 = arg_16_1:GetComponent(gohelper.Type_TextMesh)

	var_16_2.text = SkillHelper.buildDesc(var_16_1)

	if not arg_16_0.teachSkillTab[arg_16_3] then
		arg_16_0.teachSkillTab[arg_16_3] = {}
		arg_16_0.teachSkillTab[arg_16_3].teachHyperLinkClick = SkillHelper.addHyperLinkClick(var_16_2, arg_16_0._onHyperLinkClick, arg_16_0)
		arg_16_0.teachSkillTab[arg_16_3].teachfixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(arg_16_1, FixTmpBreakLine)
	end

	arg_16_0.teachSkillTab[arg_16_3].teachfixTmpBreakLine:refreshTmpContent(var_16_2)
end

function var_0_0.onClose(arg_17_0)
	return
end

function var_0_0.onDestroyView(arg_18_0)
	return
end

return var_0_0
