module("modules.logic.rouge.view.RougeCollectionChessPoolComp", package.seeall)

local var_0_0 = class("RougeCollectionChessPoolComp", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclosetipArea = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bg/#btn_closetipArea")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._gochessContainer = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_chessContainer")
	arg_1_0._gomeshContainer = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_meshContainer")
	arg_1_0._gomeshItem = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_meshContainer/#go_meshItem")
	arg_1_0._godragContainer = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_dragContainer")
	arg_1_0._gocellModel = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_cellModel")
	arg_1_0._gochessitem = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_dragContainer/#go_chessitem")
	arg_1_0._goraychessitem = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_raychessitem")
	arg_1_0._goblock = gohelper.findChild(arg_1_0.viewGO, "#go_block")
	arg_1_0._scrollbag = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_bag")
	arg_1_0._goContent = gohelper.findChild(arg_1_0.viewGO, "#scroll_bag/Viewport/#go_Content")
	arg_1_0._gocollectionItem = gohelper.findChild(arg_1_0.viewGO, "#scroll_bag/Viewport/#go_Content/#go_collectionItem")
	arg_1_0._gotip = gohelper.findChild(arg_1_0.viewGO, "#go_tip")
	arg_1_0._gosingleTipsContent = gohelper.findChild(arg_1_0.viewGO, "#go_tip/attributetip/#go_singleTipsContent")
	arg_1_0._gosingleAttributeItem = gohelper.findChild(arg_1_0.viewGO, "#go_tip/attributetip/#go_singleTipsContent/#go_singleAttributeItem")
	arg_1_0._gosizeitem = gohelper.findChild(arg_1_0.viewGO, "#go_sizebag/#go_sizecollections/#go_sizeitem")
	arg_1_0._golevelupeffect = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_effectContainer/#go_levelupeffect")
	arg_1_0._goengulfeffect = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_effectContainer/#go_engulfeffect")
	arg_1_0._goplaceeffect = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_effectContainer/#go_placeeffect")
	arg_1_0._goareaeffect = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_effectContainer/#go_areaeffect")
	arg_1_0._golightingeffect = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_effectContainer/#go_lightingeffect")
	arg_1_0._golinelevelup = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_lineContainer/#go_linelevelup")
	arg_1_0._golineengulf = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_lineContainer/#go_lineengulf")
	arg_1_0._goleveluptrigger1 = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_triggerContainer/#go_levelup1")
	arg_1_0._goleveluptrigger2 = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_triggerContainer/#go_levelup2")
	arg_1_0._goengulftrigger1 = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_triggerContainer/#go_engulf1")
	arg_1_0._goengulftrigger2 = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_triggerContainer/#go_engulf2")

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
	arg_4_0._buildDragItemCount = 0
	arg_4_0._buildEffectItemCount = 0
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	return
end

function var_0_0.getCollectionItem(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:getOrCreateCollectionPool(arg_7_1)

	if var_7_0 then
		return (var_7_0:getObject())
	end
end

function var_0_0.recycleCollectionItem(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_2 then
		return
	end

	local var_8_0 = arg_8_0._poolMap and arg_8_0._poolMap[arg_8_1]

	if var_8_0 then
		var_8_0:putObject(arg_8_2)
	end
end

function var_0_0.getOrCreateCollectionPool(arg_9_0, arg_9_1)
	arg_9_0._poolMap = arg_9_0._poolMap or arg_9_0:getUserDataTb_()

	local var_9_0 = arg_9_0._poolMap[arg_9_1]

	if not var_9_0 then
		if arg_9_1 == RougeCollectionDragItem.__cname then
			var_9_0 = arg_9_0:buildCollectionDragItemPool()
		else
			var_9_0 = arg_9_0:buildCollectionSizePool()
		end

		arg_9_0._poolMap[arg_9_1] = var_9_0
	end

	return var_9_0
end

function var_0_0.buildCollectionDragItemPool(arg_10_0)
	local var_10_0 = RougeEnum.MaxCollectionSlotSize.x * RougeEnum.MaxCollectionSlotSize.y

	return (LuaObjPool.New(var_10_0, function()
		local var_11_0 = arg_10_0._buildDragItemCount

		arg_10_0._buildDragItemCount = var_11_0 + 1

		local var_11_1 = string.format("collection_%s", arg_10_0._buildDragItemCount)
		local var_11_2 = RougeCollectionDragItem.New()

		var_11_2:onInit(var_11_1, arg_10_0)

		return var_11_2
	end, arg_10_0.releaseCollectionItemFunction, arg_10_0.resetCollectionItemFunction))
end

function var_0_0.releaseCollectionItemFunction(arg_12_0)
	if arg_12_0 then
		arg_12_0:destroy()
	end
end

function var_0_0.resetCollectionItemFunction(arg_13_0)
	if arg_13_0 then
		arg_13_0:reset()
	end
end

function var_0_0.buildCollectionSizePool(arg_14_0)
	local var_14_0 = RougeEnum.MaxCollectionSlotSize.x * RougeEnum.MaxCollectionSlotSize.y

	return (LuaObjPool.New(var_14_0, function()
		return (RougeCollectionSizeBagItem.New())
	end, arg_14_0.releaseSizeItemFunction, arg_14_0.resetSizeItemFunction))
end

function var_0_0.releaseSizeItemFunction(arg_16_0)
	if arg_16_0 then
		arg_16_0:destroy()
	end
end

function var_0_0.resetSizeItemFunction(arg_17_0)
	if arg_17_0 then
		arg_17_0:reset()
	end
end

function var_0_0.getEffectItem(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0:getOrCreateEffectPool(arg_18_1)

	if var_18_0 then
		return (var_18_0:getObject())
	else
		logError("cannot find effectpool, effectType = " .. tostring(arg_18_1))
	end
end

function var_0_0.recycleEffectItem(arg_19_0, arg_19_1, arg_19_2)
	if not arg_19_1 or not arg_19_2 then
		return
	end

	local var_19_0 = arg_19_0._effectPoolMap and arg_19_0._effectPoolMap[arg_19_1]

	if var_19_0 then
		var_19_0:putObject(arg_19_2)
	end
end

function var_0_0.getOrCreateEffectPool(arg_20_0, arg_20_1)
	arg_20_0._effectPoolMap = arg_20_0._effectPoolMap or arg_20_0:getUserDataTb_()

	local var_20_0 = arg_20_0._effectPoolMap[arg_20_1]

	if not var_20_0 then
		var_20_0 = arg_20_0:buildEffectPool(arg_20_1)
		arg_20_0._effectPoolMap[arg_20_1] = var_20_0
	end

	return var_20_0
end

local var_0_1 = 4

function var_0_0.buildEffectPool(arg_21_0, arg_21_1)
	local var_21_0 = RougeEnum.MaxCollectionSlotSize.x * RougeEnum.MaxCollectionSlotSize.y * var_0_1

	return (LuaObjPool.New(var_21_0, function()
		local var_22_0 = arg_21_0._buildEffectItemCount

		arg_21_0._buildEffectItemCount = var_22_0 + 1

		local var_22_1 = string.format("effect_%s_%s", arg_21_1, arg_21_0._buildEffectItemCount)
		local var_22_2 = arg_21_0:getEffectClonePrefab(arg_21_1)

		if not var_22_2 then
			logError("克隆造物动效失败,失败原因:找不到指定效果类型的动效预制体,效果类型effectType = " .. tostring(arg_21_1))
		end

		local var_22_3 = gohelper.cloneInPlace(var_22_2, var_22_1)

		if arg_21_1 == RougeEnum.CollectionArtType.LevelUpLine then
			local var_22_4 = gohelper.findChildImage(var_22_3, "line")

			var_22_4.material = UnityEngine.GameObject.Instantiate(var_22_4.material)

			local var_22_5 = gohelper.findChildImage(var_22_3, "lineup")

			var_22_5.material = UnityEngine.GameObject.Instantiate(var_22_5.material)
		elseif arg_21_1 == RougeEnum.CollectionArtType.EngulfLine then
			local var_22_6 = gohelper.findChildImage(var_22_3, "line")

			var_22_6.material = UnityEngine.GameObject.Instantiate(var_22_6.material)

			local var_22_7 = gohelper.findChildImage(var_22_3, "lineup")

			var_22_7.material = UnityEngine.GameObject.Instantiate(var_22_7.material)
		end

		return var_22_3
	end, arg_21_0.releaseEffectItemFunction, arg_21_0.resetEffectItemFunction))
end

function var_0_0.getEffectClonePrefab(arg_23_0, arg_23_1)
	if not arg_23_0._effectPrefabTab then
		arg_23_0._effectPrefabTab = arg_23_0:getUserDataTb_()
		arg_23_0._effectPrefabTab[RougeEnum.CollectionArtType.Place] = arg_23_0._goplaceeffect
		arg_23_0._effectPrefabTab[RougeEnum.CollectionArtType.Effect] = arg_23_0._goareaeffect
		arg_23_0._effectPrefabTab[RougeEnum.CollectionArtType.Lighting] = arg_23_0._golightingeffect
		arg_23_0._effectPrefabTab[RougeEnum.CollectionArtType.LevelUpLine] = arg_23_0._golinelevelup
		arg_23_0._effectPrefabTab[RougeEnum.CollectionArtType.EngulfLine] = arg_23_0._golineengulf
		arg_23_0._effectPrefabTab[RougeEnum.CollectionArtType.LevelUP] = arg_23_0._golevelupeffect
		arg_23_0._effectPrefabTab[RougeEnum.CollectionArtType.LevelUPTrigger1] = arg_23_0._goleveluptrigger1
		arg_23_0._effectPrefabTab[RougeEnum.CollectionArtType.LevelUPTrigger2] = arg_23_0._goleveluptrigger2
		arg_23_0._effectPrefabTab[RougeEnum.CollectionArtType.EngulfTrigger1] = arg_23_0._goengulftrigger1
		arg_23_0._effectPrefabTab[RougeEnum.CollectionArtType.EngulfTrigger2] = arg_23_0._goengulftrigger2
	end

	return arg_23_0._effectPrefabTab and arg_23_0._effectPrefabTab[arg_23_1]
end

function var_0_0.releaseEffectItemFunction(arg_24_0)
	if arg_24_0 then
		gohelper.destroy(arg_24_0)
	end
end

function var_0_0.resetEffectItemFunction(arg_25_0)
	if arg_25_0 then
		gohelper.setActive(arg_25_0, false)
	end
end

function var_0_0.onDestroyView(arg_26_0)
	if arg_26_0._poolMap then
		for iter_26_0, iter_26_1 in pairs(arg_26_0._poolMap) do
			iter_26_1:dispose()
		end

		arg_26_0._poolMap = nil
	end

	if arg_26_0._effectPoolMap then
		for iter_26_2, iter_26_3 in pairs(arg_26_0._effectPoolMap) do
			iter_26_3:dispose()
		end

		arg_26_0._effectPoolMap = nil
	end
end

return var_0_0
