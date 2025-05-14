module("modules.logic.summon.view.variant.SummonCharacterProbUpVer156", package.seeall)

local var_0_0 = class("SummonCharacterProbUpVer156", SummonMainCharacterProbUp)

var_0_0.preloadList = {
	"singlebg/summon/heroversion_1_3/rabbit/full/v1a3_rabbit_bg.png"
}

function var_0_0._editableInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_bg")
	arg_1_0._simagedog = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_dog")
	arg_1_0._simageround = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/5role/#simage_round")
	arg_1_0._simagerole1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/5role/#simage_role1")
	arg_1_0._simagerole2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/5role/#simage_role2")
	arg_1_0._simagecircle = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/5role/#simage_circle")
	arg_1_0._g = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/tip/bg")
	arg_1_0._rrow = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/tip/arrow/arrow")
	arg_1_0._charaterItemCount = 1

	var_0_0.super._editableInitView(arg_1_0)
end

function var_0_0.refreshSingleImage(arg_2_0)
	arg_2_0._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
end

function var_0_0.unloadSingleImage(arg_3_0)
	arg_3_0._simagebg:UnLoadImage()
	arg_3_0._simagedog:UnLoadImage()
	arg_3_0._simageround:UnLoadImage()
	arg_3_0._simagerole1:UnLoadImage()
	arg_3_0._simagerole2:UnLoadImage()
	arg_3_0._simagecircle:UnLoadImage()
	arg_3_0._g:UnLoadImage()
	arg_3_0._rrow:UnLoadImage()
	arg_3_0._simageline:UnLoadImage()
	arg_3_0._simagecurrency1:UnLoadImage()
	arg_3_0._simagecurrency10:UnLoadImage()
end

function var_0_0._refreshOpenTime(arg_4_0)
	arg_4_0._txtdeadline.text = ""

	local var_4_0 = SummonMainModel.instance:getCurPool()

	if not var_4_0 then
		return
	end

	local var_4_1 = SummonMainModel.instance:getPoolServerMO(var_4_0.id)

	if not var_4_1 then
		return
	end

	local var_4_2, var_4_3 = var_4_1:onOffTimestamp()

	if var_4_2 < var_4_3 and var_4_3 > 0 then
		local var_4_4 = var_4_3 - ServerTime.now()

		arg_4_0._txtdeadline.text = formatLuaLang("summonmainequipprobup_deadline", SummonModel.formatRemainTime(var_4_4))
	end
end

return var_0_0
