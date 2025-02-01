module("modules.logic.summon.view.variant.SummonCharacterProbUpVer156", package.seeall)

slot0 = class("SummonCharacterProbUpVer156", SummonMainCharacterProbUp)
slot0.preloadList = {
	"singlebg/summon/heroversion_1_3/rabbit/full/v1a3_rabbit_bg.png"
}

function slot0._editableInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_bg")
	slot0._simagedog = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_dog")
	slot0._simageround = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/5role/#simage_round")
	slot0._simagerole1 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/5role/#simage_role1")
	slot0._simagerole2 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/5role/#simage_role2")
	slot0._simagecircle = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/5role/#simage_circle")
	slot0._g = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/tip/bg")
	slot0._rrow = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/tip/arrow/arrow")
	slot0._charaterItemCount = 1

	uv0.super._editableInitView(slot0)
end

function slot0.refreshSingleImage(slot0)
	slot0._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
end

function slot0.unloadSingleImage(slot0)
	slot0._simagebg:UnLoadImage()
	slot0._simagedog:UnLoadImage()
	slot0._simageround:UnLoadImage()
	slot0._simagerole1:UnLoadImage()
	slot0._simagerole2:UnLoadImage()
	slot0._simagecircle:UnLoadImage()
	slot0._g:UnLoadImage()
	slot0._rrow:UnLoadImage()
	slot0._simageline:UnLoadImage()
	slot0._simagecurrency1:UnLoadImage()
	slot0._simagecurrency10:UnLoadImage()
end

function slot0._refreshOpenTime(slot0)
	slot0._txtdeadline.text = ""

	if not SummonMainModel.instance:getCurPool() then
		return
	end

	if not SummonMainModel.instance:getPoolServerMO(slot1.id) then
		return
	end

	slot3, slot4 = slot2:onOffTimestamp()

	if slot3 < slot4 and slot4 > 0 then
		slot0._txtdeadline.text = formatLuaLang("summonmainequipprobup_deadline", SummonModel.formatRemainTime(slot4 - ServerTime.now()))
	end
end

return slot0
