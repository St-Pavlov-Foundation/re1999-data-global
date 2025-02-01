module("modules.logic.versionactivity1_5.act142.view.Activity142MapView", package.seeall)

slot0 = class("Activity142MapView", BaseView)
slot1 = 1

function slot0.onInitView(slot0)
	slot0._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(slot0.viewGO)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._gotime = gohelper.findChild(slot0.viewGO, "#go_time")
	slot0._txtremainTime = gohelper.findChildText(slot0.viewGO, "#go_time/#txt_remainTime")
	slot0._gocategory = gohelper.findChild(slot0.viewGO, "#go_category")
	slot0._gocategoryitem = gohelper.findChild(slot0.viewGO, "#go_category/#go_categoryitem")
	slot0._gomapcontainer = gohelper.findChild(slot0.viewGO, "#go_mapcontainer")
	slot0._gomapitem = gohelper.findChild(slot0.viewGO, "#go_mapcontainer/#go_mapitem")
	slot0._goMapNode3 = gohelper.findChild(slot0.viewGO, "#go_mapcontainer/#go_mapnode3")
	slot0._goMapNodeSP = gohelper.findChild(slot0.viewGO, "#go_mapcontainer/#go_mapnodesp")
	slot0._btntask = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_task")
	slot0._goRedDotRoot = gohelper.findChild(slot0.viewGO, "#btn_task/#go_reddotreward")
	slot0._btncollect = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_collect")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btntask:AddClickListener(slot0._btntaskOnClick, slot0)
	slot0._btncollect:AddClickListener(slot0._btncollectOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btntask:RemoveClickListener()
	slot0._btncollect:RemoveClickListener()
end

function slot0._btntaskOnClick(slot0)
	ViewMgr.instance:openView(ViewName.Activity142TaskView)
end

function slot0._btncollectOnClick(slot0)
	Activity142Rpc.instance:sendGetAct142CollectionsRequest(Activity142Model.instance:getActivityId(), function ()
		Activity142StatController.instance:statCollectionViewStart()
		ViewMgr.instance:openView(ViewName.Activity142CollectView)
	end)
end

function slot0._onCategoryItemClick(slot0, slot1, slot2)
	if not slot1 or slot0._selectCategoryIndex == slot1 then
		return
	end

	if not slot0:getCategoryItemByIndex(slot1) then
		return
	end

	if slot0._selectCategoryIndex and slot0:getCategoryItemByIndex(slot0._selectCategoryIndex) then
		slot4:setIsSelected(false)
	end

	slot3:setIsSelected(true)

	slot0._selectCategoryIndex = slot1

	if slot2 then
		slot0:_setMapItems()
	else
		slot0:playViewAnimation(Activity142Enum.MAP_VIEW_SWITCH_ANIM)
		TaskDispatcher.runDelay(slot0._setMapItems, slot0, Activity142Enum.MAP_VIEW_SWITCH_SET_MAP_ITEM_ANIM_TIME)
	end
end

function slot0._setMapItems(slot0)
	if not slot0._selectCategoryIndex then
		return
	end

	if not slot0:getCategoryItemByIndex(slot0._selectCategoryIndex) then
		return
	end

	slot2 = slot1:getChapterId()

	for slot9 = 1, Activity142Enum.MAX_EPISODE_SINGLE_CHAPTER do
		slot10 = Activity142Config.instance:getChapterEpisodeIdList(Activity142Model.instance:getActivityId(), slot2)[slot9]

		if Activity142Config.instance:isSPChapter(slot2) and Activity142Enum.MAX_EPISODE_SINGLE_SP_CHAPTER < slot9 then
			slot10 = nil
		end

		if slot0._mapItemList[slot9] then
			slot12 = false

			slot11:setEpisodeId(slot10)

			if slot9 == Activity142Enum.MAX_EPISODE_SINGLE_SP_CHAPTER then
				slot12 = slot5

				slot11:setParent(slot5 and slot0._goMapNodeSP or slot0._goMapNode3)
			end

			slot11:setBg(slot12)
		end
	end
end

function slot0._onMapItemClick(slot0, slot1)
	if not slot1 then
		return
	end

	if Activity142Model.instance:isEpisodeOpen(Activity142Model.instance:getActivityId(), slot1) then
		slot0._tmpEnterEpisode = slot1

		slot0:playViewAnimation(UIAnimationName.Close)
		AudioMgr.instance:trigger(AudioEnum.ui_activity142.CloseMapView)
		TaskDispatcher.runDelay(slot0._enterEpisode, slot0, Activity142Enum.CLOSE_MAP_VIEW_TIME)
	else
		Activity142Helper.showToastByEpisodeId(slot1)
	end
end

function slot0._enterEpisode(slot0)
	if not slot0._tmpEnterEpisode then
		slot0:closeThis()

		return
	end

	Activity142Controller.instance:enterChessGame(slot0._tmpEnterEpisode)

	slot0._tmpEnterEpisode = nil
end

function slot0._editableInitView(slot0)
	slot0._mapItemList = {}

	for slot4 = 1, Activity142Enum.MAX_EPISODE_SINGLE_CHAPTER do
		if gohelper.findChild(slot0.viewGO, "#go_mapcontainer/#go_mapnode" .. slot4) then
			slot0._mapItemList[#slot0._mapItemList + 1] = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.clone(slot0._gomapitem, slot5, "mapItem" .. slot4), Activity142MapItem, {
				clickCb = slot0._onMapItemClick,
				clickCbObj = slot0
			})
		end
	end

	slot0:_initCategoryItems()
	gohelper.setActive(slot0._gocategoryitem, false)
	gohelper.setActive(slot0._gomapitem, false)
	RedDotController.instance:addRedDot(slot0._goRedDotRoot, RedDotEnum.DotNode.v1a5Activity142TaskReward)
	gohelper.setActive(slot0._gotime, false)
