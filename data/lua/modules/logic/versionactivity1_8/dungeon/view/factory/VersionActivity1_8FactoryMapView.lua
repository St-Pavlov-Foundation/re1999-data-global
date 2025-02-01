module("modules.logic.versionactivity1_8.dungeon.view.factory.VersionActivity1_8FactoryMapView", package.seeall)

slot0 = class("VersionActivity1_8FactoryMapView", BaseView)
slot1 = 1
slot2 = 0.3
slot3 = 0.2

function slot0.onInitView(slot0)
	slot0._goline = gohelper.findChild(slot0.viewGO, "Line")
	slot0._gonodecontainer = gohelper.findChild(slot0.viewGO, "#go_nodecontainer")
	slot0._gonodeitem = gohelper.findChild(slot0.viewGO, "#go_nodecontainer/#go_nodeitem")
	slot0._btnfactory = gohelper.findChildClickWithDefaultAudio(slot0.viewGO, "#btn_factory")
	slot0._btnfactoryAnimator = gohelper.findChildComponent(slot0.viewGO, "#btn_factory", typeof(UnityEngine.Animator))
	slot0._goFactoryBlueprintReddot = gohelper.findChild(slot0.viewGO, "#btn_factory/#go_reddot")
	slot0._golockedfactory = gohelper.findChild(slot0.viewGO, "#btn_factory/#go_locked")
	slot0._imageprogress = gohelper.findChildImage(slot0.viewGO, "#btn_factory/#go_progroess/circle")
	slot0._gocangetbubble = gohelper.findChild(slot0.viewGO, "#btn_factory/#go_canget")
	slot0._btncanget = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_factory/#go_canget", AudioEnum.UI.Act157GetBubbleReward)
	slot0._simagecangeticon = gohelper.findChildSingleImage(slot0.viewGO, "#btn_factory/#go_canget/icon")
	slot0._gocangetfull = gohelper.findChild(slot0.viewGO, "#btn_factory/#go_canget/#go_full")
	slot0._gofinished = gohelper.findChild(slot0.viewGO, "#btn_factory/#go_canget/finished")
	slot0._gocharging = gohelper.findChild(slot0.viewGO, "#btn_factory/#go_canget/finishing")
	slot0._gochargetime = gohelper.findChild(slot0.viewGO, "#btn_factory/#go_canget/finishing/time")
	slot0._txtnextchargetime = gohelper.findChildText(slot0.viewGO, "#btn_factory/#go_canget/finishing/time/#txt_time")
	slot0._gocangetnum = gohelper.findChild(slot0.viewGO, "#btn_factory/#go_canget/finishing/num")
	slot0._txtcangetnum = gohelper.findChildText(slot0.viewGO, "#btn_factory/#go_canget/finishing/num/#txt_num")
	slot0._gounlocknum = gohelper.findChild(slot0.viewGO, "#btn_factory/#go_num")
	slot0._imageunlockicon = gohelper.findChildImage(slot0.viewGO, "#btn_factory/#go_num/icon")
	slot0._txtunlocknum = gohelper.findChildText(slot0.viewGO, "#btn_factory/#go_num/#txt_num")
	slot0._imagefactory = gohelper.findChildImage(slot0.viewGO, "#btn_factory/#image_factory")
	slot0._mapswitchanimator = gohelper.findChildComponent(slot0.viewGO, "#go_mapswitch", typeof(UnityEngine.Animator))
	slot0._goswitchunlock = gohelper.findChild(slot0.viewGO, "#go_mapswitch/#unlock")
	slot0._switchanimator = gohelper.findChildComponent(slot0.viewGO, "#go_mapswitch/switch", typeof(UnityEngine.Animator))
	slot0._txtmapname = gohelper.findChildText(slot0.viewGO, "#go_mapswitch/normal/#txt_mapname")
	slot0._txtsidemissionmapname = gohelper.findChildText(slot0.viewGO, "#go_mapswitch/locked/layout/#txt_timelocked")
	slot0._golockedsidemissionicon = gohelper.findChild(slot0.viewGO, "#go_mapswitch/locked/layout/icon")
	slot0._goswitch = gohelper.findChild(slot0.viewGO, "#go_mapswitch/switch")
	slot0._btnleft = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_mapswitch/switch/#btn_left")
	slot0._btnright = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_mapswitch/switch/#btn_right")
	slot0._gopointparent = gohelper.findChild(slot0.viewGO, "#go_mapswitch/switch/pointbg/pointcontainer")
	slot0._goswitchpoint = gohelper.findChild(slot0.viewGO, "#go_mapswitch/switch/pointbg/pointcontainer/empty")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0._onCurrencyChange, slot0)
	slot0:addEventCb(VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.FocusElement, slot0.closeThis, slot0)
	slot0:addEventCb(VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.ManualClickElement, slot0.closeThis, slot0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, slot0.dailyRefresh, slot0)
	slot0:addEventCb(Activity157Controller.instance, Activity157Event.Act157RepairComponent, slot0._onRepairComponent, slot0)
	slot0:addEventCb(Activity157Controller.instance, Activity157Event.Act157RefreshFactoryProduction, slot0.refreshFactoryCanGetBubble, slot0)
	slot0:addEventCb(Activity157Controller.instance, Activity157Event.Act157RefreshSideMission, slot0._onRefreshNode, slot0)
	slot0:addEventCb(Activity157Controller.instance, Activity157Event.Act157FinishMission, slot0._onRefreshNode, slot0)
	slot0._btnfactory:AddClickListener(slot0._btnfactoryOnClick, slot0)
	slot0._btncanget:AddClickListener(slot0._btncangetOnClick, slot0)
	slot0._btnleft:AddClickListener(slot0._btnleftOnClick, slot0)
	slot0._btnright:AddClickListener(slot0._btnrightOnCLick, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	slot0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0._onCurrencyChange, slot0)
	slot0:removeEventCb(VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.FocusElement, slot0.closeThis, slot0)
	slot0:removeEventCb(VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.ManualClickElement, slot0.closeThis, slot0)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, slot0.dailyRefresh, slot0)
	slot0:removeEventCb(Activity157Controller.instance, Activity157Event.Act157RepairComponent, slot0._onRepairComponent, slot0)
	slot0:removeEventCb(Activity157Controller.instance, Activity157Event.Act157RefreshFactoryProduction, slot0.refreshFactoryCanGetBubble, slot0)
	slot0:removeEventCb(Activity157Controller.instance, Activity157Event.Act157RefreshSideMission, slot0._onRefreshNode, slot0)
	slot0:removeEventCb(Activity157Controller.instance, Activity157Event.Act157FinishMission, slot0._onRefreshNode, slot0)
	slot0._btnfactory:RemoveClickListener()
	slot0._btncanget:RemoveClickListener()
	slot0._btnleft:RemoveClickListener()
	slot0._btnright:RemoveClickListener()
