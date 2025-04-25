module("modules.logic.room.entity.comp.RoomEffectComp", package.seeall)

slot0 = class("RoomEffectComp", LuaCompBase)
slot0.SCENE_TRANSPARNET_OBJECT_KEY = "__transparent_set_layer_"

function slot0.ctor(slot0, slot1)
	slot0.entity = slot1
	slot0.__willDestroy = false
end

function slot0.init(slot0, slot1)
	slot0._scene = GameSceneMgr.instance:getCurScene()
	slot0.go = slot1
	slot0._paramDict = {}
	slot0._applyParamDict = {}
	slot0._goDict = slot0:getUserDataTb_()
	slot0._goTransformDict = slot0:getUserDataTb_()
	slot0._animatorDict = slot0:getUserDataTb_()
	slot0._resDict = {}
	slot0._goActiveDict = {}
	slot0._goHasDict = {}
	slot0._delayDestroyDict = {}
	slot0._delayDestroyMinTime = nil
	slot0._sameNameComponentsDic = {}
	slot0._typeComponentsData = RoomEffectCompCacheData.New(slot0)
	slot0._goSameNameChildsData = RoomEffectCompCacheData.New(slot0)
	slot0._goPathChildsData = RoomEffectCompCacheData.New(slot0)
	slot0._goSameNameChildsTrsData = RoomEffectCompCacheData.New(slot0)
	slot0._goPathChildsTrsData = RoomEffectCompCacheData.New(slot0)
	slot0.isEmulator = SDKMgr.instance:isEmulator()
end

function slot0.addEventListeners(slot0)
end

function slot0.removeEventListeners(slot0)
end

function slot0.beforeDestroy(slot0)
	slot0.__willDestroy = true

	TaskDispatcher.cancelTask(slot0._delayDestroy, slot0)
	slot0:removeEventListeners()
	slot0:returnAllEffect()
end

function slot0.isHasKey(slot0, slot1)
	if slot0._delayDestroyDict[slot1] then
		return false
	end

	if slot0._paramDict[slot1] == nil then
		return false
	end

	return true
end

function slot0.addParams(slot0, slot1, slot2)
	if slot0.__willDestroy then
		return
	end

	for slot7, slot8 in pairs(slot1) do
		slot0._paramDict[slot7] = slot8

		if slot2 and slot2 > 0 then
			slot0._delayDestroyDict[slot7] = slot2 + Time.time
		else
			slot0._delayDestroyDict[slot7] = nil
		end
	end

	slot0:_refreshDelayDestroyTask()
end

function slot0._refreshDelayDestroyTask(slot0)
	slot1 = nil

	for slot5, slot6 in pairs(slot0._delayDestroyDict) do
		if slot6 and (not slot1 or slot6 < slot1) then
			slot1 = slot6
		end
	end

	if (slot1 and slot1 - Time.time) == nil and slot0._delayDestroyMinTime then
		slot0._delayDestroyMinTime = nil

		TaskDispatcher.cancelTask(slot0._delayDestroy, slot0)
	end

	if slot1 and (slot0._delayDestroyMinTime == nil or slot1 < slot0._delayDestroyMinTime) then
		if slot0._delayDestroyMinTime then
			TaskDispatcher.cancelTask(slot0._delayDestroy, slot0)
		end

		slot0._delayDestroyMinTime = slot1

		TaskDispatcher.runDelay(slot0._delayDestroy, slot0, slot0._delayDestroyMinTime)
	end
end

function slot0._delayDestroy(slot0)
	slot0._delayDestroyMinTime = nil
	slot2 = {}

	for slot6, slot7 in pairs(slot0._delayDestroyDict) do
		if slot7 and slot7 <= Time.time + 0.001 then
			table.insert(slot2, slot6)
		end
	end

	slot0:removeParams(slot2)
	slot0:refreshEffect()
end

function slot0.changeParams(slot0, slot1)
	for slot5, slot6 in pairs(slot1) do
		if slot0._paramDict[slot5] then
			for slot10, slot11 in pairs(slot6) do
				slot0._paramDict[slot5][slot10] = slot11
			end
		end
	end
end

