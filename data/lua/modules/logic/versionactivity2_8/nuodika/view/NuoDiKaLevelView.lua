module("modules.logic.versionactivity2_8.nuodika.view.NuoDiKaLevelView", package.seeall)

local var_0_0 = class("NuoDiKaLevelView", BaseView)
local var_0_1 = {
	-960,
	-960,
	-960,
	-960,
	-1300,
	-1800,
	-2300,
	-3000
}
local var_0_2 = {
	0.2,
	0.2,
	0.6,
	1.3,
	1.3,
	1.3,
	1.3,
	1.3
}
local var_0_3 = {
	-0.6,
	-0.6,
	-0.6,
	-0.6,
	-0.1,
	0.3,
	0.8,
	1.3
}
local var_0_4 = 0.3

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg1")
	arg_1_0._simagebg2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg2")
	arg_1_0._goTitle = gohelper.findChild(arg_1_0.viewGO, "#go_Title")
	arg_1_0._simagetitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_Title/#simage_title")
	arg_1_0._gotime = gohelper.findChild(arg_1_0.viewGO, "#go_Title/#go_time")
	arg_1_0._txtlimittime = gohelper.findChildText(arg_1_0.viewGO, "#go_Title/#go_time/#txt_limittime")
	arg_1_0._btnTask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Task")
	arg_1_0._goTaskReddot = gohelper.findChild(arg_1_0.viewGO, "#btn_Task/#go_reddot")
	arg_1_0._gostoryPath = gohelper.findChild(arg_1_0.viewGO, "#go_storyPath")
	arg_1_0._gostoryScroll = gohelper.findChild(arg_1_0.viewGO, "#go_storyPath/#go_storyScroll")
	arg_1_0._gonotpasspath = gohelper.findChild(arg_1_0.viewGO, "#go_storyPath/#go_storyScroll/path/#go_notpasspath")
	arg_1_0._imagePath = gohelper.findChildImage(arg_1_0.viewGO, "#go_storyPath/#go_storyScroll/path/#go_notpasspath")
	arg_1_0._gopath1 = gohelper.findChild(arg_1_0.viewGO, "#go_storyPath/#go_storyScroll/path/#go_notpasspath/#go_path1")
	arg_1_0._imagePath1 = gohelper.findChildImage(arg_1_0.viewGO, "#go_storyPath/#go_storyScroll/path/#go_notpasspath/#go_path1")
	arg_1_0._gopasspath = gohelper.findChild(arg_1_0.viewGO, "#go_storyPath/#go_storyScroll/path/#go_passpath")
	arg_1_0._goendless = gohelper.findChild(arg_1_0.viewGO, "#go_storyPath/#go_storyScroll/path/#go_endless")
	arg_1_0._gobtnendless = gohelper.findChild(arg_1_0.viewGO, "#go_storyPath/#go_storyScroll/path/#go_endless/#btn_endless")
	arg_1_0._btnendless = gohelper.getClick(arg_1_0._gobtnendless)
	arg_1_0._gostoryStages = gohelper.findChild(arg_1_0.viewGO, "#go_storyPath/#go_storyScroll/#go_storyStages")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnTask:AddClickListener(arg_2_0._btnTaskOnClick, arg_2_0)
	arg_2_0._btnendless:AddClickListener(arg_2_0._btnEndlessOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnTask:RemoveClickListener()
	arg_3_0._btnendless:RemoveClickListener()
end

function var_0_0._btnTaskOnClick(arg_4_0)
	ViewMgr.instance:openView(ViewName.NuoDiKaTaskView)
end

function var_0_0._btnEndlessOnClick(arg_5_0)
	arg_5_0._episodeItems[8]:_btnOnClick()
end

function var_0_0._onEpisodeFinished(arg_6_0)
	if NuoDiKaModel.instance:getNewFinishEpisode() then
		arg_6_0:_playStoryFinishAnim()
	end
end

function var_0_0._playStoryFinishAnim(arg_7_0)
	local var_7_0 = NuoDiKaModel.instance:getNewFinishEpisode()

	if var_7_0 then
		for iter_7_0, iter_7_1 in ipairs(arg_7_0._episodeItems) do
			if iter_7_1.id == var_7_0 then
				if var_7_0 == NuoDiKaModel.instance:getMaxEpisodeId() then
					AudioMgr.instance:trigger(AudioEnum2_8.NuoDiKa.play_ui_level_all_pass)
					arg_7_0._anim:Play("end", 0, 0)
					arg_7_0:_checkShowBg()
				else
					local var_7_1 = NuoDiKaConfig.instance:getEpisodeCo(arg_7_0.actId, var_7_0)
					local var_7_2 = arg_7_0:_getEpisodeBg(var_7_0)

					if var_7_2 ~= arg_7_0:_getEpisodeBg(var_7_1.preEpisode) then
						gohelper.setActive(arg_7_0._simagebg2.gameObject, true)

						arg_7_0._simagebg2.gameObject:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = 0

						arg_7_0._simagebg2:LoadImage(ResUrl.getNuoDiKaSingleBg(var_7_2))
						AudioMgr.instance:trigger(AudioEnum2_8.NuoDiKa.play_ui_level_switch)
						arg_7_0._anim:Play("switch", 0, 0)
						UIBlockMgrExtend.setNeedCircleMv(false)
						UIBlockMgr.instance:startBlock("levelSwitch")
						TaskDispatcher.runDelay(arg_7_0._onChangeSwitchBg, arg_7_0, 3)
					end
				end

				arg_7_0._finishEpisodeIndex = iter_7_0

				iter_7_1:playFinish()
				iter_7_1:playStarAnim()
				TaskDispatcher.runDelay(arg_7_0._finishStoryEnd, arg_7_0, 1.5)

				break
			end
		end

		NuoDiKaModel.instance:clearFinishEpisode()
	end
end

function var_0_0._onChangeSwitchBg(arg_8_0)
	local var_8_0 = NuoDiKaModel.instance:getMaxUnlockEpisodeId()
	local var_8_1 = arg_8_0:_getEpisodeBg(var_8_0)

	NuoDiKaModel.instance:setCurEpisode(arg_8_0._curEpisodeIndex, var_8_0)
	arg_8_0._simagebg1:LoadImage(ResUrl.getNuoDiKaSingleBg(var_8_1))
	TaskDispatcher.runDelay(arg_8_0._onSwitchFinish, arg_8_0, 2)
end

function var_0_0._onSwitchFinish(arg_9_0)
	gohelper.setActive(arg_9_0._simagebg2.gameObject, false)
	arg_9_0._anim:Play("open", 0, 1)
	UIBlockMgr.instance:endBlock("levelSwitch")
end

function var_0_0._onBackToLevel(arg_10_0)
	local var_10_0 = NuoDiKaModel.instance:getNewFinishEpisode()

	if var_10_0 and var_10_0 ~= 0 then
		local var_10_1 = NuoDiKaModel.instance:getMaxUnlockEpisodeId()

		arg_10_0._curEpisodeIndex = NuoDiKaModel.instance:getEpisodeIndex(var_10_1)

		NuoDiKaModel.instance:setCurEpisode(arg_10_0._curEpisodeIndex, var_10_1)
		arg_10_0:_focusLvItem(arg_10_0._curEpisodeIndex)

		if arg_10_0._curEpisodeIndex == 8 then
			AudioMgr.instance:trigger(AudioEnum2_8.NuoDiKa.play_ui_last_level_unlock)
			arg_10_0._endlessAnim:Play("open", 0, 0)
		end
	end

	arg_10_0._anim:Play("back", 0, 0)
	arg_10_0:_refreshUI()
	arg_10_0:_refreshTask()
end

function var_0_0._refreshTask(arg_11_0)
	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.V2a4WuErLiXiTask, 0) then
		arg_11_0._taskAnim:Play("loop", 0, 0)
	else
		arg_11_0._taskAnim:Play("idle", 0, 0)
	end
