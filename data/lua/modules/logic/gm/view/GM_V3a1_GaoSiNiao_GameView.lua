local var_0_0 = string.format
local var_0_1 = table.insert
local var_0_2 = UnityEngine.Input
local var_0_3 = UnityEngine.KeyCode
local var_0_4 = UnityEngine.GameObject
local var_0_5 = "#FFFF00"
local var_0_6 = "#FF0000"
local var_0_7 = "#00FF00"
local var_0_8 = "#0000FF"
local var_0_9 = "#FFFFFF"
local var_0_10 = "#000000"

module("modules.logic.gm.view.GM_V3a1_GaoSiNiao_GameView", package.seeall)

local var_0_11 = class("GM_V3a1_GaoSiNiao_GameView", BaseView)

function var_0_11.register()
	addGlobalModule("modules.logic.gm.gaosiniao.GaoSiNiaoBattleMapMO__Edit", "GaoSiNiaoBattleMapMO__Edit")
	var_0_11.V3a1_GaoSiNiao_GameView_register(V3a1_GaoSiNiao_GameView)
	var_0_11.V3a1_GaoSiNiao_GameView_BagItem_register(V3a1_GaoSiNiao_GameView_BagItem)
	var_0_11.V3a1_GaoSiNiao_GameView_GridItem_register(V3a1_GaoSiNiao_GameView_GridItem)
end

local var_0_12 = _G.class("GM_V3a1_GaoSiNiao_GameView_BtnTextView", RougeSimpleItemBase)

function var_0_12.ctor(arg_2_0, arg_2_1)
	RougeSimpleItemBase.ctor(arg_2_0, arg_2_1)

	arg_2_0._btnCmp = arg_2_1.btnCmp
	arg_2_0._btnText = arg_2_1.btnText
	arg_2_0._btnTrans = arg_2_0._btnCmp.transform
	arg_2_0._textTrans = arg_2_0._btnText.transform
end

function var_0_12.addEvents(arg_3_0)
	arg_3_0._btnCmp:AddClickListener(arg_3_0._onClick, arg_3_0)
end

function var_0_12.removeEvents(arg_4_0)
	arg_4_0._btnCmp:RemoveClickListener()
end

function var_0_12._onClick(arg_5_0)
	local var_5_0 = arg_5_0._staticData.onClickCb

	if var_5_0 then
		var_5_0(arg_5_0)
	end
end

function var_0_12.setBtnWidth(arg_6_0, arg_6_1)
	recthelper.setWidth(arg_6_0._btnTrans, math.max(100, arg_6_1 or 0))
end

function var_0_12.setBtnHeight(arg_7_0, arg_7_1)
	recthelper.setHeight(arg_7_0._btnTrans, math.max(100, arg_7_1 or 0))
end

function var_0_12.setBtnTextColor(arg_8_0, arg_8_1)
	UIColorHelper.set(arg_8_0._btnText, arg_8_1)
end

function var_0_12.setText(arg_9_0, arg_9_1)
	arg_9_0._btnText.text = arg_9_1
end

function var_0_12._editableInitView(arg_10_0)
	RougeSimpleItemBase._editableInitView(arg_10_0)
	arg_10_0:setBtnWidth(169)

	arg_10_0._textTrans.anchorMin = Vector2.New(0, 0)
	arg_10_0._textTrans.anchorMax = Vector2.New(1, 1)

	recthelper.setAnchor(arg_10_0._textTrans, 0, 0)

	arg_10_0._textTrans.sizeDelta = Vector2.New(0, 0)

	arg_10_0:setBtnTextColor(var_0_10)
end

local var_0_13 = _G.class("GM_V3a1_GaoSiNiao_GameView_DropdownView", RougeSimpleItemBase)

function var_0_13.ctor(arg_11_0, arg_11_1)
	RougeSimpleItemBase.ctor(arg_11_0, arg_11_1)

	arg_11_0._btnCmp = arg_11_1.btnCmp
	arg_11_0._btnText = arg_11_1.btnText
	arg_11_0._btnTextGo = arg_11_0._btnText.gameObject
	arg_11_0._curSelectIndex = 0
	arg_11_0._valueList = {}
end

function var_0_13.addEvents(arg_12_0)
	arg_12_0._btnCmp:AddClickListener(arg_12_0._onClick, arg_12_0)
end

function var_0_13.removeEvents(arg_13_0)
	arg_13_0._btnCmp:RemoveClickListener()
end

