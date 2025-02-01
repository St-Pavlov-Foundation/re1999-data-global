module("modules.logic.explore.view.ExploreFinishView", package.seeall)

slot0 = class("ExploreFinishView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButton(slot0.viewGO, "#btn_close")
	slot0._gohorizontal = gohelper.findChild(slot0.viewGO, "center/progressbar/content")
	slot0._txtchapter = gohelper.findChildTextMesh(slot0.viewGO, "center/bg/#txt_chaptername")
	slot0._txtchapterEn = gohelper.findChildTextMesh(slot0.viewGO, "center/bg/#txt_chapternameen")
	slot0._goitem = gohelper.findChild(slot0.viewGO, "center/progressbar/content/#go_item")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0.closeThis, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
end

function slot0._editableInitView(slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.ChessGame.PlayerArrive)

	slot1 = ExploreModel.instance:getMapId()
	slot3 = DungeonConfig.instance:getEpisodeCO(ExploreConfig.instance:getMapIdConfig(slot1).episodeId)
	slot0._txtchapter.text = slot3.name
	slot0._txtchapterEn.text = slot3.name_En
	slot4, slot5, slot6, slot7, slot8, slot9 = ExploreSimpleModel.instance:getCoinCountByMapId(slot1)

	gohelper.CreateObjList(slot0, slot0.setItem, {
		{
			slot6,
			slot9,
			"dungeon_secretroom_btn_triangle"
		},
		{
			slot5,
			slot8,
			"dungeon_secretroom_btn_sandglass"
		},
		{
			slot4,
			slot7,
			"dungeon_secretroom_btn_box"
		}
	}, slot0._gohorizontal, slot0._goitem)
end

function slot0.setItem(slot0, slot1, slot2, slot3)
	slot7 = slot2[1] == slot2[2]

	UISpriteSetMgr.instance:setExploreSprite(gohelper.findChildImage(slot1, "bg2"), slot7 and "dungeon_secretroom_img_full" or "dungeon_secretroom_img_unfull")
	UISpriteSetMgr.instance:setExploreSprite(gohelper.findChildImage(slot1, "bg2/image_icon"), slot2[3] .. (slot7 and "1" or "2"))

	gohelper.findChildTextMesh(slot1, "txt_progress").text = string.format("<color=#%s>%d/%d", slot7 and "E0BB6D" or "D5D4BC", slot2[1], slot2[2])
end

function slot0.onClose(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_feedback_close)
	ExploreController.instance:exit()
end

return slot0
