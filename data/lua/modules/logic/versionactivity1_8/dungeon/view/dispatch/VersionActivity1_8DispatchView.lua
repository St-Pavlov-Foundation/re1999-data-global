module("modules.logic.versionactivity1_8.dungeon.view.dispatch.VersionActivity1_8DispatchView", package.seeall)

slot0 = class("VersionActivity1_8DispatchView", BaseView)
slot1 = 4
slot2 = "#3d5a4a"
slot3 = "#287B4D"

function slot0.onInitView(slot0)
	slot0._goback = gohelper.findChild(slot0.viewGO, "#go_back")
	slot0.backClick = gohelper.getClick(slot0._goback)
	slot0._gomapcontainer = gohelper.findChild(slot0.viewGO, "container/left/#go_mapcontainer")
	slot0._simagemap = gohelper.findChildSingleImage(slot0.viewGO, "container/left/#go_mapcontainer/#simage_map")
	slot0._goherocontainer = gohelper.findChild(slot0.viewGO, "container/left/#go_herocontainer")
	slot0._goclosehero = gohelper.findChild(slot0.viewGO, "container/left/#go_herocontainer/header/#go_closehero")
	slot0.heroCloseClick = gohelper.getClickWithAudio(slot0._goclosehero, AudioEnum.UI.play_ui_rolesopen)
	slot0._goclose = gohelper.findChild(slot0.viewGO, "container/right/#go_close")
	slot0.closeClick = gohelper.getClickWithAudio(slot0._goclose, AudioEnum.UI.play_ui_rolesopen)
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "container/right/Scroll View/Viewport/Content/#txt_desc")
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "container/right/#txt_title")
	slot0._txtcosttime = gohelper.findChildText(slot0.viewGO, "container/right/#txt_costtime")
	slot0._gotimelock = gohelper.findChild(slot0.viewGO, "container/right/#txt_costtime/locked")
	slot0._btninterruptdispatch = gohelper.findChildButtonWithAudio(slot0.viewGO, "container/right/#btn_interruptdispatch")
	slot0._btnstartdispatch = gohelper.findChildButtonWithAudio(slot0.viewGO, "container/right/#btn_startdispatch")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0.backClick:AddClickListener(slot0.closeThis, slot0)
	slot0.closeClick:AddClickListener(slot0.closeThis, slot0)
	slot0.heroCloseClick:AddClickListener(slot0.onClickHeroClose, slot0)
	slot0._btnstartdispatch:AddClickListener(slot0._btnstartdispatchOnClick, slot0)
	slot0._btninterruptdispatch:AddClickListener(slot0._btninterruptdispatchOnClick, slot0)
	slot0:addEventCb(DispatchController.instance, DispatchEvent.ChangeDispatchHeroContainerEvent, slot0.changeHeroContainerVisible, slot0)
	slot0:addEventCb(DispatchController.instance, DispatchEvent.AddDispatchInfo, slot0.onAddDispatchInfo, slot0)
	slot0:addEventCb(DispatchController.instance, DispatchEvent.RemoveDispatchInfo, slot0.onRemoveDispatchInfo, slot0)
	slot0:addEventCb(DispatchController.instance, DispatchEvent.OnDispatchFinish, slot0.onDispatchFinish, slot0)
	slot0:addEventCb(DispatchController.instance, DispatchEvent.ChangeSelectedHero, slot0.onSelectHeroMoChange, slot0)
end

function slot0.removeEvents(slot0)
	slot0.backClick:RemoveClickListener()
	slot0.closeClick:RemoveClickListener()
	slot0.heroCloseClick:RemoveClickListener()
	slot0._btnstartdispatch:RemoveClickListener()
	slot0._btninterruptdispatch:RemoveClickListener()
	slot0:removeEventCb(DispatchController.instance, DispatchEvent.ChangeDispatchHeroContainerEvent, slot0.changeHeroContainerVisible, slot0)
	slot0:removeEventCb(DispatchController.instance, DispatchEvent.AddDispatchInfo, slot0.onAddDispatchInfo, slot0)
	slot0:removeEventCb(DispatchController.instance, DispatchEvent.RemoveDispatchInfo, slot0.onRemoveDispatchInfo, slot0)
	slot0:removeEventCb(DispatchController.instance, DispatchEvent.OnDispatchFinish, slot0.onDispatchFinish, slot0)
	slot0:removeEventCb(DispatchController.instance, DispatchEvent.ChangeSelectedHero, slot0.onSelectHeroMoChange, slot0)
end

function slot0.onClickHeroClose(slot0)
	DispatchController.instance:dispatchEvent(DispatchEvent.ChangeDispatchHeroContainerEvent, false)
end

