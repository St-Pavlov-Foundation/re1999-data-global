module("modules.logic.versionactivity1_4.dungeon.view.VersionActivity1_4DungeonView", package.seeall)

slot0 = class("VersionActivity1_4DungeonView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._goroot = gohelper.findChild(slot0.viewGO, "root")
	slot0._gopath = gohelper.findChild(slot0.viewGO, "root/#go_path")
	slot0._gostages = gohelper.findChild(slot0.viewGO, "root/#go_path/#go_stages")
	slot0._gotitle = gohelper.findChild(slot0.viewGO, "root/#go_title")
	slot0._simagetitle = gohelper.findChildSingleImage(slot0.viewGO, "root/#go_title/#simage_title")
	slot0._gotime = gohelper.findChild(slot0.viewGO, "root/#go_title/#go_time")
	slot0._txtlimittime = gohelper.findChildText(slot0.viewGO, "root/#go_title/#go_time/#txt_limittime")
	slot0._btntask = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_task")
	slot0._txttasknum = gohelper.findChildTextMesh(slot0.viewGO, "root/#btn_task/#txt_TaskNum")
	slot0._goreddotreward = gohelper.findChild(slot0.viewGO, "root/#btn_task/#go_reddotreward")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")
	slot0._stageItemList = {}
	slot0._animPath = gohelper.findChildComponent(slot0.viewGO, "root/#go_path", typeof(UnityEngine.Animator))

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btntask:AddClickListener(slot0._btntaskOnClick, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0._onCurrencyChange, slot0)
	slot0:addEventCb(VersionActivity1_4DungeonController.instance, VersionActivity1_4DungeonEvent.OnSelectEpisodeId, slot0.onSelect, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btntask:RemoveClickListener()
	slot0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0._onCurrencyChange, slot0)
	slot0:removeEventCb(VersionActivity1_4DungeonController.instance, VersionActivity1_4DungeonEvent.OnSelectEpisodeId, slot0.onSelect, slot0)
end

function slot0._btntaskOnClick(slot0)
	ViewMgr.instance:openView(ViewName.Activity129View, {
		actId = VersionActivity1_4Enum.ActivityId.DungeonStore
	})
end

function slot0._editableInitView(slot0)
	slot0._simagebg:LoadImage("singlebg/v1a4_role37_singlebg/v1a4_dungeon_fullbg.png")
end

function slot0.onSelect(slot0)
	if VersionActivity1_4DungeonModel.instance:getSelectEpisodeId() then
		gohelper.setActive(slot0._goroot, false)
		gohelper.setActive(slot0._gobtns, false)
	else
		gohelper.setActive(slot0._goroot, true)
		gohelper.setActive(slot0._gobtns, true)
		slot0:refreshStages()
	end
end

function slot0.onUpdateParam(slot0)
	ViewMgr.instance:closeView(ViewName.VersionActivity1_4DungeonEpisodeView)
end

function slot0._onCurrencyChange(slot0, slot1)
	if not slot1[Activity129Config.instance:getConstValue1(VersionActivity1_4Enum.ActivityId.DungeonStore, Activity129Enum.ConstEnum.CostId)] then
		return
	end

	slot0._txttasknum.text = tostring(ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Currency, slot2))
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_qiutu_revelation_open)

	slot0.actId = slot0.viewParam.actId

	ActivityEnterMgr.instance:enterActivity(slot0.actId)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		slot0.actId
	})
	slot0:refreshStages()
	TaskDispatcher.runRepeat(slot0._showLeftTime, slot0, 60)
	slot0:_showLeftTime()

	slot0._txttasknum.text = tostring(ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Currency, Activity129Config.instance:getConstValue1(VersionActivity1_4Enum.ActivityId.DungeonStore, Activity129Enum.ConstEnum.CostId)))
end

function slot0.refreshStages(slot0)
	slot2, slot3 = nil
	slot8 = #DungeonConfig.instance:getChapterEpisodeCOList(14101)

	for slot8 = 1, math.max(#slot0._stageItemList, slot8) do
		if not slot0._stageItemList[slot8] then
			slot0._stageItemList[slot8] = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], gohelper.findChild(slot0._gostages, "stage" .. slot8)), VersionActivity1_4DungeonItem, slot0, slot8)
		end

		slot10, slot11 = slot9:refreshItem(slot4[slot8], slot8)

		if slot11 then
			slot3 = slot8
		end

		if slot10 then
			slot2 = slot8
		end
	end

	TaskDispatcher.cancelTask(slot0.playAnim, slot0)

	if slot2 then
		slot0.animName = "go_0" .. tostring(slot2 - 1)

		TaskDispatcher.runDelay(slot0.playAnim, slot0, 1)
	else
		slot0.animName = "idle_0" .. tostring((slot3 or 1) - 1)

		slot0:playAnim()
	end
end

function slot0.playAnim(slot0)
	slot0._animPath:Play(slot0.animName)
end

function slot0._showLeftTime(slot0)
	if not ActivityModel.instance:getActMO(slot0.actId) then
		return
	end

	slot0._txtlimittime.text = string.format(luaLang("activity_warmup_remain_time"), slot1:getRemainTimeStr2ByEndTime())
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._showLeftTime, slot0)
	TaskDispatcher.cancelTask(slot0.playAnim, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
end

return slot0