end

function var_0_0._onCloseTask(arg_12_0)
	arg_12_0:_refreshTask()
end

function var_0_0._addEvents(arg_13_0)
	arg_13_0:addEventCb(NuoDiKaController.instance, NuoDiKaEvent.EpisodeFinished, arg_13_0._onEpisodeFinished, arg_13_0)
	arg_13_0:addEventCb(NuoDiKaController.instance, NuoDiKaEvent.OnBackToLevel, arg_13_0._onBackToLevel, arg_13_0)
	arg_13_0:addEventCb(NuoDiKaController.instance, NuoDiKaEvent.OnCloseTask, arg_13_0._onCloseTask, arg_13_0)
end

function var_0_0._removeEvents(arg_14_0)
	arg_14_0:removeEventCb(NuoDiKaController.instance, NuoDiKaEvent.EpisodeFinished, arg_14_0._onEpisodeFinished, arg_14_0)
	arg_14_0:removeEventCb(NuoDiKaController.instance, NuoDiKaEvent.OnBackToLevel, arg_14_0._onBackToLevel, arg_14_0)
	arg_14_0:removeEventCb(NuoDiKaController.instance, NuoDiKaEvent.OnCloseTask, arg_14_0._onCloseTask, arg_14_0)
end

function var_0_0._editableInitView(arg_15_0)
	arg_15_0.actId = VersionActivity2_8Enum.ActivityId.NuoDiKa
	arg_15_0._anim = arg_15_0.viewGO:GetComponent(gohelper.Type_Animator)
	arg_15_0._animEvent = arg_15_0.viewGO:GetComponent(gohelper.Type_AnimationEventWrap)
	arg_15_0._endlessAnim = arg_15_0._goendless:GetComponent(gohelper.Type_Animator)
	arg_15_0._taskAnim = gohelper.findChild(arg_15_0.viewGO, "#btn_Task/ani"):GetComponent(gohelper.Type_Animator)
	arg_15_0._notPassAnim = arg_15_0._gonotpasspath:GetComponent(gohelper.Type_Animator)
	arg_15_0._passAnim = arg_15_0._gopasspath:GetComponent(gohelper.Type_Animator)
	arg_15_0._gostages = {}

	for iter_15_0 = 1, 8 do
		local var_15_0 = gohelper.findChild(arg_15_0._gostoryStages, "stage" .. iter_15_0)

		table.insert(arg_15_0._gostages, var_15_0)
	end

	arg_15_0:_initLevelItems()
	arg_15_0:_checkShowBg()
	arg_15_0:_refreshUI()
	arg_15_0:_addEvents()
