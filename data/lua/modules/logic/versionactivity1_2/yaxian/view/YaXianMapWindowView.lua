module("modules.logic.versionactivity1_2.yaxian.view.YaXianMapWindowView", package.seeall)

local var_0_0 = class("YaXianMapWindowView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "window/bottom/#go_node/node1/#go_select")
	arg_1_0._txtindex = gohelper.findChildText(arg_1_0.viewGO, "window/bottom/#go_node/node1/info/#txt_nodename/#txt_index")
	arg_1_0._txtnodenameen = gohelper.findChildText(arg_1_0.viewGO, "window/bottom/#go_node/node1/info/#txt_nodename/#txt_nodename_en")
	arg_1_0._simagetitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "window/title/#simage_title")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "window/title/#txt_time")

	gohelper.setActive(arg_1_0._txttime, false)

	arg_1_0._simagebottom = gohelper.findChildSingleImage(arg_1_0.viewGO, "window/bottom/#simage_bottom")
	arg_1_0._goleft = gohelper.findChild(arg_1_0.viewGO, "#go_left")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

var_0_0.UnlockKey = "YaXianMapWindowViewUnlockKey"

function var_0_0.onRewardClick(arg_4_0)
	ViewMgr.instance:openView(ViewName.YaXianRewardView)
end

function var_0_0.onCollectClick(arg_5_0)
	ViewMgr.instance:openView(ViewName.YaXianCollectView)
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._simagebottom:LoadImage(ResUrl.getYaXianImage("img_quyu_bg"))

	arg_6_0.txtReward = gohelper.findChildText(arg_6_0.viewGO, "window/righttop/reward/#txt_reward")
	arg_6_0.txtCollect = gohelper.findChildText(arg_6_0.viewGO, "window/righttop/collect/#txt_collect")
	arg_6_0.collectClick = gohelper.findChildClick(arg_6_0.viewGO, "window/righttop/collect/clickArea")

	arg_6_0.collectClick:AddClickListener(arg_6_0.onCollectClick, arg_6_0)

	arg_6_0.rewardClick = gohelper.findChildClick(arg_6_0.viewGO, "window/righttop/reward/clickArea")

	arg_6_0.rewardClick:AddClickListener(arg_6_0.onRewardClick, arg_6_0)

	arg_6_0.goRedDot = gohelper.findChild(arg_6_0.viewGO, "window/righttop/reward/reddot")

	RedDotController.instance:addRedDot(arg_6_0.goRedDot, RedDotEnum.DotNode.YaXianReward)

	arg_6_0.chapterNodeList = {}
	arg_6_0.chapterAnimatorList = arg_6_0:getUserDataTb_()

	for iter_6_0 = 1, 3 do
		local var_6_0 = arg_6_0:getUserDataTb_()

		var_6_0.index = iter_6_0
		var_6_0.go = gohelper.findChild(arg_6_0.viewGO, "window/bottom/#go_node/node" .. iter_6_0)
		var_6_0.goSelect = gohelper.findChild(var_6_0.go, "#go_select")
		var_6_0.goLock = gohelper.findChild(var_6_0.go, "#go_lock")
		var_6_0.txtChapterName = gohelper.findChildText(var_6_0.go, "info/#txt_nodename")
		var_6_0.txtChapterNameEn = gohelper.findChildText(var_6_0.go, "info/#txt_nodename/#txt_nodename_en")
		var_6_0.txtChapterIndex = gohelper.findChildText(var_6_0.go, "info/#txt_nodename/#txt_index")
		var_6_0.click = gohelper.findChildClick(var_6_0.go, "clickarea")

		var_6_0.click:AddClickListener(arg_6_0.onClickChapterItem, arg_6_0, var_6_0)
		table.insert(arg_6_0.chapterAnimatorList, var_6_0.go:GetComponent(typeof(UnityEngine.Animator)))
		table.insert(arg_6_0.chapterNodeList, var_6_0)
	end

	arg_6_0:addEventCb(YaXianController.instance, YaXianEvent.OnSelectChapterChange, arg_6_0.onSelectChapterChange, arg_6_0)
	arg_6_0:addEventCb(YaXianController.instance, YaXianEvent.OnUpdateEpisodeInfo, arg_6_0.onUpdateEpisodeInfo, arg_6_0)
	arg_6_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_6_0._onCloseViewFinish, arg_6_0, LuaEventSystem.Low)
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0.lastCanFightChapterId = YaXianModel.instance:getLastCanFightEpisodeMo().config.chapterId
	arg_8_0.chapterCoList = YaXianConfig.instance:getChapterConfigList()

	arg_8_0:refreshUI()
