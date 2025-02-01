module("modules.logic.summon.view.variant.SummonCharacterProbUpVer194", package.seeall)

slot0 = class("SummonCharacterProbUpVer194", SummonMainCharacterProbUp)
slot0.preloadList = {
	"singlebg/summon/heroversion_1_9/yaxian/v1a9_yaxian_summon_fullbg.png",
	"singlebg/summon/heroversion_1_9/yaxian/v1a9_yaxian_summon_role1.png",
	"singlebg/summon/heroversion_1_9/yaxian/v1a9_yaxian_summon_fontbg.png"
}

function slot0._editableInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_bg")
	slot0._simagerole1 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/node2/#simage_role1")
	slot0._simagerole2 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/node2/#simage_role2")
	slot0._simagead1 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/node1/#simage_ad1")
	slot0._simagefrontbg = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_frontbg")
	slot0._simageline = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/image_deadline/#txt_deadline/#simage_line")
	slot0._txtdeadline = gohelper.findChildText(slot0.viewGO, "#go_ui/current/image_deadline/#txt_deadline")
	slot0._charaterItemCount = 1

	uv0.super._editableInitView(slot0)
end

function slot0.refreshSingleImage(slot0)
	slot0._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
end

function slot0.unloadSingleImage(slot0)
	slot0._simagebg:UnLoadImage()
	slot0._simagerole1:UnLoadImage()
	slot0._simagerole2:UnLoadImage()
	slot0._simagead1:UnLoadImage()
	slot0._simagefrontbg:UnLoadImage()
	slot0._simageline:UnLoadImage()
	slot0._simageline:UnLoadImage()
	slot0._simagecurrency1:UnLoadImage()
	slot0._simagecurrency10:UnLoadImage()
end

return slot0
