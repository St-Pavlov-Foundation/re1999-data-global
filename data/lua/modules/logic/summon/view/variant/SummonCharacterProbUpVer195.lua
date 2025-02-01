module("modules.logic.summon.view.variant.SummonCharacterProbUpVer195", package.seeall)

slot0 = class("SummonCharacterProbUpVer195", SummonMainCharacterProbUp)
slot0.preloadList = {
	"singlebg/summon/heroversion_1_9/yuanlv/v1a9_yuanlv_summon_fullbg.png",
	"singlebg/summon/heroversion_1_9/yuanlv/v1a9_yuanlv_summon_role1.png",
	"singlebg/summon/heroversion_1_9/yuanlv/v1a9_yuanlv_summon_mask.png"
}

function slot0._editableInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_bg")
	slot0._simagead1 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/node1/#simage_ad1")
	slot0._simagerole3 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/node2/#simage_role3")
	slot0._simagerole2 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/node2/#simage_role2")
	slot0._simagefrontbg = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_frontbg")
	slot0._charaterItemCount = 1

	uv0.super._editableInitView(slot0)
end

function slot0.refreshSingleImage(slot0)
	slot0._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
end

function slot0.unloadSingleImage(slot0)
	slot0._simagebg:UnLoadImage()
	slot0._simagead1:UnLoadImage()
	slot0._simagerole3:UnLoadImage()
	slot0._simagerole2:UnLoadImage()
	slot0._simagefrontbg:UnLoadImage()
	slot0._simageline:UnLoadImage()
	slot0._simagecurrency1:UnLoadImage()
	slot0._simagecurrency10:UnLoadImage()
end

return slot0
