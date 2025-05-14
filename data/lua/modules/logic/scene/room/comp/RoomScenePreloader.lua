module("modules.logic.scene.room.comp.RoomScenePreloader", package.seeall)

local var_0_0 = class("RoomScenePreloader", BaseSceneComp)

var_0_0.OnPreloadFinish = 1
var_0_0.ResDebugPackageUI = "ui/viewres/room/debug/roomdebugpackageui.prefab"
var_0_0.ResEffectB = "scenes/m_s07_xiaowu/prefab/effects/effects_b.prefab"
var_0_0.ResEffectE = "scenes/m_s07_xiaowu/prefab/effects/effects_e.prefab"
var_0_0.ResEffectF = "scenes/m_s07_xiaowu/prefab/effects/effects_f.prefab"
var_0_0.ResEffectD01 = "scenes/m_s07_xiaowu/prefab/effects/effects_d01.prefab"
var_0_0.ResEffectD02 = "scenes/m_s07_xiaowu/prefab/effects/effects_d02.prefab"
var_0_0.ResEffectD03 = "scenes/m_s07_xiaowu/prefab/effects/effects_d03.prefab"
var_0_0.ResEffectD04 = "scenes/m_s07_xiaowu/prefab/effects/effects_d04.prefab"
var_0_0.ResEffectD05 = "scenes/m_s07_xiaowu/prefab/effects/effects_d05.prefab"
var_0_0.ResEffectD06 = "scenes/m_s07_xiaowu/prefab/effects/effects_d06.prefab"
var_0_0.ResEffectBlue01 = "scenes/m_s07_xiaowu/prefab/effects/effect_transport_blue_01.prefab"
var_0_0.ResEffectBlue02 = "scenes/m_s07_xiaowu/prefab/effects/effect_transport_blue_02.prefab"
var_0_0.ResEffectGreen01 = "scenes/m_s07_xiaowu/prefab/effects/effect_transport_green_01.prefab"
var_0_0.ResEffectGreen02 = "scenes/m_s07_xiaowu/prefab/effects/effect_transport_green_02.prefab"
var_0_0.ResEffectYellow01 = "scenes/m_s07_xiaowu/prefab/effects/effect_transport_yellow_01.prefab"
var_0_0.ResEffectYellow02 = "scenes/m_s07_xiaowu/prefab/effects/effect_transport_yellow_02.prefab"
var_0_0.ResEffectRed01 = "scenes/m_s07_xiaowu/prefab/effects/effect_transport_red_01.prefab"
var_0_0.ResVXPlacingHere = "scenes/m_s07_xiaowu/prefab/vx/vx_placinghere.prefab"
var_0_0.ResSmoke = "scenes/m_s07_xiaowu/prefab/vx/smoke.prefab"
var_0_0.ResSmokeSnow = "scenes/m_s07_xiaowu/prefab/vx/v1a8_wl/v1a8_smoke.prefab"
var_0_0.BlockTypeSmokeDict = {
	[15] = var_0_0.ResSmokeSnow,
	[16] = var_0_0.ResSmokeSnow
}
var_0_0.ResVXXuXian = "scenes/m_s07_xiaowu/prefab/vx/vx_xuxian.prefab"
var_0_0.ResVXWater = "scenes/m_s07_xiaowu/prefab/vx/vx_water.prefab"
var_0_0.ResInitBuilding = "scenes/m_s07_xiaowu/prefab/jianzhu/a_rukou/rukou.prefab"
var_0_0.ResCharacterClickHelper = "scenes/m_s07_xiaowu/prefab/characterclickhelper.prefab"
var_0_0.DefaultLand = "scenes/m_s07_xiaowu/prefab/ground/floor/01.prefab"
var_0_0.InitLand = "scenes/m_s07_xiaowu/prefab/ground/floor/02.prefab"
var_0_0.LandAB = "scenes/m_s07_xiaowu/prefab/ground"
var_0_0.ReplaceLand = "scenes/m_s07_xiaowu/prefab/ground/floor/01b.prefab"
var_0_0.ResFogParticle = "scenes/m_s07_xiaowu/a_fufeice/prefab/bxhy_fogparticle.prefab"
var_0_0.DiffuseGI = "scenes/m_s07_xiaowu/prefab/diffuse_gi.prefab"
var_0_0.ResEffectWaveList = {
	"scenes/m_s07_xiaowu/prefab/effects/bolang01.prefab",
	"scenes/m_s07_xiaowu/prefab/effects/bolang02.prefab",
	"scenes/m_s07_xiaowu/prefab/effects/bolang03.prefab",
	"scenes/m_s07_xiaowu/prefab/effects/bolang04.prefab",
	"scenes/m_s07_xiaowu/prefab/effects/bolang05.prefab",
	"scenes/m_s07_xiaowu/prefab/effects/bolang06.prefab"
}
var_0_0.ResEffectWaveWithRiverList = {
	"scenes/m_s07_xiaowu/prefab/ground/floor_water/effects/bolang01.prefab",
	"scenes/m_s07_xiaowu/prefab/ground/floor_water/effects/bolang02.prefab",
	"scenes/m_s07_xiaowu/prefab/ground/floor_water/effects/bolang03.prefab",
	"scenes/m_s07_xiaowu/prefab/ground/floor_water/effects/bolang04.prefab",
	"scenes/m_s07_xiaowu/prefab/ground/floor_water/effects/bolang05.prefab",
	"scenes/m_s07_xiaowu/prefab/ground/floor_water/effects/bolang06.prefab"
}
var_0_0.ResResourceColorDict = {
	[RoomResourceEnum.ResourceId.Plant] = "scenes/m_s07_xiaowu/prefab/effects/effect_similar_02.prefab",
	[RoomResourceEnum.ResourceId.Building] = "scenes/m_s07_xiaowu/prefab/effects/effect_similar_04.prefab",
	[RoomResourceEnum.ResourceId.Sculpture] = "scenes/m_s07_xiaowu/prefab/effects/effect_similar_03.prefab",
	[RoomResourceEnum.ResourceId.River] = "scenes/m_s07_xiaowu/prefab/effects/effect_similar_01.prefab"
}
var_0_0.ResResourceVehicleDict = {
	[RoomResourceEnum.ResourceId.River] = "scenes/m_s07_xiaowu/prefab/building/building_xiaochuan.prefab",
	[RoomResourceEnum.ResourceId.Road] = "scenes/m_s07_xiaowu/prefab/building/terrain_dabache_a.prefab",
	[RoomResourceEnum.ResourceId.Railway] = "scenes/m_s07_xiaowu/prefab/building/terrain_dabache_a.prefab"
}
var_0_0.ResDebugPackageColorOther = "scenes/m_s07_xiaowu/prefab/effects/effect_debugpackage_other.prefab"
var_0_0.ResDebugPackageColorDict = {
	[-2] = var_0_0.ResDebugPackageColorOther,
	[RoomResourceEnum.ResourceId.Empty] = "scenes/m_s07_xiaowu/prefab/effects/effect_debugpackage.prefab",
	[RoomResourceEnum.ResourceId.None] = "scenes/m_s07_xiaowu/prefab/effects/effect_debugpackage_0.prefab",
	[RoomResourceEnum.ResourceId.Plant] = "scenes/m_s07_xiaowu/prefab/effects/effect_debugpackage_2.prefab",
	[RoomResourceEnum.ResourceId.Building] = "scenes/m_s07_xiaowu/prefab/effects/effect_debugpackage_4.prefab",
	[RoomResourceEnum.ResourceId.Sculpture] = "scenes/m_s07_xiaowu/prefab/effects/effect_debugpackage_3.prefab",
	[RoomResourceEnum.ResourceId.River] = "scenes/m_s07_xiaowu/prefab/effects/effect_debugpackage_1.prefab"
}
var_0_0.ResCharacterFaithMax = "scenes/m_s07_xiaowu/prefab/effects/bxhy_effect_icon_a.prefab"
var_0_0.ResCharacterFaithFull = "scenes/m_s07_xiaowu/prefab/effects/bxhy_effect_icon_b.prefab"
var_0_0.ResCharacterFaithNormal = "scenes/m_s07_xiaowu/prefab/effects/bxhy_effect_icon_c.prefab"
var_0_0.ResCharacterChat = "scenes/m_s07_xiaowu/prefab/effects/bxhy_effect_icon_e.prefab"
var_0_0.ResCommonList = {
	var_0_0.ResCharacterFaithMax,
	var_0_0.ResCharacterFaithFull,
	var_0_0.ResCharacterFaithNormal,
	var_0_0.ResCharacterChat
}
var_0_0.ResAnim = {
	Inventory = "scenes/dynamic/m_s07_xiaowu/anim/vx/inventory.controller",
	PlaceCharacter = "scenes/dynamic/m_s07_xiaowu/anim/vx/vx_renwu.controller",
	ContainerUp = "scenes/dynamic/m_s07_xiaowu/anim/vx/container_up.controller",
	ContainerPlay = "scenes/dynamic/m_s07_xiaowu/anim/vx/container_play.controller",
	PressingCharacter = "scenes/dynamic/m_s07_xiaowu/anim/vx/renwutuodong.controller"
}
var_0_0.ResOcean = "scenes/m_s07_xiaowu/prefab/ground/water/ocean.prefab"
var_0_0.ResEffectConfirmCharacter = "scenes/m_s07_xiaowu/prefab/vx/renwurukou.prefab"
var_0_0.ResEffectCharacterShadow = "scenes/m_s07_xiaowu/prefab/character/shadow.prefab"
var_0_0.ResEffectPressingCharacter = "scenes/m_s07_xiaowu/prefab/vx/temp_tuodongjuese.prefab"
var_0_0.ResEffectPlaceCharacter = "scenes/m_s07_xiaowu/prefab/vx/vx_men.prefab"
var_0_0.ResCharacterFaithEffect = "scenes/m_s07_xiaowu/prefab/vx/vx_friend.prefab"
var_0_0.ResCharacterClickEffect = "scenes/m_s07_xiaowu/prefab/vx/vx_click.prefab"
var_0_0.ResEquipRoomSkinEffect = "scenes/m_s07_xiaowu/prefab/vx/v1a9_changeskin/v1a9_changeskin1.prefab"
var_0_0.RecCharacterBirthdayEffect = "scenes/m_s07_xiaowu/prefab/vx/meeting_years_fireworks.prefab"
var_0_0.CritterBuildingSeatSlot = "scenes/m_s07_xiaowu/prefab/vx/v2a2_lock/v2a2_lock_22101_seat.prefab"
var_0_0.ResCritterEvent = {
	SurpriseCollect = "scenes/m_s07_xiaowu/prefab/ui/mapbubble4.prefab",
	TrainEventComplete = "scenes/m_s07_xiaowu/prefab/ui/mapbubble2.prefab",
	HasTrainEvent = "scenes/m_s07_xiaowu/prefab/ui/mapbubble1.prefab",
	NoMoodWork = "scenes/m_s07_xiaowu/prefab/ui/mapbubble3.prefab"
}

