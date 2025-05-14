module("modules.logic.versionactivity2_3.newcultivationgift.view.VersionActivity2_3NewCultivationGiftRewardView", package.seeall)

local var_0_0 = class("VersionActivity2_3NewCultivationGiftRewardView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagefullbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_fullbg")
	arg_1_0._simagedecbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_fullbg/#simage_decbg")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._scrollreward = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_reward")
	arg_1_0._gorewarditem = gohelper.findChild(arg_1_0.viewGO, "#scroll_reward/viewport/content/#go_rewarditem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0.onDestroyView(arg_6_0)
	return
end

return var_0_0
