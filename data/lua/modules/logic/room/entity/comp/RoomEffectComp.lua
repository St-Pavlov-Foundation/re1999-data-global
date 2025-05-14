module("modules.logic.room.entity.comp.RoomEffectComp", package.seeall)

local var_0_0 = class("RoomEffectComp", LuaCompBase)

var_0_0.SCENE_TRANSPARNET_OBJECT_KEY = "__transparent_set_layer_"

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.entity = arg_1_1
	arg_1_0.__willDestroy = false
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0._scene = GameSceneMgr.instance:getCurScene()
	arg_2_0.go = arg_2_1
	arg_2_0._paramDict = {}
	arg_2_0._applyParamDict = {}
	arg_2_0._goDict = arg_2_0:getUserDataTb_()
	arg_2_0._goTransformDict = arg_2_0:getUserDataTb_()
	arg_2_0._animatorDict = arg_2_0:getUserDataTb_()
	arg_2_0._resDict = {}
	arg_2_0._goActiveDict = {}
	arg_2_0._goHasDict = {}
	arg_2_0._delayDestroyDict = {}
	arg_2_0._delayDestroyMinTime = nil
	arg_2_0._sameNameComponentsDic = {}
	arg_2_0._typeComponentsData = RoomEffectCompCacheData.New(arg_2_0)
	arg_2_0._goSameNameChildsData = RoomEffectCompCacheData.New(arg_2_0)
	arg_2_0._goPathChildsData = RoomEffectCompCacheData.New(arg_2_0)
	arg_2_0._goSameNameChildsTrsData = RoomEffectCompCacheData.New(arg_2_0)
	arg_2_0._goPathChildsTrsData = RoomEffectCompCacheData.New(arg_2_0)
	arg_2_0.isEmulator = SDKMgr.instance:isEmulator()
end

function var_0_0.addEventListeners(arg_3_0)
	return
end

function var_0_0.removeEventListeners(arg_4_0)
	return
end

function var_0_0.beforeDestroy(arg_5_0)
	arg_5_0.__willDestroy = true

	TaskDispatcher.cancelTask(arg_5_0._delayDestroy, arg_5_0)
	arg_5_0:removeEventListeners()
	arg_5_0:returnAllEffect()
end

function var_0_0.isHasKey(arg_6_0, arg_6_1)
	if arg_6_0._delayDestroyDict[arg_6_1] then
		return false
	end

	if arg_6_0._paramDict[arg_6_1] == nil then
		return false
	end

	return true
end

