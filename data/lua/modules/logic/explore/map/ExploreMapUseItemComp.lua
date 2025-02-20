module("modules.logic.explore.map.ExploreMapUseItemComp", package.seeall)

slot0 = class("ExploreMapUseItemComp", ExploreMapBaseComp)
slot1 = UnityEngine.Shader.PropertyToID("_OcclusionThreshold")

function slot0.onInit(slot0)
	slot0._legalPosDic = {}
	slot0._pos = Vector2.New()
	slot0._mo = nil
	slot0._highLightContainer = UnityEngine.GameObject.New("HighLight")

	gohelper.addChild(slot0._mapGo, slot0._highLightContainer)

	slot0._path = ResUrl.getExploreEffectPath(ExploreConstValue.PlaceEffect)
	slot0._tempUnitGo = nil
	slot0._tempUnitLoader = nil
	slot0._iconLoader = PrefabInstantiate.Create(slot0._highLightContainer)

	slot0._iconLoader:startLoad(slot0._path, slot0._onAssetLoad, slot0)
	gohelper.setActive(slot0._highLightContainer, false)

	slot0._useList = {}
	slot0._renderers = {}
end

function slot0._onAssetLoad(slot0)
	slot0._goSelect = gohelper.findChild(slot0._iconLoader:getInstGO(), "root/select")
	slot5 = false

	gohelper.setActive(slot0._goSelect, slot5)

	slot0._diban = {}

	for slot5 = -1, 1 do
		for slot9 = -1, 1 do
			if slot5 ~= 0 or slot9 ~= 0 then
				slot10 = ExploreHelper.getKeyXY(slot5, slot9)
				slot0._diban[slot10] = gohelper.findChild(slot1, "root/diban" .. slot10)
			end
		end
	end

	if slot0._mo then
		slot0:_updateHighLight()
	end
end

