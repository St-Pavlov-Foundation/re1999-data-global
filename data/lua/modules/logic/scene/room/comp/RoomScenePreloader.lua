module("modules.logic.scene.room.comp.RoomScenePreloader", package.seeall)

slot0 = class("RoomScenePreloader", BaseSceneComp)
slot0.OnPreloadFinish = 1
slot0.ResDebugPackageUI = "ui/viewres/room/debug/roomdebugpackageui.prefab"
slot0.ResEffectB = "scenes/m_s07_xiaowu/prefab/effects/effects_b.prefab"
slot0.ResEffectE = "scenes/m_s07_xiaowu/prefab/effects/effects_e.prefab"
slot0.ResEffectF = "scenes/m_s07_xiaowu/prefab/effects/effects_f.prefab"
slot0.ResEffectD01 = "scenes/m_s07_xiaowu/prefab/effects/effects_d01.prefab"
slot0.ResEffectD02 = "scenes/m_s07_xiaowu/prefab/effects/effects_d02.prefab"
slot0.ResEffectD03 = "scenes/m_s07_xiaowu/prefab/effects/effects_d03.prefab"
slot0.ResEffectD04 = "scenes/m_s07_xiaowu/prefab/effects/effects_d04.prefab"
slot0.ResEffectD05 = "scenes/m_s07_xiaowu/prefab/effects/effects_d05.prefab"
slot0.ResEffectD06 = "scenes/m_s07_xiaowu/prefab/effects/effects_d06.prefab"
slot0.ResEffectBlue01 = "scenes/m_s07_xiaowu/prefab/effects/effect_transport_blue_01.prefab"
slot0.ResEffectBlue02 = "scenes/m_s07_xiaowu/prefab/effects/effect_transport_blue_02.prefab"
slot0.ResEffectGreen01 = "scenes/m_s07_xiaowu/prefab/effects/effect_transport_green_01.prefab"
slot0.ResEffectGreen02 = "scenes/m_s07_xiaowu/prefab/effects/effect_transport_green_02.prefab"
slot0.ResEffectYellow01 = "scenes/m_s07_xiaowu/prefab/effects/effect_transport_yellow_01.prefab"
slot0.ResEffectYellow02 = "scenes/m_s07_xiaowu/prefab/effects/effect_transport_yellow_02.prefab"
slot0.ResEffectRed01 = "scenes/m_s07_xiaowu/prefab/effects/effect_transport_red_01.prefab"
slot0.ResVXPlacingHere = "scenes/m_s07_xiaowu/prefab/vx/vx_placinghere.prefab"
slot0.ResSmoke = "scenes/m_s07_xiaowu/prefab/vx/smoke.prefab"
slot0.ResSmokeSnow = "scenes/m_s07_xiaowu/prefab/vx/v1a8_wl/v1a8_smoke.prefab"
slot0.BlockTypeSmokeDict = {
	[15] = slot0.ResSmokeSnow,
	[16] = slot0.ResSmokeSnow
}
slot0.ResVXXuXian = "scenes/m_s07_xiaowu/prefab/vx/vx_xuxian.prefab"
slot0.ResVXWater = "scenes/m_s07_xiaowu/prefab/vx/vx_water.prefab"
slot0.ResInitBuilding = "scenes/m_s07_xiaowu/prefab/jianzhu/a_rukou/rukou.prefab"
slot0.ResCharacterClickHelper = "scenes/m_s07_xiaowu/prefab/characterclickhelper.prefab"
slot0.DefaultLand = "scenes/m_s07_xiaowu/prefab/ground/floor/01.prefab"
slot0.InitLand = "scenes/m_s07_xiaowu/prefab/ground/floor/02.prefab"
slot0.LandAB = "scenes/m_s07_xiaowu/prefab/ground"
slot0.ReplaceLand = "scenes/m_s07_xiaowu/prefab/ground/floor/01b.prefab"
slot0.ResFogParticle = "scenes/m_s07_xiaowu/a_fufeice/prefab/bxhy_fogparticle.prefab"
slot0.DiffuseGI = "scenes/m_s07_xiaowu/prefab/diffuse_gi.prefab"
slot0.ResEffectWaveList = {
	"scenes/m_s07_xiaowu/prefab/effects/bolang01.prefab",
	"scenes/m_s07_xiaowu/prefab/effects/bolang02.prefab",
	"scenes/m_s07_xiaowu/prefab/effects/bolang03.prefab",
	"scenes/m_s07_xiaowu/prefab/effects/bolang04.prefab",
	"scenes/m_s07_xiaowu/prefab/effects/bolang05.prefab",
	"scenes/m_s07_xiaowu/prefab/effects/bolang06.prefab"
}
slot0.ResEffectWaveWithRiverList = {
	"scenes/m_s07_xiaowu/prefab/ground/floor_water/effects/bolang01.prefab",
	"scenes/m_s07_xiaowu/prefab/ground/floor_water/effects/bolang02.prefab",
	"scenes/m_s07_xiaowu/prefab/ground/floor_water/effects/bolang03.prefab",
	"scenes/m_s07_xiaowu/prefab/ground/floor_water/effects/bolang04.prefab",
	"scenes/m_s07_xiaowu/prefab/ground/floor_water/effects/bolang05.prefab",
	"scenes/m_s07_xiaowu/prefab/ground/floor_water/effects/bolang06.prefab"
}
slot0.ResResourceColorDict = {
	[RoomResourceEnum.ResourceId.Plant] = "scenes/m_s07_xiaowu/prefab/effects/effect_similar_02.prefab",
	[RoomResourceEnum.ResourceId.Building] = "scenes/m_s07_xiaowu/prefab/effects/effect_similar_04.prefab",
	[RoomResourceEnum.ResourceId.Sculpture] = "scenes/m_s07_xiaowu/prefab/effects/effect_similar_03.prefab",
	[RoomResourceEnum.ResourceId.River] = "scenes/m_s07_xiaowu/prefab/effects/effect_similar_01.prefab"
}
slot0.ResResourceVehicleDict = {
	[RoomResourceEnum.ResourceId.River] = "scenes/m_s07_xiaowu/prefab/building/building_xiaochuan.prefab",
	[RoomResourceEnum.ResourceId.Road] = "scenes/m_s07_xiaowu/prefab/building/terrain_dabache_a.prefab",
	[RoomResourceEnum.ResourceId.Railway] = "scenes/m_s07_xiaowu/prefab/building/terrain_dabache_a.prefab"
}
slot0.ResDebugPackageColorOther = "scenes/m_s07_xiaowu/prefab/effects/effect_debugpackage_other.prefab"
slot0.ResDebugPackageColorDict = {
	[-2] = slot0.ResDebugPackageColorOther,
	[RoomResourceEnum.ResourceId.Empty] = "scenes/m_s07_xiaowu/prefab/effects/effect_debugpackage.prefab",
	[RoomResourceEnum.ResourceId.None] = "scenes/m_s07_xiaowu/prefab/effects/effect_debugpackage_0.prefab",
	[RoomResourceEnum.ResourceId.Plant] = "scenes/m_s07_xiaowu/prefab/effects/effect_debugpackage_2.prefab",
	[RoomResourceEnum.ResourceId.Building] = "scenes/m_s07_xiaowu/prefab/effects/effect_debugpackage_4.prefab",
	[RoomResourceEnum.ResourceId.Sculpture] = "scenes/m_s07_xiaowu/prefab/effects/effect_debugpackage_3.prefab",
	[RoomResourceEnum.ResourceId.River] = "scenes/m_s07_xiaowu/prefab/effects/effect_debugpackage_1.prefab"
}
slot0.ResCharacterFaithMax = "scenes/m_s07_xiaowu/prefab/effects/bxhy_effect_icon_a.prefab"
slot0.ResCharacterFaithFull = "scenes/m_s07_xiaowu/prefab/effects/bxhy_effect_icon_b.prefab"
slot0.ResCharacterFaithNormal = "scenes/m_s07_xiaowu/prefab/effects/bxhy_effect_icon_c.prefab"
slot0.ResCharacterChat = "scenes/m_s07_xiaowu/prefab/effects/bxhy_effect_icon_e.prefab"
slot0.ResCommonList = {
	slot0.ResCharacterFaithMax,
	slot0.ResCharacterFaithFull,
	slot0.ResCharacterFaithNormal,
	slot0.ResCharacterChat
}
slot0.ResAnim = {
	Inventory = "scenes/dynamic/m_s07_xiaowu/anim/vx/inventory.controller",
	PlaceCharacter = "scenes/dynamic/m_s07_xiaowu/anim/vx/vx_renwu.controller",
	ContainerUp = "scenes/dynamic/m_s07_xiaowu/anim/vx/container_up.controller",
	ContainerPlay = "scenes/dynamic/m_s07_xiaowu/anim/vx/container_play.controller",
	PressingCharacter = "scenes/dynamic/m_s07_xiaowu/anim/vx/renwutuodong.controller"
}
slot0.ResOcean = "scenes/m_s07_xiaowu/prefab/ground/water/ocean.prefab"
slot0.ResEffectConfirmCharacter = "scenes/m_s07_xiaowu/prefab/vx/renwurukou.prefab"
slot0.ResEffectCharacterShadow = "scenes/m_s07_xiaowu/prefab/character/shadow.prefab"
slot0.ResEffectPressingCharacter = "scenes/m_s07_xiaowu/prefab/vx/temp_tuodongjuese.prefab"
slot0.ResEffectPlaceCharacter = "scenes/m_s07_xiaowu/prefab/vx/vx_men.prefab"
slot0.ResCharacterFaithEffect = "scenes/m_s07_xiaowu/prefab/vx/vx_friend.prefab"
slot0.ResCharacterClickEffect = "scenes/m_s07_xiaowu/prefab/vx/vx_click.prefab"
slot0.ResEquipRoomSkinEffect = "scenes/m_s07_xiaowu/prefab/vx/v1a9_changeskin/v1a9_changeskin1.prefab"
slot0.RecCharacterBirthdayEffect = "scenes/m_s07_xiaowu/prefab/vx/meeting_years_fireworks.prefab"
slot0.CritterBuildingSeatSlot = "scenes/m_s07_xiaowu/prefab/vx/v2a2_lock/v2a2_lock_22101_seat.prefab"
slot0.ResCritterEvent = {
	SurpriseCollect = "scenes/m_s07_xiaowu/prefab/ui/mapbubble4.prefab",
	TrainEventComplete = "scenes/m_s07_xiaowu/prefab/ui/mapbubble2.prefab",
	HasTrainEvent = "scenes/m_s07_xiaowu/prefab/ui/mapbubble1.prefab",
	NoMoodWork = "scenes/m_s07_xiaowu/prefab/ui/mapbubble3.prefab"
}

