module("modules.logic.turnback.view.new.view.TurnbackReviewView", package.seeall)

local var_0_0 = class("TurnbackReviewView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._scrollTabList = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_TabList")
	arg_1_0._gotabitem = gohelper.findChild(arg_1_0.viewGO, "#scroll_TabList/Viewport/Content/#go_tabitem")
	arg_1_0._trstabitemContent = gohelper.findChild(arg_1_0.viewGO, "#scroll_TabList/Viewport/Content").transform
	arg_1_0._txtunlocktab = gohelper.findChildText(arg_1_0.viewGO, "#scroll_TabList/Viewport/Content/#go_tabitem/Unlock/#txt_unlocktab")
	arg_1_0._txtlockedtab = gohelper.findChildText(arg_1_0.viewGO, "#scroll_TabList/Viewport/Content/#go_tabitem/Locked/#txt_lockedtab")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "#scroll_TabList/Viewport/Content/#go_tabitem/#go_reddot")
	arg_1_0._goui = gohelper.findChild(arg_1_0.viewGO, "#go_ui")
	arg_1_0._simagecgold = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/#simage_cgold")
	arg_1_0._simagezoneold = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/#simage_cgold/masknode/#simage_zoneold")
	arg_1_0._gomasknodeold = gohelper.findChild(arg_1_0.viewGO, "#go_ui/#simage_cgold/masknode")
	arg_1_0._simagecg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/#simage_cg")
	arg_1_0._simagezone = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/#simage_cg/masknode/#simage_zone")
	arg_1_0._gomasknode = gohelper.findChild(arg_1_0.viewGO, "#go_ui/#simage_cg/masknode")
	arg_1_0._godrag = gohelper.findChild(arg_1_0.viewGO, "#go_ui/#btn_click/#go_drag")
	arg_1_0._btnprev = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_ui/#btn_prev")
	arg_1_0._btnnext = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_ui/#btn_next")
	arg_1_0._txtchapter = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/desc/#txt_chapter")
	arg_1_0._txttitleName = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/desc/#txt_titleName")
	arg_1_0._txttitleNameEn = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/desc/#txt_titleNameEn")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/desc/#txt_desc")
	arg_1_0._btnpage = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_ui/page/btn")
	arg_1_0._txtcurindex = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/page/#txt_curindex")
	arg_1_0._txttotalpage = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/page/#txt_curindex/#txt_totalpage")
	arg_1_0._btngoto = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_ui/#btn_goto")
	arg_1_0._txtcurchapter = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/#btn_goto/#txt_curchapter")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_ui/#go_btns")
	arg_1_0._animator = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._cgType = HandbookEnum.CGType.Dungeon
	arg_1_0._topItemList = {}
	arg_1_0._selectChapter = 1
	arg_1_0.centerBannerPosX = 0

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

var_0_0.bannerWidth = 1420
var_0_0.moveDistance = 100
var_0_0.LayoutSpace = 100

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnprev:AddClickListener(arg_2_0._btnprevOnClick, arg_2_0)
	arg_2_0._btnnext:AddClickListener(arg_2_0._btnnextOnClick, arg_2_0)
	arg_2_0._btngoto:AddClickListener(arg_2_0._btngotoOnClick, arg_2_0)
	arg_2_0._btnpage:AddClickListener(arg_2_0._btnpageOnClick, arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, arg_2_0.onDungeonUpdate, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnprev:RemoveClickListener()
	arg_3_0._btnnext:RemoveClickListener()
	arg_3_0._btngoto:RemoveClickListener()
	arg_3_0._btnpage:RemoveClickListener()
	arg_3_0:removeEventCb(DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, arg_3_0.onDungeonUpdate, arg_3_0)
end

function var_0_0._btnpageOnClick(arg_4_0)
	if not string.nilorempty(arg_4_0._lastEpisodeId) then
		local var_4_0 = "17#3#" .. arg_4_0._selectChapter

		JumpController.instance:jumpTo(var_4_0)
	end
end

function var_0_0._btngotoOnClick(arg_5_0)
	if not string.nilorempty(arg_5_0._jumpEpisodeId) then
		local var_5_0 = JumpEnum.JumpView.DungeonViewWithEpisode .. "#" .. arg_5_0._jumpEpisodeId

		JumpController.instance:jumpTo(var_5_0)
		TaskDispatcher.cancelTask(arg_5_0.autoSwitch, arg_5_0)
	end
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._cimagecg = arg_6_0._simagecg.gameObject:GetComponent(typeof(UnityEngine.UI.CustomImage))
	arg_6_0._imageZone = gohelper.findChildImage(arg_6_0.viewGO, "#go_ui/#simage_cg/masknode/#simage_zone")
	arg_6_0._cimagecgold = arg_6_0._simagecgold.gameObject:GetComponent(typeof(UnityEngine.UI.CustomImage))
	arg_6_0._imageZoneOld = gohelper.findChildImage(arg_6_0.viewGO, "#go_ui/#simage_cgold/masknode/#simage_zoneold")

	gohelper.setActive(arg_6_0._simagecg.gameObject, false)
	gohelper.setActive(arg_6_0._simagecgold.gameObject, false)

	arg_6_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_6_0._godrag)

	arg_6_0._drag:AddDragBeginListener(arg_6_0._onDragBegin, arg_6_0)
	arg_6_0._drag:AddDragEndListener(arg_6_0._onDragEnd, arg_6_0)
	gohelper.addUIClickAudio(arg_6_0._btnprev.gameObject, AudioEnum.UI.play_ui_screenplay_photo_click)
	gohelper.addUIClickAudio(arg_6_0._btnnext.gameObject, AudioEnum.UI.play_ui_screenplay_photo_click)

	arg_6_0.loadedCgList = {}
