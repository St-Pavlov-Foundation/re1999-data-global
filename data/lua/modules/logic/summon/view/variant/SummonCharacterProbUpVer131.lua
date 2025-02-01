module("modules.logic.summon.view.variant.SummonCharacterProbUpVer131", package.seeall)

slot0 = class("SummonCharacterProbUpVer131", SummonMainCharacterProbUp)
slot0.SIMAGE_COUNT = 0
slot0.preloadList = {
	ResUrl.getSummonCoverBg("heroversion_1_3/rabbit/full/v1a3_rabbit_bg")
}

function slot0._editableInitView(slot0)
	slot0._simagedog = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_dog")
	slot0._simageround = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_round")
	slot0._simagerole1 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_role1")
	slot0._simagerole2 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_role2")
	slot0._simagecircle = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_circle")
	slot0._simageendec = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_endec")

	uv0.super._editableInitView(slot0)
end

function slot0.refreshSingleImage(slot0)
	slot0._simagebg:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_3/rabbit/full/v1a3_rabbit_bg"))
	slot0._simagedog:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_3/rabbit/v1a3_rabbit_dog"))
	slot0._simageround:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_3/rabbit/v1a3_rabbit_roledec"))
	slot0._simagerole1:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_3/rabbit/v1a3_rabbit_2"))
	slot0._simagerole2:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_3/rabbit/v1a3_rabbit_role1"))
	slot0._simagecircle:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_3/rabbit/v1a3_rabbit_rolecircle"))
	slot0._simageendec:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_3/rabbit/v1a3_rabbit_endec"))
	slot0._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
end

function slot0.unloadSingleImage(slot0)
	slot0._simagebg:UnLoadImage()
	slot0._simagedog:UnLoadImage()
	slot0._simageround:UnLoadImage()
	slot0._simagerole1:UnLoadImage()
	slot0._simagerole2:UnLoadImage()
	slot0._simagecircle:UnLoadImage()
	slot0._simageendec:UnLoadImage()
	slot0._simageline:UnLoadImage()
	slot0._simagecurrency1:UnLoadImage()
	slot0._simagecurrency10:UnLoadImage()
end

return slot0
