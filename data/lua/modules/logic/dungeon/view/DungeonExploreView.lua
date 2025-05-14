module("modules.logic.dungeon.view.DungeonExploreView", package.seeall)

local var_0_0 = class("DungeonExploreView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagelevelbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_levelbg")
	arg_1_0._gochapteritem = gohelper.findChild(arg_1_0.viewGO, "left/mask/#scroll_level/Viewport/Content/#go_levelitem")
	arg_1_0._golevelitem = gohelper.findChild(arg_1_0.viewGO, "right/contain/level/#go_levelitem")
	arg_1_0._btnstart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/contain/#btn_start")
	arg_1_0._btnbook = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/contain/#btn_book", AudioEnum.UI.play_ui_leimi_biguncharted_open)
	arg_1_0._gobookred = gohelper.findChild(arg_1_0.viewGO, "right/contain/#btn_book/#go_bookreddot")
	arg_1_0._gofullbooknum = gohelper.findChild(arg_1_0.viewGO, "right/contain/#btn_book/full")
	arg_1_0._gounfullbooknum = gohelper.findChild(arg_1_0.viewGO, "right/contain/#btn_book/unfull")
	arg_1_0._txtfullbooknum = gohelper.findChildTextMesh(arg_1_0.viewGO, "right/contain/#btn_book/full/#txt_num")
	arg_1_0._txtunfullbooknum = gohelper.findChildTextMesh(arg_1_0.viewGO, "right/contain/#btn_book/unfull/#txt_num")
	arg_1_0._txtrewarddesc = gohelper.findChildTextMesh(arg_1_0.viewGO, "right/contain/progress/curprogress")
	arg_1_0._btnReward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/contain/progress/curprogress/#btn_detail")
	arg_1_0._goRewardRed = gohelper.findChild(arg_1_0.viewGO, "right/contain/progress/curprogress/#btn_detail/#go_reddot")
	arg_1_0._simagedecorate = gohelper.findChildSingleImage(arg_1_0.viewGO, "right/contain/#simage_decorate")
	arg_1_0._txtlevelname = gohelper.findChildTextMesh(arg_1_0.viewGO, "right/contain/#txt_levelname")
	arg_1_0._txtdesc = gohelper.findChildTextMesh(arg_1_0.viewGO, "right/contain/#txt_desc")
	arg_1_0._anim = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	ExploreController.instance:registerCallback(ExploreEvent.OnChapterClick, arg_2_0.onChapterClick, arg_2_0)
	ExploreController.instance:registerCallback(ExploreEvent.OnLevelClick, arg_2_0.onLevelClick, arg_2_0)
	ExploreController.instance:registerCallback(ExploreEvent.TaskUpdate, arg_2_0.onTaskUpdate, arg_2_0)
	arg_2_0._btnstart:AddClickListener(arg_2_0._clickStart, arg_2_0)
	arg_2_0._btnbook:AddClickListener(arg_2_0._clickBook, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnstart:RemoveClickListener()
	arg_3_0._btnbook:RemoveClickListener()
	arg_3_0._btnReward:RemoveClickListener()
	ExploreController.instance:unregisterCallback(ExploreEvent.OnChapterClick, arg_3_0.onChapterClick, arg_3_0)
	ExploreController.instance:unregisterCallback(ExploreEvent.OnLevelClick, arg_3_0.onLevelClick, arg_3_0)
	ExploreController.instance:unregisterCallback(ExploreEvent.TaskUpdate, arg_3_0.onTaskUpdate, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_3_0._onCloseView, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._chapterProcess = {}

	for iter_4_0 = 1, 3 do
		arg_4_0._chapterProcess[iter_4_0] = arg_4_0:getUserDataTb_()
		arg_4_0._chapterProcess[iter_4_0].go = gohelper.findChild(arg_4_0.viewGO, "right/contain/progress/list/#go_progressitem" .. iter_4_0)
		arg_4_0._chapterProcess[iter_4_0].bg = gohelper.findChildImage(arg_4_0._chapterProcess[iter_4_0].go, "bg")
		arg_4_0._chapterProcess[iter_4_0].dark = gohelper.findChild(arg_4_0._chapterProcess[iter_4_0].go, "dark")
		arg_4_0._chapterProcess[iter_4_0].light = gohelper.findChild(arg_4_0._chapterProcess[iter_4_0].go, "light")
		arg_4_0._chapterProcess[iter_4_0].progress = gohelper.findChildTextMesh(arg_4_0._chapterProcess[iter_4_0].go, "txt_progress")
		arg_4_0._chapterProcess[iter_4_0].unlockEffect = gohelper.findChild(arg_4_0._chapterProcess[iter_4_0].go, "click_light")
		arg_4_0._chapterProcess[iter_4_0].red = gohelper.findChild(arg_4_0._chapterProcess[iter_4_0].go, "#go_reddot")

		local var_4_0 = gohelper.findButtonWithAudio(arg_4_0._chapterProcess[iter_4_0].go)

		arg_4_0:addClickCb(var_4_0, arg_4_0._clickReward, arg_4_0, iter_4_0)
	end
end

function var_0_0._onCloseView(arg_5_0, arg_5_1)
	if arg_5_1 == ViewName.LoadingView then
		arg_5_0:onShow()
		arg_5_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_5_0._onCloseView, arg_5_0)
	end
end

function var_0_0.onOpen(arg_6_0)
	if ViewMgr.instance:isOpen(ViewName.LoadingView) then
		gohelper.setActive(arg_6_0.viewGO, false)
		arg_6_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_6_0._onCloseView, arg_6_0)
	else
		arg_6_0:onShow()
	end
