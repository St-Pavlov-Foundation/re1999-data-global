module("modules.logic.versionactivity1_3.armpipe.view.ArmRewardViewTaskItem", package.seeall)

local var_0_0 = class("ArmRewardViewTaskItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtNum = gohelper.findChildText(arg_1_0.viewGO, "Root/#txt_Num")
	arg_1_0._txtTaskDesc = gohelper.findChildText(arg_1_0.viewGO, "Root/#txt_TaskDesc")
	arg_1_0._gorewards = gohelper.findChild(arg_1_0.viewGO, "Root/#scroll_Rewards/Viewport/#gorewards")
	arg_1_0._goclaimedBG = gohelper.findChild(arg_1_0.viewGO, "Root/image_ClaimedBG")
	arg_1_0._gocollecticon = gohelper.findChild(arg_1_0.viewGO, "Root/#go_collecticon")

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
	gohelper.setActive(arg_4_0._gocollecticon, false)

	arg_4_0._animator = arg_4_0.viewGO:GetComponent(ArmPuzzlePipeEnum.ComponentType.Animator)
end

function var_0_0._editableAddEvents(arg_5_0)
	return
end

function var_0_0._editableRemoveEvents(arg_6_0)
	return
end

function var_0_0.getAnimator(arg_7_0)
	return arg_7_0._animator
end

function var_0_0.onUpdateMO(arg_8_0, arg_8_1)
	arg_8_0._rewardMO = arg_8_1

	arg_8_0:_refreshUI()
end

function var_0_0.onSelect(arg_9_0, arg_9_1)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	return
end

function var_0_0._refreshUI(arg_11_0)
	local var_11_0 = arg_11_0._rewardMO

	if var_11_0 and var_11_0.config then
		local var_11_1 = var_11_0.config

		arg_11_0._txtNum.text = arg_11_0:_getNumStr(var_11_1.episodeId)
		arg_11_0._txtTaskDesc.text = var_11_1.name

		local var_11_2 = ItemModel.instance:getItemDataListByConfigStr(var_11_0.config.firstBonus)

		arg_11_0.itemList = var_11_2
		arg_11_0._isReceived = Activity124Model.instance:isReceived(var_11_1.activityId, var_11_1.episodeId)

		IconMgr.instance:getCommonPropItemIconList(arg_11_0, arg_11_0._onItemShow, var_11_2, arg_11_0._gorewards)
		gohelper.setActive(arg_11_0._goclaimedBG, arg_11_0._isReceived)
	end
end

function var_0_0._getNumStr(arg_12_0, arg_12_1)
	if arg_12_1 < 10 then
		return "0" .. arg_12_1
	end

	return tostring(arg_12_1)
end

function var_0_0._onItemShow(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	arg_13_1:onUpdateMO(arg_13_2)
	arg_13_1:setConsume(true)
	arg_13_1:showStackableNum2()
	arg_13_1:isShowEffect(true)
	arg_13_1:setAutoPlay(true)
	arg_13_1:setCountFontSize(48)

	if not arg_13_1._gocollecticon then
		arg_13_1._gocollecticon = gohelper.clone(arg_13_0._gocollecticon, arg_13_1.viewGO)

		local var_13_0 = arg_13_1._gocollecticon.transform

		transformhelper.setLocalPos(var_13_0, 0, 0, 0)
	end

	gohelper.setActive(arg_13_1._gocollecticon, arg_13_0._isReceived)
end

var_0_0.prefabPath = "ui/viewres/versionactivity_1_3/v1a3_arm/v1a3_armreward_taskitem.prefab"

return var_0_0
