module("modules.logic.versionactivity1_5.dungeon.view.dispatch.VersionActivity1_5DispatchView", package.seeall)

slot0 = class("VersionActivity1_5DispatchView", BaseView)

function slot0.onInitView(slot0)
	slot0._goback = gohelper.findChild(slot0.viewGO, "#go_back")
	slot0._gomapcontainer = gohelper.findChild(slot0.viewGO, "container/left/#go_mapcontainer")
	slot0._simagemap = gohelper.findChildSingleImage(slot0.viewGO, "container/left/#go_mapcontainer/#simage_map")
	slot0._goherocontainer = gohelper.findChild(slot0.viewGO, "container/left/#go_herocontainer")
	slot0._goclosehero = gohelper.findChild(slot0.viewGO, "container/left/#go_herocontainer/header/#go_closehero")
	slot0._goclose = gohelper.findChild(slot0.viewGO, "container/right/#go_close")
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "container/right/#txt_title")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "container/right/Scroll View/Viewport/Content/#txt_desc")
	slot0._txtcosttime = gohelper.findChildText(slot0.viewGO, "container/right/#txt_costtime")
	slot0._gotimelock = gohelper.findChild(slot0.viewGO, "container/right/#txt_costtime/locked")
	slot0._btnstartdispatch = gohelper.findChildButtonWithAudio(slot0.viewGO, "container/right/#btn_startdispatch")
	slot0._btninterruptdispatch = gohelper.findChildButtonWithAudio(slot0.viewGO, "container/right/#btn_interruptdispatch")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnstartdispatch:AddClickListener(slot0._btnstartdispatchOnClick, slot0)
	slot0._btninterruptdispatch:AddClickListener(slot0._btninterruptdispatchOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnstartdispatch:RemoveClickListener()
	slot0._btninterruptdispatch:RemoveClickListener()
end

slot0.DarkColor = "#3d5a4a"
slot0.LightColor = "#287B4D"

function slot0._btnstartdispatchOnClick(slot0)
	if slot0.status ~= VersionActivity1_5DungeonEnum.DispatchStatus.NotDispatch then
		return
	end

	if VersionActivity1_5HeroListModel.instance:getSelectedHeroCount() < slot0.dispatchCo.minCount then
		GameFacade.showToast(ToastEnum.V1a5_DungeonDispatchLessMinHero)

		return
	end

	VersionActivity1_5DungeonRpc.instance:sendAct139DispatchRequest(slot0.dispatchId, VersionActivity1_5HeroListModel.instance:getSelectedHeroIdList(), slot0.onDispatchSuccess, slot0)
end

function slot0.onDispatchSuccess(slot0)
	GameFacade.showToast(ToastEnum.V1a5_DungeonDispatchSuccess)
end

function slot0._btninterruptdispatchOnClick(slot0)
	if slot0.status ~= VersionActivity1_5DungeonEnum.DispatchStatus.Dispatching then
		return
	end

	if slot0.dispatchMo:isFinish() then
		return
	end

	VersionActivity1_5DungeonRpc.instance:sendAct139InterruptDispatchRequest(slot0.dispatchId)
end

function slot0.onClickHeroClose(slot0)
	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.ChangeDispatchHeroContainerEvent, false)
end

function slot0._editableInitView(slot0)
	slot0.backClick = gohelper.getClick(slot0._goback)

	slot0.backClick:AddClickListener(slot0.closeThis, slot0)

	slot0.closeClick = gohelper.getClick(slot0._goclose)

	slot0.closeClick:AddClickListener(slot0.closeThis, slot0)

	slot0.heroCloseClick = gohelper.getClick(slot0._goclosehero)

	slot0.heroCloseClick:AddClickListener(slot0.onClickHeroClose, slot0)

	slot0.simagebg = gohelper.findChildSingleImage(slot0.viewGO, "container/bg02")

	slot0.simagebg:LoadImage(ResUrl.getV1a5DungeonSingleBg("paiqian/v1a5_dungeon_bg_paiqian02"))
	slot0:changeHeroContainerVisible(false)

	slot0.checkShortedTimeFuncDict = {
		[VersionActivity1_5DungeonEnum.DispatchShortedType.Career] = slot0.checkCareer,
		[VersionActivity1_5DungeonEnum.DispatchShortedType.HeroId] = slot0.checkHeroID
	}

	slot0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.ChangeDispatchHeroContainerEvent, slot0.changeHeroContainerVisible, slot0)
	slot0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.AddDispatchInfo, slot0.onAddDispatchInfo, slot0)
	slot0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.RemoveDispatchInfo, slot0.onRemoveDispatchInfo, slot0)
	slot0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnDispatchFinish, slot0.onDispatchFinish, slot0)
	slot0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.ChangeSelectedHero, slot0.onSelectHeroMoChange, slot0)
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

