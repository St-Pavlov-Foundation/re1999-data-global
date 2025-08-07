module("modules.logic.sp01.odyssey.view.OdysseyTaskView", package.seeall)

local var_0_0 = class("OdysseyTaskView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._scrollTaskList = gohelper.findChildScrollRect(arg_1_0.viewGO, "root/Task/#scroll_TaskList")
	arg_1_0._txtreward = gohelper.findChildText(arg_1_0.viewGO, "root/Reward/image_nameBG/#txt_reward")
	arg_1_0._simagereward = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/Reward/#simage_reward")
	arg_1_0._imagereward = gohelper.findChildImage(arg_1_0.viewGO, "root/Reward/#simage_reward")
	arg_1_0._btnbigRewardClick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/Reward/#simage_reward/#btn_bigRewardClick")
	arg_1_0._scrolldesc = gohelper.findChildScrollRect(arg_1_0.viewGO, "root/Reward/#scroll_desc")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "root/Reward/#scroll_desc/Viewport/Content/#txt_desc")
	arg_1_0._btncanget = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/Reward/btn/#btn_canget")
	arg_1_0._gohasget = gohelper.findChild(arg_1_0.viewGO, "root/Reward/btn/#go_hasget")
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "root/Reward/btn/#go_normal")
	arg_1_0._scrollLeftTab = gohelper.findChildScrollRect(arg_1_0.viewGO, "root/#scroll_LeftTab")
	arg_1_0._goTabContent = gohelper.findChild(arg_1_0.viewGO, "root/#scroll_LeftTab/Viewport/#go_tabContent")
	arg_1_0._goTabItem = gohelper.findChild(arg_1_0.viewGO, "root/#scroll_LeftTab/Viewport/#go_tabContent/#go_tabItem")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "root/#go_topleft")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btncanget:AddClickListener(arg_2_0._btncangetOnClick, arg_2_0)
	arg_2_0._btnbigRewardClick:AddClickListener(arg_2_0._btnbigRewardOnClick, arg_2_0)
	arg_2_0:addEventCb(OdysseyController.instance, OdysseyEvent.OnTaskRewardGetFinish, arg_2_0._playGetRewardFinishAnim, arg_2_0)
	arg_2_0:addEventCb(OdysseyController.instance, OdysseyEvent.OdysseyTaskUpdated, arg_2_0.refreshUI, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btncanget:RemoveClickListener()
	arg_3_0._btnbigRewardClick:RemoveClickListener()
	arg_3_0:removeEventCb(OdysseyController.instance, OdysseyEvent.OnTaskRewardGetFinish, arg_3_0._playGetRewardFinishAnim, arg_3_0)
	arg_3_0:removeEventCb(OdysseyController.instance, OdysseyEvent.OdysseyTaskUpdated, arg_3_0.refreshUI, arg_3_0)
end

var_0_0.TaskMaskTime = 0.65
var_0_0.TaskGetAnimTime = 0.567

function var_0_0._btncangetOnClick(arg_4_0)
	arg_4_0.bigRewardTaskMo = OdysseyTaskModel.instance:getBigRewardTaskMo()

	if OdysseyTaskModel.instance:isTaskCanGet(arg_4_0.bigRewardTaskMo) then
		TaskRpc.instance:sendFinishTaskRequest(arg_4_0.bigRewardTaskMo.id)
	end
end

function var_0_0._onTabClick(arg_5_0, arg_5_1)
	OdysseyTaskModel.instance:setCurSelectTaskTypeAndGroupId(OdysseyEnum.TaskType.NormalTask, arg_5_1.tabType)
	OdysseyTaskModel.instance:refreshList()
	arg_5_0:refreshTabSelectState()
end

function var_0_0._btnbigRewardOnClick(arg_6_0)
	local var_6_0 = string.splitToNumber(arg_6_0.bigRewardTaskConfig.bonus, "#")

	MaterialTipController.instance:showMaterialInfo(var_6_0[1], var_6_0[2])
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(arg_7_0.viewContainer.scrollView)

	arg_7_0._taskAnimRemoveItem:setMoveInterval(0)
	arg_7_0._taskAnimRemoveItem:setMoveAnimationTime(var_0_0.TaskMaskTime - var_0_0.TaskGetAnimTime)

	arg_7_0.removeIndexTab = {}

	gohelper.setActive(arg_7_0._goTabItem, false)

	arg_7_0.tabTypeList = {
		OdysseyEnum.TaskGroupType.Story,
		OdysseyEnum.TaskGroupType.Fight,
		OdysseyEnum.TaskGroupType.Collect,
		OdysseyEnum.TaskGroupType.Myth
	}
	arg_7_0.tabItemMap = arg_7_0:getUserDataTb_()
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	AudioMgr.instance:trigger(AudioEnum2_9.Odyssey.play_ui_cikexia_link_task)

	arg_9_0.bigRewardTaskConfig = OdysseyConfig.instance:getBigRewardTaskConfig()

	arg_9_0:refreshUI()
end

function var_0_0.refreshUI(arg_10_0)
	arg_10_0:createAndRefreshTab()
	arg_10_0:refreshBigReward()
	arg_10_0:refreshReddot()

	arg_10_0._scrollTaskList.verticalNormalizedPosition = 1
end

function var_0_0.createAndRefreshTab(arg_11_0)
	arg_11_0.curTaskType, arg_11_0.curSelectGroupTypeId = OdysseyTaskModel.instance:getCurSelectTaskTypeAndGroupId()

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.tabTypeList) do
		local var_11_0 = arg_11_0.tabItemMap[iter_11_1]

		if not var_11_0 then
			var_11_0 = {
				tabType = iter_11_1,
				go = gohelper.clone(arg_11_0._goTabItem, arg_11_0._goTabContent, "Tab" .. iter_11_1)
			}
			var_11_0.goNormal = gohelper.findChild(var_11_0.go, "go_normal")
			var_11_0.txtNormalName = gohelper.findChildText(var_11_0.go, "go_normal/txt_normalName")
			var_11_0.txtNormalNum = gohelper.findChildText(var_11_0.go, "go_normal/txt_normalNum")
			var_11_0.goSelect = gohelper.findChild(var_11_0.go, "go_select")
			var_11_0.txtSelectName = gohelper.findChildText(var_11_0.go, "go_select/txt_selectName")
			var_11_0.txtSelectNum = gohelper.findChildText(var_11_0.go, "go_select/txt_selectNum")
			var_11_0.goreddot = gohelper.findChild(var_11_0.go, "go_reddot")
			var_11_0.btnClick = gohelper.findChildButtonWithAudio(var_11_0.go, "btn_click")

			var_11_0.btnClick:AddClickListener(arg_11_0._onTabClick, arg_11_0, var_11_0)

			arg_11_0.tabItemMap[iter_11_1] = var_11_0
		end

		gohelper.setActive(var_11_0.go, true)
		gohelper.setActive(var_11_0.goNormal, var_11_0.tabType ~= arg_11_0.curSelectGroupTypeId)
		gohelper.setActive(var_11_0.goSelect, var_11_0.tabType == arg_11_0.curSelectGroupTypeId)

		var_11_0.txtNormalName.text = luaLang(OdysseyEnum.NormalTaskGroupTypeLang[iter_11_1])
		var_11_0.txtSelectName.text = luaLang(OdysseyEnum.NormalTaskGroupTypeLang[iter_11_1])

		local var_11_1 = OdysseyTaskModel.instance:getNormalTaskListByGroupType(var_11_0.tabType)
		local var_11_2 = OdysseyTaskModel.instance:getTaskItemRewardCount(var_11_1)

		var_11_0.txtNormalNum.text = string.format("%s/%s", var_11_2, #var_11_1)
		var_11_0.txtSelectNum.text = string.format("%s/%s", var_11_2, #var_11_1)
	end
end

function var_0_0.refreshTabSelectState(arg_12_0)
	arg_12_0.curTaskType, arg_12_0.curSelectGroupTypeId = OdysseyTaskModel.instance:getCurSelectTaskTypeAndGroupId()

	for iter_12_0, iter_12_1 in pairs(arg_12_0.tabItemMap) do
		gohelper.setActive(iter_12_1.goNormal, iter_12_1.tabType ~= arg_12_0.curSelectGroupTypeId)
		gohelper.setActive(iter_12_1.goSelect, iter_12_1.tabType == arg_12_0.curSelectGroupTypeId)
	end

	arg_12_0._scrollTaskList.verticalNormalizedPosition = 1
end

function var_0_0.refreshReddot(arg_13_0)
	for iter_13_0, iter_13_1 in pairs(arg_13_0.tabItemMap) do
		local var_13_0 = OdysseyTaskModel.instance:canShowReddot(OdysseyEnum.TaskType.NormalTask, iter_13_1.tabType)

		gohelper.setActive(iter_13_1.goreddot, var_13_0)
	end
end

function var_0_0.refreshBigReward(arg_14_0)
	local var_14_0 = string.splitToNumber(arg_14_0.bigRewardTaskConfig.bonus, "#")
	local var_14_1, var_14_2 = ItemModel.instance:getItemConfigAndIcon(var_14_0[1], var_14_0[2])

	arg_14_0._txtreward.text = var_14_1.name

	if var_14_0[1] == MaterialEnum.MaterialType.Equip then
		arg_14_0._simagereward:LoadImage(ResUrl.getHeroDefaultEquipIcon(var_14_1.id), function()
			arg_14_0._imagereward:SetNativeSize()
		end)
	else
		arg_14_0._simagereward:LoadImage(var_14_2)
	end

	arg_14_0._scrolldesc.verticalNormalizedPosition = 1
	arg_14_0._txtdesc.text = arg_14_0.bigRewardTaskConfig.desc
	arg_14_0.bigRewardTaskMo = OdysseyTaskModel.instance:getBigRewardTaskMo()

	local var_14_3 = OdysseyTaskModel.instance:isTaskHasGet(arg_14_0.bigRewardTaskMo)
	local var_14_4 = OdysseyTaskModel.instance:isTaskCanGet(arg_14_0.bigRewardTaskMo)

	gohelper.setActive(arg_14_0._gohasget, var_14_3)
	gohelper.setActive(arg_14_0._gonormal, not var_14_3 and not var_14_4)
	gohelper.setActive(arg_14_0._btncanget.gameObject, var_14_4)
end

function var_0_0._playGetRewardFinishAnim(arg_16_0, arg_16_1)
	if arg_16_1 then
		arg_16_0.removeIndexTab = {
			arg_16_1
		}
	end

	TaskDispatcher.runDelay(arg_16_0.delayPlayFinishAnim, arg_16_0, var_0_0.TaskGetAnimTime)
end

function var_0_0.delayPlayFinishAnim(arg_17_0)
	arg_17_0._taskAnimRemoveItem:removeByIndexs(arg_17_0.removeIndexTab)
end

function var_0_0.onClose(arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0.delayPlayFinishAnim, arg_18_0)
end

function var_0_0.onDestroyView(arg_19_0)
	for iter_19_0, iter_19_1 in pairs(arg_19_0.tabItemMap) do
		iter_19_1.btnClick:RemoveClickListener()
	end

	arg_19_0._simagereward:UnLoadImage()
end

return var_0_0
