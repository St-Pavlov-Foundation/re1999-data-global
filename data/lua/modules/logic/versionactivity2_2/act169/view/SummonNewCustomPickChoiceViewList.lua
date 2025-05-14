module("modules.logic.versionactivity2_2.act169.view.SummonNewCustomPickChoiceViewList", package.seeall)

local var_0_0 = class("SummonNewCustomPickChoiceViewList", BaseView)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0._editableInitView(arg_2_0)
	arg_2_0._ownHeroes = {}
	arg_2_0._gocontent = gohelper.findChild(arg_2_0.viewGO, "#scroll_rule/Viewport/content")
	arg_2_0._tfcontent = arg_2_0._gocontent.transform
	arg_2_0._goitem = gohelper.findChild(arg_2_0.viewGO, "#scroll_rule/Viewport/content/selfselectsixchoiceitem")

	gohelper.setActive(arg_2_0._goitem, false)
end

function var_0_0.onOpen(arg_3_0)
	logNormal("SummonNewCustomPickChoiceViewList onOpen")
	SummonNewCustomPickChoiceListModel.instance:clearSelectIds()
	arg_3_0:refreshUI()
end

function var_0_0.refreshUI(arg_4_0)
	arg_4_0:refreshList()
end

function var_0_0.refreshList(arg_5_0)
	arg_5_0:refreshItems(SummonNewCustomPickChoiceListModel.instance.ownList, arg_5_0._ownHeroes, arg_5_0._gocontent)
	ZProj.UGUIHelper.RebuildLayout(arg_5_0._tfcontent)
end

function var_0_0.refreshItems(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if arg_6_1 and #arg_6_1 > 0 then
		gohelper.setActive(arg_6_3, true)

		for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
			arg_6_0:getOrCreateItem(iter_6_0, arg_6_2, arg_6_3).component:onUpdateMO(iter_6_1)
		end
	else
		gohelper.setActive(arg_6_3, false)
	end
end

function var_0_0.getOrCreateItem(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = arg_7_2[arg_7_1]

	if not var_7_0 then
		var_7_0 = arg_7_0:getUserDataTb_()
		var_7_0.go = gohelper.clone(arg_7_0._goitem, arg_7_3, "item" .. tostring(arg_7_1))

		gohelper.setActive(var_7_0.go, true)

		var_7_0.component = MonoHelper.addNoUpdateLuaComOnceToGo(var_7_0.go, SummonNewCustomPickChoiceItem)

		var_7_0.component:init(var_7_0.go)
		var_7_0.component:addEvents()
		var_7_0.component:setClickCallBack(function(arg_8_0)
			SummonNewCustomPickChoiceController.instance:setSelect(arg_8_0)
		end)

		arg_7_2[arg_7_1] = var_7_0
	end

	return var_7_0
end

function var_0_0.addEvents(arg_9_0)
	arg_9_0:addEventCb(SummonNewCustomPickChoiceController.instance, SummonNewCustomPickEvent.OnCustomPickListChanged, arg_9_0.refreshUI, arg_9_0)
end

function var_0_0.removeEvents(arg_10_0)
	arg_10_0:removeEventCb(SummonNewCustomPickChoiceController.instance, SummonNewCustomPickEvent.OnCustomPickListChanged, arg_10_0.refreshUI, arg_10_0)
end

return var_0_0
