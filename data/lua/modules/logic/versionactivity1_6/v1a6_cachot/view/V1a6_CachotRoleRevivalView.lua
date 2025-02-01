module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotRoleRevivalView", package.seeall)

slot0 = class("V1a6_CachotRoleRevivalView", BaseView)

function slot0.onInitView(slot0)
	slot0._gotipswindow = gohelper.findChild(slot0.viewGO, "#go_tipswindow")
	slot0._gopreparecontent = gohelper.findChild(slot0.viewGO, "#go_tipswindow/scroll_view/Viewport/#go_preparecontent")
	slot0._gostart = gohelper.findChild(slot0.viewGO, "#go_tipswindow/#go_start")
	slot0._btnstart = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_tipswindow/#go_start/#btn_start")
	slot0._gostartlight = gohelper.findChild(slot0.viewGO, "#go_tipswindow/#go_start/#btn_start/#go_startlight")
	slot0._simagetitle = gohelper.findChildSingleImage(slot0.viewGO, "#simage_title")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnstart:AddClickListener(slot0._btnstartOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnstart:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
end

function slot0._btnstartOnClick(slot0)
	if not slot0._selectedMo or not slot0._selectedMo:getHeroMO() then
		GameFacade.showToast(ToastEnum.V1a6CachotToast11)

		return
	end

	RogueRpc.instance:sendRogueEventSelectRequest(V1a6_CachotEnum.ActivityId, slot0.viewParam.eventId, slot0._selectedMo:getHeroMO().heroId, slot0._onSelectEnd, slot0)
end

function slot0._onSelectEnd(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_easter_success)
	V1a6_CachotController.instance:openV1a6_CachotTipsView({
		str = formatLuaLang("cachot_revival", slot0._selectedMo:getHeroMO().config.name),
		style = V1a6_CachotEnum.TipStyle.Normal
	})
end

function slot0._btncloseOnClick(slot0)
	RogueRpc.instance:sendRogueEventEndRequest(V1a6_CachotEnum.ActivityId, slot0.viewParam.eventId, slot0.closeThis, slot0)
end

function slot0._editableInitView(slot0)
	V1a6_CachotRoleRevivalPrepareListModel.instance:initList()
	gohelper.setActive(slot0._gostartlight, false)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(V1a6_CachotController.instance, V1a6_CachotEvent.OnClickTeamItem, slot0._onClickTeamItem, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
end

function slot0._onCloseView(slot0, slot1)
	if slot1 == ViewName.V1a6_CachotRoleRevivalResultView or slot1 == ViewName.V1a6_CachotTipsView then
		slot0:closeThis()
	end
end

function slot0._onClickTeamItem(slot0, slot1)
	slot0._selectedMo = slot1

	gohelper.setActive(slot0._gostartlight, true)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
