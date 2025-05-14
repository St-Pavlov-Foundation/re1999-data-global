module("modules.logic.versionactivity2_2.tianshinana.view.TianShiNaNaLevelView", package.seeall)

local var_0_0 = class("TianShiNaNaLevelView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnReset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_reset")
	arg_1_0._animTips = gohelper.findChild(arg_1_0.viewGO, "Top/Tips"):GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._txtRound = gohelper.findChildTextMesh(arg_1_0.viewGO, "Top/Tips/image_TipsBG/#txt_round")
	arg_1_0._sliderRound = gohelper.findChildSlider(arg_1_0.viewGO, "Top/Tips/image_TipsBG/#slider_round")
	arg_1_0._goTips2 = gohelper.findChild(arg_1_0.viewGO, "Top/Tips2")
	arg_1_0._txtTips2 = gohelper.findChildTextMesh(arg_1_0.viewGO, "Top/Tips2/image_TipsBG/#txt_Tips")
	arg_1_0._mainTarget = gohelper.findChild(arg_1_0.viewGO, "TargetList/mainTarget")
	arg_1_0._mainTargetDesc = gohelper.findChildTextMesh(arg_1_0.viewGO, "TargetList/mainTarget/#txt_TargetDesc")
	arg_1_0._mainTargetIcon = gohelper.findChild(arg_1_0.viewGO, "TargetList/mainTarget/#go_TargetIcon")
	arg_1_0._subTarget = gohelper.findChild(arg_1_0.viewGO, "TargetList/subTarget")
	arg_1_0._headTips = gohelper.findChild(arg_1_0.viewGO, "#go_HeadTips")
	arg_1_0._headTips1 = gohelper.findChild(arg_1_0.viewGO, "#go_HeadTips/1")
	arg_1_0._headTips2 = gohelper.findChild(arg_1_0.viewGO, "#go_HeadTips/2")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnReset:AddClickListener(arg_2_0._onResetClick, arg_2_0)
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.RoundUpdate, arg_2_0._refreshRound, arg_2_0)
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.ResetScene, arg_2_0._refreshRound, arg_2_0)
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.StatuChange, arg_2_0._onStatuChange, arg_2_0)
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.WaitClickJumpRound, arg_2_0._onClickJumpRound, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnReset:RemoveClickListener()
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.RoundUpdate, arg_3_0._refreshRound, arg_3_0)
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.ResetScene, arg_3_0._refreshRound, arg_3_0)
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.StatuChange, arg_3_0._onStatuChange, arg_3_0)
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.WaitClickJumpRound, arg_3_0._onClickJumpRound, arg_3_0)
end

function var_0_0.onOpen(arg_4_0)
	GuideModel.instance:setFlag(GuideModel.GuideFlag.MaskUseMainCamera, 1)

	arg_4_0._targetIcons = arg_4_0:getUserDataTb_()

	local var_4_0 = TianShiNaNaModel.instance.episodeCo
	local var_4_1 = string.split(var_4_0.conditionStr, "#")
	local var_4_2 = #var_4_1

	gohelper.setActive(arg_4_0._subTarget, false)

	if var_4_2 == 0 then
		gohelper.setActive(arg_4_0._mainTarget, false)
	elseif var_4_2 == 1 then
		gohelper.setActive(arg_4_0._mainTarget, true)
	else
		gohelper.setActive(arg_4_0._mainTarget, true)

		for iter_4_0 = 2, #var_4_1 do
			local var_4_3 = gohelper.cloneInPlace(arg_4_0._subTarget)

			gohelper.setActive(var_4_3, true)

			local var_4_4 = gohelper.findChildTextMesh(var_4_3, "#txt_TargetDesc")
			local var_4_5 = gohelper.findChild(var_4_3, "#go_TargetIcon")

			var_4_4.text = var_4_1[iter_4_0]
			arg_4_0._targetIcons[iter_4_0] = var_4_5

			ZProj.UGUIHelper.SetGrayFactor(var_4_5, 1)
		end
	end

	arg_4_0._mainTargetTxt = var_4_1[1] or ""
	arg_4_0._subTargetConditionTxts = string.split(var_4_0.subConditionStr, "|") or {}
	arg_4_0._subTargetConditions = GameUtil.splitString2(var_4_0.subCondition, true) or {}

	if not string.nilorempty(var_4_0.exStarCondition) then
		arg_4_0._conditions = GameUtil.splitString2(var_4_0.exStarCondition, true)
	else
		arg_4_0._conditions = {}
	end

	ZProj.UGUIHelper.SetGrayFactor(arg_4_0._mainTargetIcon, 1)
	arg_4_0:_refreshRound()
