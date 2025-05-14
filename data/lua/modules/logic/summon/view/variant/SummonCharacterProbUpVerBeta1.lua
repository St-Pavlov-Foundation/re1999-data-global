module("modules.logic.summon.view.variant.SummonCharacterProbUpVerBeta1", package.seeall)

local var_0_0 = class("SummonCharacterProbUpVerBeta1", SummonMainCharacterProbUp)

var_0_0.SIMAGE_COUNT = 3
var_0_0.preloadList = {
	ResUrl.getSummonCoverBg("hero/full/bg2"),
	ResUrl.getSummonCoverBg("hero/full/mask"),
	ResUrl.getSummonCoverBg("hero/leftdown"),
	ResUrl.getSummonCoverBg("hero/rightup")
}

local var_0_1 = {
	ResUrl.getSummonCoverBg("hero/bolinyidong"),
	ResUrl.getSummonCoverBg("hero/tannante"),
	ResUrl.getSummonCoverBg("hero/kaige")
}

for iter_0_0 = 1, var_0_0.SIMAGE_COUNT do
	table.insert(var_0_0.preloadList, var_0_1[iter_0_0])
end

function var_0_0._editableInitView(arg_1_0)
	arg_1_0._simageleft = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_left")
	arg_1_0._simageright = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_right")
	arg_1_0._simagejian = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_ad3/#simage_jian")
	arg_1_0._simagemask = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_mask")

	for iter_1_0 = 1, var_0_0.SIMAGE_COUNT do
		arg_1_0["_simagead" .. iter_1_0] = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_ad" .. iter_1_0)
	end

	var_0_0.super._editableInitView(arg_1_0)
end

function var_0_0.refreshSingleImage(arg_2_0)
	arg_2_0._simagebg:LoadImage(ResUrl.getSummonCoverBg("hero/full/bg2"))
	arg_2_0._simagemask:LoadImage(ResUrl.getSummonCoverBg("hero/full/mask"))
	arg_2_0._simageleft:LoadImage(ResUrl.getSummonCoverBg("hero/leftdown"))
	arg_2_0._simageright:LoadImage(ResUrl.getSummonCoverBg("hero/rightup"))
	arg_2_0._simagejian:LoadImage(ResUrl.getSummonCoverBg("hero/tianshi"))
	arg_2_0._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))

	for iter_2_0 = 1, var_0_0.SIMAGE_COUNT do
		arg_2_0["_simagead" .. iter_2_0]:LoadImage(var_0_1[iter_2_0], arg_2_0._adLoaded, arg_2_0)
	end
end

function var_0_0.unloadSingleImage(arg_3_0)
	for iter_3_0 = 1, var_0_0.SIMAGE_COUNT do
		arg_3_0["_simagead" .. iter_3_0]:UnLoadImage()
	end

	arg_3_0._simagebg:UnLoadImage()
	arg_3_0._simageleft:UnLoadImage()
	arg_3_0._simageright:UnLoadImage()
	arg_3_0._simagejian:UnLoadImage()
	arg_3_0._simagemask:UnLoadImage()
	arg_3_0._simageline:UnLoadImage()
	arg_3_0._simagecurrency1:UnLoadImage()
	arg_3_0._simagecurrency10:UnLoadImage()
end

return var_0_0
