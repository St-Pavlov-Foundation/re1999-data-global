module("modules.logic.seasonver.act166.view.Season166TalentInfoView", package.seeall)

local var_0_0 = class("Season166TalentInfoView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btncloseView = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_closeView")
	arg_1_0._gotalent1 = gohelper.findChild(arg_1_0.viewGO, "talentIcon/#go_talentIcon1")
	arg_1_0._gotalent2 = gohelper.findChild(arg_1_0.viewGO, "talentIcon/#go_talentIcon2")
	arg_1_0._gotalent3 = gohelper.findChild(arg_1_0.viewGO, "talentIcon/#go_talentIcon3")
	arg_1_0._goEquipSlot = gohelper.findChild(arg_1_0.viewGO, "#go_equipslot")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "info/#txt_title")
	arg_1_0._txttitleen = gohelper.findChildText(arg_1_0.viewGO, "info/#txt_titleen")
	arg_1_0._txtbasicSkill = gohelper.findChildText(arg_1_0.viewGO, "info/#txt_basicSkill")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btncloseView:AddClickListener(arg_2_0._btncloseViewOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btncloseView:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseViewOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btncloseOnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._editableInitView(arg_6_0)
	SkillHelper.addHyperLinkClick(arg_6_0._txtbasicSkill, arg_6_0.clcikHyperLink, arg_6_0)
	arg_6_0:initEquipSlot()
end

function var_0_0.initEquipSlot(arg_7_0)
	arg_7_0.talentSlotTab = arg_7_0:getUserDataTb_()

	for iter_7_0 = 1, 3 do
		local var_7_0 = {
			item = gohelper.findChild(arg_7_0._goEquipSlot, iter_7_0)
		}

		var_7_0.light = gohelper.findChild(var_7_0.item, "light")
		var_7_0.imageLight = gohelper.findChildImage(var_7_0.item, "light")
		var_7_0.lineLight = gohelper.findChild(var_7_0.item, "line_light")
		var_7_0.lineDark = gohelper.findChild(var_7_0.item, "line_dark")
		var_7_0.effect1 = gohelper.findChild(var_7_0.item, "light/qi1")
		var_7_0.effect2 = gohelper.findChild(var_7_0.item, "light/qi2")
		var_7_0.effect3 = gohelper.findChild(var_7_0.item, "light/qi3")
		arg_7_0.talentSlotTab[iter_7_0] = var_7_0
	end
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	AudioMgr.instance:trigger(AudioEnum.Season166.play_ui_hero_sign)
	arg_9_0:refreshUI()
end

function var_0_0.refreshUI(arg_10_0)
	arg_10_0.actId = Season166Model.instance:getCurSeasonId()

	if not arg_10_0.actId or arg_10_0.actId == 0 then
		local var_10_0 = Season166Model.instance:getBattleContext()

		arg_10_0.actId = var_10_0 and var_10_0.actId or 0
	end

	arg_10_0.talentParam = Season166Model.instance:getFightTalentParam()
	arg_10_0.talentId = arg_10_0.talentParam.talentId
	arg_10_0.talentLevel = arg_10_0.talentParam.talentLevel
	arg_10_0.talentConfig = lua_activity166_talent.configDict[arg_10_0.actId][arg_10_0.talentId]
	arg_10_0.styleCfgDic = lua_activity166_talent_style.configDict[arg_10_0.talentId]
	arg_10_0.maxSlot = lua_activity166_talent_style.configDict[arg_10_0.talentId][arg_10_0.talentLevel].slot

	arg_10_0:refreshEquip()
	arg_10_0:refreshTitle()
	arg_10_0:initBasicSkill()
	arg_10_0:refreshSkill()
end

function var_0_0.refreshEquip(arg_11_0)
	local var_11_0 = lua_activity166_talent.configDict[arg_11_0.actId][arg_11_0.talentId]

	for iter_11_0 = 1, 3 do
		gohelper.setActive(arg_11_0["_gotalent" .. iter_11_0], iter_11_0 == var_11_0.sortIndex)
	end

	local var_11_1 = arg_11_0.maxSlot
	local var_11_2 = #arg_11_0.talentParam.talentSkillIds

	for iter_11_1, iter_11_2 in ipairs(arg_11_0.talentSlotTab) do
		gohelper.setActive(iter_11_2.item, iter_11_1 <= var_11_1)
		gohelper.setActive(iter_11_2.light, iter_11_1 <= var_11_2)
		gohelper.setActive(iter_11_2.lineLight, iter_11_1 > 1 and iter_11_1 <= var_11_2)
		gohelper.setActive(iter_11_2.lineDark, iter_11_1 > 1 and var_11_2 < iter_11_1)
		UISpriteSetMgr.instance:setSeason166Sprite(iter_11_2.imageLight, "season166_talentree_pointl" .. tostring(var_11_0.sortIndex))

		for iter_11_3 = 1, 3 do
			gohelper.setActive(iter_11_2["effect" .. iter_11_3], var_11_0.sortIndex == iter_11_3)
		end
	end
end

function var_0_0.refreshTitle(arg_12_0)
	arg_12_0._txttitle.text = arg_12_0.talentConfig.name
	arg_12_0._txttitleen.text = arg_12_0.talentConfig.nameEn

	local var_12_0 = arg_12_0.talentConfig.baseSkillIds

	if string.nilorempty(var_12_0) then
		var_12_0 = arg_12_0.talentConfig.baseSkillIds2
	end

	local var_12_1 = string.splitToNumber(var_12_0, "#")
	local var_12_2 = lua_skill_effect.configDict[var_12_1[1]]
	local var_12_3 = FightConfig.instance:getSkillEffectDesc("", var_12_2)

	arg_12_0._txtbasicSkill.text = SkillHelper.buildDesc(var_12_3)
end

function var_0_0.initBasicSkill(arg_13_0)
	arg_13_0.selectSkillList = {}

	for iter_13_0 = 1, 3 do
		local var_13_0 = arg_13_0:getUserDataTb_()

		var_13_0.go = gohelper.findChild(arg_13_0.viewGO, "info/basicSkill/" .. iter_13_0)
		var_13_0.goUnequip = gohelper.findChild(var_13_0.go, "unequip")
		var_13_0.goWhiteBg = gohelper.findChild(var_13_0.go, "unequip/bg2")
		var_13_0.goEquiped = gohelper.findChild(var_13_0.go, "equiped")
		var_13_0.animEquip = var_13_0.goEquiped:GetComponent(gohelper.Type_Animation)
		var_13_0.txtDesc = gohelper.findChildText(var_13_0.go, "equiped/txt_desc")

		SkillHelper.addHyperLinkClick(var_13_0.txtDesc, arg_13_0.clcikHyperLink, arg_13_0)

		local var_13_1 = gohelper.findChildImage(var_13_0.go, "equiped/txt_desc/slot")

		UISpriteSetMgr.instance:setSeason166Sprite(var_13_1, "season166_talentree_pointl" .. tostring(arg_13_0.talentConfig.sortIndex))

		local var_13_2 = gohelper.findChild(var_13_0.go, "equiped/txt_desc/slot/" .. arg_13_0.talentConfig.sortIndex)

		gohelper.setActive(var_13_2, true)

		var_13_0.goLock = gohelper.findChild(var_13_0.go, "locked")

		local var_13_3 = gohelper.findChildText(var_13_0.go, "locked/txt_desc")
		local var_13_4 = arg_13_0.styleCfgDic[iter_13_0].needStar
		local var_13_5 = Season166Config.instance:getBaseSpotByTalentId(arg_13_0.actId, arg_13_0.talentId)

		var_13_3.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("season166_talent_selectlock"), var_13_4, var_13_5.name)
		var_13_0.anim = var_13_0.go:GetComponent(gohelper.Type_Animator)
		arg_13_0.selectSkillList[iter_13_0] = var_13_0
	end
