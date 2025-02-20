module("modules.logic.summon.view.variant.SummonCharacterProbUpVer226", package.seeall)

slot0 = class("SummonCharacterProbUpVer226", SummonMainCharacterProbUp)
slot0.preloadList = {
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

function slot0._editableInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_bg")
	slot0._simagedec1 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_dec1")
	slot0._simagedec1glow = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_dec1/#simage_dec1_glow")
	slot0._simagedec2 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_dec2")
	slot0._simagedec2glow = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_dec2/#simage_dec2_glow")
	slot0._simagead1 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/node1/#simage_ad1")
	slot0._simagerole2 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/node2/#simage_role2")
	slot0._simagerole1 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/node2/#simage_role1")
	slot0._simageforeground = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_foreground")
	slot0._simageline1 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_line1")
	slot0._simageline2 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_line2")
	slot0._simageline3 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_line3")
	slot0._simageline4 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_line4")
	slot0._simageline5 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_line5")
	slot0._ip = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/tip/tip")
	slot0._charaterItemCount = 1

	uv0.super._editableInitView(slot0)
end

function slot0.refreshSingleImage(slot0)
	slot0._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
end

function slot0.unloadSingleImage(slot0)
	slot0._simagebg:UnLoadImage()
	slot0._simagedec1:UnLoadImage()
	slot0._simagedec1glow:UnLoadImage()
	slot0._simagedec2:UnLoadImage()
	slot0._simagedec2glow:UnLoadImage()
	slot0._simagead1:UnLoadImage()
	slot0._simagerole2:UnLoadImage()
	slot0._simagerole1:UnLoadImage()
	slot0._simageforeground:UnLoadImage()
	slot0._simageline1:UnLoadImage()
	slot0._simageline2:UnLoadImage()
	slot0._simageline3:UnLoadImage()
	slot0._simageline4:UnLoadImage()
	slot0._simageline5:UnLoadImage()
	slot0._ip:UnLoadImage()
	slot0._simageline:UnLoadImage()
	slot0._simagecurrency1:UnLoadImage()
	slot0._simagecurrency10:UnLoadImage()
end

return slot0