function slot0.onInit(slot0)
	slot0._preloadSequence = FlowSequence.New()

	if RoomController.instance:isEditorMode() then
		slot0._preloadSequence:addWork(RoomPreloadMapBlockWork.New())
		slot0._preloadSequence:addWork(RoomPreloadUIWork.New())
	end

	slot0._preloadSequence:addWork(RoomPreloadGOWork.New())
	slot0._preloadSequence:addWork(RoomPreloadAnimWork.New())

	if RoomController.instance:isEditorMode() then
		slot0._preloadSequence:addWork(RoomPreloadBuildingWork.New())
		slot0._preloadSequence:addWork(RoomPreloadBlockPackageWork.New())
	end

	slot0._context = {
		callback = slot0._onPreloadWorkDone,
		callbackObj = slot0
	}
	slot0._initialized = false

	GameSceneMgr.instance:registerCallback(SceneEventName.ExitScene, slot0._onExitScene, slot0)
end

function slot0._onExitScene(slot0, slot1, slot2, slot3)
	if not slot3 or slot3 ~= SceneType.Room then
		slot0:_releaseAssetItemDict(slot0._preAssetItemDict)

		slot0._preAssetItemDict = nil
	end
end

function slot0.init(slot0, slot1, slot2)
	slot0._initialized = true
	slot0._context.poolGODict = {}
	slot0._context.resABDict = {}
	slot0._context.poolUIDict = {}
	slot0._assetItemDict = slot0._assetItemDict or {}
	slot0._assetItemTimeDict = slot0._assetItemTimeDict or {}

	slot0._preloadSequence:registerDoneListener(slot0._onPreloadDone, slot0)
	slot0._preloadSequence:start(slot0._context)