function var_0_0.onInit(arg_1_0)
	arg_1_0._preloadSequence = FlowSequence.New()

	if RoomController.instance:isEditorMode() then
		arg_1_0._preloadSequence:addWork(RoomPreloadMapBlockWork.New())
		arg_1_0._preloadSequence:addWork(RoomPreloadUIWork.New())
	end

	arg_1_0._preloadSequence:addWork(RoomPreloadGOWork.New())
	arg_1_0._preloadSequence:addWork(RoomPreloadAnimWork.New())

	if RoomController.instance:isEditorMode() then
		arg_1_0._preloadSequence:addWork(RoomPreloadBuildingWork.New())
		arg_1_0._preloadSequence:addWork(RoomPreloadBlockPackageWork.New())
	end

	arg_1_0._context = {}
	arg_1_0._context.callback = arg_1_0._onPreloadWorkDone
	arg_1_0._context.callbackObj = arg_1_0
	arg_1_0._initialized = false

	GameSceneMgr.instance:registerCallback(SceneEventName.ExitScene, arg_1_0._onExitScene, arg_1_0)
end

function var_0_0._onExitScene(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	if not arg_2_3 or arg_2_3 ~= SceneType.Room then
		arg_2_0:_releaseAssetItemDict(arg_2_0._preAssetItemDict)

		arg_2_0._preAssetItemDict = nil
	end
end

function var_0_0.init(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._initialized = true
	arg_3_0._context.poolGODict = {}
	arg_3_0._context.resABDict = {}
	arg_3_0._context.poolUIDict = {}
	arg_3_0._assetItemDict = arg_3_0._assetItemDict or {}
	arg_3_0._assetItemTimeDict = arg_3_0._assetItemTimeDict or {}

	arg_3_0._preloadSequence:registerDoneListener(arg_3_0._onPreloadDone, arg_3_0)
	arg_3_0._preloadSequence:start(arg_3_0._context)
end

function var_0_0._onPreloadWorkDone(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0:addAssetItem(arg_4_1, arg_4_2)
end

function var_0_0._loadAssetsCb(arg_5_0, arg_5_1)
	return
end

function var_0_0.addAssetItem(arg_6_0, arg_6_1, arg_6_2)
	if not arg_6_0._initialized then
		return
	end

	if not arg_6_0._assetItemDict[arg_6_1] then
		arg_6_0._assetItemTimeDict[arg_6_1] = Time.time

		local var_6_0 = RoomAssetItem.New()

		var_6_0:init(arg_6_2, arg_6_1)

		arg_6_0._assetItemDict[arg_6_1] = var_6_0

		var_6_0:Retain()
	end
end

function var_0_0._onPreloadDone(arg_7_0)
	arg_7_0:_releaseAssetItemDict(arg_7_0._preAssetItemDict)

	arg_7_0._preAssetItemDict = nil

	arg_7_0:_initPools()
	arg_7_0:dispatchEvent(var_0_0.OnPreloadFinish)
end

function var_0_0._getAssetItem(arg_8_0, arg_8_1)
	return arg_8_0._assetItemDict and arg_8_0._assetItemDict[arg_8_1]
end

function var_0_0.onSceneClose(arg_9_0)
	arg_9_0._initialized = false

	arg_9_0._preloadSequence:unregisterDoneListener(arg_9_0._onPreloadDone, arg_9_0)
	arg_9_0._preloadSequence:stop()
	arg_9_0:disposePools()
	arg_9_0:_releaseAssetItemDict(arg_9_0._preAssetItemDict)

	arg_9_0._preAssetItemDict = nil
	arg_9_0._preAssetItemDict = arg_9_0._assetItemDict
	arg_9_0._assetItemDict = nil
end

function var_0_0._releaseAssetItemDict(arg_10_0, arg_10_1)
	if arg_10_1 then
		for iter_10_0, iter_10_1 in pairs(arg_10_1) do
			iter_10_1:Release()
		end
	end
end

function var_0_0.getResource(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_2 or arg_11_1

	if GameResMgr.IsFromEditorDir then
		var_11_0 = arg_11_1
	end

	local var_11_1 = arg_11_0:_getAssetItem(var_11_0)

	if not var_11_1 then
		-- block empty
	end

	if var_11_1 then
		return var_11_1:GetResource(arg_11_1)
	end
end

function var_0_0._initPools(arg_12_0)
	if not arg_12_0._poolInitialized then
		arg_12_0._poolInitialized = true

		RoomUIPool.init({})
		RoomGOPool.init({}, {})
	end
end

function var_0_0.disposePools(arg_13_0)
	arg_13_0._poolInitialized = false

	RoomUIPool.dispose()
	RoomGOPool.dispose()
end

function var_0_0.clearPools(arg_14_0)
	if not arg_14_0._initialized then
		return
	end

	RoomGOPool.clearPool()

	local var_14_0 = Time.time - 1

	for iter_14_0, iter_14_1 in pairs(arg_14_0._assetItemDict) do
		if var_14_0 > (arg_14_0._assetItemTimeDict[iter_14_0] or 0) and iter_14_1 and RoomGOPool.existABPath(iter_14_0) == false then
			arg_14_0._assetItemDict[iter_14_0] = nil
			arg_14_0._assetItemTimeDict[iter_14_0] = 0

			iter_14_1:Release()
		end
	end
end

function var_0_0.exist(arg_15_0, arg_15_1)
	return arg_15_0:_getAssetItem(arg_15_1) and true or false
end

return var_0_0