function slot0.removeParams(slot0, slot1, slot2)
	for slot7, slot8 in ipairs(slot1) do
		if slot2 and slot2 > 0 then
			slot0._delayDestroyDict[slot8] = slot2 + Time.time
		else
			slot0._paramDict[slot8] = nil
			slot0._delayDestroyDict[slot8] = nil
		end
	end

	slot0:_refreshDelayDestroyTask()
end

function slot0.getEffectGOTrs(slot0, slot1)
	return slot0._goTransformDict[slot1]
end

function slot0.getEffectGO(slot0, slot1)
	return slot0._goDict[slot1]
end

function slot0.getEffectRes(slot0, slot1)
	return slot0._resDict[slot1]
end

function slot0.isSameResByKey(slot0, slot1, slot2)
	return slot0._resDict[slot1] == slot2
end

function slot0.isHasEffectGOByKey(slot0, slot1)
	return slot0._goHasDict[slot1]
end

function slot0.setActiveByKey(slot0, slot1, slot2)
	if slot0.__willDestroy or slot2 == nil then
		return
	end

	if slot0._goActiveDict[slot1] ~= (slot2 and true or false) then
		slot0._goActiveDict[slot1] = slot3

		if slot0._goHasDict[slot1] then
			gohelper.setActive(slot0._goDict[slot1], slot3)
		end
	end
end

function slot0.playEffectAnimator(slot0, slot1, slot2)
	if slot0.__willDestroy then
		return
	end

	if slot0._animatorDict[slot1] == nil and slot0:getEffectGO(slot1) then
		slot0._animatorDict[slot1] = slot4:GetComponent(RoomEnum.ComponentType.Animator) or false
	end

	if slot3 then
		slot3:Play(slot2, 0, 0)

		return true
	end
end

function slot0.getMeshRenderersByKey(slot0, slot1)
	return slot0:getComponentsByKey(slot1, RoomEnum.ComponentName.MeshRenderer)
end

function slot0.getMeshRenderersByPath(slot0, slot1, slot2)
	return slot0:getComponentsByPath(slot1, RoomEnum.ComponentName.MeshRenderer, slot2)
end

function slot0.getComponentsByPath(slot0, slot1, slot2, slot3)
	if not RoomEnum.ComponentType[slot2] then
		return
	end

	slot6 = slot0:_getSameCacheData(slot2):getDataByKey(slot1, slot3)

	if slot0.__willDestroy then
		return slot6
	end

	if not slot6 and slot0._goHasDict[slot1] then
		slot5:addDataByKey(slot1, slot3, {})

		if gohelper.findChild(slot0._goDict[slot1], slot3) then
			slot0:_cArrayToLuaTable(slot7:GetComponentsInChildren(slot4, true), slot6)
		end
	end

	return slot6
end

function slot0._getSameCacheData(slot0, slot1)
	if not slot0._sameNameComponentsDic[slot1] then
		slot0._sameNameComponentsDic[slot1] = RoomEffectCompCacheData.New(slot0)
	end

	return slot2
end

function slot0.getComponentsByKey(slot0, slot1, slot2)
	if not RoomEnum.ComponentType[slot2] then
		return
	end

	slot4 = slot0._typeComponentsData:getDataByKey(slot1, slot2)

	if slot0.__willDestroy then
		return slot4
	end

	if not slot4 and slot0._goHasDict[slot1] then
		slot4 = {}

		slot0._typeComponentsData:addDataByKey(slot1, slot2, slot4)
		slot0:_cArrayToLuaTable(slot0._goDict[slot1]:GetComponentsInChildren(slot3, true), slot4)
	end

	return slot4
end

function slot0.getGameObjectsByName(slot0, slot1, slot2)
	slot3 = slot0._goSameNameChildsData:getDataByKey(slot1, slot2)

	if slot0.__willDestroy then
		return slot3
	end

	if not slot3 and slot0._goHasDict[slot1] then
		slot0._goSameNameChildsData:addDataByKey(slot1, slot2, {})

		if uv0.SCENE_TRANSPARNET_OBJECT_KEY == slot2 then
			for slot8 = 1, #slot0:getMeshRenderersByKey(slot1) do
				if string.find(slot4[slot8].name, "transparent") and slot10 == 1 then
					table.insert(slot3, slot9.gameObject)
				end
			end
		else
			RoomHelper.getGameObjectsByNameInChildren(slot0._goDict[slot1], slot2, slot3)
		end
	end

	return slot3