end

function slot0._onCloseView(slot0, slot1)
	if slot1 ~= ViewName.VersionActivity1_8FactoryBlueprintView then
		return
	end

	if slot0._waitRefreshUnlockAnim then
		for slot5, slot6 in pairs(slot0.missionId2NodeItemDict) do
			slot6:refreshUnlockAnim()
		end

		slot0:refreshIsShowSwitchPoint()

		slot0._waitRefreshUnlockAnim = nil
	end
end

function slot0._onCurrencyChange(slot0, slot1)
	if not slot1[CurrencyEnum.CurrencyType.V1a8FactoryPart] then
		return
	end

	slot0:refreshFactoryEntrance()
end

function slot0.dailyRefresh(slot0)
	Activity157Controller.instance:getAct157ActInfo()
end

function slot0._onRepairComponent(slot0)
	slot0:refreshFactoryEntrance()
	slot0:refreshFactoryCanGetBubble()

	if ViewMgr.instance:isOpen(ViewName.VersionActivity1_8FactoryBlueprintView) then
		slot0._waitRefreshUnlockAnim = true
	else
		for slot5, slot6 in pairs(slot0.missionId2NodeItemDict) do
			slot6:refreshUnlockAnim()
		end
	end
end

function slot0._onRefreshNode(slot0)
	slot0:refreshNode()
	slot0:refreshNodeLines()
