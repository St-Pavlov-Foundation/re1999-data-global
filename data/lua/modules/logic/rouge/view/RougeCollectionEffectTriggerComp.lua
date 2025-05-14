module("modules.logic.rouge.view.RougeCollectionEffectTriggerComp", package.seeall)

local var_0_0 = class("RougeCollectionEffectTriggerComp", BaseView)

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
	arg_4_0:addEventCb(RougeCollectionChessController.instance, RougeEvent.PlaceCollection2SlotArea, arg_4_0.placeCollection2SlotAreaSucc, arg_4_0)

	arg_4_0._poolComp = arg_4_0.viewContainer:getRougePoolComp()
	arg_4_0._effectTab = arg_4_0:getUserDataTb_()
	arg_4_0._collectionMap = arg_4_0:getUserDataTb_()
end

function var_0_0.onOpenFinish(arg_5_0)
	if not RougeCollectionModel.instance:checkHasTmpTriggerEffectInfo() then
		return
	end

	arg_5_0:init()
end

local var_0_1 = 2

function var_0_0.placeCollection2SlotAreaSucc(arg_6_0, arg_6_1)
	if not arg_6_1 then
		return
	end

	local var_6_0 = arg_6_1.id
	local var_6_1 = arg_6_1:getCenterSlotPos()
	local var_6_2 = arg_6_1:getRotation()
	local var_6_3 = arg_6_1.cfgId
	local var_6_4 = RougeCollectionConfig.instance:getRotateEditorParam(var_6_3, var_6_2, RougeEnum.CollectionEditorParamType.Effect)
	local var_6_5 = FlowSequence.New()

	var_6_5:addWork(FunctionWork.New(function()
		arg_6_0:recycleEffectGOs(var_6_0, RougeEnum.CollectionArtType.Place)
		arg_6_0:recycleEffectGOs(var_6_0, RougeEnum.CollectionArtType.Effect)
	end))
	var_6_5:addWork(FunctionWork.New(arg_6_0.shapeTriggerForeachCollectionCells, arg_6_0, arg_6_1))
	var_6_5:addWork(FunctionWork.New(function()
		arg_6_0:playCellEffect(var_6_0, var_6_4, var_6_1, RougeEnum.CollectionArtType.Effect)
	end))
	var_6_5:addWork(WorkWaitSeconds.New(var_0_1))
	var_6_5:addWork(FunctionWork.New(function()
		arg_6_0:recycleEffectGOs(var_6_0, RougeEnum.CollectionArtType.Place)
		arg_6_0:recycleEffectGOs(var_6_0, RougeEnum.CollectionArtType.Effect)
	end))
	var_6_5:start()
end

function var_0_0.shapeTriggerForeachCollectionCells(arg_10_0, arg_10_1)
	RougeCollectionHelper.foreachCollectionCells(arg_10_1, arg_10_0.collectionCellsEffectExcuteFunc, arg_10_0, RougeEnum.CollectionArtType.Place)
end

