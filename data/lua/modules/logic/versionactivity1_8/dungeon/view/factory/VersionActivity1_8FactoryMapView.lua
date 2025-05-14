module("modules.logic.versionactivity1_8.dungeon.view.factory.VersionActivity1_8FactoryMapView", package.seeall)

local var_0_0 = class("VersionActivity1_8FactoryMapView", BaseView)
local var_0_1 = 1
local var_0_2 = 0.3
local var_0_3 = 0.2

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goline = gohelper.findChild(arg_1_0.viewGO, "Line")
	arg_1_0._gonodecontainer = gohelper.findChild(arg_1_0.viewGO, "#go_nodecontainer")
	arg_1_0._gonodeitem = gohelper.findChild(arg_1_0.viewGO, "#go_nodecontainer/#go_nodeitem")
	arg_1_0._btnfactory = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "#btn_factory")
	arg_1_0._btnfactoryAnimator = gohelper.findChildComponent(arg_1_0.viewGO, "#btn_factory", typeof(UnityEngine.Animator))
	arg_1_0._goFactoryBlueprintReddot = gohelper.findChild(arg_1_0.viewGO, "#btn_factory/#go_reddot")
	arg_1_0._golockedfactory = gohelper.findChild(arg_1_0.viewGO, "#btn_factory/#go_locked")
	arg_1_0._imageprogress = gohelper.findChildImage(arg_1_0.viewGO, "#btn_factory/#go_progroess/circle")
	arg_1_0._gocangetbubble = gohelper.findChild(arg_1_0.viewGO, "#btn_factory/#go_canget")
	arg_1_0._btncanget = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_factory/#go_canget", AudioEnum.UI.Act157GetBubbleReward)
	arg_1_0._simagecangeticon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#btn_factory/#go_canget/icon")
	arg_1_0._gocangetfull = gohelper.findChild(arg_1_0.viewGO, "#btn_factory/#go_canget/#go_full")
	arg_1_0._gofinished = gohelper.findChild(arg_1_0.viewGO, "#btn_factory/#go_canget/finished")
	arg_1_0._gocharging = gohelper.findChild(arg_1_0.viewGO, "#btn_factory/#go_canget/finishing")
	arg_1_0._gochargetime = gohelper.findChild(arg_1_0.viewGO, "#btn_factory/#go_canget/finishing/time")
	arg_1_0._txtnextchargetime = gohelper.findChildText(arg_1_0.viewGO, "#btn_factory/#go_canget/finishing/time/#txt_time")
	arg_1_0._gocangetnum = gohelper.findChild(arg_1_0.viewGO, "#btn_factory/#go_canget/finishing/num")
	arg_1_0._txtcangetnum = gohelper.findChildText(arg_1_0.viewGO, "#btn_factory/#go_canget/finishing/num/#txt_num")
	arg_1_0._gounlocknum = gohelper.findChild(arg_1_0.viewGO, "#btn_factory/#go_num")
	arg_1_0._imageunlockicon = gohelper.findChildImage(arg_1_0.viewGO, "#btn_factory/#go_num/icon")
	arg_1_0._txtunlocknum = gohelper.findChildText(arg_1_0.viewGO, "#btn_factory/#go_num/#txt_num")
	arg_1_0._imagefactory = gohelper.findChildImage(arg_1_0.viewGO, "#btn_factory/#image_factory")
	arg_1_0._mapswitchanimator = gohelper.findChildComponent(arg_1_0.viewGO, "#go_mapswitch", typeof(UnityEngine.Animator))
	arg_1_0._goswitchunlock = gohelper.findChild(arg_1_0.viewGO, "#go_mapswitch/#unlock")
	arg_1_0._switchanimator = gohelper.findChildComponent(arg_1_0.viewGO, "#go_mapswitch/switch", typeof(UnityEngine.Animator))
	arg_1_0._txtmapname = gohelper.findChildText(arg_1_0.viewGO, "#go_mapswitch/normal/#txt_mapname")
	arg_1_0._txtsidemissionmapname = gohelper.findChildText(arg_1_0.viewGO, "#go_mapswitch/locked/layout/#txt_timelocked")
	arg_1_0._golockedsidemissionicon = gohelper.findChild(arg_1_0.viewGO, "#go_mapswitch/locked/layout/icon")
	arg_1_0._goswitch = gohelper.findChild(arg_1_0.viewGO, "#go_mapswitch/switch")
	arg_1_0._btnleft = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_mapswitch/switch/#btn_left")
	arg_1_0._btnright = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_mapswitch/switch/#btn_right")
	arg_1_0._gopointparent = gohelper.findChild(arg_1_0.viewGO, "#go_mapswitch/switch/pointbg/pointcontainer")
	arg_1_0._goswitchpoint = gohelper.findChild(arg_1_0.viewGO, "#go_mapswitch/switch/pointbg/pointcontainer/empty")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_2_0._onCloseView, arg_2_0)
	arg_2_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_2_0._onCurrencyChange, arg_2_0)
	arg_2_0:addEventCb(VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.FocusElement, arg_2_0.closeThis, arg_2_0)
	arg_2_0:addEventCb(VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.ManualClickElement, arg_2_0.closeThis, arg_2_0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_2_0.dailyRefresh, arg_2_0)
	arg_2_0:addEventCb(Activity157Controller.instance, Activity157Event.Act157RepairComponent, arg_2_0._onRepairComponent, arg_2_0)
	arg_2_0:addEventCb(Activity157Controller.instance, Activity157Event.Act157RefreshFactoryProduction, arg_2_0.refreshFactoryCanGetBubble, arg_2_0)
	arg_2_0:addEventCb(Activity157Controller.instance, Activity157Event.Act157RefreshSideMission, arg_2_0._onRefreshNode, arg_2_0)
	arg_2_0:addEventCb(Activity157Controller.instance, Activity157Event.Act157FinishMission, arg_2_0._onRefreshNode, arg_2_0)
	arg_2_0._btnfactory:AddClickListener(arg_2_0._btnfactoryOnClick, arg_2_0)
	arg_2_0._btncanget:AddClickListener(arg_2_0._btncangetOnClick, arg_2_0)
	arg_2_0._btnleft:AddClickListener(arg_2_0._btnleftOnClick, arg_2_0)
	arg_2_0._btnright:AddClickListener(arg_2_0._btnrightOnCLick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_3_0._onCloseView, arg_3_0)
	arg_3_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_3_0._onCurrencyChange, arg_3_0)
	arg_3_0:removeEventCb(VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.FocusElement, arg_3_0.closeThis, arg_3_0)
	arg_3_0:removeEventCb(VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.ManualClickElement, arg_3_0.closeThis, arg_3_0)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, arg_3_0.dailyRefresh, arg_3_0)
	arg_3_0:removeEventCb(Activity157Controller.instance, Activity157Event.Act157RepairComponent, arg_3_0._onRepairComponent, arg_3_0)
	arg_3_0:removeEventCb(Activity157Controller.instance, Activity157Event.Act157RefreshFactoryProduction, arg_3_0.refreshFactoryCanGetBubble, arg_3_0)
	arg_3_0:removeEventCb(Activity157Controller.instance, Activity157Event.Act157RefreshSideMission, arg_3_0._onRefreshNode, arg_3_0)
	arg_3_0:removeEventCb(Activity157Controller.instance, Activity157Event.Act157FinishMission, arg_3_0._onRefreshNode, arg_3_0)
	arg_3_0._btnfactory:RemoveClickListener()
	arg_3_0._btncanget:RemoveClickListener()
	arg_3_0._btnleft:RemoveClickListener()
	arg_3_0._btnright:RemoveClickListener()
