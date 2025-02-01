module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotEndingView", package.seeall)

slot0 = class("V1a6_CachotEndingView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagelevelbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_levelbg")
	slot0._simagecg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_cg")
	slot0._txten = gohelper.findChildText(slot0.viewGO, "#txt_en")
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "#txt_title")
	slot0._txttips = gohelper.findChildText(slot0.viewGO, "#txt_tips")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")

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
	V1a6_CachotController.instance:openV1a6_CachotResultView()
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	NavigateMgr.instance:addEscape(ViewName.V1a6_CachotEndingView, slot0._btncloseOnClick, slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_finale_get)
	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	if lua_rogue_ending.configDict[V1a6_CachotModel.instance:getRogueEndingInfo() and slot1._ending] then
		slot0._txttitle.text = tostring(slot3.title)
		slot0._txttips.text = tostring(slot3.endingDesc)

		slot0._simagecg:LoadImage(ResUrl.getV1a6CachotIcon(slot3.endingIcon))
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
