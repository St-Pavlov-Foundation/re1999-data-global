module("modules.logic.rouge.map.map.itemcomp.RougeMapLineItem", package.seeall)

local var_0_0 = class("RougeMapLineItem", UserDataDispose)

var_0_0.ShaderParamDict = {
	Angle = UnityEngine.Shader.PropertyToID("_Angle"),
	MainTex = UnityEngine.Shader.PropertyToID("_MainTex"),
	Start = UnityEngine.Shader.PropertyToID("_StartVec"),
	End = UnityEngine.Shader.PropertyToID("_EndVec"),
	Cut1 = UnityEngine.Shader.PropertyToID("_Cut1"),
	Cut2 = UnityEngine.Shader.PropertyToID("_Cut2")
}

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:__onInit()

	arg_1_0.go = arg_1_1
	arg_1_0.tr = arg_1_1.transform
	arg_1_0.map = arg_1_2
	arg_1_0.mat = gohelper.findChild(arg_1_0.go, "arc"):GetComponent(typeof(UnityEngine.MeshRenderer)).material
	arg_1_0.startPos = Vector4.New(0, 0, 0, 0)
	arg_1_0.endPos = Vector4.New(0, 0, 0, 0)
	arg_1_0.startPosVec2 = Vector2.New(0, 0)
	arg_1_0.endPosVec2 = Vector2.New(0, 0)
	arg_1_0.angle = 85

	arg_1_0:addEventCb(RougeMapController.instance, RougeMapEvent.onUpdateMapInfo, arg_1_0.onUpdateMapInfo, arg_1_0)
end

function var_0_0.drawLine(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.curNode = arg_2_1
	arg_2_0.preNode = arg_2_2
	arg_2_0.curEpisodeIndex = arg_2_1.episodeId
	arg_2_0.curArriveStatus = arg_2_0.curNode.arriveStatus
	arg_2_0.preArriveStatus = arg_2_0.preNode.arriveStatus
	arg_2_0.go.name = string.format("%s_%s-%s_%s", arg_2_0.curEpisodeIndex - 1, arg_2_0.preNode.index, arg_2_0.curEpisodeIndex, arg_2_0.curNode.index)

	arg_2_0:refreshPos()
	arg_2_0:refreshLineTexture()
end

function var_0_0.refreshPos(arg_3_0)
	local var_3_0, var_3_1 = RougeMapHelper.getNodeContainerPos(arg_3_0.curEpisodeIndex, arg_3_0.curNode:getEpisodePos())
	local var_3_2, var_3_3 = RougeMapHelper.getNodeContainerPos(arg_3_0.curEpisodeIndex - 1, arg_3_0.preNode:getEpisodePos())
	local var_3_4 = var_3_0 - RougeMapEnum.LineOffset
	local var_3_5 = var_3_2 + RougeMapEnum.LineOffset
	local var_3_6 = (var_3_4 + var_3_5) * 0.5
	local var_3_7 = (var_3_1 + var_3_3) * 0.5

	arg_3_0.startPosX = -math.sqrt((var_3_4 - var_3_5)^2 + (var_3_1 - var_3_3)^2) * 0.5
	arg_3_0.endPosX = -arg_3_0.startPosX

	arg_3_0.startPos:Set(arg_3_0.startPosX, 0, 0, 0)
	arg_3_0.startPosVec2:Set(arg_3_0.startPosX, 0)
	arg_3_0.mat:SetVector(var_0_0.ShaderParamDict.Start, arg_3_0.startPos)
	arg_3_0.endPos:Set(arg_3_0.endPosX, 0, 0, 0)
	arg_3_0.endPosVec2:Set(arg_3_0.endPosX, 0, 0, 0)
	arg_3_0.mat:SetVector(var_0_0.ShaderParamDict.End, arg_3_0.endPos)
	transformhelper.setLocalPos(arg_3_0.tr, var_3_6, var_3_7, 0)

	local var_3_8 = RougeMapHelper.getAngle(var_3_5, var_3_3, var_3_4, var_3_1)

	transformhelper.setLocalRotation(arg_3_0.tr, 0, 0, var_3_8)
	arg_3_0:refreshLineProgress()
end

function var_0_0.refreshLineProgress(arg_4_0)
	arg_4_0.isCurNodeFog = arg_4_0.curNode.fog
	arg_4_0.isPreNodeFog = arg_4_0.preNode.fog

	local var_4_0 = RougeMapModel.instance:isHoleNode(arg_4_0.preNode.nodeId)
	local var_4_1 = RougeMapEnum.NormalLineCutValue
	local var_4_2 = RougeMapEnum.NormalLineCutValue

	if arg_4_0.isCurNodeFog then
		if arg_4_0.isPreNodeFog then
			var_4_1 = RougeMapEnum.HideLineCutValue
			var_4_2 = RougeMapEnum.HideLineCutValue
		else
			var_4_1 = var_4_0 and RougeMapEnum.HoleLineCutValue or RougeMapEnum.FogLineCutValue
		end
	elseif arg_4_0.isPreNodeFog then
		var_4_2 = RougeMapEnum.HoleLineCutValue
	end

	arg_4_0.mat:SetFloat(var_0_0.ShaderParamDict.Cut1, var_4_1)
	arg_4_0.mat:SetFloat(var_0_0.ShaderParamDict.Cut2, var_4_2)
end

function var_0_0.refreshLineTexture(arg_5_0)
	arg_5_0.curArriveStatus = arg_5_0.curNode.arriveStatus
	arg_5_0.preArriveStatus = arg_5_0.preNode.arriveStatus

	local var_5_0 = RougeMapHelper.getLineType(arg_5_0.curArriveStatus, arg_5_0.preArriveStatus)

	arg_5_0.mat:SetTexture(var_0_0.ShaderParamDict.MainTex, arg_5_0.map.lineIconDict[var_5_0])
end

function var_0_0.onUpdateMapInfo(arg_6_0)
	if not arg_6_0:checkNeedRefresh() then
		return
	end

	arg_6_0.curArriveStatus = arg_6_0.curNode.arriveStatus
	arg_6_0.preArriveStatus = arg_6_0.preNode.arriveStatus

	arg_6_0:refreshPos()
	arg_6_0:refreshLineTexture()
end

function var_0_0.checkNeedRefresh(arg_7_0)
	return arg_7_0.curArriveStatus ~= arg_7_0.curNode.arriveStatus or arg_7_0.preArriveStatus ~= arg_7_0.preNode.arriveStatus or arg_7_0.isCurNodeFog ~= arg_7_0.curNode.fog or arg_7_0.isPreNodeFog ~= arg_7_0.preNode.fog
end

function var_0_0.getActorPos(arg_8_0, arg_8_1)
	local var_8_0, var_8_1 = ZProj.ArcFollowHelper.GetArcToLocalPos(arg_8_1, arg_8_0.startPosVec2, arg_8_0.endPosVec2, arg_8_0.angle, nil, nil)
	local var_8_2, var_8_3 = SLFramework.TransformHelper.LocalPosToWorldPos(arg_8_0.tr, var_8_0, var_8_1, 0, nil, nil, nil)
	local var_8_4, var_8_5 = SLFramework.TransformHelper.WorldPosToLocalPos(arg_8_0.map.trLayerPiecesContainer, var_8_2, var_8_3, 0, nil, nil, nil)
	local var_8_6 = var_8_5

	return var_8_4, var_8_6, 0
end

function var_0_0.destroy(arg_9_0)
	arg_9_0:__onDispose()
end

return var_0_0
