module("modules.logic.sp01.assassin2.outside.view.AssassinStatsView", package.seeall)

local var_0_0 = class("AssassinStatsView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnInfo = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Info", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	arg_1_0._goPanel = gohelper.findChild(arg_1_0.viewGO, "StatsPanel")
	arg_1_0._goArrow1 = gohelper.findChild(arg_1_0.viewGO, "StatsPanel/StatsTitle/#go_Arrow")
	arg_1_0._goattrLayout = gohelper.findChild(arg_1_0.viewGO, "StatsPanel/#go_attrLayout")
	arg_1_0._goattrItem = gohelper.findChild(arg_1_0.viewGO, "StatsPanel/#go_attrLayout/#go_attrItem")
	arg_1_0._btnattribute = gohelper.findChildClickWithAudio(arg_1_0.viewGO, "StatsPanel/#btn_attribute", AudioEnum.UI.Play_ui_role_description)
	arg_1_0._gopassiveskills = gohelper.findChild(arg_1_0.viewGO, "StatsPanel/passiveskill/bg/#go_passiveskills")
	arg_1_0._txtpassivename = gohelper.findChildText(arg_1_0.viewGO, "StatsPanel/passiveskill/bg/passiveskillimage/#txt_passivename")
	arg_1_0._btnpassiveskill = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "StatsPanel/passiveskill/#btn_passiveskill", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	arg_1_0._goArrow2 = gohelper.findChild(arg_1_0.viewGO, "StatsPanel/passiveskill/#go_Arrow")
	arg_1_0._goskill = gohelper.findChild(arg_1_0.viewGO, "StatsPanel/#go_skill")
	arg_1_0._goArrow3 = gohelper.findChild(arg_1_0.viewGO, "StatsPanel/#go_skill/#go_Arrow")
	arg_1_0._goskilltipview = gohelper.findChild(arg_1_0.viewGO, "#go_skilltipview")
	arg_1_0._gocharactertipview = gohelper.findChild(arg_1_0.viewGO, "#go_charactertipview")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnInfo:AddClickListener(arg_2_0._btnInfoOnClick, arg_2_0)
	arg_2_0._btnpassiveskill:AddClickListener(arg_2_0._btnpassiveskillOnClick, arg_2_0)
	arg_2_0._btnattribute:AddClickListener(arg_2_0._btnattributeOnClick, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_2_0._onOpenView, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_2_0._onCloseView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnInfo:RemoveClickListener()
	arg_3_0._btnpassiveskill:RemoveClickListener()
	arg_3_0._btnattribute:RemoveClickListener()
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_3_0._onOpenView, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_3_0._onCloseView, arg_3_0)
end

function var_0_0._btnInfoOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnpassiveskillOnClick(arg_5_0)
	local var_5_0 = {}

	var_5_0.tag = "passiveskill"

	local var_5_1 = AssassinHeroModel.instance:getHeroMo(arg_5_0.assassinHeroId)

	var_5_0.heroid = var_5_1.heroId

	local var_5_2 = transformhelper.getLocalPos(arg_5_0._transPanel)

	var_5_0.anchorParams = {
		Vector2.New(0.5, 0.5),
		Vector2.New(0.5, 0.5)
	}
	var_5_0.tipPos = Vector2.New(var_5_2 + 795, 40)
	var_5_0.buffTipsX = -863
	var_5_0.heroMo = var_5_1
	var_5_0.showAssassinBg = true
	arg_5_0._showPassiveSkill = true

	CharacterController.instance:openCharacterTipView(var_5_0)
end

function var_0_0._btnattributeOnClick(arg_6_0)
	local var_6_0 = {}

	var_6_0.tag = "attribute"

	local var_6_1 = AssassinHeroModel.instance:getHeroMo(arg_6_0.assassinHeroId)

	var_6_0.heroMo = var_6_1
	var_6_0.heroid = var_6_1.heroId
	var_6_0.equips = var_6_1.defaultEquipUid ~= "0" and {
		var_6_1.defaultEquipUid
	} or nil
	var_6_0.trialEquipMo = var_6_1.trialEquipMo

	local var_6_2 = transformhelper.getLocalPos(arg_6_0._transPanel)

	var_6_0.anchorParams = {
		Vector2.New(0.5, 0.5),
		Vector2.New(0.5, 0.5)
	}
	var_6_0.tipPos = Vector2.New(var_6_2 + 636, 35)
	var_6_0.showAssassinBg = true
	var_6_0.hideAttrDetail = true
	arg_6_0._showAttr = true

	CharacterController.instance:openCharacterTipView(var_6_0)
end

function var_0_0._onOpenView(arg_7_0, arg_7_1)
	arg_7_0:refreshArrow()
end

function var_0_0._onCloseView(arg_8_0, arg_8_1)
	if arg_8_1 == ViewName.CharacterTipView then
		arg_8_0._showPassiveSkill = false
		arg_8_0._showAttr = false
	end

	arg_8_0:refreshArrow()
end

function var_0_0._editableInitView(arg_9_0)
	arg_9_0._transPanel = arg_9_0._goPanel.transform
	arg_9_0._showPassiveSkill = false
	arg_9_0._showAttr = false
	arg_9_0._passiveskillitems = {}

	for iter_9_0 = 1, 3 do
		local var_9_0 = arg_9_0:getUserDataTb_()

		var_9_0.go = gohelper.findChild(arg_9_0._gopassiveskills, "passiveskill" .. tostring(iter_9_0))
		var_9_0.on = gohelper.findChild(var_9_0.go, "on")
		var_9_0.off = gohelper.findChild(var_9_0.go, "off")
		arg_9_0._passiveskillitems[iter_9_0] = var_9_0
	end

	arg_9_0._skillContainer = MonoHelper.addNoUpdateLuaComOnceToGo(arg_9_0._goskill, CharacterSkillContainer, {
		skillTipY = 17,
		adjustBuffTip = true,
		skillTipX = 409,
		showAssassinBg = true
	})
end

function var_0_0.onUpdateParam(arg_10_0)
	arg_10_0.assassinHeroId = arg_10_0.viewParam.assassinHeroId

	arg_10_0:setAttribute()
	arg_10_0:setHeroSkill()
end

function var_0_0.onOpen(arg_11_0)
	arg_11_0:onUpdateParam()
	arg_11_0:refreshArrow()
end

function var_0_0.onOpenFinish(arg_12_0)
	PostProcessingMgr.instance:setIgnoreUIBlur(true)
end

function var_0_0.setAttribute(arg_13_0)
	local var_13_0 = AssassinHeroModel.instance:getAssassinHeroAttributeList(arg_13_0.assassinHeroId)

	gohelper.CreateObjList(arg_13_0, arg_13_0._onCreateHeroAttributeItem, var_13_0, arg_13_0._goattrLayout, arg_13_0._goattrItem)
end

function var_0_0._onCreateHeroAttributeItem(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = gohelper.findChildImage(arg_14_1, "icon")
	local var_14_1 = gohelper.findChildText(arg_14_1, "#txt_attrName")
	local var_14_2 = gohelper.findChildText(arg_14_1, "#txt_attrValue")
	local var_14_3 = arg_14_2.id
	local var_14_4 = HeroConfig.instance:getHeroAttributeCO(var_14_3)

	CharacterController.instance:SetAttriIcon(var_14_0, var_14_3)

	var_14_1.text = var_14_4.name
	var_14_2.text = arg_14_2.value
end

function var_0_0.setHeroSkill(arg_15_0)
	local var_15_0 = AssassinHeroModel.instance:getHeroMo(arg_15_0.assassinHeroId)
	local var_15_1 = var_15_0:getpassiveskillsCO()
	local var_15_2 = var_15_1[1].skillPassive
	local var_15_3 = lua_skill.configDict[var_15_2]

	if not var_15_3 then
		logError("AssassinHeroView:refreshHeroSkill error, no skillCfg, skillId: " .. tostring(var_15_2))

		return
	end

	arg_15_0._txtpassivename.text = var_15_3.name

	for iter_15_0 = 1, #var_15_1 do
		local var_15_4 = CharacterModel.instance:isPassiveUnlockByHeroMo(var_15_0, iter_15_0)

		gohelper.setActive(arg_15_0._passiveskillitems[iter_15_0].on, var_15_4)
		gohelper.setActive(arg_15_0._passiveskillitems[iter_15_0].off, not var_15_4)
		gohelper.setActive(arg_15_0._passiveskillitems[iter_15_0].go, true)
	end

	for iter_15_1 = #var_15_1 + 1, #arg_15_0._passiveskillitems do
		gohelper.setActive(arg_15_0._passiveskillitems[iter_15_1].go, false)
	end

	arg_15_0._skillContainer:onUpdateMO(var_15_0.heroId, nil, var_15_0)
end

function var_0_0.refreshArrow(arg_16_0)
	local var_16_0 = ViewMgr.instance:isOpen(ViewName.CharacterTipView)
	local var_16_1 = ViewMgr.instance:isOpen(ViewName.SkillTipView)

	gohelper.setActive(arg_16_0._goArrow1, var_16_0 and arg_16_0._showAttr)
	gohelper.setActive(arg_16_0._goArrow2, var_16_0 and arg_16_0._showPassiveSkill)
	gohelper.setActive(arg_16_0._goArrow3, var_16_1)
end

function var_0_0.onClose(arg_17_0)
	PostProcessingMgr.instance:setIgnoreUIBlur(false)
end

function var_0_0.onDestroyView(arg_18_0)
	return
end

return var_0_0
