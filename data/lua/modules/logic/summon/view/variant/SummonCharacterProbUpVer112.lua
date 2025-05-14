module("modules.logic.summon.view.variant.SummonCharacterProbUpVer112", package.seeall)

local var_0_0 = class("SummonCharacterProbUpVer112", SummonMainCharacterProbUp)

var_0_0.SIMAGE_COUNT = 3
var_0_0.preloadList = {
	ResUrl.getSummonCoverBg("heroversion_1_1/full/bg1"),
	ResUrl.getSummonCoverBg("heroversion_1_1/fg")
}

for iter_0_0 = 1, var_0_0.SIMAGE_COUNT do
	table.insert(var_0_0.preloadList, ResUrl.getSummonCoverBg("heroversion_1_1/img_role" .. iter_0_0 + 3))
end

function var_0_0._editableInitView(arg_1_0)
	arg_1_0._charaterItemCount = 2

	var_0_0.super._editableInitView(arg_1_0)
end

function var_0_0.refreshSingleImage(arg_2_0)
	arg_2_0._simagebg:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_1/full/bg1"))
	arg_2_0._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
	arg_2_0._simagefrontbg:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_1/fg"))

	for iter_2_0 = 1, var_0_0.SIMAGE_COUNT do
		arg_2_0["_simagead" .. iter_2_0]:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_1/img_role" .. iter_2_0 + 3), arg_2_0._adLoaded, arg_2_0)
	end
end

function var_0_0.unloadSingleImage(arg_3_0)
	for iter_3_0 = 1, var_0_0.SIMAGE_COUNT do
		arg_3_0["_simagead" .. iter_3_0]:UnLoadImage()
	end

	arg_3_0._simagebg:UnLoadImage()
	arg_3_0._simageline:UnLoadImage()
	arg_3_0._simagecurrency1:UnLoadImage()
	arg_3_0._simagecurrency10:UnLoadImage()
	arg_3_0._simagefrontbg:UnLoadImage()
end

return var_0_0
