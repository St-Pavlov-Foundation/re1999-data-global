module("modules.logic.explore.view.ExploreEnterView", package.seeall)

slot0 = class("ExploreEnterView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButton(slot0.viewGO, "#btn_close")
	slot0._txtnamecn = gohelper.findChildTextMesh(slot0.viewGO, "center/#txt_namecn")
	slot0._imagenum = gohelper.findChildImage(slot0.viewGO, "center/bg/#image_num")
	slot0._txtlevelname = gohelper.findChildTextMesh(slot0.viewGO, "center/bg/#txt_levelname")
	slot0._gohorizontal = gohelper.findChild(slot0.viewGO, "center/progressbar/horizontal")
	slot0._goitem = gohelper.findChild(slot0.viewGO, "center/progressbar/horizontal/#go_item")

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
	AudioMgr.instance:trigger(AudioEnum.Va3Aact120.play_ui_molu_jlbn_level_unlock)

	slot4 = 1

	for slot8, slot9 in ipairs(DungeonConfig.instance:getExploreChapterList()) do
		if slot9.id == ExploreConfig.instance:getMapIdConfig(ExploreModel.instance:getMapId()).chapterId then
			slot4 = slot8

			break
		end
	end

	slot7 = nil
	slot0._txtnamecn.text = (GameUtil.utf8len(slot3[slot4].name) < 2 or string.format("<size=50>%s</size>%s<size=50>%s</size>", GameUtil.utf8sub(slot5, 1, 1), GameUtil.utf8sub(slot5, 2, slot6 - 2), GameUtil.utf8sub(slot5, slot6, 1))) and "<size=50>" .. slot5
	slot9 = 1

	for slot13, slot14 in ipairs(DungeonConfig.instance:getChapterEpisodeCOList(slot3[slot4].id)) do
		if slot14.id == slot2.episodeId then
			slot9 = slot13

			break
		end
	end

	UISpriteSetMgr.instance:setExploreSprite(slot0._imagenum, "dungeon_secretroom_num_" .. slot9)

	slot0._txtlevelname.text = slot8[slot9].name
	slot10, slot11, slot12, slot13, slot14, slot15 = ExploreSimpleModel.instance:getCoinCountByMapId(slot1)

	gohelper.CreateObjList(slot0, slot0.setItem, {
		{
			slot12,
			slot15,
			"dungeon_secretroom_btn_triangle"
		},
		{
			slot11,
			slot14,
			"dungeon_secretroom_btn_sandglass"
		},
		{
			slot10,
			slot13,
			"dungeon_secretroom_btn_box"
		}
	}, slot0._gohorizontal, slot0._goitem)
	TaskDispatcher.runDelay(slot0.closeThis, slot0, 3)
end

function slot0.setItem(slot0, slot1, slot2, slot3)
	UISpriteSetMgr.instance:setExploreSprite(gohelper.findChildImage(slot1, "bg"), slot2[1] == slot2[2] and "dungeon_secretroom_img_full" or "dungeon_secretroom_img_unfull")
	UISpriteSetMgr.instance:setExploreSprite(gohelper.findChildImage(slot1, "image_icon"), slot2[3] .. (slot2[1] == slot2[2] and "1" or "2"))

	gohelper.findChildTextMesh(slot1, "txt_progress").text = string.format("%d/%d", slot2[1], slot2[2])
end

function slot0.onClose(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_feedback_close)
	TaskDispatcher.cancelTask(slot0.closeThis, slot0)

	if not ExploreController.instance:getMap() then
		return
	end

	slot1:getHero():onRoleFirstEnter()
end

return slot0
