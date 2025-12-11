module("modules.logic.gm.controller.GMEvent", package.seeall)

local var_0_0 = _M
local var_0_1 = 1

local function var_0_2(arg_1_0)
	assert(var_0_0[arg_1_0] == nil, "[GMEvent] error redefined GMEvent." .. arg_1_0)

	var_0_0[arg_1_0] = var_0_1
	var_0_1 = var_0_1 + 1
end

var_0_2("RecommendStore_ShowAllBannerUpdate")
var_0_2("RecommendStore_ShowAllTabIdUpdate")
var_0_2("RecommendStore_StopBannerLoopAnimUpdate")
var_0_2("GMLog_Trigger")
var_0_2("GMLog_UpdateCount")
var_0_2("GMLogView_Select")
var_0_2("SummonMainView_ShowAllTabIdUpdate")
var_0_2("DungeonMapView_ShowAllTabIdUpdate")
var_0_2("CharacterDataVoiceView_ShowAllTabIdUpdate")
var_0_2("MainThumbnailRecommendView_ShowAllBannerUpdate")
var_0_2("MainThumbnailRecommendView_ShowAllTabIdUpdate")
var_0_2("MainThumbnailRecommendView_StopBannerLoopAnimUpdate")
var_0_2("VersionActivity_DungeonMapView_ShowAllTabIdUpdate")
var_0_2("PackageStoreView_ShowAllTabIdUpdate")
var_0_2("PackageStoreView_ShowAllItemIdUpdate")
var_0_2("ClothesStoreView_ShowAllTabIdUpdate")
var_0_2("VersionActivity_EnterView_ShowAllTabIdUpdate")
var_0_2("CharacterBackpackView_ShowAllTabIdUpdate")
var_0_2("CharacterBackpackView_EnableCheckFaceOnSelect")
var_0_2("CharacterBackpackView_EnableCheckMouthOnSelect")
var_0_2("CharacterBackpackView_EnableCheckContentOnSelect")
var_0_2("CharacterBackpackView_EnableCheckMotionOnSelect")
var_0_2("CharacterView_ShowAllTabIdUpdate")
var_0_2("CharacterView_OnClickCheckFace")
var_0_2("CharacterView_OnClickCheckMouth")
var_0_2("CharacterView_OnClickCheckContent")
var_0_2("CharacterView_OnClickCheckMotion")
var_0_2("StoreView_ShowAllTabIdUpdate")
var_0_2("NormalStoreView_ShowAllTabIdUpdate")
var_0_2("NormalStoreView_ShowAllGoodsIdUpdate")
var_0_2("SummonPoolHistoryView_ShowAllTabIdUpdate")
var_0_2("SummonHeroDetailView_ShowAllTabIdUpdate")
var_0_2("MailView_ShowAllTabIdUpdate")
var_0_2("ActivityBeginnerView_ShowAllTabIdUpdate")
var_0_2("ActivityWelfareView_ShowAllTabIdUpdate")
var_0_2("V3a1_GaoSiNiao_LevelView_ShowAllTabIdUpdate")
var_0_2("V3a1_GaoSiNiao_LevelView_EnableEditModeOnSelect")
var_0_2("V3a1_GaoSiNiao_GameView_ShowAllTabIdUpdate")
var_0_2("V3a1_GaoSiNiao_GameView_OnClickSwitchMode")

return var_0_0
