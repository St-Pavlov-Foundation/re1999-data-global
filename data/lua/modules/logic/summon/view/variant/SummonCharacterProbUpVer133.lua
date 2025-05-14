module("modules.logic.summon.view.variant.SummonCharacterProbUpVer133", package.seeall)

local var_0_0 = class("SummonCharacterProbUpVer133", SummonMainCharacterProbUp)

var_0_0.SIMAGE_COUNT = 0
var_0_0.preloadList = {
	ResUrl.getSummonCoverBg("heroversion_1_3/galapona/full/v1a3_galapona_bg"),
	ResUrl.getSummonCoverBg("heroversion_1_3/galapona/v1a3_galapona_bg1"),
	ResUrl.getSummonCoverBg("heroversion_1_3/galapona/full/v1a3_galapona_dec")
}

function var_0_0._editableInitView(arg_1_0)
	arg_1_0._simagebg2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_bg2")
	arg_1_0._simagerole1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_role1")
	arg_1_0._simagerole2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_role2")
	arg_1_0._simagerole3 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_role3")
	arg_1_0._simageforeground = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_foreground")
	arg_1_0._simageline1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_line1")
	arg_1_0._simageline2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_line2")
	arg_1_0._simageline3 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_line3")
	arg_1_0._simageline4 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_line4")
	arg_1_0._simageline5 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_line5")
	arg_1_0._simagestar1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/xinggui1")
	arg_1_0._simagegrow1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/xinggui1/xinggui1_glow")
	arg_1_0._simagestar2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/xinggui2")
	arg_1_0._simagegrow2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/xinggui2/xinggui2_glow")

	var_0_0.super._editableInitView(arg_1_0)
end

function var_0_0.refreshSingleImage(arg_2_0)
	arg_2_0._simagebg:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_3/galapona/full/v1a3_galapona_bg"))
	arg_2_0._simagebg2:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_3/galapona/v1a3_galapona_bg1"))
	arg_2_0._simageforeground:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_3/galapona/full/v1a3_galapona_dec"))
	arg_2_0._simagerole1:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_3/galapona/v1a3_galapona_role2"))
	arg_2_0._simagerole2:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_3/galapona/v1a3_galapona_role3"))
	arg_2_0._simagerole3:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_3/galapona/v1a3_galapona_role1"))
	arg_2_0._simageline1:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_3/galapona/v1a3_galapona_line1"))
	arg_2_0._simageline2:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_3/galapona/v1a3_galapona_line2"))
	arg_2_0._simageline3:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_3/galapona/v1a3_galapona_line3"))
	arg_2_0._simageline4:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_3/galapona/v1a3_galapona_line4"))
	arg_2_0._simageline5:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_3/galapona/v1a3_galapona_line5"))
	arg_2_0._simagestar1:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_3/galapona/v1a3_galapona_xinggui1"))
	arg_2_0._simagegrow1:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_3/galapona/v1a3_galapona_xinggui1"))
	arg_2_0._simagestar2:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_3/galapona/v1a3_galapona_xinggui2"))
	arg_2_0._simagegrow2:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_3/galapona/v1a3_galapona_xinggui2"))
	arg_2_0._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
end

function var_0_0.unloadSingleImage(arg_3_0)
	arg_3_0._simagebg:UnLoadImage()
	arg_3_0._simageforeground:UnLoadImage()
	arg_3_0._simagerole1:UnLoadImage()
	arg_3_0._simagerole2:UnLoadImage()
	arg_3_0._simagerole3:UnLoadImage()
	arg_3_0._simageline1:UnLoadImage()
	arg_3_0._simageline2:UnLoadImage()
	arg_3_0._simageline3:UnLoadImage()
	arg_3_0._simageline4:UnLoadImage()
	arg_3_0._simageline5:UnLoadImage()
	arg_3_0._simageline:UnLoadImage()
	arg_3_0._simagestar1:UnLoadImage()
	arg_3_0._simagegrow1:UnLoadImage()
	arg_3_0._simagestar2:UnLoadImage()
	arg_3_0._simagegrow2:UnLoadImage()
	arg_3_0._simagecurrency1:UnLoadImage()
	arg_3_0._simagecurrency10:UnLoadImage()
end

return var_0_0