end

function var_0_0._onCloseView(arg_4_0, arg_4_1)
	if arg_4_1 ~= ViewName.VersionActivity1_8FactoryBlueprintView then
		return
	end

	if arg_4_0._waitRefreshUnlockAnim then
		for iter_4_0, iter_4_1 in pairs(arg_4_0.missionId2NodeItemDict) do
			iter_4_1:refreshUnlockAnim()
		end

		arg_4_0:refreshIsShowSwitchPoint()

		arg_4_0._waitRefreshUnlockAnim = nil
	end
end

function var_0_0._onCurrencyChange(arg_5_0, arg_5_1)
	if not arg_5_1[CurrencyEnum.CurrencyType.V1a8FactoryPart] then
		return
	end

	arg_5_0:refreshFactoryEntrance()
end

function var_0_0.dailyRefresh(arg_6_0)
	Activity157Controller.instance:getAct157ActInfo()
end

function var_0_0._onRepairComponent(arg_7_0)
	arg_7_0:refreshFactoryEntrance()
	arg_7_0:refreshFactoryCanGetBubble()

	if ViewMgr.instance:isOpen(ViewName.VersionActivity1_8FactoryBlueprintView) then
		arg_7_0._waitRefreshUnlockAnim = true
	else
		for iter_7_0, iter_7_1 in pairs(arg_7_0.missionId2NodeItemDict) do
			iter_7_1:refreshUnlockAnim()
		end
	end
