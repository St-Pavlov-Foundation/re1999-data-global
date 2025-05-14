module("modules.logic.summon.view.variant.SummonCharacterProbUpVer226", package.seeall)

local var_0_0 = class("SummonCharacterProbUpVer226", SummonMainCharacterProbUp)

var_0_0.preloadList = {
	"singlebg/summon/heroversion_2_0/galapona/full/v2a0_galapona_bg.png",
	"singlebg/summon/heroversion_2_0/galapona/v2a0_galapona_summon_dec2.png",
	"singlebg/summon/heroversion_2_0/galapona/v2a0_galapona_summon_dec2.png",
	"singlebg/summon/heroversion_2_0/galapona/v2a0_galapona_summon_dec1.png",
	"singlebg/summon/heroversion_2_0/galapona/v2a0_galapona_summon_dec1.png",
	"singlebg/summon/heroversion_2_0/galapona/v2a0_galapona_role1.png",
	"singlebg/summon/heroversion_2_0/galapona/full/v2a0_galapona_dec.png",
	"singlebg/summon/heroversion_2_0/galapona/v2a0_galapona_line1.png",
	"singlebg/summon/heroversion_2_0/galapona/v2a0_galapona_line3.png"
}

function var_0_0._editableInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_bg")
	arg_1_0._simagedec1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_dec1")
	arg_1_0._simagedec1glow = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_dec1/#simage_dec1_glow")
	arg_1_0._simagedec2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_dec2")
	arg_1_0._simagedec2glow = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_dec2/#simage_dec2_glow")
	arg_1_0._simagead1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/node1/#simage_ad1")
	arg_1_0._simagerole2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/node2/#simage_role2")
	arg_1_0._simagerole1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/node2/#simage_role1")
	arg_1_0._simageforeground = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_foreground")
	arg_1_0._simageline1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_line1")
	arg_1_0._simageline2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_line2")
	arg_1_0._simageline3 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_line3")
	arg_1_0._simageline4 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_line4")
	arg_1_0._simageline5 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_line5")
	arg_1_0._ip = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/tip/tip")
	arg_1_0._charaterItemCount = 1

	var_0_0.super._editableInitView(arg_1_0)
end

function var_0_0.refreshSingleImage(arg_2_0)
	arg_2_0._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
end

function var_0_0.unloadSingleImage(arg_3_0)
	arg_3_0._simagebg:UnLoadImage()
	arg_3_0._simagedec1:UnLoadImage()
	arg_3_0._simagedec1glow:UnLoadImage()
	arg_3_0._simagedec2:UnLoadImage()
	arg_3_0._simagedec2glow:UnLoadImage()
	arg_3_0._simagead1:UnLoadImage()
	arg_3_0._simagerole2:UnLoadImage()
	arg_3_0._simagerole1:UnLoadImage()
	arg_3_0._simageforeground:UnLoadImage()
	arg_3_0._simageline1:UnLoadImage()
	arg_3_0._simageline2:UnLoadImage()
	arg_3_0._simageline3:UnLoadImage()
	arg_3_0._simageline4:UnLoadImage()
	arg_3_0._simageline5:UnLoadImage()
	arg_3_0._ip:UnLoadImage()
	arg_3_0._simageline:UnLoadImage()
	arg_3_0._simagecurrency1:UnLoadImage()
	arg_3_0._simagecurrency10:UnLoadImage()
end

return var_0_0
