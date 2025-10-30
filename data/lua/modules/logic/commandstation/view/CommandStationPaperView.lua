module("modules.logic.commandstation.view.CommandStationPaperView", package.seeall)

local var_0_0 = class("CommandStationPaperView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._anim = gohelper.findChildAnim(arg_1_0.viewGO, "")
	arg_1_0._btnTask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_task")
	arg_1_0._goTaskRed = gohelper.findChild(arg_1_0.viewGO, "#btn_task/#go_reddot")
	arg_1_0._btnCompose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/Panel/#btn_compose")
	arg_1_0._animCompose = arg_1_0._btnCompose:GetComponent(typeof(UnityEngine.Animation))
	arg_1_0._btnLeft = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/Panel/#btn_Left")
	arg_1_0._btnRight = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/Panel/#btn_Right")
	arg_1_0._goRightRed = gohelper.findChild(arg_1_0.viewGO, "Right/Panel/#btn_Right/#go_reddot")
	arg_1_0._goschedule = gohelper.findChild(arg_1_0.viewGO, "Right/Schedule")
	arg_1_0._godone = gohelper.findChild(arg_1_0.viewGO, "Right/Done")
	arg_1_0._btnDish = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/Done/#simage_Disk")
	arg_1_0._simageDish = gohelper.findChildSingleImage(arg_1_0.viewGO, "Right/Done/#simage_Disk")
	arg_1_0._txtNum1 = gohelper.findChildText(arg_1_0.viewGO, "Right/Schedule/#txt_Num1")
	arg_1_0._txtNum2 = gohelper.findChildText(arg_1_0.viewGO, "Right/Schedule/#txt_Num1/#txt_Num2")
	arg_1_0._gobuttom = gohelper.findChild(arg_1_0.viewGO, "Right/Panel/Bottom")
	arg_1_0._goitem = gohelper.findChild(arg_1_0.viewGO, "Right/Panel/Bottom/Layout/#go_Item")
	arg_1_0._paperRoot = gohelper.findChild(arg_1_0.viewGO, "Right/Panel/#go_paper")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnDish:AddClickListener(arg_2_0.onClickDish, arg_2_0)
	arg_2_0._btnTask:AddClickListener(arg_2_0._onTaskClick, arg_2_0)
	arg_2_0._btnCompose:AddClickListener(arg_2_0._onComposeClick, arg_2_0)
	arg_2_0._btnLeft:AddClickListener(arg_2_0._onChangePage, arg_2_0, -1)
	arg_2_0._btnRight:AddClickListener(arg_2_0._onChangePage, arg_2_0, 1)
	CommandStationController.instance:registerCallback(CommandStationEvent.OnPaperUpdate, arg_2_0.onPaperUpdate, arg_2_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_2_0._onViewClose, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnDish:RemoveClickListener()
	arg_3_0._btnTask:RemoveClickListener()
	arg_3_0._btnCompose:RemoveClickListener()
	arg_3_0._btnLeft:RemoveClickListener()
	arg_3_0._btnRight:RemoveClickListener()
	CommandStationController.instance:unregisterCallback(CommandStationEvent.OnPaperUpdate, arg_3_0.onPaperUpdate, arg_3_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_3_0._onViewClose, arg_3_0)
end

function var_0_0.onOpen(arg_4_0)
	GameGCMgr.instance:dispatchEvent(GameGCEvent.SetBanGc, "commandstation_tocode_video", false)

	arg_4_0._viewOpenTime = Time.realtimeSinceStartup
	arg_4_0._itemNum = CommandStationConfig.instance:getCurPaperCount()

	RedDotController.instance:addRedDot(arg_4_0._goTaskRed, RedDotEnum.DotNode.CommandStationTask)
	arg_4_0:initPaper()

	arg_4_0._paperList = CommandStationConfig.instance:getPaperList()
	arg_4_0._curPaperIndex = Mathf.Clamp(CommandStationModel.instance.paper + 1, 1, #arg_4_0._paperList)

	gohelper.setActive(arg_4_0._gobuttom, #arg_4_0._paperList > 1)

	arg_4_0._goPoints = arg_4_0._goPoints or arg_4_0:getUserDataTb_()

	if #arg_4_0._paperList > 1 then
		gohelper.CreateObjList(arg_4_0, arg_4_0._createPoint, arg_4_0._paperList, nil, arg_4_0._goitem)
	end

	arg_4_0:_checkCanCompose()
	arg_4_0:refreshPaperCountAndPlayAudio()
end

function var_0_0._createPoint(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = gohelper.findChild(arg_5_1, "#go_Light")

	arg_5_0._goPoints[arg_5_3] = var_5_0
end

function var_0_0._checkCanCompose(arg_6_0)
	arg_6_0._canCompose = false

	local var_6_0 = arg_6_0._paperList[CommandStationModel.instance.paper + 1]

	if not var_6_0 then
		return
	end

	if arg_6_0._itemNum >= CommandStationConfig.instance:getCurTotalPaperCount(var_6_0.versionId) then
		arg_6_0._canCompose = true
	end
end

function var_0_0._onViewClose(arg_7_0, arg_7_1)
	if not ViewHelper.instance:checkViewOnTheTop(arg_7_0.viewName) then
		return
	end

	if arg_7_1 == ViewName.FullScreenVideoView then
		return
	end

	local var_7_0 = CommandStationConfig.instance:getCurPaperCount()
	local var_7_1 = false

	if var_7_0 ~= arg_7_0._itemNum then
		AudioMgr.instance:trigger(AudioEnum3_0.CommandStationPaper.play_ui_wenming_cards_effect)

		var_7_1 = true
		arg_7_0._itemNum = var_7_0
		arg_7_0._curPaperIndex = Mathf.Clamp(CommandStationModel.instance.paper + 1, 1, #arg_7_0._paperList)

		arg_7_0:_checkCanCompose()
	end

	arg_7_0:refreshPaperCount(var_7_1)

	if arg_7_0._needPlayDoneAnim then
		arg_7_0._needPlayDoneAnim = nil

		ZProj.TweenHelper.DOAnchorPosY(arg_7_0._paperContents[arg_7_0._curPaperIndex], 0, 0.2, arg_7_0._playDoneAnim, arg_7_0)
		UIBlockHelper.instance:startBlock("CommandStationPaperView_tweenPosY", 0.2)
	end
end

function var_0_0.refreshPaperCountAndPlayAudio(arg_8_0)
	AudioMgr.instance:trigger(AudioEnum3_0.CommandStationPaper.play_ui_lushang_zhihuibu_paper2)
	arg_8_0:refreshPaperCount()
end

function var_0_0.refreshPaperCount(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0._paperList[arg_9_0._curPaperIndex].allNum
	local var_9_1 = var_9_0
	local var_9_2 = arg_9_0._curPaperIndex == CommandStationModel.instance.paper + 1

	if var_9_2 then
		local var_9_3 = arg_9_0._paperList[arg_9_0._curPaperIndex - 1]
		local var_9_4 = var_9_3 and CommandStationConfig.instance:getCurTotalPaperCount(var_9_3.versionId) or 0

		var_9_1 = CommandStationConfig.instance:getCurPaperCount() - var_9_4
	elseif arg_9_0._curPaperIndex > CommandStationModel.instance.paper + 1 then
		var_9_1 = 0
	end

	local var_9_5 = Mathf.Clamp(var_9_1, 0, var_9_0)
	local var_9_6 = arg_9_0._preItemCount

	var_9_6 = var_9_2 and arg_9_1 and var_9_6 or var_9_5

	if var_9_6 < var_9_5 then
		if arg_9_0._curPaperIndex == 1 then
			arg_9_0:scrollTo(Mathf.Floor(var_9_6 / 2) + 1)
		else
			arg_9_0:scrollTo(var_9_6 + 1)
		end
	end

	if var_9_2 then
		arg_9_0._preItemCount = var_9_5
	end

	local var_9_7 = arg_9_0._curPaperIndex <= CommandStationModel.instance.paper

	gohelper.setActive(arg_9_0._paperDones[arg_9_0._curPaperIndex], var_9_7 and not arg_9_0._needPlayDoneAnim)
	gohelper.setActive(arg_9_0._goschedule, not var_9_7)
	gohelper.setActive(arg_9_0._godone, var_9_7)

	if var_9_7 then
		arg_9_0._simageDish:LoadImage(ResUrl.getCommandStationPaperIcon(arg_9_0._paperList[arg_9_0._curPaperIndex].diskIcon))
	end

	if arg_9_0._curPaperIndex == 1 then
		arg_9_0._txtNum1.text = Mathf.Floor(var_9_5 / 2)
		arg_9_0._txtNum2.text = Mathf.Floor(var_9_0 / 2)
	else
		arg_9_0._txtNum1.text = var_9_5
		arg_9_0._txtNum2.text = var_9_0
	end

	for iter_9_0, iter_9_1 in pairs(arg_9_0._paperRoots) do
		gohelper.setActive(iter_9_1, iter_9_0 == arg_9_0._curPaperIndex)
	end

	local var_9_8 = arg_9_0._paperMarkDict[arg_9_0._curPaperIndex]

	if var_9_8 then
		arg_9_0:_playAnim(var_9_8.afterMark, var_9_5, var_9_6)
		arg_9_0:_playAnim(var_9_8.beforeMark, var_9_5, var_9_6)
	end

	gohelper.setActive(arg_9_0._btnCompose, var_9_0 <= var_9_5 and var_9_2 and not arg_9_1)
	gohelper.setActive(arg_9_0._btnLeft, arg_9_0._curPaperIndex ~= 1)
	gohelper.setActive(arg_9_0._btnRight, arg_9_0._curPaperIndex ~= #arg_9_0._paperList)
	gohelper.setActive(arg_9_0._goRightRed, arg_9_0._canCompose and not var_9_2)

	for iter_9_2, iter_9_3 in pairs(arg_9_0._goPoints) do
		gohelper.setActive(iter_9_3, iter_9_2 == arg_9_0._curPaperIndex)
	end

	if arg_9_1 and var_9_0 <= var_9_5 and var_9_2 then
		TaskDispatcher.runDelay(arg_9_0._delayShowComposeBtn, arg_9_0, 0.667)
	else
		TaskDispatcher.cancelTask(arg_9_0._delayShowComposeBtn, arg_9_0)
	end
end

function var_0_0._delayShowComposeBtn(arg_10_0)
	if not arg_10_0._animCompose then
		return
	end

	gohelper.setActive(arg_10_0._btnCompose, true)
	arg_10_0._animCompose:Play()
	AudioMgr.instance:trigger(AudioEnum3_0.CommandStationPaper.play_ui_tangren_pen1)
end

function var_0_0._playAnim(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if arg_11_0._curPaperIndex == 1 then
		arg_11_2 = Mathf.Floor(arg_11_2 / 2)
		arg_11_3 = Mathf.Floor(arg_11_3 / 2)
	end

	for iter_11_0, iter_11_1 in pairs(arg_11_1) do
		if arg_11_2 < iter_11_0 then
			iter_11_1:playAnim(1)
		elseif arg_11_3 < iter_11_0 then
			iter_11_1:playAnim(2)
		else
			iter_11_1:playAnim(3)
		end
	end
end

function var_0_0.scrollTo(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0._paperMarkDict[arg_12_0._curPaperIndex]

	if not var_12_0 or not var_12_0.afterMark[arg_12_1] then
		return
	end

	local var_12_1 = var_12_0.afterMark[arg_12_1].transform
	local var_12_2 = arg_12_0._paperContents[arg_12_0._curPaperIndex]
	local var_12_3 = var_12_2:InverseTransformPoint(var_12_1.position)
	local var_12_4 = 80
	local var_12_5 = recthelper.getHeight(var_12_2)
	local var_12_6 = recthelper.getHeight(var_12_2.parent)
	local var_12_7 = -var_12_3.y - var_12_4 / 2 - 5 - 200
	local var_12_8 = Mathf.Clamp(var_12_7, 0, var_12_5 - var_12_6)

	recthelper.setAnchorY(var_12_2, var_12_8)
end

function var_0_0._playDoneAnim(arg_13_0)
	gohelper.setActive(arg_13_0._paperDones[arg_13_0._curPaperIndex], true)
	arg_13_0._paperDonesAnim[arg_13_0._curPaperIndex]:Play()
	AudioMgr.instance:trigger(AudioEnum3_0.CommandStationPaper.play_ui_diqiu_yure_success)
end

function var_0_0._onChangePage(arg_14_0, arg_14_1)
	if arg_14_0._curPaperIndex + arg_14_1 > CommandStationModel.instance.paper + 1 then
		GameFacade.showToast(ToastEnum.CommandStationPaperSwitch)

		return
	end

	arg_14_0._curPaperIndex = arg_14_0._curPaperIndex + arg_14_1
	arg_14_0._anim.enabled = true

	if arg_14_1 > 0 then
		arg_14_0._anim:Play("switchright", 0, 0)
	else
		arg_14_0._anim:Play("switchleft", 0, 0)
	end

	UIBlockHelper.instance:startBlock("CommandStationPaperView_switch", 0.167)
	TaskDispatcher.runDelay(arg_14_0.refreshPaperCountAndPlayAudio, arg_14_0, 0.167)
end

function var_0_0.initPaper(arg_15_0)
	if arg_15_0._paperRoots then
		return
	end

	arg_15_0._paperRoots = arg_15_0:getUserDataTb_()
	arg_15_0._paperContents = arg_15_0:getUserDataTb_()
	arg_15_0._paperDones = arg_15_0:getUserDataTb_()
	arg_15_0._paperDonesAnim = arg_15_0:getUserDataTb_()
	arg_15_0._paperMarkDict = {}

	local var_15_0 = arg_15_0._paperRoot.transform

	for iter_15_0 = 0, var_15_0.childCount - 1 do
		local var_15_1 = var_15_0:GetChild(iter_15_0)
		local var_15_2 = string.match(var_15_1.name, "^#go_paper(%d+)$")
		local var_15_3 = tonumber(var_15_2)

		if var_15_3 then
			arg_15_0._paperRoots[var_15_3] = var_15_1.gameObject
			arg_15_0._paperContents[var_15_3] = gohelper.findChild(arg_15_0._paperRoots[var_15_3], "Panel/ViewPort/Content").transform
			arg_15_0._paperDones[var_15_3] = gohelper.findChild(arg_15_0._paperRoots[var_15_3], "Panel/ViewPort/Content/#go_Done")
			arg_15_0._paperDonesAnim[var_15_3] = gohelper.findChild(arg_15_0._paperRoots[var_15_3], "Panel/ViewPort/Content/#go_Done/ani"):GetComponent(typeof(UnityEngine.Animation))
			arg_15_0._paperMarkDict[var_15_3] = {
				afterMark = arg_15_0:getUserDataTb_(),
				beforeMark = arg_15_0:getUserDataTb_()
			}

			local var_15_4 = gohelper.findChild(arg_15_0._paperRoots[var_15_3], "Panel/ViewPort/Content/AfterMark")
			local var_15_5 = gohelper.findChild(arg_15_0._paperRoots[var_15_3], "Panel/ViewPort/Content/BeforeMark")

			var_15_4 = var_15_4 and var_15_4.transform
			var_15_5 = var_15_5 and var_15_5.transform

			if var_15_4 then
				for iter_15_1 = 0, var_15_4.childCount - 1 do
					local var_15_6 = var_15_4:GetChild(iter_15_1)
					local var_15_7, var_15_8 = string.match(var_15_6.name, "^#go_(%d+)_(%d+)$")
					local var_15_9 = tonumber(var_15_7)
					local var_15_10 = tonumber(var_15_8)

					if var_15_9 then
						arg_15_0._paperMarkDict[var_15_3].afterMark[var_15_9] = MonoHelper.addNoUpdateLuaComOnceToGo(var_15_6.gameObject, CommandStationPaperMarkItem, {
							after = true,
							style = var_15_10
						})
					end
				end
			end

			if var_15_5 then
				for iter_15_2 = 0, var_15_5.childCount - 1 do
					local var_15_11 = var_15_5:GetChild(iter_15_2)
					local var_15_12, var_15_13 = string.match(var_15_11.name, "^#go_(%d+)_(%d+)$")
					local var_15_14 = tonumber(var_15_12)
					local var_15_15 = tonumber(var_15_13)

					if var_15_14 then
						arg_15_0._paperMarkDict[var_15_3].beforeMark[var_15_14] = MonoHelper.addNoUpdateLuaComOnceToGo(var_15_11.gameObject, CommandStationPaperMarkItem, {
							after = false,
							style = var_15_15
						})
					end
				end
			end
		end
	end
end

function var_0_0._onTaskClick(arg_16_0)
	CommandStationController.instance:openCommandStationTaskView()
end

function var_0_0._onComposeClick(arg_17_0)
	CommandStationRpc.instance:sendCommandPostPaperRequest()
end

function var_0_0.onPaperUpdate(arg_18_0)
	arg_18_0._anim.enabled = true

	arg_18_0._anim:Play("rightout", 0, 0)
	TaskDispatcher.runDelay(arg_18_0._delayShowVideo, arg_18_0, 0.333)
	UIBlockHelper.instance:startBlock("CommandStationPaperView_rightout", 0.333)
end

function var_0_0._delayShowVideo(arg_19_0)
	AudioMgr.instance:trigger(AudioEnum3_0.CommandStationPaper.play_ui_lushang_zhihuibu_poyi)
	VideoController.instance:openFullScreenVideoView("videos/commandstation_decode.mp4", nil, 10, arg_19_0._onVideoEnd, arg_19_0)
end

function var_0_0._onVideoEnd(arg_20_0)
	ViewMgr.instance:openView(ViewName.CommandStationPaperGetView, {
		paperCo = arg_20_0._paperList[arg_20_0._curPaperIndex]
	})
	arg_20_0._anim:Play("rightin", 0, 0)
	TaskDispatcher.runDelay(arg_20_0.refreshPaperCountAndPlayAudio, arg_20_0, 0.633)
	UIBlockHelper.instance:startBlock("CommandStationPaperView_rightin", 0.633)

	arg_20_0._needPlayDoneAnim = true
end

function var_0_0.onClickDish(arg_21_0)
	ViewMgr.instance:openView(ViewName.CommandStationPaperGetView, {
		paperCo = arg_21_0._paperList[arg_21_0._curPaperIndex]
	})
end

function var_0_0.onClose(arg_22_0)
	TaskDispatcher.cancelTask(arg_22_0._delayShowComposeBtn, arg_22_0)
	TaskDispatcher.cancelTask(arg_22_0.refreshPaperCount, arg_22_0)
	TaskDispatcher.cancelTask(arg_22_0._delayShowVideo, arg_22_0)
	CommandStationController.StatCommandStationViewClose(arg_22_0.viewName, Time.realtimeSinceStartup - arg_22_0._viewOpenTime)
end

function var_0_0.onDestroyView(arg_23_0)
	if arg_23_0._paperMarkDict then
		for iter_23_0, iter_23_1 in pairs(arg_23_0._paperMarkDict) do
			for iter_23_2, iter_23_3 in pairs(iter_23_1.afterMark) do
				iter_23_3:destroy()
			end

			for iter_23_4, iter_23_5 in pairs(iter_23_1.beforeMark) do
				iter_23_5:destroy()
			end
		end
	end
end

return var_0_0
