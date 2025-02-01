module("modules.logic.rouge.dlc.101.map.RougeMapFogEffect", package.seeall)

slot0 = class("RougeMapFogEffect", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.effectGO = slot1
	slot5 = typeof
	slot0.fogMeshRenderer = gohelper.findChildComponent(slot0.effectGO, "mask_smoke", slot5(UnityEngine.MeshRenderer))
	slot0.fogMat = slot0.fogMeshRenderer.sharedMaterial
	slot0.tempVector4 = Vector4.zero
	slot0.shaderParamList = slot0:getUserDataTb_()

	for slot5 = 1, RougeMapEnum.MaxHoleNum do
		table.insert(slot0.shaderParamList, UnityEngine.Shader.PropertyToID("_TransPos_" .. slot5))
	end

	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onUpdateMapInfo, slot0.onUpdateMapInfo, slot0)
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onMapPosChange, slot0.onMapPosChanged, slot0)
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onCameraSizeChange, slot0.onCameraSizeChanged, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0.onCloseViewFinish, slot0)
	slot0:initAndRefreshFog()
end

function slot0.onUpdateMapInfo(slot0)
	if not RougeMapHelper.checkMapViewOnTop() then
		slot0.waitUpdate = true

		return
	end

	slot0.waitUpdate = nil

	slot0:initNodeInfo()
	slot0:refreshFog(true)
end

function slot0.onCloseViewFinish(slot0, slot1)
	if slot0.waitUpdate then
		slot0:onUpdateMapInfo()
	end
end

function slot0.initAndRefreshFog(slot0)
	slot0:initNodeInfo()
	slot0:refreshFog()
end

function slot0.onMapPosChanged(slot0)
	slot0:refreshFog()
end

function slot0.onCameraSizeChanged(slot0)
	slot0:refreshFog()
end

function slot0.refreshFog(slot0, slot1)
	slot2 = slot0._fogNodeList and #slot0._fogNodeList > 0

	gohelper.setActive(slot0.effectGO, slot2)

	if not slot2 then
		return
	end

	slot0:updateFogPosition(slot1)
	slot0:updateHolesPosition()
end

function slot0.initNodeInfo(slot0)
	slot0._fogNodeList = RougeMapModel.instance:getFogNodeList()
	slot0._holeNodeList = RougeMapModel.instance:getHoleNodeList()
end

function slot0.updateFogPosition(slot0, slot1)
	slot0:_cancelFogTween()
	slot0:_endFogUIBlock()

	slot2 = slot0:getFogNextPositionX()
	slot3, slot4 = transformhelper.getPos(slot0.effectGO.transform)

	if slot1 then
		slot0:_startFogUIBlock()

		slot5, slot6 = RougeDLCModel101.instance:getFogPrePos()

		transformhelper.setPosXY(slot0.effectGO.transform, slot5, slot6)
		RougeDLCModel101.instance:setFogPrePos(slot2, slot4)

		slot0._fogTweenId = ZProj.TweenHelper.DOMoveX(slot0.effectGO.transform, slot2, RougeMapEnum.FogDuration, slot0._onFogTweenDone, slot0)
	else
		transformhelper.setPosXY(slot0.effectGO.transform, slot2, slot4)
	end
end

function slot0.getFogNextPositionX(slot0)
	if not (RougeMapController.instance:getMapComp() and slot2:getMapItem((slot0._fogNodeList and slot0._fogNodeList[1]).nodeId)) then
		return 0
	end

	return slot3:getScenePos().x + RougeMapEnum.FogOffset[1]
end

function slot0._onFogTweenDone(slot0)
	slot0:_endFogUIBlock()
end

function slot0._startFogUIBlock(slot0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("RougeMapFogEffect")
end

function slot0._endFogUIBlock(slot0)
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("RougeMapFogEffect")
end

function slot0._cancelFogTween(slot0)
	if slot0._fogTweenId then
		ZProj.TweenHelper.KillById(slot0._fogTweenId)

		slot0._fogTweenId = nil
	end
end

function slot0.updateHolesPosition(slot0)
	if gohelper.isNil(slot0.fogMat) or not RougeMapController.instance:getMapComp() then
		return
	end

	for slot5 = 1, RougeMapEnum.MaxHoleNum do
		if slot0._holeNodeList and slot0._holeNodeList[slot5] then
			slot8 = slot1:getMapItem(slot6.nodeId) and slot7:getScenePos()

			slot0.tempVector4:Set(slot8.x + RougeMapEnum.HolePosOffset[1], slot8.y + RougeMapEnum.HolePosOffset[2], RougeMapEnum.HoleSize)
		else
			slot0.tempVector4:Set(RougeMapEnum.OutSideAreaPos.X, RougeMapEnum.OutSideAreaPos.Y)
		end

		slot0.fogMat:SetVector(slot0.shaderParamList[slot5], slot0.tempVector4)
	end
end

function slot0.onDestroy(slot0)
	slot0:_cancelFogTween()
	slot0:_endFogUIBlock()
end

return slot0