end

function var_0_0._getEpisodeBg(arg_16_0, arg_16_1)
	local var_16_0 = "v2a8_nuodika_level_fullbg1"
	local var_16_1 = string.split(NuoDiKaConfig.instance:getConstCo(3).value, "#")
	local var_16_2 = string.split(NuoDiKaConfig.instance:getConstCo(4).value, "#")
	local var_16_3 = string.split(NuoDiKaConfig.instance:getConstCo(5).value, "#")

	if arg_16_1 >= tonumber(var_16_3[1]) then
		var_16_0 = var_16_3[2]
	elseif arg_16_1 >= tonumber(var_16_2[1]) then
		var_16_0 = var_16_2[2]
	else
		var_16_0 = var_16_1[2]
	end

	return var_16_0
end

function var_0_0._checkShowBg(arg_17_0)
	local var_17_0 = "v2a8_nuodika_level_fullbg1"

	if NuoDiKaModel.instance:isAllEpisodeFinish() then
		var_17_0 = NuoDiKaConfig.instance:getConstCo(6).value
	else
		local var_17_1 = NuoDiKaModel.instance:getMaxUnlockEpisodeId()
		local var_17_2 = NuoDiKaModel.instance:getEpisodeIndex(var_17_1)
		local var_17_3 = string.split(NuoDiKaConfig.instance:getConstCo(3).value, "#")
		local var_17_4 = string.split(NuoDiKaConfig.instance:getConstCo(4).value, "#")
		local var_17_5 = string.split(NuoDiKaConfig.instance:getConstCo(5).value, "#")

		if var_17_2 > NuoDiKaModel.instance:getEpisodeIndex(tonumber(var_17_5[1])) then
			var_17_0 = var_17_5[2]
		elseif var_17_2 > NuoDiKaModel.instance:getEpisodeIndex(tonumber(var_17_4[1])) then
			var_17_0 = var_17_4[2]
		else
			var_17_0 = var_17_3[2]
		end
	end

	if var_17_0 ~= arg_17_0._simagebg1.curImageUrl then
		arg_17_0._simagebg1:LoadImage(ResUrl.getNuoDiKaSingleBg(var_17_0))
	end
end

function var_0_0._refreshUI(arg_18_0)
	local var_18_0 = NuoDiKaModel.instance:getMaxUnlockEpisodeId()
	local var_18_1 = NuoDiKaModel.instance:getMaxEpisodeId()

	gohelper.setActive(arg_18_0._goendless, var_18_0 == var_18_1)

	local var_18_2 = NuoDiKaModel.instance:isAllEpisodeFinish()

	gohelper.setActive(arg_18_0._gonotpasspath, not var_18_2)
	gohelper.setActive(arg_18_0._gopasspath, var_18_2)

	local var_18_3 = NuoDiKaModel.instance:getEpisodeIndex(var_18_0)

	if not var_18_2 then
		local var_18_4 = var_18_3 > 4 and "go_passpath_02" or "go_passpath_01"

		arg_18_0._notPassAnim:Play(var_18_4, 0, 0)

		local var_18_5 = Vector4.New(var_0_2[var_18_3], -0.3, 0, 0)
		local var_18_6 = Vector4.New(var_0_3[var_18_3], -0.3, 0, 0)
		local var_18_7 = arg_18_0._gonotpasspath:GetComponent(typeof(ZProj.MaterialPropsCtrl))

		var_18_7.vector_01 = var_18_5
		var_18_7.vector_03 = var_18_6

		var_18_7:SetProps()
	else
		arg_18_0._passAnim:Play("go_passpath_02", 0, 0)
	end

	gohelper.setActive(arg_18_0._gopath1, var_18_3 > 4)

	local var_18_8 = 960 - var_0_1[var_18_3]

	recthelper.setWidth(arg_18_0._gostoryScroll.transform, var_18_8)
