module("modules.logic.versionactivity2_1.aergusi.view.AergusiFailView", package.seeall)

slot0 = class("AergusiFailView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._gofail = gohelper.findChild(slot0.viewGO, "#go_fail")
	slot0._txtclassnum = gohelper.findChildText(slot0.viewGO, "txtFbName/#txt_classnum")
	slot0._txtclassname = gohelper.findChildText(slot0.viewGO, "txtFbName/#txt_classname")
	slot0._btnquitgame = gohelper.findChildButtonWithAudio(slot0.viewGO, "btn/#btn_quitgame")
	slot0._btnrestart = gohelper.findChildButtonWithAudio(slot0.viewGO, "btn/#btn_restart")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnquitgame:AddClickListener(slot0._btnquitgameOnClick, slot0)
	slot0._btnrestart:AddClickListener(slot0._btnrestartOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btnquitgame:RemoveClickListener()
	slot0._btnrestart:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
end

function slot0._btnquitgameOnClick(slot0)
	slot0:closeThis()
	ViewMgr.instance:closeView(ViewName.AergusiDialogView)
end

function slot0._btnrestartOnClick(slot0)
	slot0:closeThis()
	ViewMgr.instance:closeView(ViewName.AergusiDialogView)
	AergusiController.instance:dispatchEvent(AergusiEvent.RestartEvidence)
end

function slot0._editableInitView(slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_settleaccounts_lose)
	slot0:refreshTips()
end

function slot0.refreshTips(slot0)
	slot0._txtclassnum.text = string.format("STAGE %02d", AergusiModel.instance:getEpisodeIndex(slot0.viewParam.episodeId))
	slot0._txtclassname.text = AergusiConfig.instance:getEpisodeConfig(nil, slot0.viewParam.episodeId).name
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._realRestart, slot0)
end

return slot0
