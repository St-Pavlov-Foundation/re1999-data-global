module("modules.logic.explore.controller.ExploreConstValue", package.seeall)

slot0 = _M
slot0.TILE_SIZE = 1
slot0.CameraTraceTime = 1
slot0.Toast = {
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
slot0.MessageBoxId = {
	MapReset = 40701
}
slot0.TrapAudioMaxDis = 5
slot0.RTPCKey = {
	TrapDis = "ui_qiutu_trap_loop_attenuation"
}
slot0.CHECK_INTERVAL = {
	MapShadowObjDestory = 4,
	MapSceneObjDestory = 4,
	UnitObjDestory = 4
}
slot0.MapSceneObjEffectType = {
	OnlyEffect = 1,
	NoEffect = 0,
	Mix = 2
}
slot0.MapSceneObjDestoryInterval = {
	[slot0.MapSceneObjEffectType.NoEffect] = slot0.CHECK_INTERVAL.MapSceneObjDestory,
	[slot0.MapSceneObjEffectType.OnlyEffect] = 999,
	[slot0.MapSceneObjEffectType.Mix] = slot0.CHECK_INTERVAL.MapSceneObjDestory
}
slot0.UseCSharpTree = true
slot0.ClickEffect = "v1a4_dianjidimian"
slot0.PlaceEffect = "v1a4_fangzhiyuanjian"
slot0.MapLightEffect = "zj_03_jh_fglj_guangshu"
slot0.MapPrefab = "explore/prefabs/scene.prefab"
slot0.MapConfigPath = "config/explore/lua_explore_map_%s.lua"
slot0.EntryCameraCtrlPath = "explore/camera_anim/msts_anim_entry_01.controller"
slot0.MapNavMeshPath = "explore/navigate/%s.mesh"
slot0.MapSceneObjAlwaysShowEffectType = {
	[slot0.MapSceneObjEffectType.OnlyEffect] = true
}

return slot0
