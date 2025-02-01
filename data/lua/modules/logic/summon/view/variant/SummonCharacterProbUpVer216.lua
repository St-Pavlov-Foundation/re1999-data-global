module("modules.logic.summon.view.variant.SummonCharacterProbUpVer216", package.seeall)

slot0 = class("SummonCharacterProbUpVer216", SummonMainCharacterProbUp)
slot0.preloadList = {
	"singlebg/summon/heroversion_1_4/role37/full/v1a4_role37_summon_bg.png",
	"singlebg/summon/heroversion_1_4/role37/v1a4_role37_summon_37.png"
}

function slot0._editableInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_bg")
	slot0._simagead1 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/node1/#simage_ad1")
	slot0._simagerole2 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/node2/#simage_role2")
	slot0._simagerole1 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/node2/#simage_role1")
	slot0._simagefrontbg = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_frontbg")
	slot0._magedec6 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/Dec/image_dec6")
	slot0._magedec10 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/Dec/image_dec10")
	slot0._magedec20 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/Dec/image_dec20")
	slot0._ip = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/tip/tip")
	slot0._charaterItemCount = 1

	uv0.super._editableInitView(slot0)
end

function slot0.refreshSingleImage(slot0)
	slot0._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
end

function slot0.unloadSingleImage(slot0)
	slot0._simagebg:UnLoadImage()
	slot0._simagead1:UnLoadImage()
	slot0._simagerole2:UnLoadImage()
	slot0._simagerole1:UnLoadImage()
	slot0._simagefrontbg:UnLoadImage()
	slot0._magedec6:UnLoadImage()
	slot0._magedec10:UnLoadImage()
	slot0._magedec20:UnLoadImage()
	slot0._ip:UnLoadImage()
	slot0._simageline:UnLoadImage()
	slot0._simagecurrency1:UnLoadImage()
	slot0._simagecurrency10:UnLoadImage()
end

return slot0