end

function slot0.getGameObjectByPath(slot0, slot1, slot2)
	slot3 = slot0._goPathChildsData:getDataByKey(slot1, slot2)

	if not slot0.__willDestroy and not slot3 and slot0._goHasDict[slot1] then
		slot0._goPathChildsData:addDataByKey(slot1, slot2, {})

		if gohelper.findChild(slot0._goDict[slot1], slot2) then
			table.insert(slot3, slot4)
		end
	end

	if slot3 then
		return slot3[1]
	end
end

function slot0.getGameObjectsTrsByName(slot0, slot1, slot2)
	slot3 = slot0._goSameNameChildsTrsData:getDataByKey(slot1, slot2)

	if slot0.__willDestroy then
		return slot3
	end

	if not slot3 and slot0._goHasDict[slot1] and slot0:getGameObjectsByName(slot1, slot2) then
		slot8 = slot2
		slot9 = {}

		slot0._goSameNameChildsTrsData:addDataByKey(slot1, slot8, slot9)

		for slot8, slot9 in ipairs(slot4) do
			table.insert(slot3, slot9.transform)
		end
	end

	return slot3
end

function slot0.getGameObjectTrsByPath(slot0, slot1, slot2)
	slot3 = slot0._goPathChildsTrsData:getDataByKey(slot1, slot2)

	if not slot0.__willDestroy and not slot3 and slot0._goHasDict[slot1] then
		slot0._goPathChildsTrsData:addDataByKey(slot1, slot2, {})

		if slot0:getGameObjectByPath(slot1, slot2) then
			table.insert(slot3, slot4)
		end
	end

	if slot3 then
		return slot3[1]
	end
end

function slot0.removeComponentsByKey(slot0, slot1)
	slot0._typeComponentsData:removeDataByKey(slot1)
	slot0._goSameNameChildsData:removeDataByKey(slot1)
	slot0._goPathChildsData:removeDataByKey(slot1)
	slot0._goSameNameChildsTrsData:removeDataByKey(slot1)
	slot0._goPathChildsTrsData:removeDataByKey(slot1)

	for slot5, slot6 in pairs(slot0._sameNameComponentsDic) do
		slot6:removeDataByKey(slot1)
	end
end

function slot0.refreshEffect(slot0)
	if slot0.__willDestroy then
		return
	end

	slot1 = false

	for slot5, slot6 in pairs(slot0._resDict) do
		if not slot0._paramDict[slot5] or slot7.res ~= slot6 then
			slot0:returnEffect(slot5, slot0._goDict[slot5], slot6)

			if slot0._applyParamDict[slot5] and slot8.pathfinding then
				slot1 = true
			end
		end
	end

	slot2 = {}

	for slot7, slot8 in pairs(slot0._paramDict) do
		if GameResMgr.IsFromEditorDir then
			table.insert(slot2, slot8.res)
		else
			table.insert(slot2, slot8.ab or slot8.res)
		end
	end

	GameSceneMgr.instance:getCurScene().loader:makeSureLoaded(slot2, slot0._rebuildEffect, slot0)
	slot0:_tryClearClickCollider()

	if slot1 then
		slot0:_tryUpdatePathfindingCollider()
	end
end

