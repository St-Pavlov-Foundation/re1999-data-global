module("modules.logic.investigate.view.InvestigateOpinionCommonView", package.seeall)

local var_0_0 = class("InvestigateOpinionCommonView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagefullbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/view/#simage_fullbg")
	arg_1_0._simagefullbg2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/view/#simage_fullbg2")
	arg_1_0._simagefullbg3 = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/view/#simage_fullbg3")
	arg_1_0._simagefullbg4 = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/view/#simage_fullbg3/#simage_fullbg4")
	arg_1_0._simagetitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/view/#simage_title")
	arg_1_0._btnleftarrow = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/view/#simage_title/#btn_leftarrow")
	arg_1_0._goreddotleft = gohelper.findChild(arg_1_0.viewGO, "root/view/#simage_title/#btn_leftarrow/#go_reddotleft")
	arg_1_0._btnrightarrow = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/view/#simage_title/#btn_rightarrow")
	arg_1_0._goreddotright = gohelper.findChild(arg_1_0.viewGO, "root/view/#simage_title/#btn_rightarrow/#go_reddotright")
	arg_1_0._goprogress = gohelper.findChild(arg_1_0.viewGO, "root/view/#go_progress")
	arg_1_0._goprogresitem = gohelper.findChild(arg_1_0.viewGO, "root/view/#go_progress/#go_progresitem")
	arg_1_0._scrolldesc = gohelper.findChildScrollRect(arg_1_0.viewGO, "root/view/#scroll_desc")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "root/view/#scroll_desc/viewport/#go_content")
	arg_1_0._txtroledec = gohelper.findChildText(arg_1_0.viewGO, "root/view/#scroll_desc/viewport/#go_content/top/roledecbg/#txt_roledec")
	arg_1_0._txtdec = gohelper.findChildText(arg_1_0.viewGO, "root/view/#scroll_desc/viewport/#go_content/#txt_dec")
	arg_1_0._goOpinion = gohelper.findChild(arg_1_0.viewGO, "root/view/#go_Opinion")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "root/#go_topleft")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnleftarrow:AddClickListener(arg_2_0._btnleftarrowOnClick, arg_2_0)
	arg_2_0._btnrightarrow:AddClickListener(arg_2_0._btnrightarrowOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnleftarrow:RemoveClickListener()
	arg_3_0._btnrightarrow:RemoveClickListener()
end

function var_0_0._btnleftarrowOnClick(arg_4_0)
	local var_4_0, var_4_1 = arg_4_0:_getPrevValue(arg_4_0._moIndex, arg_4_0._moList)

	arg_4_0._moIndex = var_4_0

	InvestigateOpinionModel.instance:setInfo(var_4_1, arg_4_0._moList)
	InvestigateController.instance:dispatchEvent(InvestigateEvent.ChangeArrow)
end

function var_0_0._getPrevValue(arg_5_0, arg_5_1, arg_5_2)
	arg_5_1 = arg_5_1 - 1

	if arg_5_1 < 1 then
		arg_5_1 = #arg_5_2
	end

	local var_5_0 = arg_5_2[arg_5_1]

	return arg_5_1, var_5_0
end

function var_0_0._getNextValue(arg_6_0, arg_6_1, arg_6_2)
	arg_6_1 = arg_6_1 + 1

	if arg_6_1 > #arg_6_2 then
		arg_6_1 = 1
	end

	local var_6_0 = arg_6_2[arg_6_1]

	return arg_6_1, var_6_0
end

function var_0_0._btnrightarrowOnClick(arg_7_0)
	local var_7_0, var_7_1 = arg_7_0:_getNextValue(arg_7_0._moIndex, arg_7_0._moList)

	arg_7_0._moIndex = var_7_0

	InvestigateOpinionModel.instance:setInfo(var_7_1, arg_7_0._moList)
	InvestigateController.instance:dispatchEvent(InvestigateEvent.ChangeArrow)
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._opinionItemList = arg_8_0:getUserDataTb_()
	arg_8_0._progressItemList = arg_8_0:getUserDataTb_()
	arg_8_0._descItemList = arg_8_0:getUserDataTb_()
	arg_8_0._progressStatus = {}
	arg_8_0._txtdec.text = ""

	gohelper.setActive(arg_8_0._txtdec, false)
	gohelper.setActive(arg_8_0._goOpinion, true)

	arg_8_0._rootAnimator = arg_8_0.viewGO:GetComponent("Animator")
	arg_8_0._goDragTip = gohelper.findChild(arg_8_0.viewGO, "root/view/#fullbg_glow")
	arg_8_0._goUnFinishedTip = gohelper.findChild(arg_8_0.viewGO, "root/view/Bottom/txt_tips")
	arg_8_0._goFinishedTip = gohelper.findChild(arg_8_0.viewGO, "root/view/Bottom/img_finished")
	arg_8_0._redDotCompLeft = RedDotController.instance:addNotEventRedDot(arg_8_0._goreddotleft, arg_8_0._isShowLeftRedDot, arg_8_0)
	arg_8_0._redDotCompRight = RedDotController.instance:addNotEventRedDot(arg_8_0._goreddotright, arg_8_0._isShowRightRedDot, arg_8_0)

	arg_8_0:addEventCb(InvestigateController.instance, InvestigateEvent.ChangeArrow, arg_8_0._onChangeArrow, arg_8_0)
end

function var_0_0._onChangeArrow(arg_9_0)
	arg_9_0._redDotCompLeft:refreshRedDot()
	arg_9_0._redDotCompRight:refreshRedDot()
end

function var_0_0._isShowLeftRedDot(arg_10_0)
	local var_10_0, var_10_1 = InvestigateOpinionModel.instance:getInfo()

	if not var_10_0 or not var_10_1 then
		return false
	end

	local var_10_2 = tabletool.indexOf(var_10_1, var_10_0)

	if not var_10_2 then
		return false
	end

	local var_10_3, var_10_4 = arg_10_0:_getPrevValue(var_10_2, var_10_1)

	return InvestigateController.showSingleInfoRedDot(var_10_4.id)
end

function var_0_0._isShowRightRedDot(arg_11_0)
	local var_11_0, var_11_1 = InvestigateOpinionModel.instance:getInfo()

	if not var_11_0 or not var_11_1 then
		return false
	end

	local var_11_2 = tabletool.indexOf(var_11_1, var_11_0)

	if not var_11_2 then
		return false
	end

	local var_11_3, var_11_4 = arg_11_0:_getNextValue(var_11_2, var_11_1)

	return InvestigateController.showSingleInfoRedDot(var_11_4.id)
end

function var_0_0._onLinkedOpinionSuccess(arg_12_0, arg_12_1)
	arg_12_0:_updateProgress()
	arg_12_0:_checkFinish()

	arg_12_0._linkedClueId = arg_12_1

	arg_12_0:_initOpinionDescList(arg_12_0._opinionList)

	arg_12_0._linkedClueId = nil
end

function var_0_0.onTabSwitchOpen(arg_13_0)
	arg_13_0:addEventCb(InvestigateController.instance, InvestigateEvent.LinkedOpinionSuccess, arg_13_0._onLinkedOpinionSuccess, arg_13_0)

	local var_13_0, var_13_1 = InvestigateOpinionModel.instance:getInfo()

	arg_13_0:_initInfo(var_13_0, var_13_1)
end

function var_0_0.onTabSwitchClose(arg_14_0)
	arg_14_0:removeEventCb(InvestigateController.instance, InvestigateEvent.LinkedOpinionSuccess, arg_14_0._onLinkedOpinionSuccess, arg_14_0)
end

function var_0_0.setInExtendView(arg_15_0, arg_15_1)
	arg_15_0._isInExtendView = arg_15_1
end

function var_0_0.onOpen(arg_16_0)
	return
end

function var_0_0._initInfo(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0._moList = arg_17_2
	arg_17_0._moIndex = arg_17_0._moList and tabletool.indexOf(arg_17_0._moList, arg_17_1)
	arg_17_0._moNum = arg_17_0._moList and #arg_17_0._moList

	gohelper.setActive(arg_17_0._btnleftarrow, arg_17_0._moIndex ~= nil)
	gohelper.setActive(arg_17_0._btnrightarrow, arg_17_0._moIndex ~= nil)
	arg_17_0:_updateMo(arg_17_1)
end

function var_0_0._updateMo(arg_18_0, arg_18_1)
	arg_18_0._mo = arg_18_1
	arg_18_0._txtroledec.text = arg_18_0._mo.desc
	arg_18_0._opinionList = InvestigateConfig.instance:getInvestigateRelatedClueInfos(arg_18_0._mo.id)

	arg_18_0:_initOpinionItems()
	arg_18_0:_checkFinish()
	arg_18_0:_initOpinionProgress(arg_18_0._opinionList)
	arg_18_0:_initOpinionDescList(arg_18_0._opinionList)
	arg_18_0._redDotCompLeft:refreshRedDot()
	arg_18_0._redDotCompRight:refreshRedDot()
end

function var_0_0._initOpinionItems(arg_19_0)
	arg_19_0._opinionAllDataList = InvestigateConfig.instance:getInvestigateAllClueInfos(arg_19_0._mo.id)
	arg_19_0._opinionNum = #arg_19_0._opinionAllDataList

	local var_19_0 = gohelper.findChild(arg_19_0._goOpinion, tostring(arg_19_0._opinionNum))

	gohelper.setActive(var_19_0, true)

	local var_19_1 = arg_19_0._simagefullbg2 and arg_19_0._simagefullbg2.gameObject:GetComponent(typeof(UnityEngine.Collider2D))
	local var_19_2 = arg_19_0.viewContainer:getSetting().otherRes[1]

	if arg_19_0._curitemList then
		for iter_19_0, iter_19_1 in ipairs(arg_19_0._curitemList) do
			gohelper.setActive(iter_19_1.viewGO, false)
		end
	end

	arg_19_0._curitemList = arg_19_0._opinionItemList[arg_19_0._mo.id] or arg_19_0:getUserDataTb_()
	arg_19_0._opinionItemList[arg_19_0._mo.id] = arg_19_0._curitemList

	for iter_19_2 = 1, arg_19_0._opinionNum do
		local var_19_3 = arg_19_0._opinionAllDataList[iter_19_2]

		if not var_19_3 then
			break
		end

		local var_19_4 = arg_19_0._curitemList[iter_19_2]

		if not var_19_4 then
			local var_19_5 = gohelper.findChild(arg_19_0._goOpinion, string.format("%s/opinion%s", arg_19_0._opinionNum, iter_19_2))
			local var_19_6 = gohelper.findChild(arg_19_0._goOpinion, string.format("%s/node%s", arg_19_0._opinionNum, iter_19_2))
			local var_19_7 = arg_19_0:getResInst(var_19_2, var_19_5)

			var_19_4 = MonoHelper.addNoUpdateLuaComOnceToGo(var_19_7, InvestigateOpinionItem)

			var_19_4:setIndex(iter_19_2, arg_19_0._opinionNum)
			var_19_4:setInExtendView(arg_19_0._isInExtendView)

			if not var_19_6 then
				logError(string.format("_initOpinionItems nodeEndGo is nil path:%s/node%s", arg_19_0._opinionNum, iter_19_2))
			end

			var_19_4:onUpdateMO(var_19_3, var_19_1, var_19_5, var_19_6, arg_19_0._goDragTip)

			arg_19_0._curitemList[iter_19_2] = var_19_4
		end

		gohelper.setActive(var_19_4.viewGO, true)
	end
end

function var_0_0._initOpinionProgress(arg_20_0, arg_20_1)
	gohelper.CreateObjList(arg_20_0, arg_20_0._onItemShow, arg_20_1, arg_20_0._goprogress, arg_20_0._goprogresitem)
	arg_20_0:_updateProgress()
end

function var_0_0._onItemShow(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = arg_21_0:getUserDataTb_()

	arg_21_0._progressItemList[arg_21_3] = var_21_0
	var_21_0.unfinished = gohelper.findChild(arg_21_1, "unfinished")
	var_21_0.finished = gohelper.findChild(arg_21_1, "finished")
	var_21_0.light = gohelper.findChild(arg_21_1, "light")
	var_21_0.config = arg_21_2
end

function var_0_0._updateProgress(arg_22_0)
	for iter_22_0, iter_22_1 in ipairs(arg_22_0._progressItemList) do
		local var_22_0 = InvestigateOpinionModel.instance:getLinkedStatus(iter_22_1.config.id)

		gohelper.setActive(iter_22_1.unfinished, not var_22_0)
		gohelper.setActive(iter_22_1.finished, var_22_0)

		if not arg_22_0._isInExtendView then
			local var_22_1 = arg_22_0._progressStatus[iter_22_0]

			arg_22_0._progressStatus[iter_22_0] = var_22_0

			if var_22_1 == false and var_22_0 then
				gohelper.setActive(iter_22_1.light, true)
			end
		end
	end
end

function var_0_0._checkFinish(arg_23_0)
	local var_23_0 = true

	for iter_23_0, iter_23_1 in ipairs(arg_23_0._opinionList) do
		if InvestigateOpinionModel.instance:getLinkedStatus(iter_23_1.id) == false then
			var_23_0 = false

			break
		end
	end

	gohelper.setActive(arg_23_0._goFinishedTip, var_23_0)
	gohelper.setActive(arg_23_0._goUnFinishedTip, not var_23_0)
end

function var_0_0._initOpinionDescList(arg_24_0, arg_24_1)
	local var_24_0 = #arg_24_1

	for iter_24_0, iter_24_1 in ipairs(arg_24_0._descItemList) do
		gohelper.setActive(iter_24_1, iter_24_0 <= var_24_0)
	end

	for iter_24_2, iter_24_3 in ipairs(arg_24_1) do
		local var_24_1 = arg_24_0._descItemList[iter_24_2] or gohelper.cloneInPlace(arg_24_0._txtdec.gameObject)

		arg_24_0._descItemList[iter_24_2] = var_24_1

		gohelper.setActive(var_24_1, true)

		local var_24_2 = InvestigateOpinionModel.instance:getLinkedStatus(iter_24_3.id)
		local var_24_3 = gohelper.findChildTextMesh(var_24_1, "")
		local var_24_4 = gohelper.findChild(var_24_1, "line")

		var_24_3.text = iter_24_3.relatedDesc

		local var_24_5 = var_24_3.color

		var_24_5.a = var_24_2 and 1 or 0
		var_24_3.color = var_24_5

		gohelper.setActive(var_24_4, var_24_2)

		if not arg_24_0._isInExtendView then
			local var_24_6 = SLFramework.AnimatorPlayer.Get(var_24_1)

			if var_24_6 and iter_24_3.id == arg_24_0._linkedClueId then
				var_24_6:Play("open", arg_24_0._openAnimDone, arg_24_0)

				if var_24_0 > 2 then
					arg_24_0._scrolldesc.verticalNormalizedPosition = iter_24_2 > 2 and 0 or 1
				end

				AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Investigate.play_ui_molu_jlbn_level_unlock)
			end
		end
	end
end

function var_0_0._openAnimDone(arg_25_0)
	return
end

function var_0_0.onClose(arg_26_0)
	arg_26_0._rootAnimator:Play("close", 0, 0)
end

function var_0_0.onDestroyView(arg_27_0)
	return
end

return var_0_0
