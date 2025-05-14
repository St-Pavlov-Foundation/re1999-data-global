module("modules.logic.versionactivity2_5.act186.view.Activity186SignView", package.seeall)

local var_0_0 = class("Activity186SignView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.signList = {}
	arg_1_0.signContent = gohelper.findChild(arg_1_0.viewGO, "root/signList/Content")
	arg_1_0.btnTaskCanget = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/avgTask/#go_reward/go_canget")
	arg_1_0.goTaskReceive = gohelper.findChild(arg_1_0.viewGO, "root/avgTask/#go_reward/go_receive")
	arg_1_0.goTaskReward = gohelper.findChild(arg_1_0.viewGO, "root/avgTask/#go_reward/go_icon")
	arg_1_0.txtTaskDesc = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/avgTask/txtDesc")
	arg_1_0.hasgetHookAnim = gohelper.findChildComponent(arg_1_0.viewGO, "root/avgTask/#go_reward/go_receive/go_hasget", gohelper.Type_Animator)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnTaskCanget, arg_2_0.onClickBtnTaskCanget, arg_2_0)
	arg_2_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshNorSignActivity, arg_2_0.onRefreshNorSignActivity, arg_2_0)
	arg_2_0:addEventCb(Activity186Controller.instance, Activity186Event.SpBonusStageChange, arg_2_0.onSpBonusStageChange, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_2_0.onCloseView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onCloseView(arg_5_0, arg_5_1)
	if arg_5_1 == ViewName.CommonPropView then
		if arg_5_0._waitRefreshList then
			arg_5_0:refreshSignList()
		end

		if arg_5_0._waitRefreshTask then
			arg_5_0:refreshTask()
		end
	end
end

function var_0_0.onRefreshNorSignActivity(arg_6_0)
	arg_6_0._waitRefreshList = true
end

function var_0_0.onSpBonusStageChange(arg_7_0)
	arg_7_0._waitRefreshTask = true
end

function var_0_0.onClickBtnTaskCanget(arg_8_0)
	Activity101Rpc.instance:sendAcceptAct186SpBonusRequest(arg_8_0.signActId, arg_8_0.actId)
end

function var_0_0.onUpdateParam(arg_9_0)
	arg_9_0:refreshParam()
	arg_9_0:refreshView()
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0:refreshParam()
	arg_10_0:refreshView()
end

function var_0_0.refreshParam(arg_11_0)
	arg_11_0.actId = arg_11_0.viewParam.actId
	arg_11_0.signActId = ActivityEnum.Activity.V2a5_Act186Sign
	arg_11_0.actMo = Activity186Model.instance:getById(arg_11_0.actId)
end

function var_0_0.refreshView(arg_12_0)
	arg_12_0:refreshSignList()
	arg_12_0:refreshTask()
end

function var_0_0.refreshSignList(arg_13_0)
	arg_13_0._waitRefresh = false

	local var_13_0 = ActivityConfig.instance:getNorSignActivityCos(arg_13_0.signActId)

	for iter_13_0 = 1, math.max(#var_13_0, #arg_13_0.signList) do
		arg_13_0:getOrCreateItem(iter_13_0):onUpdateMO(var_13_0[iter_13_0])
	end
end

function var_0_0.getOrCreateItem(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0.signList[arg_14_1]

	if not var_14_0 then
		local var_14_1 = arg_14_0.viewContainer:getSetting().otherRes.itemRes
		local var_14_2 = arg_14_0.viewContainer:getResInst(var_14_1, arg_14_0.signContent, string.format("item%s", arg_14_1))

		var_14_0 = MonoHelper.addNoUpdateLuaComOnceToGo(var_14_2, Activity186SignItem)

		var_14_0:initActId(arg_14_0.actId)

		arg_14_0.signList[arg_14_1] = var_14_0
	end

	return var_14_0
end

function var_0_0.refreshTask(arg_15_0)
	arg_15_0._waitRefreshTask = false

	local var_15_0 = arg_15_0.actMo.spBonusStage
	local var_15_1 = arg_15_0.spBonusStage and var_15_0 ~= arg_15_0.spBonusStage
	local var_15_2 = var_15_0 ~= 0
	local var_15_3 = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("act186_signview_task_txt"), var_15_2 and 1 or 0)

	arg_15_0.txtTaskDesc.text = var_15_3

	gohelper.setActive(arg_15_0.goTaskReceive, var_15_0 == 2)
	gohelper.setActive(arg_15_0.btnTaskCanget, var_15_0 == 1)

	if var_15_0 == 2 then
		if var_15_1 then
			arg_15_0.hasgetHookAnim:Play("go_hasget_in")
		else
			arg_15_0.hasgetHookAnim:Play("go_hasget_idle")
		end
	end

	arg_15_0.spBonusStage = var_15_0

	local var_15_4 = Activity186Config.instance:getConstStr(Activity186Enum.ConstId.Act101Reward)
	local var_15_5 = GameUtil.splitString2(var_15_4, true)[1]

	if not arg_15_0.itemIcon then
		arg_15_0.itemIcon = IconMgr.instance:getCommonPropItemIcon(arg_15_0.goTaskReward)
	end

	arg_15_0.itemIcon:setMOValue(var_15_5[1], var_15_5[2], var_15_5[3])
	arg_15_0.itemIcon:setScale(0.7)
	arg_15_0.itemIcon:setCountFontSize(46)
	arg_15_0.itemIcon:setHideLvAndBreakFlag(true)
	arg_15_0.itemIcon:hideEquipLvAndBreak(true)
end

function var_0_0.onClose(arg_16_0)
	return
end

function var_0_0.onDestroyView(arg_17_0)
	return
end

return var_0_0
