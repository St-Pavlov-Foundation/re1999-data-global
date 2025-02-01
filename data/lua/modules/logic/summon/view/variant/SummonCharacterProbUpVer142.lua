module("modules.logic.summon.view.variant.SummonCharacterProbUpVer142", package.seeall)

slot0 = class("SummonCharacterProbUpVer142", SummonMainCharacterProbUp)
slot0.SIMAGE_COUNT = 0
slot0.preloadList = {
	ResUrl.getSummonCoverBg("heroversion_1_4/role37/full/v1a4_role37_summon_bg")
}

function slot0._editableInitView(slot0)
	slot0._simagemiddle = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_middle")
	slot0._simagerole1 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_role1")
	slot0._simagerole2 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_role2")
	slot0._simagerole3 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_role3")
	slot0._charaterItemCount = 1

	uv0.super._editableInitView(slot0)
end

function slot0.refreshSingleImage(slot0)
	slot0._simagebg:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_4/role37/full/v1a4_role37_summon_bg"))
	slot0._simagerole1:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_4/role37/v1a4_role37_summon_37"))
	slot0._simagerole2:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_4/role37/v1a4_role37_summon_role2"))
	slot0._simagerole3:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_4/role37/v1a4_role37_summon_role1"))
	slot0._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
end

function slot0.unloadSingleImage(slot0)
	slot0._simagebg:UnLoadImage()
	slot0._simagerole1:UnLoadImage()
	slot0._simagerole2:UnLoadImage()
	slot0._simagerole3:UnLoadImage()
	slot0._simageline:UnLoadImage()
	slot0._simagecurrency1:UnLoadImage()
	slot0._simagecurrency10:UnLoadImage()
end

return slot0
