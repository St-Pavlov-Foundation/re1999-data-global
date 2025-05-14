module("modules.logic.versionactivity2_2.act169.view.SummonNewCustomPickTipsView", package.seeall)

local var_0_0 = class("SummonNewCustomPickTipsView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/bg/#simage_bg1")
	arg_1_0._simagebg2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/bg/#simage_bg2")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_close")
	arg_1_0._btncloseBg = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_closeBg")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btncloseBg:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0:addEventCb(SummonNewCustomPickChoiceController.instance, SummonNewCustomPickEvent.OnCustomPickListChanged, arg_2_0.refreshUI, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btncloseBg:RemoveClickListener()
	arg_3_0:removeEventCb(SummonNewCustomPickChoiceController.instance, SummonNewCustomPickEvent.OnCustomPickListChanged, arg_3_0.refreshUI, arg_3_0)
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._noGainHeroes = {}
	arg_5_0._ownHeroes = {}
	arg_5_0._gobg = gohelper.findChild(arg_5_0.viewGO, "bg")
	arg_5_0._goitem = gohelper.findChild(arg_5_0.viewGO, "root/#scroll_rule/Viewport/#go_storeItem/selfselectsixchoiceitem")
	arg_5_0._gocontent = gohelper.findChild(arg_5_0.viewGO, "root/#scroll_rule/Viewport/#go_storeItem")
	arg_5_0._goNoGain = gohelper.findChild(arg_5_0.viewGO, "root/#scroll_rule/Viewport/#go_storeItem/#go_nogain")
	arg_5_0._goOwn = gohelper.findChild(arg_5_0.viewGO, "root/#scroll_rule/Viewport/#go_storeItem/#go_own")
	arg_5_0._goTitleNoGain = gohelper.findChild(arg_5_0.viewGO, "root/#scroll_rule/Viewport/#go_storeItem/Title1")
	arg_5_0._goTitleOwn = gohelper.findChild(arg_5_0.viewGO, "root/#scroll_rule/Viewport/#go_storeItem/Title2")

	gohelper.setActive(arg_5_0._goitem, false)

	arg_5_0._tfcontent = arg_5_0._gocontent.transform
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	logNormal("SummonCustomPickChoiceList onOpen")
	arg_7_0:refreshUI()
end

function var_0_0.refreshUI(arg_8_0)
	arg_8_0:refreshList()
end

function var_0_0.refreshList(arg_9_0)
	arg_9_0:refreshItems(SummonNewCustomPickChoiceListModel.instance.noGainList, arg_9_0._noGainHeroes, arg_9_0._goNoGain, arg_9_0._goTitleNoGain)
	arg_9_0:refreshItems(SummonNewCustomPickChoiceListModel.instance.ownList, arg_9_0._ownHeroes, arg_9_0._goOwn, arg_9_0._goTitleOwn)
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

		var_11_0.component = MonoHelper.addNoUpdateLuaComOnceToGo(var_11_0.go, SummonNewCustomPickChoiceItem)

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
	return
end

return var_0_0
