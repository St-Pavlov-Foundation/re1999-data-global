module("modules.logic.room.entity.RoomMapBlockEntity", package.seeall)

local var_0_0 = class("RoomMapBlockEntity", RoomBaseBlockEntity)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)

	arg_1_0._placingHereRotation = nil
	arg_1_0._pathfindingEnabled = true
	arg_1_0._highlightDic = {}
end

function var_0_0.getTag(arg_2_0)
	return SceneTag.RoomMapBlock
end

function var_0_0.init(arg_3_0, arg_3_1)
	var_0_0.super.init(arg_3_0, arg_3_1)
	arg_3_0:addAmbientAudio()
end

function var_0_0.initComponents(arg_4_0)
	var_0_0.super.initComponents(arg_4_0)

	if RoomController.instance:isDebugPackageMode() then
		arg_4_0:addComp("debugpackageui", RoomDebugPackageUIComp)
	end

	arg_4_0:addComp("nightlight", RoomNightLightComp)
	arg_4_0:addComp("birthday", RoomMapBlockBirthdayComp)
	arg_4_0.nightlight:setEffectKey(RoomEnum.EffectKey.BlockLandKey)
end

function var_0_0.onStart(arg_5_0)
	var_0_0.super.onStart(arg_5_0)
	RoomMapController.instance:registerCallback(RoomEvent.ResourceLight, arg_5_0._refreshLightEffect, arg_5_0)
	RoomMapController.instance:registerCallback(RoomEvent.StartPlayAmbientAudio, arg_5_0.playAmbientAudio, arg_5_0)
	RoomDebugController.instance:registerCallback(RoomEvent.DebugSetPackage, arg_5_0.refreshPackage, arg_5_0)
	RoomDebugController.instance:registerCallback(RoomEvent.DebugPackageOrderChanged, arg_5_0.refreshPackage, arg_5_0)
	RoomDebugController.instance:registerCallback(RoomEvent.DebugPackageListShowChanged, arg_5_0.refreshPackage, arg_5_0)
	RoomDebugController.instance:registerCallback(RoomEvent.DebugPackageFilterChanged, arg_5_0.refreshPackage, arg_5_0)
end

