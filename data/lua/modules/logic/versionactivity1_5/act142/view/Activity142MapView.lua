module("modules.logic.versionactivity1_5.act142.view.Activity142MapView", package.seeall)

local var_0_0 = class("Activity142MapView", BaseView)
local var_0_1 = 1

function var_0_0.onInitView(arg_1_0)
	arg_1_0._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_1_0.viewGO)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._gotime = gohelper.findChild(arg_1_0.viewGO, "#go_time")
	arg_1_0._txtremainTime = gohelper.findChildText(arg_1_0.viewGO, "#go_time/#txt_remainTime")
	arg_1_0._gocategory = gohelper.findChild(arg_1_0.viewGO, "#go_category")
	arg_1_0._gocategoryitem = gohelper.findChild(arg_1_0.viewGO, "#go_category/#go_categoryitem")
	arg_1_0._gomapcontainer = gohelper.findChild(arg_1_0.viewGO, "#go_mapcontainer")
	arg_1_0._gomapitem = gohelper.findChild(arg_1_0.viewGO, "#go_mapcontainer/#go_mapitem")
	arg_1_0._goMapNode3 = gohelper.findChild(arg_1_0.viewGO, "#go_mapcontainer/#go_mapnode3")
	arg_1_0._goMapNodeSP = gohelper.findChild(arg_1_0.viewGO, "#go_mapcontainer/#go_mapnodesp")
	arg_1_0._btntask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_task")
	arg_1_0._goRedDotRoot = gohelper.findChild(arg_1_0.viewGO, "#btn_task/#go_reddotreward")
	arg_1_0._btncollect = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_collect")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btntask:AddClickListener(arg_2_0._btntaskOnClick, arg_2_0)
	arg_2_0._btncollect:AddClickListener(arg_2_0._btncollectOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btntask:RemoveClickListener()
	arg_3_0._btncollect:RemoveClickListener()
end

function var_0_0._btntaskOnClick(arg_4_0)
	ViewMgr.instance:openView(ViewName.Activity142TaskView)
end

function var_0_0._btncollectOnClick(arg_5_0)
	local var_5_0 = Activity142Model.instance:getActivityId()

	Activity142Rpc.instance:sendGetAct142CollectionsRequest(var_5_0, function()
		Activity142StatController.instance:statCollectionViewStart()
		ViewMgr.instance:openView(ViewName.Activity142CollectView)
	end)
end

function var_0_0._onCategoryItemClick(arg_7_0, arg_7_1, arg_7_2)
	if not arg_7_1 or arg_7_0._selectCategoryIndex == arg_7_1 then
		return
	end

	local var_7_0 = arg_7_0:getCategoryItemByIndex(arg_7_1)

	if not var_7_0 then
		return
	end

	if arg_7_0._selectCategoryIndex then
		local var_7_1 = arg_7_0:getCategoryItemByIndex(arg_7_0._selectCategoryIndex)

		if var_7_1 then
			var_7_1:setIsSelected(false)
		end
	end

	var_7_0:setIsSelected(true)

	arg_7_0._selectCategoryIndex = arg_7_1

	if arg_7_2 then
		arg_7_0:_setMapItems()
	else
		arg_7_0:playViewAnimation(Activity142Enum.MAP_VIEW_SWITCH_ANIM)
		TaskDispatcher.runDelay(arg_7_0._setMapItems, arg_7_0, Activity142Enum.MAP_VIEW_SWITCH_SET_MAP_ITEM_ANIM_TIME)
	end
end

function var_0_0._setMapItems(arg_8_0)
	if not arg_8_0._selectCategoryIndex then
		return
	end

	local var_8_0 = arg_8_0:getCategoryItemByIndex(arg_8_0._selectCategoryIndex)

	if not var_8_0 then
		return
	end

	local var_8_1 = var_8_0:getChapterId()
	local var_8_2 = Activity142Model.instance:getActivityId()
	local var_8_3 = Activity142Config.instance:getChapterEpisodeIdList(var_8_2, var_8_1)
	local var_8_4 = Activity142Config.instance:isSPChapter(var_8_1)

	for iter_8_0 = 1, Activity142Enum.MAX_EPISODE_SINGLE_CHAPTER do
		local var_8_5 = var_8_3[iter_8_0]

		if var_8_4 and iter_8_0 > Activity142Enum.MAX_EPISODE_SINGLE_SP_CHAPTER then
			var_8_5 = nil
		end

		local var_8_6 = arg_8_0._mapItemList[iter_8_0]

		if var_8_6 then
			local var_8_7 = false

			var_8_6:setEpisodeId(var_8_5)

			if iter_8_0 == Activity142Enum.MAX_EPISODE_SINGLE_SP_CHAPTER then
				var_8_7 = var_8_4

				local var_8_8 = var_8_4 and arg_8_0._goMapNodeSP or arg_8_0._goMapNode3

				var_8_6:setParent(var_8_8)
			end

			var_8_6:setBg(var_8_7)
		end
	end
end

function var_0_0._onMapItemClick(arg_9_0, arg_9_1)
	if not arg_9_1 then
		return
	end

	local var_9_0 = Activity142Model.instance:getActivityId()

	if Activity142Model.instance:isEpisodeOpen(var_9_0, arg_9_1) then
		arg_9_0._tmpEnterEpisode = arg_9_1

		arg_9_0:playViewAnimation(UIAnimationName.Close)
		AudioMgr.instance:trigger(AudioEnum.ui_activity142.CloseMapView)
		TaskDispatcher.runDelay(arg_9_0._enterEpisode, arg_9_0, Activity142Enum.CLOSE_MAP_VIEW_TIME)
	else
		Activity142Helper.showToastByEpisodeId(arg_9_1)
	end
end

function var_0_0._enterEpisode(arg_10_0)
	if not arg_10_0._tmpEnterEpisode then
		arg_10_0:closeThis()

		return
	end

	Activity142Controller.instance:enterChessGame(arg_10_0._tmpEnterEpisode)

	arg_10_0._tmpEnterEpisode = nil
end

function var_0_0._editableInitView(arg_11_0)
	arg_11_0._mapItemList = {}

	for iter_11_0 = 1, Activity142Enum.MAX_EPISODE_SINGLE_CHAPTER do
		local var_11_0 = gohelper.findChild(arg_11_0.viewGO, "#go_mapcontainer/#go_mapnode" .. iter_11_0)

		if var_11_0 then
			local var_11_1 = gohelper.clone(arg_11_0._gomapitem, var_11_0, "mapItem" .. iter_11_0)
			local var_11_2 = {
				clickCb = arg_11_0._onMapItemClick,
				clickCbObj = arg_11_0
			}
			local var_11_3 = MonoHelper.addNoUpdateLuaComOnceToGo(var_11_1, Activity142MapItem, var_11_2)

			arg_11_0._mapItemList[#arg_11_0._mapItemList + 1] = var_11_3
		end
	end

	arg_11_0:_initCategoryItems()
	gohelper.setActive(arg_11_0._gocategoryitem, false)
	gohelper.setActive(arg_11_0._gomapitem, false)
	RedDotController.instance:addRedDot(arg_11_0._goRedDotRoot, RedDotEnum.DotNode.v1a5Activity142TaskReward)
	gohelper.setActive(arg_11_0._gotime, false)
end

function var_0_0._initCategoryItems(arg_12_0)
	arg_12_0._selectCategoryIndex = nil
	arg_12_0._categoryItemList = {}

	local var_12_0 = var_0_1
	local var_12_1 = Activity142Model.instance:getActivityId()
	local var_12_2 = Activity142Config.instance:getChapterList(var_12_1)

	for iter_12_0, iter_12_1 in ipairs(var_12_2) do
		local var_12_3 = gohelper.clone(arg_12_0._gocategoryitem, arg_12_0._gocategory, "categoryItem" .. iter_12_1)
		local var_12_4 = {
			index = iter_12_0,
			clickCb = arg_12_0._onCategoryItemClick,
			clickCbObj = arg_12_0
		}
		local var_12_5 = MonoHelper.addNoUpdateLuaComOnceToGo(var_12_3, Activity142MapCategoryItem, var_12_4)

		var_12_5:setChapterId(iter_12_1)

		arg_12_0._categoryItemList[iter_12_0] = var_12_5

		if Activity142Model.instance:isChapterOpen(iter_12_1) and var_12_0 < iter_12_0 then
			var_12_0 = iter_12_0
		end
	end

	local var_12_6 = arg_12_0:getCategoryItemByIndex(var_12_0)

	if var_12_6 then
		var_12_6:onClick(true)
	end
end

function var_0_0.onOpen(arg_13_0)
	arg_13_0:_startRefreshRemainTime()
end

function var_0_0.onSetVisible(arg_14_0, arg_14_1)
	if not arg_14_1 then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.ui_activity142.OpenMapView)
	arg_14_0:refresh(Activity142Enum.OPEN_MAP_VIEW_TIME)
end

function var_0_0.refresh(arg_15_0, arg_15_1)
	arg_15_0:_refreshCategoryItems()
	arg_15_0:_refreshMapItems(arg_15_1)
end

function var_0_0._refreshCategoryItems(arg_16_0)
	for iter_16_0, iter_16_1 in ipairs(arg_16_0._categoryItemList) do
		iter_16_1:refresh()
	end
end

function var_0_0._refreshMapItems(arg_17_0, arg_17_1)
	for iter_17_0, iter_17_1 in ipairs(arg_17_0._mapItemList) do
		iter_17_1:refresh(arg_17_1)
	end
end

function var_0_0._startRefreshRemainTime(arg_18_0)
	arg_18_0:_refreshRemainTime()
	TaskDispatcher.runRepeat(arg_18_0._refreshRemainTime, arg_18_0, TimeUtil.OneMinuteSecond)
end

function var_0_0._refreshRemainTime(arg_19_0)
	if gohelper.isNil(arg_19_0._txtremainTime) then
		TaskDispatcher.cancelTask(arg_19_0._refreshRemainTime, arg_19_0)

		return
	end

	local var_19_0 = Activity142Model.instance:getActivityId()
	local var_19_1 = Activity142Model.instance:getRemainTimeStr(var_19_0)

	arg_19_0._txtremainTime.text = var_19_1
end

function var_0_0.playViewAnimation(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	if arg_20_0._animatorPlayer then
		Activity142Helper.setAct142UIBlock(true, Activity142Enum.PLAY_MAP_VIEW_ANIM)
		arg_20_0._animatorPlayer:Play(arg_20_1, arg_20_0.playViewAnimationFinish, arg_20_0)

		arg_20_0._tmpAnimCb = arg_20_2
		arg_20_0._tmpAnimCbObj = arg_20_3
	elseif arg_20_2 then
		arg_20_2(arg_20_3)
	end
end

function var_0_0.playViewAnimationFinish(arg_21_0)
	if arg_21_0._tmpAnimCb then
		arg_21_0._tmpAnimCb(arg_21_0._tmpAnimCbObj)
	end

	arg_21_0._tmpAnimCb = nil
	arg_21_0._tmpAnimCbObj = nil

	Activity142Helper.setAct142UIBlock(false, Activity142Enum.PLAY_MAP_VIEW_ANIM)
end

function var_0_0.getCategoryItemByIndex(arg_22_0, arg_22_1)
	local var_22_0

	if arg_22_0._categoryItemList then
		var_22_0 = arg_22_0._categoryItemList[arg_22_1]
	end

	if not var_22_0 then
		logError("Activity142MapView:getCategoryItemByIndex error, can't find category item, index:", arg_22_1 or "nil")
	end

	return var_22_0
end

function var_0_0.onClose(arg_23_0)
	TaskDispatcher.cancelTask(arg_23_0._setMapItems, arg_23_0)
	TaskDispatcher.cancelTask(arg_23_0._refreshRemainTime, arg_23_0)
	TaskDispatcher.cancelTask(arg_23_0._enterEpisode, arg_23_0)
end

function var_0_0.onDestroyView(arg_24_0)
	arg_24_0._selectCategoryIndex = nil
	arg_24_0._categoryItemList = {}
	arg_24_0._mapItemList = {}
	arg_24_0._tmpAnimCb = nil
	arg_24_0._tmpAnimCbObj = nil

	Activity142Helper.setAct142UIBlock(false, Activity142Enum.PLAY_MAP_VIEW_ANIM)
end

return var_0_0
