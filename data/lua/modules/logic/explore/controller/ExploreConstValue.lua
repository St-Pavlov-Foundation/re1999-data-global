module("modules.logic.explore.controller.ExploreConstValue", package.seeall)

local var_0_0 = _M

var_0_0.TILE_SIZE = 1
var_0_0.CameraTraceTime = 1
var_0_0.Toast = {
	ExploreCantUseItem = 90101,
	ExploreChapterLock = 60301,
	ExploreCantPlacePot = 90103,
	CantUseItem = 1703,
	WayImpassable = 1701,
	ExploreCantTrigger = 90102,
	NoItem = 25,
	ExploreLock = 40402,
	UseWithFixPrism = 1702,
	CantTrigger = 40401
}
var_0_0.MessageBoxId = {
	MapReset = 40701
}
var_0_0.TrapAudioMaxDis = 5
var_0_0.RTPCKey = {
	TrapDis = "ui_qiutu_trap_loop_attenuation"
}
var_0_0.CHECK_INTERVAL = {
	MapShadowObjDestory = 4,
	MapSceneObjDestory = 4,
	UnitObjDestory = 4
}
var_0_0.MapSceneObjEffectType = {
	OnlyEffect = 1,
	NoEffect = 0,
	Mix = 2
}
var_0_0.MapSceneObjDestoryInterval = {
	[var_0_0.MapSceneObjEffectType.NoEffect] = var_0_0.CHECK_INTERVAL.MapSceneObjDestory,
	[var_0_0.MapSceneObjEffectType.OnlyEffect] = 999,
	[var_0_0.MapSceneObjEffectType.Mix] = var_0_0.CHECK_INTERVAL.MapSceneObjDestory
}
var_0_0.UseCSharpTree = true
var_0_0.ClickEffect = "v1a4_dianjidimian"
var_0_0.PlaceEffect = "v1a4_fangzhiyuanjian"
var_0_0.MapLightEffect = "zj_03_jh_fglj_guangshu"
var_0_0.MapPrefab = "explore/prefabs/scene.prefab"
var_0_0.MapConfigPath = "config/explore/lua_explore_map_%s.lua"
var_0_0.EntryCameraCtrlPath = "explore/camera_anim/msts_anim_entry_01.controller"
var_0_0.MapNavMeshPath = "explore/navigate/%s.mesh"
var_0_0.MapSceneObjAlwaysShowEffectType = {
	[var_0_0.MapSceneObjEffectType.OnlyEffect] = true
}

return var_0_0
