module("modules.logic.rouge.view.RougeCollectionEffectActiveComp", package.seeall)

local var_0_0 = class("RougeCollectionEffectActiveComp", BaseView)

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
	arg_4_0:addEventCb(RougeCollectionChessController.instance, RougeEvent.OnBeginDragCollection, arg_4_0.onBeginDragCollection, arg_4_0)
	arg_4_0:addEventCb(RougeCollectionChessController.instance, RougeEvent.DeleteSlotCollection, arg_4_0.deleteSlotCollection, arg_4_0)
	arg_4_0:addEventCb(RougeCollectionChessController.instance, RougeEvent.UpdateSlotCollectionEffect, arg_4_0.updateSomeSlotCollectionEffect, arg_4_0)
	arg_4_0:addEventCb(RougeCollectionChessController.instance, RougeEvent.RotateSlotCollection, arg_4_0.onRotateSlotCollection, arg_4_0)
	arg_4_0:addEventCb(RougeCollectionChessController.instance, RougeEvent.Failed2PlaceSlotCollection, arg_4_0.failed2PlaceSlotCollection, arg_4_0)

	arg_4_0._poolComp = arg_4_0.viewContainer:getRougePoolComp()
	arg_4_0._effectTab = arg_4_0:getUserDataTb_()
	arg_4_0._activeEffectMap = {}
end

function var_0_0.onOpenFinish(arg_5_0)
	arg_5_0:init()
end

function var_0_0.init(arg_6_0)
	local var_6_0 = RougeCollectionModel.instance:getSlotAreaCollection()

	arg_6_0:updateSomeSlotCollectionEffect(var_6_0)
end

function var_0_0.updateSomeSlotCollectionEffect(arg_7_0, arg_7_1)
	if arg_7_1 then
		for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
			arg_7_0:recycleCollectionEffects(iter_7_1.id)
		end

		for iter_7_2, iter_7_3 in ipairs(arg_7_1) do
			arg_7_0:updateSlotCollectionEffect(iter_7_3.id)
		end

		arg_7_0:playNeedTriggerAudio()
	end
end

function var_0_0.updateSlotCollectionEffect(arg_8_0, arg_8_1)
	arg_8_0:excuteActiveEffect(arg_8_1)
end

function var_0_0.excuteActiveEffect(arg_9_0, arg_9_1)
	local var_9_0 = RougeCollectionModel.instance:getCollectionByUid(arg_9_1)

	if not var_9_0 then
		return
	end

	if not RougeCollectionModel.instance:isCollectionPlaceInSlotArea(arg_9_1) then
		return
	end

	for iter_9_0, iter_9_1 in pairs(RougeEnum.EffectActiveType) do
		local var_9_1 = var_9_0:getEffectShowTypeRelations(iter_9_1)
		local var_9_2 = var_9_0:isEffectActive(iter_9_1)

		arg_9_0:executeEffectCmd(var_9_1, var_9_0, iter_9_1, var_9_2)
	end
end

