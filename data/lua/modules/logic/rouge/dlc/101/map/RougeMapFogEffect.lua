module("modules.logic.rouge.dlc.101.map.RougeMapFogEffect", package.seeall)

local var_0_0 = class("RougeMapFogEffect", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.effectGO = arg_1_1
	arg_1_0.fogMeshRenderer = gohelper.findChildComponent(arg_1_0.effectGO, "mask_smoke", typeof(UnityEngine.MeshRenderer))
	arg_1_0.fogMat = arg_1_0.fogMeshRenderer.sharedMaterial
	arg_1_0.tempVector4 = Vector4.zero
	arg_1_0.shaderParamList = arg_1_0:getUserDataTb_()

	for iter_1_0 = 1, RougeMapEnum.MaxHoleNum do
		table.insert(arg_1_0.shaderParamList, UnityEngine.Shader.PropertyToID("_TransPos_" .. iter_1_0))
	end

	arg_1_0:addEventCb(RougeMapController.instance, RougeMapEvent.onUpdateMapInfo, arg_1_0.onUpdateMapInfo, arg_1_0)
	arg_1_0:addEventCb(RougeMapController.instance, RougeMapEvent.onMapPosChange, arg_1_0.onMapPosChanged, arg_1_0)
	arg_1_0:addEventCb(RougeMapController.instance, RougeMapEvent.onCameraSizeChange, arg_1_0.onCameraSizeChanged, arg_1_0)
	arg_1_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_1_0.onCloseViewFinish, arg_1_0)
	arg_1_0:initAndRefreshFog()
end

function var_0_0.onUpdateMapInfo(arg_2_0)
	if not RougeMapHelper.checkMapViewOnTop() then
		arg_2_0.waitUpdate = true

		return
	end

	arg_2_0.waitUpdate = nil

	arg_2_0:initNodeInfo()
	arg_2_0:refreshFog(true)
end

function var_0_0.onCloseViewFinish(arg_3_0, arg_3_1)
	if arg_3_0.waitUpdate then
		arg_3_0:onUpdateMapInfo()
	end
end

function var_0_0.initAndRefreshFog(arg_4_0)
	arg_4_0:initNodeInfo()
	arg_4_0:refreshFog()
end

function var_0_0.onMapPosChanged(arg_5_0)
	arg_5_0:refreshFog()
end

function var_0_0.onCameraSizeChanged(arg_6_0)
	arg_6_0:refreshFog()
end

function var_0_0.refreshFog(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0._fogNodeList and #arg_7_0._fogNodeList > 0

	gohelper.setActive(arg_7_0.effectGO, var_7_0)

	if not var_7_0 then
		return
	end

	arg_7_0:updateFogPosition(arg_7_1)
	arg_7_0:updateHolesPosition()
end

function var_0_0.initNodeInfo(arg_8_0)
	arg_8_0._fogNodeList = RougeMapModel.instance:getFogNodeList()
	arg_8_0._holeNodeList = RougeMapModel.instance:getHoleNodeList()
end

function var_0_0.updateFogPosition(arg_9_0, arg_9_1)
	arg_9_0:_cancelFogTween()
	arg_9_0:_endFogUIBlock()

	local var_9_0 = arg_9_0:getFogNextPositionX()
	local var_9_1, var_9_2 = transformhelper.getPos(arg_9_0.effectGO.transform)

	if arg_9_1 then
		arg_9_0:_startFogUIBlock()

		local var_9_3, var_9_4 = RougeDLCModel101.instance:getFogPrePos()

		transformhelper.setPosXY(arg_9_0.effectGO.transform, var_9_3, var_9_4)
		RougeDLCModel101.instance:setFogPrePos(var_9_0, var_9_2)

		arg_9_0._fogTweenId = ZProj.TweenHelper.DOMoveX(arg_9_0.effectGO.transform, var_9_0, RougeMapEnum.FogDuration, arg_9_0._onFogTweenDone, arg_9_0)
	else
		transformhelper.setPosXY(arg_9_0.effectGO.transform, var_9_0, var_9_2)
	end
end

function var_0_0.getFogNextPositionX(arg_10_0)
	local var_10_0 = arg_10_0._fogNodeList and arg_10_0._fogNodeList[1]
	local var_10_1 = RougeMapController.instance:getMapComp()
	local var_10_2 = var_10_1 and var_10_1:getMapItem(var_10_0.nodeId)

	if not var_10_2 then
		return 0
	end

	return var_10_2:getScenePos().x + RougeMapEnum.FogOffset[1]
end

function var_0_0._onFogTweenDone(arg_11_0)
	arg_11_0:_endFogUIBlock()
end

function var_0_0._startFogUIBlock(arg_12_0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("RougeMapFogEffect")
end

function var_0_0._endFogUIBlock(arg_13_0)
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("RougeMapFogEffect")
end

function var_0_0._cancelFogTween(arg_14_0)
	if arg_14_0._fogTweenId then
		ZProj.TweenHelper.KillById(arg_14_0._fogTweenId)

		arg_14_0._fogTweenId = nil
	end
end

function var_0_0.updateHolesPosition(arg_15_0)
	local var_15_0 = RougeMapController.instance:getMapComp()

	if gohelper.isNil(arg_15_0.fogMat) or not var_15_0 then
		return
	end

	for iter_15_0 = 1, RougeMapEnum.MaxHoleNum do
		local var_15_1 = arg_15_0._holeNodeList and arg_15_0._holeNodeList[iter_15_0]

		if var_15_1 then
			local var_15_2 = var_15_0:getMapItem(var_15_1.nodeId)
			local var_15_3 = var_15_2 and var_15_2:getScenePos()
			local var_15_4 = var_15_3.x + RougeMapEnum.HolePosOffset[1]
			local var_15_5 = var_15_3.y + RougeMapEnum.HolePosOffset[2]

			arg_15_0.tempVector4:Set(var_15_4, var_15_5, RougeMapEnum.HoleSize)
		else
			arg_15_0.tempVector4:Set(RougeMapEnum.OutSideAreaPos.X, RougeMapEnum.OutSideAreaPos.Y)
		end

		arg_15_0.fogMat:SetVector(arg_15_0.shaderParamList[iter_15_0], arg_15_0.tempVector4)
	end
end

function var_0_0.onDestroy(arg_16_0)
	arg_16_0:_cancelFogTween()
	arg_16_0:_endFogUIBlock()
end

return var_0_0