function slot0.onDispatchFinish(slot0)
	slot0:refreshHeroContainer()
end

function slot0.onRemoveDispatchInfo(slot0, slot1)
	if slot1 ~= slot0.dispatchId then
		return
	end

	VersionActivity1_5HeroListModel.instance:resetSelectHeroList()
	slot0:onDispatchInfoChange()
end

function slot0.onAddDispatchInfo(slot0, slot1)
	if slot1 ~= slot0.dispatchId then
		return
	end

	slot0:changeHeroContainerVisible(false)
	slot0:onDispatchInfoChange()
end

function slot0.onDispatchInfoChange(slot0)
	slot0:changeDispatchStatus()

	if slot0.status == VersionActivity1_5DungeonEnum.DispatchStatus.Finished then
		slot0:closeThis()

		return
	end

	slot0:refreshHeroContainer()
	slot0:refreshSelectedHero()
	slot0:refreshCostTime()
	slot0:refreshBtn()
end

function slot0.onSelectHeroMoChange(slot0)
	slot0:refreshStartBtnGray()
	slot0:refreshCostTime()
end

function slot0.onOpen(slot0)
	slot0.dispatchId = slot0.viewParam.dispatchId
	slot0.dispatchCo = VersionActivity1_5DungeonConfig.instance:getDispatchCo(slot0.dispatchId)

	slot0:changeDispatchStatus()

	if slot0.status == VersionActivity1_5DungeonEnum.DispatchStatus.Finished then
		slot0:closeThis()

		return
	end

	VersionActivity1_5HeroListModel.instance:onOpenDispatchView(slot0.dispatchCo)
	slot0:initSelectedHeroItem()
	slot0:refreshUI()
end

function slot0.initSelectedHeroItem(slot0)
	slot0.selectedHeroItemList = {}

	for slot4 = 1, 4 do
		if slot4 <= slot0.dispatchCo.maxCount then
			table.insert(slot0.selectedHeroItemList, VersionActivity1_5DispatchSelectHeroItem.createItem(gohelper.findChild(slot0.viewGO, "container/right/selectedherocontainer/herocontainer/go_selectheroitem" .. slot4), slot4))
		else
			gohelper.setActive(slot5, false)
		end
	end
end

function slot0.refreshUI(slot0)
	slot0:refreshLeft()
	slot0:refreshRight()
end

function slot0.refreshLeft(slot0)
	slot0:refreshMap()
	slot0:refreshHeroContainer()
end

function slot0.refreshRight(slot0)
	slot0._txttitle.text = slot0.dispatchCo.title
	slot0._txtdesc.text = slot0.dispatchCo.desc

	slot0:refreshSelectedHero()
	slot0:refreshCostTime()
	slot0:refreshBtn()
end

function slot0.refreshMap(slot0)
	slot0._simagemap:LoadImage(ResUrl.getV1a5DungeonSingleBg("paiqian/v1a5_dungeon_img_chahua_" .. slot0.dispatchCo.image))
end

function slot0.refreshHeroContainer(slot0)
	VersionActivity1_5HeroListModel.instance:refreshHero()
end

function slot0.refreshSelectedHero(slot0)
	for slot4, slot5 in ipairs(slot0.selectedHeroItemList) do
		slot5:refreshUI()
	end
end