function slot0._rebuildEffect(slot0)
	if slot0.__willDestroy then
		return
	end

	slot1 = false
	slot2 = GameSceneMgr.instance:getCurScene().preloader
	slot3 = GameResMgr.IsFromEditorDir

	for slot7, slot8 in pairs(slot0._paramDict) do
		slot10 = slot0._goTransformDict[slot7]
		slot11 = true

		if slot0._goDict[slot7] then
			slot11 = false
		end

		slot12 = slot8.res
		slot13 = slot8.ab
		slot14 = slot8.localPos or slot11 and Vector3.zero
		slot15 = slot8.localRotation or slot11 and Vector3.zero
		slot16 = slot8.localScale or slot11 and Vector3.one
		slot17 = slot8.layer
		slot18 = slot8.shadow
		slot19 = slot8.batch
		slot20 = slot8.highlight
		slot21 = slot8.alphaThreshold
		slot22 = slot8.isInventory
		slot23 = slot0._applyParamDict[slot7]

		if slot11 and slot2 and slot2:exist(slot3 and slot12 or slot13 or slot12) then
			slot24 = slot0.entity.containerGO

			if slot8.containerGO then
				slot24 = slot8.containerGO
			end

			slot9 = RoomGOPool.getInstance(slot12, slot24, slot8.name or slot7, slot13)
			slot0._goDict[slot7] = slot9
			slot0._goTransformDict[slot7] = slot9.transform
			slot0._resDict[slot7] = slot12
			slot0._goHasDict[slot7] = true

			if slot8.pathfinding then
				slot1 = true
			end

			if slot8.deleteChildPath and gohelper.findChild(slot9, slot8.deleteChildPath) then
				gohelper.addChild(RoomGOPool.getPoolContainerGO(), slot26)
				gohelper.destroy(slot26)
			end

			if slot0._goActiveDict[slot7] ~= nil then
				gohelper.setActive(slot9, slot0._goActiveDict[slot7])
			end
		end

		if slot9 then
			if slot8.containerGO then
				slot8.containerGO = nil
			end

			if slot14 then
				transformhelper.setLocalPos(slot10, slot14.x, slot14.y, slot14.z)
			end

			if slot15 then
				transformhelper.setLocalRotation(slot10, slot15.x, slot15.y, slot15.z)
			end

			if slot16 then
				transformhelper.setLocalScale(slot10, slot16.x, slot16.y, slot16.z)
			end

			if slot19 ~= nil and (not slot23 or slot23.batch ~= slot19) then
				slot0:setBatch(slot7, slot19)
			end

			if slot17 ~= nil and (not slot23 or slot23.layer ~= slot17) and slot17 ~= UnityLayer.SceneOpaque then
				slot0:setLayer(slot7, slot17)
			end

			CurveWorldRenderer.InitCurveWorldRenderer(slot9)

			if slot18 ~= nil and (not slot23 or slot23.shadow ~= slot18) then
				slot0:setShadow(slot7, slot18)
			end

			slot24 = false
			slot25 = false

			if not slot23 or slot20 ~= nil and slot23.highlight ~= slot20 then
				slot24 = true
			end

			if not slot23 or slot22 ~= nil and slot23.isInventory ~= slot22 then
				slot25 = slot22
			end

			if not slot23 or slot21 ~= nil and slot23.alphaThreshold ~= slot21 then
				slot24 = true
			end

			if slot24 then
				slot0:setMPB(slot7, slot20, slot21, slot8.alphaThresholdValue)
			end

			if slot25 then
				slot0:setDimdegeKey(slot7, false)
			end

			slot0._applyParamDict[slot7] = tabletool.copy(slot8)
		end
	end

	slot0:_tryClearClickCollider()

	if slot0.entity.onEffectRebuild then
		slot0.entity:onEffectRebuild()
	end

	for slot7, slot8 in ipairs(RoomEnum.EffectRebuildCompNames) do
		if slot0.entity[slot8] and slot9.onEffectRebuild then
			slot9:onEffectRebuild()
		end
	end

	if slot1 then
		slot0:_tryUpdatePathfindingCollider()
	end
end

function slot0.setLayer(slot0, slot1, slot2)
	if not slot0._goDict[slot1] then
		return
	end

	if slot2 == UnityLayer.SceneOrthogonalOpaque then
		RenderPipelineSetting.SetChildRenderLayerMask(slot3, 7, 8, true)
		RenderPipelineSetting.SetChildRenderLayerMask(slot3, 0, 8, false)
	else
		RenderPipelineSetting.SetChildRenderLayerMask(slot3, 0, 8, true)
		RenderPipelineSetting.SetChildRenderLayerMask(slot3, 7, 8, false)
	end
end

function slot0.setShadow(slot0, slot1, slot2)
	if slot0:getMeshRenderersByKey(slot1) then
		for slot7 = 1, #slot3 do
			slot8 = slot3[slot7]

			if slot2 then
				slot8.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.On
				slot8.receiveShadows = true
			else
				slot8.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.Off
				slot8.receiveShadows = false
			end
		end
	end