end

function slot0._onPreloadWorkDone(slot0, slot1, slot2)
	slot0:addAssetItem(slot1, slot2)
end

function slot0._loadAssetsCb(slot0, slot1)
end

function slot0.addAssetItem(slot0, slot1, slot2)
	if not slot0._initialized then
		return
	end

	if not slot0._assetItemDict[slot1] then
		slot0._assetItemTimeDict[slot1] = Time.time
		slot3 = RoomAssetItem.New()

		slot3:init(slot2, slot1)

		slot0._assetItemDict[slot1] = slot3

		slot3:Retain()
	end
end

function slot0._onPreloadDone(slot0)
	slot0:_releaseAssetItemDict(slot0._preAssetItemDict)

	slot0._preAssetItemDict = nil

	slot0:_initPools()
	slot0:dispatchEvent(uv0.OnPreloadFinish)
end

function slot0._getAssetItem(slot0, slot1)
	return slot0._assetItemDict and slot0._assetItemDict[slot1]
end

function slot0.onSceneClose(slot0)
	slot0._initialized = false

	slot0._preloadSequence:unregisterDoneListener(slot0._onPreloadDone, slot0)
	slot0._preloadSequence:stop()
	slot0:disposePools()
	slot0:_releaseAssetItemDict(slot0._preAssetItemDict)

	slot0._preAssetItemDict = nil
	slot0._preAssetItemDict = slot0._assetItemDict
	slot0._assetItemDict = nil