function var_0_0.addParams(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_0.__willDestroy then
		return
	end

	local var_7_0 = Time.time

	for iter_7_0, iter_7_1 in pairs(arg_7_1) do
		arg_7_0._paramDict[iter_7_0] = iter_7_1

		if arg_7_2 and arg_7_2 > 0 then
			arg_7_0._delayDestroyDict[iter_7_0] = arg_7_2 + var_7_0
		else
			arg_7_0._delayDestroyDict[iter_7_0] = nil
		end
	end

	arg_7_0:_refreshDelayDestroyTask()
end

function var_0_0._refreshDelayDestroyTask(arg_8_0)
	local var_8_0

	for iter_8_0, iter_8_1 in pairs(arg_8_0._delayDestroyDict) do
		if iter_8_1 and (not var_8_0 or iter_8_1 < var_8_0) then
			var_8_0 = iter_8_1
		end
	end

	var_8_0 = var_8_0 and var_8_0 - Time.time

	if var_8_0 == nil and arg_8_0._delayDestroyMinTime then
		arg_8_0._delayDestroyMinTime = nil

		TaskDispatcher.cancelTask(arg_8_0._delayDestroy, arg_8_0)
	end

	if var_8_0 and (arg_8_0._delayDestroyMinTime == nil or var_8_0 < arg_8_0._delayDestroyMinTime) then
		if arg_8_0._delayDestroyMinTime then
			TaskDispatcher.cancelTask(arg_8_0._delayDestroy, arg_8_0)
		end

		arg_8_0._delayDestroyMinTime = var_8_0

		TaskDispatcher.runDelay(arg_8_0._delayDestroy, arg_8_0, arg_8_0._delayDestroyMinTime)
	end
end

function var_0_0._delayDestroy(arg_9_0)
	local var_9_0 = Time.time + 0.001

	arg_9_0._delayDestroyMinTime = nil

	local var_9_1 = {}

	for iter_9_0, iter_9_1 in pairs(arg_9_0._delayDestroyDict) do
		if iter_9_1 and iter_9_1 <= var_9_0 then
			table.insert(var_9_1, iter_9_0)
		end
	end

	arg_9_0:removeParams(var_9_1)
	arg_9_0:refreshEffect()
end

function var_0_0.changeParams(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in pairs(arg_10_1) do
		if arg_10_0._paramDict[iter_10_0] then
			for iter_10_2, iter_10_3 in pairs(iter_10_1) do
				arg_10_0._paramDict[iter_10_0][iter_10_2] = iter_10_3
			end
		end
	end
end

function var_0_0.removeParams(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = Time.time

	for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
		if arg_11_2 and arg_11_2 > 0 then
			arg_11_0._delayDestroyDict[iter_11_1] = arg_11_2 + var_11_0
		else
			arg_11_0._paramDict[iter_11_1] = nil
			arg_11_0._delayDestroyDict[iter_11_1] = nil
		end
	end

	arg_11_0:_refreshDelayDestroyTask()
end

function var_0_0.getEffectGOTrs(arg_12_0, arg_12_1)
	return arg_12_0._goTransformDict[arg_12_1]
end

function var_0_0.getEffectGO(arg_13_0, arg_13_1)
	return arg_13_0._goDict[arg_13_1]
end

function var_0_0.getEffectRes(arg_14_0, arg_14_1)
	return arg_14_0._resDict[arg_14_1]
end

function var_0_0.isSameResByKey(arg_15_0, arg_15_1, arg_15_2)
	return arg_15_0._resDict[arg_15_1] == arg_15_2
end

function var_0_0.isHasEffectGOByKey(arg_16_0, arg_16_1)
	return arg_16_0._goHasDict[arg_16_1]
end

function var_0_0.setActiveByKey(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_0.__willDestroy or arg_17_2 == nil then
		return
	end

	local var_17_0 = arg_17_2 and true or false

	if arg_17_0._goActiveDict[arg_17_1] ~= var_17_0 then
		arg_17_0._goActiveDict[arg_17_1] = var_17_0

		if arg_17_0._goHasDict[arg_17_1] then
			gohelper.setActive(arg_17_0._goDict[arg_17_1], var_17_0)
		end
	end
end

function var_0_0.playEffectAnimator(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_0.__willDestroy then
		return
	end

	local var_18_0 = arg_18_0._animatorDict[arg_18_1]

	if var_18_0 == nil then
		local var_18_1 = arg_18_0:getEffectGO(arg_18_1)

		if var_18_1 then
			var_18_0 = var_18_1:GetComponent(RoomEnum.ComponentType.Animator)
			arg_18_0._animatorDict[arg_18_1] = var_18_0 or false
		end
	end

	if var_18_0 then
		var_18_0:Play(arg_18_2, 0, 0)

		return true
	end
end

function var_0_0.getMeshRenderersByKey(arg_19_0, arg_19_1)
	return arg_19_0:getComponentsByKey(arg_19_1, RoomEnum.ComponentName.MeshRenderer)
end

function var_0_0.getMeshRenderersByPath(arg_20_0, arg_20_1, arg_20_2)
	return arg_20_0:getComponentsByPath(arg_20_1, RoomEnum.ComponentName.MeshRenderer, arg_20_2)
end

function var_0_0.getComponentsByPath(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = RoomEnum.ComponentType[arg_21_2]

	if not var_21_0 then
		return
	end

	local var_21_1 = arg_21_0:_getSameCacheData(arg_21_2)
	local var_21_2 = var_21_1:getDataByKey(arg_21_1, arg_21_3)

	if arg_21_0.__willDestroy then
		return var_21_2
	end

	if not var_21_2 and arg_21_0._goHasDict[arg_21_1] then
		var_21_2 = {}

		var_21_1:addDataByKey(arg_21_1, arg_21_3, var_21_2)

		local var_21_3 = gohelper.findChild(arg_21_0._goDict[arg_21_1], arg_21_3)

		if var_21_3 then
			local var_21_4 = var_21_3:GetComponentsInChildren(var_21_0, true)

			arg_21_0:_cArrayToLuaTable(var_21_4, var_21_2)
		end
	end

	return var_21_2
end

function var_0_0._getSameCacheData(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0._sameNameComponentsDic[arg_22_1]

	if not var_22_0 then
		var_22_0 = RoomEffectCompCacheData.New(arg_22_0)
		arg_22_0._sameNameComponentsDic[arg_22_1] = var_22_0
	end

	return var_22_0
end

function var_0_0.getComponentsByKey(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = RoomEnum.ComponentType[arg_23_2]

	if not var_23_0 then
		return
	end

	local var_23_1 = arg_23_0._typeComponentsData:getDataByKey(arg_23_1, arg_23_2)

	if arg_23_0.__willDestroy then
		return var_23_1
	end

	if not var_23_1 and arg_23_0._goHasDict[arg_23_1] then
		var_23_1 = {}

		arg_23_0._typeComponentsData:addDataByKey(arg_23_1, arg_23_2, var_23_1)

		local var_23_2 = arg_23_0._goDict[arg_23_1]:GetComponentsInChildren(var_23_0, true)

		arg_23_0:_cArrayToLuaTable(var_23_2, var_23_1)
	end

	return var_23_1
end

function var_0_0.getGameObjectsByName(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = arg_24_0._goSameNameChildsData:getDataByKey(arg_24_1, arg_24_2)

	if arg_24_0.__willDestroy then
		return var_24_0
	end

	if not var_24_0 and arg_24_0._goHasDict[arg_24_1] then
		var_24_0 = {}

		arg_24_0._goSameNameChildsData:addDataByKey(arg_24_1, arg_24_2, var_24_0)

		if var_0_0.SCENE_TRANSPARNET_OBJECT_KEY == arg_24_2 then
			local var_24_1 = arg_24_0:getMeshRenderersByKey(arg_24_1)

			for iter_24_0 = 1, #var_24_1 do
				local var_24_2 = var_24_1[iter_24_0]
				local var_24_3 = string.find(var_24_2.name, "transparent")

				if var_24_3 and var_24_3 == 1 then
					table.insert(var_24_0, var_24_2.gameObject)
				end
			end
		else
			RoomHelper.getGameObjectsByNameInChildren(arg_24_0._goDict[arg_24_1], arg_24_2, var_24_0)
		end
	end

	return var_24_0
end

function var_0_0.getGameObjectByPath(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = arg_25_0._goPathChildsData:getDataByKey(arg_25_1, arg_25_2)

	if not arg_25_0.__willDestroy and not var_25_0 and arg_25_0._goHasDict[arg_25_1] then
		var_25_0 = {}

		arg_25_0._goPathChildsData:addDataByKey(arg_25_1, arg_25_2, var_25_0)

		local var_25_1 = gohelper.findChild(arg_25_0._goDict[arg_25_1], arg_25_2)

		if var_25_1 then
			table.insert(var_25_0, var_25_1)
		end
	end

	if var_25_0 then
		return var_25_0[1]
	end
end

function var_0_0.getGameObjectsTrsByName(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = arg_26_0._goSameNameChildsTrsData:getDataByKey(arg_26_1, arg_26_2)

	if arg_26_0.__willDestroy then
		return var_26_0
	end

	if not var_26_0 and arg_26_0._goHasDict[arg_26_1] then
		local var_26_1 = arg_26_0:getGameObjectsByName(arg_26_1, arg_26_2)

		if var_26_1 then
			var_26_0 = {}

			arg_26_0._goSameNameChildsTrsData:addDataByKey(arg_26_1, arg_26_2, var_26_0)

			for iter_26_0, iter_26_1 in ipairs(var_26_1) do
				table.insert(var_26_0, iter_26_1.transform)
			end
		end
	end

	return var_26_0
end

function var_0_0.getGameObjectTrsByPath(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = arg_27_0._goPathChildsTrsData:getDataByKey(arg_27_1, arg_27_2)

	if not arg_27_0.__willDestroy and not var_27_0 and arg_27_0._goHasDict[arg_27_1] then
		var_27_0 = {}

		arg_27_0._goPathChildsTrsData:addDataByKey(arg_27_1, arg_27_2, var_27_0)

		local var_27_1 = arg_27_0:getGameObjectByPath(arg_27_1, arg_27_2)

		if var_27_1 then
			table.insert(var_27_0, var_27_1)
		end
	end

	if var_27_0 then
		return var_27_0[1]
	end
end

function var_0_0.removeComponentsByKey(arg_28_0, arg_28_1)
	arg_28_0._typeComponentsData:removeDataByKey(arg_28_1)
	arg_28_0._goSameNameChildsData:removeDataByKey(arg_28_1)
	arg_28_0._goPathChildsData:removeDataByKey(arg_28_1)
	arg_28_0._goSameNameChildsTrsData:removeDataByKey(arg_28_1)
	arg_28_0._goPathChildsTrsData:removeDataByKey(arg_28_1)

	for iter_28_0, iter_28_1 in pairs(arg_28_0._sameNameComponentsDic) do
		iter_28_1:removeDataByKey(arg_28_1)
	end
end

function var_0_0.refreshEffect(arg_29_0)
	if arg_29_0.__willDestroy then
		return
	end

	local var_29_0 = false

	for iter_29_0, iter_29_1 in pairs(arg_29_0._resDict) do
		local var_29_1 = arg_29_0._paramDict[iter_29_0]

		if not var_29_1 or var_29_1.res ~= iter_29_1 then
			arg_29_0:returnEffect(iter_29_0, arg_29_0._goDict[iter_29_0], iter_29_1)

			local var_29_2 = arg_29_0._applyParamDict[iter_29_0]

			if var_29_2 and var_29_2.pathfinding then
				var_29_0 = true
			end
		end
	end

	local var_29_3 = {}
	local var_29_4 = GameResMgr.IsFromEditorDir

	for iter_29_2, iter_29_3 in pairs(arg_29_0._paramDict) do
		if var_29_4 then
			table.insert(var_29_3, iter_29_3.res)
		else
			table.insert(var_29_3, iter_29_3.ab or iter_29_3.res)
		end
	end

	GameSceneMgr.instance:getCurScene().loader:makeSureLoaded(var_29_3, arg_29_0._rebuildEffect, arg_29_0)
	arg_29_0:_tryClearClickCollider()

	if var_29_0 then
		arg_29_0:_tryUpdatePathfindingCollider()
	end
end

function var_0_0._rebuildEffect(arg_30_0)
	if arg_30_0.__willDestroy then
		return
	end

	local var_30_0 = false
	local var_30_1 = GameSceneMgr.instance:getCurScene().preloader
	local var_30_2 = GameResMgr.IsFromEditorDir

	for iter_30_0, iter_30_1 in pairs(arg_30_0._paramDict) do
		local var_30_3 = arg_30_0._goDict[iter_30_0]
		local var_30_4 = arg_30_0._goTransformDict[iter_30_0]
		local var_30_5 = true

		if var_30_3 then
			var_30_5 = false
		end

		local var_30_6 = iter_30_1.res
		local var_30_7 = iter_30_1.ab
		local var_30_8 = iter_30_1.localPos or var_30_5 and Vector3.zero
		local var_30_9 = iter_30_1.localRotation or var_30_5 and Vector3.zero
		local var_30_10 = iter_30_1.localScale or var_30_5 and Vector3.one
		local var_30_11 = iter_30_1.layer
		local var_30_12 = iter_30_1.shadow
		local var_30_13 = iter_30_1.batch
		local var_30_14 = iter_30_1.highlight
		local var_30_15 = iter_30_1.alphaThreshold
		local var_30_16 = iter_30_1.isInventory
		local var_30_17 = arg_30_0._applyParamDict[iter_30_0]

		if var_30_5 and var_30_1 and var_30_1:exist(var_30_2 and var_30_6 or var_30_7 or var_30_6) then
			local var_30_18 = arg_30_0.entity.containerGO

			if iter_30_1.containerGO then
				var_30_18 = iter_30_1.containerGO
			end

			local var_30_19 = iter_30_1.name or iter_30_0

			var_30_3 = RoomGOPool.getInstance(var_30_6, var_30_18, var_30_19, var_30_7)
			var_30_4 = var_30_3.transform
			arg_30_0._goDict[iter_30_0] = var_30_3
			arg_30_0._goTransformDict[iter_30_0] = var_30_4
			arg_30_0._resDict[iter_30_0] = var_30_6
			arg_30_0._goHasDict[iter_30_0] = true

			if iter_30_1.pathfinding then
				var_30_0 = true
			end

			if iter_30_1.deleteChildPath then
				local var_30_20 = gohelper.findChild(var_30_3, iter_30_1.deleteChildPath)

				if var_30_20 then
					gohelper.addChild(RoomGOPool.getPoolContainerGO(), var_30_20)
					gohelper.destroy(var_30_20)
				end
			end

			if arg_30_0._goActiveDict[iter_30_0] ~= nil then
				gohelper.setActive(var_30_3, arg_30_0._goActiveDict[iter_30_0])
			end
		end

		if var_30_3 then
			if iter_30_1.containerGO then
				iter_30_1.containerGO = nil
			end

			if var_30_8 then
				transformhelper.setLocalPos(var_30_4, var_30_8.x, var_30_8.y, var_30_8.z)
			end

			if var_30_9 then
				transformhelper.setLocalRotation(var_30_4, var_30_9.x, var_30_9.y, var_30_9.z)
			end

			if var_30_10 then
				transformhelper.setLocalScale(var_30_4, var_30_10.x, var_30_10.y, var_30_10.z)
			end

			if var_30_13 ~= nil and (not var_30_17 or var_30_17.batch ~= var_30_13) then
				arg_30_0:setBatch(iter_30_0, var_30_13)
			end

			if var_30_11 ~= nil and (not var_30_17 or var_30_17.layer ~= var_30_11) and var_30_11 ~= UnityLayer.SceneOpaque then
				arg_30_0:setLayer(iter_30_0, var_30_11)
			end

			CurveWorldRenderer.InitCurveWorldRenderer(var_30_3)

			if var_30_12 ~= nil and (not var_30_17 or var_30_17.shadow ~= var_30_12) then
				arg_30_0:setShadow(iter_30_0, var_30_12)
			end

			local var_30_21 = false
			local var_30_22 = false

			if not var_30_17 or var_30_14 ~= nil and var_30_17.highlight ~= var_30_14 then
				var_30_21 = true
			end

			if not var_30_17 or var_30_16 ~= nil and var_30_17.isInventory ~= var_30_16 then
				var_30_22 = var_30_16
			end

			if not var_30_17 or var_30_15 ~= nil and var_30_17.alphaThreshold ~= var_30_15 then
				var_30_21 = true
			end

			if var_30_21 then
				arg_30_0:setMPB(iter_30_0, var_30_14, var_30_15, iter_30_1.alphaThresholdValue)
			end

			if var_30_22 then
				arg_30_0:setDimdegeKey(iter_30_0, false)
			end

			arg_30_0._applyParamDict[iter_30_0] = tabletool.copy(iter_30_1)
		end
	end

	arg_30_0:_tryClearClickCollider()

	if arg_30_0.entity.onEffectRebuild then
		arg_30_0.entity:onEffectRebuild()
	end

	for iter_30_2, iter_30_3 in ipairs(RoomEnum.EffectRebuildCompNames) do
		local var_30_23 = arg_30_0.entity[iter_30_3]

		if var_30_23 and var_30_23.onEffectRebuild then
			var_30_23:onEffectRebuild()
		end
	end

	if var_30_0 then
		arg_30_0:_tryUpdatePathfindingCollider()
	end
end

function var_0_0.setLayer(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = arg_31_0._goDict[arg_31_1]

	if not var_31_0 then
		return
	end

	if arg_31_2 == UnityLayer.SceneOrthogonalOpaque then
		RenderPipelineSetting.SetChildRenderLayerMask(var_31_0, 7, 8, true)
		RenderPipelineSetting.SetChildRenderLayerMask(var_31_0, 0, 8, false)
	else
		RenderPipelineSetting.SetChildRenderLayerMask(var_31_0, 0, 8, true)
		RenderPipelineSetting.SetChildRenderLayerMask(var_31_0, 7, 8, false)
	end
end

function var_0_0.setShadow(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = arg_32_0:getMeshRenderersByKey(arg_32_1)

	if var_32_0 then
		for iter_32_0 = 1, #var_32_0 do
			local var_32_1 = var_32_0[iter_32_0]

			if arg_32_2 then
				var_32_1.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.On
				var_32_1.receiveShadows = true
			else
				var_32_1.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.Off
				var_32_1.receiveShadows = false
			end
		end
	end
end

function var_0_0.setBatch(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = arg_33_0:getComponentsByKey(arg_33_1, RoomEnum.ComponentName.BatchRendererEntity)

	if var_33_0 then
		for iter_33_0 = 1, #var_33_0 do
			var_33_0[iter_33_0].enabled = arg_33_2
		end
	end
end

function var_0_0.setMPB(arg_34_0, arg_34_1, arg_34_2, arg_34_3, arg_34_4)
	local var_34_0 = arg_34_0:getMeshRenderersByKey(arg_34_1)
	local var_34_1 = GameSceneMgr.instance:getCurScene()
	local var_34_2

	if arg_34_2 or arg_34_3 then
		var_34_2 = var_34_1.mapmgr:getPropertyBlock()

		var_34_2:Clear()

		if arg_34_2 then
			var_34_2:SetVector("_Highlight", Vector4.New(0.3, 0.19, 0.06, 0))
		end

		if arg_34_3 then
			var_34_2:SetFloat("_AlphaThreshold", arg_34_4 or 0.6)
		end
	end

	if var_34_0 then
		for iter_34_0 = 1, #var_34_0 do
			local var_34_3 = var_34_0[iter_34_0]

			if arg_34_3 ~= nil then
				MaterialReplaceHelper.SetRendererKeyworld(var_34_3, "_SCREENCOORD", arg_34_3 and true or false)
			end

			var_34_3:SetPropertyBlock(var_34_2)
		end
	end
end

function var_0_0.setDimdegeKey(arg_35_0, arg_35_1, arg_35_2)
	local var_35_0 = arg_35_0:getMeshRenderersByKey(arg_35_1)

	if var_35_0 then
		local var_35_1 = GameSceneMgr.instance:getCurScene().mapmgr:getPropertyBlock()

		var_35_1:Clear()
		var_35_1:SetFloat("_DimEdgeSize", arg_35_2 and 0 or 1)

		for iter_35_0 = 1, #var_35_0 do
			var_35_0[iter_35_0]:SetPropertyBlock(var_35_1)
		end
	end
end

function var_0_0.setMaterialKeyword(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
	local var_36_0 = arg_36_0:_cArrayToLuaTable(arg_36_1.materials)

	if var_36_0 then
		for iter_36_0 = 1, #var_36_0 do
			local var_36_1 = var_36_0[iter_36_0]

			if arg_36_3 then
				var_36_1:EnableKeyword(arg_36_2)
			else
				var_36_1:DisableKeyword(arg_36_2)
			end
		end
	end
end

function var_0_0.returnEffect(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
	if not arg_37_2 or string.nilorempty(arg_37_3) then
		return
	end

	local var_37_0 = arg_37_0._applyParamDict[arg_37_1]

	if var_37_0 then
		if var_37_0.isInventory then
			arg_37_0:setDimdegeKey(arg_37_1, true)
		end

		if var_37_0.layer and var_37_0.layer ~= UnityLayer.SceneOpaque then
			arg_37_0:setLayer(arg_37_1, UnityLayer.SceneOpaque)
		end

		if var_37_0.batch == false then
			arg_37_0:setBatch(true)
		end

		if arg_37_0._goActiveDict[arg_37_1] == false then
			gohelper.setActive(arg_37_0._goDict[arg_37_1], true)
		end
	end

	for iter_37_0, iter_37_1 in ipairs(RoomEnum.EffectRebuildCompNames) do
		local var_37_1 = arg_37_0.entity[iter_37_1]

		if var_37_1 and var_37_1.onEffectReturn then
			var_37_1:onEffectReturn(arg_37_1, arg_37_3)
		end
	end

	RoomGOPool.returnInstance(arg_37_3, arg_37_2)
	arg_37_0:removeComponentsByKey(arg_37_1)

	arg_37_0._goDict[arg_37_1] = nil
	arg_37_0._resDict[arg_37_1] = nil
	arg_37_0._animatorDict[arg_37_1] = nil
	arg_37_0._applyParamDict[arg_37_1] = nil
	arg_37_0._goTransformDict[arg_37_1] = nil
	arg_37_0._goActiveDict[arg_37_1] = nil
	arg_37_0._goHasDict[arg_37_1] = nil
end

function var_0_0.returnAllEffect(arg_38_0)
	TaskDispatcher.cancelTask(arg_38_0._delayDestroy, arg_38_0)

	for iter_38_0, iter_38_1 in pairs(arg_38_0._resDict) do
		arg_38_0:returnEffect(iter_38_0, arg_38_0._goDict[iter_38_0], iter_38_1)
	end

	arg_38_0._resDict = nil
	arg_38_0._paramDict = nil
	arg_38_0._applyParamDict = nil
end

function var_0_0._cArrayToLuaTable(arg_39_0, arg_39_1, arg_39_2)
	return RoomHelper.cArrayToLuaTable(arg_39_1, arg_39_2)
end

function var_0_0._tryClearClickCollider(arg_40_0)
	if arg_40_0.entity.collider then
		arg_40_0.entity.collider:clearColliderGOList()
	end
end

function var_0_0._tryUpdatePathfindingCollider(arg_41_0)
	RoomScenePathComp.addEntityCollider(arg_41_0.entity.go)
end

return var_0_0