function var_0_0.executeEffectCmd(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	if not arg_10_1 or not arg_10_2 then
		return
	end

	local var_10_0 = arg_10_0:tryGetExecuteEffectFunc(arg_10_3)

	if not var_10_0 then
		logError(string.format("无法找到肉鸽造物效果表现执行方法,效果id = %s, 造物uid = %s", arg_10_3, arg_10_2.id))

		return
	end

	for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
		var_10_0(arg_10_0, arg_10_2, iter_10_1, arg_10_4)
	end
end

function var_0_0.tryGetExecuteEffectFunc(arg_11_0, arg_11_1)
	if not arg_11_0._effectExcuteFuncTab then
		arg_11_0._effectExcuteFuncTab = {
			[RougeEnum.EffectActiveType.Electric] = arg_11_0.electricEffectFunc,
			[RougeEnum.EffectActiveType.Engulf] = arg_11_0.engulfEffectFunc,
			[RougeEnum.EffectActiveType.LevelUp] = arg_11_0.levelUpEffectFunc
		}
	end

	return arg_11_0._effectExcuteFuncTab[arg_11_1]
end

function var_0_0.electricEffectFunc(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.UpdateActiveEffect, arg_12_1.id, RougeEnum.EffectActiveType.Electric, arg_12_3)

	if arg_12_3 then
		arg_12_0:try2PlayEffectActiveAudio(arg_12_1.id, nil, RougeEnum.EffectActiveType.Electric, AudioEnum.UI.ElectricEffect)
		RougeCollectionHelper.foreachCollectionCells(arg_12_1, arg_12_0.electircTypeCellFunc, arg_12_0)
	end

	arg_12_0:updateActiveEffectInfo(arg_12_1.id, RougeEnum.EffectActiveType.Electric, arg_12_3)
end

function var_0_0.electircTypeCellFunc(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = arg_13_1:getLeftTopPos()
	local var_13_1 = Vector2(var_13_0.x + arg_13_3 - 1, var_13_0.y + arg_13_2 - 1)
	local var_13_2, var_13_3 = RougeCollectionHelper.slotPos2AnchorPos(var_13_1)
	local var_13_4 = arg_13_0._poolComp:getEffectItem(RougeEnum.CollectionArtType.Lighting)

	gohelper.setActive(var_13_4, true)
	recthelper.setAnchor(var_13_4.transform, var_13_2, var_13_3)
	arg_13_0:saveEffectGO(arg_13_1.id, RougeEnum.CollectionArtType.Lighting, var_13_4)
end

function var_0_0.levelUpEffectFunc(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.UpdateActiveEffect, arg_14_1.id, RougeEnum.EffectActiveType.LevelUp, arg_14_3)

	if arg_14_3 then
		local var_14_0 = arg_14_2:getTrueCollectionIds()

		arg_14_0:try2PlayEffectActiveAudio(arg_14_1.id, var_14_0, RougeEnum.EffectActiveType.LevelUp, AudioEnum.UI.LevelUpEffect)

		if var_14_0 then
			for iter_14_0, iter_14_1 in ipairs(var_14_0) do
				local var_14_1 = RougeCollectionModel.instance:getCollectionByUid(iter_14_1)

				arg_14_0:levelupTypeTrueIdFunc(var_14_1, arg_14_1)
				arg_14_0:updateActiveEffectInfo(iter_14_1, RougeEnum.EffectActiveType.LevelUp, arg_14_3)
			end
		end
	end

	arg_14_0:updateActiveEffectInfo(arg_14_1.id, RougeEnum.EffectActiveType.LevelUp, arg_14_3)
end

function var_0_0.levelupTypeTrueIdFunc(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0, var_15_1 = RougeCollectionHelper.getTwoCollectionConnectCell(arg_15_1, arg_15_2)

	if not var_15_0 or not var_15_1 then
		return
	end

	local var_15_2 = arg_15_1.id
	local var_15_3 = arg_15_2.id

	arg_15_0:drawLineConnectTwoCollection(var_15_2, var_15_0, var_15_3, var_15_1, RougeEnum.CollectionArtType.LevelUpLine)
	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.UpdateActiveEffect, var_15_2, RougeEnum.EffectActiveType.LevelUp, true)
end

function var_0_0.drawLineConnectTwoCollection(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5)
	local var_16_0 = arg_16_0._poolComp:getEffectItem(arg_16_5)
	local var_16_1, var_16_2 = RougeCollectionHelper.slotPos2AnchorPos(arg_16_2)

	gohelper.setActive(var_16_0, true)
	recthelper.setAnchor(var_16_0.transform, var_16_1, var_16_2)

	local var_16_3 = var_16_0.transform.position
	local var_16_4, var_16_5 = recthelper.rectToRelativeAnchorPos2(var_16_3, arg_16_0.viewGO.transform)
	local var_16_6, var_16_7 = RougeCollectionHelper.slotPos2AnchorPos(arg_16_4)

	recthelper.setAnchor(var_16_0.transform, var_16_6, var_16_7)

	local var_16_8 = var_16_0.transform.position
	local var_16_9, var_16_10 = recthelper.rectToRelativeAnchorPos2(var_16_8, arg_16_0.viewGO.transform)
	local var_16_11 = gohelper.findChildImage(var_16_0, "line")

	arg_16_0:setLinePosition(var_16_11, var_16_4, var_16_5, var_16_9, var_16_10)

	local var_16_12 = gohelper.findChildImage(var_16_0, "lineup")

	arg_16_0:setLinePosition(var_16_12, var_16_4, var_16_5, var_16_9, var_16_10)

	local var_16_13 = gohelper.findChild(var_16_0, "#dot")
	local var_16_14, var_16_15 = recthelper.rectToRelativeAnchorPos2(var_16_3, var_16_0.transform)

	recthelper.setAnchor(var_16_13.transform, var_16_14, var_16_15)
	arg_16_0:saveEffectGO(arg_16_1, arg_16_5, var_16_0)
	arg_16_0:saveEffectGO(arg_16_3, arg_16_5, var_16_0)
end

function var_0_0.setLinePosition(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4, arg_17_5)
	local var_17_0 = Vector4(arg_17_2, arg_17_3, 0, 0)
	local var_17_1 = Vector4(arg_17_4, arg_17_5, 0, 0)

	arg_17_1.material:SetVector("_StartVec", var_17_0)
	arg_17_1.material:SetVector("_EndVec", var_17_1)
end

function var_0_0.engulfEffectFunc(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.UpdateActiveEffect, arg_18_1.id, RougeEnum.EffectActiveType.Engulf, arg_18_3)

	if arg_18_3 then
		local var_18_0 = arg_18_2:getTrueCollectionIds()

		arg_18_0:try2PlayEffectActiveAudio(arg_18_1.id, var_18_0, RougeEnum.EffectActiveType.Engulf, AudioEnum.UI.EngulfEffect)

		if var_18_0 then
			for iter_18_0, iter_18_1 in ipairs(var_18_0) do
				local var_18_1 = RougeCollectionModel.instance:getCollectionByUid(iter_18_1)

				arg_18_0:engulfTypeTrueIdFunc(arg_18_1, var_18_1)
				arg_18_0:updateActiveEffectInfo(iter_18_1, RougeEnum.EffectActiveType.Engulf, arg_18_3)
			end
		end
	end

	arg_18_0:updateActiveEffectInfo(arg_18_1.id, RougeEnum.EffectActiveType.Engulf, arg_18_3)
end

function var_0_0.engulfTypeTrueIdFunc(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0, var_19_1 = RougeCollectionHelper.getTwoCollectionConnectCell(arg_19_1, arg_19_2)

	if not var_19_0 or not var_19_1 then
		return
	end

	local var_19_2 = arg_19_1.id
	local var_19_3 = arg_19_2.id

	arg_19_0:drawLineConnectTwoCollection(var_19_2, var_19_0, var_19_3, var_19_1, RougeEnum.CollectionArtType.EngulfLine)
	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.UpdateActiveEffect, arg_19_2.id, RougeEnum.EffectActiveType.Engulf, true)
end

function var_0_0.saveEffectGO(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	local var_20_0 = arg_20_0._effectTab and arg_20_0._effectTab[arg_20_1]

	if not (var_20_0 and var_20_0[arg_20_2]) then
		arg_20_0._effectTab = arg_20_0._effectTab or arg_20_0:getUserDataTb_()
		arg_20_0._effectTab[arg_20_1] = arg_20_0._effectTab[arg_20_1] or arg_20_0:getUserDataTb_()
		arg_20_0._effectTab[arg_20_1][arg_20_2] = arg_20_0:getUserDataTb_()
	end

	table.insert(arg_20_0._effectTab[arg_20_1][arg_20_2], arg_20_3)
end

function var_0_0.recycleEffectGOs(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_0._effectTab and arg_21_0._effectTab[arg_21_1]

	if var_21_0 and var_21_0[arg_21_2] then
		local var_21_1 = var_21_0[arg_21_2]

		for iter_21_0 = #var_21_1, 1, -1 do
			local var_21_2 = var_21_1[iter_21_0]

			table.remove(var_21_1, iter_21_0)
			arg_21_0._poolComp:recycleEffectItem(arg_21_2, var_21_2)
		end
	end
end

function var_0_0.onBeginDragCollection(arg_22_0, arg_22_1)
	if not arg_22_1 then
		return
	end

	arg_22_0:recycleCollectionEffects(arg_22_1.id)
	arg_22_0:updateCollectionActiveEffectInfo(arg_22_1.id)
end

function var_0_0.onRotateSlotCollection(arg_23_0, arg_23_1)
	if not arg_23_1 then
		return
	end

	arg_23_0:recycleCollectionEffects(arg_23_1.id)
	arg_23_0:updateCollectionActiveEffectInfo(arg_23_1.id)
end

function var_0_0.setCollectionEffectsVisible(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = arg_24_0._effectTab and arg_24_0._effectTab[arg_24_1]

	if not var_24_0 then
		return
	end

	for iter_24_0, iter_24_1 in pairs(var_24_0) do
		local var_24_1 = arg_24_0._effectTab and arg_24_0._effectTab[arg_24_1]

		if var_24_1 and var_24_1[iter_24_0] then
			for iter_24_2, iter_24_3 in pairs(var_24_1[iter_24_0]) do
				if iter_24_3 then
					gohelper.setActive(iter_24_3, arg_24_2)
				end
			end
		end
	end
end

function var_0_0.try2PlayEffectActiveAudio(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4)
	local var_25_0 = arg_25_0:isCollectionHasActiveEffect(arg_25_1, arg_25_3)

	if var_25_0 and arg_25_2 then
		for iter_25_0, iter_25_1 in ipairs(arg_25_2) do
			var_25_0 = arg_25_0:isCollectionHasActiveEffect(iter_25_1, arg_25_3)

			if not var_25_0 then
				break
			end
		end
	end

	if not var_25_0 then
		arg_25_0._needTriggerAudioMap = arg_25_0._needTriggerAudioMap or {}
		arg_25_0._needTriggerAudioMap[arg_25_4] = true
	end
end

function var_0_0.playNeedTriggerAudio(arg_26_0)
	if arg_26_0._needTriggerAudioMap then
		for iter_26_0, iter_26_1 in pairs(arg_26_0._needTriggerAudioMap) do
			if iter_26_1 then
				AudioMgr.instance:trigger(iter_26_0)
			end

			arg_26_0._needTriggerAudioMap[iter_26_0] = nil
		end
	end
end

function var_0_0.updateActiveEffectInfo(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	if arg_27_3 then
		arg_27_0._activeEffectMap = arg_27_0._activeEffectMap or {}
		arg_27_0._activeEffectMap[arg_27_1] = arg_27_0._activeEffectMap[arg_27_1] or {}
		arg_27_0._activeEffectMap[arg_27_1][arg_27_2] = arg_27_3
	else
		local var_27_0 = arg_27_0._activeEffectMap and arg_27_0._activeEffectMap[arg_27_1]

		if var_27_0 then
			var_27_0[arg_27_2] = arg_27_3
		end
	end
end

function var_0_0.isCollectionHasActiveEffect(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = arg_28_0._activeEffectMap and arg_28_0._activeEffectMap[arg_28_1]

	return var_28_0 and var_28_0[arg_28_2]
end

function var_0_0.failed2PlaceSlotCollection(arg_29_0, arg_29_1)
	if not RougeCollectionModel.instance:isCollectionPlaceInSlotArea(arg_29_1) then
		return
	end

	arg_29_0:updateSlotCollectionEffect(arg_29_1)
end

function var_0_0.recycleCollectionEffects(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_0._effectTab and arg_30_0._effectTab[arg_30_1]

	if not var_30_0 then
		return
	end

	for iter_30_0, iter_30_1 in pairs(var_30_0) do
		arg_30_0:recycleEffectGOs(arg_30_1, iter_30_0)
	end
end

function var_0_0.updateCollectionActiveEffectInfo(arg_31_0, arg_31_1)
	if not arg_31_1 then
		return
	end

	for iter_31_0, iter_31_1 in pairs(RougeEnum.EffectActiveType) do
		arg_31_0:updateActiveEffectInfo(arg_31_1, iter_31_1, false)
	end
end

function var_0_0.deleteSlotCollection(arg_32_0, arg_32_1)
	arg_32_0:recycleCollectionEffects(arg_32_1)
	arg_32_0:updateCollectionActiveEffectInfo(arg_32_1)
end

function var_0_0.onDestroyView(arg_33_0)
	arg_33_0._poolComp = nil
end

return var_0_0
