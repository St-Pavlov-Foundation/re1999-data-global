module("modules.logic.versionactivity2_5.act186.view.Activity186GiftView", package.seeall)

local var_0_0 = class("Activity186GiftView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._simageItem = gohelper.findChildSingleImage(arg_1_0.viewGO, "Item/#simage_Item")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._clickbg:AddClickListener(arg_2_0._onBgClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._clickbg:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._clickbg = gohelper.getClickWithAudio(arg_4_0._simageFullBG.gameObject)
end

function var_0_0._onBgClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0.onClickModalMask(arg_6_0)
	arg_6_0:closeThis()
end

function var_0_0.onOpen(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.NewYearEve.play_ui_shuori_evegift_popup)
	arg_7_0:_refreshUI()
end

function var_0_0._refreshUI(arg_8_0)
	arg_8_0._simageItem:LoadImage(ResUrl.getAntiqueIcon("v2a5_antique_icon_1"))
end

function var_0_0.onClose(arg_9_0)
	local var_9_0 = Activity186Config.instance:getConstStr(Activity186Enum.ConstId.AvgReward)
	local var_9_1 = GameUtil.splitString2(var_9_0, true)
	local var_9_2 = {}

	for iter_9_0, iter_9_1 in ipairs(var_9_1) do
		local var_9_3 = MaterialDataMO.New()

		var_9_3:initValue(iter_9_1[1], iter_9_1[2], iter_9_1[3])
		table.insert(var_9_2, var_9_3)
	end

	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, var_9_2)
end

function var_0_0.onDestroyView(arg_10_0)
	arg_10_0._simageItem:UnLoadImage()
end

return var_0_0
