module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotMainView", package.seeall)

local var_0_0 = class("V1a6_CachotMainView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "title/#txt_title")
	arg_1_0._btncollection = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_collection")
	arg_1_0._btnreward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_reward")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "#btn_reward/#go_reddot")
	arg_1_0._txtscore = gohelper.findChildText(arg_1_0.viewGO, "#btn_reward/scorebg/#txt_score")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#btn_reward/scorebg/#txt_score/#simage_icon")
	arg_1_0._gocontrol = gohelper.findChild(arg_1_0.viewGO, "#go_control")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btncollection:AddClickListener(arg_2_0._btncollectionOnClick, arg_2_0)
	arg_2_0._btnreward:AddClickListener(arg_2_0._btnrewardOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btncollection:RemoveClickListener()
	arg_3_0._btnreward:RemoveClickListener()
end

function var_0_0._btnrewardOnClick(arg_4_0)
	V1a6_CachotController.instance:openV1a6_CachotProgressView()
end

function var_0_0._btncollectionOnClick(arg_5_0)
	V1a6_CachotController.instance:openV1a6_CachotCollectionView()
end

function var_0_0._editableInitView(arg_6_0)
	return
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0.stateMo = V1a6_CachotModel.instance:getRogueStateInfo()
	arg_8_0._txtscore.text = arg_8_0.stateMo.totalScore

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_interface_open)
	RedDotController.instance:addRedDot(arg_8_0._goreddot, RedDotEnum.DotNode.V1a6RogueRewardEnter)
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	return
end

return var_0_0
