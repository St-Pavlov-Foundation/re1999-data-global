module("modules.logic.versionactivity2_5.act186.view.Activity186TaskItem", package.seeall)

local var_0_0 = class("Activity186TaskItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.txtIndex = gohelper.findChildTextMesh(arg_1_0.viewGO, "txtIndex")
	arg_1_0.txtDesc = gohelper.findChildTextMesh(arg_1_0.viewGO, "txtDesc")
	arg_1_0.goReward = gohelper.findChild(arg_1_0.viewGO, "#go_reward")
	arg_1_0.txtNum = gohelper.findChildTextMesh(arg_1_0.goReward, "#txt_num")
	arg_1_0.btnCanget = gohelper.findChildButtonWithAudio(arg_1_0.goReward, "go_canget")
	arg_1_0.goReceive = gohelper.findChild(arg_1_0.goReward, "go_receive")
	arg_1_0.btnJump = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btnJump")
	arg_1_0.goDoing = gohelper.findChild(arg_1_0.viewGO, "goDoing")
	arg_1_0.goLightBg = gohelper.findChild(arg_1_0.goReward, "go_lightbg")
	arg_1_0.anim = arg_1_0.viewGO:GetComponent(gohelper.Type_Animator)
	arg_1_0.isOpen = true

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0.btnCanget:AddClickListener(arg_2_0.onClickBtnCanget, arg_2_0)
	arg_2_0.btnJump:AddClickListener(arg_2_0.onClickBtnJump, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0.btnCanget:RemoveClickListener()
	arg_3_0.btnJump:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onClickBtnCanget(arg_5_0)
	if not arg_5_0._mo then
		return
	end

	if not arg_5_0._mo.canGetReward then
		return
	end

	local var_5_0 = arg_5_0._mo.config

	if arg_5_0._mo.isGlobalTask then
		TaskRpc.instance:sendFinishTaskRequest(var_5_0.id)
	else
		Activity186Rpc.instance:sendFinishAct186TaskRequest(var_5_0.activityId, var_5_0.id)
	end
end

function var_0_0.onClickBtnJump(arg_6_0)
	if not arg_6_0._mo then
		return
	end

	local var_6_0 = arg_6_0._mo.config.jumpId

	if var_6_0 and var_6_0 ~= 0 then
		GameFacade.jump(var_6_0)
	end
end

function var_0_0.onUpdateMO(arg_7_0, arg_7_1)
	arg_7_0._mo = arg_7_1
	arg_7_0.config = arg_7_0._mo.config

	arg_7_0:refreshDesc()
	arg_7_0:refreshJump()
	arg_7_0:refreshReward()

	if arg_7_0.isOpen then
		arg_7_0.anim:Play("open", 0, 0)
	else
		arg_7_0.anim:Play("open", 0, 1)
	end

	arg_7_0.isOpen = false
end

function var_0_0.refreshDesc(arg_8_0)
	arg_8_0.txtIndex.text = tostring(arg_8_0._mo.index)

	local var_8_0 = Activity173Controller.numberDisplay(arg_8_0._mo.progress)
	local var_8_1 = Activity173Controller.numberDisplay(arg_8_0.config and arg_8_0.config.maxProgress or 0)

	arg_8_0.txtDesc.text = string.format("%s\n(%s/%s)", arg_8_0.config and arg_8_0.config.desc or "", var_8_0, var_8_1)
end

function var_0_0.refreshJump(arg_9_0)
	local var_9_0 = arg_9_0._mo.canGetReward
	local var_9_1 = arg_9_0._mo.hasGetBonus

	gohelper.setActive(arg_9_0.btnCanget, var_9_0)
	gohelper.setActive(arg_9_0.goLightBg, var_9_0)
	gohelper.setActive(arg_9_0.goReceive, var_9_1)

	local var_9_2 = arg_9_0._mo.config.jumpId
	local var_9_3 = var_9_2 and var_9_2 ~= 0 and not var_9_0 and not var_9_1

	gohelper.setActive(arg_9_0.btnJump, var_9_3)

	local var_9_4 = not var_9_0 and not var_9_1 and not var_9_3

	gohelper.setActive(arg_9_0.goDoing, var_9_4)
end

function var_0_0.refreshReward(arg_10_0)
	local var_10_0 = (GameUtil.splitString2(arg_10_0.config and arg_10_0.config.bonus, true) or {})[1]

	arg_10_0.txtNum.text = string.format("×%s", var_10_0 and var_10_0[3] or 0)
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0
