module("modules.logic.rouge.view.RougeCollectionChessView", package.seeall)

local var_0_0 = class("RougeCollectionChessView", RougeBaseDLCViewComp)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._gomeshContainer = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_meshContainer")
	arg_1_0._goeffectContainer = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_effectContainer")
	arg_1_0._gotriggerContainer = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_triggerContainer")
	arg_1_0._gocellModel = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_dragAnchor/#go_cellModel")
	arg_1_0._golineContainer = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_dragAnchor/#go_lineContainer")
	arg_1_0._godragContainer = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_dragAnchor/#go_dragContainer")
	arg_1_0._btnlayout = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_layout")
	arg_1_0._btnclear = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_left/#btn_clear")
	arg_1_0._btnauto = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_left/#btn_auto")
	arg_1_0._btnoverview = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_left/#btn_overview")
	arg_1_0._btnhandbook = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_left/#btn_handbook")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclear:AddClickListener(arg_2_0._btnclearOnClick, arg_2_0)
	arg_2_0._btnauto:AddClickListener(arg_2_0._btnautoOnClick, arg_2_0)
	arg_2_0._btnoverview:AddClickListener(arg_2_0._btnoverviewOnClick, arg_2_0)
	arg_2_0._btnhandbook:AddClickListener(arg_2_0._btnhandbookOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnlayout:RemoveClickListener()
	arg_3_0._btnclear:RemoveClickListener()
	arg_3_0._btnauto:RemoveClickListener()
	arg_3_0._btnoverview:RemoveClickListener()
	arg_3_0._btnhandbook:RemoveClickListener()
end

function var_0_0._btnclearOnClick(arg_4_0)
	if not RougeCollectionHelper.isCanDragCollection() then
		return
	end

	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.ClearTmpCollection)
	RougeCollectionChessController.instance:onKeyClearCollectionSlotArea()
	AudioMgr.instance:trigger(AudioEnum.UI.OneKeyClearSlotArea)
end

function var_0_0._btnautoOnClick(arg_5_0)
	if not RougeCollectionHelper.isCanDragCollection() then
		return
	end

	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.ClearTmpCollection)
	RougeCollectionChessController.instance:onKeyPlaceCollection2SlotArea()
	AudioMgr.instance:trigger(AudioEnum.UI.OneKeyPlaceSlotArea)
end

function var_0_0._btnoverviewOnClick(arg_6_0)
	RougeController.instance:openRougeCollectionOverView()
end

function var_0_0._btnhandbookOnClick(arg_7_0)
	RougeController.instance:openRougeCollectionHandBookView()
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0:initAllContainerPosition()
	arg_8_0:checkAndSetHandBookIconVisible()
end

function var_0_0.onOpen(arg_9_0)
	var_0_0.super.onOpen(arg_9_0)
	arg_9_0:startCheckCollectionCfgs()
	RougeCollectionChessController.instance:onOpen()
	RougeStatController.instance:startAdjustBackPack()
end

function var_0_0.onClose(arg_10_0)
	RougeStatController.instance:endAdjustBackPack()
end

function var_0_0.startCheckCollectionCfgs(arg_11_0)
	RougeCollectionDebugHelper.checkCollectionStaticItmeCfgs()
	RougeCollectionDebugHelper.checkCollectionDescCfgs()
end

function var_0_0.initAllContainerPosition(arg_12_0)
	local var_12_0 = RougeCollectionHelper.CollectionSlotCellSize
	local var_12_1 = {
		arg_12_0._gomeshContainer,
		arg_12_0._goeffectContainer,
		arg_12_0._gotriggerContainer,
		arg_12_0._gocellModel,
		arg_12_0._golineContainer,
		arg_12_0._godragContainer
	}
	local var_12_2 = Vector2(0, 1)
	local var_12_3 = Vector2(0, 1)
	local var_12_4 = var_12_0.x / 2
	local var_12_5 = -var_12_0.y / 2

	for iter_12_0, iter_12_1 in pairs(var_12_1) do
		recthelper.setSize(iter_12_1.transform, var_12_0.x, var_12_0.y)
		recthelper.setAnchor(iter_12_1.transform, var_12_4, var_12_5)

		iter_12_1.transform.anchorMin = var_12_2
		iter_12_1.transform.anchorMax = var_12_3
	end
end

function var_0_0.checkAndSetHandBookIconVisible(arg_13_0)
	local var_13_0 = RougeOutsideModel.instance:getRougeGameRecord()
	local var_13_1 = false

	if var_13_0 then
		local var_13_2 = lua_rouge_const.configDict[RougeEnum.Const.CompositeEntryVisible]
		local var_13_3 = var_13_2 and tonumber(var_13_2.value) or 0

		var_13_1 = var_13_0:passLayerId(var_13_3)
	end

	gohelper.setActive(arg_13_0._btnhandbook.gameObject, var_13_1)
end

return var_0_0
