module("modules.logic.dungeon.view.DungeonExploreView", package.seeall)

slot0 = class("DungeonExploreView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagelevelbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_levelbg")
	slot0._gochapteritem = gohelper.findChild(slot0.viewGO, "left/mask/#scroll_level/Viewport/Content/#go_levelitem")
	slot0._golevelitem = gohelper.findChild(slot0.viewGO, "right/contain/level/#go_levelitem")
	slot0._btnstart = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/contain/#btn_start")
	slot0._btnbook = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/contain/#btn_book", AudioEnum.UI.play_ui_leimi_biguncharted_open)
	slot0._gobookred = gohelper.findChild(slot0.viewGO, "right/contain/#btn_book/#go_bookreddot")
	slot0._gofullbooknum = gohelper.findChild(slot0.viewGO, "right/contain/#btn_book/full")
	slot0._gounfullbooknum = gohelper.findChild(slot0.viewGO, "right/contain/#btn_book/unfull")
	slot0._txtfullbooknum = gohelper.findChildTextMesh(slot0.viewGO, "right/contain/#btn_book/full/#txt_num")
	slot0._txtunfullbooknum = gohelper.findChildTextMesh(slot0.viewGO, "right/contain/#btn_book/unfull/#txt_num")
	slot0._txtrewarddesc = gohelper.findChildTextMesh(slot0.viewGO, "right/contain/progress/curprogress")
	slot0._btnReward = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/contain/progress/curprogress/#btn_detail")
	slot0._goRewardRed = gohelper.findChild(slot0.viewGO, "right/contain/progress/curprogress/#btn_detail/#go_reddot")
	slot0._simagedecorate = gohelper.findChildSingleImage(slot0.viewGO, "right/contain/#simage_decorate")
	slot0._txtlevelname = gohelper.findChildTextMesh(slot0.viewGO, "right/contain/#txt_levelname")
	slot0._txtdesc = gohelper.findChildTextMesh(slot0.viewGO, "right/contain/#txt_desc")
	slot0._anim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	ExploreController.instance:registerCallback(ExploreEvent.OnChapterClick, slot0.onChapterClick, slot0)
	ExploreController.instance:registerCallback(ExploreEvent.OnLevelClick, slot0.onLevelClick, slot0)
	ExploreController.instance:registerCallback(ExploreEvent.TaskUpdate, slot0.onTaskUpdate, slot0)
	slot0._btnstart:AddClickListener(slot0._clickStart, slot0)
	slot0._btnbook:AddClickListener(slot0._clickBook, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnstart:RemoveClickListener()
	slot0._btnbook:RemoveClickListener()
	slot0._btnReward:RemoveClickListener()
	ExploreController.instance:unregisterCallback(ExploreEvent.OnChapterClick, slot0.onChapterClick, slot0)
	ExploreController.instance:unregisterCallback(ExploreEvent.OnLevelClick, slot0.onLevelClick, slot0)
	ExploreController.instance:unregisterCallback(ExploreEvent.TaskUpdate, slot0.onTaskUpdate, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
end

function slot0._editableInitView(slot0)
	slot0._chapterProcess = {}

	for slot4 = 1, 3 do
		slot0._chapterProcess[slot4] = slot0:getUserDataTb_()
		slot0._chapterProcess[slot4].go = gohelper.findChild(slot0.viewGO, "right/contain/progress/list/#go_progressitem" .. slot4)
		slot0._chapterProcess[slot4].bg = gohelper.findChildImage(slot0._chapterProcess[slot4].go, "bg")
		slot0._chapterProcess[slot4].dark = gohelper.findChild(slot0._chapterProcess[slot4].go, "dark")
		slot0._chapterProcess[slot4].light = gohelper.findChild(slot0._chapterProcess[slot4].go, "light")
		slot0._chapterProcess[slot4].progress = gohelper.findChildTextMesh(slot0._chapterProcess[slot4].go, "txt_progress")
		slot0._chapterProcess[slot4].unlockEffect = gohelper.findChild(slot0._chapterProcess[slot4].go, "click_light")
		slot0._chapterProcess[slot4].red = gohelper.findChild(slot0._chapterProcess[slot4].go, "#go_reddot")

		slot0:addClickCb(gohelper.findButtonWithAudio(slot0._chapterProcess[slot4].go), slot0._clickReward, slot0, slot4)
	end
end

function slot0._onCloseView(slot0, slot1)
	if slot1 == ViewName.LoadingView then
		slot0:onShow()
		slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	end
end

function slot0.onOpen(slot0)
	if ViewMgr.instance:isOpen(ViewName.LoadingView) then
		gohelper.setActive(slot0.viewGO, false)
		slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	else
		slot0:onShow()
	end
end

function slot0.onShow(slot0)
	gohelper.setActive(slot0.viewGO, true)
	AudioMgr.instance:trigger(AudioEnum.Va3Aact120.play_ui_molu_ilbn_open)
	ExploreSimpleModel.instance:setDelaySave(true)
	slot0:initChapterList()

	slot0._selectChapterIndex, slot0._selectLevelIndex = ExploreSimpleModel.instance:getChapterIndex(ExploreSimpleModel.instance:getLastSelectMap())

	ExploreController.instance:dispatchEvent(ExploreEvent.OnChapterClick, slot0._selectChapterIndex or 1)

	slot0._selectChapterIndex = nil
	slot0._selectLevelIndex = nil

	ExploreSimpleModel.instance:setDelaySave(false)
	slot0._anim:Play("open", 0, 0)
	slot0._anim:Update(0)
end

function slot0.onUpdateParam(slot0)
end

function slot0._clickBook(slot0)
	gohelper.setActive(slot0._gobookred, false)
	ViewMgr.instance:openView(ViewName.ExploreArchivesView, {
		id = slot0._chapterCo.id
	})
end

function slot0._clickReward(slot0, slot1)
	if slot1 == 3 then
		ViewMgr.instance:openView(ViewName.ExploreBonusRewardView, slot0._chapterCo)
	else
		ViewMgr.instance:openView(ViewName.ExploreRewardView, slot0._chapterCo)
	end
end

function slot0.onTaskUpdate(slot0)
	gohelper.setActive(slot0._chapterProcess[1].red, ExploreSimpleModel.instance:getTaskRed(slot0._chapterCo.id, ExploreEnum.CoinType.PurpleCoin))
	gohelper.setActive(slot0._chapterProcess[2].red, ExploreSimpleModel.instance:getTaskRed(slot0._chapterCo.id, ExploreEnum.CoinType.GoldCoin))
end

function slot0.onChapterClick(slot0, slot1)
	if slot0._chapterCo == slot0._chapterCoList[slot1] then
		return
	end

	if slot0._nowIndex ~= slot1 then
		slot0._nowIndex = slot1

		if not not slot0._nowIndex then
			AudioMgr.instance:trigger(AudioEnum.UI.UI_Activity_open)
			slot0._anim:Play("switch", 0, 0)
			slot0._anim:Update(0)
			TaskDispatcher.runDelay(slot0._delayRefreshView, slot0, 0)
		else
			slot0:_refreshChapterInfo(slot1)
		end
	end
end

function slot0._delayRefreshView(slot0)
	slot0:_refreshChapterInfo(slot0._nowIndex)
end

function slot0._refreshChapterInfo(slot0, slot1)
	slot2 = slot0._chapterCoList[slot1]
	slot0._chapterCo = slot2
	slot0._episodeCoList = DungeonConfig.instance:getChapterEpisodeCOList(slot2.id)
	slot0._levelList = slot0._levelList or {}

	gohelper.CreateObjList(slot0, slot0._onLevelItemLoad, slot0._episodeCoList, slot0._golevelitem.transform.parent.gameObject, slot0._golevelitem, DungeonExploreLevelItem)
	ExploreController.instance:dispatchEvent(ExploreEvent.OnLevelClick, slot0._selectLevelIndex or 1)
	slot0._simagelevelbg:LoadImage(ResUrl.getExploreBg(ExploreSimpleModel.instance:isChapterFinish(slot2.id) and "level/levelbg" .. slot1 .. "_1" or "level/levelbg" .. slot1))
	slot0._simagedecorate:LoadImage(ResUrl.getExploreBg("dungeon_secretroom_img_title" .. slot1))
	gohelper.setActive(slot0._gobookred, ExploreSimpleModel.instance:getHaveNewArchive(slot2.id))
	gohelper.setActive(slot0._goRewardRed, ExploreSimpleModel.instance:getTaskRed(slot2.id))

	slot6 = nil
	slot0._txtlevelname.text = (GameUtil.utf8len(slot2.name) < 2 or (not LangSettings.instance:isEn() or string.format("<size=86>%s</size>%s", GameUtil.utf8sub(slot4, 1, 1), GameUtil.utf8sub(slot4, 2, slot5 - 1))) and string.format("<size=86>%s</size>%s<size=86>%s</size>", GameUtil.utf8sub(slot4, 1, 1), GameUtil.utf8sub(slot4, 2, slot5 - 2), GameUtil.utf8sub(slot4, slot5, 1))) and "<size=86>" .. slot4
	slot0._txtdesc.text = slot2.desc
	slot7, slot8, slot9, slot10, slot11, slot12 = ExploreSimpleModel.instance:getChapterCoinCount(slot2.id)
	slot13 = ExploreSimpleModel.instance:isChapterCoinFull(slot2.id)
	slot14 = slot7 == slot10
	slot15 = slot8 == slot11
	slot16 = slot9 == slot12

	for slot20 = 1, 3 do
		UISpriteSetMgr.instance:setExploreSprite(slot0._chapterProcess[slot20].bg, slot13 and "dungeon_secretroom_img_full" or "dungeon_secretroom_img_unfull")
	end

	gohelper.setActive(slot0._chapterProcess[1].dark, not slot16)
	gohelper.setActive(slot0._chapterProcess[1].light, slot16)
	gohelper.setActive(slot0._chapterProcess[2].dark, not slot15)
	gohelper.setActive(slot0._chapterProcess[2].light, slot15)
	gohelper.setActive(slot0._chapterProcess[3].dark, not slot14)
	gohelper.setActive(slot0._chapterProcess[3].light, slot14)

	slot0._txtrewarddesc.text = slot13 and luaLang("explore_collect_full") or luaLang("explore_collect")
	slot18 = ExploreSimpleModel.instance:getChapterMo(slot0._chapterCo.id) and tabletool.len(slot17.archiveIds) or 0
	slot19 = ExploreConfig.instance:getArchiveTotalCount(slot0._chapterCo.id)
	slot0._txtfullbooknum.text = slot18 .. "/" .. slot19
	slot0._txtunfullbooknum.text = slot18 .. "/" .. slot19

	gohelper.setActive(slot0._gofullbooknum, slot19 <= slot18)
	gohelper.setActive(slot0._gounfullbooknum, slot18 < slot19)

	slot0._chapterProcess[1].progress.text = string.format("%d/%d", slot9, slot12)
	slot0._chapterProcess[2].progress.text = string.format("%d/%d", slot8, slot11)
	slot0._chapterProcess[3].progress.text = string.format("%d/%d", slot7, slot10)

	slot0:_hideUnlockEffect()

	slot20 = false

	if slot14 and not ExploreSimpleModel.instance:getCollectFullIsShow(slot2.id, ExploreEnum.CoinType.Bonus) then
		ExploreSimpleModel.instance:markCollectFullIsShow(slot2.id, ExploreEnum.CoinType.Bonus)
		gohelper.setActive(slot0._chapterProcess[3].unlockEffect, true)

		slot20 = true
	end

	if slot15 and not ExploreSimpleModel.instance:getCollectFullIsShow(slot2.id, ExploreEnum.CoinType.GoldCoin) then
		ExploreSimpleModel.instance:markCollectFullIsShow(slot2.id, ExploreEnum.CoinType.GoldCoin)
		gohelper.setActive(slot0._chapterProcess[2].unlockEffect, true)

		slot20 = true
	end

	if slot16 and not ExploreSimpleModel.instance:getCollectFullIsShow(slot2.id, ExploreEnum.CoinType.PurpleCoin) then
		ExploreSimpleModel.instance:markCollectFullIsShow(slot2.id, ExploreEnum.CoinType.PurpleCoin)
		gohelper.setActive(slot0._chapterProcess[1].unlockEffect, true)

		slot20 = true
	end

	TaskDispatcher.cancelTask(slot0._hideUnlockEffect, slot0)

	if slot20 then
		TaskDispatcher.runDelay(slot0._hideUnlockEffect, slot0, 1.8)
	end

	slot0:onTaskUpdate()
end

function slot0._hideUnlockEffect(slot0)
	if not slot0._chapterProcess then
		return
	end

	for slot4 = 1, 3 do
		gohelper.setActive(slot0._chapterProcess[slot4].unlockEffect, false)
	end
end

function slot0.onLevelClick(slot0, slot1)
	if slot0._curEpisodeCo then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_property)
	end

	slot0._curEpisodeCo = slot0._episodeCoList[slot1]

	ExploreSimpleModel.instance:setLastSelectMap(slot0._curEpisodeCo.chapterId, slot0._curEpisodeCo.id)
end

function slot0._clickStart(slot0)
	ExploreController.instance:enterExploreScene(lua_explore_scene.configDict[slot0._curEpisodeCo.chapterId][slot0._curEpisodeCo.id].id)
end

function slot0.initChapterList(slot0)
	slot0._chapterCoList = DungeonConfig.instance:getExploreChapterList()
	slot0._chapterList = {}

	gohelper.CreateObjList(slot0, slot0._onChapterItemLoad, slot0._chapterCoList, slot0._gochapteritem.transform.parent.gameObject, slot0._gochapteritem, DungeonExploreChapterItem)
end

function slot0._onChapterItemLoad(slot0, slot1, slot2, slot3)
	slot1:setData(slot2, slot3)

	slot0._chapterList[slot3] = slot1
end

function slot0._onLevelItemLoad(slot0, slot1, slot2, slot3)
	slot1:setData(slot2, slot3, slot3 == #slot0._episodeCoList)

	slot0._levelList[slot3] = slot1
end

function slot0.onHide(slot0, slot1, slot2)
	if ExploreModel.instance.isJumpToExplore then
		ExploreModel.instance.isJumpToExplore = false

		ViewMgr.instance:closeView(ViewName.DungeonView)

		return
	end

	if slot0._anim then
		slot0._anim:Play("close", 0, 0)
	end

	slot0._closeCallBack = slot1
	slot0._closeCallBackObj = slot2

	UIBlockMgr.instance:startBlock("DungeonExploreView_Close")
	TaskDispatcher.runDelay(slot0._onCloseAnimEnd, slot0, 0.167)
	TaskDispatcher.cancelTask(slot0._hideUnlockEffect, slot0)
end

function slot0._onCloseAnimEnd(slot0)
	UIBlockMgr.instance:endBlock("DungeonExploreView_Close")

	if slot0._closeCallBack then
		slot0._closeCallBack(slot0._closeCallBackObj)
	end
end

function slot0.onClose(slot0)
	slot0:onHide()
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._onCloseAnimEnd, slot0)
	UIBlockMgr.instance:endBlock("DungeonExploreView_Close")
	TaskDispatcher.cancelTask(slot0._delayRefreshView, slot0)

	for slot4, slot5 in pairs(slot0._chapterList) do
		slot5:destroy()
	end

	for slot4, slot5 in pairs(slot0._levelList) do
		slot5:destroy()
	end

	slot0._simagelevelbg:UnLoadImage()
	slot0._simagedecorate:UnLoadImage()
end

return slot0
