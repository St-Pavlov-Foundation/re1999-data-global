module("modules.logic.rouge.common.comp.RougeCollectionSlotComp", package.seeall)

local var_0_0 = class("RougeCollectionSlotComp", UserDataDispose)

function var_0_0.Get(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.New()

	arg_1_1 = arg_1_1 or RougeCollectionHelper.DefaultSlotParam

	var_1_0:init(arg_1_0, arg_1_1)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0:__onInit()

	arg_2_0.params = arg_2_2
	arg_2_0._slotItemLoader = PrefabInstantiate.Create(arg_2_1)

	arg_2_0._slotItemLoader:startLoad(RougeEnum.ResPath.CommonCollectionSlotItem, arg_2_0._onCollectionSlotLoaded, arg_2_0)
end

function var_0_0._onCollectionSlotLoaded(arg_3_0)
	arg_3_0.viewGO = arg_3_0._slotItemLoader:getInstGO()

	arg_3_0:_editableInitView()
	arg_3_0:checkIsNeedUpdate()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._gomeshcontainer = gohelper.findChild(arg_4_0.viewGO, "#go_meshcontainer")
	arg_4_0._gomeshItem = gohelper.findChild(arg_4_0.viewGO, "#go_meshcontainer/#go_meshItem")
	arg_4_0._goplacecontainer = gohelper.findChild(arg_4_0.viewGO, "#go_placecontainer")
	arg_4_0._gochessitem = gohelper.findChild(arg_4_0.viewGO, "#go_placecontainer/#go_chessitem")
	arg_4_0._goeffect = gohelper.findChild(arg_4_0.viewGO, "#go_meshcontainer/#effect")
	arg_4_0._coverCells = arg_4_0:getUserDataTb_()
	arg_4_0._collectionItemMap = arg_4_0:getUserDataTb_()
	arg_4_0._placeCollectionMap = {}

	arg_4_0:addEventCb(RougeCollectionChessController.instance, RougeEvent.PlaceCollection2SlotArea, arg_4_0.placeCollection2SlotArea, arg_4_0)
	arg_4_0:addEventCb(RougeCollectionChessController.instance, RougeEvent.DeleteSlotCollection, arg_4_0.deleteSlotCollection, arg_4_0)
	arg_4_0:addEventCb(RougeCollectionChessController.instance, RougeEvent.GetNewCollections, arg_4_0._onGetNewCollections, arg_4_0)
	arg_4_0:initCellPrefabItem()

	arg_4_0._slotCellTab = arg_4_0:getUserDataTb_()
end

function var_0_0.initCellPrefabItem(arg_5_0)
	if not arg_5_0.params then
		return
	end

	arg_5_0._cellWidth = arg_5_0.params.cellWidth
	arg_5_0._cellHeight = arg_5_0.params.cellHeight

	recthelper.setSize(arg_5_0._gochessitem.transform, arg_5_0._cellWidth, arg_5_0._cellHeight)

	arg_5_0._gridlayout = arg_5_0._gomeshcontainer:GetComponent(gohelper.Type_GridLayoutGroup)
	arg_5_0._gridlayout.cellSize = Vector2(arg_5_0._cellWidth, arg_5_0._cellHeight)

	recthelper.setSize(arg_5_0._goplacecontainer.transform, arg_5_0._cellWidth, arg_5_0._cellHeight)
end

function var_0_0.checkIsNeedUpdate(arg_6_0)
	if arg_6_0._isDirty then
		arg_6_0:start2InitSlot()
	end
end

function var_0_0.onUpdateMO(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if not arg_7_1 or not (arg_7_1 > 0) or not arg_7_2 or not (arg_7_2 > 0) then
		logError(string.format("初始化肉鸽棋盘失败,失败原因:棋盘宽或高不可小于或等于0, col = %s, row = %s", arg_7_1, arg_7_2))

		return
	end

	arg_7_0._placeCollectionMOs = arg_7_3
	arg_7_0._col = arg_7_1
	arg_7_0._row = arg_7_2

	arg_7_0:start2InitSlot()
end

function var_0_0.start2InitSlot(arg_8_0)
	if gohelper.isNil(arg_8_0.viewGO) then
		arg_8_0._isDirty = true

		return
	end

	arg_8_0:initCollectionSlot()
	arg_8_0:initPlaceCollections()

	arg_8_0._isDirty = false
end

function var_0_0.initCollectionSlot(arg_9_0)
	arg_9_0._gridlayout.constraintCount = arg_9_0._col

	for iter_9_0 = 0, arg_9_0._row - 1 do
		for iter_9_1 = 0, arg_9_0._col - 1 do
			arg_9_0:createCollectionSlotCell(iter_9_1, iter_9_0)
		end
	end

	for iter_9_2, iter_9_3 in pairs(arg_9_0._slotCellTab) do
		for iter_9_4, iter_9_5 in pairs(iter_9_3) do
			local var_9_0 = iter_9_2 >= 0 and iter_9_2 < arg_9_0._col and iter_9_4 >= 0 and iter_9_4 < arg_9_0._row

			iter_9_5:setItemVisible(var_9_0)
		end
	end

	local var_9_1 = -(arg_9_0._row / 2 - 0.5) * arg_9_0._cellHeight
	local var_9_2 = (arg_9_0._col / 2 - 0.5) * arg_9_0._cellWidth

	recthelper.setAnchor(arg_9_0._goplacecontainer.transform, var_9_1, var_9_2)
end

function var_0_0.initPlaceCollections(arg_10_0)
	if arg_10_0._placeCollectionMOs then
		for iter_10_0, iter_10_1 in ipairs(arg_10_0._placeCollectionMOs) do
			arg_10_0:placeCollection2SlotArea(iter_10_1)
		end
	end
end

function var_0_0.getCollectionSlotCell(arg_11_0, arg_11_1, arg_11_2)
	return arg_11_0._slotCellTab and arg_11_0._slotCellTab[arg_11_1] and arg_11_0._slotCellTab[arg_11_1][arg_11_2]
end

function var_0_0.createCollectionSlotCell(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0._slotCellTab[arg_12_1] and arg_12_0._slotCellTab[arg_12_1][arg_12_2]

	if not var_12_0 then
		local var_12_1 = gohelper.cloneInPlace(arg_12_0._gomeshItem, string.format("%s_%s", arg_12_1, arg_12_2))

		gohelper.setActive(var_12_1, true)

		var_12_0 = arg_12_0.params.cls.New()

		var_12_0:onInit(var_12_1, arg_12_1, arg_12_2, arg_12_0.params)

		arg_12_0._slotCellTab = arg_12_0._slotCellTab or arg_12_0:getUserDataTb_()
		arg_12_0._slotCellTab[arg_12_1] = arg_12_0._slotCellTab[arg_12_1] or arg_12_0:getUserDataTb_()
		arg_12_0._slotCellTab[arg_12_1][arg_12_2] = var_12_0
	end

	var_12_0:initSlotCellLines()
end

var_0_0.PlayEffectDuration = 0.5

function var_0_0.placeCollection2SlotArea(arg_13_0, arg_13_1, arg_13_2)
	if not arg_13_1 then
		return
	end

	local var_13_0 = arg_13_1 and arg_13_1.id

	if arg_13_0._placeCollectionMap[var_13_0] then
		arg_13_0._placeCollectionMap[var_13_0] = nil
	end

	local var_13_1 = arg_13_1:getRotation()
	local var_13_2 = RougeCollectionConfig.instance:getOrBuildCollectionShapeMap(arg_13_1.cfgId, var_13_1)
	local var_13_3 = arg_13_1:getCenterSlotPos()
	local var_13_4 = RougeCollectionConfig.instance:getRotateEditorParam(arg_13_1.cfgId, var_13_1, RougeEnum.CollectionEditorParamType.Shape)

	arg_13_0:revertCoverCells(arg_13_1.id)

	for iter_13_0, iter_13_1 in ipairs(var_13_4) do
		local var_13_5 = Vector2(iter_13_1.x + var_13_3.x, var_13_3.y - iter_13_1.y)
		local var_13_6 = arg_13_0:getCollectionSlotCell(var_13_5.x, var_13_5.y)

		if var_13_6 then
			local var_13_7 = RougeCollectionHelper.getSlotCellInsideLine(var_13_2, iter_13_1)

			var_13_6:onPlaceCollection(var_13_7)

			arg_13_0._placeCollectionMap[var_13_0] = arg_13_0._placeCollectionMap[var_13_0] or {}
			arg_13_0._coverCells[var_13_0] = arg_13_0._coverCells[var_13_0] or {}

			table.insert(arg_13_0._placeCollectionMap[var_13_0], var_13_5)
			table.insert(arg_13_0._coverCells[var_13_0], var_13_6)
		end
	end

	if arg_13_0.params and arg_13_0.params.showIcon then
		arg_13_0:showCollectionIcon(arg_13_1)
	end
end

function var_0_0.showCollectionIcon(arg_14_0, arg_14_1)
	if not arg_14_1 then
		return
	end

	arg_14_0:getOrCreateCollectionItem(arg_14_1.id):onUpdateMO(arg_14_1)
end

function var_0_0.getOrCreateCollectionItem(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0._collectionItemMap[arg_15_1]

	if not var_15_0 then
		var_15_0 = RougeCollectionBaseSlotItem.New()

		local var_15_1 = gohelper.cloneInPlace(arg_15_0._gochessitem, "item_" .. tostring(arg_15_1))

		var_15_0:onInit(var_15_1)
		var_15_0:setPerCellWidthAndHeight(arg_15_0._cellWidth, arg_15_0._cellHeight)

		arg_15_0._collectionItemMap[arg_15_1] = var_15_0
	end

	return var_15_0
end

function var_0_0.deleteSlotCollection(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0._coverCells and arg_16_0._coverCells[arg_16_1]

	if var_16_0 then
		for iter_16_0, iter_16_1 in ipairs(var_16_0) do
			iter_16_1:revertCellState()
		end

		var_16_0[arg_16_1] = nil
	end
end

function var_0_0._onGetNewCollections(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	if not arg_17_1 or not arg_17_2 then
		return
	end

	if arg_17_3 == RougeEnum.CollectionPlaceArea.SlotArea then
		for iter_17_0, iter_17_1 in ipairs(arg_17_1) do
			local var_17_0 = RougeCollectionModel.instance:getCollectionByUid(iter_17_1)

			RougeCollectionHelper.foreachCollectionCells(var_17_0, arg_17_0._playEffectAfterGetNewSlotCollection, arg_17_0)
		end
	end

	arg_17_0:showGetCollectionEffect()
	AudioMgr.instance:trigger(AudioEnum.UI.CollectionChange)
end

function var_0_0._playEffectAfterGetNewSlotCollection(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = arg_18_1:getLeftTopPos()
	local var_18_1 = var_18_0.x + arg_18_3 - 1
	local var_18_2 = var_18_0.y + arg_18_2 - 1
	local var_18_3 = arg_18_0:getCollectionSlotCell(var_18_1, var_18_2)

	if var_18_3 then
		var_18_3:playGetCollectionEffect()
	end
end

function var_0_0.showGetCollectionEffect(arg_19_0)
	if arg_19_0._isPlayingEffect then
		return
	end

	TaskDispatcher.cancelTask(arg_19_0._delay2HideEffect, arg_19_0)
	TaskDispatcher.runDelay(arg_19_0._delay2HideEffect, arg_19_0, var_0_0.PlayEffectDuration)
	gohelper.setActive(arg_19_0._goeffect, true)

	arg_19_0._isPlayingEffect = true
end

function var_0_0._delay2HideEffect(arg_20_0)
	gohelper.setActive(arg_20_0._goeffect, false)

	arg_20_0._isPlayingEffect = false
end

function var_0_0.revertCoverCells(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0._coverCells and arg_21_0._coverCells[arg_21_1]

	if var_21_0 then
		for iter_21_0, iter_21_1 in pairs(var_21_0) do
			iter_21_1:updateCellState(RougeEnum.LineState.Normal)
		end

		arg_21_0._coverCells[arg_21_1] = {}
	end
end

function var_0_0.disposeAllSlotCells(arg_22_0)
	if arg_22_0._slotCellTab then
		for iter_22_0, iter_22_1 in pairs(arg_22_0._slotCellTab) do
			for iter_22_2, iter_22_3 in pairs(iter_22_1) do
				iter_22_3:destroy()
			end
		end

		arg_22_0._slotCellTab = nil
	end

	arg_22_0._coverCells = nil
end

function var_0_0.disposeAllCollections(arg_23_0)
	if arg_23_0._collectionItemMap then
		for iter_23_0, iter_23_1 in pairs(arg_23_0._collectionItemMap) do
			iter_23_1:destroy()
		end
	end
end

function var_0_0.destroy(arg_24_0)
	arg_24_0:disposeAllSlotCells()

	if arg_24_0._slotItemLoader then
		arg_24_0._slotItemLoader:onDestroy()

		arg_24_0._slotItemLoader = nil
	end

	TaskDispatcher.cancelTask(arg_24_0._delay2HideEffect, arg_24_0)
	arg_24_0:__onDispose()
end

return var_0_0
