module("modules.logic.fight.view.FightNewProgressView6", package.seeall)

local var_0_0 = class("FightNewProgressView6", FightBaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.imgBgProgress = gohelper.findChildImage(arg_1_0.viewGO, "container/imgPre")
	arg_1_0.imgProgress = gohelper.findChildImage(arg_1_0.viewGO, "container/imgHp")
	arg_1_0.signRoot = gohelper.findChild(arg_1_0.viewGO, "container/imgHp/imgSignHpContainer")
	arg_1_0.signItem = gohelper.findChild(arg_1_0.viewGO, "container/imgHp/imgSignHpContainer/1")
	arg_1_0.animator = gohelper.findChildComponent(arg_1_0.viewGO, "container", typeof(UnityEngine.Animator))
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:com_registMsg(FightMsgId.NewProgressValueChange, arg_2_0.onNewProgressValueChange)
end

function var_0_0.onConstructor(arg_3_0, arg_3_1)
	arg_3_0.data = arg_3_1
	arg_3_0.id = arg_3_0.data.id
end

function var_0_0.onOpen(arg_4_0)
	local var_4_0 = OdysseyConfig.instance:getConstConfig(20)

	if var_4_0 then
		local var_4_1 = string.splitToNumber(var_4_0.value, "#")

		table.sort(var_4_1, var_0_0.sortSignList)

		arg_4_0.signDataList = var_4_1

		arg_4_0:com_createObjList(arg_4_0.onSignItemShow, var_4_1, arg_4_0.signRoot, arg_4_0.signItem)
	end

	local var_4_2 = arg_4_0.data.value / arg_4_0.data.max

	arg_4_0.imgProgress.fillAmount = var_4_2
	arg_4_0.imgBgProgress.fillAmount = var_4_2
end

function var_0_0.sortSignList(arg_5_0, arg_5_1)
	return arg_5_0 < arg_5_1
end

function var_0_0.onNewProgressValueChange(arg_6_0, arg_6_1)
	if arg_6_1 ~= arg_6_0.id then
		return
	end

	local var_6_0 = arg_6_0.data.value / arg_6_0.data.max
	local var_6_1 = arg_6_0:com_registFlowParallel()
	local var_6_2 = 0.2

	var_6_1:registWork(FightTweenWork, {
		type = "DOFillAmount",
		img = arg_6_0.imgProgress,
		to = var_6_0,
		t = var_6_2
	})

	local var_6_3 = var_6_1:registWork(FightWorkFlowSequence)

	var_6_3:registWork(FightWorkDelayTimer, 0.2)
	var_6_3:registWork(FightTweenWork, {
		type = "DOFillAmount",
		img = arg_6_0.imgBgProgress,
		to = var_6_0,
		t = var_6_2
	})
	var_6_3:registWork(FightWorkFunction, arg_6_0.refreshSignList, arg_6_0)
	FightMsgMgr.replyMsg(FightMsgId.NewProgressValueChange, var_6_1)
	arg_6_0.animator:Play("open", 0, 0)
end

function var_0_0.refreshSignList(arg_7_0)
	if arg_7_0.signDataList then
		arg_7_0:com_createObjList(arg_7_0.onSignItemShow, arg_7_0.signDataList, arg_7_0.signRoot, arg_7_0.signItem)
	end
end

function var_0_0.onSignItemShow(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = gohelper.findChild(arg_8_1, "finished")
	local var_8_1 = gohelper.findChild(arg_8_1, "unfinish")
	local var_8_2 = arg_8_2 >= arg_8_0.data.value

	gohelper.setActive(var_8_0, not var_8_2)
	gohelper.setActive(var_8_1, var_8_2)
end

return var_0_0