end

function var_0_0.refreshUI(arg_9_0)
	arg_9_0.chapterId = arg_9_0.viewContainer.chapterId

	arg_9_0:refreshTxt()
	arg_9_0:refreshChapterUI()
end

function var_0_0.refreshTxt(arg_10_0)
	arg_10_0.txtReward.text = YaXianModel.instance:getScore() .. "/" .. YaXianConfig.instance:getMaxBonusScore()
	arg_10_0.txtCollect.text = YaXianModel.instance:getHadToothCount() - 1 .. "/" .. #lua_activity115_tooth.configList - 1
end

function var_0_0.refreshChapterUI(arg_11_0)
	for iter_11_0, iter_11_1 in ipairs(arg_11_0.chapterCoList) do
		arg_11_0:refreshChapterItem(iter_11_1, arg_11_0.chapterNodeList[iter_11_0])
	end

	if arg_11_0:isPlayedChapterUnlockAnimation(arg_11_0.chapterId) then
		return
	end

	arg_11_0:playChapterUnlockAnimation(arg_11_0.chapterId, arg_11_0.unlockAnimationDone)
end

function var_0_0.refreshTime(arg_12_0)
	local var_12_0, var_12_1 = ActivityModel.instance:getActivityInfo()[YaXianEnum.ActivityId]:getRemainTime()

	if LangSettings.instance:isEn() then
		arg_12_0._txttime.text = string.format(luaLang("remain"), string.format("%s%s", var_12_0, var_12_1))
	else
		arg_12_0._txttime.text = string.format(luaLang("remain"), string.format("<nbsp>%s<nbsp>%s", var_12_0, var_12_1))
	end
end

function var_0_0.refreshChapterItem(arg_13_0, arg_13_1, arg_13_2)
	gohelper.setActive(arg_13_2.goSelect, arg_13_0.chapterId == arg_13_1.id)
	gohelper.setActive(arg_13_2.goLock, not YaXianController.instance:checkChapterIsUnlock(arg_13_1.id))

	arg_13_2.txtChapterName.text = arg_13_1.name
	arg_13_2.txtChapterNameEn.text = arg_13_1.name_En
	arg_13_2.txtChapterIndex.text = arg_13_1.id
end

function var_0_0.onClickChapterItem(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0.chapterCoList[arg_14_1.index]

	if arg_14_0.chapterId == var_14_0.id then
		return
	end

	local var_14_1 = YaXianController.instance:getChapterStatus(var_14_0.id)

	if var_14_1 == YaXianEnum.ChapterStatus.notOpen then
		local var_14_2, var_14_3 = OpenHelper.getToastIdAndParam(var_14_0.openId)

		GameFacade.showToastWithTableParam(var_14_2, var_14_3)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_search_clear)

		return
	end

	if var_14_1 == YaXianEnum.ChapterStatus.Lock then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_search_clear)
		GameFacade.showToast(ToastEnum.ConditionLock)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_skin_tag)
	arg_14_0.viewContainer:changeChapterId(var_14_0.id)
end

function var_0_0.onSelectChapterChange(arg_15_0)
	arg_15_0:refreshUI()
end

function var_0_0.onUpdateEpisodeInfo(arg_16_0)
	arg_16_0:refreshTxt()

	local var_16_0 = YaXianModel.instance:getLastCanFightEpisodeMo().config.chapterId

	if var_16_0 == arg_16_0.lastCanFightChapterId then
		arg_16_0.nextChapterId = nil

		return
	end

	if not YaXianController.instance:checkChapterIsUnlock(var_16_0) then
		arg_16_0.nextChapterId = nil

		return
	end

	arg_16_0.nextChapterId = var_16_0
