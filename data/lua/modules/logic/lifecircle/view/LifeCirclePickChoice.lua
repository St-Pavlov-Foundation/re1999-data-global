module("modules.logic.lifecircle.view.LifeCirclePickChoice", package.seeall)

local var_0_0 = class("LifeCirclePickChoice", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageListBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_ListBG")
	arg_1_0._btnconfirm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_confirm")
	arg_1_0._btncancel = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_cancel")
	arg_1_0._scrollrule = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_rule")
	arg_1_0._gostoreItem = gohelper.findChild(arg_1_0.viewGO, "#scroll_rule/Viewport/#go_storeItem")
	arg_1_0._gonogain = gohelper.findChild(arg_1_0.viewGO, "#scroll_rule/Viewport/#go_storeItem/#go_nogain")
	arg_1_0._goown = gohelper.findChild(arg_1_0.viewGO, "#scroll_rule/Viewport/#go_storeItem/#go_own")
	arg_1_0._scrollrule_simple = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_rule_simple")
	arg_1_0._gostoreItem_simple = gohelper.findChild(arg_1_0.viewGO, "#scroll_rule_simple/Viewport/#go_storeItem_simple")
	arg_1_0._gosimple = gohelper.findChild(arg_1_0.viewGO, "#scroll_rule_simple/Viewport/#go_storeItem_simple/#go_simple")
	arg_1_0._goLifeCirclePickChoiceItem = gohelper.findChild(arg_1_0.viewGO, "#go_LifeCirclePickChoiceItem")
	arg_1_0._goexskill = gohelper.findChild(arg_1_0.viewGO, "#go_LifeCirclePickChoiceItem/role/#go_exskill")
	arg_1_0._imageexskill = gohelper.findChildImage(arg_1_0.viewGO, "#go_LifeCirclePickChoiceItem/role/#go_exskill/#image_exskill")
	arg_1_0._goclick = gohelper.findChild(arg_1_0.viewGO, "#go_LifeCirclePickChoiceItem/select/#go_click")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnconfirm:AddClickListener(arg_2_0._btnconfirmOnClick, arg_2_0)
	arg_2_0._btncancel:AddClickListener(arg_2_0._btncancelOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnconfirm:RemoveClickListener()
	arg_3_0._btncancel:RemoveClickListener()
end

local var_0_1 = table.insert

var_0_0.Style = {
	Title = 1,
	None = 0
}

local function var_0_2(arg_4_0, arg_4_1)
	local var_4_0 = HeroModel.instance:getByHeroId(arg_4_0.id)
	local var_4_1 = HeroModel.instance:getByHeroId(arg_4_1.id)
	local var_4_2 = var_4_0 ~= nil
	local var_4_3 = var_4_1 ~= nil

	if var_4_2 ~= var_4_3 then
		return var_4_3
	end

	local var_4_4 = var_4_0 and var_4_0.exSkillLevel or -1
	local var_4_5 = var_4_1 and var_4_1.exSkillLevel or -1

	if var_4_4 ~= var_4_5 then
		if var_4_4 == 5 or var_4_5 == 5 then
			return var_4_4 ~= 5
		end

		return var_4_5 < var_4_4
	end

	return arg_4_0.id > arg_4_1.id
end

function var_0_0._btncancelOnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._confirmCallback(arg_6_0)
	local var_6_0 = arg_6_0.viewParam.callback

	if var_6_0 then
		var_6_0(arg_6_0)
	else
		arg_6_0:closeThis()
	end
end

function var_0_0._btnconfirmOnClick(arg_7_0)
	arg_7_0:_confirmCallback()
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._txtTitle = gohelper.findChildText(arg_8_0.viewGO, "Title")
	arg_8_0._btn_confirmTxt = gohelper.findChildText(arg_8_0.viewGO, "#btn_confirm/Text")
	arg_8_0._goTitleNoGain = gohelper.findChild(arg_8_0.viewGO, "#scroll_rule/Viewport/#go_storeItem/Title1")
	arg_8_0._goTitleOwn = gohelper.findChild(arg_8_0.viewGO, "#scroll_rule/Viewport/#go_storeItem/Title2")

	gohelper.setActive(arg_8_0._goLifeCirclePickChoiceItem, false)

	arg_8_0._gostoreItemTrans = arg_8_0._gostoreItem.transform
	arg_8_0._gostoreItem_simpleTrans = arg_8_0._gostoreItem_simple.transform
	arg_8_0._scrollruleGo = arg_8_0._scrollrule.gameObject
	arg_8_0._scrollrule_simpleGo = arg_8_0._scrollrule_simple.gameObject
	arg_8_0._noGainItemList = {}
	arg_8_0._ownItemList = {}
	arg_8_0._noGainDataList = {}
	arg_8_0._ownDataList = {}
end

function var_0_0._heroIdList(arg_9_0)
	return arg_9_0.viewParam.heroIdList or {}
end

function var_0_0._title(arg_10_0)
	return arg_10_0.viewParam.title or ""
end

function var_0_0._confirmDesc(arg_11_0)
	return arg_11_0.viewParam.confirmDesc or ""
end

function var_0_0.isCustomSelect(arg_12_0)
	return arg_12_0.viewParam.isCustomSelect or false
end

function var_0_0._isTitleStyle(arg_13_0)
	return arg_13_0.viewParam.style == var_0_0.Style.None
end

function var_0_0.onUpdateParam(arg_14_0)
	gohelper.setActive(arg_14_0._scrollruleGo, false)
	gohelper.setActive(arg_14_0._scrollrule_simpleGo, false)

	if arg_14_0:_isTitleStyle() then
		gohelper.setActive(arg_14_0._scrollruleGo, true)
		arg_14_0:_refreshWithTitle()
	else
		gohelper.setActive(arg_14_0._scrollrule_simpleGo, true)
		arg_14_0:_refresh()
	end
end

function var_0_0.onOpen(arg_15_0)
	arg_15_0._txtTitle.text = arg_15_0:_title()
	arg_15_0._btn_confirmTxt.text = arg_15_0:_confirmDesc()

	for iter_15_0, iter_15_1 in ipairs(arg_15_0:_heroIdList()) do
		local var_15_0 = SummonCustomPickChoiceMO.New()

		var_15_0:init(iter_15_1)

		if var_15_0:hasHero() then
			var_0_1(arg_15_0._ownDataList, var_15_0)
		else
			var_0_1(arg_15_0._noGainDataList, var_15_0)
		end
	end

	table.sort(arg_15_0._ownDataList, var_0_2)
	table.sort(arg_15_0._noGainDataList, var_0_2)
	arg_15_0:onUpdateParam()
end

function var_0_0.onClose(arg_16_0)
	GameUtil.onDestroyViewMemberList(arg_16_0, "_noGainItemList")
	GameUtil.onDestroyViewMemberList(arg_16_0, "_ownItemList")
end

function var_0_0.onDestroyView(arg_17_0)
	return
end

function var_0_0._refreshWithTitle(arg_18_0)
	arg_18_0:_refreshItemListAndTitle(arg_18_0._noGainDataList, arg_18_0._noGainItemList, arg_18_0._gonogain, arg_18_0._goTitleNoGain)
	arg_18_0:_refreshItemListAndTitle(arg_18_0._ownDataList, arg_18_0._ownItemList, arg_18_0._goown, arg_18_0._goTitleOwn)
	ZProj.UGUIHelper.RebuildLayout(arg_18_0._gostoreItemTrans)
end

function var_0_0._refresh(arg_19_0)
	arg_19_0:_refreshItemList(arg_19_0._noGainDataList, arg_19_0._noGainItemList, arg_19_0._gosimple)
	arg_19_0:_refreshItemList(arg_19_0._ownDataList, arg_19_0._ownItemList, arg_19_0._gosimple)
	ZProj.UGUIHelper.RebuildLayout(arg_19_0._gostoreItem_simpleTrans)
end

function var_0_0._refreshItemListAndTitle(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4)
	local var_20_0 = not arg_20_1 or #arg_20_1 == 0

	gohelper.setActive(arg_20_3, not var_20_0)
	gohelper.setActive(arg_20_4, not var_20_0)

	if var_20_0 then
		return
	end

	arg_20_0:_refreshItemList(arg_20_1, arg_20_2, arg_20_3)
end

function var_0_0._refreshItemList(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	for iter_21_0, iter_21_1 in ipairs(arg_21_1) do
		local var_21_0 = arg_21_2[iter_21_0]

		if not var_21_0 then
			var_21_0 = arg_21_0:_create_LifeCirclePickChoiceItem(iter_21_0, arg_21_3)
			arg_21_2[iter_21_0] = var_21_0
		end

		var_21_0:onUpdateMO(iter_21_1)
		var_21_0:setActive(true)
	end

	for iter_21_2 = #arg_21_1 + 1, #arg_21_2 do
		item:setActive(false)
	end
end

function var_0_0._create_LifeCirclePickChoiceItem(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = gohelper.clone(arg_22_0._goLifeCirclePickChoiceItem, arg_22_2)
	local var_22_1 = LifeCirclePickChoiceItem.New({
		parent = arg_22_0,
		baseViewContainer = arg_22_0.viewContainer
	})

	var_22_1:init(var_22_0)
	var_22_1:setIndex(arg_22_1)

	return var_22_1
end

function var_0_0.onItemSelected(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_0._lastSelectedItem then
		arg_23_0._lastSelectedItem:setSelected(false)
	end

	arg_23_0._lastSelectedItem = arg_23_2 and arg_23_1 or nil
end

function var_0_0.selectedHeroId(arg_24_0)
	if not arg_24_0._lastSelectedItem then
		return
	end

	return arg_24_0._lastSelectedItem:heroId()
end

return var_0_0
