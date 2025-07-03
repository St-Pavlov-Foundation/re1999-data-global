module("modules.logic.versionactivity2_7.coopergarland.controller.CooperGarlandGameEntityMgr", package.seeall)

local var_0_0 = class("CooperGarlandGameEntityMgr", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0:clearAllMap()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clearAllMap()
end

function var_0_0.clearAllMap(arg_3_0)
	arg_3_0._panelRoot = nil
	arg_3_0._ballRoot = nil
	arg_3_0._compRoot = nil
	arg_3_0._wallRoot = nil
	arg_3_0._panelGo = nil

	if arg_3_0._ballEntity then
		arg_3_0._ballEntity:destroy()
	end

	arg_3_0._ballEntity = nil

	arg_3_0:_clearCompAndWall()

	arg_3_0._initMapCb = nil
	arg_3_0._initMapCbObj = nil

	if arg_3_0._loader then
		arg_3_0._loader:dispose()

		arg_3_0._loader = nil
	end

	arg_3_0._hasLoadedRes = false

	UIBlockMgr.instance:endBlock(CooperGarlandEnum.BlockKey.LoadGameRes)
end

function var_0_0.enterMap(arg_4_0)
	arg_4_0:clearAllMap()
	arg_4_0:_startLoadRes()
end

function var_0_0._startLoadRes(arg_5_0)
	if arg_5_0._loader then
		arg_5_0._loader:dispose()
	end

	arg_5_0._loader = MultiAbLoader.New()

	UIBlockMgr.instance:startBlock(CooperGarlandEnum.BlockKey.LoadGameRes)

	local var_5_0 = CooperGarlandConfig.instance:getAllComponentResPath()

	if string.nilorempty(next(CooperGarlandEnum.ResPath)) and string.nilorempty(next(var_5_0)) then
		arg_5_0:_loadResFinished()
	else
		for iter_5_0, iter_5_1 in pairs(CooperGarlandEnum.ResPath) do
			arg_5_0._loader:addPath(iter_5_1)
		end

		for iter_5_2, iter_5_3 in ipairs(var_5_0) do
			arg_5_0._loader:addPath(iter_5_3)
		end

		arg_5_0._loader:startLoad(arg_5_0._loadResFinished, arg_5_0)
	end
end

function var_0_0._loadResFinished(arg_6_0)
	UIBlockMgr.instance:endBlock(CooperGarlandEnum.BlockKey.LoadGameRes)

	arg_6_0._hasLoadedRes = true

	arg_6_0:tryInitMap(arg_6_0._panelRoot, arg_6_0._ballRoot, arg_6_0._initMapCb, arg_6_0._initMapCbObj)
end

function var_0_0.tryInitMap(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	arg_7_0._panelRoot = arg_7_1
	arg_7_0._ballRoot = arg_7_2
	arg_7_0._initMapCb = arg_7_3
	arg_7_0._initMapCbObj = arg_7_4

	arg_7_0:_initMap()
end

function var_0_0._initMap(arg_8_0)
	if not arg_8_0._hasLoadedRes or gohelper.isNil(arg_8_0._panelRoot) or gohelper.isNil(arg_8_0._ballRoot) then
		return
	end

	local var_8_0 = arg_8_0._loader:getAssetItem(CooperGarlandEnum.ResPath.UIPanel)

	if var_8_0 then
		arg_8_0._panelGo = gohelper.clone(var_8_0:GetResource(), arg_8_0._panelRoot)

		local var_8_1 = arg_8_0._panelGo.transform
		local var_8_2, var_8_3, var_8_4 = transformhelper.getLocalPos(var_8_1)

		transformhelper.setLocalPos(var_8_1, var_8_2, var_8_3, CooperGarlandEnum.Const.PanelPosZ)

		arg_8_0._panelScale = transformhelper.getLocalScale(var_8_1)
		arg_8_0._wallRoot = gohelper.findChild(arg_8_0._panelGo, "#go_walls")
		arg_8_0._compRoot = gohelper.findChild(arg_8_0._panelGo, "#go_comps")
		arg_8_0._floorColliderThickness = gohelper.findChild(arg_8_0._panelGo, "#go_boundary/floor"):GetComponent(typeof(UnityEngine.BoxCollider)).size.z
		arg_8_0._boundaryColliderHeightZ = gohelper.findChild(arg_8_0._panelGo, "#go_boundary/top"):GetComponent(typeof(UnityEngine.BoxCollider)).size.z
	end

	if arg_8_0._initMapCb then
		arg_8_0._initMapCb(arg_8_0._initMapCbObj)
	end

	arg_8_0._initMapCb = nil
	arg_8_0._initMapCbObj = nil

	arg_8_0:_setupMap()
end

function var_0_0._setupMap(arg_9_0)
	local var_9_0
	local var_9_1 = CooperGarlandGameModel.instance:getMapId()
	local var_9_2 = CooperGarlandConfig.instance:getMapComponentList(var_9_1)

	for iter_9_0, iter_9_1 in ipairs(var_9_2) do
		local var_9_3 = CooperGarlandConfig.instance:getMapComponentType(var_9_1, iter_9_1)
		local var_9_4 = CooperGarlandConfig.instance:getComponentTypePath(var_9_3)
		local var_9_5 = arg_9_0._loader:getAssetItem(var_9_4)
		local var_9_6 = CooperGarlandGameModel.instance:isFinishedStoryComponent(var_9_1, iter_9_1)

		if var_9_5 and not var_9_6 then
			local var_9_7 = var_9_3 == CooperGarlandEnum.ComponentType.Wall
			local var_9_8 = gohelper.clone(var_9_5:GetResource(), var_9_7 and arg_9_0._wallRoot or arg_9_0._compRoot)
			local var_9_9 = MonoHelper.addLuaComOnceToGo(var_9_8, CooperGarlandComponentEntity, {
				mapId = var_9_1,
				componentId = iter_9_1,
				componentType = var_9_3
			})

			if var_9_7 then
				arg_9_0._wallDict[iter_9_1] = var_9_9
			else
				arg_9_0._compDict[iter_9_1] = var_9_9
			end

			if var_9_3 == CooperGarlandEnum.ComponentType.Start then
				var_9_0 = var_9_9:getWorldPos()
			end
		end
	end

	CooperGarlandStatHelper.instance:setupMap()
	arg_9_0:setBallVisible(var_9_0)
	CooperGarlandController.instance:setStopGame(false)
	CooperGarlandController.instance:dispatchEvent(CooperGarlandEvent.GuideOnEnterMap, var_9_1)
end

function var_0_0.resetMap(arg_10_0)
	if arg_10_0._compDict then
		for iter_10_0, iter_10_1 in pairs(arg_10_0._compDict) do
			iter_10_1:reset()
		end
	end

	arg_10_0:resetBall()
end

function var_0_0.resetBall(arg_11_0)
	if arg_11_0._ballEntity then
		arg_11_0._ballEntity:reset()
	end
end

function var_0_0.changeMap(arg_12_0)
	arg_12_0:_clearCompAndWall()
	arg_12_0:setBallVisible()
	arg_12_0:_setupMap()
end

function var_0_0._clearCompAndWall(arg_13_0)
	if arg_13_0._wallDict then
		for iter_13_0, iter_13_1 in pairs(arg_13_0._wallDict) do
			iter_13_1:destroy()
		end
	end

	arg_13_0._wallDict = {}

	if arg_13_0._compDict then
		for iter_13_2, iter_13_3 in pairs(arg_13_0._compDict) do
			iter_13_3:destroy()
		end
	end

	arg_13_0._compDict = {}
end

function var_0_0.removeComp(arg_14_0, arg_14_1)
	if arg_14_0._compDict[arg_14_1] then
		arg_14_0._compDict[arg_14_1]:setRemoved()
	end
end

function var_0_0.setBallVisible(arg_15_0, arg_15_1)
	if arg_15_1 and not arg_15_0._ballEntity then
		local var_15_0 = arg_15_0._loader:getAssetItem(CooperGarlandEnum.ResPath.Ball)

		if var_15_0 then
			local var_15_1 = CooperGarlandGameModel.instance:getMapId()
			local var_15_2 = gohelper.clone(var_15_0:GetResource(), arg_15_0._ballRoot)
			local var_15_3 = gohelper.findChild(var_15_2, "#go_ball")
			local var_15_4 = var_15_3:GetComponentInChildren(typeof(UnityEngine.Renderer))
			local var_15_5 = CooperGarlandConfig.instance:getAct192Const(CooperGarlandEnum.ConstId.BallScale, true)

			transformhelper.setLocalScale(var_15_2.transform, var_15_5, var_15_5, var_15_5)

			arg_15_0._ballSize = var_15_4.bounds.size.x * var_15_2.transform.localScale.x
			arg_15_0._ballEntity = MonoHelper.addLuaComOnceToGo(var_15_3, CooperGarlandBallEntity, {
				mapId = var_15_1
			})
		end
	end

	if arg_15_0._ballEntity then
		arg_15_0._ballEntity:setVisible(arg_15_1)
	end
end

function var_0_0.playBallDieVx(arg_16_0)
	if arg_16_0._ballEntity then
		arg_16_0._ballEntity:playDieVx()
	end
end

function var_0_0.checkBallFreeze(arg_17_0, arg_17_1)
	if arg_17_0._ballEntity then
		arg_17_0._ballEntity:checkFreeze(arg_17_1)
	end
end

function var_0_0.isBallCanTriggerComp(arg_18_0)
	local var_18_0 = false

	if arg_18_0._ballEntity then
		var_18_0 = arg_18_0._ballEntity:isCanTriggerComp()
	end

	return var_18_0
end

function var_0_0.getPanelGo(arg_19_0)
	return arg_19_0._panelGo
end

function var_0_0.getBallPosZ(arg_20_0)
	return CooperGarlandEnum.Const.PanelPosZ - arg_20_0._floorColliderThickness * arg_20_0._panelScale - arg_20_0._ballSize / 2 + CooperGarlandEnum.Const.BallPosOffset
end

function var_0_0.getCompPosZ(arg_21_0, arg_21_1)
	local var_21_0 = 0

	if not arg_21_1 then
		var_21_0 = -arg_21_0._floorColliderThickness
	end

	return var_21_0
end

function var_0_0.getCompColliderSizeZ(arg_22_0)
	return arg_22_0._boundaryColliderHeightZ
end

function var_0_0.getCompColliderOffsetZ(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0._boundaryColliderHeightZ / 2

	return -(arg_23_1 and var_23_0 or var_23_0 - arg_23_0._floorColliderThickness)
end

function var_0_0.getRemoveCompList(arg_24_0)
	local var_24_0 = {}

	if arg_24_0._compDict then
		for iter_24_0, iter_24_1 in pairs(arg_24_0._compDict) do
			if iter_24_1:getIsRemoved() then
				var_24_0[#var_24_0 + 1] = iter_24_0
			end
		end
	end

	return var_24_0
end

function var_0_0.getBallVelocity(arg_25_0)
	local var_25_0 = Vector3.zero

	if arg_25_0._ballEntity then
		var_25_0 = arg_25_0._ballEntity:getVelocity()
	end

	return var_25_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
