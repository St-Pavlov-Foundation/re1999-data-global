module("modules.logic.explore.view.ExploreGuideView", package.seeall)

local var_0_0 = class("ExploreGuideView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "commen/#simage_bg")
	arg_1_0._simagedecorate1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "commen/#simage_decorate1")
	arg_1_0._simagedecorate3 = gohelper.findChildSingleImage(arg_1_0.viewGO, "commen/#simage_decorate3")
	arg_1_0._btnlook = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "commen/#btn_look")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnlook:AddClickListener(arg_2_0._btnlookOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnlook:RemoveClickListener()
end

function var_0_0._btnlookOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._simagebg:LoadImage(ResUrl.getWeekWalkBg("yd_yindaodi_1.png"))
	arg_5_0._simagedecorate1:LoadImage(ResUrl.getCommonIcon("yd_biaoti_di"))
	arg_5_0._simagedecorate3:LoadImage(ResUrl.getCommonIcon("yd_blxian"))
end

function var_0_0.onUpdateParam(arg_6_0)
	arg_6_0:_setAnim()
end

function var_0_0._setAnim(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.viewParam and arg_7_0.viewParam.viewParam and arg_7_0.viewParam.viewParam[1]

	var_7_0 = var_7_0 or 1

	if not arg_7_1 and var_7_0 == 4 then
		return
	end

	if AudioEnum.Explore["ExploreGuideUnlock" .. var_7_0] then
		AudioMgr.instance:trigger(AudioEnum.Explore["ExploreGuideUnlock" .. var_7_0])
	end

	local var_7_1 = tostring(var_7_0)

	arg_7_0._anim:Play(var_7_1, 0, 0)
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0._anim = arg_8_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	arg_8_0:_setAnim(true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_artificial_ui_openfunction)
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	arg_10_0._simagebg:UnLoadImage()
	arg_10_0._simagedecorate1:UnLoadImage()
	arg_10_0._simagedecorate3:UnLoadImage()
end

return var_0_0
