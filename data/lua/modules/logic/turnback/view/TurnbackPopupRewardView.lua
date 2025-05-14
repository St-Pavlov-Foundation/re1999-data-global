module("modules.logic.turnback.view.TurnbackPopupRewardView", package.seeall)

local var_0_0 = class("TurnbackPopupRewardView", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._simagebgicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg/#simage_bgicon")
	arg_1_0._simagerolebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg/#simage_rolebg")
	arg_1_0._simageline = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg/#simage_line")
	arg_1_0._scrollreward = gohelper.findChildScrollRect(arg_1_0.viewGO, "reward/#scroll_reward")
	arg_1_0._gorewardcontent = gohelper.findChild(arg_1_0.viewGO, "reward/#scroll_reward/Viewport/#go_rewardcontent")
	arg_1_0._btnreward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "reward/#btn_reward")
	arg_1_0._gocanget = gohelper.findChild(arg_1_0.viewGO, "reward/#btn_reward/#go_canget")
	arg_1_0._gohasget = gohelper.findChild(arg_1_0.viewGO, "reward/#btn_reward/#go_hasget")
	arg_1_0._btnjump = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_jump")
	arg_1_0._txtremaintime = gohelper.findChildText(arg_1_0.viewGO, "#txt_remainTime")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._gosubmoduleContent = gohelper.findChild(arg_1_0.viewGO, "#go_submoduleContent")
	arg_1_0._gosubmoduleItem = gohelper.findChild(arg_1_0.viewGO, "#go_submoduleContent/#go_submoduleItem")
	arg_1_0._txtTitle = gohelper.findChildText(arg_1_0.viewGO, "mask/#txt_title")
	arg_1_0._subModuleContentLayout = arg_1_0._gosubmoduleContent:GetComponentInChildren(gohelper.Type_GridLayoutGroup)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnreward:AddClickListener(arg_2_0._btnrewardOnClick, arg_2_0)
	arg_2_0._btnjump:AddClickListener(arg_2_0._btnjumpOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0:addEventCb(TurnbackController.instance, TurnbackEvent.RefreshOnceBonusGetState, arg_2_0.refreshOnceBonusGetState, arg_2_0)
	arg_2_0:addEventCb(TurnbackController.instance, TurnbackEvent.RefreshRemainTime, arg_2_0.refreshTime, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnreward:RemoveClickListener()
	arg_3_0._btnjump:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0:removeEventCb(TurnbackController.instance, TurnbackEvent.RefreshOnceBonusGetState, arg_3_0.refreshOnceBonusGetState, arg_3_0)
	arg_3_0:removeEventCb(TurnbackController.instance, TurnbackEvent.RefreshRemainTime, arg_3_0.refreshTime, arg_3_0)
end

function var_0_0._btnrewardOnClick(arg_4_0)
	if TurnbackModel.instance:isInOpenTime() then
		if not arg_4_0.hasGet then
			TurnbackRpc.instance:sendTurnbackOnceBonusRequest(arg_4_0.turnbackId)
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_task_slide)
		end
	else
		ViewMgr.instance:closeView(ViewName.TurnbackPopupBeginnerView)
		GameFacade.showToast(ToastEnum.ActivityNotInOpenTime)
	end
end

function var_0_0._btnjumpOnClick(arg_5_0)
	if TurnbackModel.instance:isInOpenTime() then
		local var_5_0 = TurnbackConfig.instance:getTurnbackCo(arg_5_0.turnbackId)

		if var_5_0.jumpId ~= 0 then
			GameFacade.jump(var_5_0.jumpId)
		end
	else
		ViewMgr.instance:closeView(ViewName.TurnbackPopupBeginnerView)
		GameFacade.showToast(ToastEnum.ActivityNotInOpenTime)
	end
end

function var_0_0._btncloseOnClick(arg_6_0)
	if arg_6_0._param and arg_6_0._param.closeCallback then
		arg_6_0._param.closeCallback(arg_6_0._param.callbackObject)
	end
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._simagebg:LoadImage(ResUrl.getTurnbackIcon("turnback_windowbg"))
	arg_7_0._simagebgicon:LoadImage(ResUrl.getTurnbackIcon("turnback_windowbg2"))
	arg_7_0._simagerolebg:LoadImage(ResUrl.getTurnbackIcon("turnback_windowrolebg"))
	arg_7_0._simageline:LoadImage(ResUrl.getTurnbackIcon("turnback_windowlinebg"))
	gohelper.setActive(arg_7_0._gosubmoduleItem, false)

	arg_7_0.subModuleItemTab = arg_7_0:getUserDataTb_()
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onRefreshViewParam(arg_9_0, arg_9_1)
	arg_9_0._param = arg_9_1
end

function var_0_0.onOpen(arg_10_0)
	AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_feedback_open)

	arg_10_0.turnbackId = TurnbackModel.instance:getCurTurnbackId()

	arg_10_0:createReward()
	arg_10_0:createSubModuleItem()
	arg_10_0:refreshTime()
	arg_10_0:refreshOnceBonusGetState()
