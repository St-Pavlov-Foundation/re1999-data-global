module("modules.logic.bgmswitch.view.BGMSwitchMusicFilterView", package.seeall)

local var_0_0 = class("BGMSwitchMusicFilterView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._goobtain = gohelper.findChild(arg_1_0.viewGO, "container/layoutgroup/#go_obtain")
	arg_1_0._scrollAmount = gohelper.findChildScrollRect(arg_1_0.viewGO, "container/layoutgroup/#go_obtain/#scroll_Amount")
	arg_1_0._gotypeitem = gohelper.findChild(arg_1_0.viewGO, "container/layoutgroup/#go_obtain/#scroll_Amount/Viewport/Container/#go_typeitem")
	arg_1_0._btnreset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "container/#btn_reset")
	arg_1_0._btnconfirm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "container/#btn_confirm")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnreset:AddClickListener(arg_2_0._btnresetOnClick, arg_2_0)
	arg_2_0._btnconfirm:AddClickListener(arg_2_0._btnconfirmOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnreset:RemoveClickListener()
	arg_3_0._btnconfirm:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnresetOnClick(arg_5_0)
	BGMSwitchModel.instance:clearFilterTypes()
	BGMSwitchController.instance:dispatchEvent(BGMSwitchEvent.FilterClassSelect)
	arg_5_0:_refreshView()
end

function var_0_0._btnconfirmOnClick(arg_6_0)
	arg_6_0:closeThis()
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._items = {}
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0:_addSelfEvents()
	arg_9_0:_refreshView()
end

function var_0_0._addSelfEvents(arg_10_0)
	return
end

function var_0_0._refreshView(arg_11_0)
	arg_11_0:_refreshContent()
	arg_11_0:_refreshItems()
end

function var_0_0._refreshContent(arg_12_0)
	return
end

function var_0_0._refreshItems(arg_13_0)
	local var_13_0 = {}
	local var_13_1 = {}
	local var_13_2 = BGMSwitchModel.instance:getBGMSelectType()

	if var_13_2 == BGMSwitchEnum.SelectType.All then
		var_13_1 = BGMSwitchModel.instance:getUnfilteredAllBgmsSorted()
	elseif var_13_2 == BGMSwitchEnum.SelectType.Loved then
		var_13_1 = BGMSwitchModel.instance:getUnfilteredFavoriteBgmsSorted()
	end

	for iter_13_0, iter_13_1 in pairs(var_13_1) do
		var_13_0[BGMSwitchConfig.instance:getBGMSwitchCO(iter_13_1).audioType] = true
	end

	for iter_13_2, iter_13_3 in pairs(var_13_0) do
		if not arg_13_0._items[iter_13_2] then
			local var_13_3 = BGMSwitchMusicFilterItem.New()
			local var_13_4 = gohelper.cloneInPlace(arg_13_0._gotypeitem, iter_13_2)

			var_13_3:init(var_13_4)

			arg_13_0._items[iter_13_2] = var_13_3
		end

		local var_13_5 = BGMSwitchConfig.instance:getBGMTypeCO(iter_13_2)

		arg_13_0._items[iter_13_2]:setItem(var_13_5)
	end
end

function var_0_0.onClose(arg_14_0)
	arg_14_0:_removeSelfEvents()
end

function var_0_0._removeSelfEvents(arg_15_0)
	return
end

function var_0_0.onDestroyView(arg_16_0)
	if arg_16_0._items then
		for iter_16_0, iter_16_1 in pairs(arg_16_0._items) do
			iter_16_1:destroy()
		end
	end
end

return var_0_0