function var_0_0.setLocalPos(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	var_0_0.super.setLocalPos(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0:refreshName()
end

function var_0_0.onEffectRebuild(arg_7_0)
	var_0_0.super.onEffectRebuild(arg_7_0)
	arg_7_0:_refreshLandLightEffect()
	arg_7_0:_refreshLinkGO()

	local var_7_0 = arg_7_0:getMO()

	arg_7_0:_refreshWaterGradient(var_7_0)
	arg_7_0.birthday:refreshBirthday()
end

function var_0_0.refreshBlock(arg_8_0)
	var_0_0.super.refreshBlock(arg_8_0)

	local var_8_0 = arg_8_0:getMO()

	if var_8_0.blockState == RoomBlockEnum.BlockState.Temp then
		if not arg_8_0.effect:isHasEffectGOByKey(RoomEnum.EffectKey.BlockTempPlaceKey) then
			arg_8_0.effect:addParams({
				[RoomEnum.EffectKey.BlockTempPlaceKey] = {
					res = RoomScenePreloader.ResEffectB
				}
			})
		end
	elseif arg_8_0.effect:isHasEffectGOByKey(RoomEnum.EffectKey.BlockTempPlaceKey) then
		arg_8_0.effect:removeParams({
			RoomEnum.EffectKey.BlockTempPlaceKey
		})

		arg_8_0._placingHereRotation = nil
	end

	local var_8_1 = var_8_0:getOpState() == RoomBlockEnum.OpState.Back
	local var_8_2 = RoomWaterReformModel.instance:isWaterReform() and RoomWaterReformModel.instance:isBlockInSelect(var_8_0)

	if var_8_1 or var_8_2 then
		local var_8_3

		if var_8_2 then
			if var_8_0:hasRiver() then
				var_8_3 = RoomScenePreloader.ResEffectD03
			else
				var_8_3 = RoomScenePreloader.ResEffectD04
			end
		elseif var_8_1 then
			var_8_3 = var_8_0:getOpStateParam() and RoomScenePreloader.ResEffectD03 or RoomScenePreloader.ResEffectD04
		end

		if var_8_3 and arg_8_0._lastSelectEffPath ~= var_8_3 then
			arg_8_0._lastSelectEffPath = var_8_3

			arg_8_0.effect:addParams({
				[RoomEnum.EffectKey.BlockBackBlockKey] = {
					res = var_8_3
				}
			})
		end
	elseif arg_8_0.effect:isHasEffectGOByKey(RoomEnum.EffectKey.BlockBackBlockKey) then
		arg_8_0._lastSelectEffPath = nil

		arg_8_0:removeParamsAndPlayAnimator({
			RoomEnum.EffectKey.BlockBackBlockKey
		}, "close", RoomBlockEnum.PlaceEffectAnimatorCloseTime)
	end

	arg_8_0:_refreshLightEffect()
	arg_8_0:refreshPackage()
	arg_8_0.effect:refreshEffect()
	arg_8_0:_refreshLinkGO()
	arg_8_0.birthday:refreshBirthday()
end

function var_0_0.checkBlockLandShow(arg_9_0, arg_9_1)
	if arg_9_1 and arg_9_1.blockCleanType == RoomBlockEnum.CleanType.CleanLand then
		return false
	end

	return true
end

function var_0_0.refreshBackBuildingEffect(arg_10_0, arg_10_1)
	local var_10_0 = false

	if RoomMapBlockModel.instance:isBackMore() then
		local var_10_1 = arg_10_1 or arg_10_0:getMO()

		if var_10_1 and RoomMapBuildingModel.instance:getBuildingParam(var_10_1.hexPoint.x, var_10_1.hexPoint.y) then
			var_10_0 = true
		end
	end

	if var_10_0 then
		if not arg_10_0.effect:isHasEffectGOByKey(RoomEnum.EffectKey.BlockBackBuildingKey) then
			arg_10_0.effect:addParams({
				[RoomEnum.EffectKey.BlockBackBuildingKey] = {
					res = RoomScenePreloader.ResEffectD06
				}
			})
			arg_10_0.effect:refreshEffect()
		end
	elseif arg_10_0.effect:isHasEffectGOByKey(RoomEnum.EffectKey.BlockBackBuildingKey) then
		arg_10_0:removeParamsAndPlayAnimator({
			RoomEnum.EffectKey.BlockBackBuildingKey
		}, "close", RoomBlockEnum.PlaceEffectAnimatorCloseTime)
	end
end

function var_0_0._refreshLinkGO(arg_11_0)
	local var_11_0 = arg_11_0:getMO()

	if not var_11_0 then
		return
	end

	local var_11_1 = var_11_0:getResourceList()

	for iter_11_0 = 1, #var_11_1 do
		local var_11_2 = var_11_1[iter_11_0]

		if RoomResourceEnum.ResourceLinkGOPath[var_11_2] and RoomResourceEnum.ResourceLinkGOPath[var_11_2][iter_11_0] then
			local var_11_3 = arg_11_0.effect:getGameObjectByPath(RoomEnum.EffectKey.BlockLandKey, RoomResourceEnum.ResourceLinkGOPath[var_11_2][iter_11_0])

			if var_11_3 then
				local var_11_4, var_11_5 = var_11_0:getNeighborBlockLinkResourceId(iter_11_0, true)

				gohelper.setActive(var_11_3, var_11_2 == var_11_4)
			end
		end
	end

	local var_11_6 = var_11_0:getDefineBlockType()

	if RoomBlockEnum.BlockLinkEffectGOPath[var_11_6] then
		local var_11_7 = arg_11_0.effect:getGameObjectByPath(RoomEnum.EffectKey.BlockLandKey, RoomBlockEnum.BlockLinkEffectGOPath[var_11_6])

		if var_11_7 then
			local var_11_8 = var_11_0:hasNeighborSameBlockType()

			gohelper.setActive(var_11_7, var_11_8)
		end
	end
end

function var_0_0.refreshPackage(arg_12_0)
	if not RoomController.instance:isDebugPackageMode() or not RoomDebugController.instance:isDebugPackageListShow() then
		arg_12_0.effect:removeParams({
			RoomEnum.EffectKey.BlockPackageEffectKey
		})
		arg_12_0.effect:refreshEffect()

		return
	end

	local var_12_0 = arg_12_0:getMO()
	local var_12_1 = var_12_0.packageId
	local var_12_2 = RoomDebugPackageListModel.instance:getFilterPackageId()

	if not var_12_2 or var_12_2 == 0 or not var_12_1 or var_12_1 == 0 then
		arg_12_0.effect:removeParams({
			RoomEnum.EffectKey.BlockPackageEffectKey
		})
		arg_12_0.effect:refreshEffect()

		return
	end

	local var_12_3 = var_12_0:getMainRes()

	if not var_12_3 or var_12_3 < 0 then
		var_12_3 = RoomResourceEnum.ResourceId.Empty
	end

	if RoomDebugController.instance:isEditPackageOrder() then
		if var_12_3 ~= (RoomDebugPackageListModel.instance:getFilterMainRes() or RoomResourceEnum.ResourceId.Empty) or var_12_2 ~= var_12_1 then
			arg_12_0.effect:removeParams({
				RoomEnum.EffectKey.BlockPackageEffectKey
			})
		else
			arg_12_0.effect:addParams({
				[RoomEnum.EffectKey.BlockPackageEffectKey] = {
					res = RoomScenePreloader.ResDebugPackageColorDict[var_12_3]
				}
			})
		end
	elseif var_12_2 ~= var_12_1 then
		arg_12_0.effect:addParams({
			[RoomEnum.EffectKey.BlockPackageEffectKey] = {
				res = RoomScenePreloader.ResDebugPackageColorOther
			}
		})
	else
		arg_12_0.effect:addParams({
			[RoomEnum.EffectKey.BlockPackageEffectKey] = {
				res = RoomScenePreloader.ResDebugPackageColorDict[var_12_3]
			}
		})
	end

	arg_12_0.effect:refreshEffect()
end

function var_0_0.refreshTempOccupy(arg_13_0)
	var_0_0.super.refreshTempOccupy(arg_13_0)
	arg_13_0:_refreshLandLightEffect()
end

function var_0_0.playSmokeEffect(arg_14_0)
	local var_14_0 = arg_14_0:getMO()

	if not var_14_0 then
		return
	end

	arg_14_0.effect:addParams({
		[RoomEnum.EffectKey.BlockSmokeEffectKey] = {
			res = RoomScenePreloader.BlockTypeSmokeDict[var_14_0:getDefineBlockType()] or RoomScenePreloader.ResSmoke,
			containerGO = arg_14_0.staticContainerGO
		}
	}, 2)
	arg_14_0.effect:refreshEffect()
end

function var_0_0.playVxWaterEffect(arg_15_0)
	local var_15_0 = arg_15_0.effect:getEffectGO(RoomEnum.EffectKey.BlockVxWaterKey)

	if var_15_0 then
		gohelper.setActive(var_15_0, false)
		gohelper.setActive(var_15_0, true)
	end

	arg_15_0.effect:addParams({
		[RoomEnum.EffectKey.BlockVxWaterKey] = {
			res = RoomScenePreloader.ResVXWater,
			containerGO = arg_15_0.containerGO
		}
	}, 3)
	arg_15_0.effect:refreshEffect()
end

function var_0_0._refreshLightEffect(arg_16_0)
	arg_16_0:_refreshLandLightEffect()
end

function var_0_0._refreshLandLightEffect(arg_17_0)
	local var_17_0 = arg_17_0:getMO()

	if not var_17_0 or not var_17_0:isHasLight() then
		return
	end

	local var_17_1 = var_17_0.hexPoint
	local var_17_2 = GameSceneMgr.instance:getCurScene().mapmgr:getPropertyBlock()

	var_17_2:SetVector("_Highlight", Vector4.New(0.3, 0.19, 0.06, 0))

	local var_17_3 = var_17_0:getRiverCount()
	local var_17_4 = false
	local var_17_5 = var_17_0:isFullWater()
	local var_17_6 = RoomEnum.EffectPath.ResourcePointLightPaths
	local var_17_7 = RoomEnum.EffectKey.BlockKeys
	local var_17_8 = RoomEnum.EffectKey.BlockLandKey
	local var_17_9 = RoomConfig.instance
	local var_17_10 = var_17_0:getRotate()
	local var_17_11 = RoomEnum.EffectPath.LightMeshPath
	local var_17_12 = RoomResourceModel.instance
	local var_17_13 = RoomResourceEnum.ResourceId.River
	local var_17_14 = RoomEnum.EffectKey.BlockHalfLakeKeys
	local var_17_15 = var_17_0:isHalfLakeWater()
	local var_17_16 = var_17_15 and var_17_12:isLightResourcePoint(var_17_1.x, var_17_1.y, 0) == var_17_13

	for iter_17_0 = 1, 6 do
		local var_17_17 = RoomRotateHelper.rotateDirection(iter_17_0, var_17_10)
		local var_17_18 = var_17_12:isLightResourcePoint(var_17_1.x, var_17_1.y, var_17_17)

		if var_17_18 and var_17_18 == var_17_13 then
			var_17_4 = true
		end

		local var_17_19 = var_17_0:getResourceId(var_17_17)

		if var_17_5 and var_17_19 == var_17_13 then
			arg_17_0:_setLightEffectByPath(var_17_7[iter_17_0], var_17_11, var_17_18, var_17_2)

			if var_17_3 < 6 then
				arg_17_0:_setLightEffectByPath(var_17_8, var_17_6[iter_17_0], var_17_18, var_17_2)
			end
		elseif var_17_9:isLightByResourceId(var_17_19) then
			arg_17_0:_setLightEffectByPath(var_17_8, var_17_6[iter_17_0], var_17_18, var_17_2)
		end

		if var_17_15 and var_17_19 ~= var_17_13 then
			arg_17_0:_setLightEffectByPath(var_17_14[iter_17_0], var_17_11, var_17_16, var_17_2)
		end
	end

	if not var_17_5 and var_17_3 > 0 and var_17_3 < 6 then
		arg_17_0:_setLightEffectByPath(RoomEnum.EffectKey.BlockRiverKey, var_17_11, var_17_4, var_17_2)
	end
end

function var_0_0._setLightEffectByPath(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	local var_18_0 = arg_18_0.effect:getMeshRenderersByPath(arg_18_1, arg_18_2)

	if var_18_0 and #var_18_0 > 0 and arg_18_0:_isUpdateLight(arg_18_1, arg_18_2, arg_18_3) then
		for iter_18_0, iter_18_1 in ipairs(var_18_0) do
			if arg_18_3 then
				iter_18_1:SetPropertyBlock(arg_18_4)
			else
				iter_18_1:SetPropertyBlock(nil)
			end
		end
	end
end

function var_0_0._isUpdateLight(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = arg_19_0._highlightDic[arg_19_1]
	local var_19_1 = true

	if var_19_0 then
		if var_19_0.isLight == arg_19_3 and var_19_0.path == arg_19_2 and var_19_0.effectRes == arg_19_0.effect:getEffectRes(arg_19_1) then
			var_19_1 = false
		end
	else
		var_19_0 = {}
		arg_19_0._highlightDic[arg_19_1] = var_19_0
	end

	if var_19_1 then
		var_19_0.isLight = arg_19_3
		var_19_0.path = arg_19_2
		var_19_0.effectRes = arg_19_0.effect:getEffectRes(arg_19_1)
	end

	return var_19_1
end

function var_0_0.beforeDestroy(arg_20_0)
	if arg_20_0.ambientAudioId and arg_20_0.ambientAudioId ~= AudioEnum.None then
		AudioMgr.instance:trigger(AudioEnum.Room.stop_amb_home, arg_20_0.go)
	end

	var_0_0.super.beforeDestroy(arg_20_0)
	arg_20_0:removeEvent()
end

function var_0_0.removeEvent(arg_21_0)
	RoomMapController.instance:unregisterCallback(RoomEvent.ResourceLight, arg_21_0._refreshLightEffect, arg_21_0)
	RoomMapController.instance:unregisterCallback(RoomEvent.StartPlayAmbientAudio, arg_21_0.playAmbientAudio, arg_21_0)
	RoomDebugController.instance:unregisterCallback(RoomEvent.DebugSetPackage, arg_21_0.refreshPackage, arg_21_0)
	RoomDebugController.instance:unregisterCallback(RoomEvent.DebugPackageOrderChanged, arg_21_0.refreshPackage, arg_21_0)
	RoomDebugController.instance:unregisterCallback(RoomEvent.DebugPackageListShowChanged, arg_21_0.refreshPackage, arg_21_0)
	RoomDebugController.instance:unregisterCallback(RoomEvent.DebugPackageFilterChanged, arg_21_0.refreshPackage, arg_21_0)
end

function var_0_0.getMO(arg_22_0)
	local var_22_0 = RoomMapBlockModel.instance:getFullBlockMOById(arg_22_0.id)

	if var_22_0 then
		var_22_0.replaceDefineId = nil
		var_22_0.replaceRotate = nil

		if var_22_0.hexPoint then
			local var_22_1 = RoomMapBuildingModel.instance
			local var_22_2 = var_22_1:getBuildingParam(var_22_0.hexPoint.x, var_22_0.hexPoint.y)

			if not var_22_2 and not RoomBuildingController.instance:isPressBuilding() then
				var_22_2 = var_22_1:getTempBuildingParam(var_22_0.hexPoint.x, var_22_0.hexPoint.y)
			end

			var_22_0.replaceDefineId = var_22_2 and var_22_2.blockDefineId
			var_22_0.replaceRotate = var_22_2 and var_22_2.blockDefineId and var_22_2.blockRotate
		end
	end

	return var_22_0
end

function var_0_0.addAmbientAudio(arg_23_0)
	gohelper.addAkGameObject(arg_23_0.go)

	local var_23_0 = arg_23_0:getMO()
	local var_23_1 = {}

	for iter_23_0 = 1, 6 do
		local var_23_2 = var_23_0:getResourceId(iter_23_0)

		if var_23_2 ~= RoomResourceEnum.ResourceId.None and var_23_2 ~= RoomResourceEnum.ResourceId.Empty then
			var_23_1[var_23_2] = var_23_1[var_23_2] or 0
			var_23_1[var_23_2] = var_23_1[var_23_2] + 1
		end
	end

	local var_23_3 = 0
	local var_23_4 = 0
	local var_23_5 = 0

	for iter_23_1, iter_23_2 in pairs(var_23_1) do
		if var_23_3 < iter_23_2 then
			var_23_3 = iter_23_2
			var_23_4 = RoomResourceEnum.ResourceAudioPriority[iter_23_1] or 0
			var_23_5 = iter_23_1
		elseif iter_23_2 == var_23_3 and (RoomResourceEnum.ResourceAudioPriority[iter_23_1] or var_23_4 < 0) then
			var_23_3 = iter_23_2
			var_23_4 = RoomResourceEnum.ResourceAudioPriority[iter_23_1] or 0
			var_23_5 = iter_23_1
		end
	end

	arg_23_0.ambientAudioId = RoomResourceEnum.ResourceAudioId[var_23_5]
end

function var_0_0.playAmbientAudio(arg_24_0)
	if arg_24_0.ambientAudioId and arg_24_0.ambientAudioId ~= AudioEnum.None then
		AudioMgr.instance:trigger(arg_24_0.ambientAudioId, arg_24_0.go)
	end
end

function var_0_0.getCharacterMeshRendererList(arg_25_0)
	return arg_25_0.effect:getMeshRenderersByKey(RoomEnum.EffectKey.BlockLandKey)
end

function var_0_0.getGameObjectListByName(arg_26_0, arg_26_1)
	return arg_26_0.effect:getGameObjectsByName(RoomEnum.EffectKey.BlockLandKey, arg_26_1)
end

return var_0_0