function var_0_13._editableInitView(arg_14_0)
	RougeSimpleItemBase._editableInitView(arg_14_0)

	local var_14_0 = gohelper.create2d(arg_14_0.viewGO)
	local var_14_1 = var_14_0.transform
	local var_14_2 = gohelper.clone(arg_14_0._btnTextGo, var_14_0, "Dropdown Text")
	local var_14_3 = var_14_2.transform
	local var_14_4 = gohelper.onceAddComponent(var_14_0, gohelper.Type_Image)
	local var_14_5 = gohelper.findChildText(var_14_2, "")

	var_14_1.pivot = Vector2.New(0.5, 1)

	UIDockingHelper.setDock(UIDockingHelper.Dock.MB_D, var_14_1, arg_14_0:transform())

	var_14_5.richText = true
	var_14_3.anchorMin = Vector2.New(0, 0)
	var_14_3.anchorMax = Vector2.New(1, 1)

	recthelper.setAnchor(var_14_3, 0, 0)

	var_14_3.sizeDelta = Vector2.New(0, 0)

	ZProj.UGUIHelper.SetColorAlpha(var_14_4, 0.5)
	UIColorHelper.set(var_14_5, var_0_10)

	arg_14_0._imgGo = var_14_0
	arg_14_0._imgTrans = var_14_1
	arg_14_0._dropDownText = var_14_5

	arg_14_0:setActive_imgTrans(false)
end

function var_0_13.optionCount(arg_15_0)
	return arg_15_0._valueList and #arg_15_0._valueList or 0
end

function var_0_13.setOptionList(arg_16_0, arg_16_1, arg_16_2)
	arg_16_2 = arg_16_2 or arg_16_1
	arg_16_0._valueList = arg_16_1 or {}
	arg_16_0._nameList = arg_16_2 or {}
	arg_16_0._curSelectIndex = 0

	arg_16_0:onUpdateMO()
end

function var_0_13.setBtnDesc(arg_17_0, arg_17_1)
	arg_17_0._btnText.text = gohelper.getRichColorText(arg_17_1, var_0_5)
end

function var_0_13.setData(arg_18_0)
	local var_18_0 = {}
	local var_18_1 = "None"

	for iter_18_0, iter_18_1 in ipairs(arg_18_0._nameList or {}) do
		if iter_18_0 - 1 == arg_18_0._curSelectIndex then
			local var_18_2 = iter_18_1

			iter_18_1 = gohelper.getRichColorText(iter_18_1, var_0_7)
		end

		var_0_1(var_18_0, iter_18_1)
	end

	arg_18_0._dropDownText.text = table.concat(var_18_0, "\n")

	recthelper.setHeight(arg_18_0._imgTrans, arg_18_0._dropDownText.preferredHeight)

	if arg_18_0._curSelectIndex < 0 then
		arg_18_0:setBtnDesc("--")
	end
end

function var_0_13.setDropdownWidth(arg_19_0, arg_19_1)
	recthelper.setWidth(arg_19_0._imgTrans, math.max(100, arg_19_1 or 0))
end

function var_0_13._onClick(arg_20_0)
	local var_20_0 = arg_20_0._staticData.onClickCb

	if var_20_0 then
		var_20_0(arg_20_0)
	end
end

function var_0_13.isCapturing(arg_21_0)
	return arg_21_0:parent():_gm_getCurSelectedDropdownView() == arg_21_0
end

function var_0_13.selectLast(arg_22_0)
	local var_22_0 = arg_22_0:optionCount()
	local var_22_1 = (arg_22_0._curSelectIndex + var_22_0 - 1) % var_22_0

	arg_22_0:_onDropDownChange(var_22_1)

	return arg_22_0:getSelectedValue()
end

function var_0_13.selectNext(arg_23_0)
	local var_23_0 = arg_23_0:optionCount()
	local var_23_1 = (arg_23_0._curSelectIndex + 1) % var_23_0

	arg_23_0:_onDropDownChange(var_23_1)

	return arg_23_0:getSelectedValue()
end

