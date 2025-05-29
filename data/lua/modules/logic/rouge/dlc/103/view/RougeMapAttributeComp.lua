module("modules.logic.rouge.dlc.103.view.RougeMapAttributeComp", package.seeall)

local var_0_0 = class("RougeMapAttributeComp", BaseViewExtended)

function var_0_0.definePrefabUrl(arg_1_0)
	arg_1_0:setPrefabUrl("ui/viewres/rouge/dlc/103/rougedistortruleitem.prefab")
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0._btndistortrule = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "#btn_distortrule")
	arg_2_0._gotips = gohelper.findChild(arg_2_0.viewGO, "#go_tips")
	arg_2_0._scrolloverview = gohelper.findChildScrollRect(arg_2_0.viewGO, "#go_tips/#scroll_overview")
	arg_2_0._txttitle1 = gohelper.findChildText(arg_2_0.viewGO, "#go_tips/#scroll_overview/Viewport/Content/txt_title1")
	arg_2_0._txtdec1 = gohelper.findChildText(arg_2_0.viewGO, "#go_tips/#scroll_overview/Viewport/Content/#txt_dec1")
	arg_2_0._txttitle2 = gohelper.findChildText(arg_2_0.viewGO, "#go_tips/#scroll_overview/Viewport/Content/txt_title2")
	arg_2_0._txtdec2 = gohelper.findChildText(arg_2_0.viewGO, "#go_tips/#scroll_overview/Viewport/Content/#txt_dec2")
	arg_2_0._btnclose = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "#go_tips/#btn_close")

	if arg_2_0._editableInitView then
		arg_2_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0._btndistortrule:AddClickListener(arg_3_0._btndistortruleOnClick, arg_3_0)
	arg_3_0._btnclose:AddClickListener(arg_3_0._btncloseOnClick, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	arg_4_0._btndistortrule:RemoveClickListener()
	arg_4_0._btnclose:RemoveClickListener()
end

function var_0_0._btndistortruleOnClick(arg_5_0)
	arg_5_0._tipAnimatorPlayer:Play("open", function()
		return
	end, arg_5_0)
	arg_5_0:setTipVisible(true)
end

function var_0_0._btncloseOnClick(arg_7_0)
	arg_7_0._tipAnimatorPlayer:Play("close", arg_7_0.closeTips, arg_7_0)
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._monsterRuleItemTab = arg_8_0:getUserDataTb_()

	gohelper.setActive(arg_8_0._txtdec2.gameObject, false)

	arg_8_0._tipAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_8_0._gotips)
	arg_8_0._canvasgroup = gohelper.onceAddComponent(arg_8_0.viewGO, gohelper.Type_CanvasGroup)
	arg_8_0._scrollViewTran = arg_8_0._scrolloverview.transform
	arg_8_0._scrollWidth = recthelper.getWidth(arg_8_0._scrollViewTran)
	arg_8_0._scrollScreenPos = recthelper.uiPosToScreenPos(arg_8_0._scrollViewTran)
	arg_8_0._effectTipViewPosX = recthelper.screenPosToAnchorPos2(arg_8_0._scrollScreenPos, arg_8_0.PARENT_VIEW.viewGO.transform) + arg_8_0._scrollWidth

	SkillHelper.addHyperLinkClick(arg_8_0._txtdec1, arg_8_0.clcikHyperLink, arg_8_0)
	gohelper.fitScreenOffset(arg_8_0._scrollViewTran)
	arg_8_0:initInfo()
	arg_8_0:setTipVisible(false)
	arg_8_0:checkAndSetIconVisible()
	arg_8_0:addEventCb(RougeMapController.instance, RougeMapEvent.onUpdateMapInfo, arg_8_0._onUpdateMapInfo, arg_8_0)
end

function var_0_0._onUpdateMapInfo(arg_9_0)
	arg_9_0:initInfo()
	arg_9_0:checkAndSetIconVisible()
end

function var_0_0.initInfo(arg_10_0)
	arg_10_0._monsterRuleIds = RougeMapModel.instance:getChoiceCollection()
	arg_10_0._monsterRuleNum = arg_10_0._monsterRuleIds and #arg_10_0._monsterRuleIds or 0

	if RougeMapModel.instance:isNormalLayer() then
		local var_10_0 = RougeMapModel.instance:getLayerId()
		local var_10_1 = RougeMapModel.instance:getLayerChoiceInfo(var_10_0)

		arg_10_0._ruleCo = var_10_1 and var_10_1:getMapRuleCo()
	else
		arg_10_0._ruleCo = nil
	end
