module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotFinishView", package.seeall)

slot0 = class("V1a6_CachotFinishView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagelevelbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_levelbg")
	slot0._txtsuccesstips = gohelper.findChildText(slot0.viewGO, "success/#txt_successtips")
	slot0._txtfailedtips = gohelper.findChildText(slot0.viewGO, "failed/#txt_failedtips")
	slot0._gosuccess = gohelper.findChild(slot0.viewGO, "#go_success")
	slot0._gofailed = gohelper.findChild(slot0.viewGO, "#go_failed")
	slot0._btnjump = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_jump")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnjump:AddClickListener(slot0._btnjumpOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnjump:RemoveClickListener()
end

function slot0._btnjumpOnClick(slot0)
	if slot0._isFinish then
		V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.OnFinishGame, slot0._rogueEndingInfo and slot0._rogueEndingInfo._ending)
	else
		slot0:_jump2ResultView()
	end

	slot0:closeThis()
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	NavigateMgr.instance:addEscape(ViewName.V1a6_CachotFinishView, slot0._btnjumpOnClick, slot0)
	RogueRpc.instance:sendRogueReadEndingRequest(V1a6_CachotEnum.ActivityId)

	slot0._rogueEndingInfo = V1a6_CachotModel.instance:getRogueEndingInfo()
	slot0._isFinish = false

	if slot0._rogueEndingInfo then
		slot0._isFinish = slot0._rogueEndingInfo._isFinish

		slot0._rogueEndingInfo:onEnterEndingFlow()
	end

	slot0:refreshUI()
	slot0:playAudioEffect()
end

function slot0.refreshUI(slot0)
	gohelper.setActive(slot0._gosuccess, slot0._isFinish)
	gohelper.setActive(slot0._gofailed, not slot0._isFinish)
end

function slot0._jump2ResultView(slot0)
	V1a6_CachotController.instance:openV1a6_CachotResultView()
end

function slot0.playAudioEffect(slot0)
	if slot0._isFinish then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_victory_open)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_fail_open)
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._rogueEndingInfo = nil
end

return slot0
