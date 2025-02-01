module("modules.logic.versionactivity.view.PushBoxTaskItem", package.seeall)

slot0 = class("PushBoxTaskItem", BaseView)

function slot0.onInitView(slot0)
	slot0.txt_desc = gohelper.findChildTextMesh(slot0.viewGO, "txt_desc")
	slot0.txt_curcount = gohelper.findChildText(slot0.viewGO, "txt_curcount")
	slot0.txt_totalcount = gohelper.findChildText(slot0.viewGO, "txt_totalcount")
	slot0.btn_receive = gohelper.findChildButtonWithAudio(slot0.viewGO, "btn_receive")
	slot0.btn_jump = gohelper.findChildButtonWithAudio(slot0.viewGO, "btn_jump")
	slot0.go_rewards = gohelper.findChild(slot0.viewGO, "go_rewards")
	slot0.go_finish = gohelper.findChild(slot0.viewGO, "go_finish")
	slot0.simage_bg = gohelper.findChildSingleImage(slot0.viewGO, "simage_bg")
	slot0._go_blackmask = gohelper.findChild(slot0.viewGO, "go_blackmask")
	slot0._ani = gohelper.onceAddComponent(slot0.viewGO, typeof(UnityEngine.Animator))

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0.btn_jump:AddClickListener(slot0._onBtnJump, slot0)
	slot0.btn_receive:AddClickListener(slot0._onBtnReceive, slot0)
end

function slot0.removeEvents(slot0)
	slot0.btn_jump:RemoveClickListener()
	slot0.btn_receive:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot0.simage_bg.curImageUrl = nil

	slot0.simage_bg:LoadImage(ResUrl.getVersionActivityIcon("pushbox/ing_rwdi"))
end

function slot0.onOpen(slot0)
end

function slot0.playOpenAni(slot0, slot1)
	slot0._ani:Play(UIAnimationName.Open, 0, 0)
end

function slot0._refreshData(slot0, slot1)
	slot0._ani:Play(UIAnimationName.Idle, 0, 0)

	slot0._task_data = PushBoxModel.instance:getTaskData(slot1.id)
	slot0._config = slot1.config
	slot0.txt_desc.text = slot0._config.desc
	slot0.txt_curcount.text = slot0._task_data.progress
	slot0.txt_totalcount.text = slot0._config.maxProgress
	slot2 = ItemModel.instance:getItemDataListByConfigStr(slot0._config.bonus)
	slot0.item_list = slot2

	IconMgr.instance:getCommonPropItemIconList(slot0, slot0._onItemShow, slot2, slot0.go_rewards)
	gohelper.setActive(slot0.btn_receive.gameObject, not slot0._task_data.hasGetBonus and slot0._config.maxProgress <= slot0._task_data.progress)
	gohelper.setActive(slot0.go_finish, slot0._task_data.hasGetBonus)
	gohelper.setActive(slot0.btn_jump.gameObject, not slot0._task_data.hasGetBonus and slot0._task_data.progress < slot0._config.maxProgress)
	gohelper.setActive(slot0._go_blackmask, slot0._task_data.hasGetBonus)
end

function slot0._onItemShow(slot0, slot1, slot2, slot3)
	slot1:onUpdateMO(slot2)
	slot1:setConsume(true)
	slot1:showStackableNum2()
	slot1:isShowEffect(true)
	slot1:setAutoPlay(true)
	slot1:setCountFontSize(48)
end

function slot0._onBtnReceive(slot0)
	if slot0._task_data.progress < slot0._config.maxProgress then
		return
	end

	UIBlockMgr.instance:startBlock("PushBoxTaskItemReward")
	gohelper.setActive(slot0._go_blackmask, true)
	slot0._ani:Play("finish", 0, 0)
	TaskDispatcher.runDelay(slot0._taskRewardRequest, slot0, 0.6)
end

function slot0._taskRewardRequest(slot0)
	UIBlockMgr.instance:endBlock("PushBoxTaskItemReward")
	PushBoxRpc.instance:sendReceiveTaskRewardRequest(nil, slot0._config.taskId)
end

function slot0._onBtnJump(slot0)
	if not PushBoxModel.instance:getPassData(tonumber(string.split(slot0._config.listenerParam, "#")[1])) then
		GameFacade.showToast(ToastEnum.WarmUpGotoOrder)

		return
	end

	ViewMgr.instance:closeView(ViewName.VersionActivityPushBoxTaskView)
end

function slot0.onClose(slot0)
	UIBlockMgr.instance:endBlock("PushBoxTaskItemReward")
	TaskDispatcher.cancelTask(slot0._showAni, slot0)
	TaskDispatcher.cancelTask(slot0._taskRewardRequest, slot0)
end

function slot0.onDestroyView(slot0)
	slot0.simage_bg:UnLoadImage()
end

return slot0