end

function var_0_0._onRefreshNode(arg_8_0)
	arg_8_0:refreshNode()
	arg_8_0:refreshNodeLines()
end

function var_0_0._btnfactoryOnClick(arg_9_0)
	Activity157Controller.instance:openFactoryBlueprintView()
end

function var_0_0._btncangetOnClick(arg_10_0)
	Activity157Controller.instance:getFactoryProduction()
end

function var_0_0._btnleftOnClick(arg_11_0)
	if not arg_11_0.curIndex then
		return
	end

	arg_11_0:switchMap(arg_11_0.curIndex - 1)
end

function var_0_0._btnrightOnCLick(arg_12_0)
	if not arg_12_0.curIndex then
		return
	end

	arg_12_0:switchMap(arg_12_0.curIndex + 1)
end

function var_0_0.switchMap(arg_13_0, arg_13_1, arg_13_2)
	if not arg_13_1 then
		if arg_13_2 then
			local var_13_0 = Activity157Model.instance:getInProgressMissionGroup()

			for iter_13_0, iter_13_1 in ipairs(arg_13_0.switchPointItemList) do
				if iter_13_1.missionGroupId == var_13_0 then
					arg_13_1 = iter_13_0

					break
				end
			end
		else
			arg_13_1 = arg_13_0.curIndex
		end
	end

	arg_13_1 = arg_13_1 or var_0_1

	local var_13_1 = #arg_13_0.switchPointItemList

	if var_13_1 < arg_13_1 then
		arg_13_1 = var_0_1
	elseif arg_13_1 < var_0_1 then
		arg_13_1 = var_13_1
	end

	local var_13_2 = arg_13_1 and arg_13_0.switchPointItemList[arg_13_1]

	if not var_13_2 then
		return
	end

	local var_13_3 = false
	local var_13_4 = arg_13_0.curIndex and arg_13_0.switchPointItemList[arg_13_0.curIndex]
	local var_13_5 = var_13_4 and var_13_4.missionGroupId
	local var_13_6 = var_13_2.missionGroupId
	local var_13_7 = Activity157Config.instance:isSideMissionGroup(arg_13_0.actId, var_13_6)

	if var_13_5 and Activity157Config.instance:isSideMissionGroup(arg_13_0.actId, var_13_5) ~= var_13_7 then
		var_13_3 = true
	end

	if var_13_3 then
		arg_13_0._mapswitchanimator:Play(var_13_7 and "switch_locked" or "switch_nomal", 0, 0)
	else
		arg_13_0._mapswitchanimator:Play(var_13_7 and "locked" or "nomal", 0, 0)
	end

	arg_13_0:recycleAllNodeItem()

	arg_13_0.curIndex = arg_13_1

	arg_13_0:setNodeGroup(var_13_6, arg_13_2)
	arg_13_0:refreshSwitchPoint()
	arg_13_0:refreshMapName()
end