end

function var_0_0._refreshRound(arg_5_0)
	local var_5_0 = TianShiNaNaModel.instance.totalRound or 0
	local var_5_1 = var_5_0 - TianShiNaNaModel.instance.nowRound
	local var_5_2 = false

	if arg_5_0._nowRound and var_5_1 + 1 == arg_5_0._nowRound then
		var_5_2 = true
	end

	arg_5_0._nowRound = var_5_1
	arg_5_0._txtRound.text = string.format("<color=#e99b56>%d</color>/%d", var_5_1, var_5_0)

	arg_5_0._sliderRound:SetValue(var_5_1 / var_5_0)

	if TianShiNaNaModel.instance:isWaitClick() then
		arg_5_0._txtTips2.text = luaLang("act167_cantplace")

		gohelper.setActive(arg_5_0._goTips2, true)
		arg_5_0:setHeadTips(true)
	end

	arg_5_0:_refreshMainTarget()

	if var_5_2 then
		arg_5_0._animTips:Play("open", 0, 0)
	end
end

function var_0_0._refreshMainTarget(arg_6_0)
	local var_6_0 = 0

	for iter_6_0, iter_6_1 in ipairs(arg_6_0._subTargetConditions) do
		local var_6_1 = false

		for iter_6_2, iter_6_3 in ipairs(iter_6_1) do
			if TianShiNaNaModel.instance.unitMos[iter_6_3] then
				var_6_1 = true

				break
			end
		end

		if var_6_1 then
			var_6_0 = iter_6_0

			break
		end
	end

	if not arg_6_0._mainTargetProgress then
		-- block empty
	elseif arg_6_0._mainTargetProgress == var_6_0 then
		return
	elseif var_6_0 > arg_6_0._mainTargetProgress then
		-- block empty
	end

	arg_6_0._mainTargetProgress = var_6_0

	if var_6_0 == 0 then
		arg_6_0._mainTargetDesc.text = arg_6_0._mainTargetTxt
	else
		arg_6_0._mainTargetDesc.text = arg_6_0._subTargetConditionTxts[var_6_0]
	end
end

function var_0_0._onResetClick(arg_7_0)
	if TianShiNaNaHelper.isBanOper() then
		return
	end

	MessageBoxController.instance:showMsgBox(MessageBoxIdDefine.Act167Reset, MsgBoxEnum.BoxType.Yes_No, arg_7_0._sendReset, nil, nil, arg_7_0)
end

function var_0_0._sendReset(arg_8_0)
	Activity167Rpc.instance:sendAct167ReStartEpisodeRequest(VersionActivity2_2Enum.ActivityId.TianShiNaNa, TianShiNaNaModel.instance.episodeCo.id)
end

function var_0_0._onStatuChange(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_2 == TianShiNaNaEnum.CurState.SelectDir then
		arg_9_0._txtTips2.text = luaLang("act167_place")

		gohelper.setActive(arg_9_0._goTips2, true)
		arg_9_0:setHeadTips(true)
	elseif arg_9_2 == TianShiNaNaEnum.CurState.Rotate then
		arg_9_0._txtTips2.text = luaLang("act167_slide")

		gohelper.setActive(arg_9_0._goTips2, true)
		arg_9_0:setHeadTips(true)
	else
		arg_9_0:setHeadTips(false)
		gohelper.setActive(arg_9_0._goTips2, false)
	end
end

function var_0_0._onClickJumpRound(arg_10_0)
	arg_10_0:setHeadTips(false)
	gohelper.setActive(arg_10_0._goTips2, false)
end

function var_0_0.setHeadTips(arg_11_0, arg_11_1)
	if arg_11_1 then
		gohelper.setActive(arg_11_0._headTips, true)

		local var_11_0 = TianShiNaNaModel.instance:getNextCubeType()

		gohelper.setActive(arg_11_0._headTips1, var_11_0 == 2)
		gohelper.setActive(arg_11_0._headTips2, var_11_0 == 1)
	else
		gohelper.setActive(arg_11_0._headTips, false)
	end
end

function var_0_0.onClose(arg_12_0)
	GuideModel.instance:setFlag(GuideModel.GuideFlag.MaskUseMainCamera, nil)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2TianShiNaNa.stop_ui_youyu_foot)
	TianShiNaNaModel.instance:sendStat("主动中断")
end

return var_0_0