end

function var_0_0.onOpen(arg_19_0)
	RedDotController.instance:addRedDot(arg_19_0._goTaskReddot, RedDotEnum.DotNode.V2a4WuErLiXiTask, arg_19_0.actId)
	arg_19_0:_refreshLeftTime()
	arg_19_0:_refreshTask()
	TaskDispatcher.runRepeat(arg_19_0._refreshLeftTime, arg_19_0, 1)
end

function var_0_0._refreshLeftTime(arg_20_0)
	arg_20_0._txtlimittime.text = ActivityHelper.getActivityRemainTimeStr(arg_20_0.actId)
end

function var_0_0._initLevelItems(arg_21_0)
	local var_21_0 = arg_21_0.viewContainer:getSetting().otherRes[1]

	arg_21_0._episodeItems = {}

	local var_21_1 = NuoDiKaConfig.instance:getEpisodeCoList(arg_21_0.actId)

	for iter_21_0 = 1, #var_21_1 do
		local var_21_2 = arg_21_0:getResInst(var_21_0, arg_21_0._gostages[iter_21_0])
		local var_21_3 = MonoHelper.addNoUpdateLuaComOnceToGo(var_21_2, NuoDiKaLevelItem, arg_21_0)

		arg_21_0._episodeItems[iter_21_0] = var_21_3

		arg_21_0._episodeItems[iter_21_0]:setParam(var_21_1[iter_21_0], iter_21_0, arg_21_0.actId)

		if arg_21_0._episodeItems[iter_21_0]:isUnlock() then
			arg_21_0._curEpisodeIndex = iter_21_0
		end
	end

	local var_21_4 = NuoDiKaModel.instance:getCurEpisodeIndex()

	arg_21_0._curEpisodeIndex = var_21_4 > 0 and var_21_4 or arg_21_0._curEpisodeIndex

	arg_21_0:_focusLvItem(arg_21_0._curEpisodeIndex)
end

function var_0_0._finishStoryEnd(arg_22_0)
	if arg_22_0._finishEpisodeIndex == #arg_22_0._episodeItems then
		arg_22_0._curEpisodeIndex = arg_22_0._finishEpisodeIndex
		arg_22_0._finishEpisodeIndex = nil
	else
		arg_22_0._curEpisodeIndex = arg_22_0._finishEpisodeIndex + 1

		arg_22_0:_unlockStory()
	end
end

function var_0_0._unlockStory(arg_23_0)
	arg_23_0._episodeItems[arg_23_0._finishEpisodeIndex + 1]:playUnlock()
	TaskDispatcher.runDelay(arg_23_0._unlockLvEnd, arg_23_0, 1.5)
end

function var_0_0._unlockLvEnd(arg_24_0)
	arg_24_0._episodeItems[arg_24_0._finishEpisodeIndex + 1]:refreshUI()

	arg_24_0._finishEpisodeIndex = nil
end

function var_0_0._focusLvItem(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = NuoDiKaModel.instance:getMaxUnlockEpisodeId()
	local var_25_1 = NuoDiKaModel.instance:getEpisodeIndex(var_25_0)
	local var_25_2 = 960 - var_0_1[var_25_1]
	local var_25_3 = var_25_2 > UnityEngine.Screen.width and 0.5 * UnityEngine.Screen.width - var_25_2 or -0.5 * UnityEngine.Screen.width

	if arg_25_2 then
		ZProj.TweenHelper.DOLocalMoveX(arg_25_0._gostoryScroll.transform, var_25_3, var_0_4, arg_25_0._onFocusEnd, arg_25_0, arg_25_1)
	else
		transformhelper.setLocalPos(arg_25_0._gostoryScroll.transform, var_25_3, 0, 0)
	end

	NuoDiKaModel.instance:setCurEpisode(arg_25_1)
end

function var_0_0._onFocusEnd(arg_26_0, arg_26_1)
	arg_26_0:_checkShowBg()
end

function var_0_0.onClose(arg_27_0)
	TaskDispatcher.cancelTask(arg_27_0._refreshLeftTime, arg_27_0)
	TaskDispatcher.cancelTask(arg_27_0._unlockLvEnd, arg_27_0)
	TaskDispatcher.cancelTask(arg_27_0._finishStoryEnd, arg_27_0)
	TaskDispatcher.cancelTask(arg_27_0._unlockStory, arg_27_0)
	TaskDispatcher.cancelTask(arg_27_0._playStoryFinishAnim, arg_27_0)
end

function var_0_0.onDestroyView(arg_28_0)
	arg_28_0:_removeEvents()
	arg_28_0._simagebg1:UnLoadImage()

	arg_28_0._episodeItems = nil
end

return var_0_0