function var_0_13._onDropDownChange(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0:optionCount()

	if var_24_0 <= 0 then
		return
	end

	arg_24_1 = GameUtil.clamp(arg_24_1, 0, var_24_0 - 1)

	if arg_24_0._curSelectIndex == arg_24_1 then
		return
	end

	arg_24_0._curSelectIndex = arg_24_1

	arg_24_0:onUpdateMO()
end

function var_0_13.selectNone(arg_25_0, arg_25_1)
	arg_25_0._curSelectIndex = -1

	arg_25_0:refresh()
end

function var_0_13.selectByValue(arg_26_0, arg_26_1)
	if arg_26_1 == nil then
		arg_26_0:selectNone()

		return
	end

	for iter_26_0, iter_26_1 in ipairs(arg_26_0._valueList) do
		if iter_26_1 == arg_26_1 then
			arg_26_0._curSelectIndex = iter_26_0 - 1

			arg_26_0:refresh()

			return
		end
	end

	arg_26_0:selectNone()
end

function var_0_13.getSelectedValue(arg_27_0)
	return arg_27_0._valueList[arg_27_0._curSelectIndex + 1]
end

function var_0_13.setActive_imgTrans(arg_28_0, arg_28_1)
	GameUtil.setActive01(arg_28_0._imgTrans, arg_28_1)
end

function var_0_13.onDestroyView(arg_29_0, ...)
	RougeSimpleItemBase.onDestroyView(arg_29_0, ...)
end

function var_0_11.V3a1_GaoSiNiao_GameView_register(arg_30_0)
	GMMinusModel.instance:saveOriginalFunc(arg_30_0, "_editableInitView")
	GMMinusModel.instance:saveOriginalFunc(arg_30_0, "addEvents")
	GMMinusModel.instance:saveOriginalFunc(arg_30_0, "removeEvents")
	GMMinusModel.instance:saveOriginalFunc(arg_30_0, "onDestroyView")

	function arg_30_0._editableInitView(arg_31_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_31_0, "_editableInitView", ...)
		arg_31_0:_gm_editableInitView()
		arg_31_0:_gm_onClickSwitchMode()
		UpdateBeat:Add(arg_31_0._gm_onUpdate, arg_31_0)
	end

	function arg_30_0.addEvents(arg_32_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_32_0, "addEvents", ...)
		arg_32_0:_gm_addEvents()
	end

	function arg_30_0.removeEvents(arg_33_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_33_0, "removeEvents", ...)
		arg_33_0:_gm_removeEvents()
	end

	function arg_30_0.onDestroyView(arg_34_0, ...)
		arg_34_0:_gm_onDestroyView()
		GMMinusModel.instance:callOriginalSelfFunc(arg_34_0, "onDestroyView", ...)
	end

	function arg_30_0._gm_cloneMenuBtn(arg_35_0, arg_35_1, arg_35_2)
		local var_35_0 = gohelper.clone(arg_35_0._gm_menuBtnSrcGo, arg_35_0._gm_menuRootGo, arg_35_1)
		local var_35_1 = gohelper.findChildButtonWithAudio(var_35_0, "")
		local var_35_2 = gohelper.findChildText(var_35_0, "txt_Reset")

		var_35_2.text = arg_35_2 or ""

		return var_35_1, var_35_0, var_35_2
	end

	function arg_30_0._gm_cloneHMenuBtn(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
		local var_36_0, var_36_1, var_36_2 = arg_36_0:_gm_cloneMenuBtn(arg_36_1, arg_36_2)
		local var_36_3 = var_36_1.transform

		arg_36_0._gm_menuBtnPosOffsetX = arg_36_0._gm_menuBtnPosOffsetX - 160 + (arg_36_3 or 0)

		local var_36_4 = recthelper.getAnchorX(var_36_3) + arg_36_0._gm_menuBtnPosOffsetX

		recthelper.setAnchorX(var_36_3, var_36_4)

		return var_36_0, var_36_1, var_36_2
	end

	function arg_30_0._gm_cloneVMenuBtn(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
		local var_37_0, var_37_1, var_37_2 = arg_37_0:_gm_cloneMenuBtn(arg_37_1, arg_37_2)
		local var_37_3 = var_37_1.transform

		arg_37_0._gm_menuBtnPosOffsetY = arg_37_0._gm_menuBtnPosOffsetY - 152 + (arg_37_3 or 0)

		local var_37_4 = recthelper.getAnchorY(var_37_3) + arg_37_0._gm_menuBtnPosOffsetY

		recthelper.setAnchorY(var_37_3, var_37_4)

		return var_37_0, var_37_1, var_37_2
	end

	function arg_30_0._gm_createDropdownView(arg_38_0, arg_38_1, ...)
		local var_38_0, var_38_1, var_38_2 = arg_38_0:_gm_cloneHMenuBtn(...)
		local var_38_3 = var_0_13.New({
			parent = arg_38_0,
			baseViewContainer = arg_38_0.viewContainer,
			btnCmp = var_38_0,
			btnText = var_38_2,
			arg_38_1,
			arg_38_1
		})

		var_38_3:init(var_38_1)

		return var_38_3
	end

	function arg_30_0._gm_createBtnTextView_FixedZRot(arg_39_0, arg_39_1)
		local var_39_0, var_39_1, var_39_2 = GMMinusModel.instance:_addBtnText(arg_39_0._gm_rotateEditRootGo)
		local var_39_3 = var_0_12.New({
			parent = arg_39_0,
			baseViewContainer = arg_39_0.viewContainer,
			btnCmp = var_39_0,
			btnText = var_39_1,
			onClickCb = arg_39_1
		})

		var_39_3:init(var_39_2)

		return var_39_3
	end

	function arg_30_0._gm_editableInitView(arg_40_0, ...)
		GMMinusModel.instance:addBtnGM(arg_40_0)

		arg_40_0._gm_menuRootGo = gohelper.create2d(arg_40_0.viewGO, "=== Edit Menu(Right-Top) ===")
		arg_40_0._gm_menuBtnSrcGo = arg_40_0._btnreset.gameObject
		arg_40_0._gm_menuBtnPosOffsetX = 0
		arg_40_0._gm_menuBtnPosOffsetY = 0
		arg_40_0._gm_curSelectedDropdownView = nil
		arg_40_0._gm_editSelectedGridItemObjSet = arg_40_0:getUserDataTb_()
		arg_40_0._gm_saveMapBtn = arg_40_0:_gm_cloneHMenuBtn("=== GM Save Map===", luaLang("room_layoutplan_copy_btn_confirm_txt"))
		arg_40_0._gm_DumpBtn = arg_40_0:_gm_cloneVMenuBtn("=== GM Dump===", "Dump")

		gohelper.addChild(arg_40_0.viewGO, arg_40_0._gm_DumpBtn.gameObject)

		local var_40_0 = {}
		local var_40_1 = {}

		arg_40_0._gm_gridTypeDropdownView = arg_40_0:_gm_createDropdownView(function(arg_41_0)
			arg_41_0:parent():_gm_selectDropdownMenuView(arg_40_0)
		end, "=== GM Grid GridType Dropdown ===", "Grid\nType Edit...", -10)

		arg_40_0._gm_gridTypeDropdownView:setDropdownWidth(200)

		for iter_40_0, iter_40_1 in pairs(GaoSiNiaoEnum.GridType) do
			if iter_40_1 ~= GaoSiNiaoEnum.GridType.__End then
				var_0_1(var_40_0, iter_40_1)
			end
		end

		table.sort(var_40_0, function(arg_42_0, arg_42_1)
			return arg_42_0 < arg_42_1
		end)

		for iter_40_2, iter_40_3 in ipairs(var_40_0) do
			var_0_1(var_40_1, GaoSiNiaoEnum._edit_nameOfGridType(iter_40_3))
		end

		arg_40_0._gm_gridTypeDropdownView:setOptionList(var_40_0, var_40_1)

		local var_40_2 = {}
		local var_40_3 = {}

		arg_40_0._gm_gridPathSpriteDropdownView = arg_40_0:_gm_createDropdownView("=== GM Grid Path Dropdown ===", "Grid\nPath Edit...", -50)

		arg_40_0._gm_gridPathSpriteDropdownView:setDropdownWidth(200)

		for iter_40_4, iter_40_5 in pairs(GaoSiNiaoEnum.PathSpriteId) do
			if iter_40_5 ~= GaoSiNiaoEnum.PathSpriteId.__End and iter_40_5 ~= GaoSiNiaoEnum.PathSpriteId.None then
				var_0_1(var_40_2, iter_40_5)
			end
		end

		table.sort(var_40_2, function(arg_43_0, arg_43_1)
			return arg_43_0 < arg_43_1
		end)

		for iter_40_6, iter_40_7 in ipairs(var_40_2) do
			var_0_1(var_40_3, GaoSiNiaoEnum.rPathSpriteId[iter_40_7])
		end

		arg_40_0._gm_gridPathSpriteDropdownView:setOptionList(var_40_2, var_40_3)

		arg_40_0._gm_simageMaskClick = gohelper.getClick(arg_40_0._simageMask.gameObject)
		arg_40_0._gm_simageFullBGClick = gohelper.getClick(arg_40_0._simageFullBG.gameObject)
		arg_40_0._gm_rotateEditRootGo = gohelper.create2d(arg_40_0.viewGO, "=== Edit Rotate(Mid-Right) ===")
		arg_40_0._gm_rotateZ0 = arg_40_0:_gm_createBtnTextView_FixedZRot(function(arg_44_0)
			arg_44_0:parent():_gm_onClickFixedRot(0)
		end)

		arg_40_0._gm_rotateZ0:setText("0°")
		UIDockingHelper.setDock(UIDockingHelper.Dock.MB_D, arg_40_0._gm_rotateZ0:transform(), arg_40_0._gm_saveMapBtn.transform, 0, -20)

		arg_40_0._gm_rotateZ_90 = arg_40_0:_gm_createBtnTextView_FixedZRot(function(arg_45_0)
			arg_45_0:parent():_gm_onClickFixedRot(-90)
		end)

		arg_40_0._gm_rotateZ_90:setText("-90°")
		UIDockingHelper.setDock(UIDockingHelper.Dock.ML_L, arg_40_0._gm_rotateZ_90:transform(), arg_40_0._gm_rotateZ0:transform(), -20)

		arg_40_0._gm_rotateZ90 = arg_40_0:_gm_createBtnTextView_FixedZRot(function(arg_46_0)
			arg_46_0:parent():_gm_onClickFixedRot(90)
		end)

		arg_40_0._gm_rotateZ90:setText("90°")
		UIDockingHelper.setDock(UIDockingHelper.Dock.MB_D, arg_40_0._gm_rotateZ90:transform(), arg_40_0._gm_rotateZ0:transform(), 0, -20)

		arg_40_0._gm_rotateZ180 = arg_40_0:_gm_createBtnTextView_FixedZRot(function(arg_47_0)
			arg_47_0:parent():_gm_onClickFixedRot(180)
		end)

		arg_40_0._gm_rotateZ180:setText("180°")
		UIDockingHelper.setDock(UIDockingHelper.Dock.MB_D, arg_40_0._gm_rotateZ180:transform(), arg_40_0._gm_rotateZ_90:transform(), 0, -20)
	end

	function arg_30_0._gm_onClickFixedRot(arg_48_0, arg_48_1)
		arg_48_0:_gm_edit_selectedZRot(arg_48_1)
	end

	function arg_30_0._gm_edit_selectedZRot(arg_49_0, arg_49_1)
		arg_49_1 = arg_49_1 % 360

		arg_49_0:_gm_edit_selectedProp("zRot", arg_49_1)
	end

	function arg_30_0._gm_edit_selectGridType(arg_50_0, arg_50_1)
		arg_50_0:_gm_edit_selectedProp("type", arg_50_1)
	end

	function arg_30_0._gm_edit_selectPathType(arg_51_0, arg_51_1)
		arg_51_0:_gm_edit_selectedProp("ePathType", arg_51_1)
	end

	function arg_30_0._gm_edit_selectedProp(arg_52_0, arg_52_1, arg_52_2)
		for iter_52_0, iter_52_1 in pairs(arg_52_0._gm_editSelectedGridItemObjSet) do
			if iter_52_1 and iter_52_0 then
				iter_52_0._mo[arg_52_1] = arg_52_2

				iter_52_0:_gm_FlashHighLight()
			end
		end
	end

	function arg_30_0._gm_addEvents(arg_53_0)
		GMMinusModel.instance:btnGM_AddClickListener(arg_53_0)
		arg_53_0._gm_saveMapBtn:AddClickListener(arg_53_0._gm_saveMapBtnOnClick, arg_53_0)
		arg_53_0._gm_DumpBtn:AddClickListener(arg_53_0._gm_DumpBtnOnClick, arg_53_0)
		arg_53_0._gm_simageMaskClick:AddClickListener(arg_53_0._gm_onClick_simageMaskClick, arg_53_0)
		arg_53_0._gm_simageFullBGClick:AddClickListener(arg_53_0._gm_onClick_simageMaskClick, arg_53_0)
		GM_V3a1_GaoSiNiao_GameViewContainer.addEvents(arg_53_0)
	end

	function arg_30_0._gm_removeEvents(arg_54_0)
		GMMinusModel.instance:btnGM_RemoveClickListener(arg_54_0)
		arg_54_0._gm_saveMapBtn:RemoveClickListener()
		arg_54_0._gm_DumpBtn:RemoveClickListener()
		arg_54_0._gm_simageMaskClick:RemoveClickListener()
		arg_54_0._gm_simageFullBGClick:RemoveClickListener()
		GM_V3a1_GaoSiNiao_GameViewContainer.removeEvents(arg_54_0)
	end

	function arg_30_0._gm_selectDropdownMenuView(arg_55_0, arg_55_1)
		if arg_55_0._gm_curSelectedDropdownView then
			arg_55_0._gm_curSelectedDropdownView:setActive_imgTrans(false)
		end

		arg_55_0._gm_curSelectedDropdownView = arg_55_1

		if arg_55_1 then
			arg_55_1:setActive_imgTrans(true)
		end
	end

	function arg_30_0._gm_getCurSelectedDropdownView(arg_56_0)
		return arg_56_0._gm_curSelectedDropdownView
	end

	function arg_30_0._gm_onDestroyView(arg_57_0)
		UpdateBeat:Remove(arg_57_0._gm_onUpdate, arg_57_0)
		GameUtil.onDestroyViewMember(arg_57_0, "_gm_gridTypeDropdownView")
		GameUtil.onDestroyViewMember(arg_57_0, "_gm_gridPathSpriteDropdownView")
		GameUtil.onDestroyViewMember(arg_57_0, "_gm_rotateZ0")
		GameUtil.onDestroyViewMember(arg_57_0, "_gm_rotateZ90")
		GameUtil.onDestroyViewMember(arg_57_0, "_gm_rotateZ_90")
		GameUtil.onDestroyViewMember(arg_57_0, "_gm_rotateZ180")
	end

	function arg_30_0._gm_onClickSwitchMode(arg_58_0)
		local var_58_0 = var_0_11.s_isEditMode

		GaoSiNiaoTesting.instance:cSwitchMode(var_58_0)
		arg_58_0:_gm_refresh()
	end

	function arg_30_0._gm_refresh(arg_59_0)
		arg_59_0:_gm_refreshBagList()
		arg_59_0:_gm_refreshGridList()
		gohelper.setActive(arg_59_0._gm_menuRootGo, var_0_11.s_isEditMode)
		gohelper.setActive(arg_59_0._gm_rotateEditRootGo, var_0_11.s_isEditMode)
		arg_59_0:_gm_refreshActive_gridPathSpriteDropdownView()
	end

	function arg_30_0._gm_refreshActive_gridPathSpriteDropdownView(arg_60_0)
		local var_60_0 = arg_60_0._gm_gridTypeDropdownView:getSelectedValue()
		local var_60_1 = var_60_0 == GaoSiNiaoEnum.GridType.Path or var_60_0 == GaoSiNiaoEnum.GridType._edit_BagPath

		arg_60_0._gm_gridPathSpriteDropdownView:setActive(var_60_1)
	end

	function arg_30_0._gm_refreshBagList(arg_61_0)
		arg_61_0._tmpBagDataList = nil

		arg_61_0:_refreshBagList()
	end

	function arg_30_0._gm_refreshGridList(arg_62_0)
		arg_62_0._tmpGridDataList = nil

		arg_62_0:_refreshGridList()
	end

	function arg_30_0._gm_saveMapBtnOnClick(arg_63_0)
		if not var_0_11.s_isEditMode then
			logError("Invalid Operator: _gm_saveMapBtnOnClick")

			return
		end

		arg_63_0:_gm_selectDropdownMenuView(nil)
		arg_63_0.viewContainer:mapMO():_edit_confirmSaveOrNot()
	end

	function arg_30_0._gm_DumpBtnOnClick(arg_64_0)
		arg_64_0:_gm_selectDropdownMenuView(nil)

		local var_64_0 = {}

		GaoSiNiaoBattleModel.instance:dump(var_64_0)
		logError(table.concat(var_64_0, "\n"))
	end

	function arg_30_0._gm_onUpdate(arg_65_0)
		if var_0_11.s_isEditMode then
			return arg_65_0:_gm_edit_onUpdate()
		end

		local var_65_0 = var_0_2.GetKey(var_0_3.LeftControl)
		local var_65_1 = var_0_2.GetKey(var_0_3.RightControl)

		if (var_65_0 or var_65_1) and var_0_2.GetKeyDown(var_0_3.W) then
			arg_65_0:_dragContext():_critical_beforeClear()
			GaoSiNiaoController.instance:completeGame()
		end
	end

	function arg_30_0._gm_edit_onUpdate(arg_66_0)
		local var_66_0 = var_0_2.GetKey(var_0_3.LeftAlt)
		local var_66_1 = var_0_2.GetKey(var_0_3.RightAlt)
		local var_66_2

		var_66_2 = var_66_0 or var_66_1

		local var_66_3 = var_0_2.GetKey(var_0_3.LeftShift)
		local var_66_4 = var_0_2.GetKey(var_0_3.RightShift)
		local var_66_5

		var_66_5 = var_66_3 or var_66_4

		local var_66_6 = var_0_2.GetKey(var_0_3.LeftControl)
		local var_66_7 = var_0_2.GetKey(var_0_3.RightControl)
		local var_66_8

		var_66_8 = var_66_6 or var_66_7

		if arg_66_0._gm_curSelectedDropdownView then
			if var_0_2.GetKeyDown(var_0_3.UpArrow) then
				local var_66_9 = arg_66_0._gm_curSelectedDropdownView:selectLast()

				if arg_66_0._gm_gridTypeDropdownView:isCapturing() then
					arg_66_0:_gm_refreshActive_gridPathSpriteDropdownView()
				elseif arg_66_0._gm_gridPathSpriteDropdownView:isCapturing() then
					-- block empty
				end

				return
			elseif var_0_2.GetKeyDown(var_0_3.DownArrow) then
				local var_66_10 = arg_66_0._gm_curSelectedDropdownView:selectNext()

				if arg_66_0._gm_gridTypeDropdownView:isCapturing() then
					arg_66_0:_gm_refreshActive_gridPathSpriteDropdownView()
				elseif arg_66_0._gm_gridPathSpriteDropdownView:isCapturing() then
					-- block empty
				end

				return
			elseif var_0_2.GetKeyDown(var_0_3.KeypadEnter) or var_0_2.GetKeyDown(var_0_3.Return) or var_0_2.GetKeyDown(var_0_3.Escape) then
				arg_66_0:_gm_selectDropdownMenuView(nil)

				return
			end
		end
	end

	function arg_30_0._gm_onClick_simageMaskClick(arg_67_0)
		if var_0_2.GetMouseButtonUp(0) then
			arg_67_0:_gm_selectDropdownMenuView(nil)
		end
	end

	function arg_30_0._gm_showAllTabIdUpdate(arg_68_0)
		return
	end

	function arg_30_0._gm_reSeletedGridItemObj(arg_69_0, arg_69_1)
		local var_69_0 = arg_69_0._gm_editSelectedGridItemObjSet[arg_69_1]

		var_69_0 = var_69_0 == nil and true or not var_69_0
		arg_69_0._gm_editSelectedGridItemObjSet[arg_69_1] = var_69_0

		arg_69_1:onShowSelected(var_69_0)

		local var_69_1

		for iter_69_0, iter_69_1 in pairs(arg_69_0._gm_editSelectedGridItemObjSet) do
			local var_69_2 = iter_69_0:getType()

			if var_69_1 == nil then
				var_69_1 = var_69_2
			elseif var_69_1 ~= var_69_2 then
				var_69_1 = false

				break
			end
		end

		if var_69_1 then
			arg_69_0._gm_gridTypeDropdownView:selectByValue(var_69_1)
		else
			arg_69_0._gm_gridTypeDropdownView:selectNone()
		end

		arg_69_0:_gm_refreshActive_gridPathSpriteDropdownView()
	end

	function arg_30_0._gm_singleSeletedGridItemObj(arg_70_0, arg_70_1)
		arg_70_0:_gm_clearAllSeletedGridItemObj()

		arg_70_0._gm_editSelectedGridItemObjSet[arg_70_1] = true

		arg_70_1:onShowSelected(true)
		arg_70_0._gm_gridTypeDropdownView:selectByValue(arg_70_1:getType())
		arg_70_0:_gm_refreshActive_gridPathSpriteDropdownView()
	end

	function arg_30_0._gm_clearAllSeletedGridItemObj(arg_71_0)
		for iter_71_0, iter_71_1 in pairs(arg_71_0._gm_editSelectedGridItemObjSet) do
			arg_71_0._gm_editSelectedGridItemObjSet[iter_71_0] = false

			iter_71_0:onShowSelected(false)
		end

		arg_71_0._gm_gridTypeDropdownView:selectNone()
		arg_71_0:_gm_refreshActive_gridPathSpriteDropdownView()
	end
end

function var_0_11.V3a1_GaoSiNiao_GameView_BagItem_register(arg_72_0)
	GMMinusModel.instance:saveOriginalFunc(arg_72_0, "_editableInitView")
	GMMinusModel.instance:saveOriginalFunc(arg_72_0, "addEvents")
	GMMinusModel.instance:saveOriginalFunc(arg_72_0, "removeEvents")
	GMMinusModel.instance:saveOriginalFunc(arg_72_0, "_onBeginDrag")
	GMMinusModel.instance:saveOriginalFunc(arg_72_0, "_onDragging")
	GMMinusModel.instance:saveOriginalFunc(arg_72_0, "_onEndDrag")

	function arg_72_0._editableInitView(arg_73_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_73_0, "_editableInitView", ...)

		arg_73_0._gm_gocontentClick = gohelper.getClick(arg_73_0._gocontent)
	end

	function arg_72_0.addEvents(arg_74_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_74_0, "addEvents", ...)
		arg_74_0._gm_gocontentClick:AddClickListener(arg_74_0._gm_onClick_gocontent, arg_74_0)
	end

	function arg_72_0.removeEvents(arg_75_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_75_0, "removeEvents", ...)
		GameUtil.onDestroyViewMember_ClickListener(arg_75_0, "_gm_gocontentClick")
	end

	function arg_72_0._onBeginDrag(arg_76_0, arg_76_1, ...)
		if var_0_11.s_isEditMode then
			return
		end

		GMMinusModel.instance:callOriginalSelfFunc(arg_76_0, "_onBeginDrag", arg_76_1, ...)
	end

	function arg_72_0._onDragging(arg_77_0, arg_77_1, ...)
		if var_0_11.s_isEditMode then
			return
		end

		GMMinusModel.instance:callOriginalSelfFunc(arg_77_0, "_onDragging", arg_77_1, ...)
	end

	function arg_72_0._onEndDrag(arg_78_0, arg_78_1, ...)
		if var_0_11.s_isEditMode then
			return
		end

		GMMinusModel.instance:callOriginalSelfFunc(arg_78_0, "_onEndDrag", arg_78_1, ...)
	end

	function arg_72_0._gm_onClick_gocontent(arg_79_0)
		if not var_0_11.s_isEditMode then
			return
		end

		local var_79_0 = var_0_2.GetKey(var_0_3.LeftAlt)
		local var_79_1 = var_0_2.GetKey(var_0_3.RightAlt)
		local var_79_2 = var_79_0 or var_79_1
		local var_79_3 = arg_79_0:getCount()

		if var_79_2 then
			var_79_3 = var_79_3 - 1
		else
			var_79_3 = var_79_3 + 1
		end

		arg_79_0:setCount(math.max(var_79_3, 0))

		arg_79_0._mo.count = arg_79_0:getCount()
	end
end

function var_0_11.V3a1_GaoSiNiao_GameView_GridItem_register(arg_80_0)
	GMMinusModel.instance:saveOriginalFunc(arg_80_0, "_editableInitView")
	GMMinusModel.instance:saveOriginalFunc(arg_80_0, "addEvents")
	GMMinusModel.instance:saveOriginalFunc(arg_80_0, "removeEvents")
	GMMinusModel.instance:saveOriginalFunc(arg_80_0, "_onBeginDrag")
	GMMinusModel.instance:saveOriginalFunc(arg_80_0, "_onDragging")
	GMMinusModel.instance:saveOriginalFunc(arg_80_0, "_onEndDrag")

	function arg_80_0._editableInitView(arg_81_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_81_0, "_editableInitView", ...)

		arg_81_0._gm_viewGOClick = gohelper.getClick(arg_81_0.viewGO)
	end

	function arg_80_0.addEvents(arg_82_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_82_0, "addEvents", ...)
		arg_82_0._gm_viewGOClick:AddClickListener(arg_82_0._gm_onClick_viewGO, arg_82_0)
	end

	function arg_80_0.removeEvents(arg_83_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_83_0, "removeEvents", ...)
		arg_83_0._gm_viewGOClick:RemoveClickListener()
	end

	function arg_80_0._gm_onClick_viewGO(arg_84_0)
		if not var_0_11.s_isEditMode then
			return
		end

		local var_84_0 = var_0_2.GetKey(var_0_3.LeftControl)
		local var_84_1 = var_0_2.GetKey(var_0_3.RightControl)
		local var_84_2 = var_84_0 or var_84_1
		local var_84_3 = arg_84_0:parent()

		if var_84_2 then
			var_84_3:_gm_reSeletedGridItemObj(arg_84_0)
		else
			var_84_3:_gm_singleSeletedGridItemObj(arg_84_0)
		end
	end
end

function var_0_11.onInitView(arg_85_0)
	arg_85_0._btnClose = gohelper.findChildButtonWithAudio(arg_85_0.viewGO, "btnClose")
	arg_85_0._item1Toggle = gohelper.findChildToggle(arg_85_0.viewGO, "viewport/content/item1/Toggle")
	arg_85_0._item2Btn = gohelper.findChildButtonWithAudio(arg_85_0.viewGO, "viewport/content/item2/Button")
	arg_85_0._item2Btn_Text1Go = gohelper.findChild(arg_85_0.viewGO, "viewport/content/item2/Button/Label1")
	arg_85_0._item2Btn_Text2Go = gohelper.findChild(arg_85_0.viewGO, "viewport/content/item2/Button/Label2")
	arg_85_0._item3Btn = gohelper.findChildButtonWithAudio(arg_85_0.viewGO, "viewport/content/item3/Button")
end

function var_0_11.addEvents(arg_86_0)
	arg_86_0._btnClose:AddClickListener(arg_86_0.closeThis, arg_86_0)
	arg_86_0._item1Toggle:AddOnValueChanged(arg_86_0._onItem1ToggleValueChanged, arg_86_0)
	arg_86_0._item2Btn:AddClickListener(arg_86_0._onItem2Click, arg_86_0)
	arg_86_0._item3Btn:AddClickListener(arg_86_0._onItem3Click, arg_86_0)
end

function var_0_11.removeEvents(arg_87_0)
	arg_87_0._btnClose:RemoveClickListener()
	arg_87_0._item1Toggle:RemoveOnValueChanged()
	arg_87_0._item2Btn:RemoveClickListener()
	arg_87_0._item3Btn:RemoveClickListener()
end

function var_0_11.onUpdateParam(arg_88_0)
	arg_88_0:refresh()
end

function var_0_11.onOpen(arg_89_0)
	arg_89_0:onUpdateParam()
end

function var_0_11.refresh(arg_90_0)
	arg_90_0:_refreshItem1()
	arg_90_0:_refreshItem2()
	arg_90_0:_refreshItem3()
end

function var_0_11.onDestroyView(arg_91_0)
	return
end

var_0_11.s_ShowAllTabId = false

function var_0_11._refreshItem1(arg_92_0)
	local var_92_0 = var_0_11.s_ShowAllTabId

	arg_92_0._item1Toggle.isOn = var_92_0
end

function var_0_11._onItem1ToggleValueChanged(arg_93_0)
	local var_93_0 = arg_93_0._item1Toggle.isOn

	var_0_11.s_ShowAllTabId = var_93_0

	GMController.instance:dispatchEvent(GMEvent.V3a1_GaoSiNiao_GameView_ShowAllTabIdUpdate, var_93_0)
end

var_0_11.s_isEditMode = false

function var_0_11._refreshItem2(arg_94_0)
	local var_94_0 = var_0_11.s_isEditMode

	gohelper.setActive(arg_94_0._item2Btn_Text1Go, not var_94_0)
	gohelper.setActive(arg_94_0._item2Btn_Text2Go, var_94_0)
end

function var_0_11._onItem2Click(arg_95_0)
	var_0_11.s_isEditMode = not var_0_11.s_isEditMode

	GMController.instance:dispatchEvent(GMEvent.V3a1_GaoSiNiao_GameView_OnClickSwitchMode)
	arg_95_0:_refreshItem2()
end

function var_0_11._refreshItem3(arg_96_0)
	return
end

function var_0_11._onItem3Click(arg_97_0)
	GMController.instance:dispatchEvent(GMEvent.V3a1_GaoSiNiao_GameView_OnClickDump)
end

return var_0_11