function slot0._btnstartdispatchOnClick(slot0)
	if slot0.status ~= DispatchEnum.DispatchStatus.NotDispatch then
		return
	end

	slot1 = false

	if slot0.dispatchCo then
		slot1 = slot0.dispatchCo.minCount <= DispatchHeroListModel.instance:getSelectedHeroCount()
	end

	if not slot1 then
		GameFacade.showToast(ToastEnum.V1a5_DungeonDispatchLessMinHero)

		return
	end

	DispatchRpc.instance:sendDispatchRequest(slot0.elementId, slot0.dispatchId, DispatchHeroListModel.instance:getSelectedHeroIdList(), slot0.onDispatchSuccess, slot0)
end

function slot0.onDispatchSuccess(slot0, slot1, slot2, slot3)
	if slot2 ~= 0 then
		return
	end

	GameFacade.showToast(ToastEnum.V1a5_DungeonDispatchSuccess)
	slot0:updateAct157Info()
end

function slot0._btninterruptdispatchOnClick(slot0)
	if slot0.status ~= DispatchEnum.DispatchStatus.Dispatching then
		return
	end

	if slot0.dispatchMo and slot0.dispatchMo:isFinish() then
		return
	end

	DispatchRpc.instance:sendInterruptDispatchRequest(slot0.elementId, slot0.dispatchId, slot0.updateAct157Info, slot0)
end

function slot0.updateAct157Info(slot0)
	Activity157Controller.instance:getAct157ActInfo()
end

function slot0.onAddDispatchInfo(slot0, slot1)
	if slot1 ~= slot0.dispatchId then
		return
	end

	slot0:changeHeroContainerVisible(false)
	slot0:onDispatchInfoChange()
end

function slot0.onRemoveDispatchInfo(slot0, slot1)
	if slot1 ~= slot0.dispatchId then
		return
	end

	DispatchHeroListModel.instance:resetSelectHeroList()
	slot0:onDispatchInfoChange()
end

function slot0.onDispatchInfoChange(slot0)
	slot0:changeDispatchStatus()

	if slot0.status == DispatchEnum.DispatchStatus.Finished then
		slot0:closeThis()

		return
	end

	slot0:refreshHeroContainer()
	slot0:refreshSelectedHero()
	slot0:refreshCostTime()
	slot0:refreshBtn()
end

function slot0.onDispatchFinish(slot0)
	slot0:refreshHeroContainer()
end

function slot0.onSelectHeroMoChange(slot0)
	slot0:refreshStartBtnGray()
	slot0:refreshCostTime()
end

function slot0._editableInitView(slot0)
	slot0.checkShortedTimeFuncDict = {
		[DispatchEnum.DispatchShortedType.Career] = slot0.checkCareer,
		[DispatchEnum.DispatchShortedType.HeroId] = slot0.checkHeroID
	}

	slot0:changeHeroContainerVisible(false)
	TaskDispatcher.runRepeat(slot0.everySecondCall, slot0, 1)
end

function slot0.changeHeroContainerVisible(slot0, slot1)
	if slot0.preIsShow == slot1 then
		return
	end

	slot0.preIsShow = slot1

	if slot0.preIsShow then
		AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_unlock)
	end

	gohelper.setActive(slot0._goherocontainer, slot1)
	gohelper.setActive(slot0._gomapcontainer, not slot1)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.elementId = slot0.viewParam.elementId
	slot0.dispatchId = slot0.viewParam.dispatchId
	slot0.dispatchCo = DungeonConfig.instance:getDispatchCfg(slot0.dispatchId)

	slot0:changeDispatchStatus()

	if slot0.status == DispatchEnum.DispatchStatus.Finished then
		slot0:closeThis()

		return
	end

	DispatchHeroListModel.instance:onOpenDispatchView(slot0.dispatchCo, slot0.elementId)
	slot0:initSelectedHeroItem()
	slot0:refreshUI()
end

function slot0.changeDispatchStatus(slot0)
	slot0.status = DispatchModel.instance:getDispatchStatus(slot0.elementId, slot0.dispatchId)
	slot0.dispatchMo = DispatchModel.instance:getDispatchMo(slot0.elementId, slot0.dispatchId)

	DispatchHeroListModel.instance:setDispatchViewStatus(slot0.status)
end

function slot0.initSelectedHeroItem(slot0)
	slot0.selectedHeroItemList = {}

	for slot5 = 1, uv0 do
		if slot5 <= (slot0.dispatchCo and slot0.dispatchCo.maxCount or 0) then
			table.insert(slot0.selectedHeroItemList, MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.findChild(slot0.viewGO, "container/right/selectedherocontainer/herocontainer/go_selectheroitem" .. slot5), VersionActivity1_8DispatchSelectHeroItem, slot5))
		else
			gohelper.setActive(slot6, false)
		end
	end
end