end

function var_0_0.refreshSkill(arg_14_0)
	local var_14_0 = arg_14_0.talentParam.talentSkillIds
	local var_14_1 = #var_14_0 + 1

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.selectSkillList) do
		if iter_14_0 == var_14_1 and var_14_1 <= arg_14_0.maxSlot then
			gohelper.setActive(iter_14_1.goWhiteBg, true)
		else
			gohelper.setActive(iter_14_1.goWhiteBg, false)
		end

		if iter_14_0 > arg_14_0.maxSlot then
			gohelper.setActive(iter_14_1.goUnequip, false)
			gohelper.setActive(iter_14_1.goEquiped, false)
			gohelper.setActive(iter_14_1.goLock, true)
		elseif iter_14_0 > #var_14_0 then
			gohelper.setActive(iter_14_1.goUnequip, true)
			gohelper.setActive(iter_14_1.goEquiped, false)
			gohelper.setActive(iter_14_1.goLock, false)
		else
			local var_14_2 = lua_skill_effect.configDict[var_14_0[iter_14_0]]
			local var_14_3 = FightConfig.instance:getSkillEffectDesc("", var_14_2)

			iter_14_1.txtDesc.text = SkillHelper.buildDesc(var_14_3)

			gohelper.setActive(iter_14_1.goUnequip, false)
			gohelper.setActive(iter_14_1.goEquiped, true)
			gohelper.setActive(iter_14_1.goLock, false)
		end
	end
end

function var_0_0.clcikHyperLink(arg_15_0, arg_15_1, arg_15_2)
	CommonBuffTipController.instance:openCommonTipViewWithCustomPos(arg_15_1, Vector2(-742, 178))
end

function var_0_0.onClose(arg_16_0)
	return
end

function var_0_0.onDestroyView(arg_17_0)
	return
end

return var_0_0
