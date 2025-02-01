module("modules.logic.versionactivity1_5.sportsnews.view.SportsNewsPaperView", package.seeall)

slot0 = class("SportsNewsPaperView", BaseView)

function slot0.onInitView(slot0)
	slot0._txtcontent = gohelper.findChildText(slot0.viewGO, "#txt_content")
	slot0._btnstartbtn = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_startbtn")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnstartbtn:AddClickListener(slot0._btnstartbtnOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnstartbtn:RemoveClickListener()
end

function slot0._btnstartbtnOnClick(slot0)
	PlayerPrefsHelper.setString(SportsNewsModel.instance:getFirstHelpKey(slot0.viewParam.actId), "watched")
	slot0:closeThis()
	HelpController.instance:showHelp(HelpEnum.HelpId.SportsNews)
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
end

function slot0.onClose(slot0)
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

function slot0.onDestroyView(slot0)
end

return slot0