end

function var_0_0.checkAndSetIconVisible(arg_11_0)
	local var_11_0 = arg_11_0._monsterRuleNum and arg_11_0._monsterRuleNum > 0

	var_11_0 = var_11_0 or arg_11_0._ruleCo ~= nil

	arg_11_0:setIconVisible(var_11_0)
end

function var_0_0.setIconVisible(arg_12_0, arg_12_1)
	arg_12_0._canvasgroup.alpha = arg_12_1 and 1 or 0
	arg_12_0._canvasgroup.interactable = arg_12_1
	arg_12_0._canvasgroup.blocksRaycasts = arg_12_1
end

function var_0_0.setTipVisible(arg_13_0, arg_13_1)
	gohelper.setActive(arg_13_0._gotips, arg_13_1)

	if not arg_13_1 then
		return
	end

	arg_13_0:refreshMapRule()
	arg_13_0:refreshMonsterRules()
end

function var_0_0.closeTips(arg_14_0)
	arg_14_0:setTipVisible(false)
end

function var_0_0.refreshMapRule(arg_15_0)
	gohelper.setActive(arg_15_0._txttitle1, false)
	gohelper.setActive(arg_15_0._txtdec1, false)

	if not arg_15_0._ruleCo then
		return
	end

	local var_15_0 = arg_15_0._ruleCo and arg_15_0._ruleCo.desc or ""

	gohelper.setActive(arg_15_0._txttitle1, true)
	gohelper.setActive(arg_15_0._txtdec1, true)

	arg_15_0._txtdec1.text = SkillHelper.buildDesc(var_15_0)
end

function var_0_0.clcikHyperLink(arg_16_0, arg_16_1, arg_16_2)
	CommonBuffTipController.instance:openCommonTipViewWithCustomPosCallback(arg_16_1, function(arg_17_0, arg_17_1, arg_17_2)
		arg_17_2.pivot = GameUtil.checkClickPositionInRight(arg_16_2) and CommonBuffTipEnum.Pivot.Right or CommonBuffTipEnum.Pivot.Left

		local var_17_0, var_17_1 = recthelper.screenPosToAnchorPos2(arg_16_2, arg_17_1)

		recthelper.setAnchor(arg_17_2, arg_16_0._effectTipViewPosX, var_17_1 + CommonBuffTipEnum.DefaultInterval)
	end)
end

function var_0_0.refreshMonsterRules(arg_18_0)
	local var_18_0 = {}

	for iter_18_0, iter_18_1 in ipairs(arg_18_0._monsterRuleIds or {}) do
		local var_18_1 = arg_18_0:_getOrCreateMonsterRuleItem(iter_18_0)
		local var_18_2 = RougeDLCConfig103.instance:getMonsterRuleConfig(iter_18_1)
		local var_18_3 = var_18_2 and var_18_2.desc

		var_18_1.txtdec.text = SkillHelper.buildDesc(var_18_3)

		gohelper.setActive(var_18_1.viewGO, true)

		var_18_0[var_18_1] = true
	end

	for iter_18_2, iter_18_3 in pairs(arg_18_0._monsterRuleItemTab) do
		if not var_18_0[iter_18_3] then
			gohelper.setActive(iter_18_3.viewGO, false)
		end
	end

	gohelper.setActive(arg_18_0._txttitle2.gameObject, arg_18_0._monsterRuleNum > 0)
end

function var_0_0._getOrCreateMonsterRuleItem(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0._monsterRuleItemTab[arg_19_1]

	if not var_19_0 then
		var_19_0 = arg_19_0:getUserDataTb_()
		var_19_0.viewGO = gohelper.cloneInPlace(arg_19_0._txtdec2.gameObject, "debuff_" .. arg_19_1)
		var_19_0.txtdec = gohelper.onceAddComponent(var_19_0.viewGO, gohelper.Type_TextMesh)

		SkillHelper.addHyperLinkClick(var_19_0.txtdec, arg_19_0.clcikHyperLink, arg_19_0)

		arg_19_0._monsterRuleItemTab[arg_19_1] = var_19_0
	end

	return var_19_0
end

function var_0_0.onDestroy(arg_20_0)
	return
end

return var_0_0
