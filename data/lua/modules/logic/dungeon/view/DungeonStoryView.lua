module("modules.logic.dungeon.view.DungeonStoryView", package.seeall)

slot0 = class("DungeonStoryView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnback = gohelper.findChildButtonWithAudio(slot0.viewGO, "top_left/#btn_back")
	slot0._btnplay = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_play")
	slot0._txtchapter = gohelper.findChildText(slot0.viewGO, "#txt_chapter")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#txt_name")
	slot0._txtnameen = gohelper.findChildText(slot0.viewGO, "#txt_nameen")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "#txt_desc")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnback:AddClickListener(slot0._btnbackOnClick, slot0)
	slot0._btnplay:AddClickListener(slot0._btnplayOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnback:RemoveClickListener()
	slot0._btnplay:RemoveClickListener()
end

function slot0._btnbackOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnplayOnClick(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._txtchapter.text = ""
	slot0._txtname.text = slot0.viewParam.name
	slot0._txtdesc.text = slot0.viewParam.desc
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
