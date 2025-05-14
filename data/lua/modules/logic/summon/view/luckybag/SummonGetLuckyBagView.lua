module("modules.logic.summon.view.luckybag.SummonGetLuckyBagView", package.seeall)

local var_0_0 = class("SummonGetLuckyBagView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "content/#go_collection/txt_name")
	arg_1_0._txtnameen = gohelper.findChildText(arg_1_0.viewGO, "content/#go_collection/en")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "content/#go_collection/#simage_icon")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._bgClick = gohelper.getClick(arg_4_0.viewGO)

	arg_4_0._bgClick:AddClickListener(arg_4_0._onClickBG, arg_4_0)
end

function var_0_0.onDestroyView(arg_5_0)
	arg_5_0._bgClick:RemoveClickListener()
end

function var_0_0.onOpen(arg_6_0)
	logNormal("SummonGetLuckyBagView onOpen")
	AudioMgr.instance:trigger(AudioEnum.Summon.play_ui_wulu_lucky_bag_gain)
	arg_6_0:refreshView()
end

function var_0_0.onClose(arg_7_0)
	return
end

function var_0_0.refreshView(arg_8_0)
	local var_8_0 = arg_8_0.viewParam.poolId
	local var_8_1 = arg_8_0.viewParam.luckyBagId
	local var_8_2 = SummonConfig.instance:getLuckyBag(var_8_0, var_8_1)

	if var_8_2 then
		arg_8_0._txtname.text = var_8_2.name
		arg_8_0._txtnameen.text = var_8_2.nameEn or ""

		arg_8_0._simageicon:LoadImage(ResUrl.getSummonCoverBg(var_8_2.icon))
	end
end

function var_0_0._onClickBG(arg_9_0)
	arg_9_0:closeThis()
end

return var_0_0
