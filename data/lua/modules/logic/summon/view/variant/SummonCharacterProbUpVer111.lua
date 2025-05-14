module("modules.logic.summon.view.variant.SummonCharacterProbUpVer111", package.seeall)

local var_0_0 = class("SummonCharacterProbUpVer111", SummonMainCharacterProbUp)

var_0_0.SIMAGE_COUNT = 3
var_0_0.preloadList = {
	ResUrl.getSummonCoverBg("heroversion_1_1/full/bg"),
	ResUrl.getSummonCoverBg("heroversion_1_1/bg_zsz")
}

for iter_0_0 = 1, var_0_0.SIMAGE_COUNT do
	table.insert(var_0_0.preloadList, ResUrl.getSummonCoverBg("heroversion_1_1/img_role" .. iter_0_0))
end

function var_0_0.refreshSingleImage(arg_1_0)
	arg_1_0._simagebg:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_1/full/bg"))
	arg_1_0._simagefrontbg:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_1/bg_zsz"))
	arg_1_0._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))

	for iter_1_0 = 1, var_0_0.SIMAGE_COUNT do
		arg_1_0["_simagead" .. iter_1_0]:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_1/img_role" .. iter_1_0), arg_1_0._adLoaded, arg_1_0)
	end
end

function var_0_0.unloadSingleImage(arg_2_0)
	for iter_2_0 = 1, var_0_0.SIMAGE_COUNT do
		arg_2_0["_simagead" .. iter_2_0]:UnLoadImage()
	end

	arg_2_0._simagebg:UnLoadImage()
	arg_2_0._simagefrontbg:UnLoadImage()
	arg_2_0._simageline:UnLoadImage()
	arg_2_0._simagecurrency1:UnLoadImage()
	arg_2_0._simagecurrency10:UnLoadImage()
end

return var_0_0