end

function var_0_0.onShow(arg_7_0)
	gohelper.setActive(arg_7_0.viewGO, true)
	AudioMgr.instance:trigger(AudioEnum.Va3Aact120.play_ui_molu_ilbn_open)
	ExploreSimpleModel.instance:setDelaySave(true)
	arg_7_0:initChapterList()

	arg_7_0._selectChapterIndex, arg_7_0._selectLevelIndex = ExploreSimpleModel.instance:getChapterIndex(ExploreSimpleModel.instance:getLastSelectMap())

	ExploreController.instance:dispatchEvent(ExploreEvent.OnChapterClick, arg_7_0._selectChapterIndex or 1)

	arg_7_0._selectChapterIndex = nil
	arg_7_0._selectLevelIndex = nil

	ExploreSimpleModel.instance:setDelaySave(false)
	arg_7_0._anim:Play("open", 0, 0)
	arg_7_0._anim:Update(0)
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0._clickBook(arg_9_0)
	gohelper.setActive(arg_9_0._gobookred, false)
	ViewMgr.instance:openView(ViewName.ExploreArchivesView, {
		id = arg_9_0._chapterCo.id
	})
end

function var_0_0._clickReward(arg_10_0, arg_10_1)
	if arg_10_1 == 3 then
		ViewMgr.instance:openView(ViewName.ExploreBonusRewardView, arg_10_0._chapterCo)
	else
		ViewMgr.instance:openView(ViewName.ExploreRewardView, arg_10_0._chapterCo)
	end
end

function var_0_0.onTaskUpdate(arg_11_0)
	gohelper.setActive(arg_11_0._chapterProcess[1].red, ExploreSimpleModel.instance:getTaskRed(arg_11_0._chapterCo.id, ExploreEnum.CoinType.PurpleCoin))
	gohelper.setActive(arg_11_0._chapterProcess[2].red, ExploreSimpleModel.instance:getTaskRed(arg_11_0._chapterCo.id, ExploreEnum.CoinType.GoldCoin))
end

