module("modules.logic.investigate.view.InvestigateOpinionCommonView", package.seeall)

slot0 = class("InvestigateOpinionCommonView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagefullbg = gohelper.findChildSingleImage(slot0.viewGO, "root/view/#simage_fullbg")
	slot0._simagefullbg2 = gohelper.findChildSingleImage(slot0.viewGO, "root/view/#simage_fullbg2")
	slot0._simagefullbg3 = gohelper.findChildSingleImage(slot0.viewGO, "root/view/#simage_fullbg3")
	slot0._simagefullbg4 = gohelper.findChildSingleImage(slot0.viewGO, "root/view/#simage_fullbg3/#simage_fullbg4")
	slot0._simagetitle = gohelper.findChildSingleImage(slot0.viewGO, "root/view/#simage_title")
	slot0._btnleftarrow = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/view/#simage_title/#btn_leftarrow")
	slot0._goreddotleft = gohelper.findChild(slot0.viewGO, "root/view/#simage_title/#btn_leftarrow/#go_reddotleft")
	slot0._btnrightarrow = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/view/#simage_title/#btn_rightarrow")
	slot0._goreddotright = gohelper.findChild(slot0.viewGO, "root/view/#simage_title/#btn_rightarrow/#go_reddotright")
	slot0._goprogress = gohelper.findChild(slot0.viewGO, "root/view/#go_progress")
	slot0._goprogresitem = gohelper.findChild(slot0.viewGO, "root/view/#go_progress/#go_progresitem")
	slot0._scrolldesc = gohelper.findChildScrollRect(slot0.viewGO, "root/view/#scroll_desc")
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "root/view/#scroll_desc/viewport/#go_content")
	slot0._txtroledec = gohelper.findChildText(slot0.viewGO, "root/view/#scroll_desc/viewport/#go_content/top/roledecbg/#txt_roledec")
	slot0._txtdec = gohelper.findChildText(slot0.viewGO, "root/view/#scroll_desc/viewport/#go_content/#txt_dec")
	slot0._goOpinion = gohelper.findChild(slot0.viewGO, "root/view/#go_Opinion")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "root/#go_topleft")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnleftarrow:AddClickListener(slot0._btnleftarrowOnClick, slot0)
	slot0._btnrightarrow:AddClickListener(slot0._btnrightarrowOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnleftarrow:RemoveClickListener()
	slot0._btnrightarrow:RemoveClickListener()
end

function slot0._btnleftarrowOnClick(slot0)
	slot0._moIndex, slot2 = slot0:_getPrevValue(slot0._moIndex, slot0._moList)

	InvestigateOpinionModel.instance:setInfo(slot2, slot0._moList)
	InvestigateController.instance:dispatchEvent(InvestigateEvent.ChangeArrow)
end

function slot0._getPrevValue(slot0, slot1, slot2)
	if slot1 - 1 < 1 then
		slot1 = #slot2
	end

	return slot1, slot2[slot1]
end

function slot0._getNextValue(slot0, slot1, slot2)
	if slot1 + 1 > #slot2 then
		slot1 = 1
	end

	return slot1, slot2[slot1]
end

function slot0._btnrightarrowOnClick(slot0)
	slot0._moIndex, slot2 = slot0:_getNextValue(slot0._moIndex, slot0._moList)

	InvestigateOpinionModel.instance:setInfo(slot2, slot0._moList)
	InvestigateController.instance:dispatchEvent(InvestigateEvent.ChangeArrow)
end

function slot0._editableInitView(slot0)
	slot0._opinionItemList = slot0:getUserDataTb_()
	slot0._progressItemList = slot0:getUserDataTb_()
	slot0._descItemList = slot0:getUserDataTb_()
	slot0._progressStatus = {}
	slot0._txtdec.text = ""

	gohelper.setActive(slot0._txtdec, false)
	gohelper.setActive(slot0._goOpinion, true)

	slot0._rootAnimator = slot0.viewGO:GetComponent("Animator")
	slot0._goDragTip = gohelper.findChild(slot0.viewGO, "root/view/#fullbg_glow")
	slot0._goUnFinishedTip = gohelper.findChild(slot0.viewGO, "root/view/Bottom/txt_tips")
	slot0._goFinishedTip = gohelper.findChild(slot0.viewGO, "root/view/Bottom/img_finished")
	slot0._redDotCompLeft = RedDotController.instance:addNotEventRedDot(slot0._goreddotleft, slot0._isShowLeftRedDot, slot0)
	slot0._redDotCompRight = RedDotController.instance:addNotEventRedDot(slot0._goreddotright, slot0._isShowRightRedDot, slot0)

	slot0:addEventCb(InvestigateController.instance, InvestigateEvent.ChangeArrow, slot0._onChangeArrow, slot0)
end

function slot0._onChangeArrow(slot0)
	slot0._redDotCompLeft:refreshRedDot()
	slot0._redDotCompRight:refreshRedDot()
end

function slot0._isShowLeftRedDot(slot0)
	slot1, slot2 = InvestigateOpinionModel.instance:getInfo()

	if not slot1 or not slot2 then
		return false
	end

	if not tabletool.indexOf(slot2, slot1) then
		return false
	end

	slot4, slot5 = slot0:_getPrevValue(slot3, slot2)

	return InvestigateController.showSingleInfoRedDot(slot5.id)
end

function slot0._isShowRightRedDot(slot0)
	slot1, slot2 = InvestigateOpinionModel.instance:getInfo()

	if not slot1 or not slot2 then
		return false
	end

	if not tabletool.indexOf(slot2, slot1) then
		return false
	end

	slot4, slot5 = slot0:_getNextValue(slot3, slot2)

	return InvestigateController.showSingleInfoRedDot(slot5.id)
end

function slot0._onLinkedOpinionSuccess(slot0, slot1)
	slot0:_updateProgress()
	slot0:_checkFinish()

	slot0._linkedClueId = slot1

	slot0:_initOpinionDescList(slot0._opinionList)

	slot0._linkedClueId = nil
end

function slot0.onTabSwitchOpen(slot0)
	slot0:addEventCb(InvestigateController.instance, InvestigateEvent.LinkedOpinionSuccess, slot0._onLinkedOpinionSuccess, slot0)

	slot1, slot2 = InvestigateOpinionModel.instance:getInfo()

	slot0:_initInfo(slot1, slot2)
end

function slot0.onTabSwitchClose(slot0)
	slot0:removeEventCb(InvestigateController.instance, InvestigateEvent.LinkedOpinionSuccess, slot0._onLinkedOpinionSuccess, slot0)
end

function slot0.setInExtendView(slot0, slot1)
	slot0._isInExtendView = slot1
end

function slot0.onOpen(slot0)
end

function slot0._initInfo(slot0, slot1, slot2)
	slot0._moList = slot2
	slot0._moIndex = slot0._moList and tabletool.indexOf(slot0._moList, slot1)
	slot0._moNum = slot0._moList and #slot0._moList

	gohelper.setActive(slot0._btnleftarrow, slot0._moIndex ~= nil)
	gohelper.setActive(slot0._btnrightarrow, slot0._moIndex ~= nil)
	slot0:_updateMo(slot1)
end

function slot0._updateMo(slot0, slot1)
	slot0._mo = slot1
	slot0._txtroledec.text = slot0._mo.desc
	slot0._opinionList = InvestigateConfig.instance:getInvestigateRelatedClueInfos(slot0._mo.id)

	slot0:_initOpinionItems()
	slot0:_checkFinish()
	slot0:_initOpinionProgress(slot0._opinionList)
	slot0:_initOpinionDescList(slot0._opinionList)
	slot0._redDotCompLeft:refreshRedDot()
	slot0._redDotCompRight:refreshRedDot()
end

function slot0._initOpinionItems(slot0)
	slot0._opinionAllDataList = InvestigateConfig.instance:getInvestigateAllClueInfos(slot0._mo.id)
	slot0._opinionNum = #slot0._opinionAllDataList

	gohelper.setActive(gohelper.findChild(slot0._goOpinion, tostring(slot0._opinionNum)), true)

	slot2 = slot0._simagefullbg2 and slot0._simagefullbg2.gameObject:GetComponent(typeof(UnityEngine.Collider2D))
	slot3 = slot0.viewContainer:getSetting().otherRes[1]

	if slot0._curitemList then
		for slot7, slot8 in ipairs(slot0._curitemList) do
			gohelper.setActive(slot8.viewGO, false)
		end
	end

	slot0._curitemList = slot0._opinionItemList[slot0._mo.id] or slot0:getUserDataTb_()
	slot0._opinionItemList[slot0._mo.id] = slot0._curitemList

	for slot7 = 1, slot0._opinionNum do
		if not slot0._opinionAllDataList[slot7] then
			break
		end

		if not slot0._curitemList[slot7] then
			slot9 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot3, gohelper.findChild(slot0._goOpinion, string.format("%s/opinion%s", slot0._opinionNum, slot7))), InvestigateOpinionItem)

			slot9:setIndex(slot7, slot0._opinionNum)
			slot9:setInExtendView(slot0._isInExtendView)

			if not gohelper.findChild(slot0._goOpinion, string.format("%s/node%s", slot0._opinionNum, slot7)) then
				logError(string.format("_initOpinionItems nodeEndGo is nil path:%s/node%s", slot0._opinionNum, slot7))
			end

			slot9:onUpdateMO(slot8, slot2, slot10, slot11, slot0._goDragTip)

			slot0._curitemList[slot7] = slot9
		end

		gohelper.setActive(slot9.viewGO, true)
	end
