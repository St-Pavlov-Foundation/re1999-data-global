module("modules.logic.scene.explore.comp.ExploreScenePPVolume", package.seeall)

slot0 = class("ExploreScenePPVolume", BaseSceneComp)
slot0.ExploreHighProfilePath = "ppassets/profiles/msts_profile_high.asset"
slot0.ExploreMiddleProfilePath = "ppassets/profiles/msts_profile_middle.asset"
slot0.ExploreLowProfilePath = "ppassets/profiles/msts_profile_low.asset"

function slot0.onSceneStart(slot0, slot1, slot2)
	slot0:initPPVolume()
	slot0:_setCamera()
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnQualityChange, slot0.updatePPLevel, slot0)
end

function slot0.initPPVolume(slot0)
	if slot0._ppVolumeGo then
		return
	end

	slot0._highProfile = ConstAbCache.instance:getRes(uv0.ExploreHighProfilePath)
	slot0._middleProfile = ConstAbCache.instance:getRes(uv0.ExploreMiddleProfilePath)
	slot0._lowProfile = ConstAbCache.instance:getRes(uv0.ExploreLowProfilePath)

	gohelper.setActive(CameraMgr.instance:getUnitCameraGO(), false)

	slot0._ppVolumeGo = gohelper.create3d(CameraMgr.instance:getMainCameraGO(), "PPVolume")
	slot0._ppVolumeWrap = gohelper.onceAddComponent(slot0._ppVolumeGo, PostProcessingMgr.PPVolumeWrapType)

	slot0:updatePPLevel()
end

function slot0._setCamera(slot0)
	slot2 = CameraMgr.instance:getMainCameraGO():GetComponent(PostProcessingMgr.PPCustomCamDataType)
	slot0._originalusePostProcess = slot2.usePostProcess
	slot0._originalMainCameraVolumeTrigger = slot2.volumeTrigger
	slot2.usePostProcess = true
	slot2.volumeTrigger = slot0._ppVolumeGo.transform
end

function slot0._resetCamera(slot0)
	slot2 = CameraMgr.instance:getMainCameraGO():GetComponent(PostProcessingMgr.PPCustomCamDataType)
	slot2.usePostProcess = slot0._originalusePostProcess
	slot2.volumeTrigger = slot0._originalMainCameraVolumeTrigger
	slot0._originalusePostProcess = nil
	slot0._originalMainCameraVolumeTrigger = nil
end

function slot0.updatePPLevel(slot0)
	if not slot0._ppVolumeWrap then
		return
	end

	slot2 = slot0._highProfile
	slot3 = CameraMgr.instance:getMainCameraGO()

	if GameGlobalMgr.instance:getScreenState():getLocalQuality() == ModuleEnum.Performance.High then
		slot2 = slot0._highProfile
	elseif slot1 == ModuleEnum.Performance.Middle then
		slot2 = slot0._middleProfile
	elseif slot1 == ModuleEnum.Performance.Low then
		slot2 = slot0._lowProfile
	end

	slot0._ppVolumeWrap:SetProfile(slot2)
end

function slot0.destoryPPVolume(slot0)
	if not slot0._ppVolumeGo then
		return
	end

	gohelper.setActive(CameraMgr.instance:getUnitCameraGO(), true)
	gohelper.destroy(slot0._ppVolumeGo)

	slot0._ppVolumeGo = nil
	slot0._ppVolumeWrap = nil
	slot0._highProfile = nil
	slot0._middleProfile = nil
	slot0._lowProfile = nil
end

function slot0.onSceneClose(slot0)
	slot0:_resetCamera()
	slot0:destoryPPVolume()
	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnQualityChange, slot0.updatePPLevel, slot0)
end

return slot0