end

function slot0._initCategoryItems(slot0)
	slot0._selectCategoryIndex = nil
	slot0._categoryItemList = {}

	for slot7, slot8 in ipairs(Activity142Config.instance:getChapterList(Activity142Model.instance:getActivityId())) do
		slot11 = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.clone(slot0._gocategoryitem, slot0._gocategory, "categoryItem" .. slot8), Activity142MapCategoryItem, {
			index = slot7,
			clickCb = slot0._onCategoryItemClick,
			clickCbObj = slot0
		})

		slot11:setChapterId(slot8)

		slot0._categoryItemList[slot7] = slot11

		if Activity142Model.instance:isChapterOpen(slot8) and uv0 < slot7 then
			slot1 = slot7
		end
	end

	if slot0:getCategoryItemByIndex(slot1) then
		slot4:onClick(true)
	end
end

function slot0.onOpen(slot0)
	slot0:_startRefreshRemainTime()
end

function slot0.onSetVisible(slot0, slot1)
	if not slot1 then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.ui_activity142.OpenMapView)
	slot0:refresh(Activity142Enum.OPEN_MAP_VIEW_TIME)
end

function slot0.refresh(slot0, slot1)
	slot0:_refreshCategoryItems()
	slot0:_refreshMapItems(slot1)
end

function slot0._refreshCategoryItems(slot0)
	for slot4, slot5 in ipairs(slot0._categoryItemList) do
		slot5:refresh()
	end
end

function slot0._refreshMapItems(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._mapItemList) do
		slot6:refresh(slot1)
	end
end

function slot0._startRefreshRemainTime(slot0)
	slot0:_refreshRemainTime()
	TaskDispatcher.runRepeat(slot0._refreshRemainTime, slot0, TimeUtil.OneMinuteSecond)
end

function slot0._refreshRemainTime(slot0)
	if gohelper.isNil(slot0._txtremainTime) then
		TaskDispatcher.cancelTask(slot0._refreshRemainTime, slot0)

		return
	end

	slot0._txtremainTime.text = Activity142Model.instance:getRemainTimeStr(Activity142Model.instance:getActivityId())
end

function slot0.playViewAnimation(slot0, slot1, slot2, slot3)
	if slot0._animatorPlayer then
		Activity142Helper.setAct142UIBlock(true, Activity142Enum.PLAY_MAP_VIEW_ANIM)
		slot0._animatorPlayer:Play(slot1, slot0.playViewAnimationFinish, slot0)

		slot0._tmpAnimCb = slot2
		slot0._tmpAnimCbObj = slot3
	elseif slot2 then
		slot2(slot3)
	end
end

function slot0.playViewAnimationFinish(slot0)
	if slot0._tmpAnimCb then
		slot0._tmpAnimCb(slot0._tmpAnimCbObj)
	end

	slot0._tmpAnimCb = nil
	slot0._tmpAnimCbObj = nil

	Activity142Helper.setAct142UIBlock(false, Activity142Enum.PLAY_MAP_VIEW_ANIM)
end

function slot0.getCategoryItemByIndex(slot0, slot1)
	slot2 = nil

	if slot0._categoryItemList then
		slot2 = slot0._categoryItemList[slot1]
	end

	if not slot2 then
		logError("Activity142MapView:getCategoryItemByIndex error, can't find category item, index:", slot1 or "nil")
	end

	return slot2
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._setMapItems, slot0)
	TaskDispatcher.cancelTask(slot0._refreshRemainTime, slot0)
	TaskDispatcher.cancelTask(slot0._enterEpisode, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._selectCategoryIndex = nil
	slot0._categoryItemList = {}
	slot0._mapItemList = {}
	slot0._tmpAnimCb = nil
	slot0._tmpAnimCbObj = nil

	Activity142Helper.setAct142UIBlock(false, Activity142Enum.PLAY_MAP_VIEW_ANIM)
end

return slot0