end

function slot0._initOpinionProgress(slot0, slot1)
	gohelper.CreateObjList(slot0, slot0._onItemShow, slot1, slot0._goprogress, slot0._goprogresitem)
	slot0:_updateProgress()
end

function slot0._onItemShow(slot0, slot1, slot2, slot3)
	slot4 = slot0:getUserDataTb_()
	slot0._progressItemList[slot3] = slot4
	slot4.unfinished = gohelper.findChild(slot1, "unfinished")
	slot4.finished = gohelper.findChild(slot1, "finished")
	slot4.light = gohelper.findChild(slot1, "light")
	slot4.config = slot2
end

function slot0._updateProgress(slot0)
	for slot4, slot5 in ipairs(slot0._progressItemList) do
		slot6 = InvestigateOpinionModel.instance:getLinkedStatus(slot5.config.id)

		gohelper.setActive(slot5.unfinished, not slot6)
		gohelper.setActive(slot5.finished, slot6)

		if not slot0._isInExtendView then
			slot0._progressStatus[slot4] = slot6

			if slot0._progressStatus[slot4] == false and slot6 then
				gohelper.setActive(slot5.light, true)
			end
		end
	end
end

function slot0._checkFinish(slot0)
	slot1 = true

	for slot5, slot6 in ipairs(slot0._opinionList) do
		if InvestigateOpinionModel.instance:getLinkedStatus(slot6.id) == false then
			slot1 = false

			break
		end
	end

	gohelper.setActive(slot0._goFinishedTip, slot1)
	gohelper.setActive(slot0._goUnFinishedTip, not slot1)