end

function var_0_0._onCloseViewFinish(arg_17_0)
	if arg_17_0.nextChapterId then
		arg_17_0:playChapterUnlockAnimation(arg_17_0.nextChapterId, arg_17_0.unlockAnimationDoneNeedSwitchChapter)
	end
end

function var_0_0.playChapterUnlockAnimation(arg_18_0, arg_18_1, arg_18_2)
	if not arg_18_1 then
		return
	end

	if not ViewHelper.instance:checkViewOnTheTop(arg_18_0.viewName) then
		return
	end

	arg_18_0.nextChapterId = nil

	local var_18_0 = arg_18_0.chapterNodeList[arg_18_1]

	gohelper.setActive(var_18_0.goLock, true)

	arg_18_0.playingUnlockAnimationChapterId = arg_18_1

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_unlock)

	local var_18_1 = arg_18_0.chapterAnimatorList[arg_18_1]

	if var_18_1 then
		UIBlockMgr.instance:startBlock(var_0_0.UnlockKey)
		var_18_1:Play(UIAnimationName.Unlock)

		arg_18_0.unlockCallback = arg_18_2

		TaskDispatcher.runDelay(arg_18_0.unlockCallback, arg_18_0, YaXianEnum.MapViewChapterUnlockDuration)
	elseif arg_18_2 then
		arg_18_2(arg_18_0)
	end
end

function var_0_0.unlockAnimationDone(arg_19_0)
	UIBlockMgr.instance:endBlock(var_0_0.UnlockKey)
	arg_19_0:recordPlayChapterUnlockAnimation(arg_19_0.playingUnlockAnimationChapterId)

	arg_19_0.playingUnlockAnimationChapterId = nil
	arg_19_0.unlockCallback = nil
end

function var_0_0.unlockAnimationDoneNeedSwitchChapter(arg_20_0)
	local var_20_0 = arg_20_0.playingUnlockAnimationChapterId

	arg_20_0:unlockAnimationDone()
	arg_20_0.viewContainer:changeChapterId(var_20_0)
end

function var_0_0.initPlayedChapterUnlockAnimationList(arg_21_0)
	if arg_21_0.playedChapterIdList then
		return
	end

	local var_21_0 = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.YaXianChapterUnlockAnimationKey))

	if string.nilorempty(var_21_0) then
		arg_21_0.playedChapterIdList = {}
	end

	arg_21_0.playedChapterIdList = string.splitToNumber(var_21_0, ";")
end

function var_0_0.isPlayedChapterUnlockAnimation(arg_22_0, arg_22_1)
	arg_22_0:initPlayedChapterUnlockAnimationList()

	return tabletool.indexOf(arg_22_0.playedChapterIdList, arg_22_1)
end

function var_0_0.recordPlayChapterUnlockAnimation(arg_23_0, arg_23_1)
	if tabletool.indexOf(arg_23_0.playedChapterIdList, arg_23_1) then
		return
	end

	table.insert(arg_23_0.playedChapterIdList, arg_23_1)
	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.YaXianChapterUnlockAnimationKey), table.concat(arg_23_0.playedChapterIdList, ";"))
end

function var_0_0.onClose(arg_24_0)
	return
end

function var_0_0.onDestroyView(arg_25_0)
	arg_25_0._simagebottom:UnLoadImage()
	TaskDispatcher.cancelTask(arg_25_0.refreshTime, arg_25_0)

	if arg_25_0.unlockCallback then
		TaskDispatcher.cancelTask(arg_25_0.unlockCallback, arg_25_0)
	end

	arg_25_0.collectClick:RemoveClickListener()
	arg_25_0.rewardClick:RemoveClickListener()

	for iter_25_0, iter_25_1 in ipairs(arg_25_0.chapterNodeList) do
		iter_25_1.click:RemoveClickListener()
	end
end

return var_0_0
