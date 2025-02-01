module("modules.logic.explore.map.unit.comp.ExplorePipeComp", package.seeall)

slot0 = class("ExplorePipeComp", LuaCompBase)
slot1 = UnityEngine.Shader.PropertyToID("_GasColor")
slot2 = UnityEngine.Shader.PropertyToID("_Fade")
slot3 = UnityEngine.Shader.PropertyToID("_Process")

function slot0.ctor(slot0, slot1)
	slot0.unit = slot1
	slot0._allMatDict = {}
	slot0._dirToPipeType = {}
	slot0._fromColor = {}
	slot0._toColor = {}
end

function slot0.initData(slot0)
	for slot4 = 0, 270, 90 do
		slot0._dirToPipeType[slot4] = slot0.unit.mo:getDirType(slot4)
	end

	slot0._dirToPipeType[-1] = ExploreEnum.PipeGoNode.Center
end

function slot0.setup(slot0, slot1)
	slot0.go = slot1
	slot0._allMatDict = {}

	for slot5, slot6 in pairs(ExploreEnum.PipeGoNodeName) do
		if slot0:_getMat(slot6) then
			slot0._allMatDict[slot5] = slot7

			slot0._allMatDict[slot5]:SetFloat(uv0, 1)
		end
	end

	slot0:tweenColor(1)
end

function slot0._getMat(slot0, slot1)
	if not gohelper.findChild(slot0.go, "#go_rotate/" .. slot1) then
		return
	end

	return slot2:GetComponent(typeof(UnityEngine.Renderer)) and slot3.material
end

function slot0.applyColor(slot0, slot1)
	for slot5, slot6 in pairs(slot0._dirToPipeType) do
		slot0._fromColor[slot5] = slot0._toColor[slot5]
		slot0._toColor[slot5] = slot0.unit.mo:getColor(slot5)
	end

	slot0._toColor[-1] = slot0.unit.mo:getColor(-1)

	if slot1 then
		for slot5, slot6 in pairs(slot0._toColor) do
			slot0._fromColor[slot5] = slot6
		end

		slot0._fromColor[-1] = slot0._toColor[-1]

		slot0:tweenColor(1)
	end
end

slot4 = Color()

function slot0.tweenColor(slot0, slot1)
	for slot5, slot6 in pairs(slot0._toColor) do
		if slot0._allMatDict[slot0._dirToPipeType[slot5]] then
			if slot6 == slot0._fromColor[slot5] then
				if slot6 == ExploreEnum.PipeColor.None then
					slot8:SetFloat(uv0, 1)
				else
					slot8:SetFloat(uv0, 0)
					slot8:SetColor(uv1, ExploreEnum.PipeColorDef[slot6])
				end
			elseif slot6 == ExploreEnum.PipeColor.None then
				slot8:SetFloat(uv0, slot1)
			elseif slot0._fromColor[slot5] == ExploreEnum.PipeColor.None then
				slot8:SetFloat(uv0, 1 - slot1)
				slot8:SetColor(uv1, ExploreEnum.PipeColorDef[slot6])
			else
				slot8:SetFloat(uv0, 0)
				slot8:SetColor(uv1, MaterialUtil.getLerpValue("Color", ExploreEnum.PipeColorDef[slot0._fromColor[slot5]], ExploreEnum.PipeColorDef[slot6], slot1, uv2))
			end
		end
	end
end

function slot0.clear(slot0)
	slot0._allMatDict = {}
end

function slot0.onDestroy(slot0)
	slot0:clear()

	slot0._fromColor = {}
	slot0._toColor = {}
	slot0._dirToPipeType = {}
	slot0.unit = nil
end

return slot0
