module("modules.logic.summon.view.variant.SummonCharacterProbUpVer141", package.seeall)

slot0 = class("SummonCharacterProbUpVer141", SummonMainCharacterProbUp)
slot0.preloadList = {
	"singlebg/summon/heroversion_1_4/fourroles/full/v1a4_fourroles_summon_bg.png",
	"singlebg/summon/heroversion_1_4/fourroles/v1a4_fourroles_bottombg.png"
}

function slot0._editableInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_bg")
	slot0._simagerole3 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_role3")
	slot0._simagerole1 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_role1")
	slot0._simagerole2 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_role2")
	slot0._simagerole4 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_role4")
	slot0._simagebottom = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_bottom")
	slot0._charaterItemCount = 4

	uv0.super._editableInitView(slot0)
end

function slot0.refreshSingleImage(slot0)
	slot0._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
end

function slot0.unloadSingleImage(slot0)
	slot0._simagebg:UnLoadImage()
	slot0._simagerole3:UnLoadImage()
	slot0._simagerole1:UnLoadImage()
	slot0._simagerole2:UnLoadImage()
	slot0._simagerole4:UnLoadImage()
	slot0._simagebottom:UnLoadImage()
	slot0._simagecurrency1:UnLoadImage()
	slot0._simagecurrency10:UnLoadImage()
end

return slot0
