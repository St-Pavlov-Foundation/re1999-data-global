module("modules.logic.seasonver.act123.view1_8.Season123_1_8FightRuleTipView", package.seeall)

local var_0_0 = class("Season123_1_8FightRuleTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnClose1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_close1")
	arg_1_0._btnClose2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_close2")
	arg_1_0._goLabel = gohelper.findChild(arg_1_0.viewGO, "root/top/#btn_label")
	arg_1_0._goCard = gohelper.findChild(arg_1_0.viewGO, "root/top/#btn_card")
	arg_1_0._simageleftbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/bg/#simage_leftbg")
	arg_1_0._simagerightbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/bg/#simage_rightbg")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnClose1:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnClose2:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnClose1:RemoveClickListener()
	arg_3_0._btnClose2:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0.labelTab = arg_4_0:createTab(arg_4_0._goLabel, Activity123Enum.RuleTab.Rule)
	arg_4_0.cardTab = arg_4_0:createTab(arg_4_0._goCard, Activity123Enum.RuleTab.Card)

	arg_4_0._simageleftbg:LoadImage(ResUrl.getSeasonIcon("img_bg_light2.png"))
	arg_4_0._simagerightbg:LoadImage(ResUrl.getSeasonIcon("img_bg_light1.png"))
end

function var_0_0._btncloseOnClick(arg_5_0)
	arg_5_0:_closeView()
end

function var_0_0._closeView(arg_6_0)
	arg_6_0:closeThis()
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0._ruleList = SeasonFightRuleView.getRuleList()
	arg_7_0._cardList = Season123Model.instance:getFightCardDataList()

	if #arg_7_0._ruleList > 0 then
		arg_7_0:switchTab(Activity123Enum.RuleTab.Rule)
	else
		arg_7_0:switchTab(Activity123Enum.RuleTab.Card)
	end

	NavigateMgr.instance:addEscape(arg_7_0.viewName, arg_7_0._btncloseOnClick, arg_7_0)
end

function var_0_0.createTab(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0:getUserDataTb_()

	var_8_0.go = arg_8_1
	var_8_0.tabType = arg_8_2
	var_8_0.goUnSelect = gohelper.findChild(arg_8_1, "unselect")
	var_8_0.goSelect = gohelper.findChild(arg_8_1, "selected")
	var_8_0.btn = gohelper.findButtonWithAudio(arg_8_1)

	var_8_0.btn:AddClickListener(arg_8_0.onClickTab, arg_8_0, var_8_0)

	return var_8_0
end

function var_0_0.updateTab(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if arg_9_2 then
		local var_9_0 = arg_9_0.tabType == arg_9_1.tabType

		gohelper.setActive(arg_9_1.go, true)
		gohelper.setActive(arg_9_1.goSelect, var_9_0)
		gohelper.setActive(arg_9_1.goUnSelect, not var_9_0)
	else
		gohelper.setActive(arg_9_1.go, false)
	end
end

function var_0_0.destroyTab(arg_10_0, arg_10_1)
	if arg_10_1 then
		arg_10_1.btn:RemoveClickListener()
	end
end

function var_0_0.onClickTab(arg_11_0, arg_11_1)
	if not arg_11_1 then
		return
	end

	arg_11_0:switchTab(arg_11_1.tabType)
end

function var_0_0.switchTab(arg_12_0, arg_12_1)
	if arg_12_0.tabType == arg_12_1 then
		return
	end

	arg_12_0.tabType = arg_12_1

	local var_12_0 = arg_12_0:getTabActive(arg_12_0.labelTab.tabType)
	local var_12_1 = arg_12_0:getTabActive(arg_12_0.cardTab.tabType)
	local var_12_2 = 0

	if var_12_0 then
		var_12_2 = var_12_2 + 1
	end

	if var_12_1 then
		var_12_2 = var_12_2 + 1
	end

	arg_12_0:updateTab(arg_12_0.labelTab, var_12_0, var_12_2)
	arg_12_0:updateTab(arg_12_0.cardTab, var_12_1, var_12_2)
	arg_12_0.viewContainer:switchTab(arg_12_1)
end

function var_0_0.getTabActive(arg_13_0, arg_13_1)
	if arg_13_1 == Activity123Enum.RuleTab.Card then
		return arg_13_0._cardList and #arg_13_0._cardList > 0
	end

	return arg_13_0._ruleList and #arg_13_0._ruleList > 0
end

function var_0_0.onClose(arg_14_0)
	return
end

function var_0_0.onDestroyView(arg_15_0)
	arg_15_0:destroyTab(arg_15_0.labelTab)
	arg_15_0:destroyTab(arg_15_0.cardTab)
	arg_15_0._simageleftbg:UnLoadImage()
	arg_15_0._simagerightbg:UnLoadImage()
end

return var_0_0
