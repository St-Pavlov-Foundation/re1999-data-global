module("modules.logic.versionactivity2_2.tianshinana.view.TianShiNaNaLevelView", package.seeall)

slot0 = class("TianShiNaNaLevelView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnReset = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_reset")
	slot0._animTips = gohelper.findChild(slot0.viewGO, "Top/Tips"):GetComponent(typeof(UnityEngine.Animator))
	slot0._txtRound = gohelper.findChildTextMesh(slot0.viewGO, "Top/Tips/image_TipsBG/#txt_round")
	slot0._sliderRound = gohelper.findChildSlider(slot0.viewGO, "Top/Tips/image_TipsBG/#slider_round")
	slot0._goTips2 = gohelper.findChild(slot0.viewGO, "Top/Tips2")
	slot0._txtTips2 = gohelper.findChildTextMesh(slot0.viewGO, "Top/Tips2/image_TipsBG/#txt_Tips")
	slot0._mainTarget = gohelper.findChild(slot0.viewGO, "TargetList/mainTarget")
	slot0._mainTargetDesc = gohelper.findChildTextMesh(slot0.viewGO, "TargetList/mainTarget/#txt_TargetDesc")
	slot0._mainTargetIcon = gohelper.findChild(slot0.viewGO, "TargetList/mainTarget/#go_TargetIcon")
	slot0._subTarget = gohelper.findChild(slot0.viewGO, "TargetList/subTarget")
	slot0._headTips = gohelper.findChild(slot0.viewGO, "#go_HeadTips")
	slot0._headTips1 = gohelper.findChild(slot0.viewGO, "#go_HeadTips/1")
	slot0._headTips2 = gohelper.findChild(slot0.viewGO, "#go_HeadTips/2")
end

function slot0.addEvents(slot0)
	slot0._btnReset:AddClickListener(slot0._onResetClick, slot0)
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.RoundUpdate, slot0._refreshRound, slot0)
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.ResetScene, slot0._refreshRound, slot0)
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.StatuChange, slot0._onStatuChange, slot0)
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.WaitClickJumpRound, slot0._onClickJumpRound, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnReset:RemoveClickListener()
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.RoundUpdate, slot0._refreshRound, slot0)
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.ResetScene, slot0._refreshRound, slot0)
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.StatuChange, slot0._onStatuChange, slot0)
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.WaitClickJumpRound, slot0._onClickJumpRound, slot0)
end

function slot0.onOpen(slot0)
	GuideModel.instance:setFlag(GuideModel.GuideFlag.MaskUseMainCamera, 1)

	slot0._targetIcons = slot0:getUserDataTb_()

	gohelper.setActive(slot0._subTarget, false)

	if #string.split(TianShiNaNaModel.instance.episodeCo.conditionStr, "#") == 0 then
		gohelper.setActive(slot0._mainTarget, false)
	elseif slot3 == 1 then
		gohelper.setActive(slot0._mainTarget, true)
	else
		gohelper.setActive(slot0._mainTarget, true)

		for slot7 = 2, #slot2 do
			slot8 = gohelper.cloneInPlace(slot0._subTarget)

			gohelper.setActive(slot8, true)

			slot10 = gohelper.findChild(slot8, "#go_TargetIcon")
			gohelper.findChildTextMesh(slot8, "#txt_TargetDesc").text = slot2[slot7]
			slot0._targetIcons[slot7] = slot10

			ZProj.UGUIHelper.SetGrayFactor(slot10, 1)
		end
	end

	slot0._mainTargetTxt = slot2[1] or ""
	slot0._subTargetConditionTxts = string.split(slot1.subConditionStr, "|") or {}
	slot0._subTargetConditions = GameUtil.splitString2(slot1.subCondition, true) or {}

	if not string.nilorempty(slot1.exStarCondition) then
		slot0._conditions = GameUtil.splitString2(slot1.exStarCondition, true)
	else
		slot0._conditions = {}
	end

	ZProj.UGUIHelper.SetGrayFactor(slot0._mainTargetIcon, 1)
	slot0:_refreshRound()