function var_0_0.playCellEffect(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	arg_11_0:recycleEffectGOs(arg_11_1, arg_11_4)

	for iter_11_0, iter_11_1 in ipairs(arg_11_2) do
		local var_11_0 = RougeCollectionHelper.getCollectionCellSlotPos(arg_11_3, iter_11_1)

		arg_11_0:playSlotCellEffect(arg_11_1, var_11_0, arg_11_4)
	end
end

function var_0_0.recycleEffectGOs(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0._effectTab and arg_12_0._effectTab[arg_12_1]

	if var_12_0 and var_12_0[arg_12_2] then
		for iter_12_0 = #var_12_0[arg_12_2], 1, -1 do
			local var_12_1 = var_12_0[arg_12_2][iter_12_0]

			arg_12_0._poolComp:recycleEffectItem(arg_12_2, var_12_1)
			table.remove(var_12_0[arg_12_2], iter_12_0)
		end
	end
end

function var_0_0.checkIsSlotPosInSlotArea(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = RougeCollectionModel.instance:getCurSlotAreaSize()

	if arg_13_1 >= 0 and arg_13_1 < var_13_0.col and arg_13_2 >= 0 and arg_13_2 < var_13_0.row then
		return true
	end
end

local var_0_2 = 1.5

function var_0_0.init(arg_14_0)
	local var_14_0 = RougeCollectionModel.instance:getTmpCollectionTriggerEffectInfo()

	if not var_14_0 then
		return
	end

	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("RougeCollectionEffectTriggerComp_PlayEffect")

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		arg_14_0:excuteActiveEffect(iter_14_1)
	end

	TaskDispatcher.cancelTask(arg_14_0._endUIBlock, arg_14_0)
	TaskDispatcher.runDelay(arg_14_0._endUIBlock, arg_14_0, var_0_2)
end

function var_0_0._endUIBlock(arg_15_0)
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("RougeCollectionEffectTriggerComp_PlayEffect")
end

function var_0_0.excuteActiveEffect(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1.showType

	arg_16_0:executeEffectCmd(arg_16_1, var_16_0)
end

function var_0_0.executeEffectCmd(arg_17_0, arg_17_1, arg_17_2)
	if not arg_17_1 then
		return
	end

	local var_17_0 = arg_17_0:tryGetExecuteEffectFunc(arg_17_2)

	if not var_17_0 then
		logError(string.format("无法找到肉鸽造物效果表现执行方法,效果id = %s, 造物uid = %s", arg_17_2, arg_17_1.trigger.id))

		return
	end

	var_17_0(arg_17_0, arg_17_1)
end

function var_0_0.tryGetExecuteEffectFunc(arg_18_0, arg_18_1)
	if not arg_18_0._effectExcuteFuncTab then
		arg_18_0._effectExcuteFuncTab = {
			[RougeEnum.EffectTriggerType.Engulf] = arg_18_0.engulfEffectFunc,
			[RougeEnum.EffectTriggerType.LevelUp] = arg_18_0.levelUpEffectFunc
		}
	end

	return arg_18_0._effectExcuteFuncTab[arg_18_1]
end

function var_0_0.levelUpEffectFunc(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_1.removeCollections
	local var_19_1 = arg_19_1.trigger

	if var_19_0 then
		for iter_19_0, iter_19_1 in ipairs(var_19_0) do
			arg_19_0:levelupEffectCollectionFunc(var_19_1, iter_19_1)
		end
	end
end

function var_0_0.levelupEffectCollectionFunc(arg_20_0, arg_20_1, arg_20_2)
	if not arg_20_1 or not arg_20_2 then
		return
	end

	local var_20_0, var_20_1 = RougeCollectionHelper.getTwoCollectionConnectCell(arg_20_1, arg_20_2)

	if not var_20_0 or not var_20_1 then
		return
	end

	local var_20_2 = FlowSequence.New()
	local var_20_3 = FlowParallel.New()

	var_20_3:addWork(FunctionWork.New(arg_20_0.levelupTriggerForeachCollectionCells, arg_20_0, arg_20_1))
	var_20_3:addWork(FunctionWork.New(arg_20_0.levelupTriggerForeachCollectionCells, arg_20_0, arg_20_2))
	var_20_3:addWork(FunctionWork.New(function()
		arg_20_0:drawTriggerLine(arg_20_1, arg_20_2, RougeEnum.CollectionArtType.LevelUPTrigger2)
	end))
	var_20_2:addWork(var_20_3)
	var_20_2:addWork(WorkWaitSeconds.New(var_0_2))
	var_20_2:addWork(FunctionWork.New(function()
		arg_20_0:recycleEffectGOs(arg_20_1.id, RougeEnum.CollectionArtType.LevelUPTrigger1)
	end))
	var_20_2:addWork(FunctionWork.New(function()
		arg_20_0:recycleEffectGOs(arg_20_2.id, RougeEnum.CollectionArtType.LevelUPTrigger1)
	end))
	var_20_2:addWork(FunctionWork.New(function()
		arg_20_0:recycleEffectGOs(arg_20_1.id, RougeEnum.CollectionArtType.LevelUPTrigger2)
	end))
	var_20_2:start()
end

function var_0_0.levelupTriggerForeachCollectionCells(arg_25_0, arg_25_1)
	RougeCollectionHelper.foreachCollectionCells(arg_25_1, arg_25_0.collectionCellsEffectExcuteFunc, arg_25_0, RougeEnum.CollectionArtType.LevelUPTrigger1)
end

function var_0_0.collectionCellsEffectExcuteFunc(arg_26_0, arg_26_1, arg_26_2, arg_26_3, arg_26_4)
	local var_26_0 = arg_26_1:getLeftTopPos()
	local var_26_1 = Vector2(var_26_0.x + arg_26_3 - 1, var_26_0.y + arg_26_2 - 1)

	arg_26_0:playSlotCellEffect(arg_26_1.id, var_26_1, arg_26_4)
end

function var_0_0.drawTriggerLine(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	local var_27_0, var_27_1 = RougeCollectionHelper.getTwoCollectionConnectCell(arg_27_1, arg_27_2)

	if not var_27_0 or not var_27_1 then
		return
	end

	local var_27_2 = arg_27_0:getDrawLineDirection(var_27_0, var_27_1)
	local var_27_3, var_27_4 = RougeCollectionHelper.slotPos2AnchorPos(var_27_0)
	local var_27_5 = arg_27_0:getAndSaveEffectItem(arg_27_1.id, arg_27_3)

	recthelper.setAnchor(var_27_5.transform, var_27_3, var_27_4)
	gohelper.setActive(var_27_5.gameObject, true)
	arg_27_0:setLineDirection(var_27_5, var_27_2)
end

function var_0_0.getDrawLineDirection(arg_28_0, arg_28_1, arg_28_2)
	if not arg_28_1 or not arg_28_2 then
		return
	end

	if arg_28_2.y > arg_28_1.y then
		return RougeEnum.SlotCellDirection.Bottom
	elseif arg_28_2.y < arg_28_1.y then
		return RougeEnum.SlotCellDirection.Top
	elseif arg_28_2.x > arg_28_1.x then
		return RougeEnum.SlotCellDirection.Right
	else
		return RougeEnum.SlotCellDirection.Left
	end
end

function var_0_0.setLineDirection(arg_29_0, arg_29_1, arg_29_2)
	if not arg_29_1 then
		return
	end

	for iter_29_0 = arg_29_1.transform.childCount, 1, -1 do
		gohelper.setActive(arg_29_1.transform:GetChild(iter_29_0 - 1).gameObject, false)
	end

	local var_29_0

	if arg_29_2 == RougeEnum.SlotCellDirection.Left then
		var_29_0 = arg_29_1.transform:Find("left")
	elseif arg_29_2 == RougeEnum.SlotCellDirection.Right then
		var_29_0 = arg_29_1.transform:Find("right")
	elseif arg_29_2 == RougeEnum.SlotCellDirection.Top then
		var_29_0 = arg_29_1.transform:Find("top")
	else
		var_29_0 = arg_29_1.transform:Find("down")
	end

	if var_29_0 then
		gohelper.setActive(var_29_0.gameObject, true)
	end
end

function var_0_0.playSlotCellEffect(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	if not arg_30_1 or not arg_30_2 or not arg_30_3 then
		return
	end

	if not arg_30_0:checkIsSlotPosInSlotArea(arg_30_2.x, arg_30_2.y) then
		return
	end

	local var_30_0 = arg_30_0:getAndSaveEffectItem(arg_30_1, arg_30_3)
	local var_30_1, var_30_2 = RougeCollectionHelper.slotPos2AnchorPos(arg_30_2)

	gohelper.setActive(var_30_0, true)
	recthelper.setAnchor(var_30_0.transform, var_30_1, var_30_2)
end

function var_0_0.getAndSaveEffectItem(arg_31_0, arg_31_1, arg_31_2)
	if not arg_31_1 or not arg_31_2 then
		return
	end

	local var_31_0 = arg_31_0._poolComp:getEffectItem(arg_31_2)
	local var_31_1 = arg_31_0._effectTab and arg_31_0._effectTab[arg_31_1]

	if not (var_31_1 and var_31_1[arg_31_2]) then
		arg_31_0._effectTab = arg_31_0._effectTab or arg_31_0:getUserDataTb_()
		arg_31_0._effectTab[arg_31_1] = arg_31_0._effectTab[arg_31_1] or arg_31_0:getUserDataTb_()
		arg_31_0._effectTab[arg_31_1][arg_31_2] = arg_31_0:getUserDataTb_()
	end

	table.insert(arg_31_0._effectTab[arg_31_1][arg_31_2], var_31_0)

	return var_31_0
end

function var_0_0.setCollectionsVisible(arg_32_0, arg_32_1, arg_32_2)
	if not arg_32_1 then
		return
	end

	for iter_32_0, iter_32_1 in pairs(arg_32_1) do
		RougeCollectionChessController.instance:dispatchEvent(RougeEvent.SetCollectionVisible, iter_32_1, arg_32_2)
	end
end

function var_0_0.getOrCreateTmpCollection(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_0._collectionMap[arg_33_1.id]

	if not var_33_0 then
		var_33_0 = arg_33_0._poolComp:getCollectionItem(RougeCollectionDragItem.__cname)

		var_33_0:onUpdateMO(arg_33_1)
		var_33_0:setShapeCellsVisible(false)
		var_33_0:setHoleToolVisible(true)
		var_33_0:setShowTypeFlagVisible(true)

		arg_33_0._collectionMap[arg_33_1.id] = var_33_0
	end

	return var_33_0
end

function var_0_0.resetTmpCollection(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_0._collectionMap[arg_34_1]

	if not var_34_0 then
		return
	end

	var_34_0:reset()
end

function var_0_0.engulfEffectFunc(arg_35_0, arg_35_1)
	local var_35_0 = arg_35_1.removeCollections
	local var_35_1 = arg_35_1.trigger

	if var_35_0 then
		for iter_35_0, iter_35_1 in ipairs(var_35_0) do
			arg_35_0:engulfEffectCollectionFunc(var_35_1, iter_35_1)
		end
	end
end

function var_0_0.engulfEffectCollectionFunc(arg_36_0, arg_36_1, arg_36_2)
	if not arg_36_1 or not arg_36_2 then
		return
	end

	local var_36_0, var_36_1 = RougeCollectionHelper.getTwoCollectionConnectCell(arg_36_1, arg_36_2)

	if not var_36_0 or not var_36_1 then
		return
	end

	local var_36_2 = FlowSequence.New()
	local var_36_3 = FlowParallel.New()

	var_36_3:addWork(FunctionWork.New(arg_36_0.engulfTriggerForeachCollectionCells, arg_36_0, arg_36_1))
	var_36_3:addWork(FunctionWork.New(arg_36_0.engulfTriggerForeachCollectionCells, arg_36_0, arg_36_2))
	var_36_3:addWork(FunctionWork.New(function()
		arg_36_0:playEngulfCollection(arg_36_2, arg_36_1)
	end))
	var_36_3:addWork(FunctionWork.New(function()
		arg_36_0:drawTriggerLine(arg_36_2, arg_36_1, RougeEnum.CollectionArtType.EngulfTrigger2)
	end))
	var_36_2:addWork(var_36_3)
	var_36_2:addWork(WorkWaitSeconds.New(var_0_2))
	var_36_2:addWork(FunctionWork.New(function()
		arg_36_0:recycleEffectGOs(arg_36_1.id, RougeEnum.CollectionArtType.EngulfTrigger1)
	end))
	var_36_2:addWork(FunctionWork.New(function()
		arg_36_0:recycleEffectGOs(arg_36_2.id, RougeEnum.CollectionArtType.EngulfTrigger1)
	end))
	var_36_2:addWork(FunctionWork.New(function()
		arg_36_0:recycleEffectGOs(arg_36_2.id, RougeEnum.CollectionArtType.EngulfTrigger2)
	end))
	var_36_2:addWork(FunctionWork.New(arg_36_0.resetTmpCollection, arg_36_0, arg_36_2.id))
	var_36_2:start()
end

function var_0_0.engulfTriggerForeachCollectionCells(arg_42_0, arg_42_1)
	RougeCollectionHelper.foreachCollectionCells(arg_42_1, arg_42_0.collectionCellsEffectExcuteFunc, arg_42_0, RougeEnum.CollectionArtType.EngulfTrigger1)
end

function var_0_0.playEngulfCollection(arg_43_0, arg_43_1, arg_43_2)
	if not arg_43_1 or not arg_43_2 then
		return
	end

	local var_43_0 = arg_43_0:getOrCreateTmpCollection(arg_43_1)
	local var_43_1, var_43_2 = RougeCollectionHelper.getTwoCollectionConnectCell(arg_43_1, arg_43_2)

	if not var_43_1 or not var_43_2 then
		return
	end

	local var_43_3 = arg_43_0:getDrawLineDirection(var_43_1, var_43_2)
	local var_43_4 = arg_43_0:getEngulfCollectionAnimStateName(var_43_3)

	var_43_0:playAnim(var_43_4)
	var_43_0:setCollectionInteractable(false)
end

function var_0_0.getEngulfCollectionAnimStateName(arg_44_0, arg_44_1)
	local var_44_0 = "default"

	return arg_44_1 == RougeEnum.SlotCellDirection.Left and "left" or arg_44_1 == RougeEnum.SlotCellDirection.Right and "right" or arg_44_1 == RougeEnum.SlotCellDirection.Top and "top" or "down"
end

function var_0_0.onClose(arg_45_0)
	RougeCollectionModel.instance:clearTmpCollectionTriggerEffectInfo()
	arg_45_0:_endUIBlock()
end

function var_0_0.onDestroyView(arg_46_0)
	if arg_46_0._collectionMap then
		for iter_46_0, iter_46_1 in pairs(arg_46_0._collectionMap) do
			iter_46_1:destroy()
		end
	end

	arg_46_0._poolComp = nil

	TaskDispatcher.cancelTask(arg_46_0._endUIBlock, arg_46_0)
end

return var_0_0
