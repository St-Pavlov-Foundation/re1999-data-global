module("modules.logic.sp01.odyssey.view.OdysseyLevelRewardView", package.seeall)

local var_0_0 = class("OdysseyLevelRewardView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._scrollRewardList = gohelper.findChildScrollRect(arg_1_0.viewGO, "root/Reward/#scroll_RewardList")
	arg_1_0._goContent = gohelper.findChild(arg_1_0.viewGO, "root/Reward/#scroll_RewardList/Viewport/#go_Content")
	arg_1_0._gorewarditem = gohelper.findChild(arg_1_0.viewGO, "root/Reward/#scroll_RewardList/Viewport/#go_Content/#go_rewarditem")
	arg_1_0._txtlevel = gohelper.findChildText(arg_1_0.viewGO, "root/Level/image_level/#txt_level")
	arg_1_0._imageexpProgress = gohelper.findChildImage(arg_1_0.viewGO, "root/Level/image_level/#image_expProgress")
	arg_1_0._txtexp = gohelper.findChildText(arg_1_0.viewGO, "root/Level/image_exp/#txt_exp")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "root/#go_topleft")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(OdysseyController.instance, OdysseyEvent.OdysseyTaskUpdated, arg_2_0.refreshUI, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(OdysseyController.instance, OdysseyEvent.OdysseyTaskUpdated, arg_3_0.refreshUI, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	gohelper.setActive(arg_4_0._gorewarditem, false)
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	AudioMgr.instance:trigger(AudioEnum2_9.Odyssey.play_ui_cikexia_link_award)
	arg_6_0:refreshUI()
	arg_6_0:setScrollMove()
end

function var_0_0.refreshUI(arg_7_0)
	arg_7_0.curLevel, arg_7_0.curExp = OdysseyModel.instance:getHeroCurLevelAndExp()

	local var_7_0 = OdysseyConfig.instance:getLevelConfig(arg_7_0.curLevel)

	arg_7_0._txtlevel.text = arg_7_0.curLevel
	arg_7_0._imageexpProgress.fillAmount = var_7_0 and var_7_0.needExp > 0 and arg_7_0.curExp / var_7_0.needExp or 1
	arg_7_0._txtexp.text = var_7_0 and var_7_0.needExp > 0 and string.format("XP: <#ffac54>%s</color>/%s", arg_7_0.curExp, var_7_0.needExp) or "XP: MAX"
end

var_0_0.rewardItemWidth = 384
var_0_0.rewardItemSpace = 42
var_0_0.leftOffset = 18

function var_0_0.setScrollMove(arg_8_0)
	local var_8_0 = recthelper.getWidth(arg_8_0._scrollRewardList.gameObject.transform)
	local var_8_1 = var_0_0.rewardItemWidth + var_0_0.rewardItemSpace

	arg_8_0.taskList = OdysseyTaskModel.instance:getCurTaskList(OdysseyEnum.TaskType.LevelReward)

	if #arg_8_0.taskList == 0 then
		recthelper.setAnchorX(arg_8_0._goContent.transform, 0)

		return
	end

	local var_8_2 = #arg_8_0.taskList * var_8_1 - var_0_0.rewardItemSpace + var_0_0.leftOffset - var_8_0
	local var_8_3 = OdysseyTaskModel.instance:getAllCanGetMoList(OdysseyEnum.TaskType.LevelReward)

	if #var_8_3 > 0 then
		local var_8_4 = var_8_3[1].config.maxProgress

		recthelper.setAnchorX(arg_8_0._goContent.transform, Mathf.Max(-Mathf.Max(var_8_4 - 3, 0) * var_8_1), -var_8_2)
	else
		recthelper.setAnchorX(arg_8_0._goContent.transform, Mathf.Max(-Mathf.Max(arg_8_0.curLevel - 2, 0) * var_8_1), -var_8_2)
	end
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	return
end

return var_0_0