function slot0.addEventListeners(slot0)
	slot0:addEventCb(ExploreController.instance, ExploreEvent.DragItemBegin, slot0.changeStatus, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0:removeEventCb(ExploreController.instance, ExploreEvent.DragItemBegin, slot0.changeStatus, slot0)
end

function slot0.changeStatus(slot0, slot1)
	if not slot0:beginStatus(slot1) then
		ToastController.instance:showToast(ExploreConstValue.Toast.CantUseItem)

		return
	end
end

function slot0._onDragItemBegin(slot0, slot1)
	if slot0._mo == slot1 then
		if slot0._tempUnitLoader then
			slot0._tempUnitLoader:dispose()

			slot0._tempUnitLoader = nil
		end

		gohelper.destroy(slot0._tempUnitGo)

		slot0._tempUnitGo = nil

		gohelper.setActive(slot0._highLightContainer, false)
		slot0:_resetMat()
		slot0._map:setMapStatus(ExploreEnum.MapStatus.Normal)
	else
		gohelper.setActive(slot0._highLightContainer, true)

		slot0.highLightType = nil
		slot0._legalPosDic = {}
		slot0._mo = slot1
		slot2 = ExploreController.instance:getMap():getHero()

		if slot2:isMoving() then
			if ExploreModel.instance:isHeroInControl() and ExploreMapModel.instance:getNode(ExploreHelper.getKey(slot2.nodePos)).nodeType ~= ExploreEnum.NodeType.Ice then
				if slot2:stopMoving(false) then
					slot3 = slot6
				end
			else
				slot0._map:setMapStatus(ExploreEnum.MapStatus.Normal)
				ToastController.instance:showToast(ExploreConstValue.Toast.CantUseItem)

				return
			end
		end

		if slot0._tempUnitLoader then
			slot0._tempUnitLoader:dispose()
		end

		gohelper.destroy(slot0._tempUnitGo)

		slot0._tempUnitGo = UnityEngine.GameObject.New("TempUnit")
		slot0._tempUnitLoader = PrefabInstantiate.Create(slot0._tempUnitGo)

		slot0._tempUnitLoader:startLoad(lua_explore_unit.configDict[tonumber(string.split(slot1.config.effect, "#")[2])].asset, slot0.onUnitLoadEnd, slot0)
		gohelper.setActive(slot0._tempUnitGo, false)

		slot0.highLightType = ExploreEnum.ItemEffectRange.Round

		if slot0._goSelect then
			slot0:_updateHighLight(slot3)
		end
	end
end

function slot0.onUnitLoadEnd(slot0)
	for slot6 = 0, slot0._tempUnitLoader:getInstGO():GetComponentsInChildren(typeof(UnityEngine.Collider)).Length - 1 do
		slot2[slot6].enabled = false
	end
end

function slot0.getCurItemMo(slot0)
	return slot0._mo
end

function slot0.onMapClick(slot0, slot1)
	slot2, slot3 = slot0._map:GetTilemapMousePos(slot1, true)

	if not slot0:_setUnit(slot0._mo.id, slot3) then
		slot0._map:setMapStatus(ExploreEnum.MapStatus.Normal)
	end
end

function slot0.onStatusEnd(slot0)
	slot0:clearDrag()

	if slot0._confirmView then
		slot0._confirmView:setTarget()
	end

	if slot0._tempUnitLoader then
		slot0._tempUnitLoader:dispose()

		slot0._tempUnitLoader = nil
	end

	gohelper.destroy(slot0._tempUnitGo)

	slot0._tempUnitGo = nil

	gohelper.setActive(slot0._highLightContainer, false)
	slot0:_resetMat()
	gohelper.setActive(slot0._goSelect, false)
end

function slot0.onStatusStart(slot0, slot1)
	slot0:_onDragItemBegin(slot1)
end

function slot0.clearDrag(slot0)
	slot0.highLightType = nil
	slot0._mo = nil

	slot0:_updateHighLight()
end

function slot0._updateHighLight(slot0, slot1)
	slot0._useList = {}
	slot2 = false

	if slot0._mo and slot0._mo.itemEffect == ExploreEnum.ItemEffect.CreateUnit2 then
		slot2 = true
	end

	if slot0.highLightType == ExploreEnum.ItemEffectRange.Round then
		slot1 = slot1 or slot0._map:getHeroPos()
		slot3 = slot0._map:getHero():getPos()

		transformhelper.setPos(slot0._highLightContainer.transform, slot3.x, slot3.y, slot3.z)

		for slot7 = -1, 1 do
			for slot11 = -1, 1 do
				if (slot7 == 0 and slot11 == 0) == false and (not slot2 or slot7 == 0 or slot11 == 0) then
					slot0._pos.x = slot1.x + slot7
					slot0._pos.y = slot1.y + slot11
					slot14 = ExploreHelper.getKey(slot0._pos)
					slot0._useList[slot14] = slot0._diban[ExploreHelper.getKeyXY(slot7, slot11)]
					slot15 = ExploreMapModel.instance:getNode(slot14)
					slot16 = true

					for slot21, slot22 in pairs(slot0._map:getUnitByPos(slot0._pos)) do
						if slot22:isEnter() and not slot22.mo.canUseItem then
							slot16 = false

							break
						end
					end

					if slot16 and slot15 and slot15:isWalkable() then
						slot18 = slot13.transform.position
						slot19 = slot18.y
						slot18.y = 10
						slot20, slot21 = UnityEngine.Physics.Raycast(slot18, Vector3.down, nil, Mathf.Infinity, ExploreHelper.getSceneMask())

						if slot20 then
							slot18.y = slot21.point.y + 0.027
						else
							slot18.y = slot19
						end

						for slot25, slot26 in pairs(slot17) do
							for slot31 = 0, slot26.go:GetComponentsInChildren(typeof(UnityEngine.MeshRenderer)).Length - 1 do
								if not slot0._renderers[slot27[slot31]] then
									slot0._renderers[slot32] = true
								end

								slot33 = slot32.material

								slot33:EnableKeyword("_OCCLUSION_CLIP")
								slot33:SetFloat(uv0, 0.5)
							end
						end

						gohelper.setActive(slot13, true)

						slot0._legalPosDic[slot14] = slot18.y
					else
						gohelper.setActive(slot13, false)
					end
				else
					gohelper.setActive(slot13, false)
				end
			end
		end
	end
end

function slot0.onCancel(slot0, slot1)
	gohelper.setActive(slot0._goSelect, false)
	gohelper.setActive(slot0._useList[ExploreHelper.getKey(slot1)], true)
	gohelper.setActive(slot0._tempUnitGo, false)
end

function slot0._setUnit(slot0, slot1, slot2)
	if slot2 and slot0._legalPosDic[ExploreHelper.getKey(slot2)] then
		if slot0._mo.config.audioId and slot4 > 0 then
			AudioMgr.instance:trigger(slot4)
		end

		slot5 = slot0._useList[slot3].transform.position
		slot0._goSelect.transform.position = slot5
		slot5.y = slot0._legalPosDic[slot3]
		slot0._tempUnitGo.transform.position = slot5

		gohelper.setActive(slot0._tempUnitGo, true)

		if not slot0._confirmView then
			slot0._confirmView = ExploreUseItemConfirmView.New()
		elseif slot0._confirmView._targetPos then
			gohelper.setActive(slot0._useList[ExploreHelper.getKey(slot0._confirmView._targetPos)], true)
		end

		slot0._confirmView:setTarget(slot0._goSelect, slot2)
		gohelper.setActive(slot0._goSelect, true)
		gohelper.setActive(slot0._useList[slot3], false)

		return true
	end
end

function slot0._resetMat(slot0)
	for slot4 in pairs(slot0._renderers) do
		if not tolua.isnull(slot4) then
			slot4.material:DisableKeyword("_OCCLUSION_CLIP")
		end
	end

	slot0._renderers = {}
end

function slot0.onDestroy(slot0)
	if slot0._confirmView then
		slot0._confirmView:dispose()

		slot0._confirmView = nil
	end

	if slot0._iconLoader then
		slot0._iconLoader:dispose()

		slot0._iconLoader = nil
	end

	if slot0._tempUnitLoader then
		slot0._tempUnitLoader:dispose()

		slot0._tempUnitLoader = nil
	end

	slot0._renderers = {}

	gohelper.destroy(slot0._tempUnitGo)

	slot0._tempUnitGo = nil
	slot0._goSelect = nil
	slot0._diban = nil
	slot0._mo = nil

	gohelper.destroy(slot0._highLightContainer)

	slot0._highLightContainer = nil

	uv0.super.onDestroy(slot0)
end

return slot0