end

function slot0._initOpinionDescList(slot0, slot1)
	for slot6, slot7 in ipairs(slot0._descItemList) do
		gohelper.setActive(slot7, slot6 <= #slot1)
	end

	for slot6, slot7 in ipairs(slot1) do
		slot8 = slot0._descItemList[slot6] or gohelper.cloneInPlace(slot0._txtdec.gameObject)
		slot0._descItemList[slot6] = slot8

		gohelper.setActive(slot8, true)

		slot10 = gohelper.findChildTextMesh(slot8, "")
		slot10.text = slot7.relatedDesc
		slot12 = slot10.color
		slot12.a = InvestigateOpinionModel.instance:getLinkedStatus(slot7.id) and 1 or 0
		slot10.color = slot12

		gohelper.setActive(gohelper.findChild(slot8, "line"), slot9)

		if not slot0._isInExtendView and SLFramework.AnimatorPlayer.Get(slot8) and slot7.id == slot0._linkedClueId then
			slot13:Play("open", slot0._openAnimDone, slot0)

			if slot2 > 2 then
				slot0._scrolldesc.verticalNormalizedPosition = slot6 > 2 and 0 or 1
			end

			AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Investigate.play_ui_molu_jlbn_level_unlock)
		end
	end
end

function slot0._openAnimDone(slot0)
end

function slot0.onClose(slot0)
	slot0._rootAnimator:Play("close", 0, 0)
end

function slot0.onDestroyView(slot0)
end

return slot0
