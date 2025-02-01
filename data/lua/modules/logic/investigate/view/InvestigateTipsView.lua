module("modules.logic.investigate.view.InvestigateTipsView", package.seeall)

slot0 = class("InvestigateTipsView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagewindowbg = gohelper.findChildSingleImage(slot0.viewGO, "root/#simage_windowbg")
	slot0._simagepic = gohelper.findChildSingleImage(slot0.viewGO, "root/#simage_pic")
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
	slot0._elementId = slot0.viewParam.elementId
	slot0._fragmentId = slot0.viewParam.fragmentId
	slot0._txtdec.text = lua_chapter_map_fragment.configDict[slot0._fragmentId].content

	if InvestigateConfig.instance:getInvestigateClueInfoByElement(slot0._elementId) then
		slot0._simagepic:LoadImage(slot2.mapRes)
	end

	DungeonController.instance:dispatchEvent(DungeonEvent.OnSetEpisodeListVisible, false)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Investigate.play_ui_molu_jlbn_open)
end

function slot0.onClose(slot0)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnSetEpisodeListVisible, true)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Investigate.play_ui_shuori_dreamsong_receive_open)
end

function slot0.onCloseFinish(slot0)
	InvestigateController.instance:dispatchEvent(InvestigateEvent.ShowGetEffect)
end

function slot0.onDestroyView(slot0)
end

return slot0
