module("modules.logic.rouge.map.map.itemcomp.RougeMapLineItem", package.seeall)

slot0 = class("RougeMapLineItem", UserDataDispose)
slot0.ShaderParamDict = {
	Angle = UnityEngine.Shader.PropertyToID("_Angle"),
	MainTex = UnityEngine.Shader.PropertyToID("_MainTex"),
	Start = UnityEngine.Shader.PropertyToID("_StartVec"),
	End = UnityEngine.Shader.PropertyToID("_EndVec"),
	Cut1 = UnityEngine.Shader.PropertyToID("_Cut1"),
	Cut2 = UnityEngine.Shader.PropertyToID("_Cut2")
}

function slot0.init(slot0, slot1, slot2)
	slot0:__onInit()

	slot0.go = slot1
	slot0.tr = slot1.transform
	slot0.map = slot2
	slot0.mat = gohelper.findChild(slot0.go, "arc"):GetComponent(typeof(UnityEngine.MeshRenderer)).material
	slot0.startPos = Vector4.New(0, 0, 0, 0)
	slot0.endPos = Vector4.New(0, 0, 0, 0)
	slot0.startPosVec2 = Vector2.New(0, 0)
	slot0.endPosVec2 = Vector2.New(0, 0)
	slot0.angle = 85

	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onUpdateMapInfo, slot0.onUpdateMapInfo, slot0)
end

function slot0.drawLine(slot0, slot1, slot2)
	slot0.curNode = slot1
	slot0.preNode = slot2
	slot0.curEpisodeIndex = slot1.episodeId
	slot0.curArriveStatus = slot0.curNode.arriveStatus
	slot0.preArriveStatus = slot0.preNode.arriveStatus
	slot0.go.name = string.format("%s_%s-%s_%s", slot0.curEpisodeIndex - 1, slot0.preNode.index, slot0.curEpisodeIndex, slot0.curNode.index)

	slot0:refreshPos()
	slot0:refreshLineTexture()
end

function slot0.refreshPos(slot0)
	slot1, slot2 = RougeMapHelper.getNodeContainerPos(slot0.curEpisodeIndex, slot0.curNode:getEpisodePos())
	slot3, slot4 = RougeMapHelper.getNodeContainerPos(slot0.curEpisodeIndex - 1, slot0.preNode:getEpisodePos())
	slot1 = slot1 - RougeMapEnum.LineOffset
	slot3 = slot3 + RougeMapEnum.LineOffset
	slot0.startPosX = -math.sqrt((slot1 - slot3)^2 + (slot2 - slot4)^2) * 0.5
	slot0.endPosX = -slot0.startPosX

	slot0.startPos:Set(slot0.startPosX, 0, 0, 0)
	slot0.startPosVec2:Set(slot0.startPosX, 0)
	slot0.mat:SetVector(uv0.ShaderParamDict.Start, slot0.startPos)
	slot0.endPos:Set(slot0.endPosX, 0, 0, 0)
	slot0.endPosVec2:Set(slot0.endPosX, 0, 0, 0)
	slot0.mat:SetVector(uv0.ShaderParamDict.End, slot0.endPos)
	transformhelper.setLocalPos(slot0.tr, (slot1 + slot3) * 0.5, (slot2 + slot4) * 0.5, 0)
	transformhelper.setLocalRotation(slot0.tr, 0, 0, RougeMapHelper.getAngle(slot3, slot4, slot1, slot2))
	slot0:refreshLineProgress()
end

function slot0.refreshLineProgress(slot0)
	slot0.isCurNodeFog = slot0.curNode.fog
	slot0.isPreNodeFog = slot0.preNode.fog
	slot1 = RougeMapModel.instance:isHoleNode(slot0.preNode.nodeId)
	slot2 = RougeMapEnum.NormalLineCutValue
	slot3 = RougeMapEnum.NormalLineCutValue

	if slot0.isCurNodeFog then
		if slot0.isPreNodeFog then
			slot2 = RougeMapEnum.HideLineCutValue
			slot3 = RougeMapEnum.HideLineCutValue
		else
			slot2 = slot1 and RougeMapEnum.HoleLineCutValue or RougeMapEnum.FogLineCutValue
		end
	elseif slot0.isPreNodeFog then
		slot3 = RougeMapEnum.HoleLineCutValue
	end

	slot0.mat:SetFloat(uv0.ShaderParamDict.Cut1, slot2)
	slot0.mat:SetFloat(uv0.ShaderParamDict.Cut2, slot3)
end

function slot0.refreshLineTexture(slot0)
	slot0.curArriveStatus = slot0.curNode.arriveStatus
	slot0.preArriveStatus = slot0.preNode.arriveStatus

	slot0.mat:SetTexture(uv0.ShaderParamDict.MainTex, slot0.map.lineIconDict[RougeMapHelper.getLineType(slot0.curArriveStatus, slot0.preArriveStatus)])
end

function slot0.onUpdateMapInfo(slot0)
	if not slot0:checkNeedRefresh() then
		return
	end

	slot0.curArriveStatus = slot0.curNode.arriveStatus
	slot0.preArriveStatus = slot0.preNode.arriveStatus

	slot0:refreshPos()
	slot0:refreshLineTexture()
end

function slot0.checkNeedRefresh(slot0)
	return slot0.curArriveStatus ~= slot0.curNode.arriveStatus or slot0.preArriveStatus ~= slot0.preNode.arriveStatus or slot0.isCurNodeFog ~= slot0.curNode.fog or slot0.isPreNodeFog ~= slot0.preNode.fog
end

function slot0.getActorPos(slot0, slot1)
	slot2, slot3 = ZProj.ArcFollowHelper.GetArcToLocalPos(slot1, slot0.startPosVec2, slot0.endPosVec2, slot0.angle, nil, )
	slot4, slot5 = SLFramework.TransformHelper.LocalPosToWorldPos(slot0.tr, slot2, slot3, 0, nil, , )
	slot4, slot5 = SLFramework.TransformHelper.WorldPosToLocalPos(slot0.map.trLayerPiecesContainer, slot4, slot5, 0, nil, , )

	return slot4, slot5, 0
end

function slot0.destroy(slot0)
	slot0:__onDispose()
end

return slot0
