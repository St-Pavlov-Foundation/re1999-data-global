module("modules.logic.bossrush.view.v1a6.V1a6_BossRush_ResultAssess", package.seeall)

slot0 = class("V1a6_BossRush_ResultAssess", LuaCompBase)

function slot0.onInitView(slot0)
	slot0._go3s1 = gohelper.findChild(slot0.viewGO, "3s")
	slot0._go4s1 = gohelper.findChild(slot0.viewGO, "4s")
	slot0._gocomplete = gohelper.findChild(slot0.viewGO, "#go_complete")
	slot0._goassess = gohelper.findChild(slot0.viewGO, "#go_assess")
	slot0._imageAssessIcon = gohelper.findChild(slot0.viewGO, "#go_assess/#image_AssessIcon")
	slot0._go3s2 = gohelper.findChild(slot0._goassess, "3s")
	slot0._go4s2 = gohelper.findChild(slot0._goassess, "4s")
	slot0._gocommon = gohelper.findChild(slot0._goassess, "common")
	slot0._goimagecomplete = gohelper.findChild(slot0.viewGO, "#go_complete/image_CompleteBG")
	slot0._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(slot0.viewGO)
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._animationEvent = slot0.viewGO:GetComponent(gohelper.Type_AnimationEventWrap)
	slot0._animatorAssess = slot0._goassess:GetComponent(typeof(UnityEngine.Animator))

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEventListeners(slot0)
	slot0._animationEvent:AddEventListener(BossRushEnum.AnimEvtResultPanel.CompleteFinish, slot0._completeFinishCallback, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._animationEvent:RemoveEventListener(BossRushEnum.AnimEvtResultPanel.CompleteFinish)
end

function slot0._editableInitView(slot0)
	slot0.layer4Gos = slot0:getUserDataTb_()

	table.insert(slot0.layer4Gos, gohelper.findChild(slot0.viewGO, "Layer4"))
	table.insert(slot0.layer4Gos, gohelper.findChild(slot0._goassess, "Layer4"))
	table.insert(slot0.layer4Gos, gohelper.findChild(slot0._goassess, "commonLayer4"))
	table.insert(slot0.layer4Gos, gohelper.findChild(slot0.viewGO, "#go_complete/image_CompleteBGLayer4"))
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1

	slot0:onInitView()

	slot2 = BossRushModel.instance:isSpecialLayerCurBattle()

	gohelper.setActive(slot0._goimagecomplete, not slot2)
	gohelper.setActive(slot0._goimagecompleteLayer4, slot2)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mane_post_1_6_survey)
end

function slot0.playAnim(slot0, slot1, slot2, slot3)
	slot0._isEmpty = slot1
	slot0._callback = {
		callback = slot2,
		callbackObj = slot3
	}

	slot0._animatorPlayer:Play(BossRushEnum.V1a6_ResultAnimName.Open, slot0._openAnimCallback, slot0)
end

function slot0._openAnimCallback(slot0)
	if slot0._isEmpty then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mane_post_1_6_score)
	slot0._animatorPlayer:Play(BossRushEnum.V1a6_ResultAnimName.Close, slot0._closeAnimCallback, slot0)
	slot0._animatorAssess:Play(BossRushEnum.V1a6_ResultAnimName.Close)
end

function slot0._closeAnimCallback(slot0)
	if slot0._callback then
		slot0._callback.callback(slot0._callback.callbackObj)
	end
end

function slot0._completeFinishCallback(slot0)
	if slot0._isEmpty then
		slot0:_closeAnimCallback()
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mane_post_1_6_score)
		gohelper.setActive(slot0.viewGO, false)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mane_post_1_6_level)
	end
end

function slot0.setData(slot0, slot1, slot2, slot3, slot4, slot5)
	if slot4 then
		slot0._assessItem = MonoHelper.addNoUpdateLuaComOnceToGo(slot4:getResInst(BossRushEnum.ResPath.v1a4_bossrush_result_assess, slot0._imageAssessIcon.gameObject, "AssessIcon"), V1a6_BossRush_AssessIcon)

		slot0._assessItem:setData(slot1, slot2, slot5, true)
	end

	slot6 = BossRushEnum.ScoreLevel.S_AA < (slot3 or -1)

	gohelper.setActive(slot0._go4s1, not slot5 and slot6)
	gohelper.setActive(slot0._go4s2, not slot5 and slot6)
	gohelper.setActive(slot0._go3s1, not slot5 and not slot6)
	gohelper.setActive(slot0._go3s2, not slot5 and not slot6)
	gohelper.setActive(slot0._gocommon, not slot5)
end

function slot0.refreshLayerGo(slot0, slot1)
	for slot5, slot6 in pairs(slot0.layer4Gos) do
		gohelper.setActive(slot6, slot1)
	end
end

return slot0
