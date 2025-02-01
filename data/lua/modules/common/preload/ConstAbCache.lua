module("modules.common.preload.ConstAbCache", package.seeall)

slot0 = class("ConstAbCache")

function slot0.ctor(slot0)
	slot0._pathTab = {
		"ui/viewres/rpcblock/rpcblock.prefab",
		PostProcessingMgr.MainHighProfilePath,
		PostProcessingMgr.MainMiddleProfilePath,
		PostProcessingMgr.MainLowProfilePath,
		ExploreScenePPVolume.ExploreHighProfilePath,
		ExploreScenePPVolume.ExploreMiddleProfilePath,
		ExploreScenePPVolume.ExploreLowProfilePath,
		PostProcessingMgr.CaptureResPath
	}
	slot0._pathResTab = {}
end

function slot0.getRes(slot0, slot1)
	return slot0._pathResTab[slot1]
end

function slot0.startLoad(slot0, slot1, slot2)
	slot0._finishCb = slot1
	slot0._finishCbObj = slot2
	slot0._needCount = #slot0._pathTab

	for slot6, slot7 in ipairs(slot0._pathTab) do
		loadAbAsset(slot7, false, slot0._onLoadOne, slot0)
	end
end

function slot0._onLoadOne(slot0, slot1)
	if slot1.IsLoadSuccess then
		slot1:Retain()

		slot0._pathResTab[slot1.ResPath] = slot1:GetResource()
		slot0._needCount = slot0._needCount - 1

		if slot0._needCount == 0 then
			if slot0._finishCb then
				slot0._finishCb(slot0._finishCbObj)

				slot0._finishCb = nil
				slot0._finishCbObj = nil
			end

			logNormal("ConstAbCache 预加载ab资源完成了!")
		end

		return
	end

	logError("ConstAbCache 预加载ab资源失败，path = " .. slot1.ResPath)
end

slot0.instance = slot0.New()

return slot0