function var_0_0._editableInitView(arg_14_0)
	arg_14_0.actId = Activity157Model.instance:getActId()
	arg_14_0.nodeItemPool = {}
	arg_14_0.missionId2NodeItemDict = {}
	arg_14_0.curIndex = nil
	arg_14_0.lineTemplateDict = arg_14_0:getUserDataTb_()
	arg_14_0.switchPointItemList = {}
	arg_14_0._waitRefreshUnlockAnim = nil

	gohelper.setActive(arg_14_0._gonodeitem, false)
	gohelper.setActive(arg_14_0._goswitchpoint, false)

	arg_14_0.mapAreaAnimatorDict = arg_14_0:getUserDataTb_()

	local var_14_0 = gohelper.findChild(arg_14_0.viewGO, "Map").transform
	local var_14_1 = var_14_0.childCount

	for iter_14_0 = 1, var_14_1 do
		local var_14_2 = var_14_0:GetChild(iter_14_0 - 1)
		local var_14_3 = var_14_2:GetComponent(typeof(UnityEngine.Animator))

		var_14_3:Play("lock_idle", 0, 0)

		arg_14_0.mapAreaAnimatorDict[tostring(var_14_2.name)] = var_14_3
	end

	local var_14_4 = Activity157Config.instance:getAct157Const(arg_14_0.actId, Activity157Enum.ConstId.FactoryCompositeCost)
	local var_14_5 = var_14_4 and string.splitToNumber(var_14_4, "#")

	if var_14_5 then
		local var_14_6, var_14_7 = ItemModel.instance:getItemConfigAndIcon(var_14_5[1], var_14_5[2])

		if var_14_7 then
			arg_14_0._simagecangeticon:LoadImage(var_14_7)
		end
	end

	local var_14_8 = Activity157Config.instance:getAct157Const(arg_14_0.actId, Activity157Enum.ConstId.FactoryRepairPartItem)
	local var_14_9 = var_14_8 and string.splitToNumber(var_14_8, "#")

	if var_14_9 then
		local var_14_10 = CurrencyConfig.instance:getCurrencyCo(var_14_9[2])
		local var_14_11 = var_14_10 and var_14_10.icon

		if var_14_11 then
			UISpriteSetMgr.instance:setCurrencyItemSprite(arg_14_0._imageunlockicon, var_14_11 .. "_1", true)
		end
	end

	local var_14_12 = arg_14_0.viewContainer:getSetting().otherRes[1]

	arg_14_0.goLineTemplate = arg_14_0.viewContainer:getResInst(var_14_12, arg_14_0._goline)

	gohelper.setActive(arg_14_0.goLineTemplate, false)
	RedDotController.instance:addRedDot(arg_14_0._goFactoryBlueprintReddot, RedDotEnum.DotNode.V1a8DungeonFactoryBlueprint)
end

function var_0_0.onUpdateParam(arg_15_0)
	Activity157Controller.instance:onFactoryMapViewOpen()
end

function var_0_0.onOpen(arg_16_0)
	arg_16_0:refresh(true)
	arg_16_0:everySecondCall()
	TaskDispatcher.runRepeat(arg_16_0.everySecondCall, arg_16_0, 1)
	Activity157Controller.instance:onFactoryMapViewOpen()
end

function var_0_0.everySecondCall(arg_17_0)
	for iter_17_0, iter_17_1 in pairs(arg_17_0.missionId2NodeItemDict) do
		iter_17_1:everySecondCall()
	end

	arg_17_0:refreshFactoryCanGetBubbleTime()
	arg_17_0:refreshMapName()
end

function var_0_0.refresh(arg_18_0, arg_18_1)
	arg_18_0:refreshNode(arg_18_1)
	arg_18_0:refreshNodeLines()
	arg_18_0:refreshFactoryEntrance()
	arg_18_0:refreshFactoryCanGetBubble()
end

function var_0_0.refreshNode(arg_19_0, arg_19_1)
	arg_19_0:refreshIsShowSwitchPoint()
	arg_19_0:switchMap(nil, arg_19_1)
	arg_19_0:refreshSwitchPoint()
end

