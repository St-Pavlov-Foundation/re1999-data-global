module("modules.logic.custompickchoice.view.CustomPickChoiceView", package.seeall)

local var_0_0 = class("CustomPickChoiceView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gobg = gohelper.findChild(arg_1_0.viewGO, "mask")
	arg_1_0._gomask = gohelper.findChild(arg_1_0.viewGO, "bg")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "Title")
	arg_1_0._goTips = gohelper.findChild(arg_1_0.viewGO, "Tips2")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "Tips2/#txt_num")
	arg_1_0._btnconfirm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_confirm")
	arg_1_0._btncancel = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_cancel")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "#scroll_rule/Viewport/#go_storeItem")
	arg_1_0._goitem = gohelper.findChild(arg_1_0.viewGO, "#scroll_rule/Viewport/#go_storeItem/selfselectsixchoiceitem")
	arg_1_0._gonogain = gohelper.findChild(arg_1_0.viewGO, "#scroll_rule/Viewport/#go_storeItem/#go_nogain")
	arg_1_0._goown = gohelper.findChild(arg_1_0.viewGO, "#scroll_rule/Viewport/#go_storeItem/#go_own")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnconfirm:AddClickListener(arg_2_0._btnconfirmOnClick, arg_2_0)
	arg_2_0._btncancel:AddClickListener(arg_2_0.closeThis, arg_2_0)
	arg_2_0:addEventCb(CustomPickChoiceController.instance, CustomPickChoiceEvent.onCustomPickListChanged, arg_2_0.refreshUI, arg_2_0)
	arg_2_0:addEventCb(CustomPickChoiceController.instance, CustomPickChoiceEvent.onCustomPickComplete, arg_2_0.closeThis, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnconfirm:RemoveClickListener()
	arg_3_0._btncancel:RemoveClickListener()
	arg_3_0:removeEventCb(CustomPickChoiceController.instance, CustomPickChoiceEvent.onCustomPickListChanged, arg_3_0.refreshUI, arg_3_0)
	arg_3_0:removeEventCb(CustomPickChoiceController.instance, CustomPickChoiceEvent.onCustomPickComplete, arg_3_0.closeThis, arg_3_0)
end

function var_0_0._btnconfirmOnClick(arg_4_0)
	CustomPickChoiceController.instance:tryChoice(arg_4_0.viewParam)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._noGainHeroes = {}
	arg_5_0._ownHeroes = {}
	arg_5_0._goTitleNoGain = gohelper.findChild(arg_5_0.viewGO, "#scroll_rule/Viewport/#go_storeItem/Title1")
	arg_5_0._goTitleOwn = gohelper.findChild(arg_5_0.viewGO, "#scroll_rule/Viewport/#go_storeItem/Title2")
	arg_5_0._transcontent = arg_5_0._gocontent.transform

	gohelper.setActive(arg_5_0._goitem, false)
end

function var_0_0.onOpen(arg_6_0)
	logNormal("CustomPickChoiceView onOpen")
	CustomPickChoiceController.instance:onOpenView()

	local var_6_0 = arg_6_0.viewParam and arg_6_0.viewParam.styleId
	local var_6_1 = var_6_0 and CustomPickChoiceEnum.FixedText[var_6_0]

	if var_6_1 then
		for iter_6_0, iter_6_1 in pairs(var_6_1) do
			if arg_6_0[iter_6_0] then
				arg_6_0[iter_6_0].text = luaLang(iter_6_1)
			end
		end
	end

	local var_6_2 = var_6_0 and CustomPickChoiceEnum.ComponentVisible[var_6_0]

	if var_6_2 then
		for iter_6_2, iter_6_3 in pairs(var_6_2) do
			if arg_6_0[iter_6_2] then
				gohelper.setActive(arg_6_0[iter_6_2], iter_6_3)
			end
		end
	end
end

function var_0_0.refreshUI(arg_7_0)
	arg_7_0:refreshSelectCount()
	arg_7_0:refreshList()
end

function var_0_0.refreshSelectCount(arg_8_0)
	local var_8_0 = CustomPickChoiceListModel.instance:getSelectCount()
	local var_8_1 = CustomPickChoiceListModel.instance:getMaxSelectCount()

	arg_8_0._txtnum.text = GameUtil.getSubPlaceholderLuaLang(luaLang("summon_custompick_selectnum"), {
		var_8_0,
		var_8_1
	})

	ZProj.UGUIHelper.SetGrayscale(arg_8_0._btnconfirm.gameObject, var_8_0 ~= var_8_1)
end

function var_0_0.refreshList(arg_9_0)
	arg_9_0:refreshItems(CustomPickChoiceListModel.instance.noGainList, arg_9_0._noGainHeroes, arg_9_0._gonogain, arg_9_0._goTitleNoGain)
	arg_9_0:refreshItems(CustomPickChoiceListModel.instance.ownList, arg_9_0._ownHeroes, arg_9_0._goown, arg_9_0._goTitleOwn)
	ZProj.UGUIHelper.RebuildLayout(arg_9_0._transcontent)
end

function var_0_0.refreshItems(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	if arg_10_1 and #arg_10_1 > 0 then
		gohelper.setActive(arg_10_3, true)
		gohelper.setActive(arg_10_4, true)

		for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
			arg_10_0:getOrCreateItem(iter_10_0, arg_10_2, arg_10_3).component:onUpdateMO(iter_10_1)
		end
	else
		gohelper.setActive(arg_10_3, false)
		gohelper.setActive(arg_10_4, false)
	end
end

function var_0_0.getOrCreateItem(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = arg_11_2[arg_11_1]

	if not var_11_0 then
		var_11_0 = arg_11_0:getUserDataTb_()
		var_11_0.go = gohelper.clone(arg_11_0._goitem, arg_11_3, "item" .. tostring(arg_11_1))

		gohelper.setActive(var_11_0.go, true)

		var_11_0.component = MonoHelper.addNoUpdateLuaComOnceToGo(var_11_0.go, CustomPickChoiceItem)

		var_11_0.component:init(var_11_0.go)
		var_11_0.component:addEvents()

		arg_11_2[arg_11_1] = var_11_0
	end

	return var_11_0
end

function var_0_0.onClose(arg_12_0)
	return
end

function var_0_0.onDestroyView(arg_13_0)
	CustomPickChoiceController.instance:onCloseView()
end

return var_0_0
