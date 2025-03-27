module("modules.logic.gm.controller.GMEvent", package.seeall)

slot1 = 1

function slot2(slot0)
	assert(uv0[slot0] == nil, "[GMEvent] error redefined GMEvent." .. slot0)

	uv0[slot0] = uv1
	uv1 = uv1 + 1
end

slot2("RecommendStore_ShowAllBannerUpdate")
slot2("RecommendStore_ShowAllTabIdUpdate")
slot2("RecommendStore_StopBannerLoopAnimUpdate")
slot2("GMLog_Trigger")
slot2("GMLog_UpdateCount")
slot2("GMLogView_Select")
slot2("SummonMainView_ShowAllTabIdUpdate")
slot2("DungeonMapView_ShowAllTabIdUpdate")
slot2("CharacterDataVoiceView_ShowAllTabIdUpdate")
slot2("MainThumbnailRecommendView_ShowAllBannerUpdate")
slot2("MainThumbnailRecommendView_ShowAllTabIdUpdate")
slot2("MainThumbnailRecommendView_StopBannerLoopAnimUpdate")
slot2("VersionActivity_DungeonMapView_ShowAllTabIdUpdate")
slot2("PackageStoreView_ShowAllTabIdUpdate")
slot2("PackageStoreView_ShowAllItemIdUpdate")
slot2("ClothesStoreView_ShowAllTabIdUpdate")
slot2("VersionActivity_EnterView_ShowAllTabIdUpdate")
slot2("CharacterBackpackView_ShowAllTabIdUpdate")
slot2("CharacterBackpackView_EnableCheckFaceOnSelect")
slot2("CharacterBackpackView_EnableCheckMouthOnSelect")
slot2("CharacterBackpackView_EnableCheckContentOnSelect")
slot2("CharacterBackpackView_EnableCheckMotionOnSelect")
slot2("CharacterView_ShowAllTabIdUpdate")
slot2("CharacterView_OnClickCheckFace")
slot2("CharacterView_OnClickCheckMouth")
slot2("CharacterView_OnClickCheckContent")
slot2("CharacterView_OnClickCheckMotion")
slot2("StoreView_ShowAllTabIdUpdate")
slot2("NormalStoreView_ShowAllTabIdUpdate")
slot2("NormalStoreView_ShowAllGoodsIdUpdate")
slot2("SummonPoolHistoryView_ShowAllTabIdUpdate")
slot2("SummonHeroDetailView_ShowAllTabIdUpdate")
slot2("MailView_ShowAllTabIdUpdate")
slot2("ActivityBeginnerView_ShowAllTabIdUpdate")
slot2("ActivityWelfareView_ShowAllTabIdUpdate")

return _M