end

function slot0._releaseAssetItemDict(slot0, slot1)
	if slot1 then
		for slot5, slot6 in pairs(slot1) do
			slot6:Release()
		end
	end
end

function slot0.getResource(slot0, slot1, slot2)
	slot3 = slot2 or slot1

	if GameResMgr.IsFromEditorDir then
		slot3 = slot1
	end

	if not slot0:_getAssetItem(slot3) then
		-- Nothing
	end

	if slot4 then
		return slot4:GetResource(slot1)
	end
end

function slot0._initPools(slot0)
	if not slot0._poolInitialized then
		slot0._poolInitialized = true

		RoomUIPool.init({})
		RoomGOPool.init({}, {})
	end
end

function slot0.disposePools(slot0)
	slot0._poolInitialized = false

	RoomUIPool.dispose()
	RoomGOPool.dispose()
end

function slot0.clearPools(slot0)
	if not slot0._initialized then
		return
	end

	RoomGOPool.clearPool()

	for slot5, slot6 in pairs(slot0._assetItemDict) do
		if Time.time - 1 > (slot0._assetItemTimeDict[slot5] or 0) and slot6 and RoomGOPool.existABPath(slot5) == false then
			slot0._assetItemDict[slot5] = nil
			slot0._assetItemTimeDict[slot5] = 0

			slot6:Release()
		end
	end
end

function slot0.exist(slot0, slot1)
	return slot0:_getAssetItem(slot1) and true or false
end

return slot0