end

function slot0._refreshRound(slot0)
	slot2 = (TianShiNaNaModel.instance.totalRound or 0) - TianShiNaNaModel.instance.nowRound
	slot3 = false

	if slot0._nowRound and slot2 + 1 == slot0._nowRound then
		slot3 = true
	end

	slot0._nowRound = slot2
	slot0._txtRound.text = string.format("<color=#e99b56>%d</color>/%d", slot2, slot1)

	slot0._sliderRound:SetValue(slot2 / slot1)

	if TianShiNaNaModel.instance:isWaitClick() then
		slot0._txtTips2.text = luaLang("act167_cantplace")

		gohelper.setActive(slot0._goTips2, true)
		slot0:setHeadTips(true)
	end

	slot0:_refreshMainTarget()

	if slot3 then
		slot0._animTips:Play("open", 0, 0)
	end
end

function slot0._refreshMainTarget(slot0)
	slot1 = 0

	for slot5, slot6 in ipairs(slot0._subTargetConditions) do
		slot7 = false

		for slot11, slot12 in ipairs(slot6) do
			if TianShiNaNaModel.instance.unitMos[slot12] then
				slot7 = true

				break
			end
		end

		if slot7 then
			slot1 = slot5

			break
		end
	end

	if not slot0._mainTargetProgress then
		-- Nothing
	elseif slot0._mainTargetProgress == slot1 then
		return
	elseif slot0._mainTargetProgress < slot1 then
		-- Nothing
	end

	slot0._mainTargetProgress = slot1

	if slot1 == 0 then
		slot0._mainTargetDesc.text = slot0._mainTargetTxt
	else
		slot0._mainTargetDesc.text = slot0._subTargetConditionTxts[slot1]
	end
end

function slot0._onResetClick(slot0)
	if TianShiNaNaHelper.isBanOper() then
		return
	end

	MessageBoxController.instance:showMsgBox(MessageBoxIdDefine.Act167Reset, MsgBoxEnum.BoxType.Yes_No, slot0._sendReset, nil, , slot0)
end

function slot0._sendReset(slot0)
	Activity167Rpc.instance:sendAct167ReStartEpisodeRequest(VersionActivity2_2Enum.ActivityId.TianShiNaNa, TianShiNaNaModel.instance.episodeCo.id)
end

function slot0._onStatuChange(slot0, slot1, slot2)
	if slot2 == TianShiNaNaEnum.CurState.SelectDir then
		slot0._txtTips2.text = luaLang("act167_place")

		gohelper.setActive(slot0._goTips2, true)
		slot0:setHeadTips(true)
	elseif slot2 == TianShiNaNaEnum.CurState.Rotate then
		slot0._txtTips2.text = luaLang("act167_slide")

		gohelper.setActive(slot0._goTips2, true)
		slot0:setHeadTips(true)
	else
		slot0:setHeadTips(false)
		gohelper.setActive(slot0._goTips2, false)
	end
end

function slot0._onClickJumpRound(slot0)
	slot0:setHeadTips(false)
	gohelper.setActive(slot0._goTips2, false)
end

function slot0.setHeadTips(slot0, slot1)
	if slot1 then
		gohelper.setActive(slot0._headTips, true)
		gohelper.setActive(slot0._headTips1, TianShiNaNaModel.instance:getNextCubeType() == 2)
		gohelper.setActive(slot0._headTips2, slot2 == 1)
	else
		gohelper.setActive(slot0._headTips, false)
	end
end

function slot0.onClose(slot0)
	GuideModel.instance:setFlag(GuideModel.GuideFlag.MaskUseMainCamera, nil)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2TianShiNaNa.stop_ui_youyu_foot)
	TianShiNaNaModel.instance:sendStat("主动中断")
end

return slot0