function var_0_0.refreshIsShowSwitchPoint(arg_20_0)
	local var_20_0 = Activity157Model.instance:getAllActiveNodeGroupList()

	gohelper.CreateObjList(arg_20_0, arg_20_0.onSwitchPointCreate, var_20_0, arg_20_0._gopointparent, arg_20_0._goswitchpoint)
	gohelper.setActive(arg_20_0._goswitch, #var_20_0 > 1)

	if #var_20_0 > 1 then
		local var_20_1 = VersionActivity1_8DungeonEnum.PlayerPrefsKey.IsPlayedFactoryMapSwitchUnlockAnim

		if not Activity157Model.instance:getHasPlayedAnim(var_20_1) then
			arg_20_0._switchanimator:Play("unlock", 0, 0)
			Activity157Model.instance:setHasPlayedAnim(var_20_1)
		end
	end

	arg_20_0:refreshSwitchPoint()
end

function var_0_0.onSwitchPointCreate(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = arg_21_0:getUserDataTb_()

	var_21_0.go = arg_21_1
	var_21_0.missionGroupId = arg_21_2
	var_21_0.goSelect = gohelper.findChild(arg_21_1, "select")
	var_21_0.goRed = gohelper.findChild(arg_21_1, "#red")
	var_21_0.click = gohelper.getClickWithDefaultAudio(arg_21_1)

	var_21_0.click:AddClickListener(arg_21_0.onSwitchPointClick, arg_21_0, arg_21_3)
	gohelper.setActive(var_21_0.goSelect, false)

	arg_21_0.switchPointItemList[arg_21_3] = var_21_0
end

function var_0_0.onSwitchPointClick(arg_22_0, arg_22_1)
	arg_22_0:switchMap(arg_22_1)
end

function var_0_0.setNodeGroup(arg_23_0, arg_23_1, arg_23_2)
	if not arg_23_0.missionId2NodeItemDict then
		arg_23_0.missionId2NodeItemDict = {}
	end

	local var_23_0 = Activity157Model.instance:getShowMissionIdList(arg_23_1)

	for iter_23_0, iter_23_1 in ipairs(var_23_0) do
		local var_23_1 = arg_23_0:getNodeItem()

		var_23_1:setMissionData(arg_23_1, iter_23_1, arg_23_2)

		if arg_23_0.missionId2NodeItemDict[iter_23_1] then
			logError(string.format("VersionActivity1_8FactoryMapView:setNodeGroup error, missionId:%s repeat", iter_23_1))
		end

		arg_23_0.missionId2NodeItemDict[iter_23_1] = var_23_1
	end

	local var_23_2 = var_0_3

	if arg_23_2 then
		var_23_2 = var_0_2
	end

	TaskDispatcher.cancelTask(arg_23_0.playNodeShowAudio, arg_23_0)
	TaskDispatcher.runDelay(arg_23_0.playNodeShowAudio, arg_23_0, var_23_2)
end

function var_0_0.playNodeShowAudio(arg_24_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Act157FactoryNodeShow)
end

function var_0_0.refreshNodeLines(arg_25_0)
	for iter_25_0, iter_25_1 in pairs(arg_25_0.missionId2NodeItemDict) do
		iter_25_1:refreshLine()
	end
end

function var_0_0.refreshFactoryEntrance(arg_26_0)
	local var_26_0 = Activity157Model.instance:getIsUnlockFactoryBlueprint()

	gohelper.setActive(arg_26_0._golockedfactory, not var_26_0)
	gohelper.setActive(arg_26_0._gounlocknum, not var_26_0)

	if var_26_0 then
		arg_26_0:checkFactoryBlueprintEntranceUnlockAnim()
	else
		arg_26_0:refreshFactoryEntranceUnlockNum()
	end

	arg_26_0:refreshFactoryEntranceRepairProgress()
end

function var_0_0.refreshFactoryEntranceUnlockNum(arg_27_0)
	local var_27_0 = Activity157Config.instance:getAct157Const(arg_27_0.actId, Activity157Enum.ConstId.FirstFactoryComponent)
	local var_27_1, var_27_2, var_27_3 = Activity157Config.instance:getComponentUnlockCondition(arg_27_0.actId, var_27_0)
	local var_27_4 = ItemModel.instance:getItemQuantity(var_27_1, var_27_2)
	local var_27_5 = "#F5744D"

	if var_27_3 and var_27_3 <= var_27_4 then
		var_27_5 = "#88CB7F"
	end

	arg_27_0._txtunlocknum.text = string.format("<color=%s>%s</color>/%s", var_27_5, var_27_4, var_27_3 or 0)
end

function var_0_0.checkFactoryBlueprintEntranceUnlockAnim(arg_28_0)
	local var_28_0 = VersionActivity1_8DungeonEnum.PlayerPrefsKey.IsPlayedBlueprintUnlockAnim

	if Activity157Model.instance:getHasPlayedAnim(var_28_0) then
		return
	end

	gohelper.setActive(arg_28_0._golockedfactory, true)
	gohelper.setActive(arg_28_0._gounlocknum, true)
	arg_28_0._btnfactoryAnimator:Play("unlock", 0, 0)
	Activity157Model.instance:setHasPlayedAnim(var_28_0)
end

function var_0_0.refreshFactoryEntranceRepairProgress(arg_29_0)
	local var_29_0 = 0

	if Activity157Model.instance:getIsUnlockFactoryBlueprint() then
		var_29_0 = Activity157Model.instance:getComponentRepairProgress()
	end

	arg_29_0._imageprogress.fillAmount = var_29_0
end

function var_0_0.refreshFactoryCanGetBubble(arg_30_0)
	local var_30_0 = Activity157Model.instance:getIsUnlockFactoryBlueprint()
	local var_30_1 = Activity157Model.instance:getIsFirstComponentRepair()
	local var_30_2 = var_30_0 and var_30_1

	gohelper.setActive(arg_30_0._gocangetbubble, var_30_2)

	if not var_30_2 then
		return
	end

	local var_30_3 = Activity157Model.instance:getFactoryProductionNum()
	local var_30_4 = Activity157Config.instance:getAct157FactoryProductCapacity(arg_30_0.actId, Activity157Enum.ConstId.FactoryProductCapacity)

	if var_30_4 <= var_30_3 then
		gohelper.setActive(arg_30_0._gocangetfull, true)
		gohelper.setActive(arg_30_0._gochargetime, false)
		gohelper.setActive(arg_30_0._gocangetnum, false)
		gohelper.setActive(arg_30_0._gofinished, false)

		return
	end

	gohelper.setActive(arg_30_0._gocangetfull, false)

	local var_30_5 = Activity157Model.instance:getFactoryNextRecoverCountdown()
	local var_30_6 = string.nilorempty(var_30_5)

	gohelper.setActive(arg_30_0._gochargetime, not var_30_6)
	arg_30_0:refreshFactoryCanGetBubbleTime()

	local var_30_7 = var_30_3 > 0

	if not var_30_7 and var_30_6 then
		gohelper.setActive(arg_30_0._gofinished, true)
		gohelper.setActive(arg_30_0._gocangetnum, false)
	else
		local var_30_8 = "#F5744D"

		if var_30_7 then
			var_30_8 = "#88CB7F"
		end

		arg_30_0._txtcangetnum.text = string.format("<color=%s>%s</color>/%s", var_30_8, var_30_3, var_30_4)

		gohelper.setActive(arg_30_0._gofinished, false)
		gohelper.setActive(arg_30_0._gocangetnum, true)
	end
end

function var_0_0.refreshFactoryCanGetBubbleTime(arg_31_0)
	if not Activity157Model.instance:getIsUnlockFactoryBlueprint() then
		return
	end

	if Activity157Model.instance:getFactoryProductionNum() >= Activity157Config.instance:getAct157FactoryProductCapacity(arg_31_0.actId, Activity157Enum.ConstId.FactoryProductCapacity) then
		return
	end

	local var_31_0 = Activity157Model.instance:getFactoryNextRecoverCountdown()

	if not string.nilorempty(var_31_0) then
		arg_31_0._txtnextchargetime.text = var_31_0
	end
end

function var_0_0.refreshMapName(arg_32_0)
	local var_32_0 = arg_32_0:getCurSelectMissionGroupId()

	if not var_32_0 then
		arg_32_0._txtmapname.text = ""
		arg_32_0._txtsidemissionmapname.text = ""

		return
	end

	local var_32_1 = Activity157Config.instance:getMapName(arg_32_0.actId, var_32_0)

	if Activity157Config.instance:isSideMissionGroup(arg_32_0.actId, var_32_0) then
		if Activity157Model.instance:getIsSideMissionUnlocked() then
			arg_32_0._txtsidemissionmapname.text = var_32_1

			gohelper.setActive(arg_32_0._golockedsidemissionicon, false)
		else
			local var_32_2, var_32_3 = Activity157Model.instance:getSideMissionUnlockTime()

			arg_32_0._txtsidemissionmapname.text = formatLuaLang("test_task_unlock_time", var_32_2)

			if var_32_3 then
				gohelper.setActive(arg_32_0._goswitchunlock, true)
			end

			gohelper.setActive(arg_32_0._golockedsidemissionicon, not var_32_3)
		end
	else
		arg_32_0._txtmapname.text = var_32_1
	end
end

function var_0_0.refreshSwitchPoint(arg_33_0)
	if not arg_33_0.switchPointItemList then
		return
	end

	local var_33_0 = Activity157Model.instance:getIsSideMissionUnlocked()

	for iter_33_0, iter_33_1 in ipairs(arg_33_0.switchPointItemList) do
		gohelper.setActive(iter_33_1.goSelect, iter_33_0 == arg_33_0.curIndex)

		if var_33_0 then
			local var_33_1 = iter_33_1.missionGroupId

			if Activity157Config.instance:isSideMissionGroup(arg_33_0.actId, var_33_1) then
				local var_33_2 = Activity157Model.instance:isInProgressOtherMissionGroup(var_33_1)
				local var_33_3 = Activity157Model.instance:isFinishAllMission(var_33_1)
				local var_33_4 = arg_33_0:getCurSelectMissionGroupId() == var_33_1

				gohelper.setActive(iter_33_1.goRed, not var_33_2 and not var_33_3 and not var_33_4)
			else
				gohelper.setActive(iter_33_1.goRed, false)
			end
		end
	end
end

function var_0_0.getNodeItem(arg_34_0)
	if next(arg_34_0.nodeItemPool) then
		return table.remove(arg_34_0.nodeItemPool)
	else
		return arg_34_0:createNodeItem()
	end
end

function var_0_0.createNodeItem(arg_35_0)
	local var_35_0 = gohelper.clone(arg_35_0._gonodeitem, arg_35_0._gonodecontainer, "nodeitem")
	local var_35_1 = VersionActivity1_8FactoryMapNodeItem.New()

	var_35_1:init(var_35_0, arg_35_0.getLineTemplate, arg_35_0._goline, arg_35_0)

	return var_35_1
end

function var_0_0.recycleAllNodeItem(arg_36_0)
	if not arg_36_0.missionId2NodeItemDict then
		return
	end

	for iter_36_0, iter_36_1 in pairs(arg_36_0.missionId2NodeItemDict) do
		iter_36_1:reset(true)
		table.insert(arg_36_0.nodeItemPool, iter_36_1)
	end

	arg_36_0.missionId2NodeItemDict = {}
end

function var_0_0.getCurSelectMissionGroupId(arg_37_0)
	local var_37_0

	if arg_37_0.switchPointItemList then
		local var_37_1 = arg_37_0.curIndex and arg_37_0.switchPointItemList[arg_37_0.curIndex]

		if var_37_1 then
			var_37_0 = var_37_1.missionGroupId
		end
	end

	return var_37_0
end

function var_0_0.getLineTemplate(arg_38_0, arg_38_1)
	local var_38_0

	if string.nilorempty(arg_38_1) then
		return var_38_0
	end

	arg_38_0.lineTemplateDict = arg_38_0.lineTemplateDict or arg_38_0:getUserDataTb_()

	if not arg_38_0.lineTemplateDict[arg_38_1] and arg_38_0.goLineTemplate then
		arg_38_0.lineTemplateDict[arg_38_1] = gohelper.findChild(arg_38_0.goLineTemplate, arg_38_1)
	end

	return arg_38_0.lineTemplateDict[arg_38_1]
end

function var_0_0.playAreaAnim(arg_39_0, arg_39_1, arg_39_2)
	local var_39_0

	if arg_39_2 then
		var_39_0 = arg_39_1 and arg_39_0.mapAreaAnimatorDict[arg_39_1]
	end

	if var_39_0 then
		var_39_0:Play(arg_39_2, 0, 0)
	end
end

function var_0_0.onClose(arg_40_0)
	TaskDispatcher.cancelTask(arg_40_0.playNodeShowAudio, arg_40_0)
	TaskDispatcher.cancelTask(arg_40_0.everySecondCall, arg_40_0)
end

function var_0_0.onDestroyView(arg_41_0)
	for iter_41_0, iter_41_1 in ipairs(arg_41_0.nodeItemPool) do
		iter_41_1:destroy()
	end

	arg_41_0.nodeItemPool = {}

	for iter_41_2, iter_41_3 in pairs(arg_41_0.missionId2NodeItemDict) do
		iter_41_3:destroy()
	end

	arg_41_0.missionId2NodeItemDict = nil

	for iter_41_4, iter_41_5 in ipairs(arg_41_0.switchPointItemList) do
		iter_41_5.click:RemoveClickListener()
	end

	arg_41_0.switchPointItemList = nil

	arg_41_0._simagecangeticon:UnLoadImage()

	arg_41_0.curIndex = nil
	arg_41_0._waitRefreshUnlockAnim = nil
end

return var_0_0
