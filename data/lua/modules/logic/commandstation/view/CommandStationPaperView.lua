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
		local var_9_9 = arg_9_0._paperList[arg_9_0._curPaperIndex]

		arg_9_0:_playAnim(var_9_8.afterMark, var_9_5, var_9_6, var_9_9)
		arg_9_0:_playAnim(var_9_8.beforeMark, var_9_5, var_9_6, var_9_9)
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

function var_0_0._playAnim(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	if arg_11_0._curPaperIndex == 1 then
		arg_11_2 = Mathf.Floor(arg_11_2 / 2)
		arg_11_3 = Mathf.Floor(arg_11_3 / 2)
	end

	for iter_11_0, iter_11_1 in pairs(arg_11_1) do
		local var_11_0 = arg_11_0:_getOrderIndex(iter_11_0, arg_11_4)

		if arg_11_2 < var_11_0 then
			iter_11_1:playAnim(1)
		elseif arg_11_3 < var_11_0 then
			iter_11_1:playAnim(2)
		else
			iter_11_1:playAnim(3)
		end
	end
end

function var_0_0._getOrderIndex(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_1

	if arg_12_2.order and #arg_12_2.order > 0 then
		var_12_0 = tabletool.indexOf(arg_12_2.order, arg_12_1)

		if not var_12_0 then
			var_12_0 = arg_12_1

			logError(string.format("paperConfig id:%s,order is not contain index %s", arg_12_2.id, arg_12_1))
		end
	end

	return var_12_0
end

function var_0_0.scrollTo(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0._paperList[arg_13_0._curPaperIndex].order[arg_13_1] or arg_13_1
	local var_13_1 = arg_13_0._paperMarkDict[arg_13_0._curPaperIndex]

	if not var_13_1 or not var_13_1.afterMark[var_13_0] then
		return
	end

	local var_13_2 = var_13_1.afterMark[var_13_0].transform
	local var_13_3 = arg_13_0._paperContents[arg_13_0._curPaperIndex]
	local var_13_4 = var_13_3:InverseTransformPoint(var_13_2.position)
	local var_13_5 = 80
	local var_13_6 = recthelper.getHeight(var_13_3)
	local var_13_7 = recthelper.getHeight(var_13_3.parent)
	local var_13_8 = -var_13_4.y - var_13_5 / 2 - 5 - 200
	local var_13_9 = Mathf.Clamp(var_13_8, 0, var_13_6 - var_13_7)

	recthelper.setAnchorY(var_13_3, var_13_9)
end

function var_0_0._playDoneAnim(arg_14_0)
	gohelper.setActive(arg_14_0._paperDones[arg_14_0._curPaperIndex], true)
	arg_14_0._paperDonesAnim[arg_14_0._curPaperIndex]:Play()
	AudioMgr.instance:trigger(AudioEnum3_0.CommandStationPaper.play_ui_diqiu_yure_success)
end

function var_0_0._onChangePage(arg_15_0, arg_15_1)
	if arg_15_0._curPaperIndex + arg_15_1 > CommandStationModel.instance.paper + 1 then
		GameFacade.showToast(ToastEnum.CommandStationPaperSwitch)

		return
	end

	arg_15_0._curPaperIndex = arg_15_0._curPaperIndex + arg_15_1
	arg_15_0._anim.enabled = true

	if arg_15_1 > 0 then
		arg_15_0._anim:Play("switchright", 0, 0)
	else
		arg_15_0._anim:Play("switchleft", 0, 0)
	end

	UIBlockHelper.instance:startBlock("CommandStationPaperView_switch", 0.167)
	TaskDispatcher.runDelay(arg_15_0.refreshPaperCountAndPlayAudio, arg_15_0, 0.167)
end

function var_0_0.initPaper(arg_16_0)
	if arg_16_0._paperRoots then
		return
	end

	arg_16_0._paperRoots = arg_16_0:getUserDataTb_()
	arg_16_0._paperContents = arg_16_0:getUserDataTb_()
	arg_16_0._paperDones = arg_16_0:getUserDataTb_()
	arg_16_0._paperDonesAnim = arg_16_0:getUserDataTb_()
	arg_16_0._paperMarkDict = {}

	local var_16_0 = arg_16_0._paperRoot.transform

	for iter_16_0 = 0, var_16_0.childCount - 1 do
		local var_16_1 = var_16_0:GetChild(iter_16_0)
		local var_16_2 = string.match(var_16_1.name, "^#go_paper(%d+)$")
		local var_16_3 = tonumber(var_16_2)

		if var_16_3 then
			arg_16_0._paperRoots[var_16_3] = var_16_1.gameObject
			arg_16_0._paperContents[var_16_3] = gohelper.findChild(arg_16_0._paperRoots[var_16_3], "Panel/ViewPort/Content").transform
			arg_16_0._paperDones[var_16_3] = gohelper.findChild(arg_16_0._paperRoots[var_16_3], "Panel/ViewPort/Content/#go_Done")
			arg_16_0._paperDonesAnim[var_16_3] = gohelper.findChild(arg_16_0._paperRoots[var_16_3], "Panel/ViewPort/Content/#go_Done/ani"):GetComponent(typeof(UnityEngine.Animation))
			arg_16_0._paperMarkDict[var_16_3] = {
				afterMark = arg_16_0:getUserDataTb_(),
				beforeMark = arg_16_0:getUserDataTb_()
			}

			local var_16_4 = gohelper.findChild(arg_16_0._paperRoots[var_16_3], "Panel/ViewPort/Content/AfterMark")
			local var_16_5 = gohelper.findChild(arg_16_0._paperRoots[var_16_3], "Panel/ViewPort/Content/BeforeMark")

			var_16_4 = var_16_4 and var_16_4.transform
			var_16_5 = var_16_5 and var_16_5.transform

			if var_16_4 then
				for iter_16_1 = 0, var_16_4.childCount - 1 do
					local var_16_6 = var_16_4:GetChild(iter_16_1)
					local var_16_7, var_16_8 = string.match(var_16_6.name, "^#go_(%d+)_(%d+)$")
					local var_16_9 = tonumber(var_16_7)
					local var_16_10 = tonumber(var_16_8)

					if var_16_9 then
						arg_16_0._paperMarkDict[var_16_3].afterMark[var_16_9] = MonoHelper.addNoUpdateLuaComOnceToGo(var_16_6.gameObject, CommandStationPaperMarkItem, {
							after = true,
							style = var_16_10
						})
					end
				end
			end

			if var_16_5 then
				for iter_16_2 = 0, var_16_5.childCount - 1 do
					local var_16_11 = var_16_5:GetChild(iter_16_2)
					local var_16_12, var_16_13 = string.match(var_16_11.name, "^#go_(%d+)_(%d+)$")
					local var_16_14 = tonumber(var_16_12)
					local var_16_15 = tonumber(var_16_13)

					if var_16_14 then
						arg_16_0._paperMarkDict[var_16_3].beforeMark[var_16_14] = MonoHelper.addNoUpdateLuaComOnceToGo(var_16_11.gameObject, CommandStationPaperMarkItem, {
							after = false,
							style = var_16_15
						})
					end
				end
			end
		end
	end
end

function var_0_0._onTaskClick(arg_17_0)
	CommandStationController.instance:openCommandStationTaskView()
end

function var_0_0._onComposeClick(arg_18_0)
	CommandStationRpc.instance:sendCommandPostPaperRequest()
end

function var_0_0.onPaperUpdate(arg_19_0)
	arg_19_0:_checkCanCompose()

	arg_19_0._anim.enabled = true

	arg_19_0._anim:Play("rightout", 0, 0)
	TaskDispatcher.runDelay(arg_19_0._delayShowVideo, arg_19_0, 0.333)
	UIBlockHelper.instance:startBlock("CommandStationPaperView_rightout", 0.333)
end

function var_0_0._delayShowVideo(arg_20_0)
	AudioMgr.instance:trigger(AudioEnum3_0.CommandStationPaper.play_ui_lushang_zhihuibu_poyi)
	VideoController.instance:openFullScreenVideoView("videos/commandstation_decode.mp4", nil, 10, arg_20_0._onVideoEnd, arg_20_0)
end

function var_0_0._onVideoEnd(arg_21_0)
	ViewMgr.instance:openView(ViewName.CommandStationPaperGetView, {
		paperCo = arg_21_0._paperList[arg_21_0._curPaperIndex]
	})
	arg_21_0._anim:Play("rightin", 0, 0)
	TaskDispatcher.runDelay(arg_21_0.refreshPaperCountAndPlayAudio, arg_21_0, 0.633)
	UIBlockHelper.instance:startBlock("CommandStationPaperView_rightin", 0.633)

	arg_21_0._needPlayDoneAnim = true
end

function var_0_0.onClickDish(arg_22_0)
	ViewMgr.instance:openView(ViewName.CommandStationPaperGetView, {
		paperCo = arg_22_0._paperList[arg_22_0._curPaperIndex]
	})
end

function var_0_0.onClose(arg_23_0)
	TaskDispatcher.cancelTask(arg_23_0._delayShowComposeBtn, arg_23_0)
	TaskDispatcher.cancelTask(arg_23_0.refreshPaperCount, arg_23_0)
	TaskDispatcher.cancelTask(arg_23_0._delayShowVideo, arg_23_0)
	CommandStationController.StatCommandStationViewClose(arg_23_0.viewName, Time.realtimeSinceStartup - arg_23_0._viewOpenTime)
end

function var_0_0.onDestroyView(arg_24_0)
	if arg_24_0._paperMarkDict then
		for iter_24_0, iter_24_1 in pairs(arg_24_0._paperMarkDict) do
			for iter_24_2, iter_24_3 in pairs(iter_24_1.afterMark) do
				iter_24_3:destroy()
			end

			for iter_24_4, iter_24_5 in pairs(iter_24_1.beforeMark) do
				iter_24_5:destroy()
			end
		end
	end
end

return var_0_0
