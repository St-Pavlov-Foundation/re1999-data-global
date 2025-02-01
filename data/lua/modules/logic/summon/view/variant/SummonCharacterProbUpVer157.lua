module("modules.logic.summon.view.variant.SummonCharacterProbUpVer157", package.seeall)

slot0 = class("SummonCharacterProbUpVer157", SummonMainCharacterProbUp)
slot0.preloadList = {
	"singlebg/summon/heroversion_1_5/hopeofthelake/full/bg.png",
	"singlebg/summon/heroversion_1_5/hopeofthelake/v1a5_hopeofthelake_and.png",
	"singlebg/summon/heroversion_1_5/hopeofthelake/v1a5_hopeofthelake_curve.png",
	"singlebg/summon/heroversion_1_5/hopeofthelake/v1a5_hopeofthelake_paopao.png"
}

function slot0._editableInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_bg")
	slot0._simagemiddle = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_middle")
	slot0._simagebottom = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_bottom")
	slot0._simagerole1 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_role1")
	slot0._simagerole2 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_role2")
	slot0._imagemiddledec = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/simage_middledec")
	slot0._charaterItemCount = 2

	uv0.super._editableInitView(slot0)
end

function slot0.refreshSingleImage(slot0)
	slot0._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
end

function slot0.unloadSingleImage(slot0)
	slot0._simagebg:UnLoadImage()
	slot0._simagemiddle:UnLoadImage()
	slot0._simagebottom:UnLoadImage()
	slot0._simagerole1:UnLoadImage()
	slot0._simagerole2:UnLoadImage()
	slot0._imagemiddledec:UnLoadImage()
	slot0._simageline:UnLoadImage()
	slot0._simagecurrency1:UnLoadImage()
	slot0._simagecurrency10:UnLoadImage()
end

return slot0
