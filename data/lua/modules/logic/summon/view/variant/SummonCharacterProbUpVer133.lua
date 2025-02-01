module("modules.logic.summon.view.variant.SummonCharacterProbUpVer133", package.seeall)

slot0 = class("SummonCharacterProbUpVer133", SummonMainCharacterProbUp)
slot0.SIMAGE_COUNT = 0
slot0.preloadList = {
	ResUrl.getSummonCoverBg("heroversion_1_3/galapona/full/v1a3_galapona_bg"),
	ResUrl.getSummonCoverBg("heroversion_1_3/galapona/v1a3_galapona_bg1"),
	ResUrl.getSummonCoverBg("heroversion_1_3/galapona/full/v1a3_galapona_dec")
}

function slot0._editableInitView(slot0)
	slot0._simagebg2 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_bg2")
	slot0._simagerole1 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_role1")
	slot0._simagerole2 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_role2")
	slot0._simagerole3 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_role3")
	slot0._simageforeground = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_foreground")
	slot0._simageline1 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_line1")
	slot0._simageline2 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_line2")
	slot0._simageline3 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_line3")
	slot0._simageline4 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_line4")
	slot0._simageline5 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_line5")
	slot0._simagestar1 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/xinggui1")
	slot0._simagegrow1 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/xinggui1/xinggui1_glow")
	slot0._simagestar2 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/xinggui2")
	slot0._simagegrow2 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/xinggui2/xinggui2_glow")

	uv0.super._editableInitView(slot0)
end

function slot0.refreshSingleImage(slot0)
	slot0._simagebg:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_3/galapona/full/v1a3_galapona_bg"))
	slot0._simagebg2:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_3/galapona/v1a3_galapona_bg1"))
	slot0._simageforeground:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_3/galapona/full/v1a3_galapona_dec"))
	slot0._simagerole1:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_3/galapona/v1a3_galapona_role2"))
	slot0._simagerole2:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_3/galapona/v1a3_galapona_role3"))
	slot0._simagerole3:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_3/galapona/v1a3_galapona_role1"))
	slot0._simageline1:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_3/galapona/v1a3_galapona_line1"))
	slot0._simageline2:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_3/galapona/v1a3_galapona_line2"))
	slot0._simageline3:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_3/galapona/v1a3_galapona_line3"))
	slot0._simageline4:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_3/galapona/v1a3_galapona_line4"))
	slot0._simageline5:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_3/galapona/v1a3_galapona_line5"))
	slot0._simagestar1:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_3/galapona/v1a3_galapona_xinggui1"))
	slot0._simagegrow1:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_3/galapona/v1a3_galapona_xinggui1"))
	slot0._simagestar2:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_3/galapona/v1a3_galapona_xinggui2"))
	slot0._simagegrow2:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_3/galapona/v1a3_galapona_xinggui2"))
	slot0._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
end

function slot0.unloadSingleImage(slot0)
	slot0._simagebg:UnLoadImage()
	slot0._simageforeground:UnLoadImage()
	slot0._simagerole1:UnLoadImage()
	slot0._simagerole2:UnLoadImage()
	slot0._simagerole3:UnLoadImage()
	slot0._simageline1:UnLoadImage()
	slot0._simageline2:UnLoadImage()
	slot0._simageline3:UnLoadImage()
	slot0._simageline4:UnLoadImage()
	slot0._simageline5:UnLoadImage()
	slot0._simageline:UnLoadImage()
	slot0._simagestar1:UnLoadImage()
	slot0._simagegrow1:UnLoadImage()
	slot0._simagestar2:UnLoadImage()
	slot0._simagegrow2:UnLoadImage()
	slot0._simagecurrency1:UnLoadImage()
	slot0._simagecurrency10:UnLoadImage()
end

return slot0