end

function var_0_0._onDragBegin(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0._startPos = arg_7_2.position.x
end

function var_0_0._onDragEnd(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_2.position.x

	if var_8_0 > arg_8_0._startPos and var_8_0 - arg_8_0._startPos >= 100 then
		arg_8_0:_btnprevOnClick(true)
	elseif var_8_0 < arg_8_0._startPos and arg_8_0._startPos - var_8_0 >= 100 then
		arg_8_0:_btnnextOnClick(true)
	end
end

function var_0_0._focusItem(arg_9_0)
	local var_9_0 = recthelper.getWidth(arg_9_0._scrollTabList.transform)
	local var_9_1 = 428
	local var_9_2 = #arg_9_0._topItemList * var_9_1 - var_9_0

	if var_9_2 < 0 then
		return
	end

	if var_9_2 >= (arg_9_0._selectChapter - 1) * var_9_1 then
		ZProj.TweenHelper.DOAnchorPosX(arg_9_0._trstabitemContent, -(arg_9_0._selectChapter - 1) * var_9_1, 0.26)
	else
		ZProj.TweenHelper.DOAnchorPosX(arg_9_0._trstabitemContent, -var_9_2, 0.26)
	end
end

function var_0_0._btnprevOnClick(arg_10_0, arg_10_1)
	local var_10_0, var_10_1 = arg_10_0:getFirstCGIdAndEpisodeId(arg_10_0._selectChapter)

	if var_10_0 == arg_10_0._cgId then
		if arg_10_0._selectChapter ~= arg_10_0._unlockChapterList[1] then
			arg_10_0._selectChapter = arg_10_0._selectChapter - 1

			if arg_10_0._selectChapter == 7 then
				arg_10_0._selectChapter = arg_10_0._selectChapter - 1
			end
		else
			arg_10_0._selectChapter = arg_10_0._unlockChapterList[#arg_10_0._unlockChapterList]
		end

		arg_10_0:_focusItem()
	end

	local var_10_2 = HandbookModel.instance:getPrevCG(arg_10_0._cgId, arg_10_0._cgType)

	if not var_10_2 then
		return
	end

	arg_10_0._cgId = var_10_2.id
	arg_10_0._episodeId = var_10_2.episodeId
	arg_10_0._cimagecg.enabled = false
	arg_10_0._cimagecgold.enabled = false

	gohelper.setActive(arg_10_0._gomasknode, false)
	gohelper.setActive(arg_10_0._gomasknodeold, false)
	arg_10_0:_refreshTop()

	if arg_10_1 then
		arg_10_0._animator:Play("switch_right", 0, 0)
	else
		arg_10_0._animator:Play("switch_left", 0, 0)
	end

	TaskDispatcher.runDelay(arg_10_0._afterPlayAnim, arg_10_0, 0.16)
end

function var_0_0._afterPlayAnim(arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0.autoSwitch, arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0._afterPlayAnim, arg_11_0)

	arg_11_0._cimagecg.enabled = true
	arg_11_0._cimagecgold.enabled = true

	gohelper.setActive(arg_11_0._gomasknode, true)
	gohelper.setActive(arg_11_0._gomasknodeold, true)
	arg_11_0:_refreshUI()
	arg_11_0:autoMoveBanner()
end

function var_0_0._btnnextOnClick(arg_12_0, arg_12_1)
	local var_12_0 = HandbookConfig.instance:getCGDictByChapter(arg_12_0._selectChapter)
	local var_12_1 = var_12_0[#var_12_0].id
	local var_12_2 = false

	if arg_12_0._selectChapter ~= arg_12_0._unlockChapterList[#arg_12_0._unlockChapterList] then
		if var_12_1 == arg_12_0._cgId then
			arg_12_0._selectChapter = arg_12_0._selectChapter + 1

			if arg_12_0._selectChapter == 7 then
				arg_12_0._selectChapter = arg_12_0._selectChapter + 1
			end

			arg_12_0:_focusItem()
		end
	elseif HandbookModel.instance:getCGUnlockCount(arg_12_0._selectChapter, arg_12_0._cgType) == HandbookModel.instance:getCGUnlockIndexInChapter(arg_12_0._selectChapter, arg_12_0._cgId, arg_12_0._cgType) then
		var_12_2 = true
		arg_12_0._selectChapter = 1
		arg_12_0._cgId = HandbookConfig.instance:getCGDictByChapter(arg_12_0._selectChapter)[1].id

		arg_12_0:_focusItem()
	end

	local var_12_3 = HandbookModel.instance:getNextCG(arg_12_0._cgId, arg_12_0._cgType)

	if var_12_2 then
		var_12_3 = HandbookConfig.instance:getCGConfig(arg_12_0._cgId)
	end

	if not var_12_3 then
		return
	end

	arg_12_0._cgId = var_12_3.id
	arg_12_0._episodeId = var_12_3.episodeId
	arg_12_0._cimagecg.enabled = false
	arg_12_0._cimagecgold.enabled = false

	gohelper.setActive(arg_12_0._gomasknode, false)
	gohelper.setActive(arg_12_0._gomasknodeold, false)
	arg_12_0:_refreshTop()

	if arg_12_1 then
		arg_12_0._animator:Play("switch_left", 0, 0)
	else
		arg_12_0._animator:Play("switch_right", 0, 0)
	end

	TaskDispatcher.runDelay(arg_12_0._afterPlayAnim, arg_12_0, 0.16)
end

function var_0_0._initTop(arg_13_0)
	arg_13_0._chapterList = {}
	arg_13_0._cgConfigList = HandbookConfig.instance:getDungeonCGList()
	arg_13_0._unlockChapterList = {}
	arg_13_0._dungeonChapterList = {}
	arg_13_0._dungeonChapterDict = HandbookConfig.instance:getCGDict()

	for iter_13_0, iter_13_1 in ipairs(arg_13_0._cgConfigList) do
		if HandbookModel.instance:isCGUnlock(iter_13_1.id) then
			local var_13_0 = iter_13_1.storyChapterId

			if not tabletool.indexOf(arg_13_0._unlockChapterList, var_13_0) then
				table.insert(arg_13_0._unlockChapterList, var_13_0)

				if #arg_13_0._unlockChapterList == tabletool.len(arg_13_0._dungeonChapterDict) then
					break
				end
			end
		end
	end

	for iter_13_2, iter_13_3 in pairs(arg_13_0._unlockChapterList) do
		local var_13_1 = HandbookConfig.instance:getStoryChapterConfig(iter_13_3)

		table.insert(arg_13_0._dungeonChapterList, var_13_1)
	end

	arg_13_0._selectChapter = arg_13_0._unlockChapterList[#arg_13_0._unlockChapterList]
	arg_13_0._cgId, arg_13_0._episodeId = arg_13_0:getFirstCGIdAndEpisodeId(arg_13_0._selectChapter)

	for iter_13_4, iter_13_5 in ipairs(arg_13_0._dungeonChapterList) do
		local var_13_2 = arg_13_0._topItemList[iter_13_4]

		if not var_13_2 then
			var_13_2 = arg_13_0:getUserDataTb_()
			var_13_2.go = gohelper.cloneInPlace(arg_13_0._gotabitem, "chapter" .. iter_13_5.id)

			gohelper.setActive(var_13_2.go, true)

			var_13_2.config = iter_13_5
			var_13_2.chapterId = iter_13_5.id
			var_13_2.golock = gohelper.findChild(var_13_2.go, "Locked")
			var_13_2.txtlockname = gohelper.findChildText(var_13_2.go, "Locked/#txt_lockedtab")
			var_13_2.gounlock = gohelper.findChild(var_13_2.go, "Unlock")
			var_13_2.goselected = gohelper.findChild(var_13_2.go, "Unlock/image_Selected")
			var_13_2.gonormal = gohelper.findChild(var_13_2.go, "Unlock/image_Normal")
			var_13_2.txtunlockname = gohelper.findChildText(var_13_2.go, "Unlock/#txt_unlocktab")
			var_13_2.btn = gohelper.findChildButton(var_13_2.go, "btn_click")

			var_13_2.btn:AddClickListener(arg_13_0._btnTopOnClick, arg_13_0, var_13_2)
			table.insert(arg_13_0._topItemList, var_13_2)
		end

		var_13_2.txtlockname.text = iter_13_5.name
		var_13_2.txtunlockname.text = iter_13_5.name
		var_13_2.unlock = arg_13_0:checkDungeonUnlock(var_13_2.chapterId)

		gohelper.setActive(var_13_2.gounlock, var_13_2.unlock)
		gohelper.setActive(var_13_2.golock, not var_13_2.unlock)

		local var_13_3 = var_13_2.chapterId == arg_13_0._selectChapter

		gohelper.setActive(var_13_2.goselected, var_13_3)
		gohelper.setActive(var_13_2.gonormal, not var_13_3)
	end
end

function var_0_0._btnTopOnClick(arg_14_0, arg_14_1)
	if not arg_14_1.unlock then
		return
	end

	local var_14_0 = arg_14_1.chapterId

	arg_14_0._selectChapter = var_14_0
	arg_14_0._cgId, arg_14_0._episodeId = arg_14_0:getFirstCGIdAndEpisodeId(var_14_0)

	arg_14_0:_refreshTop()
	arg_14_0:_refreshUI()
	arg_14_0:_focusItem()
	arg_14_0:autoMoveBanner()
end

function var_0_0.getEpisodeName(arg_15_0, arg_15_1)
	local var_15_0 = DungeonConfig.instance:getEpisodeCO(arg_15_1)
	local var_15_1 = var_15_0 and DungeonConfig.instance:getChapterCO(var_15_0.chapterId)

	if not var_15_0 or not var_15_1 then
		return nil
	end

	local var_15_2 = var_15_0.name

	if string.nilorempty(var_15_2) then
		local var_15_3 = DungeonConfig.instance:getChainEpisodeDict()

		for iter_15_0, iter_15_1 in pairs(var_15_3) do
			if iter_15_0 == arg_15_1 then
				var_15_0 = DungeonConfig.instance:getEpisodeCO(iter_15_1)
				var_15_1 = var_15_0 and DungeonConfig.instance:getChapterCO(var_15_0.chapterId)
			end
		end
	end

	local var_15_4 = var_15_1.chapterIndex
	local var_15_5, var_15_6 = DungeonConfig.instance:getChapterEpisodeIndexWithSP(var_15_1.id, var_15_0.id)

	if not arg_15_0._jumpEpisodeId then
		arg_15_0._jumpEpisodeId = var_15_0.id
	else
		arg_15_0._jumpEpisodeId = arg_15_0._lastEpisodeId
	end

	return string.format("%s-%s %s", var_15_4, var_15_5, var_15_0.name)
end

function var_0_0.getFirstCGIdAndEpisodeId(arg_16_0, arg_16_1)
	local var_16_0 = HandbookConfig.instance:getCGDictByChapter(arg_16_1)
	local var_16_1 = var_16_0[1].id
	local var_16_2 = var_16_0[1].episodeId

	return var_16_1, var_16_2
end

function var_0_0.checkDungeonUnlock(arg_17_0, arg_17_1)
	for iter_17_0, iter_17_1 in ipairs(arg_17_0._unlockChapterList) do
		if iter_17_1 == arg_17_1 then
			return true
		end
	end

	return false
end

function var_0_0._refreshTop(arg_18_0)
	for iter_18_0, iter_18_1 in ipairs(arg_18_0._topItemList) do
		local var_18_0 = iter_18_1.chapterId == arg_18_0._selectChapter

		gohelper.setActive(iter_18_1.goselected, var_18_0)
		gohelper.setActive(iter_18_1.gonormal, not var_18_0)
	end
end

function var_0_0.onOpen(arg_19_0)
	local var_19_0 = arg_19_0.viewParam.parent

	gohelper.addChild(var_19_0, arg_19_0.viewGO)
	arg_19_0:_initTop()
	arg_19_0:_refreshUI()
	arg_19_0:_initRightBtn()
	arg_19_0:_focusItem()
	arg_19_0:autoMoveBanner()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_paiqian_open)
end

function var_0_0._initRightBtn(arg_20_0)
	arg_20_0._jumpEpisodeId = nil
	arg_20_0.playerInfo = PlayerModel.instance:getPlayinfo()
	arg_20_0._lastEpisodeId = arg_20_0.playerInfo.lastEpisodeId
	arg_20_0._txtcurchapter.text = arg_20_0:getEpisodeName(arg_20_0._lastEpisodeId)
end

function var_0_0._refreshUI(arg_21_0)
	local var_21_0 = HandbookConfig.instance:getCGConfig(arg_21_0._cgId, arg_21_0._cgType)
	local var_21_1 = StoryBgZoneModel.instance:getBgZoneByPath(var_21_0.image)

	UIBlockMgr.instance:startBlock("loadZone")

	if var_21_1 then
		arg_21_0._simagezone:LoadImage(ResUrl.getStoryRes(var_21_1.path), arg_21_0._onZoneImageLoaded, arg_21_0)
	else
		gohelper.setActive(arg_21_0._simagezone.gameObject, false)

		arg_21_0._cimagecg.vecInSide = Vector4.zero

		arg_21_0:_startLoadOriginImg()
	end

	arg_21_0._txttitleName.text = var_21_0.name
	arg_21_0._txttitleNameEn.text = var_21_0.nameEn
	arg_21_0._txtdesc.text = var_21_0.desc
	arg_21_0._txtcurindex.text = HandbookModel.instance:getCGUnlockIndexInChapter(arg_21_0._selectChapter, arg_21_0._cgId, arg_21_0._cgType)
	arg_21_0._txttotalpage.text = "/" .. HandbookModel.instance:getCGUnlockCount(arg_21_0._selectChapter, arg_21_0._cgType)
	arg_21_0._txtchapter.text = arg_21_0:getEpisodeName(arg_21_0._episodeId)
end

function var_0_0._startLoadOriginImg(arg_22_0)
	local var_22_0 = HandbookConfig.instance:getCGConfig(arg_22_0._cgId, arg_22_0._cgType)

	arg_22_0._simagecg:LoadImage(arg_22_0:getImageName(var_22_0), arg_22_0.onLoadedImage, arg_22_0)
end

function var_0_0._onZoneImageLoaded(arg_23_0)
	arg_23_0._imageZone:SetNativeSize()
	arg_23_0:_startLoadOriginImg()
end

function var_0_0.getImageName(arg_24_0, arg_24_1)
	if not tabletool.indexOf(arg_24_0.loadedCgList, arg_24_1.id) then
		table.insert(arg_24_0.loadedCgList, arg_24_1.id)
	end

	arg_24_0.lastLoadImageId = arg_24_1.id

	local var_24_0 = StoryBgZoneModel.instance:getBgZoneByPath(arg_24_1.image)

	if var_24_0 then
		return ResUrl.getStoryRes(var_24_0.sourcePath)
	end

	return ResUrl.getStoryBg(arg_24_1.image)
end

function var_0_0.onLoadedImage(arg_25_0)
	local var_25_0 = HandbookConfig.instance:getCGConfig(arg_25_0._cgId, arg_25_0._cgType)
	local var_25_1 = StoryBgZoneModel.instance:getBgZoneByPath(var_25_0.image)

	if var_25_1 then
		gohelper.setActive(arg_25_0._simagezone.gameObject, true)
		transformhelper.setLocalPosXY(arg_25_0._simagezone.gameObject.transform, var_25_1.offsetX, var_25_1.offsetY)

		local var_25_2 = HandbookConfig.instance:getCGConfig(arg_25_0._cgId, arg_25_0._cgType)
		local var_25_3 = StoryBgZoneModel.instance:getBgZoneByPath(var_25_2.image)
		local var_25_4 = Vector4(recthelper.getWidth(arg_25_0._imageZone.transform), recthelper.getHeight(arg_25_0._imageZone.transform), var_25_3.offsetX, var_25_3.offsetY)

		arg_25_0._cimagecg.vecInSide = var_25_4

		arg_25_0:_loadOldZoneImage()
	else
		gohelper.setActive(arg_25_0._simagezoneold.gameObject, false)
		arg_25_0:_startLoadOldImg()
	end

	gohelper.setActive(arg_25_0._simagecg.gameObject, true)

	if #arg_25_0.loadedCgList <= 10 then
		return
	end

	arg_25_0.loadedCgList = {
		arg_25_0.lastLoadImageId
	}

	GameGCMgr.instance:dispatchEvent(GameGCEvent.FullGC, arg_25_0)
end

function var_0_0._loadOldZoneImage(arg_26_0)
	local var_26_0 = HandbookConfig.instance:getCGConfig(arg_26_0._cgId, arg_26_0._cgType)
	local var_26_1 = StoryBgZoneModel.instance:getBgZoneByPath(var_26_0.image)

	if var_26_1 then
		arg_26_0._simagezoneold:LoadImage(ResUrl.getStoryRes(var_26_1.path), arg_26_0._onZoneImageOldLoaded, arg_26_0)
	else
		gohelper.setActive(arg_26_0._simagezoneold.gameObject, false)

		arg_26_0._cimagecgold.vecInSide = Vector4.zero

		arg_26_0:_startLoadOldImg()
	end
end

function var_0_0._onZoneImageOldLoaded(arg_27_0)
	arg_27_0._imageZoneOld:SetNativeSize()
	arg_27_0:_startLoadOldImg()
end

function var_0_0._startLoadOldImg(arg_28_0)
	local var_28_0 = HandbookConfig.instance:getCGConfig(arg_28_0._cgId, arg_28_0._cgType)

	arg_28_0._simagecgold:LoadImage(arg_28_0:getImageName(var_28_0), arg_28_0._onLoadOldFinished, arg_28_0)
end

function var_0_0._onLoadOldFinished(arg_29_0)
	UIBlockMgr.instance:endBlock("loadZone")

	local var_29_0 = HandbookConfig.instance:getCGConfig(arg_29_0._cgId, arg_29_0._cgType)
	local var_29_1 = StoryBgZoneModel.instance:getBgZoneByPath(var_29_0.image)

	if var_29_1 then
		gohelper.setActive(arg_29_0._simagezoneold.gameObject, true)
		transformhelper.setLocalPosXY(arg_29_0._simagezoneold.gameObject.transform, var_29_1.offsetX, var_29_1.offsetY)

		local var_29_2 = HandbookConfig.instance:getCGConfig(arg_29_0._cgId, arg_29_0._cgType)
		local var_29_3 = StoryBgZoneModel.instance:getBgZoneByPath(var_29_2.image)
		local var_29_4 = Vector4(recthelper.getWidth(arg_29_0._imageZoneOld.transform), recthelper.getHeight(arg_29_0._imageZoneOld.transform), var_29_3.offsetX, var_29_3.offsetY)

		arg_29_0._cimagecgold.vecInSide = var_29_4
	end

	gohelper.setActive(arg_29_0._simagecg.gameObject, false)
	gohelper.setActive(arg_29_0._simagecgold.gameObject, true)
end

function var_0_0.autoMoveBanner(arg_30_0)
	TaskDispatcher.cancelTask(arg_30_0.autoSwitch, arg_30_0)
	TaskDispatcher.runRepeat(arg_30_0.autoSwitch, arg_30_0, 3)
end

function var_0_0.autoSwitch(arg_31_0)
	arg_31_0:_btnnextOnClick()
end

function var_0_0.onDungeonUpdate(arg_32_0)
	arg_32_0:_initTop()
	arg_32_0:_refreshUI()
	arg_32_0:_initRightBtn()
	arg_32_0:_focusItem()
	arg_32_0:autoMoveBanner()
end

function var_0_0.onClose(arg_33_0)
	UIBlockMgr.instance:endBlock("loadZone")
	arg_33_0._drag:RemoveDragBeginListener()
	arg_33_0._drag:RemoveDragEndListener()

	for iter_33_0, iter_33_1 in ipairs(arg_33_0._topItemList) do
		iter_33_1.btn:RemoveClickListener()
	end

	TaskDispatcher.cancelTask(arg_33_0._afterPlayAnim, arg_33_0)
end

function var_0_0.onDestroyView(arg_34_0)
	arg_34_0._simagecg:UnLoadImage()
	TaskDispatcher.cancelTask(arg_34_0.autoSwitch, arg_34_0)
	TaskDispatcher.cancelTask(arg_34_0._afterPlayAnim, arg_34_0)
end

return var_0_0
