module("modules.logic.versionactivity.view.PushBoxTaskItem", package.seeall)

local var_0_0 = class("PushBoxTaskItem", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.txt_desc = gohelper.findChildTextMesh(arg_1_0.viewGO, "txt_desc")
	arg_1_0.txt_curcount = gohelper.findChildText(arg_1_0.viewGO, "txt_curcount")
	arg_1_0.txt_totalcount = gohelper.findChildText(arg_1_0.viewGO, "txt_totalcount")
	arg_1_0.btn_receive = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btn_receive")
	arg_1_0.btn_jump = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btn_jump")
	arg_1_0.go_rewards = gohelper.findChild(arg_1_0.viewGO, "go_rewards")
	arg_1_0.go_finish = gohelper.findChild(arg_1_0.viewGO, "go_finish")
	arg_1_0.simage_bg = gohelper.findChildSingleImage(arg_1_0.viewGO, "simage_bg")
	arg_1_0._go_blackmask = gohelper.findChild(arg_1_0.viewGO, "go_blackmask")
	arg_1_0._ani = gohelper.onceAddComponent(arg_1_0.viewGO, typeof(UnityEngine.Animator))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0.btn_jump:AddClickListener(arg_2_0._onBtnJump, arg_2_0)
	arg_2_0.btn_receive:AddClickListener(arg_2_0._onBtnReceive, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0.btn_jump:RemoveClickListener()
	arg_3_0.btn_receive:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0.simage_bg.curImageUrl = nil

	arg_4_0.simage_bg:LoadImage(ResUrl.getVersionActivityIcon("pushbox/ing_rwdi"))
end

function var_0_0.onOpen(arg_5_0)
	return
end

function var_0_0.playOpenAni(arg_6_0, arg_6_1)
	arg_6_0._ani:Play(UIAnimationName.Open, 0, 0)
end

function var_0_0._refreshData(arg_7_0, arg_7_1)
	arg_7_0._ani:Play(UIAnimationName.Idle, 0, 0)

	arg_7_0._task_data = PushBoxModel.instance:getTaskData(arg_7_1.id)
	arg_7_0._config = arg_7_1.config
	arg_7_0.txt_desc.text = arg_7_0._config.desc
	arg_7_0.txt_curcount.text = arg_7_0._task_data.progress
	arg_7_0.txt_totalcount.text = arg_7_0._config.maxProgress

	local var_7_0 = ItemModel.instance:getItemDataListByConfigStr(arg_7_0._config.bonus)

	arg_7_0.item_list = var_7_0

	IconMgr.instance:getCommonPropItemIconList(arg_7_0, arg_7_0._onItemShow, var_7_0, arg_7_0.go_rewards)
	gohelper.setActive(arg_7_0.btn_receive.gameObject, not arg_7_0._task_data.hasGetBonus and arg_7_0._task_data.progress >= arg_7_0._config.maxProgress)
	gohelper.setActive(arg_7_0.go_finish, arg_7_0._task_data.hasGetBonus)
	gohelper.setActive(arg_7_0.btn_jump.gameObject, not arg_7_0._task_data.hasGetBonus and arg_7_0._task_data.progress < arg_7_0._config.maxProgress)
	gohelper.setActive(arg_7_0._go_blackmask, arg_7_0._task_data.hasGetBonus)
end

function var_0_0._onItemShow(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_1:onUpdateMO(arg_8_2)
	arg_8_1:setConsume(true)
	arg_8_1:showStackableNum2()
	arg_8_1:isShowEffect(true)
	arg_8_1:setAutoPlay(true)
	arg_8_1:setCountFontSize(48)
end

function var_0_0._onBtnReceive(arg_9_0)
	if arg_9_0._task_data.progress < arg_9_0._config.maxProgress then
		return
	end

	UIBlockMgr.instance:startBlock("PushBoxTaskItemReward")
	gohelper.setActive(arg_9_0._go_blackmask, true)
	arg_9_0._ani:Play("finish", 0, 0)
	TaskDispatcher.runDelay(arg_9_0._taskRewardRequest, arg_9_0, 0.6)
end

function var_0_0._taskRewardRequest(arg_10_0)
	UIBlockMgr.instance:endBlock("PushBoxTaskItemReward")
	PushBoxRpc.instance:sendReceiveTaskRewardRequest(nil, arg_10_0._config.taskId)
end

function var_0_0._onBtnJump(arg_11_0)
	local var_11_0 = tonumber(string.split(arg_11_0._config.listenerParam, "#")[1])

	if not PushBoxModel.instance:getPassData(var_11_0) then
		GameFacade.showToast(ToastEnum.WarmUpGotoOrder)

		return
	end

	ViewMgr.instance:closeView(ViewName.VersionActivityPushBoxTaskView)
end

function var_0_0.onClose(arg_12_0)
	UIBlockMgr.instance:endBlock("PushBoxTaskItemReward")
	TaskDispatcher.cancelTask(arg_12_0._showAni, arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0._taskRewardRequest, arg_12_0)
end

function var_0_0.onDestroyView(arg_13_0)
	arg_13_0.simage_bg:UnLoadImage()
end

return var_0_0
