module("modules.logic.turnback.view.TurnbackPopupRewardView", package.seeall)

slot0 = class("TurnbackPopupRewardView", BaseViewExtended)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._simagebgicon = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg/#simage_bgicon")
	slot0._simagerolebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg/#simage_rolebg")
	slot0._simageline = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg/#simage_line")
	slot0._scrollreward = gohelper.findChildScrollRect(slot0.viewGO, "reward/#scroll_reward")
	slot0._gorewardcontent = gohelper.findChild(slot0.viewGO, "reward/#scroll_reward/Viewport/#go_rewardcontent")
	slot0._btnreward = gohelper.findChildButtonWithAudio(slot0.viewGO, "reward/#btn_reward")
	slot0._gocanget = gohelper.findChild(slot0.viewGO, "reward/#btn_reward/#go_canget")
	slot0._gohasget = gohelper.findChild(slot0.viewGO, "reward/#btn_reward/#go_hasget")
	slot0._btnjump = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_jump")
	slot0._txtremaintime = gohelper.findChildText(slot0.viewGO, "#txt_remainTime")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._gosubmoduleContent = gohelper.findChild(slot0.viewGO, "#go_submoduleContent")
	slot0._gosubmoduleItem = gohelper.findChild(slot0.viewGO, "#go_submoduleContent/#go_submoduleItem")
	slot0._txtTitle = gohelper.findChildText(slot0.viewGO, "mask/#txt_title")
	slot0._subModuleContentLayout = slot0._gosubmoduleContent:GetComponentInChildren(gohelper.Type_GridLayoutGroup)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnreward:AddClickListener(slot0._btnrewardOnClick, slot0)
	slot0._btnjump:AddClickListener(slot0._btnjumpOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0:addEventCb(TurnbackController.instance, TurnbackEvent.RefreshOnceBonusGetState, slot0.refreshOnceBonusGetState, slot0)
	slot0:addEventCb(TurnbackController.instance, TurnbackEvent.RefreshRemainTime, slot0.refreshTime, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnreward:RemoveClickListener()
	slot0._btnjump:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
	slot0:removeEventCb(TurnbackController.instance, TurnbackEvent.RefreshOnceBonusGetState, slot0.refreshOnceBonusGetState, slot0)
	slot0:removeEventCb(TurnbackController.instance, TurnbackEvent.RefreshRemainTime, slot0.refreshTime, slot0)
end

function slot0._btnrewardOnClick(slot0)
	if TurnbackModel.instance:isInOpenTime() then
		if not slot0.hasGet then
			TurnbackRpc.instance:sendTurnbackOnceBonusRequest(slot0.turnbackId)
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_task_slide)
		end
	else
		ViewMgr.instance:closeView(ViewName.TurnbackPopupBeginnerView)
		GameFacade.showToast(ToastEnum.ActivityNotInOpenTime)
	end
end

function slot0._btnjumpOnClick(slot0)
	if TurnbackModel.instance:isInOpenTime() then
		if TurnbackConfig.instance:getTurnbackCo(slot0.turnbackId).jumpId ~= 0 then
			GameFacade.jump(slot1.jumpId)
		end
	else
		ViewMgr.instance:closeView(ViewName.TurnbackPopupBeginnerView)
		GameFacade.showToast(ToastEnum.ActivityNotInOpenTime)
	end
end

function slot0._btncloseOnClick(slot0)
	if slot0._param and slot0._param.closeCallback then
		slot0._param.closeCallback(slot0._param.callbackObject)
	end
end

function slot0._editableInitView(slot0)
	slot0._simagebg:LoadImage(ResUrl.getTurnbackIcon("turnback_windowbg"))
	slot0._simagebgicon:LoadImage(ResUrl.getTurnbackIcon("turnback_windowbg2"))
	slot0._simagerolebg:LoadImage(ResUrl.getTurnbackIcon("turnback_windowrolebg"))
	slot0._simageline:LoadImage(ResUrl.getTurnbackIcon("turnback_windowlinebg"))
	gohelper.setActive(slot0._gosubmoduleItem, false)

	slot0.subModuleItemTab = slot0:getUserDataTb_()
end

function slot0.onUpdateParam(slot0)
end

function slot0.onRefreshViewParam(slot0, slot1)
	slot0._param = slot1
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_feedback_open)

	slot0.turnbackId = TurnbackModel.instance:getCurTurnbackId()

	slot0:createReward()
	slot0:createSubModuleItem()
	slot0:refreshTime()
	slot0:refreshOnceBonusGetState()
end

function slot0.createReward(slot0)
	for slot6 = 1, #string.split(TurnbackConfig.instance:getTurnbackCo(slot0.turnbackId).onceBonus, "|") do
		slot7 = string.split(slot2[slot6], "#")
		slot8 = IconMgr.instance:getCommonPropItemIcon(slot0._gorewardcontent)

		slot8:setMOValue(slot7[1], slot7[2], slot7[3], nil, true)
		slot8:setPropItemScale(0.75)
		slot8:setCountFontSize(36)
		slot8:setHideLvAndBreakFlag(true)
		slot8:hideEquipLvAndBreak(true)
		gohelper.setActive(slot8.go, true)
	end
end

function slot0.createSubModuleItem(slot0)
	for slot6 = 1, #TurnbackConfig.instance:getAllTurnbackSubModules(slot0.turnbackId) do
		if TurnbackConfig.instance:getTurnbackSubModuleCo(slot1[slot6]).showInPopup == TurnbackEnum.showInPopup.Show then
			slot8 = {
				go = gohelper.clone(slot0._gosubmoduleItem, slot0._gosubmoduleContent, "subModule" .. slot1[slot6])
			}
			slot8.name = gohelper.findChildText(slot8.go, "txt_name")
			slot8.point1 = gohelper.findChild(slot8.go, "point/go_point1")
			slot8.point2 = gohelper.findChild(slot8.go, "point/go_point2")
			slot8.name.text = slot7.name

			table.insert(slot0.subModuleItemTab, slot8)
			gohelper.setActive(slot8.go, true)

			slot2 = 0 + 1
		else
			slot0._txtTitle.text = slot7.name
		end
	end

	slot0:setSubModuleItemContent(slot2)
end

function slot0.setSubModuleItemContent(slot0, slot1)
	for slot5 = 1, #slot0.subModuleItemTab do
		if slot1 > 3 then
			gohelper.setActive(slot0.subModuleItemTab[slot5].point1, (slot5 - 1) % 4 < 2)
			gohelper.setActive(slot0.subModuleItemTab[slot5].point2, (slot5 - 1) % 4 >= 2)
		else
			gohelper.setActive(slot0.subModuleItemTab[slot5].point1, slot5 % 2 ~= 0)
			gohelper.setActive(slot0.subModuleItemTab[slot5].point2, slot5 % 2 == 0)
		end
	end
end

function slot0.refreshOnceBonusGetState(slot0)
	slot0.hasGet = TurnbackModel.instance:getOnceBonusGetState()

	gohelper.setActive(slot0._gocanget, not slot0.hasGet)
	gohelper.setActive(slot0._gohasget, slot0.hasGet)
end

function slot0.refreshTime(slot0)
	slot0._txtremaintime.text = TurnbackController.instance:refreshRemainTime()
end

function slot0.onClose(slot0)
	slot0._simagebg:UnLoadImage()
	slot0._simagebgicon:UnLoadImage()
	slot0._simagerolebg:UnLoadImage()
	slot0._simageline:UnLoadImage()
end

function slot0.onDestroyView(slot0)
end

return slot0