end

function var_0_0.createReward(arg_11_0)
	local var_11_0 = TurnbackConfig.instance:getTurnbackCo(arg_11_0.turnbackId)
	local var_11_1 = string.split(var_11_0.onceBonus, "|")

	for iter_11_0 = 1, #var_11_1 do
		local var_11_2 = string.split(var_11_1[iter_11_0], "#")
		local var_11_3 = IconMgr.instance:getCommonPropItemIcon(arg_11_0._gorewardcontent)

		var_11_3:setMOValue(var_11_2[1], var_11_2[2], var_11_2[3], nil, true)
		var_11_3:setPropItemScale(0.75)
		var_11_3:setCountFontSize(36)
		var_11_3:setHideLvAndBreakFlag(true)
		var_11_3:hideEquipLvAndBreak(true)
		gohelper.setActive(var_11_3.go, true)
	end
end

function var_0_0.createSubModuleItem(arg_12_0)
	local var_12_0 = TurnbackConfig.instance:getAllTurnbackSubModules(arg_12_0.turnbackId)
	local var_12_1 = 0

	for iter_12_0 = 1, #var_12_0 do
		local var_12_2 = TurnbackConfig.instance:getTurnbackSubModuleCo(var_12_0[iter_12_0])

		if var_12_2.showInPopup == TurnbackEnum.showInPopup.Show then
			local var_12_3 = {
				go = gohelper.clone(arg_12_0._gosubmoduleItem, arg_12_0._gosubmoduleContent, "subModule" .. var_12_0[iter_12_0])
			}

			var_12_3.name = gohelper.findChildText(var_12_3.go, "txt_name")
			var_12_3.point1 = gohelper.findChild(var_12_3.go, "point/go_point1")
			var_12_3.point2 = gohelper.findChild(var_12_3.go, "point/go_point2")
			var_12_3.name.text = var_12_2.name

			table.insert(arg_12_0.subModuleItemTab, var_12_3)
			gohelper.setActive(var_12_3.go, true)

			var_12_1 = var_12_1 + 1
		else
			arg_12_0._txtTitle.text = var_12_2.name
		end
	end

	arg_12_0:setSubModuleItemContent(var_12_1)
end

function var_0_0.setSubModuleItemContent(arg_13_0, arg_13_1)
	for iter_13_0 = 1, #arg_13_0.subModuleItemTab do
		if arg_13_1 > 3 then
			gohelper.setActive(arg_13_0.subModuleItemTab[iter_13_0].point1, (iter_13_0 - 1) % 4 < 2)
			gohelper.setActive(arg_13_0.subModuleItemTab[iter_13_0].point2, (iter_13_0 - 1) % 4 >= 2)
		else
			gohelper.setActive(arg_13_0.subModuleItemTab[iter_13_0].point1, iter_13_0 % 2 ~= 0)
			gohelper.setActive(arg_13_0.subModuleItemTab[iter_13_0].point2, iter_13_0 % 2 == 0)
		end
	end
end

function var_0_0.refreshOnceBonusGetState(arg_14_0)
	arg_14_0.hasGet = TurnbackModel.instance:getOnceBonusGetState()

	gohelper.setActive(arg_14_0._gocanget, not arg_14_0.hasGet)
	gohelper.setActive(arg_14_0._gohasget, arg_14_0.hasGet)
end

function var_0_0.refreshTime(arg_15_0)
	arg_15_0._txtremaintime.text = TurnbackController.instance:refreshRemainTime()
end

function var_0_0.onClose(arg_16_0)
	arg_16_0._simagebg:UnLoadImage()
	arg_16_0._simagebgicon:UnLoadImage()
	arg_16_0._simagerolebg:UnLoadImage()
	arg_16_0._simageline:UnLoadImage()
end

function var_0_0.onDestroyView(arg_17_0)
	return
end

return var_0_0
