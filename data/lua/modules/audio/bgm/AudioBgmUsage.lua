module("modules.audio.bgm.AudioBgmUsage", package.seeall)

slot0 = class("AudioBgmUsage")

function slot0.ctor(slot0)
	slot0.layerList = nil
	slot0.type = nil
	slot0.typeParam = nil
	slot0.queryFunc = nil
	slot0.queryFuncTarget = nil
	slot0.clearPauseBgm = nil
end

function slot0.containBgm(slot0, slot1)
	return tabletool.indexOf(slot0.layerList, slot1)
end

function slot0.setClearPauseBgm(slot0, slot1)
	slot0.clearPauseBgm = slot1
end

function slot0.getBgmLayer(slot0)
	if #slot0.layerList == 1 then
		return slot0.layerList[1]
	end

	if slot0.queryFunc then
		return slot0.queryFunc(slot0.queryFuncTarget, slot0)
	end
end

return slot0
