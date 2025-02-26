module("modules.logic.summon.view.variant.SummonCharacterProbUpVer111", package.seeall)

slot0 = class("SummonCharacterProbUpVer111", SummonMainCharacterProbUp)
slot0.SIMAGE_COUNT = 3
slot0.preloadList = {
	ResUrl.getSummonCoverBg("heroversion_1_1/full/bg"),
	ResUrl.getSummonCoverBg("heroversion_1_1/bg_zsz")
}

for slot4 = 1, slot0.SIMAGE_COUNT do
	table.insert(slot0.preloadList, ResUrl.getSummonCoverBg("heroversion_1_1/img_role" .. slot4))
end

function slot0.refreshSingleImage(slot0)
	slot0._simagebg:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_1/full/bg"))
	slot0._simagefrontbg:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_1/bg_zsz"))

	slot4 = "title_img_deco"

	slot0._simageline:LoadImage(ResUrl.getSummonHeroIcon(slot4))

	for slot4 = 1, uv0.SIMAGE_COUNT do
		slot0["_simagead" .. slot4]:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_1/img_role" .. slot4), slot0._adLoaded, slot0)
	end
end

function slot0.unloadSingleImage(slot0)
	for slot4 = 1, uv0.SIMAGE_COUNT do
		slot0["_simagead" .. slot4]:UnLoadImage()
	end

	slot0._simagebg:UnLoadImage()
	slot0._simagefrontbg:UnLoadImage()
	slot0._simageline:UnLoadImage()
	slot0._simagecurrency1:UnLoadImage()
	slot0._simagecurrency10:UnLoadImage()
end

return slot0
