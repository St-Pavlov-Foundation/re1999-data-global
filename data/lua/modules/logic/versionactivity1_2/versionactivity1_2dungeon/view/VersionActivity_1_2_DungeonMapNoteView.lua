module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity_1_2_DungeonMapNoteView", package.seeall)

slot0 = class("VersionActivity_1_2_DungeonMapNoteView", BaseViewExtended)

function slot0.onInitView(slot0)
	slot0._simagebg1 = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_bg1")
	slot0._simagebg2 = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_bg2")
	slot0._simagebg3 = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_bg3")
	slot0._gopaper = gohelper.findChild(slot0.viewGO, "content/#go_paper")
	slot0._txtpapertitle = gohelper.findChildText(slot0.viewGO, "content/#go_paper/#txt_papertitle")
	slot0._txtpaperdesc = gohelper.findChildText(slot0.viewGO, "content/#go_paper/#txt_papertitle/#txt_paperdesc")
	slot0._gonotebook = gohelper.findChild(slot0.viewGO, "content/#go_notebook")
	slot0._btnclose = gohelper.getClick(slot0.viewGO)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0._editableInitView(slot0)
	slot0._simagebg1:LoadImage(ResUrl.getCommonIcon("full/bg_beijingzhezhao"))
	slot0._simagebg3:LoadImage(ResUrl.getYaXianImage("img_huode_bg"))
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	if slot0._closed then
		return
	end

	SLFramework.AnimatorPlayer.Get(slot0.viewGO):Play("close", slot0.closeThis, slot0)

	slot0._closed = true
end

function slot0.onOpen(slot0)
	slot0._closed = nil
	slot0._activityId = VersionActivityEnum.ActivityId.Act121
	slot2 = slot0.viewParam and slot0.viewParam.showPaper

	gohelper.setActive(slot0._gonotebook, slot0.viewParam and slot0.viewParam.showBook)
	gohelper.setActive(slot0._gopaper, slot2)

	if slot2 then
		slot3 = lua_activity121_note.configDict[slot0.viewParam.id][slot0._activityId]
		slot0._txtpapertitle.text = slot3.name
		slot0._txtpaperdesc.text = slot3.desc

		VersionActivity1_2NoteModel.instance:setNote(slot0.viewParam.id)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_lvhu_notebook_get)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_lvhu_clue_get)
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg1:UnLoadImage()
	slot0._simagebg3:UnLoadImage()
end

return slot0
