local var_0_0 = {}
local var_0_1 = tabletool.copy

var_0_0.GM_RecommendStoreView = {
	destroy = 0,
	container = "GM_RecommendStoreViewContainer",
	mainRes = "ui/viewres/gm/gm_recommendstoreview.prefab",
	layer = "TOP",
	viewType = ViewType.Modal
}
var_0_0.GM_SummonMainView = {
	destroy = 0,
	container = "GM_SummonMainViewContainer",
	mainRes = "ui/viewres/gm/gm_summonmainview.prefab",
	layer = "TOP",
	viewType = ViewType.Modal
}
var_0_0.GM_DungeonMapView = {
	destroy = 0,
	container = "GM_DungeonMapViewContainer",
	mainRes = "ui/viewres/gm/gm_dungeonmapview.prefab",
	layer = "TOP",
	viewType = ViewType.Modal
}
var_0_0.GM_CharacterDataVoiceView = {
	destroy = 0,
	container = "GM_CharacterDataVoiceViewContainer",
	mainRes = "ui/viewres/gm/gm_characterdatavoiceview.prefab",
	layer = "TOP",
	viewType = ViewType.Modal
}
var_0_0.GM_MainThumbnailRecommendView = {
	destroy = 0,
	container = "GM_MainThumbnailRecommendViewContainer",
	mainRes = "ui/viewres/gm/gm_mainthumbnailrecommendview.prefab",
	layer = "TOP",
	viewType = ViewType.Modal
}
var_0_0.GM_VersionActivity_DungeonMapView = {
	destroy = 0,
	container = "GM_VersionActivity_DungeonMapViewContainer",
	mainRes = "ui/viewres/gm/gm_versionactivity_dungeonmapview.prefab",
	layer = "TOP",
	viewType = ViewType.Modal
}
var_0_0.GM_PackageStoreView = {
	destroy = 0,
	container = "GM_PackageStoreViewContainer",
	mainRes = "ui/viewres/gm/gm_packagestoreview.prefab",
	layer = "TOP",
	viewType = ViewType.Modal
}
var_0_0.GM_ClothesStoreView = {
	destroy = 0,
	container = "GM_ClothesStoreViewContainer",
	mainRes = "ui/viewres/gm/gm_clothesstoreview.prefab",
	layer = "TOP",
	viewType = ViewType.Modal
}
var_0_0.GM_VersionActivity_EnterView = {
	destroy = 0,
	container = "GM_VersionActivity_EnterViewContainer",
	mainRes = "ui/viewres/gm/gm_versionactivity_enteriew.prefab",
	layer = "TOP",
	viewType = ViewType.Modal
}
var_0_0.GM_CharacterBackpackView = {
	destroy = 0,
	container = "GM_CharacterBackpackViewContainer",
	mainRes = "ui/viewres/gm/gm_characterbackpackview.prefab",
	layer = "TOP",
	viewType = ViewType.Modal
}
var_0_0.GM_CharacterView = {
	destroy = 0,
	container = "GM_CharacterViewContainer",
	mainRes = "ui/viewres/gm/gm_characterview.prefab",
	layer = "TOP",
	viewType = ViewType.Modal
}
var_0_0.GM_NormalStoreView = {
	destroy = 0,
	container = "GM_NormalStoreViewContainer",
	mainRes = "ui/viewres/gm/gm_normalstoreview.prefab",
	layer = "TOP",
	viewType = ViewType.Modal
}
var_0_0.GM_StoreView = {
	destroy = 0,
	container = "GM_StoreViewContainer",
	mainRes = "ui/viewres/gm/gm_storeview.prefab",
	layer = "TOP",
	viewType = ViewType.Modal
}

local var_0_2 = {
	destroy = 0,
	container = "GM_TaskListCommonItemContainer",
	mainRes = "ui/viewres/gm/gm_tasklistcommonitem.prefab",
	layer = "TOP",
	viewType = ViewType.Modal
}

var_0_0.GM_TaskDailyView = var_0_1(var_0_2)
var_0_0.GM_TaskDailyView.container = "GM_TaskDailyViewContainer"
var_0_0.GM_TaskWeeklyView = var_0_1(var_0_2)
var_0_0.GM_TaskWeeklyView.container = "GM_TaskWeeklyViewContainer"
var_0_0.GM_SummonPoolHistoryView = {
	destroy = 0,
	container = "GM_SummonPoolHistoryViewContainer",
	mainRes = "ui/viewres/gm/gm_summonpoolhistoryview.prefab",
	layer = "TOP",
	viewType = ViewType.Modal
}
var_0_0.GM_SummonHeroDetailView = {
	destroy = 0,
	container = "GM_SummonHeroDetailViewContainer",
	mainRes = "ui/viewres/gm/gm_summonherodetailview.prefab",
	layer = "TOP",
	viewType = ViewType.Modal
}
var_0_0.GM_MailView = {
	destroy = 0,
	container = "GM_MailViewContainer",
	mainRes = "ui/viewres/gm/gm_mailview.prefab",
	layer = "TOP",
	viewType = ViewType.Modal
}
var_0_0.GM_ActivityBeginnerView = {
	destroy = 0,
	container = "GM_ActivityBeginnerViewContainer",
	mainRes = "ui/viewres/gm/gm_activitybeginnerview.prefab",
	layer = "TOP",
	viewType = ViewType.Modal
}
var_0_0.GM_ActivityWelfareView = {
	destroy = 0,
	container = "GM_ActivityWelfareViewContainer",
	mainRes = "ui/viewres/gm/gm_activitywelfareview.prefab",
	layer = "TOP",
	viewType = ViewType.Modal
}

return var_0_0
