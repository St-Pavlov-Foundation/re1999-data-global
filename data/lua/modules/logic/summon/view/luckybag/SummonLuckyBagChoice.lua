module("modules.logic.summon.view.luckybag.SummonLuckyBagChoice", package.seeall)

local var_0_0 = class("SummonLuckyBagChoice", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "Tips2/#txt_num")
	arg_1_0._btnconfirm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_confirm")
	arg_1_0._btncancel = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_cancel")
	arg_1_0._scrollrule = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_rule")
	arg_1_0._gostoreItem = gohelper.findChild(arg_1_0.viewGO, "#scroll_rule/Viewport/#go_storeItem")
	arg_1_0._goexskill = gohelper.findChild(arg_1_0.viewGO, "#scroll_rule/Viewport/#go_storeItem/selfselectsixchoiceitem/role/#go_exskill")
	arg_1_0._imageexskill = gohelper.findChildImage(arg_1_0.viewGO, "#scroll_rule/Viewport/#go_storeItem/selfselectsixchoiceitem/role/#go_exskill/#image_exskill")
	arg_1_0._goclick = gohelper.findChild(arg_1_0.viewGO, "#scroll_rule/Viewport/#go_storeItem/selfselectsixchoiceitem/select/#go_click")
	arg_1_0._gonogain = gohelper.findChild(arg_1_0.viewGO, "#scroll_rule/Viewport/#go_storeItem/#go_nogain")
	arg_1_0._goown = gohelper.findChild(arg_1_0.viewGO, "#scroll_rule/Viewport/#go_storeItem/#go_own")

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

function var_0_0._btnconfirmOnClick(arg_4_0)
	SummonLuckyBagChoiceController.instance:trySendChoice()
end

function var_0_0._btncancelOnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._noGainHeroes = {}
	arg_6_0._ownHeroes = {}
	arg_6_0._goTitleNoGain = gohelper.findChild(arg_6_0.viewGO, "#scroll_rule/Viewport/#go_storeItem/Title1")
	arg_6_0._goTitleOwn = gohelper.findChild(arg_6_0.viewGO, "#scroll_rule/Viewport/#go_storeItem/Title2")
	arg_6_0._txtTitle = gohelper.findChildText(arg_6_0.viewGO, "Title")
	arg_6_0._goitem = gohelper.findChild(arg_6_0.viewGO, "#scroll_rule/Viewport/#go_storeItem/selfselectsixchoiceitem")
	arg_6_0.goTips2 = gohelper.findChild(arg_6_0.viewGO, "Tips2")
	arg_6_0._tfcontent = arg_6_0._gostoreItem.transform

	gohelper.setActive(arg_6_0._goitem, false)
	gohelper.setActive(arg_6_0.goTips2, false)
end

function var_0_0.onDestroyView(arg_7_0)
	SummonLuckyBagChoiceController.instance:onCloseView()
end

function var_0_0.onOpen(arg_8_0)
	logNormal("SummonLuckyBagChoice onOpen")
	arg_8_0:addEventCb(SummonController.instance, SummonEvent.onLuckyBagOpened, arg_8_0.handleLuckyBagOpened, arg_8_0)
	arg_8_0:addEventCb(SummonLuckyBagChoiceController.instance, SummonEvent.onLuckyListChanged, arg_8_0.refreshUI, arg_8_0)
	arg_8_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_8_0._onCloseView, arg_8_0)
	SummonLuckyBagChoiceController.instance:onOpenView(arg_8_0.viewParam.luckyBagId, arg_8_0.viewParam.poolId)
	arg_8_0:refreshUI()
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.refreshUI(arg_10_0)
	local var_10_0 = SummonLuckyBagChoiceController.instance:isLuckyBagOpened()
	local var_10_1 = SummonLuckyBagChoiceListModel.instance:getSelectId()

	ZProj.UGUIHelper.SetGrayscale(arg_10_0._btnconfirm.gameObject, var_10_0 or var_10_1 == nil)
	arg_10_0:refreshList()
end

function var_0_0.handleLuckyBagOpened(arg_11_0)
	arg_11_0._btnconfirm:RemoveClickListener()
	arg_11_0._btncancel:RemoveClickListener()

	local var_11_0 = SummonLuckyBagChoiceController.instance:isLuckyBagOpened()
	local var_11_1 = SummonLuckyBagChoiceListModel.instance:getSelectId()

	ZProj.UGUIHelper.SetGrayscale(arg_11_0._btnconfirm.gameObject, var_11_0 or var_11_1 == nil)
end

function var_0_0.refreshList(arg_12_0)
	arg_12_0:refreshItems(SummonLuckyBagChoiceListModel.instance.noGainList, arg_12_0._noGainHeroes, arg_12_0._gonogain, arg_12_0._goTitleNoGain)
	arg_12_0:refreshItems(SummonLuckyBagChoiceListModel.instance.ownList, arg_12_0._ownHeroes, arg_12_0._goown, arg_12_0._goTitleOwn)
	ZProj.UGUIHelper.RebuildLayout(arg_12_0._tfcontent)
end

function var_0_0.refreshItems(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	if arg_13_1 and #arg_13_1 > 0 then
		gohelper.setActive(arg_13_3, true)
		gohelper.setActive(arg_13_4, true)

		for iter_13_0, iter_13_1 in ipairs(arg_13_1) do
			arg_13_0:getOrCreateItem(iter_13_0, arg_13_2, arg_13_3).component:onUpdateMO(iter_13_1)
		end
	else
		gohelper.setActive(arg_13_3, false)
		gohelper.setActive(arg_13_4, false)
	end
end

function var_0_0._onCloseView(arg_14_0, arg_14_1)
	if arg_14_1 == ViewName.CharacterGetView then
		arg_14_0:closeThis()
	end
end

function var_0_0.getOrCreateItem(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = arg_15_2[arg_15_1]

	if not var_15_0 then
		var_15_0 = arg_15_0:getUserDataTb_()
		var_15_0.go = gohelper.clone(arg_15_0._goitem, arg_15_3, "item" .. tostring(arg_15_1))

		gohelper.setActive(var_15_0.go, true)

		var_15_0.component = MonoHelper.addNoUpdateLuaComOnceToGo(var_15_0.go, SummonLuckyBagChoiceItem)

		var_15_0.component:init(var_15_0.go)
		var_15_0.component:addEvents()

		arg_15_2[arg_15_1] = var_15_0
	end

	return var_15_0
end

return var_0_0
