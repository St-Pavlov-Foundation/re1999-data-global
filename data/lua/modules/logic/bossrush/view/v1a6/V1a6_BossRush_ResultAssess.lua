module("modules.logic.bossrush.view.v1a6.V1a6_BossRush_ResultAssess", package.seeall)

local var_0_0 = class("V1a6_BossRush_ResultAssess", LuaCompBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._go3s1 = gohelper.findChild(arg_1_0.viewGO, "3s")
	arg_1_0._go4s1 = gohelper.findChild(arg_1_0.viewGO, "4s")
	arg_1_0._gocomplete = gohelper.findChild(arg_1_0.viewGO, "#go_complete")
	arg_1_0._goassess = gohelper.findChild(arg_1_0.viewGO, "#go_assess")
	arg_1_0._imageAssessIcon = gohelper.findChild(arg_1_0.viewGO, "#go_assess/#image_AssessIcon")
	arg_1_0._go3s2 = gohelper.findChild(arg_1_0._goassess, "3s")
	arg_1_0._go4s2 = gohelper.findChild(arg_1_0._goassess, "4s")
	arg_1_0._gocommon = gohelper.findChild(arg_1_0._goassess, "common")
	arg_1_0._goimagecomplete = gohelper.findChild(arg_1_0.viewGO, "#go_complete/image_CompleteBG")
	arg_1_0._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_1_0.viewGO)
	arg_1_0._animator = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._animationEvent = arg_1_0.viewGO:GetComponent(gohelper.Type_AnimationEventWrap)
	arg_1_0._animatorAssess = arg_1_0._goassess:GetComponent(typeof(UnityEngine.Animator))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._animationEvent:AddEventListener(BossRushEnum.AnimEvtResultPanel.CompleteFinish, arg_2_0._completeFinishCallback, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._animationEvent:RemoveEventListener(BossRushEnum.AnimEvtResultPanel.CompleteFinish)
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0.layer4Gos = arg_4_0:getUserDataTb_()

	table.insert(arg_4_0.layer4Gos, gohelper.findChild(arg_4_0.viewGO, "Layer4"))
	table.insert(arg_4_0.layer4Gos, gohelper.findChild(arg_4_0._goassess, "Layer4"))
	table.insert(arg_4_0.layer4Gos, gohelper.findChild(arg_4_0._goassess, "commonLayer4"))
	table.insert(arg_4_0.layer4Gos, gohelper.findChild(arg_4_0.viewGO, "#go_complete/image_CompleteBGLayer4"))
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	return
end

function var_0_0.onClose(arg_7_0)
	return
end

function var_0_0.onDestroyView(arg_8_0)
	return
end

function var_0_0.init(arg_9_0, arg_9_1)
	arg_9_0.viewGO = arg_9_1

	arg_9_0:onInitView()

	local var_9_0 = BossRushModel.instance:isSpecialLayerCurBattle()

	gohelper.setActive(arg_9_0._goimagecomplete, not var_9_0)
	gohelper.setActive(arg_9_0._goimagecompleteLayer4, var_9_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mane_post_1_6_survey)
end

function var_0_0.playAnim(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	arg_10_0._isEmpty = arg_10_1
	arg_10_0._callback = {
		callback = arg_10_2,
		callbackObj = arg_10_3
	}

	arg_10_0._animatorPlayer:Play(BossRushEnum.V1a6_ResultAnimName.Open, arg_10_0._openAnimCallback, arg_10_0)
end

function var_0_0._openAnimCallback(arg_11_0)
	if arg_11_0._isEmpty then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mane_post_1_6_score)
	arg_11_0._animatorPlayer:Play(BossRushEnum.V1a6_ResultAnimName.Close, arg_11_0._closeAnimCallback, arg_11_0)
	arg_11_0._animatorAssess:Play(BossRushEnum.V1a6_ResultAnimName.Close)
end

function var_0_0._closeAnimCallback(arg_12_0)
	if arg_12_0._callback then
		arg_12_0._callback.callback(arg_12_0._callback.callbackObj)
	end
end

function var_0_0._completeFinishCallback(arg_13_0)
	if arg_13_0._isEmpty then
		arg_13_0:_closeAnimCallback()
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mane_post_1_6_score)
		gohelper.setActive(arg_13_0.viewGO, false)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mane_post_1_6_level)
	end
end

function var_0_0.setData(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4, arg_14_5)
	if arg_14_4 then
		local var_14_0 = BossRushEnum.ResPath.v1a4_bossrush_result_assess
		local var_14_1 = arg_14_4:getResInst(var_14_0, arg_14_0._imageAssessIcon.gameObject, "AssessIcon")

		arg_14_0._assessItem = MonoHelper.addNoUpdateLuaComOnceToGo(var_14_1, V1a6_BossRush_AssessIcon)

		arg_14_0._assessItem:setData(arg_14_1, arg_14_2, arg_14_5, true)
	end

	arg_14_3 = arg_14_3 or -1

	local var_14_2 = arg_14_3 > BossRushEnum.ScoreLevel.S_AA

	gohelper.setActive(arg_14_0._go4s1, not arg_14_5 and var_14_2)
	gohelper.setActive(arg_14_0._go4s2, not arg_14_5 and var_14_2)
	gohelper.setActive(arg_14_0._go3s1, not arg_14_5 and not var_14_2)
	gohelper.setActive(arg_14_0._go3s2, not arg_14_5 and not var_14_2)
	gohelper.setActive(arg_14_0._gocommon, not arg_14_5)
end

function var_0_0.refreshLayerGo(arg_15_0, arg_15_1)
	for iter_15_0, iter_15_1 in pairs(arg_15_0.layer4Gos) do
		gohelper.setActive(iter_15_1, arg_15_1)
	end
end

return var_0_0
