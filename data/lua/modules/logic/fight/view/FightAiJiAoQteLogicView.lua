module("modules.logic.fight.view.FightAiJiAoQteLogicView", package.seeall)

local var_0_0 = class("FightAiJiAoQteLogicView", FightBaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.bowRoot = gohelper.findChild(arg_1_0.viewGO, "root/bow")
	arg_1_0.axeRoot = gohelper.findChild(arg_1_0.viewGO, "root/axe")
	arg_1_0.bowAnimator = gohelper.onceAddComponent(arg_1_0.bowRoot, typeof(UnityEngine.Animator))
	arg_1_0.axeAnimator = gohelper.onceAddComponent(arg_1_0.axeRoot, typeof(UnityEngine.Animator))
	arg_1_0.btnAxe = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "root/axe/btnAxe")
	arg_1_0.btnBow = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "root/bow/btnBow")
	arg_1_0.pointRoot = gohelper.findChild(arg_1_0.viewGO, "root/qte")
	arg_1_0.pointObj = gohelper.findChild(arg_1_0.viewGO, "root/qte/go_point")
	arg_1_0.axeUpRoot = gohelper.findChild(arg_1_0.viewGO, "root/axe/normal/go_canSelect")
	arg_1_0.bowUpRoot = gohelper.findChild(arg_1_0.viewGO, "root/bow/normal/go_canSelect")
	arg_1_0.bowClickEffect = gohelper.findChild(arg_1_0.viewGO, "root/bowClickEffect")
	arg_1_0.axeClickEffect = gohelper.findChild(arg_1_0.viewGO, "root/axeClickEffect")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:com_registClick(arg_2_0.btnAxe, arg_2_0.onAxeClick)
	arg_2_0:com_registClick(arg_2_0.btnBow, arg_2_0.onBowClick)
	arg_2_0:com_registFightEvent(FightEvent.EnterFightState, arg_2_0.onEnterFightState)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onBowClick(arg_4_0)
	arg_4_0:clickBtn(1)
end

function var_0_0.onAxeClick(arg_5_0)
	arg_5_0:clickBtn(2)
end

function var_0_0.clickBtn(arg_6_0, arg_6_1)
	if arg_6_0.clicked then
		return
	end

	AudioMgr.instance:trigger(20305035)

	arg_6_0.clicked = true

	FightRpc.instance:sendUseClothSkillRequest(arg_6_1, arg_6_0.fromId, arg_6_0.toId, FightEnum.ClothSkillType.EzioBigSkill)

	local var_6_0 = FightModel.instance:getUISpeed()
	local var_6_1 = arg_6_1 == 1 and arg_6_0.bowAnimator or arg_6_0.axeAnimator

	var_6_1.speed = var_6_0

	var_6_1:Play("click")
	gohelper.setActive(arg_6_0.bowClickEffect, arg_6_1 == 1)
	gohelper.setActive(arg_6_0.axeClickEffect, arg_6_1 == 2)

	if arg_6_0.objItem then
		local var_6_2 = gohelper.onceAddComponent(arg_6_0.objItem, typeof(UnityEngine.Animator))

		var_6_2.speed = var_6_0

		var_6_2:Play("close")
	end

	local var_6_3 = arg_6_0:com_registFlowSequence()

	var_6_3:registWork(FightWorkPlayAnimator, arg_6_0.viewGO, "close", var_6_0)
	var_6_3:registWork(FightWorkFunction, arg_6_0.afterCloseAni, arg_6_0, arg_6_1)
	var_6_3:start()
end

function var_0_0.afterCloseAni(arg_7_0)
	arg_7_0.PARENT_VIEW:closeThis()
end

function var_0_0.onEnterFightState(arg_8_0, arg_8_1)
	if arg_8_1 == FightStageMgr.FightStateType.Auto then
		arg_8_0:checkAuto()
	end
end

function var_0_0.checkAuto(arg_9_0)
	local var_9_0 = FightDataModel.instance.aiJiAoAutoSequenceForGM

	if var_9_0 then
		local var_9_1 = var_9_0.autoSequence

		if var_9_1 and #var_9_1 > 0 then
			local var_9_2 = var_9_0.index + 1

			if not var_9_1[var_9_2] then
				var_9_2 = 1
			end

			var_9_0.index = var_9_2

			local var_9_3 = var_9_1[var_9_2]

			arg_9_0:clickBtn(var_9_3)

			return
		end
	end

	local var_9_4 = arg_9_0.toId
	local var_9_5 = FightDataHelper.entityMgr:getById(var_9_4)

	if var_9_5 then
		if var_9_5.currentHp / var_9_5.attrMO.hp >= 0.5 then
			arg_9_0:clickBtn(2)
		else
			arg_9_0:clickBtn(1)
		end
	end
end

function var_0_0.onConstructor(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.fromId = arg_10_1
	arg_10_0.toId = arg_10_2
end

function var_0_0.onOpen(arg_11_0)
	local var_11_0 = (FightDataHelper.tempMgr.aiJiAoQteCount or 0) + 2

	arg_11_0.objItem = nil

	arg_11_0:com_createObjList(arg_11_0.onItemShow, var_11_0, arg_11_0.pointRoot, arg_11_0.pointObj)

	local var_11_1 = arg_11_0.toId
	local var_11_2 = FightDataHelper.entityMgr:getById(var_11_1)

	if var_11_2 then
		local var_11_3 = var_11_2.currentHp / var_11_2.attrMO.hp >= 0.5

		gohelper.setActive(arg_11_0.bowUpRoot, not var_11_3)
		gohelper.setActive(arg_11_0.axeUpRoot, var_11_3)
	end

	if FightDataHelper.stageMgr:inAutoFightState() then
		arg_11_0:checkAuto()
	end
end

function var_0_0.onItemShow(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if arg_12_3 > 2 then
		arg_12_0.objItem = arg_12_1
	end
end

function var_0_0.onClose(arg_13_0)
	return
end

function var_0_0.onDestroyView(arg_14_0)
	return
end

return var_0_0
