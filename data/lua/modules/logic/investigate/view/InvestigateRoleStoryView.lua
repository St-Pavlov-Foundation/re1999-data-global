module("modules.logic.investigate.view.InvestigateRoleStoryView", package.seeall)

slot0 = class("InvestigateRoleStoryView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagefullbg = gohelper.findChildSingleImage(slot0.viewGO, "root/#simage_fullbg")
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "root/#txt_title")
	slot0._scrolldesc = gohelper.findChildScrollRect(slot0.viewGO, "root/#scroll_desc")
	slot0._txtdec = gohelper.findChildText(slot0.viewGO, "root/#scroll_desc/viewport/content/#txt_dec")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._id = slot0.viewParam
	slot0._config = lua_investigate_info.configDict[slot0._id]
	slot0._txttitle.text = slot0._config.desc
	slot0._txtdec.text = slot0._config.conclusionDesc

	slot0._simagefullbg:LoadImage(slot0._config.conclusionBg)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Investigate.play_ui_mln_unlock)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