end

function slot0._btnfactoryOnClick(slot0)
	Activity157Controller.instance:openFactoryBlueprintView()
end

function slot0._btncangetOnClick(slot0)
	Activity157Controller.instance:getFactoryProduction()
end

function slot0._btnleftOnClick(slot0)
	if not slot0.curIndex then
		return
	end

	slot0:switchMap(slot0.curIndex - 1)
end

function slot0._btnrightOnCLick(slot0)
	if not slot0.curIndex then
		return
	end

	slot0:switchMap(slot0.curIndex + 1)
end

function slot0.switchMap(slot0, slot1, slot2)
	if not slot1 then
		if slot2 then
			for slot7, slot8 in ipairs(slot0.switchPointItemList) do
				if slot8.missionGroupId == Activity157Model.instance:getInProgressMissionGroup() then
					slot1 = slot7

					break
				end
			end
		else
			slot1 = slot0.curIndex
		end
	end

	if (slot1 or uv0) > #slot0.switchPointItemList then
		slot1 = uv0
	elseif slot1 < uv0 then
		slot1 = slot3
	end

	if not (slot1 and slot0.switchPointItemList[slot1]) then
		return
	end

	slot5 = false
	slot6 = slot0.curIndex and slot0.switchPointItemList[slot0.curIndex]

	if slot6 and slot6.missionGroupId and Activity157Config.instance:isSideMissionGroup(slot0.actId, slot7) ~= Activity157Config.instance:isSideMissionGroup(slot0.actId, slot4.missionGroupId) then
		slot5 = true
	end

	if slot5 then
		slot0._mapswitchanimator:Play(slot9 and "switch_locked" or "switch_nomal", 0, 0)
	else
		slot0._mapswitchanimator:Play(slot9 and "locked" or "nomal", 0, 0)
	end

	slot0:recycleAllNodeItem()

	slot0.curIndex = slot1

	slot0:setNodeGroup(slot8, slot2)
	slot0:refreshSwitchPoint()
	slot0:refreshMapName()
end

function slot0._editableInitView(slot0)
	slot0.actId = Activity157Model.instance:getActId()
	slot0.nodeItemPool = {}
	slot0.missionId2NodeItemDict = {}
	slot0.curIndex = nil
	slot0.lineTemplateDict = slot0:getUserDataTb_()
	slot0.switchPointItemList = {}
	slot0._waitRefreshUnlockAnim = nil

	gohelper.setActive(slot0._gonodeitem, false)
	gohelper.setActive(slot0._goswitchpoint, false)

	slot0.mapAreaAnimatorDict = slot0:getUserDataTb_()

	for slot7 = 1, gohelper.findChild(slot0.viewGO, "Map").transform.childCount do
		slot8 = slot2:GetChild(slot7 - 1)
		slot9 = slot8:GetComponent(typeof(UnityEngine.Animator))

		slot9:Play("lock_idle", 0, 0)

		slot0.mapAreaAnimatorDict[tostring(slot8.name)] = slot9
	end

	if Activity157Config.instance:getAct157Const(slot0.actId, Activity157Enum.ConstId.FactoryCompositeCost) and string.splitToNumber(slot4, "#") then
		slot6, slot7 = ItemModel.instance:getItemConfigAndIcon(slot5[1], slot5[2])

		if slot7 then
			slot0._simagecangeticon:LoadImage(slot7)
		end
	end

	if Activity157Config.instance:getAct157Const(slot0.actId, Activity157Enum.ConstId.FactoryRepairPartItem) and string.splitToNumber(slot6, "#") and CurrencyConfig.instance:getCurrencyCo(slot7[2]) and slot8.icon then
		UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._imageunlockicon, slot9 .. "_1", true)
	end

	slot0.goLineTemplate = slot0.viewContainer:getResInst(slot0.viewContainer:getSetting().otherRes[1], slot0._goline)

	gohelper.setActive(slot0.goLineTemplate, false)
	RedDotController.instance:addRedDot(slot0._goFactoryBlueprintReddot, RedDotEnum.DotNode.V1a8DungeonFactoryBlueprint)
