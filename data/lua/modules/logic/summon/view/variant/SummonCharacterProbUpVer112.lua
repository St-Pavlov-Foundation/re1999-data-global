module("modules.logic.summon.view.variant.SummonCharacterProbUpVer112", package.seeall)

slot0 = class("SummonCharacterProbUpVer112", SummonMainCharacterProbUp)
slot0.SIMAGE_COUNT = 3
slot4 = "heroversion_1_1/fg"
slot0.preloadList = {
	ResUrl.getSummonCoverBg("heroversion_1_1/full/bg1"),
	ResUrl.getSummonCoverBg(slot4)
}

for slot4 = 1, slot0.SIMAGE_COUNT do
	table.insert(slot0.preloadList, ResUrl.getSummonCoverBg("heroversion_1_1/img_role" .. slot4 + 3))
end

function slot0._editableInitView(slot0)
	slot0._charaterItemCount = 2

	uv0.super._editableInitView(slot0)
end

function slot0.refreshSingleImage(slot0)
	slot0._simagebg:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_1/full/bg1"))
	slot0._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))

	slot4 = ResUrl.getSummonCoverBg

	slot0._simagefrontbg:LoadImage(slot4("heroversion_1_1/fg"))

	for slot4 = 1, uv0.SIMAGE_COUNT do
		slot0["_simagead" .. slot4]:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_1/img_role" .. slot4 + 3), slot0._adLoaded, slot0)
	end
end

function slot0.unloadSingleImage(slot0)
	for slot4 = 1, uv0.SIMAGE_COUNT do
		slot0["_simagead" .. slot4]:UnLoadImage()
	end

	slot0._simagebg:UnLoadImage()
	slot0._simageline:UnLoadImage()
	slot0._simagecurrency1:UnLoadImage()
	slot0._simagecurrency10:UnLoadImage()
	slot0._simagefrontbg:UnLoadImage()
end

return slot0
