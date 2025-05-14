module("modules.logic.explore.map.ExploreMapUseItemComp", package.seeall)

local var_0_0 = class("ExploreMapUseItemComp", ExploreMapBaseComp)
local var_0_1 = UnityEngine.Shader.PropertyToID("_OcclusionThreshold")

function var_0_0.onInit(arg_1_0)
	arg_1_0._legalPosDic = {}
	arg_1_0._pos = Vector2.New()
	arg_1_0._mo = nil
	arg_1_0._highLightContainer = UnityEngine.GameObject.New("HighLight")

	gohelper.addChild(arg_1_0._mapGo, arg_1_0._highLightContainer)

	arg_1_0._path = ResUrl.getExploreEffectPath(ExploreConstValue.PlaceEffect)
	arg_1_0._tempUnitGo = nil
	arg_1_0._tempUnitLoader = nil
	arg_1_0._iconLoader = PrefabInstantiate.Create(arg_1_0._highLightContainer)

	arg_1_0._iconLoader:startLoad(arg_1_0._path, arg_1_0._onAssetLoad, arg_1_0)
	gohelper.setActive(arg_1_0._highLightContainer, false)

	arg_1_0._useList = {}
	arg_1_0._renderers = {}
end

function var_0_0._onAssetLoad(arg_2_0)
	local var_2_0 = arg_2_0._iconLoader:getInstGO()

	arg_2_0._goSelect = gohelper.findChild(var_2_0, "root/select")

	gohelper.setActive(arg_2_0._goSelect, false)

	arg_2_0._diban = {}

	for iter_2_0 = -1, 1 do
		for iter_2_1 = -1, 1 do
			if iter_2_0 ~= 0 or iter_2_1 ~= 0 then
				local var_2_1 = ExploreHelper.getKeyXY(iter_2_0, iter_2_1)

				arg_2_0._diban[var_2_1] = gohelper.findChild(var_2_0, "root/diban" .. var_2_1)
			end
		end
	end

	if arg_2_0._mo then
		arg_2_0:_updateHighLight()
	end
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0:addEventCb(ExploreController.instance, ExploreEvent.DragItemBegin, arg_3_0.changeStatus, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	arg_4_0:removeEventCb(ExploreController.instance, ExploreEvent.DragItemBegin, arg_4_0.changeStatus, arg_4_0)
end

function var_0_0.changeStatus(arg_5_0, arg_5_1)
	if not arg_5_0:beginStatus(arg_5_1) then
		ToastController.instance:showToast(ExploreConstValue.Toast.CantUseItem)

		return
	end
end

function var_0_0._onDragItemBegin(arg_6_0, arg_6_1)
	if arg_6_0._mo == arg_6_1 then
		if arg_6_0._tempUnitLoader then
			arg_6_0._tempUnitLoader:dispose()

			arg_6_0._tempUnitLoader = nil
		end

		gohelper.destroy(arg_6_0._tempUnitGo)

		arg_6_0._tempUnitGo = nil

		gohelper.setActive(arg_6_0._highLightContainer, false)
		arg_6_0:_resetMat()
		arg_6_0._map:setMapStatus(ExploreEnum.MapStatus.Normal)
	else
		gohelper.setActive(arg_6_0._highLightContainer, true)

		arg_6_0.highLightType = nil
		arg_6_0._legalPosDic = {}
		arg_6_0._mo = arg_6_1

		local var_6_0 = ExploreController.instance:getMap():getHero()
		local var_6_1 = var_6_0.nodePos

		if var_6_0:isMoving() then
			local var_6_2 = ExploreHelper.getKey(var_6_1)
			local var_6_3 = ExploreMapModel.instance:getNode(var_6_2)

			if ExploreModel.instance:isHeroInControl() and var_6_3.nodeType ~= ExploreEnum.NodeType.Ice then
				local var_6_4 = var_6_0:stopMoving(false)

				if var_6_4 then
					var_6_1 = var_6_4
				end
			else
				arg_6_0._map:setMapStatus(ExploreEnum.MapStatus.Normal)
				ToastController.instance:showToast(ExploreConstValue.Toast.CantUseItem)

				return
			end
		end

		if arg_6_0._tempUnitLoader then
			arg_6_0._tempUnitLoader:dispose()
		end

		gohelper.destroy(arg_6_0._tempUnitGo)

		local var_6_5 = tonumber(string.split(arg_6_1.config.effect, "#")[2])
		local var_6_6 = lua_explore_unit.configDict[var_6_5].asset

		arg_6_0._tempUnitGo = UnityEngine.GameObject.New("TempUnit")
		arg_6_0._tempUnitLoader = PrefabInstantiate.Create(arg_6_0._tempUnitGo)

		arg_6_0._tempUnitLoader:startLoad(var_6_6, arg_6_0.onUnitLoadEnd, arg_6_0)
		gohelper.setActive(arg_6_0._tempUnitGo, false)

		arg_6_0.highLightType = ExploreEnum.ItemEffectRange.Round

		if arg_6_0._goSelect then
			arg_6_0:_updateHighLight(var_6_1)
		end
	end
end

function var_0_0.onUnitLoadEnd(arg_7_0)
	local var_7_0 = arg_7_0._tempUnitLoader:getInstGO():GetComponentsInChildren(typeof(UnityEngine.Collider))

	for iter_7_0 = 0, var_7_0.Length - 1 do
		var_7_0[iter_7_0].enabled = false
	end
end

function var_0_0.getCurItemMo(arg_8_0)
	return arg_8_0._mo
end

function var_0_0.onMapClick(arg_9_0, arg_9_1)
	local var_9_0, var_9_1 = arg_9_0._map:GetTilemapMousePos(arg_9_1, true)

	if not arg_9_0:_setUnit(arg_9_0._mo.id, var_9_1) then
		arg_9_0._map:setMapStatus(ExploreEnum.MapStatus.Normal)
	end
end

function var_0_0.onStatusEnd(arg_10_0)
	arg_10_0:clearDrag()

	if arg_10_0._confirmView then
		arg_10_0._confirmView:setTarget()
	end

	if arg_10_0._tempUnitLoader then
		arg_10_0._tempUnitLoader:dispose()

		arg_10_0._tempUnitLoader = nil
	end

	gohelper.destroy(arg_10_0._tempUnitGo)

	arg_10_0._tempUnitGo = nil

	gohelper.setActive(arg_10_0._highLightContainer, false)
	arg_10_0:_resetMat()
	gohelper.setActive(arg_10_0._goSelect, false)
end

function var_0_0.onStatusStart(arg_11_0, arg_11_1)
	arg_11_0:_onDragItemBegin(arg_11_1)
end

function var_0_0.clearDrag(arg_12_0)
	arg_12_0.highLightType = nil
	arg_12_0._mo = nil

	arg_12_0:_updateHighLight()
end

function var_0_0._updateHighLight(arg_13_0, arg_13_1)
	arg_13_0._useList = {}

	local var_13_0 = false

	if arg_13_0._mo and arg_13_0._mo.itemEffect == ExploreEnum.ItemEffect.CreateUnit2 then
		var_13_0 = true
	end

	if arg_13_0.highLightType == ExploreEnum.ItemEffectRange.Round then
		arg_13_1 = arg_13_1 or arg_13_0._map:getHeroPos()

		local var_13_1 = arg_13_0._map:getHero():getPos()

		transformhelper.setPos(arg_13_0._highLightContainer.transform, var_13_1.x, var_13_1.y, var_13_1.z)

		for iter_13_0 = -1, 1 do
			for iter_13_1 = -1, 1 do
				local var_13_2 = ExploreHelper.getKeyXY(iter_13_0, iter_13_1)
				local var_13_3 = arg_13_0._diban[var_13_2]

				if (iter_13_0 == 0 and iter_13_1 == 0) == false and (not var_13_0 or iter_13_0 == 0 or iter_13_1 == 0) then
					arg_13_0._pos.x = arg_13_1.x + iter_13_0
					arg_13_0._pos.y = arg_13_1.y + iter_13_1

					local var_13_4 = ExploreHelper.getKey(arg_13_0._pos)

					arg_13_0._useList[var_13_4] = var_13_3

					local var_13_5 = ExploreMapModel.instance:getNode(var_13_4)
					local var_13_6 = true
					local var_13_7 = arg_13_0._map:getUnitByPos(arg_13_0._pos)

					for iter_13_2, iter_13_3 in pairs(var_13_7) do
						if iter_13_3:isEnter() and not iter_13_3.mo.canUseItem then
							var_13_6 = false

							break
						end
					end

					if var_13_6 and var_13_5 and var_13_5:isWalkable() then
						local var_13_8 = var_13_3.transform.position
						local var_13_9 = var_13_8.y

						var_13_8.y = 10

						local var_13_10, var_13_11 = UnityEngine.Physics.Raycast(var_13_8, Vector3.down, nil, Mathf.Infinity, ExploreHelper.getSceneMask())

						if var_13_10 then
							var_13_8.y = var_13_11.point.y + 0.027
						else
							var_13_8.y = var_13_9
						end

						for iter_13_4, iter_13_5 in pairs(var_13_7) do
							local var_13_12 = iter_13_5.go:GetComponentsInChildren(typeof(UnityEngine.MeshRenderer))

							for iter_13_6 = 0, var_13_12.Length - 1 do
								local var_13_13 = var_13_12[iter_13_6]

								if not arg_13_0._renderers[var_13_13] then
									arg_13_0._renderers[var_13_13] = true
								end

								local var_13_14 = var_13_13.material

								var_13_14:EnableKeyword("_OCCLUSION_CLIP")
								var_13_14:SetFloat(var_0_1, 0.5)
							end
						end

						gohelper.setActive(var_13_3, true)

						arg_13_0._legalPosDic[var_13_4] = var_13_8.y
					else
						gohelper.setActive(var_13_3, false)
					end
				else
					gohelper.setActive(var_13_3, false)
				end
			end
		end
	end
end

function var_0_0.onCancel(arg_14_0, arg_14_1)
	local var_14_0 = ExploreHelper.getKey(arg_14_1)

	gohelper.setActive(arg_14_0._goSelect, false)
	gohelper.setActive(arg_14_0._useList[var_14_0], true)
	gohelper.setActive(arg_14_0._tempUnitGo, false)
end

function var_0_0._setUnit(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_2 then
		local var_15_0 = ExploreHelper.getKey(arg_15_2)

		if arg_15_0._legalPosDic[var_15_0] then
			local var_15_1 = arg_15_0._mo.config.audioId

			if var_15_1 and var_15_1 > 0 then
				AudioMgr.instance:trigger(var_15_1)
			end

			local var_15_2 = arg_15_0._useList[var_15_0].transform.position

			arg_15_0._goSelect.transform.position = var_15_2
			var_15_2.y = arg_15_0._legalPosDic[var_15_0]
			arg_15_0._tempUnitGo.transform.position = var_15_2

			gohelper.setActive(arg_15_0._tempUnitGo, true)

			if not arg_15_0._confirmView then
				arg_15_0._confirmView = ExploreUseItemConfirmView.New()
			elseif arg_15_0._confirmView._targetPos then
				local var_15_3 = ExploreHelper.getKey(arg_15_0._confirmView._targetPos)

				gohelper.setActive(arg_15_0._useList[var_15_3], true)
			end

			arg_15_0._confirmView:setTarget(arg_15_0._goSelect, arg_15_2)
			gohelper.setActive(arg_15_0._goSelect, true)
			gohelper.setActive(arg_15_0._useList[var_15_0], false)

			return true
		end
	end
end

function var_0_0._resetMat(arg_16_0)
	for iter_16_0 in pairs(arg_16_0._renderers) do
		if not tolua.isnull(iter_16_0) then
			iter_16_0.material:DisableKeyword("_OCCLUSION_CLIP")
		end
	end

	arg_16_0._renderers = {}
end

function var_0_0.onDestroy(arg_17_0)
	if arg_17_0._confirmView then
		arg_17_0._confirmView:dispose()

		arg_17_0._confirmView = nil
	end

	if arg_17_0._iconLoader then
		arg_17_0._iconLoader:dispose()

		arg_17_0._iconLoader = nil
	end

	if arg_17_0._tempUnitLoader then
		arg_17_0._tempUnitLoader:dispose()

		arg_17_0._tempUnitLoader = nil
	end

	arg_17_0._renderers = {}

	gohelper.destroy(arg_17_0._tempUnitGo)

	arg_17_0._tempUnitGo = nil
	arg_17_0._goSelect = nil
	arg_17_0._diban = nil
	arg_17_0._mo = nil

	gohelper.destroy(arg_17_0._highLightContainer)

	arg_17_0._highLightContainer = nil

	var_0_0.super.onDestroy(arg_17_0)
end

return var_0_0
