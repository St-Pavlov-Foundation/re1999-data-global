module("modules.logic.versionactivity2_4.wuerlixi.view.WuErLiXiUnitTipView", package.seeall)

local var_0_0 = class("WuErLiXiUnitTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._scrollunits = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_units")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "#scroll_units/Viewport/#go_content")
	arg_1_0._gounititem = gohelper.findChild(arg_1_0.viewGO, "#scroll_units/Viewport/#go_content/#go_unititem")
	arg_1_0._btnclose1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close1")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnclose1:AddClickListener(arg_2_0._btnclose1OnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnclose1:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnclose1OnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0.onClickModalMask(arg_6_0)
	arg_6_0:closeThis()
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._unitItems = {}
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0:refreshUI()
end

function var_0_0.refreshUI(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(arg_9_0._unitItems) do
		iter_9_1:hide()
	end

	local var_9_0 = WuErLiXiMapModel.instance:getUnlockElements()

	for iter_9_2, iter_9_3 in ipairs(var_9_0) do
		if not arg_9_0._unitItems[iter_9_3.id] then
			arg_9_0._unitItems[iter_9_3.id] = WuErLiXiUnitTipItem.New()

			local var_9_1 = gohelper.cloneInPlace(arg_9_0._gounititem)

			arg_9_0._unitItems[iter_9_3.id]:init(var_9_1)
		end

		arg_9_0._unitItems[iter_9_3.id]:setItem(iter_9_3)
	end
end

return var_0_0
