module("modules.logic.versionactivity1_3.armpipe.view.ArmRewardView", package.seeall)

local var_0_0 = class("ArmRewardView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Close")
	arg_1_0._simageclosebtn = gohelper.findChildSingleImage(arg_1_0.viewGO, "#btn_Close")
	arg_1_0._simagePanelBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#simage_PanelBG")
	arg_1_0._txtTitle = gohelper.findChildText(arg_1_0.viewGO, "Root/Title/#txt_Title")
	arg_1_0._scrollTaskList = gohelper.findChildScrollRect(arg_1_0.viewGO, "Root/#scroll_TaskList")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0._btnCloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnClose:RemoveClickListener()
end

function var_0_0._btnCloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._simageclosebtn:LoadImage(ResUrl.getJiaLaBoNaIcon("v1a3_role1_igfullmask"))
	arg_5_0._simagePanelBG:LoadImage(ResUrl.getV1a3ArmSinglebg("v1a3_arm_reward_pop_bg"))
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0:addEventCb(Activity124Controller.instance, ArmPuzzlePipeEvent.RefreshMapData, arg_7_0.refreshUI, arg_7_0)
	arg_7_0:addEventCb(Activity124Controller.instance, ArmPuzzlePipeEvent.RefreshReceiveReward, arg_7_0.refreshUI, arg_7_0)
	arg_7_0:refreshUI()
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	arg_9_0._simageclosebtn:UnLoadImage()
	arg_9_0._simagePanelBG:UnLoadImage()
end

function var_0_0.refreshUI(arg_10_0)
	Activity124RewardListModel.instance:init(VersionActivity1_3Enum.ActivityId.Act305)
end

return var_0_0
