module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotTipsView", package.seeall)

slot0 = class("V1a6_CachotTipsView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._txttips1 = gohelper.findChildTextMesh(slot0.viewGO, "#txt_tips1")
	slot0._txttips2 = gohelper.findChildTextMesh(slot0.viewGO, "#txt_tips2")
	slot0._goWin = gohelper.findChild(slot0.viewGO, "#win")
	slot0._goFail = gohelper.findChild(slot0.viewGO, "#fail")
end

function slot0.addEvents(slot0)
	slot0._btnClose:AddClickListener(slot0.closeThis, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnClose:RemoveClickListener()
end

function slot0.onOpen(slot0)
	slot2, slot3 = nil
	slot0._txttips1.text = ""
	slot0._txttips2.text = ""

	if (slot0.viewParam.style or V1a6_CachotEnum.TipStyle.Normal) == V1a6_CachotEnum.TipStyle.Normal then
		slot2 = slot0._txttips1
		slot3 = "v1a6_cachot_tipsbg2"

		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_popups_prompt)
	elseif slot1 == V1a6_CachotEnum.TipStyle.ChangeConclusion then
		slot2 = slot0._txttips2
		slot3 = "v1a6_cachot_tipsbg1"

		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_newendings_enter)
	end

	gohelper.setActive(slot0._goFail, slot1 == V1a6_CachotEnum.TipStyle.ChangeConclusion)
	gohelper.setActive(slot0._goWin, slot1 == V1a6_CachotEnum.TipStyle.Normal)

	if slot0.viewParam.strExtra then
		slot2.text = GameUtil.getSubPlaceholderLuaLang(slot0.viewParam.str, slot0.viewParam.strExtra)
	else
		slot2.text = slot0.viewParam.str
	end
end

function slot0.onClose(slot0)
	V1a6_CachotEventController.instance:setPause(false, V1a6_CachotEnum.EventPauseType.Tips)
end

return slot0
