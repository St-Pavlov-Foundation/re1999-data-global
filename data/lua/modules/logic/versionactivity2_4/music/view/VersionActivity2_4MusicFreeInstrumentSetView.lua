module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicFreeInstrumentSetView", package.seeall)

local var_0_0 = class("VersionActivity2_4MusicFreeInstrumentSetView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtinfo = gohelper.findChildText(arg_1_0.viewGO, "root/#txt_info")
	arg_1_0._goinstrument = gohelper.findChild(arg_1_0.viewGO, "root/#go_instrument")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0.onClickModalMask(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._indexList = tabletool.copy(VersionActivity2_4MusicFreeModel.instance:getInstrumentIndexList())

	arg_6_0:_initItem()
	arg_6_0:_updateItems()
end

function var_0_0._initItem(arg_7_0)
	arg_7_0._itemList = arg_7_0:getUserDataTb_()

	local var_7_0 = Activity179Config.instance:getInstrumentSwitchList()

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		local var_7_1 = arg_7_0.viewContainer:getSetting().otherRes[1]
		local var_7_2 = arg_7_0:getResInst(var_7_1, arg_7_0._goinstrument)
		local var_7_3 = MonoHelper.addNoUpdateLuaComOnceToGo(var_7_2, VersionActivity2_4MusicFreeInstrumentSetItem)

		arg_7_0._itemList[iter_7_0] = var_7_3

		var_7_3:onUpdateMO(iter_7_1, arg_7_0)
	end
end

function var_0_0._updateItems(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0._itemList) do
		iter_8_1:updateIndex()
	end

	local var_8_0 = arg_8_0:_getSelectedNum()
	local var_8_1 = string.format("<color=#C66030>%s</color>/%s", var_8_0, 2)

	arg_8_0._txtinfo.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("MusicInstrumentsSelectedTips"), var_8_1)
	arg_8_0._hasSelectedChange = true
end

function var_0_0.addInstrument(arg_9_0, arg_9_1)
	if arg_9_0:_getSelectedNum() >= VersionActivity2_4MusicEnum.SelectInstrumentNum then
		return
	end

	local var_9_0 = tabletool.indexOf(arg_9_0._indexList, 0)

	arg_9_0._indexList[var_9_0] = arg_9_1

	arg_9_0:_updateItems()
end

function var_0_0.removeInstrument(arg_10_0, arg_10_1)
	local var_10_0 = tabletool.indexOf(arg_10_0._indexList, arg_10_1)

	if var_10_0 then
		arg_10_0._indexList[var_10_0] = 0

		arg_10_0:_updateItems()
	end
end

function var_0_0._getSelectedNum(arg_11_0)
	local var_11_0 = 0

	for iter_11_0, iter_11_1 in ipairs(arg_11_0._indexList) do
		if iter_11_1 ~= 0 then
			var_11_0 = var_11_0 + 1
		end
	end

	return var_11_0
end

function var_0_0.onOpen(arg_12_0)
	return
end

function var_0_0.onClose(arg_13_0)
	if not arg_13_0._hasSelectedChange then
		return
	end

	VersionActivity2_4MusicFreeModel.instance:setInstrumentIndexList(arg_13_0._indexList)
	VersionActivity2_4MusicController.instance:dispatchEvent(VersionActivity2_4MusicEvent.InstrumentSelectChange)
end

function var_0_0.onDestroyView(arg_14_0)
	return
end

return var_0_0
