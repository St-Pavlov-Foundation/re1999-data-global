module("modules.logic.summon.view.custompick.SummonCustomPickChoiceList", package.seeall)

local var_0_0 = class("SummonCustomPickChoiceList", BaseView)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._noGainHeroes = {}
	arg_4_0._ownHeroes = {}
	arg_4_0._gobg = gohelper.findChild(arg_4_0.viewGO, "bg")
	arg_4_0._goitem = gohelper.findChild(arg_4_0.viewGO, "#scroll_rule/Viewport/#go_storeItem/selfselectsixchoiceitem")
	arg_4_0._gocontent = gohelper.findChild(arg_4_0.viewGO, "#scroll_rule/Viewport/#go_storeItem")
	arg_4_0._goNoGain = gohelper.findChild(arg_4_0.viewGO, "#scroll_rule/Viewport/#go_storeItem/#go_nogain")
	arg_4_0._goOwn = gohelper.findChild(arg_4_0.viewGO, "#scroll_rule/Viewport/#go_storeItem/#go_own")
	arg_4_0._goTitleNoGain = gohelper.findChild(arg_4_0.viewGO, "#scroll_rule/Viewport/#go_storeItem/Title1")
	arg_4_0._goTitleOwn = gohelper.findChild(arg_4_0.viewGO, "#scroll_rule/Viewport/#go_storeItem/Title2")
	arg_4_0.goTips2 = gohelper.findChild(arg_4_0.viewGO, "Tips2")
	arg_4_0._txtTitle = gohelper.findChildText(arg_4_0.viewGO, "Title")
	arg_4_0._txtTips = gohelper.findChildText(arg_4_0.viewGO, "TipsBG/Tips")

	gohelper.setActive(arg_4_0._goitem, false)

	arg_4_0._tfcontent = arg_4_0._gocontent.transform
end

function var_0_0.onDestroyView(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	logNormal("SummonCustomPickChoiceList onOpen")
	arg_6_0:addEventCb(SummonCustomPickChoiceController.instance, SummonEvent.onCustomPickListChanged, arg_6_0.refreshUI, arg_6_0)
	arg_6_0:refreshUI()
end

function var_0_0.onClose(arg_7_0)
	return
end

function var_0_0.refreshUI(arg_8_0)
	arg_8_0:refreshList()

	local var_8_0 = SummonCustomPickChoiceListModel.instance:getMaxSelectCount()
	local var_8_1

	if var_8_0 == 2 then
		var_8_1 = luaLang("summoncustompickchoice_txt_Title_Two")
	else
		var_8_1 = string.format(luaLang("summoncustompickchoice_txt_Title_Multiple"), var_8_0)
	end

	arg_8_0._txtTitle.text = var_8_1

	gohelper.setActive(arg_8_0.goTips2, var_8_0 ~= 1)

	if SummonCustomPickChoiceListModel.instance:getPoolType() == SummonEnum.Type.StrongCustomOnePick then
		var_8_1 = luaLang("summon_strong_custompick_desc")
	else
		var_8_1 = luaLang("p_selfselectsixchoiceview_txt_tips")
	end

	arg_8_0._txtTips.text = var_8_1
end

function var_0_0.refreshList(arg_9_0)
	arg_9_0:refreshItems(SummonCustomPickChoiceListModel.instance.noGainList, arg_9_0._noGainHeroes, arg_9_0._goNoGain, arg_9_0._goTitleNoGain)
	arg_9_0:refreshItems(SummonCustomPickChoiceListModel.instance.ownList, arg_9_0._ownHeroes, arg_9_0._goOwn, arg_9_0._goTitleOwn)
	ZProj.UGUIHelper.RebuildLayout(arg_9_0._tfcontent)
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

		var_11_0.component = MonoHelper.addNoUpdateLuaComOnceToGo(var_11_0.go, SummonCustomPickChoiceItem)

		var_11_0.component:init(var_11_0.go)
		var_11_0.component:addEvents()

		arg_11_2[arg_11_1] = var_11_0
	end

	return var_11_0
end

return var_0_0
