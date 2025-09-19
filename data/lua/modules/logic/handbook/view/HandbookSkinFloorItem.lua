module("modules.logic.handbook.view.HandbookSkinFloorItem", package.seeall)

local var_0_0 = class("HandbookSkinFloorItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	gohelper.setActive(arg_1_0.viewGO, true)

	arg_1_0._goSelectedState = gohelper.findChild(arg_1_0.viewGO, "#select")
	arg_1_0._goUnSelectedState = gohelper.findChild(arg_1_0.viewGO, "#unclick")
	arg_1_0._txtSelectedFloorName = gohelper.findChildText(arg_1_0._goSelectedState, "#name")
	arg_1_0._txtUnSelectedFloorName = gohelper.findChildText(arg_1_0._goUnSelectedState, "#name")
	arg_1_0._txtSelectedFloorNameEn = gohelper.findChildText(arg_1_0._goSelectedState, "#name/#name_en")
	arg_1_0._txtUnSelectedFloorNameEn = gohelper.findChildText(arg_1_0._goUnSelectedState, "#name/#name_en")
	arg_1_0._txtSelectedCurSuitIdx = gohelper.findChildText(arg_1_0._goSelectedState, "#num")
	arg_1_0._txtUnSelectedCurSuitIdx = gohelper.findChildText(arg_1_0._goUnSelectedState, "#num")
	arg_1_0._txtSelectedCurFloorIdx = gohelper.findChildText(arg_1_0._goSelectedState, "#xulie")
	arg_1_0._txtUnSelectedCurFloorIdx = gohelper.findChildText(arg_1_0._goUnSelectedState, "#xulie")
	arg_1_0._click = gohelper.findChildClickWithAudio(arg_1_0.viewGO, "#unclick/btn_click")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._click:AddClickListener(arg_2_0.onClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._click:RemoveClickListener()
end

function var_0_0.onClick(arg_4_0)
	if arg_4_0._onClickAction then
		arg_4_0:_onClickAction()
	end
end

function var_0_0.setClickAction(arg_5_0, arg_5_1)
	arg_5_0._onClickAction = arg_5_1
end

function var_0_0._editableInitView(arg_6_0)
	return
end

function var_0_0.onUpdateData(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0._suitGroupCfg = arg_7_1
	arg_7_0._idx = arg_7_2
	arg_7_0._suitList = HandbookConfig.instance:getSkinSuitCfgListInGroup(arg_7_1.id) or {}
	arg_7_0._suitCount = #arg_7_0._suitList
	arg_7_0._curSuitIdx = 1
	arg_7_0._skinIdList = {}

	for iter_7_0 = 1, #arg_7_0._suitList do
		local var_7_0 = arg_7_0._suitList[iter_7_0]

		tabletool.addValues(arg_7_0._skinIdList, HandbookConfig.instance:getSkinIdListBySuitId(var_7_0.id))
	end

	arg_7_0._skinCount = #arg_7_0._skinIdList
end

function var_0_0.getHasSkinCount(arg_8_0)
	local var_8_0 = arg_8_0._skinIdList

	if not var_8_0 or #var_8_0 < 1 then
		return 0
	end

	local var_8_1 = 0
	local var_8_2 = HeroModel.instance

	for iter_8_0 = 0, #var_8_0 do
		if var_8_2:checkHasSkin(var_8_0[iter_8_0]) then
			var_8_1 = var_8_1 + 1
		end
	end

	return var_8_1
end

function var_0_0.getIdx(arg_9_0)
	return arg_9_0._idx
end

function var_0_0.refreshFloorView(arg_10_0)
	arg_10_0._txtSelectedFloorName.text = arg_10_0._suitGroupCfg.name
	arg_10_0._txtUnSelectedFloorName.text = arg_10_0._suitGroupCfg.name
	arg_10_0._txtSelectedFloorNameEn.text = arg_10_0._suitGroupCfg.nameEn
	arg_10_0._txtUnSelectedFloorNameEn.text = arg_10_0._suitGroupCfg.nameEn
	arg_10_0._txtSelectedCurFloorIdx.text = arg_10_0._idx
	arg_10_0._txtUnSelectedCurFloorIdx.text = arg_10_0._idx
end

function var_0_0.refreshCurSuitIdx(arg_11_0)
	local var_11_0 = arg_11_0._skinIdList and #arg_11_0._skinIdList or 0
	local var_11_1 = arg_11_0:getHasSkinCount() .. "/" .. var_11_0

	arg_11_0._txtSelectedCurSuitIdx.text = var_11_1
	arg_11_0._txtUnSelectedCurSuitIdx.text = var_11_1
end

function var_0_0.refreshSelectState(arg_12_0, arg_12_1)
	arg_12_0._isSelected = arg_12_1

	if arg_12_0._isSelected then
		gohelper.setActive(arg_12_0._goSelectedState, true)
		gohelper.setActive(arg_12_0._goUnSelectedState, false)
	else
		gohelper.setActive(arg_12_0._goSelectedState, false)
		gohelper.setActive(arg_12_0._goUnSelectedState, true)
	end
end

function var_0_0.onDestroyView(arg_13_0)
	return
end

return var_0_0
