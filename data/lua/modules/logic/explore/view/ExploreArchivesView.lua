module("modules.logic.explore.view.ExploreArchivesView", package.seeall)

slot0 = class("ExploreArchivesView", BaseView)

function slot0.onInitView(slot0)
	slot0._txtChapter = gohelper.findChildTextMesh(slot0.viewGO, "title/txt_title/#txt_chapter")
	slot0._btneasteregg = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_easteregg")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0._editableInitView(slot0)
	slot0._content = gohelper.findChild(slot0.viewGO, "#scroll_list/Viewport/Content")
end

function slot0.addEvents(slot0)
	slot0._btneasteregg:AddClickListener(slot0._onEggClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btneasteregg:RemoveClickListener()
end

function slot0.onOpen(slot0)
	slot0._images = {}
	slot1 = slot0.viewParam.id
	slot2 = ExploreSimpleModel.instance:getChapterMo(slot1)
	slot0.unLockArchives = slot2.archiveIds

	gohelper.setActive(slot0._btneasteregg, slot2:haveBonusScene())

	if not lua_explore_story.configDict[slot1] then
		return
	end

	slot5 = {
		[slot10] = true
	}

	for slot9, slot10 in pairs(ExploreSimpleModel.instance:getNewArchives(slot1)) do
		-- Nothing
	end

	slot0._txtChapter.text = DungeonConfig.instance:getChapterCO(slot1).name

	ExploreSimpleModel.instance:markArchive(slot1, false)

	slot8 = slot0:getResInst(string.format("ui/viewres/explore/explorearchivechapter%d.prefab", slot1), slot0._content).transform
	slot12 = recthelper.getWidth

	recthelper.setWidth(slot0._content.transform, slot12(slot8))

	slot0._unLockAnims = {}

	for slot12 = 0, slot8.childCount - 1 do
		if string.match(slot8:GetChild(slot12).name, "^#go_item_(%d+)$") then
			slot0:_initArchiveItem(slot13, slot3[tonumber(slot15)], slot5)
		end
	end

	if slot8:Find("line") then
		for slot13 = 0, slot9.childCount - 1 do
			slot16, slot17 = string.match(slot9:GetChild(slot13).name, "^#go_line_(%d+)_(%d+)$")
			slot18 = false

			if slot16 and slot17 then
				slot18 = slot0.unLockArchives[tonumber(slot16)] and slot0.unLockArchives[tonumber(slot17)]
			else
				slot19, slot17 = string.match(slot15, "^#go_line_gray_(%d+)_(%d+)$")
				slot18 = not slot0.unLockArchives[tonumber(slot19)] or not slot0.unLockArchives[tonumber(slot17)]
			end

			gohelper.setActive(slot14, slot18)
		end
	end

	if #slot0._unLockAnims > 0 then
		TaskDispatcher.runDelay(slot0.beginUnlock, slot0, 1.1)
	end
end

function slot0._onEggClick(slot0)
	ViewMgr.instance:openView(ViewName.ExploreBonusSceneRecordView, {
		chapterId = slot0.viewParam.id
	})
end

function slot0._initArchiveItem(slot0, slot1, slot2, slot3)
	slot4 = slot1.gameObject
	slot6 = gohelper.findChildSingleImage(slot4, "#simage_icon")
	slot7 = gohelper.findChildTextMesh(slot4, "#txt_name")
	slot9 = gohelper.findChildSingleImage(slot4, "#go_lock/#simage_icon")
	slot11 = gohelper.findChild(slot4, "#go_lock/lock")
	slot12 = gohelper.findChild(slot4, "#go_lock/cn")
	slot13 = gohelper.findChild(slot4, "#go_lock/en")
	slot14 = gohelper.findChild(slot4, "#go_lock"):GetComponent(typeof(UnityEngine.Animator))
	slot15 = slot0.unLockArchives[slot2.id] or false

	gohelper.setActive(slot6, slot15)
	gohelper.setActive(slot7, slot15)
	gohelper.setActive(slot8, not slot15)
	gohelper.setActive(gohelper.findChild(slot4, "go_new"), slot3[slot2.id] or false)

	slot7.text = slot2.title

	slot6:LoadImage(ResUrl.getExploreBg("file/" .. slot2.res))
	slot9:LoadImage(ResUrl.getExploreBg("file/" .. slot2.res))
	table.insert(slot0._images, slot6)
	table.insert(slot0._images, slot9)

	if slot15 then
		slot0._goNew = slot0._goNew or slot0:getUserDataTb_()
		slot0._goNew[slot2.id] = slot10

		slot0:addClickCb(gohelper.getClickWithAudio(slot4, AudioEnum.UI.play_ui_feedback_open), slot0._onItemClick, slot0, slot2.id)
	end

	if slot16 then
		gohelper.setActive(slot8, true)
		gohelper.setActive(slot7, false)
		gohelper.setActive(slot10, false)
		table.insert(slot0._unLockAnims, {
			slot8,
			slot14,
			slot7,
			slot6,
			slot10,
			slot11,
			slot12,
			slot13
		})
	end
end

function slot0.beginUnlock(slot0)
	for slot4, slot5 in pairs(slot0._unLockAnims) do
		slot5[2]:Play("unlock", 0, 0)
		gohelper.setActive(slot5[6], false)
		gohelper.setActive(slot5[7], false)
		gohelper.setActive(slot5[8], false)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_unlock)
	TaskDispatcher.runDelay(slot0.unlockEnd, slot0, 1)
end

function slot0.unlockEnd(slot0)
	for slot4, slot5 in pairs(slot0._unLockAnims) do
		gohelper.setActive(slot5[1], false)
		gohelper.setActive(slot5[3], true)
		gohelper.setActive(slot5[4], true)
		gohelper.setActive(slot5[5], true)

		if not slot0._tweens then
			slot0._tweens = {}
		end

		table.insert(slot0._tweens, ZProj.TweenHelper.DoFade(slot5[3], 0, 1, 0.5))
	end
end

function slot0._onItemClick(slot0, slot1)
	gohelper.setActive(slot0._goNew[slot1], false)
	ViewMgr.instance:openView(ViewName.ExploreArchivesDetailView, {
		id = slot1,
		chapterId = slot0.viewParam.id
	})
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.beginUnlock, slot0)

	slot4 = slot0

	TaskDispatcher.cancelTask(slot0.unlockEnd, slot4)

	for slot4, slot5 in pairs(slot0._images) do
		slot5:UnLoadImage()
	end

	if slot0._tweens then
		for slot4, slot5 in pairs(slot0._tweens) do
			ZProj.TweenHelper.KillById(slot5)
		end

		slot0._tweens = nil
	end
end

return slot0
