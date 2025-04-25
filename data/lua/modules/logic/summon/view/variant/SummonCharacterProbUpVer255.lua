module("modules.logic.summon.view.variant.SummonCharacterProbUpVer255", package.seeall)

slot0 = class("SummonCharacterProbUpVer255", SummonMainCharacterProbUp)
slot0.preloadList = {
	"singlebg/summon/heroversion_2_1/tuesday/v2a1_tuesday_fullbg.png",
	"singlebg/summon/heroversion_2_1/tuesday/v2a1_tuesday_frontbg1.png"
}

function slot0._editableInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_bg")
	slot0._simagerole1 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/node1/#simage_role1")
	slot0._simagefrontbg1 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_frontbg1")
	slot0._simagerole3 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/node2/#simage_role3")
	slot0._simagerole2 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/node2/#simage_role2")
	slot0._charaterItemCount = 1

	uv0.super._editableInitView(slot0)
end

function slot0.refreshSingleImage(slot0)
	slot0._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
end

function slot0.unloadSingleImage(slot0)
	slot0._simagebg:UnLoadImage()
	slot0._simagerole1:UnLoadImage()
	slot0._simagefrontbg1:UnLoadImage()
	slot0._simagerole3:UnLoadImage()
	slot0._simagerole2:UnLoadImage()
	slot0._simageline:UnLoadImage()
	slot0._simagecurrency1:UnLoadImage()
	slot0._simagecurrency10:UnLoadImage()
end

return slot0