function var_0_0.onChapterClick(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0._chapterCoList[arg_12_1]

	if arg_12_0._chapterCo == var_12_0 then
		return
	end

	if arg_12_0._nowIndex ~= arg_12_1 then
		local var_12_1 = not arg_12_0._nowIndex

		arg_12_0._nowIndex = arg_12_1

		if not var_12_1 then
			AudioMgr.instance:trigger(AudioEnum.UI.UI_Activity_open)
			arg_12_0._anim:Play("switch", 0, 0)
			arg_12_0._anim:Update(0)
			TaskDispatcher.runDelay(arg_12_0._delayRefreshView, arg_12_0, 0)
		else
			arg_12_0:_refreshChapterInfo(arg_12_1)
		end
	end
end

function var_0_0._delayRefreshView(arg_13_0)
	arg_13_0:_refreshChapterInfo(arg_13_0._nowIndex)
end

function var_0_0._refreshChapterInfo(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0._chapterCoList[arg_14_1]

	arg_14_0._chapterCo = var_14_0
	arg_14_0._episodeCoList = DungeonConfig.instance:getChapterEpisodeCOList(var_14_0.id)
	arg_14_0._levelList = arg_14_0._levelList or {}

	gohelper.CreateObjList(arg_14_0, arg_14_0._onLevelItemLoad, arg_14_0._episodeCoList, arg_14_0._golevelitem.transform.parent.gameObject, arg_14_0._golevelitem, DungeonExploreLevelItem)
	ExploreController.instance:dispatchEvent(ExploreEvent.OnLevelClick, arg_14_0._selectLevelIndex or 1)

	local var_14_1 = ExploreSimpleModel.instance:isChapterFinish(var_14_0.id) and "level/levelbg" .. arg_14_1 .. "_1" or "level/levelbg" .. arg_14_1

	arg_14_0._simagelevelbg:LoadImage(ResUrl.getExploreBg(var_14_1))
	arg_14_0._simagedecorate:LoadImage(ResUrl.getExploreBg("dungeon_secretroom_img_title" .. arg_14_1))
	gohelper.setActive(arg_14_0._gobookred, ExploreSimpleModel.instance:getHaveNewArchive(var_14_0.id))
	gohelper.setActive(arg_14_0._goRewardRed, ExploreSimpleModel.instance:getTaskRed(var_14_0.id))

	local var_14_2 = var_14_0.name
	local var_14_3 = GameUtil.utf8len(var_14_2)
	local var_14_4

	if var_14_3 >= 2 then
		if LangSettings.instance:isEn() then
			local var_14_5 = GameUtil.utf8sub(var_14_2, 1, 1)
			local var_14_6 = GameUtil.utf8sub(var_14_2, 2, var_14_3 - 1)

			var_14_4 = string.format("<size=86>%s</size>%s", var_14_5, var_14_6)
		else
			local var_14_7 = GameUtil.utf8sub(var_14_2, 1, 1)
			local var_14_8 = GameUtil.utf8sub(var_14_2, 2, var_14_3 - 2)
			local var_14_9 = GameUtil.utf8sub(var_14_2, var_14_3, 1)

			var_14_4 = string.format("<size=86>%s</size>%s<size=86>%s</size>", var_14_7, var_14_8, var_14_9)
		end
	else
		var_14_4 = "<size=86>" .. var_14_2
	end

	arg_14_0._txtlevelname.text = var_14_4
	arg_14_0._txtdesc.text = var_14_0.desc

	local var_14_10, var_14_11, var_14_12, var_14_13, var_14_14, var_14_15 = ExploreSimpleModel.instance:getChapterCoinCount(var_14_0.id)
	local var_14_16 = ExploreSimpleModel.instance:isChapterCoinFull(var_14_0.id)
	local var_14_17 = var_14_10 == var_14_13
	local var_14_18 = var_14_11 == var_14_14
	local var_14_19 = var_14_12 == var_14_15

	for iter_14_0 = 1, 3 do
		UISpriteSetMgr.instance:setExploreSprite(arg_14_0._chapterProcess[iter_14_0].bg, var_14_16 and "dungeon_secretroom_img_full" or "dungeon_secretroom_img_unfull")
	end

	gohelper.setActive(arg_14_0._chapterProcess[1].dark, not var_14_19)
	gohelper.setActive(arg_14_0._chapterProcess[1].light, var_14_19)
	gohelper.setActive(arg_14_0._chapterProcess[2].dark, not var_14_18)
	gohelper.setActive(arg_14_0._chapterProcess[2].light, var_14_18)
	gohelper.setActive(arg_14_0._chapterProcess[3].dark, not var_14_17)
	gohelper.setActive(arg_14_0._chapterProcess[3].light, var_14_17)

	arg_14_0._txtrewarddesc.text = var_14_16 and luaLang("explore_collect_full") or luaLang("explore_collect")

	local var_14_20 = ExploreSimpleModel.instance:getChapterMo(arg_14_0._chapterCo.id)
	local var_14_21 = var_14_20 and tabletool.len(var_14_20.archiveIds) or 0
	local var_14_22 = ExploreConfig.instance:getArchiveTotalCount(arg_14_0._chapterCo.id)

	arg_14_0._txtfullbooknum.text = var_14_21 .. "/" .. var_14_22
	arg_14_0._txtunfullbooknum.text = var_14_21 .. "/" .. var_14_22

	gohelper.setActive(arg_14_0._gofullbooknum, var_14_22 <= var_14_21)
	gohelper.setActive(arg_14_0._gounfullbooknum, var_14_21 < var_14_22)

	arg_14_0._chapterProcess[1].progress.text = string.format("%d/%d", var_14_12, var_14_15)
	arg_14_0._chapterProcess[2].progress.text = string.format("%d/%d", var_14_11, var_14_14)
	arg_14_0._chapterProcess[3].progress.text = string.format("%d/%d", var_14_10, var_14_13)

	arg_14_0:_hideUnlockEffect()

	local var_14_23 = false

	if var_14_17 and not ExploreSimpleModel.instance:getCollectFullIsShow(var_14_0.id, ExploreEnum.CoinType.Bonus) then
		ExploreSimpleModel.instance:markCollectFullIsShow(var_14_0.id, ExploreEnum.CoinType.Bonus)
		gohelper.setActive(arg_14_0._chapterProcess[3].unlockEffect, true)

		var_14_23 = true
	end

	if var_14_18 and not ExploreSimpleModel.instance:getCollectFullIsShow(var_14_0.id, ExploreEnum.CoinType.GoldCoin) then
		ExploreSimpleModel.instance:markCollectFullIsShow(var_14_0.id, ExploreEnum.CoinType.GoldCoin)
		gohelper.setActive(arg_14_0._chapterProcess[2].unlockEffect, true)

		var_14_23 = true
	end

	if var_14_19 and not ExploreSimpleModel.instance:getCollectFullIsShow(var_14_0.id, ExploreEnum.CoinType.PurpleCoin) then
		ExploreSimpleModel.instance:markCollectFullIsShow(var_14_0.id, ExploreEnum.CoinType.PurpleCoin)
		gohelper.setActive(arg_14_0._chapterProcess[1].unlockEffect, true)

		var_14_23 = true
	end

	TaskDispatcher.cancelTask(arg_14_0._hideUnlockEffect, arg_14_0)

	if var_14_23 then
		TaskDispatcher.runDelay(arg_14_0._hideUnlockEffect, arg_14_0, 1.8)
	end

	arg_14_0:onTaskUpdate()
end

function var_0_0._hideUnlockEffect(arg_15_0)
	if not arg_15_0._chapterProcess then
		return
	end

	for iter_15_0 = 1, 3 do
		gohelper.setActive(arg_15_0._chapterProcess[iter_15_0].unlockEffect, false)
	end
end

function var_0_0.onLevelClick(arg_16_0, arg_16_1)
	if arg_16_0._curEpisodeCo then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_property)
	end

	arg_16_0._curEpisodeCo = arg_16_0._episodeCoList[arg_16_1]

	ExploreSimpleModel.instance:setLastSelectMap(arg_16_0._curEpisodeCo.chapterId, arg_16_0._curEpisodeCo.id)
end

function var_0_0._clickStart(arg_17_0)
	local var_17_0 = lua_explore_scene.configDict[arg_17_0._curEpisodeCo.chapterId][arg_17_0._curEpisodeCo.id]

	ExploreController.instance:enterExploreScene(var_17_0.id)
end

function var_0_0.initChapterList(arg_18_0)
	arg_18_0._chapterCoList = DungeonConfig.instance:getExploreChapterList()
	arg_18_0._chapterList = {}

	gohelper.CreateObjList(arg_18_0, arg_18_0._onChapterItemLoad, arg_18_0._chapterCoList, arg_18_0._gochapteritem.transform.parent.gameObject, arg_18_0._gochapteritem, DungeonExploreChapterItem)
end

function var_0_0._onChapterItemLoad(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	arg_19_1:setData(arg_19_2, arg_19_3)

	arg_19_0._chapterList[arg_19_3] = arg_19_1
end

function var_0_0._onLevelItemLoad(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	arg_20_1:setData(arg_20_2, arg_20_3, arg_20_3 == #arg_20_0._episodeCoList)

	arg_20_0._levelList[arg_20_3] = arg_20_1
end

function var_0_0.onHide(arg_21_0, arg_21_1, arg_21_2)
	if ExploreModel.instance.isJumpToExplore then
		ExploreModel.instance.isJumpToExplore = false

		ViewMgr.instance:closeView(ViewName.DungeonView)

		return
	end

	if arg_21_0._anim then
		arg_21_0._anim:Play("close", 0, 0)
	end

	arg_21_0._closeCallBack = arg_21_1
	arg_21_0._closeCallBackObj = arg_21_2

	UIBlockMgr.instance:startBlock("DungeonExploreView_Close")
	TaskDispatcher.runDelay(arg_21_0._onCloseAnimEnd, arg_21_0, 0.167)
	TaskDispatcher.cancelTask(arg_21_0._hideUnlockEffect, arg_21_0)
end

function var_0_0._onCloseAnimEnd(arg_22_0)
	UIBlockMgr.instance:endBlock("DungeonExploreView_Close")

	if arg_22_0._closeCallBack then
		arg_22_0._closeCallBack(arg_22_0._closeCallBackObj)
	end
end

function var_0_0.onClose(arg_23_0)
	arg_23_0:onHide()
end

function var_0_0.onDestroyView(arg_24_0)
	TaskDispatcher.cancelTask(arg_24_0._onCloseAnimEnd, arg_24_0)
	UIBlockMgr.instance:endBlock("DungeonExploreView_Close")
	TaskDispatcher.cancelTask(arg_24_0._delayRefreshView, arg_24_0)

	for iter_24_0, iter_24_1 in pairs(arg_24_0._chapterList) do
		iter_24_1:destroy()
	end

	for iter_24_2, iter_24_3 in pairs(arg_24_0._levelList) do
		iter_24_3:destroy()
	end

	arg_24_0._simagelevelbg:UnLoadImage()
	arg_24_0._simagedecorate:UnLoadImage()
end

return var_0_0
