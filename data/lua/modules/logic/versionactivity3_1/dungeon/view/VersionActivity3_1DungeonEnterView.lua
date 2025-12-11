module("modules.logic.versionactivity3_1.dungeon.view.VersionActivity3_1DungeonEnterView", package.seeall)

local var_0_0 = class("VersionActivity3_1DungeonEnterView", VersionActivityFixedDungeonEnterView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "logo/#txt_dec")
	arg_1_0._gotime = gohelper.findChild(arg_1_0.viewGO, "logo/actbg")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "logo/actbg/#txt_time")
	arg_1_0._btnstore = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_store")
	arg_1_0._txtStoreNum = gohelper.findChildText(arg_1_0.viewGO, "entrance/#btn_store/normal/#txt_num")
	arg_1_0._txtStoreTime = gohelper.findChildText(arg_1_0.viewGO, "entrance/#btn_store/#go_time/#txt_time")
	arg_1_0._btnenter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_enter")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "entrance/#btn_enter/#go_reddot")
	arg_1_0._gohardModeUnLock = gohelper.findChild(arg_1_0.viewGO, "entrance/#btn_enter/#go_hardModeUnLock")
	arg_1_0._btnFinished = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_Finished")
	arg_1_0._btnLocked = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_Locked")
	arg_1_0._btnBoard = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Board")
	arg_1_0._txtpapernum = gohelper.findChildTextMesh(arg_1_0.viewGO, "#btn_Board/#txt_num")
	arg_1_0._goboardreddot = gohelper.findChild(arg_1_0.viewGO, "#btn_Board/#go_reddot")
	arg_1_0._goblack = gohelper.findChild(arg_1_0.viewGO, "black")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	var_0_0.super.addEvents(arg_2_0)
	arg_2_0._btnBoard:AddClickListener(arg_2_0._btnBoardOnClick, arg_2_0)
	BackpackController.instance:registerCallback(BackpackEvent.UpdateItemList, arg_2_0.refreshPaperCount, arg_2_0)
	CommandStationController.instance:registerCallback(CommandStationEvent.OnTaskUpdate, arg_2_0.refreshPaperCount, arg_2_0)
	CommandStationController.instance:registerCallback(CommandStationEvent.OneClickClaimReward, arg_2_0.refreshPaperCount, arg_2_0)
	CommandStationController.instance:registerCallback(CommandStationEvent.OnGetCommandPostInfo, arg_2_0.refreshPaperCount, arg_2_0)
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, arg_2_0._onGetTaskBonus, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	var_0_0.super.removeEvents(arg_3_0)
	arg_3_0._btnBoard:RemoveClickListener()
	BackpackController.instance:unregisterCallback(BackpackEvent.UpdateItemList, arg_3_0.refreshPaperCount, arg_3_0)
	CommandStationController.instance:unregisterCallback(CommandStationEvent.OnTaskUpdate, arg_3_0.refreshPaperCount, arg_3_0)
	CommandStationController.instance:unregisterCallback(CommandStationEvent.OneClickClaimReward, arg_3_0.refreshPaperCount, arg_3_0)
	CommandStationController.instance:unregisterCallback(CommandStationEvent.OnGetCommandPostInfo, arg_3_0.refreshPaperCount, arg_3_0)
	TaskController.instance:unregisterCallback(TaskEvent.UpdateTaskList, arg_3_0._onGetTaskBonus, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	if LangSettings.instance:isJp() then
		arg_4_0._txttime = gohelper.findChildText(arg_4_0.viewGO, "#logo/jp/actbg/#txt_time")
	elseif LangSettings.instance:isKr() then
		arg_4_0._txttime = gohelper.findChildText(arg_4_0.viewGO, "#logo/kr/actbg/#txt_time")
	elseif LangSettings.instance:isEn() then
		arg_4_0._txttime = gohelper.findChildText(arg_4_0.viewGO, "#logo/en/actbg/#txt_time")
	else
		arg_4_0._txttime = gohelper.findChildText(arg_4_0.viewGO, "logo/actbg/#txt_time")
	end

	var_0_0.super._editableInitView(arg_4_0)

	arg_4_0._gobg = gohelper.findChild(arg_4_0.viewGO, "#simage_bg")
	arg_4_0._videoComp = VersionActivityVideoComp.get(arg_4_0._gobg, arg_4_0)

	RedDotController.instance:addRedDot(arg_4_0._goboardreddot, RedDotEnum.DotNode.CommandStationTask)
end

function var_0_0.onDestroyView(arg_5_0)
	var_0_0.super.onDestroyView(arg_5_0)
	arg_5_0._videoComp:destroy()

	local var_5_0 = ViewMgr.instance:getContainer(ViewName.FullScreenVideoView)

	if var_5_0 and var_5_0:isOpen() and var_5_0.viewGO and arg_5_0._fullviewParent then
		gohelper.addChildPosStay(arg_5_0._fullviewParent, var_5_0.viewGO)
	end
end

function var_0_0._btnBoardOnClick(arg_6_0)
	CommandStationController.instance:openCommandStationPaperView()
end

function var_0_0.onOpenFinish(arg_7_0)
	arg_7_0._videoPath = langVideoUrl(VersionActivity3_1Enum.EnterLoopVideoName)

	if arg_7_0.viewParam and arg_7_0.viewParam.playVideo and arg_7_0.viewContainer then
		arg_7_0:addEventCb(VideoController.instance, VideoEvent.OnVideoPlayFinished, arg_7_0.onPlayVideoDone, arg_7_0)
		arg_7_0:addEventCb(VideoController.instance, VideoEvent.OnVideoPlayOverTime, arg_7_0.onPlayVideoDone, arg_7_0)
		arg_7_0._videoComp:loadMedia(arg_7_0._videoPath)

		arg_7_0._fullviewParent = nil

		local var_7_0 = ViewMgr.instance:getContainer(ViewName.FullScreenVideoView)

		if var_7_0 and var_7_0:isOpen() and var_7_0.viewGO then
			arg_7_0._fullviewParent = var_7_0.viewGO.transform.parent

			gohelper.addChildPosStay(arg_7_0._gobg, var_7_0.viewGO)
		end
	else
		arg_7_0._videoComp:play(arg_7_0._videoPath, true)
	end

	arg_7_0:_setVideoAsLastSibling()
end

function var_0_0.onPlayVideoDone(arg_8_0)
	arg_8_0:removeEventCb(VideoController.instance, VideoEvent.OnVideoPlayFinished, arg_8_0.onPlayVideoDone, arg_8_0)
	arg_8_0:removeEventCb(VideoController.instance, VideoEvent.OnVideoPlayOverTime, arg_8_0.onPlayVideoDone, arg_8_0)
	arg_8_0._videoComp:play(arg_8_0._videoPath, true)
end

function var_0_0._setVideoAsLastSibling(arg_9_0)
	local var_9_0 = ViewMgr.instance:getContainer(ViewName.FullScreenVideoView)

	if var_9_0 and var_9_0:isOpen() and var_9_0.viewGO then
		gohelper.setAsLastSibling(var_9_0.viewGO)
	end
end

function var_0_0.playLogoAnim(arg_10_0, arg_10_1)
	local var_10_0 = "logo"

	if LangSettings.instance:isJp() then
		var_10_0 = "#logo/jp"
	elseif LangSettings.instance:isKr() then
		var_10_0 = "#logo/kr"
	elseif LangSettings.instance:isEn() then
		var_10_0 = "#logo/en"
	end

	if not arg_10_0._gologo then
		arg_10_0._gologo = gohelper.findChild(arg_10_0.viewGO, var_10_0):GetComponent(typeof(UnityEngine.Animator))
	end

	arg_10_0._gologo:Play(arg_10_1, 0, 0)
end

function var_0_0.refreshUI(arg_11_0)
	var_0_0.super.refreshUI(arg_11_0)
	arg_11_0:refreshPaperCount()
end

function var_0_0._onGetTaskBonus(arg_12_0)
	CommandStationRpc.instance:sendGetCommandPostInfoRequest()
end

function var_0_0.refreshPaperCount(arg_13_0)
	local var_13_0 = 0
	local var_13_1 = 0
	local var_13_2 = CommandStationConfig.instance:getCurVersionId()
	local var_13_3 = CommandStationConfig.instance:getPaperList()

	for iter_13_0, iter_13_1 in ipairs(var_13_3) do
		if iter_13_1.versionId == var_13_2 then
			var_13_1 = iter_13_1.allNum

			break
		end
	end

	local var_13_4 = CommandStationTaskListModel.instance.allNormalTaskMos

	if var_13_4 and #var_13_4 > 0 then
		for iter_13_2, iter_13_3 in ipairs(var_13_4) do
			if iter_13_3.config.versionId == var_13_2 and iter_13_3.finishCount > 0 then
				var_13_0 = var_13_0 + 1
			end
		end
	end

	local var_13_5 = Mathf.Clamp(var_13_0, 0, var_13_1)

	arg_13_0._txtpapernum.text = string.format("%d/%d", var_13_5, var_13_1)
end

return var_0_0