function slot0.refreshCostTime(slot0)
	if slot0.status == VersionActivity1_5DungeonEnum.DispatchStatus.Finished then
		logError("dispatch finished")

		return
	end

	if slot0.status == VersionActivity1_5DungeonEnum.DispatchStatus.Dispatching then
		if slot0.dispatchMo:isFinish() then
			slot0:closeThis()

			return
		end

		gohelper.setActive(slot0._gotimelock, false)

		slot0._txtcosttime.text = slot0.dispatchMo:getRemainTimeStr()

		return
	end

	slot3 = uv0.DarkColor

	if slot0.checkShortedTimeFuncDict[slot0.dispatchCo.shortType] and slot4(slot0) then
		slot2 = string.splitToNumber(slot0.dispatchCo.time, "|")[1] - slot1[2]
		slot3 = uv0.LightColor

		gohelper.setActive(slot0._gotimelock, false)
	else
		gohelper.setActive(slot0._gotimelock, true)
	end

	slot5 = Mathf.Floor(slot2 / TimeUtil.OneHourSecond)
	slot6 = slot2 % TimeUtil.OneHourSecond
	slot7 = Mathf.Floor(slot6 / TimeUtil.OneMinuteSecond)
	slot8 = slot6 % TimeUtil.OneMinuteSecond
	slot9 = nil
	slot0._txtcosttime.text = string.format("<color=%s>%s</color>", slot3, (not LangSettings.instance:isEn() or string.format("%s%s%s %s%s %s%s", luaLang("dispatch_cost_time"), slot5, luaLang("time_hour"), slot7, luaLang("time_minute"), slot8, luaLang("time_second"))) and string.format("%s%s%s%s%s%s%s", luaLang("dispatch_cost_time"), slot5, luaLang("time_hour"), slot7, luaLang("time_minute"), slot8, luaLang("time_second")))
end

function slot0.checkCareer(slot0)
	if not VersionActivity1_5HeroListModel.instance:getSelectedHeroList() or #slot1 == 0 then
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
	if not VersionActivity1_5HeroListModel.instance:getSelectedHeroList() then
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
	gohelper.setActive(slot0._btnstartdispatch.gameObject, slot0.status == VersionActivity1_5DungeonEnum.DispatchStatus.NotDispatch)
	gohelper.setActive(slot0._btninterruptdispatch.gameObject, slot0.status == VersionActivity1_5DungeonEnum.DispatchStatus.Dispatching)
	slot0:refreshStartBtnGray()
end

function slot0.refreshStartBtnGray(slot0)
	if slot0.status == VersionActivity1_5DungeonEnum.DispatchStatus.NotDispatch then
		ZProj.UGUIHelper.SetGrayscale(slot0._btnstartdispatch.gameObject, VersionActivity1_5HeroListModel.instance:getSelectedHeroCount() < slot0.dispatchCo.minCount)
	end
end

function slot0.changeDispatchStatus(slot0)
	slot0.status = VersionActivity1_5DungeonModel.instance:getDispatchStatus(slot0.dispatchId)
	slot0.dispatchMo = VersionActivity1_5DungeonModel.instance:getDispatchMo(slot0.dispatchId)

	VersionActivity1_5HeroListModel.instance:setDispatchViewStatus(slot0.status)
end

function slot0.everySecondCall(slot0)
	if slot0.status == VersionActivity1_5DungeonEnum.DispatchStatus.Dispatching then
		slot0:refreshCostTime()
	end
end

function slot0.onClose(slot0)
	slot0:removeEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.ChangeDispatchHeroContainerEvent, slot0.changeHeroContainerVisible, slot0)
	slot0:removeEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.AddDispatchInfo, slot0.onAddDispatchInfo, slot0)
	slot0:removeEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.RemoveDispatchInfo, slot0.onRemoveDispatchInfo, slot0)
	slot0:removeEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnDispatchFinish, slot0.onDispatchFinish, slot0)
	slot0:removeEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.ChangeSelectedHero, slot0.onSelectHeroMoChange, slot0)
	VersionActivity1_5HeroListModel.instance:onCloseDispatchView()
	TaskDispatcher.cancelTask(slot0.everySecondCall, slot0)
end

function slot0.onDestroyView(slot0)
	slot0.backClick:RemoveClickListener()
	slot0.closeClick:RemoveClickListener()
	slot0.heroCloseClick:RemoveClickListener()
	slot0.simagebg:UnLoadImage()
	slot0._simagemap:UnLoadImage()

	for slot4, slot5 in ipairs(slot0.selectedHeroItemList) do
		slot5:destroy()
	end

	slot0.selectedHeroItemList = nil
end

return slot0
