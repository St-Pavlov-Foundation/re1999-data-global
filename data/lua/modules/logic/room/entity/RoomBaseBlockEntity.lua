module("modules.logic.room.entity.RoomBaseBlockEntity", package.seeall)

local var_0_0 = class("RoomBaseBlockEntity", RoomBaseEntity)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0)

	arg_1_0.id = arg_1_1
	arg_1_0.entityId = arg_1_0.id
	arg_1_0._pathfindingEnabled = false
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.goTrs = arg_2_1.transform
	arg_2_0.containerGO = gohelper.create3d(arg_2_1, RoomEnum.EntityChildKey.ContainerGOKey)
	arg_2_0.staticContainerGO = arg_2_0.containerGO
	arg_2_0.containerGOTrs = arg_2_0.containerGO.transform
	arg_2_0.staticContainerGOTrs = arg_2_0.staticContainerGO.transform

	var_0_0.super.init(arg_2_0, arg_2_1)

	arg_2_0._scene = GameSceneMgr.instance:getCurScene()

	arg_2_0:refreshLand()
end

function var_0_0.initComponents(arg_3_0)
	arg_3_0:addComp("effect", RoomEffectComp)
end

function var_0_0.removeParamsAndPlayAnimator(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if arg_4_3 then
		for iter_4_0 = 1, #arg_4_1 do
			arg_4_0.effect:playEffectAnimator(arg_4_1[iter_4_0], arg_4_2)
		end
	end

	arg_4_0.effect:removeParams(arg_4_1, arg_4_3)
end

function var_0_0.onStart(arg_5_0)
	return
end

function var_0_0.refreshName(arg_6_0)
	local var_6_0 = arg_6_0:getMO()

	arg_6_0.go.name = RoomResHelper.getBlockName(var_6_0.hexPoint)

	if arg_6_0.resourceui then
		arg_6_0.resourceui:refreshName()
	end
end

function var_0_0.refreshLand(arg_7_0)
	local var_7_0 = arg_7_0:getMO()
	local var_7_1 = var_7_0:getDefineId()
	local var_7_2 = var_7_0:getDefineWaterType()
	local var_7_3 = arg_7_0:checkBlockLandShow(var_7_0) ~= false
	local var_7_4 = var_7_1 ~= arg_7_0._refreshLandLastDefineId or var_7_3 ~= arg_7_0._lastShowLand
	local var_7_5 = var_7_2 ~= arg_7_0._lastWaterType

	arg_7_0._refreshLandLastDefineId = var_7_1
	arg_7_0._lastWaterType = var_7_2
	arg_7_0._lastShowLand = var_7_3

	if var_7_4 then
		local var_7_6
		local var_7_7

		if var_7_3 then
			var_7_6 = RoomResHelper.getBlockPath(var_7_1)
			var_7_7 = RoomResHelper.getBlockABPath(var_7_1)
		end

		arg_7_0:_refreshParams(RoomEnum.EffectKey.BlockLandKey, var_7_6, nil, "0", var_7_7)
	end

	if var_7_4 or var_7_5 then
		arg_7_0:_refreshRiver(var_7_0)
	end

	arg_7_0:_refreshFullRiver(var_7_0)
	arg_7_0:_refreshWaterGradient(var_7_0)
	arg_7_0:_refreshEffect()
end

function var_0_0.checkBlockLandShow(arg_8_0, arg_8_1)
	return true
end

function var_0_0._refreshWaterGradient(arg_9_0, arg_9_1)
	if not arg_9_1 or not arg_9_1:hasRiver() then
		return
	end

	local var_9_0 = arg_9_0.effect:getGameObjectsByName(RoomEnum.EffectKey.BlockLandKey, RoomEnum.EntityChildKey.WaterGradientGOKey)

	if var_9_0 then
		local var_9_1 = not arg_9_1:isInMapBlock() or arg_9_1:isWaterGradient()

		for iter_9_0, iter_9_1 in ipairs(var_9_0) do
			gohelper.setActive(iter_9_1, var_9_1)
		end
	end
end

function var_0_0.isHasWaterGradient(arg_10_0)
	local var_10_0 = false
	local var_10_1 = arg_10_0:getMO()

	if var_10_1 and var_10_1:hasRiver() then
		local var_10_2 = arg_10_0.effect:getGameObjectsByName(RoomEnum.EffectKey.BlockLandKey, RoomEnum.EntityChildKey.WaterGradientGOKey)

		if var_10_2 then
			var_10_0 = #var_10_2 > 0
		end
	end

	return var_10_0
end

function var_0_0._refreshRiver(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1 or arg_11_0:getMO()
	local var_11_1
	local var_11_2
	local var_11_3
	local var_11_4
	local var_11_5 = 0

	if var_11_0:hasRiver() then
		if not var_11_0:isFullWater() then
			var_11_1, var_11_5, var_11_2, var_11_3, var_11_4 = RoomRiverBlockHelper.getRiverBlockTypeByMO(var_11_0)
		end
	elseif var_11_0.blockId > 0 then
		var_11_1, var_11_3 = arg_11_0:_getRiverEffectRes(var_11_0:getDefineBlockType(), arg_11_0:checkSideShow())
	else
		var_11_1, var_11_3 = RoomScenePreloader.InitLand, RoomScenePreloader.InitLand
	end

	arg_11_0:_refreshParams(RoomEnum.EffectKey.BlockRiverFloorKey, var_11_2, var_11_5, nil, var_11_4)
	arg_11_0:_refreshParams(RoomEnum.EffectKey.BlockRiverKey, var_11_1, var_11_5, nil, var_11_3)
end

function var_0_0._refreshFullRiver(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1 or arg_12_0:getMO()
	local var_12_1 = var_12_0:isFullWater()

	if not var_12_1 and not arg_12_0._isLastFullRiver then
		return
	end

	arg_12_0._isLastFullRiver = var_12_1

	local var_12_2 = var_12_0:isHalfLakeWater()

	for iter_12_0 = 1, 6 do
		local var_12_3, var_12_4, var_12_5, var_12_6, var_12_7, var_12_8 = RoomBlockHelper.getResourcePath(var_12_0, iter_12_0)
		local var_12_9 = iter_12_0 - 1

		arg_12_0:_refreshParams(RoomEnum.EffectKey.BlockKeys[iter_12_0], var_12_3, var_12_9, nil, var_12_6)
		arg_12_0:_refreshParams(RoomEnum.EffectKey.BlockFloorKeys[iter_12_0], var_12_4, var_12_9, nil, var_12_7)
		arg_12_0:_refreshParams(RoomEnum.EffectKey.BlockFloorBKeys[iter_12_0], var_12_5, var_12_9, nil, var_12_8)

		local var_12_10

		if string.nilorempty(var_12_3) then
			var_12_10, var_12_6 = RoomResHelper.getMapBlockResPath(RoomResourceEnum.ResourceId.River, RoomRiverEnum.LakeBlockType[RoomRiverEnum.LakeOutLinkType.HalfLake], var_12_0:getDefineWaterType())
		end

		arg_12_0:_refreshParams(RoomEnum.EffectKey.BlockHalfLakeKeys[iter_12_0], var_12_10, var_12_9, nil, var_12_6)
	end
end

function var_0_0._refreshParams(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5)
	if string.nilorempty(arg_13_2) then
		if arg_13_0.effect:isHasKey(arg_13_1) then
			arg_13_0._riverBlockRemoveParams = arg_13_0._riverBlockRemoveParams or {}

			table.insert(arg_13_0._riverBlockRemoveParams, arg_13_1)
		end
	elseif not arg_13_0.effect:isSameResByKey(arg_13_1, arg_13_2) then
		arg_13_0._riverBlockAddParams = arg_13_0._riverBlockAddParams or {}

		local var_13_0 = {
			res = arg_13_2,
			layer = UnityLayer.SceneOpaque,
			pathfinding = arg_13_0._pathfindingEnabled
		}

		if arg_13_3 then
			var_13_0.localRotation = Vector3(0, 60 * arg_13_3, 0)
		end

		if arg_13_4 then
			var_13_0.deleteChildPath = arg_13_4
		end

		if not string.nilorempty(arg_13_5) then
			var_13_0.ab = arg_13_5
		end

		arg_13_0:onReviseResParams(var_13_0)

		arg_13_0._riverBlockAddParams[arg_13_1] = var_13_0
	end
end

function var_0_0._refreshEffect(arg_14_0)
	if arg_14_0._riverBlockRemoveParams then
		arg_14_0.effect:removeParams(arg_14_0._riverBlockRemoveParams)

		arg_14_0._riverBlockRemoveParams = nil
	end

	if arg_14_0._riverBlockAddParams then
		arg_14_0.effect:addParams(arg_14_0._riverBlockAddParams)

		arg_14_0._riverBlockAddParams = nil
	end

	arg_14_0.effect:refreshEffect()
end

function var_0_0.onReviseResParams(arg_15_0, arg_15_1)
	return
end

function var_0_0.onEffectRebuild(arg_16_0)
	return
end

function var_0_0.refreshRotation(arg_17_0, arg_17_1)
	arg_17_1 = false

	local var_17_0 = arg_17_0:getMO():getRotate()

	if arg_17_0._rotationTweenId then
		ZProj.TweenHelper.KillById(arg_17_0._rotationTweenId)
	end

	if arg_17_1 then
		arg_17_0._rotationTweenId = ZProj.TweenHelper.DOLocalRotate(arg_17_0.containerGOTrs, 0, var_17_0 * 60, 0, 0.1, nil, arg_17_0, nil, EaseType.Linear)
	else
		transformhelper.setLocalRotation(arg_17_0.containerGOTrs, 0, var_17_0 * 60, 0)
	end
end

function var_0_0.refreshBlock(arg_18_0)
	arg_18_0:refreshLand()
	arg_18_0.effect:refreshEffect()
end

function var_0_0.refreshTempOccupy(arg_19_0)
	return
end

function var_0_0.setLocalPos(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	transformhelper.setLocalPos(arg_20_0.goTrs, arg_20_1, arg_20_2, arg_20_3)
end

function var_0_0.beforeDestroy(arg_21_0)
	arg_21_0:_returnAnimator()

	if arg_21_0._rotationTweenId then
		ZProj.TweenHelper.KillById(arg_21_0._rotationTweenId)
	end

	for iter_21_0, iter_21_1 in ipairs(arg_21_0._compList) do
		if iter_21_1.beforeDestroy then
			iter_21_1:beforeDestroy()
		end
	end
end

function var_0_0.setBatchEnabled(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0.go:GetComponentsInChildren(typeof(UrpCustom.BatchRendererEntity), true)

	if var_22_0 then
		local var_22_1 = {}

		RoomHelper.cArrayToLuaTable(var_22_0, var_22_1)

		for iter_22_0 = 1, #var_22_1 do
			var_22_1[iter_22_0].enabled = arg_22_1
		end
	end
end

function var_0_0.playAnim(arg_23_0, arg_23_1, arg_23_2)
	if not arg_23_0._animator then
		arg_23_0._animator = gohelper.onceAddComponent(arg_23_0.go, typeof(UnityEngine.Animator))
	end

	if not arg_23_0._animatorPlayer then
		arg_23_0._animatorPlayer = gohelper.onceAddComponent(arg_23_0.go, typeof(SLFramework.AnimatorPlayer))
	end

	local var_23_0 = arg_23_0._scene.preloader:getResource(arg_23_1)

	arg_23_0._animator.runtimeAnimatorController = var_23_0

	arg_23_0._animatorPlayer:Play(arg_23_2, arg_23_0._returnAnimator, arg_23_0)
end

function var_0_0._returnAnimator(arg_24_0)
	if arg_24_0._animatorPlayer then
		gohelper.removeComponent(arg_24_0.go, typeof(SLFramework.AnimatorPlayer))

		arg_24_0._animatorPlayer = nil
	end

	if arg_24_0._animator then
		gohelper.removeComponent(arg_24_0.go, typeof(UnityEngine.Animator))

		arg_24_0._animator = nil
	end
end

function var_0_0.checkSideShow(arg_25_0)
	local var_25_0 = arg_25_0:getMO()

	if not var_25_0 then
		return false
	end

	local var_25_1 = false

	if var_25_0.blockState == RoomBlockEnum.BlockState.Map then
		var_25_1 = true

		local var_25_2 = var_25_0.hexPoint
		local var_25_3 = var_25_2:getNeighbors()

		for iter_25_0 = 1, 6 do
			local var_25_4 = HexPoint.directions[iter_25_0]
			local var_25_5 = RoomMapBlockModel.instance:getBlockMO(var_25_4.x + var_25_2.x, var_25_4.y + var_25_2.y)

			if not var_25_5 or var_25_5.blockState ~= RoomBlockEnum.BlockState.Map then
				var_25_1 = false

				break
			end
		end
	end

	return var_25_1
end

function var_0_0._getRiverEffectRes(arg_26_0, arg_26_1, arg_26_2)
	return RoomResHelper.getBlockLandPath(arg_26_1, arg_26_2)
end

function var_0_0.getMO(arg_27_0)
	return
end

function var_0_0.getMainEffectKey(arg_28_0)
	return RoomEnum.EffectKey.BlockLandKey
end

return var_0_0