end

function slot0.setBatch(slot0, slot1, slot2)
	if slot0:getComponentsByKey(slot1, RoomEnum.ComponentName.BatchRendererEntity) then
		for slot7 = 1, #slot3 do
			slot3[slot7].enabled = slot2
		end
	end
end

function slot0.setMPB(slot0, slot1, slot2, slot3, slot4)
	slot5 = slot0:getMeshRenderersByKey(slot1)
	slot7 = nil

	if slot2 or slot3 then
		GameSceneMgr.instance:getCurScene().mapmgr:getPropertyBlock():Clear()

		if slot2 then
			slot7:SetVector("_Highlight", Vector4.New(0.3, 0.19, 0.06, 0))
		end

		if slot3 then
			slot7:SetFloat("_AlphaThreshold", slot4 or 0.6)
		end
	end

	if slot5 then
		for slot11 = 1, #slot5 do
			slot12 = slot5[slot11]

			if slot3 ~= nil then
				MaterialReplaceHelper.SetRendererKeyworld(slot12, "_SCREENCOORD", slot3 and true or false)
			end

			slot12:SetPropertyBlock(slot7)
		end
	end
end

function slot0.setDimdegeKey(slot0, slot1, slot2)
	if slot0:getMeshRenderersByKey(slot1) then
		slot4 = GameSceneMgr.instance:getCurScene().mapmgr:getPropertyBlock()

		slot4:Clear()
		slot4:SetFloat("_DimEdgeSize", slot2 and 0 or 1)

		for slot8 = 1, #slot3 do
			slot3[slot8]:SetPropertyBlock(slot4)
		end
	end
end

function slot0.setMaterialKeyword(slot0, slot1, slot2, slot3)
	if slot0:_cArrayToLuaTable(slot1.materials) then
		for slot8 = 1, #slot4 do
			if slot3 then
				slot4[slot8]:EnableKeyword(slot2)
			else
				slot9:DisableKeyword(slot2)
			end
		end
	end
end

function slot0.returnEffect(slot0, slot1, slot2, slot3)
	if not slot2 or string.nilorempty(slot3) then
		return
	end

	if slot0._applyParamDict[slot1] then
		if slot4.isInventory then
			slot0:setDimdegeKey(slot1, true)
		end

		if slot4.layer and slot4.layer ~= UnityLayer.SceneOpaque then
			slot0:setLayer(slot1, UnityLayer.SceneOpaque)
		end

		if slot4.batch == false then
			slot0:setBatch(true)
		end

		if slot0._goActiveDict[slot1] == false then
			gohelper.setActive(slot0._goDict[slot1], true)
		end
	end

	for slot8, slot9 in ipairs(RoomEnum.EffectRebuildCompNames) do
		if slot0.entity[slot9] and slot10.onEffectReturn then
			slot10:onEffectReturn(slot1, slot3)
		end
	end

	RoomGOPool.returnInstance(slot3, slot2)
	slot0:removeComponentsByKey(slot1)

	slot0._goDict[slot1] = nil
	slot0._resDict[slot1] = nil
	slot0._animatorDict[slot1] = nil
	slot0._applyParamDict[slot1] = nil
	slot0._goTransformDict[slot1] = nil
	slot0._goActiveDict[slot1] = nil
	slot0._goHasDict[slot1] = nil
end

function slot0.returnAllEffect(slot0)
	TaskDispatcher.cancelTask(slot0._delayDestroy, slot0)

	for slot4, slot5 in pairs(slot0._resDict) do
		slot0:returnEffect(slot4, slot0._goDict[slot4], slot5)
	end

	slot0._resDict = nil
	slot0._paramDict = nil
	slot0._applyParamDict = nil
end

function slot0._cArrayToLuaTable(slot0, slot1, slot2)
	return RoomHelper.cArrayToLuaTable(slot1, slot2)
end

function slot0._tryClearClickCollider(slot0)
	if slot0.entity.collider then
		slot0.entity.collider:clearColliderGOList()
	end
end

function slot0._tryUpdatePathfindingCollider(slot0)
	RoomScenePathComp.addEntityCollider(slot0.entity.go)
end

return slot0
