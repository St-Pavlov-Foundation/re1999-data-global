module("modules.logic.defines.SDKMediaEventEnum", package.seeall)

slot0 = _M
slot0.GoodsIdMediaEvent = {
	[6100012] = SDKDataTrackMgr.MediaEvent.purchase_level5pack,
	[6100002] = SDKDataTrackMgr.MediaEvent.purchase_level10pack
}
slot0.HeroGetEvent = {
	[3023] = SDKDataTrackMgr.MediaEvent.game_summon_01
}
slot0.PurchaseIdMediaEvent = {
	[811314.0] = "purchase_furniture",
	[811324.0] = "purchase_v1.1_01_15.99pack",
	[811316.0] = "purchase_v1.1_49.99pack",
	[811319.0] = "purchase_v1.1_02_4.99pack",
	[811304.0] = "purchase_ResonatePack",
	[811325.0] = "purchase_v1.1_02_15.99pack",
	[811317.0] = "purchase_v1.1_29.99pack",
	[811313.0] = "purchase_newplayer90off",
	[811321.0] = "purchase_v1.1_02_1.99pack",
	[811322.0] = "purchase_v1.1_01_7.99pack",
	[710003.0] = "purchase_bp_middle",
	[811327.0] = "purchase_v1.1_0.99pack",
	[811318.0] = "purchase_v1.1_01_4.99pack",
	[811323.0] = "purchase_v1.1_02_7.99pack",
	[811315.0] = "purchase_Gacha10Pack",
	[811320.0] = "purchase_v1.1_01_1.99pack",
	[610001] = SDKDataTrackMgr.MediaEvent.purchase_mothlyCard,
	[710001] = SDKDataTrackMgr.MediaEvent.purchase_bp_small,
	[710002] = SDKDataTrackMgr.MediaEvent.purchase_bp_large,
	[610002] = SDKDataTrackMgr.MediaEvent.purchase_firstChargePack,
	[811461] = SDKDataTrackMgr.MediaEvent.purchase_firstChargePack,
	[610003] = SDKDataTrackMgr.MediaEvent.purchase_firstResourcePack,
	[610004] = SDKDataTrackMgr.MediaEvent.purchase_firstGachaPack,
	[610006] = SDKDataTrackMgr.MediaEvent.purchase_monthlyGachaPack
}
slot0.TotalChargeAmount = {
	[9999.0] = "purchase_re100",
	[99.0] = "purchase_re1",
	[2999.0] = "purchase_re30"
}
slot0.JP_TotalChargeAmount = {
	[15000.0] = "purchase_re150",
	[450000.0] = "purchase_re4500",
	[1500000.0] = "purchase_re15000"
}
slot0.TrackEpisodePassMediaEvent = {
	[10101] = SDKDataTrackMgr.MediaEvent.plot_progress_1_1,
	[10103] = SDKDataTrackMgr.MediaEvent.plot_progress_1_4,
	[10314] = SDKDataTrackMgr.MediaEvent.plot_progress_3_14,
	[10315] = SDKDataTrackMgr.MediaEvent.plot_progress_3_15,
	[10115] = SDKDataTrackMgr.MediaEvent.chapter_progress_1,
	[10215] = SDKDataTrackMgr.MediaEvent.chapter_progress_2,
	[10316] = SDKDataTrackMgr.MediaEvent.chapter_progress_3
}
slot0.PlayerLevelUpMediaEvent = {
	[5] = SDKDataTrackMgr.MediaEvent.roleLevel_5_achieve,
	[10] = SDKDataTrackMgr.MediaEvent.roleLevel_10_achieve,
	[15] = SDKDataTrackMgr.MediaEvent.roleLevel_15_achieve,
	[20] = SDKDataTrackMgr.MediaEvent.roleLevel_20_achieve
}
slot0.FirstStoryId = 100101

return slot0
