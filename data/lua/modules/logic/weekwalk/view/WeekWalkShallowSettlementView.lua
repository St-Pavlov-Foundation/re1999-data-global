module("modules.logic.weekwalk.view.WeekWalkShallowSettlementView", package.seeall)

slot0 = class("WeekWalkShallowSettlementView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg1 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg1")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._simagemask = gohelper.findChildSingleImage(slot0.viewGO, "#simage_mask")
	slot0._simagebg2 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg2")
	slot0._txtlayer = gohelper.findChildText(slot0.viewGO, "overview/#txt_layer")
	slot0._txtstarcount = gohelper.findChildText(slot0.viewGO, "overview/#txt_starcount")
	slot0._scrollrewards = gohelper.findChildScrollRect(slot0.viewGO, "rewards/#scroll_rewards")
	slot0._gorewarditem = gohelper.findChild(slot0.viewGO, "rewards/#scroll_rewards/Viewport/Content/#go_rewarditem")
	slot0._btnreceive = gohelper.findChildButtonWithAudio(slot0.viewGO, "rewards/#btn_receive")
	slot0._goempty = gohelper.findChild(slot0.viewGO, "rewards/#go_empty")
	slot0._gohasreceived = gohelper.findChild(slot0.viewGO, "rewards/#go_hasreceived")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnreceive:AddClickListener(slot0._btnreceiveOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btnreceive:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnreceiveOnClick(slot0)
	TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.WeekWalk, 2)
end

function slot0._editableInitView(slot0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	slot0._simagebg1:LoadImage(ResUrl.getWeekWalkBg("full/beijing_qian.jpg"))
	slot0._simagebg2:LoadImage(ResUrl.getWeekWalkBg("qianmian_tcdi.png"))
	slot0._simagemask:LoadImage(ResUrl.getWeekWalkBg("zhezhao.png"))

	slot0._info = WeekWalkModel.instance:getInfo()

	if slot0._info.isPopShallowSettle then
		slot0._info.isPopShallowSettle = false

		WeekwalkRpc.instance:sendMarkPopShallowSettleRequest()
	end

	slot0:_setLayerProgress()
	slot0:_setProgress()
end

function slot0._createItemList(slot0, slot1)
	if not slot0._itemList then
		slot0._itemList = slot0:getUserDataTb_()

		for slot5, slot6 in ipairs(slot1) do
			slot7 = gohelper.cloneInPlace(slot0._gorewarditem)

			gohelper.setActive(slot7, true)

			slot8 = IconMgr.instance:getCommonItemIcon(gohelper.findChild(slot7, "go_item"))

			slot8:setMOValue(slot6[1], slot6[2], slot6[3])
			slot8:isShowCount(true)
			slot8:setCountFontSize(31)

			slot0._itemList[slot5] = slot7
		end
	end
end

function slot0._setProgress(slot0)
	slot1, slot2, slot3 = DungeonWeekWalkView.getWeekTaskProgress()
	slot0._txtstarcount.text = GameUtil.getSubPlaceholderLuaLang(luaLang("weekwalkshallowsettlementview_starcount"), {
		slot1,
		slot2
	})

	slot0:_createItemList(slot3)

	slot5 = #slot3 > 0

	gohelper.setActive(slot0._goempty, not slot5)

	slot6 = slot0:_isGetAllTask()

	gohelper.setActive(slot0._gohasreceived, slot5 and slot6)
	gohelper.setActive(slot0._btnreceive, slot5 and not slot6)

	for slot10, slot11 in ipairs(slot0._itemList) do
		gohelper.setActive(gohelper.findChild(slot11, "go_receive"), slot5 and slot6)
	end
end

function slot0._isGetAllTask(slot0)
	for slot5, slot6 in ipairs(WeekWalkTaskListModel.instance:getList()) do
		if WeekWalkTaskListModel.instance:getTaskMo(slot6.id) and slot7.finishCount <= 0 and slot7.hasFinished then
			return false
		end
	end

	return true
end

function slot0._setLayerProgress(slot0)
	slot1, slot2 = slot0:_getLastShallowLayer()
	slot0._txtlayer.text = GameUtil.getSubPlaceholderLuaLang(luaLang("weekwalkshallowsettlementview_layer"), {
		lua_weekwalk_scene.configDict[slot1.sceneId].name,
		"0" .. (slot2 and slot2:getNoStarBattleIndex() or 1)
	})
end

function slot0._getLastShallowLayer(slot0)
	slot1, slot2 = nil

	for slot6, slot7 in ipairs(lua_weekwalk.configList) do
		if WeekWalkModel.isShallowMap(slot7.id) then
			slot1 = slot7

			if not WeekWalkModel.instance:getMapInfo(slot7.id) or slot2.isFinished <= 0 then
				break
			end
		else
			break
		end
	end

	return slot1, slot2
end

function slot0._onWeekwalkTaskUpdate(slot0)
	slot0:_setProgress()
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_ui_artificial_settlement_open)
	slot0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnWeekwalkTaskUpdate, slot0._onWeekwalkTaskUpdate, slot0)
end

function slot0.onClose(slot0)
	AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_ui_artificial_settlement_close)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function slot0.onCloseFinish(slot0)
	if slot0._info.isPopDeepSettle then
		WeekWalkController.instance:checkOpenWeekWalkDeepLayerNoticeView()
	end
end

function slot0.onDestroyView(slot0)
	slot0._simagebg1:UnLoadImage()
	slot0._simagebg2:UnLoadImage()
	slot0._simagemask:UnLoadImage()
end

return slot0
