module("modules.logic.summon.view.variant.SummonCharacterProbUpVer126", package.seeall)

local var_0_0 = class("SummonCharacterProbUpVer126", SummonMainCharacterProbUp)

var_0_0.SIMAGE_COUNT = 3
var_0_0.preloadList = {
	ResUrl.getSummonCoverBg("heroversion_1_2/nimengdishi/full/bg_da"),
	ResUrl.getSummonCoverBg("heroversion_1_2/nimengdishi/bg_zhezhao")
}
var_0_0.decoCount = 2

function var_0_0._editableInitView(arg_1_0)
	for iter_1_0 = 1, var_0_0.SIMAGE_COUNT do
		arg_1_0["_simagead" .. iter_1_0] = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/node" .. iter_1_0 .. "/#simage_ad" .. iter_1_0)
	end

	arg_1_0._simageframe = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_frame")

	local var_1_0 = var_0_0.decoCount

	for iter_1_1 = 1, var_1_0 do
		arg_1_0["_simagedecorate" .. iter_1_1] = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/decorates/#simage_decorate" .. iter_1_1)
	end

	arg_1_0._txtdeadline = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/current/image_deadline/#txt_deadline")
	arg_1_0._simageline = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/image_deadline/#txt_deadline/#simage_line")

	var_0_0.super._editableInitView(arg_1_0)
end

function var_0_0.refreshSingleImage(arg_2_0)
	arg_2_0._simagebg:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_2/nimengdishi/full/bg_da"))
	arg_2_0._simageframe:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_2/nimengdishi/bg_kuang"))
	arg_2_0._simagead1:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_2/nimengdishi/xiali"))
	arg_2_0._simagead2:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_2/nimengdishi/malilian"))
	arg_2_0._simagead3:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_2/nimengdishi/anan"))
	arg_2_0._simagefrontbg:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_2/nimengdishi/bg_zhezhao"))

	local var_2_0 = var_0_0.decoCount

	for iter_2_0 = 1, var_2_0 do
		arg_2_0["_simagedecorate" .. iter_2_0]:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_2/nimengdishi/fu" .. tostring(iter_2_0)))
	end

	arg_2_0._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
end

function var_0_0.unloadSingleImage(arg_3_0)
	for iter_3_0 = 1, var_0_0.SIMAGE_COUNT do
		arg_3_0["_simagead" .. iter_3_0]:UnLoadImage()
	end

	arg_3_0._simagebg:UnLoadImage()
	arg_3_0._simagefrontbg:UnLoadImage()
	arg_3_0._simageline:UnLoadImage()

	local var_3_0 = var_0_0.decoCount

	for iter_3_1 = 1, var_3_0 do
		local var_3_1 = arg_3_0["_simagedecorate" .. iter_3_1]

		if var_3_1 then
			var_3_1:UnLoadImage()
		end
	end

	arg_3_0._simagecurrency1:UnLoadImage()
	arg_3_0._simagecurrency10:UnLoadImage()
end

return var_0_0
