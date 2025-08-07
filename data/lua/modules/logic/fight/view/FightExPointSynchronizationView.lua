module("modules.logic.fight.view.FightExPointSynchronizationView", package.seeall)

local var_0_0 = class("FightExPointSynchronizationView", FightBaseView)

function var_0_0.onConstructor(arg_1_0, arg_1_1)
	arg_1_0.entityData = arg_1_1
	arg_1_0.entityId = arg_1_1.id

	arg_1_0:com_registMsg(FightMsgId.GetExPointView, arg_1_0.onGetExPointView)
end

function var_0_0.onInitView(arg_2_0)
	recthelper.setAnchorX(arg_2_0.viewGO.transform, 30)

	arg_2_0.preImg = gohelper.findChildImage(arg_2_0.viewGO, "root/go_pre")
	arg_2_0.preImg.fillAmount = 0
	arg_2_0.energyImg = gohelper.findChildImage(arg_2_0.viewGO, "root/go_energy")
	arg_2_0.animator = gohelper.onceAddComponent(arg_2_0.viewGO, typeof(UnityEngine.Animator))
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0:com_registMsg(FightMsgId.ShowAiJiAoExpointEffectBeforeUniqueSkill, arg_3_0.onShowAiJiAoExpointEffectBeforeUniqueSkill)
	arg_3_0:com_registFightEvent(FightEvent.OnExpointMaxAdd, arg_3_0.onExPointMaxAdd)
	arg_3_0:com_registFightEvent(FightEvent.OnExPointChange, arg_3_0.onExPointChange)
	arg_3_0:com_registFightEvent(FightEvent.UpdateExPoint, arg_3_0.onUpdateExPoint)
	arg_3_0:com_registFightEvent(FightEvent.CoverPerformanceEntityData, arg_3_0.onCoverPerformanceEntityData)

	arg_3_0.tweenComp = arg_3_0:addComponent(FightTweenComponent)
end

function var_0_0.removeEvents(arg_4_0)
	return
end

function var_0_0.onCoverPerformanceEntityData(arg_5_0, arg_5_1)
	if arg_5_1 ~= arg_5_0.entityId then
		return
	end

	arg_5_0:refreshSlider()
end

function var_0_0.onGetExPointView(arg_6_0, arg_6_1)
	if arg_6_1 == arg_6_0.entityId then
		arg_6_0:com_replyMsg(FightMsgId.GetExPointView, arg_6_0)
	end
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0:refreshSlider()
end

function var_0_0.onExPointChange(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if arg_8_1 ~= arg_8_0.entityId then
		return
	end

	local var_8_0, var_8_1 = arg_8_0:refreshSlider()

	if arg_8_2 < arg_8_3 and var_8_0 < var_8_1 then
		arg_8_0:playAni("add")
		AudioMgr.instance:trigger(20305031)
	end
end

function var_0_0.onUpdateExPoint(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if arg_9_1 ~= arg_9_0.entityId then
		return
	end

	arg_9_0:refreshSlider()
end

function var_0_0.onExPointMaxAdd(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 ~= arg_10_0.entityId then
		return
	end

	arg_10_0:refreshSlider()
end

function var_0_0.refreshSlider(arg_11_0)
	local var_11_0 = arg_11_0.entityData:getMaxExPoint()
	local var_11_1 = arg_11_0.entityData.exPoint
	local var_11_2 = var_11_1 / var_11_0

	arg_11_0.tweenComp:DOFillAmount(arg_11_0.energyImg, var_11_2, 0.2)

	if var_11_0 <= var_11_1 then
		if arg_11_0.curAniName ~= "max" then
			arg_11_0:playAni("max")
		end
	else
		arg_11_0:playAni("idle")
	end

	return var_11_1, var_11_0
end

function var_0_0.onShowAiJiAoExpointEffectBeforeUniqueSkill(arg_12_0, arg_12_1)
	if arg_12_1 ~= arg_12_0.entityId then
		return
	end

	arg_12_0.curAniName = "dazhao"

	FightMsgMgr.replyMsg(FightMsgId.ShowAiJiAoExpointEffectBeforeUniqueSkill, arg_12_0.viewGO)
end

function var_0_0.playAni(arg_13_0, arg_13_1)
	arg_13_0.curAniName = arg_13_1

	arg_13_0.animator:Play(arg_13_1, 0, 0)
end

function var_0_0.onClose(arg_14_0)
	return
end

function var_0_0.onDestroyView(arg_15_0)
	return
end

return var_0_0