function slot0.refreshUI(slot0)
	if slot0.dispatchCo then
		slot0._simagemap:LoadImage(ResUrl.getV1a8DungeonSingleBg(string.format("paiqian/v1a8_dungeon_img_map%s", slot0.dispatchCo.image)))
	end

	slot0:refreshHeroContainer()

	slot0._txttitle.text = slot0.dispatchCo and slot0.dispatchCo.title or ""
	slot0._txtdesc.text = slot0.dispatchCo and slot0.dispatchCo.desc or ""

	slot0:refreshSelectedHero()
	slot0:refreshCostTime()
	slot0:refreshBtn()
end

function slot0.refreshHeroContainer(slot0)
	DispatchHeroListModel.instance:refreshHero()
end

function slot0.refreshSelectedHero(slot0)
	for slot4, slot5 in ipairs(slot0.selectedHeroItemList) do
		slot5:refreshUI()
	end
end

function slot0.refreshCostTime(slot0)
	if slot0.status == DispatchEnum.DispatchStatus.Finished then
		logError("dispatch finished")

		return
	end

	if slot0.status == DispatchEnum.DispatchStatus.Dispatching then
		if slot0.dispatchMo and slot0.dispatchMo:isFinish() then
			slot0:closeThis()

			return
		end

		gohelper.setActive(slot0._gotimelock, false)

		slot0._txtcosttime.text = slot0.dispatchMo:getRemainTimeStr()

		return
	end

	slot1 = uv0
	slot2 = ""

	if slot0.dispatchCo then
		if slot0.checkShortedTimeFuncDict[slot0.dispatchCo.shortType] and slot5(slot0) then
			slot1 = uv1
			slot4 = string.splitToNumber(slot0.dispatchCo.time, "|")[1] - slot3[2]

			gohelper.setActive(slot0._gotimelock, false)
		else
			gohelper.setActive(slot0._gotimelock, true)
		end

		slot7 = slot4 % TimeUtil.OneHourSecond
		slot2 = GameUtil.getSubPlaceholderLuaLang(luaLang("dispatch_total_cost_time"), {
			Mathf.Floor(slot4 / TimeUtil.OneHourSecond),
			Mathf.Floor(slot7 / TimeUtil.OneMinuteSecond),
			slot7 % TimeUtil.OneMinuteSecond
		})
	else
		gohelper.setActive(slot0._gotimelock, true)
	end

	slot0._txtcosttime.text = string.format("<color=%s>%s</color>", slot1, slot2)
end

function slot0.checkCareer(slot0)
	if not DispatchHeroListModel.instance:getSelectedHeroList() or #slot1 == 0 then
		return false
	end

	slot2 = string.splitToNumber(slot0.dispatchCo.extraParam, "|")
	slot3 = slot2[1]

	for slot9, slot10 in ipairs(slot1) do
		if slot10.config.career == slot2[2] then
			slot5 = 0 + 1
		end
	end

	return slot3 <= slot5
end

function slot0.checkHeroID(slot0)
	if not DispatchHeroListModel.instance:getSelectedHeroList() then
		return false
	end

	slot2 = string.split(slot0.dispatchCo.extraParam, "|")
	slot3 = tonumber(slot2[1])

	for slot9, slot10 in ipairs(slot1) do
		if tabletool.indexOf(string.splitToNumber(slot2[2], "#"), slot10.heroId) then
			slot5 = 0 + 1
		end
	end

	return slot3 <= slot5
end

function slot0.refreshBtn(slot0)
	gohelper.setActive(slot0._btnstartdispatch.gameObject, slot0.status == DispatchEnum.DispatchStatus.NotDispatch)
	gohelper.setActive(slot0._btninterruptdispatch.gameObject, slot0.status == DispatchEnum.DispatchStatus.Dispatching)
	slot0:refreshStartBtnGray()
end

function slot0.refreshStartBtnGray(slot0)
	if slot0.status ~= DispatchEnum.DispatchStatus.NotDispatch then
		return
	end

	slot1 = false

	if slot0.dispatchCo then
		slot1 = slot0.dispatchCo.minCount <= DispatchHeroListModel.instance:getSelectedHeroCount()
	end

	ZProj.UGUIHelper.SetGrayscale(slot0._btnstartdispatch.gameObject, not slot1)
end

function slot0.everySecondCall(slot0)
	if slot0.status == DispatchEnum.DispatchStatus.Dispatching then
		slot0:refreshCostTime()
	end
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.everySecondCall, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagemap:UnLoadImage()

	if slot0.selectedHeroItemList then
		for slot4, slot5 in ipairs(slot0.selectedHeroItemList) do
			slot5:destroy()
		end

		slot0.selectedHeroItemList = nil
	end

	DispatchHeroListModel.instance:clear()
end

return slot0