end

function slot0.onUpdateParam(slot0)
	Activity157Controller.instance:onFactoryMapViewOpen()
end

function slot0.onOpen(slot0)
	slot0:refresh(true)
	slot0:everySecondCall()
	TaskDispatcher.runRepeat(slot0.everySecondCall, slot0, 1)
	Activity157Controller.instance:onFactoryMapViewOpen()
end

function slot0.everySecondCall(slot0)
	for slot4, slot5 in pairs(slot0.missionId2NodeItemDict) do
		slot5:everySecondCall()
	end

	slot0:refreshFactoryCanGetBubbleTime()
	slot0:refreshMapName()
end

function slot0.refresh(slot0, slot1)
	slot0:refreshNode(slot1)
	slot0:refreshNodeLines()
	slot0:refreshFactoryEntrance()
	slot0:refreshFactoryCanGetBubble()
end

function slot0.refreshNode(slot0, slot1)
	slot0:refreshIsShowSwitchPoint()
	slot0:switchMap(nil, slot1)
	slot0:refreshSwitchPoint()
end

function slot0.refreshIsShowSwitchPoint(slot0)
	slot1 = Activity157Model.instance:getAllActiveNodeGroupList()

	gohelper.CreateObjList(slot0, slot0.onSwitchPointCreate, slot1, slot0._gopointparent, slot0._goswitchpoint)
	gohelper.setActive(slot0._goswitch, #slot1 > 1)

	if #slot1 > 1 and not Activity157Model.instance:getHasPlayedAnim(VersionActivity1_8DungeonEnum.PlayerPrefsKey.IsPlayedFactoryMapSwitchUnlockAnim) then
		slot0._switchanimator:Play("unlock", 0, 0)
		Activity157Model.instance:setHasPlayedAnim(slot2)
	end

	slot0:refreshSwitchPoint()
end

function slot0.onSwitchPointCreate(slot0, slot1, slot2, slot3)
	slot4 = slot0:getUserDataTb_()
	slot4.go = slot1
	slot4.missionGroupId = slot2
	slot4.goSelect = gohelper.findChild(slot1, "select")
	slot4.goRed = gohelper.findChild(slot1, "#red")
	slot4.click = gohelper.getClickWithDefaultAudio(slot1)

	slot4.click:AddClickListener(slot0.onSwitchPointClick, slot0, slot3)
	gohelper.setActive(slot4.goSelect, false)

	slot0.switchPointItemList[slot3] = slot4
end

function slot0.onSwitchPointClick(slot0, slot1)
	slot0:switchMap(slot1)
end

function slot0.setNodeGroup(slot0, slot1, slot2)
	if not slot0.missionId2NodeItemDict then
		slot0.missionId2NodeItemDict = {}
	end

	for slot7, slot8 in ipairs(Activity157Model.instance:getShowMissionIdList(slot1)) do
		slot0:getNodeItem():setMissionData(slot1, slot8, slot2)

		if slot0.missionId2NodeItemDict[slot8] then
			logError(string.format("VersionActivity1_8FactoryMapView:setNodeGroup error, missionId:%s repeat", slot8))
		end

		slot0.missionId2NodeItemDict[slot8] = slot9
	end

	slot4 = uv0

	if slot2 then
		slot4 = uv1
	end

	TaskDispatcher.cancelTask(slot0.playNodeShowAudio, slot0)
	TaskDispatcher.runDelay(slot0.playNodeShowAudio, slot0, slot4)
end

function slot0.playNodeShowAudio(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Act157FactoryNodeShow)
end

function slot0.refreshNodeLines(slot0)
	for slot4, slot5 in pairs(slot0.missionId2NodeItemDict) do
		slot5:refreshLine()
	end
end

function slot0.refreshFactoryEntrance(slot0)
	slot1 = Activity157Model.instance:getIsUnlockFactoryBlueprint()

	gohelper.setActive(slot0._golockedfactory, not slot1)
	gohelper.setActive(slot0._gounlocknum, not slot1)

	if slot1 then
		slot0:checkFactoryBlueprintEntranceUnlockAnim()
	else
		slot0:refreshFactoryEntranceUnlockNum()
	end

	slot0:refreshFactoryEntranceRepairProgress()
end

function slot0.refreshFactoryEntranceUnlockNum(slot0)
	slot2, slot3, slot4 = Activity157Config.instance:getComponentUnlockCondition(slot0.actId, Activity157Config.instance:getAct157Const(slot0.actId, Activity157Enum.ConstId.FirstFactoryComponent))
	slot5 = ItemModel.instance:getItemQuantity(slot2, slot3)
	slot6 = "#F5744D"

	if slot4 and slot4 <= slot5 then
		slot6 = "#88CB7F"
	end

	slot0._txtunlocknum.text = string.format("<color=%s>%s</color>/%s", slot6, slot5, slot4 or 0)
end

function slot0.checkFactoryBlueprintEntranceUnlockAnim(slot0)
	if Activity157Model.instance:getHasPlayedAnim(VersionActivity1_8DungeonEnum.PlayerPrefsKey.IsPlayedBlueprintUnlockAnim) then
		return
	end

	gohelper.setActive(slot0._golockedfactory, true)
	gohelper.setActive(slot0._gounlocknum, true)
	slot0._btnfactoryAnimator:Play("unlock", 0, 0)
	Activity157Model.instance:setHasPlayedAnim(slot1)
end

function slot0.refreshFactoryEntranceRepairProgress(slot0)
	slot1 = 0

	if Activity157Model.instance:getIsUnlockFactoryBlueprint() then
		slot1 = Activity157Model.instance:getComponentRepairProgress()
	end

	slot0._imageprogress.fillAmount = slot1
end

function slot0.refreshFactoryCanGetBubble(slot0)
	slot3 = Activity157Model.instance:getIsUnlockFactoryBlueprint() and Activity157Model.instance:getIsFirstComponentRepair()

	gohelper.setActive(slot0._gocangetbubble, slot3)

	if not slot3 then
		return
	end

	if Activity157Config.instance:getAct157FactoryProductCapacity(slot0.actId, Activity157Enum.ConstId.FactoryProductCapacity) <= Activity157Model.instance:getFactoryProductionNum() then
		gohelper.setActive(slot0._gocangetfull, true)
		gohelper.setActive(slot0._gochargetime, false)
		gohelper.setActive(slot0._gocangetnum, false)
		gohelper.setActive(slot0._gofinished, false)

		return
	end

	gohelper.setActive(slot0._gocangetfull, false)
	gohelper.setActive(slot0._gochargetime, not string.nilorempty(Activity157Model.instance:getFactoryNextRecoverCountdown()))
	slot0:refreshFactoryCanGetBubbleTime()

	if not (slot4 > 0) and slot8 then
		gohelper.setActive(slot0._gofinished, true)
		gohelper.setActive(slot0._gocangetnum, false)
	else
		slot11 = "#F5744D"

		if slot9 then
			slot11 = "#88CB7F"
		end

		slot0._txtcangetnum.text = string.format("<color=%s>%s</color>/%s", slot11, slot4, slot5)

		gohelper.setActive(slot0._gofinished, false)
		gohelper.setActive(slot0._gocangetnum, true)
	end
end

function slot0.refreshFactoryCanGetBubbleTime(slot0)
	if not Activity157Model.instance:getIsUnlockFactoryBlueprint() then
		return
	end

	if Activity157Config.instance:getAct157FactoryProductCapacity(slot0.actId, Activity157Enum.ConstId.FactoryProductCapacity) <= Activity157Model.instance:getFactoryProductionNum() then
		return
	end

	if not string.nilorempty(Activity157Model.instance:getFactoryNextRecoverCountdown()) then
		slot0._txtnextchargetime.text = slot5
	end
end

function slot0.refreshMapName(slot0)
	if not slot0:getCurSelectMissionGroupId() then
		slot0._txtmapname.text = ""
		slot0._txtsidemissionmapname.text = ""

		return
	end

	if Activity157Config.instance:isSideMissionGroup(slot0.actId, slot1) then
		if Activity157Model.instance:getIsSideMissionUnlocked() then
			slot0._txtsidemissionmapname.text = Activity157Config.instance:getMapName(slot0.actId, slot1)

			gohelper.setActive(slot0._golockedsidemissionicon, false)
		else
			slot5, slot6 = Activity157Model.instance:getSideMissionUnlockTime()
			slot0._txtsidemissionmapname.text = formatLuaLang("test_task_unlock_time", slot5)

			if slot6 then
				gohelper.setActive(slot0._goswitchunlock, true)
			end

			gohelper.setActive(slot0._golockedsidemissionicon, not slot6)
		end
	else
		slot0._txtmapname.text = slot2
	end
end

function slot0.refreshSwitchPoint(slot0)
	if not slot0.switchPointItemList then
		return
	end

	for slot5, slot6 in ipairs(slot0.switchPointItemList) do
		gohelper.setActive(slot6.goSelect, slot5 == slot0.curIndex)

		if Activity157Model.instance:getIsSideMissionUnlocked() then
			if Activity157Config.instance:isSideMissionGroup(slot0.actId, slot6.missionGroupId) then
				gohelper.setActive(slot6.goRed, not Activity157Model.instance:isInProgressOtherMissionGroup(slot7) and not Activity157Model.instance:isFinishAllMission(slot7) and not (slot0:getCurSelectMissionGroupId() == slot7))
			else
				gohelper.setActive(slot6.goRed, false)
			end
		end
	end
end

function slot0.getNodeItem(slot0)
	if next(slot0.nodeItemPool) then
		return table.remove(slot0.nodeItemPool)
	else
		return slot0:createNodeItem()
	end
end

function slot0.createNodeItem(slot0)
	slot2 = VersionActivity1_8FactoryMapNodeItem.New()

	slot2:init(gohelper.clone(slot0._gonodeitem, slot0._gonodecontainer, "nodeitem"), slot0.getLineTemplate, slot0._goline, slot0)

	return slot2
end

function slot0.recycleAllNodeItem(slot0)
	if not slot0.missionId2NodeItemDict then
		return
	end

	for slot4, slot5 in pairs(slot0.missionId2NodeItemDict) do
		slot5:reset(true)
		table.insert(slot0.nodeItemPool, slot5)
	end

	slot0.missionId2NodeItemDict = {}
end

function slot0.getCurSelectMissionGroupId(slot0)
	slot1 = nil

	if slot0.switchPointItemList and slot0.curIndex and slot0.switchPointItemList[slot0.curIndex] then
		slot1 = slot2.missionGroupId
	end

	return slot1
end

function slot0.getLineTemplate(slot0, slot1)
	if string.nilorempty(slot1) then
		return nil
	end

	slot0.lineTemplateDict = slot0.lineTemplateDict or slot0:getUserDataTb_()

	if not slot0.lineTemplateDict[slot1] and slot0.goLineTemplate then
		slot0.lineTemplateDict[slot1] = gohelper.findChild(slot0.goLineTemplate, slot1)
	end

	return slot0.lineTemplateDict[slot1]
end

function slot0.playAreaAnim(slot0, slot1, slot2)
	slot3 = nil

	if slot2 then
		slot3 = slot1 and slot0.mapAreaAnimatorDict[slot1]
	end

	if slot3 then
		slot3:Play(slot2, 0, 0)
	end
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.playNodeShowAudio, slot0)
	TaskDispatcher.cancelTask(slot0.everySecondCall, slot0)
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in ipairs(slot0.nodeItemPool) do
		slot5:destroy()
	end

	slot0.nodeItemPool = {}

	for slot4, slot5 in pairs(slot0.missionId2NodeItemDict) do
		slot5:destroy()
	end

	slot0.missionId2NodeItemDict = nil

	for slot4, slot5 in ipairs(slot0.switchPointItemList) do
		slot5.click:RemoveClickListener()
	end

	slot0.switchPointItemList = nil

	slot0._simagecangeticon:UnLoadImage()

	slot0.curIndex = nil
	slot0._waitRefreshUnlockAnim = nil
end

return slot0
