module("modules.logic.versionactivity1_5.dungeon.view.dispatch.VersionActivity1_5DispatchView", package.seeall)

local var_0_0 = class("VersionActivity1_5DispatchView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goback = gohelper.findChild(arg_1_0.viewGO, "#go_back")
	arg_1_0._gomapcontainer = gohelper.findChild(arg_1_0.viewGO, "container/left/#go_mapcontainer")
	arg_1_0._simagemap = gohelper.findChildSingleImage(arg_1_0.viewGO, "container/left/#go_mapcontainer/#simage_map")
	arg_1_0._goherocontainer = gohelper.findChild(arg_1_0.viewGO, "container/left/#go_herocontainer")
	arg_1_0._goclosehero = gohelper.findChild(arg_1_0.viewGO, "container/left/#go_herocontainer/header/#go_closehero")
	arg_1_0._goclose = gohelper.findChild(arg_1_0.viewGO, "container/right/#go_close")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "container/right/#txt_title")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "container/right/Scroll View/Viewport/Content/#txt_desc")
	arg_1_0._txtcosttime = gohelper.findChildText(arg_1_0.viewGO, "container/right/#txt_costtime")
	arg_1_0._gotimelock = gohelper.findChild(arg_1_0.viewGO, "container/right/#txt_costtime/locked")
	arg_1_0._btnstartdispatch = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "container/right/#btn_startdispatch")
	arg_1_0._btninterruptdispatch = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "container/right/#btn_interruptdispatch")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnstartdispatch:AddClickListener(arg_2_0._btnstartdispatchOnClick, arg_2_0)
	arg_2_0._btninterruptdispatch:AddClickListener(arg_2_0._btninterruptdispatchOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnstartdispatch:RemoveClickListener()
	arg_3_0._btninterruptdispatch:RemoveClickListener()
end

var_0_0.DarkColor = "#3d5a4a"
var_0_0.LightColor = "#287B4D"

function var_0_0._btnstartdispatchOnClick(arg_4_0)
	if arg_4_0.status ~= VersionActivity1_5DungeonEnum.DispatchStatus.NotDispatch then
		return
	end

	if VersionActivity1_5HeroListModel.instance:getSelectedHeroCount() < arg_4_0.dispatchCo.minCount then
		GameFacade.showToast(ToastEnum.V1a5_DungeonDispatchLessMinHero)

		return
	end

	VersionActivity1_5DungeonRpc.instance:sendAct139DispatchRequest(arg_4_0.dispatchId, VersionActivity1_5HeroListModel.instance:getSelectedHeroIdList(), arg_4_0.onDispatchSuccess, arg_4_0)
end

function var_0_0.onDispatchSuccess(arg_5_0)
	GameFacade.showToast(ToastEnum.V1a5_DungeonDispatchSuccess)
end

function var_0_0._btninterruptdispatchOnClick(arg_6_0)
	if arg_6_0.status ~= VersionActivity1_5DungeonEnum.DispatchStatus.Dispatching then
		return
	end

	if arg_6_0.dispatchMo:isFinish() then
		return
	end

	VersionActivity1_5DungeonRpc.instance:sendAct139InterruptDispatchRequest(arg_6_0.dispatchId)
end

function var_0_0.onClickHeroClose(arg_7_0)
	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.ChangeDispatchHeroContainerEvent, false)
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0.backClick = gohelper.getClick(arg_8_0._goback)

	arg_8_0.backClick:AddClickListener(arg_8_0.closeThis, arg_8_0)

	arg_8_0.closeClick = gohelper.getClick(arg_8_0._goclose)

	arg_8_0.closeClick:AddClickListener(arg_8_0.closeThis, arg_8_0)

	arg_8_0.heroCloseClick = gohelper.getClick(arg_8_0._goclosehero)

	arg_8_0.heroCloseClick:AddClickListener(arg_8_0.onClickHeroClose, arg_8_0)

	arg_8_0.simagebg = gohelper.findChildSingleImage(arg_8_0.viewGO, "container/bg02")

	arg_8_0.simagebg:LoadImage(ResUrl.getV1a5DungeonSingleBg("paiqian/v1a5_dungeon_bg_paiqian02"))
	arg_8_0:changeHeroContainerVisible(false)

	arg_8_0.checkShortedTimeFuncDict = {
		[VersionActivity1_5DungeonEnum.DispatchShortedType.Career] = arg_8_0.checkCareer,
		[VersionActivity1_5DungeonEnum.DispatchShortedType.HeroId] = arg_8_0.checkHeroID
	}

	arg_8_0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.ChangeDispatchHeroContainerEvent, arg_8_0.changeHeroContainerVisible, arg_8_0)
	arg_8_0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.AddDispatchInfo, arg_8_0.onAddDispatchInfo, arg_8_0)
	arg_8_0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.RemoveDispatchInfo, arg_8_0.onRemoveDispatchInfo, arg_8_0)
	arg_8_0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnDispatchFinish, arg_8_0.onDispatchFinish, arg_8_0)
	arg_8_0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.ChangeSelectedHero, arg_8_0.onSelectHeroMoChange, arg_8_0)
	TaskDispatcher.runRepeat(arg_8_0.everySecondCall, arg_8_0, 1)
end

function var_0_0.changeHeroContainerVisible(arg_9_0, arg_9_1)
	if arg_9_0.preIsShow == arg_9_1 then
		return
	end

	arg_9_0.preIsShow = arg_9_1

	if arg_9_0.preIsShow then
		AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_unlock)
	end

	gohelper.setActive(arg_9_0._goherocontainer, arg_9_1)
	gohelper.setActive(arg_9_0._gomapcontainer, not arg_9_1)
end

function var_0_0.onDispatchFinish(arg_10_0)
	arg_10_0:refreshHeroContainer()
end

function var_0_0.onRemoveDispatchInfo(arg_11_0, arg_11_1)
	if arg_11_1 ~= arg_11_0.dispatchId then
		return
	end

	VersionActivity1_5HeroListModel.instance:resetSelectHeroList()
	arg_11_0:onDispatchInfoChange()
end

function var_0_0.onAddDispatchInfo(arg_12_0, arg_12_1)
	if arg_12_1 ~= arg_12_0.dispatchId then
		return
	end

	arg_12_0:changeHeroContainerVisible(false)
	arg_12_0:onDispatchInfoChange()
end

function var_0_0.onDispatchInfoChange(arg_13_0)
	arg_13_0:changeDispatchStatus()

	if arg_13_0.status == VersionActivity1_5DungeonEnum.DispatchStatus.Finished then
		arg_13_0:closeThis()

		return
	end

	arg_13_0:refreshHeroContainer()
	arg_13_0:refreshSelectedHero()
	arg_13_0:refreshCostTime()
	arg_13_0:refreshBtn()
end

function var_0_0.onSelectHeroMoChange(arg_14_0)
	arg_14_0:refreshStartBtnGray()
	arg_14_0:refreshCostTime()
end

function var_0_0.onOpen(arg_15_0)
	arg_15_0.dispatchId = arg_15_0.viewParam.dispatchId
	arg_15_0.dispatchCo = VersionActivity1_5DungeonConfig.instance:getDispatchCo(arg_15_0.dispatchId)

	arg_15_0:changeDispatchStatus()

	if arg_15_0.status == VersionActivity1_5DungeonEnum.DispatchStatus.Finished then
		arg_15_0:closeThis()

		return
	end

	VersionActivity1_5HeroListModel.instance:onOpenDispatchView(arg_15_0.dispatchCo)
	arg_15_0:initSelectedHeroItem()
	arg_15_0:refreshUI()
end

function var_0_0.initSelectedHeroItem(arg_16_0)
	arg_16_0.selectedHeroItemList = {}

	for iter_16_0 = 1, 4 do
		local var_16_0 = gohelper.findChild(arg_16_0.viewGO, "container/right/selectedherocontainer/herocontainer/go_selectheroitem" .. iter_16_0)

		if iter_16_0 <= arg_16_0.dispatchCo.maxCount then
			table.insert(arg_16_0.selectedHeroItemList, VersionActivity1_5DispatchSelectHeroItem.createItem(var_16_0, iter_16_0))
		else
			gohelper.setActive(var_16_0, false)
		end
	end
end

function var_0_0.refreshUI(arg_17_0)
	arg_17_0:refreshLeft()
	arg_17_0:refreshRight()
end

function var_0_0.refreshLeft(arg_18_0)
	arg_18_0:refreshMap()
	arg_18_0:refreshHeroContainer()
end

function var_0_0.refreshRight(arg_19_0)
	arg_19_0._txttitle.text = arg_19_0.dispatchCo.title
	arg_19_0._txtdesc.text = arg_19_0.dispatchCo.desc

	arg_19_0:refreshSelectedHero()
	arg_19_0:refreshCostTime()
	arg_19_0:refreshBtn()
end

function var_0_0.refreshMap(arg_20_0)
	arg_20_0._simagemap:LoadImage(ResUrl.getV1a5DungeonSingleBg("paiqian/v1a5_dungeon_img_chahua_" .. arg_20_0.dispatchCo.image))
end

function var_0_0.refreshHeroContainer(arg_21_0)
	VersionActivity1_5HeroListModel.instance:refreshHero()
end

function var_0_0.refreshSelectedHero(arg_22_0)
	for iter_22_0, iter_22_1 in ipairs(arg_22_0.selectedHeroItemList) do
		iter_22_1:refreshUI()
	end
end

function var_0_0.refreshCostTime(arg_23_0)
	if arg_23_0.status == VersionActivity1_5DungeonEnum.DispatchStatus.Finished then
		logError("dispatch finished")

		return
	end

	if arg_23_0.status == VersionActivity1_5DungeonEnum.DispatchStatus.Dispatching then
		if arg_23_0.dispatchMo:isFinish() then
			arg_23_0:closeThis()

			return
		end

		gohelper.setActive(arg_23_0._gotimelock, false)

		arg_23_0._txtcosttime.text = arg_23_0.dispatchMo:getRemainTimeStr()

		return
	end

	local var_23_0 = string.splitToNumber(arg_23_0.dispatchCo.time, "|")
	local var_23_1 = var_23_0[1]
	local var_23_2 = var_0_0.DarkColor
	local var_23_3 = arg_23_0.checkShortedTimeFuncDict[arg_23_0.dispatchCo.shortType]

	if var_23_3 and var_23_3(arg_23_0) then
		var_23_1 = var_23_1 - var_23_0[2]
		var_23_2 = var_0_0.LightColor

		gohelper.setActive(arg_23_0._gotimelock, false)
	else
		gohelper.setActive(arg_23_0._gotimelock, true)
	end

	local var_23_4 = Mathf.Floor(var_23_1 / TimeUtil.OneHourSecond)
	local var_23_5 = var_23_1 % TimeUtil.OneHourSecond
	local var_23_6 = Mathf.Floor(var_23_5 / TimeUtil.OneMinuteSecond)
	local var_23_7 = var_23_5 % TimeUtil.OneMinuteSecond
	local var_23_8

	if LangSettings.instance:isEn() then
		var_23_8 = string.format("%s%s%s %s%s %s%s", luaLang("dispatch_cost_time"), var_23_4, luaLang("time_hour"), var_23_6, luaLang("time_minute"), var_23_7, luaLang("time_second"))
	else
		var_23_8 = string.format("%s%s%s%s%s%s%s", luaLang("dispatch_cost_time"), var_23_4, luaLang("time_hour"), var_23_6, luaLang("time_minute"), var_23_7, luaLang("time_second"))
	end

	arg_23_0._txtcosttime.text = string.format("<color=%s>%s</color>", var_23_2, var_23_8)
end

function var_0_0.checkCareer(arg_24_0)
	local var_24_0 = VersionActivity1_5HeroListModel.instance:getSelectedHeroList()

	if not var_24_0 or #var_24_0 == 0 then
		return false
	end

	local var_24_1 = string.splitToNumber(arg_24_0.dispatchCo.extraParam, "|")
	local var_24_2 = var_24_1[1]
	local var_24_3 = var_24_1[2]
	local var_24_4 = 0

	for iter_24_0, iter_24_1 in ipairs(var_24_0) do
		if iter_24_1.config.career == var_24_3 then
			var_24_4 = var_24_4 + 1
		end
	end

	return var_24_2 <= var_24_4
end

function var_0_0.checkHeroID(arg_25_0)
	local var_25_0 = VersionActivity1_5HeroListModel.instance:getSelectedHeroList()

	if not var_25_0 then
		return false
	end

	local var_25_1 = string.split(arg_25_0.dispatchCo.extraParam, "|")
	local var_25_2 = tonumber(var_25_1[1])
	local var_25_3 = string.splitToNumber(var_25_1[2], "#")
	local var_25_4 = 0

	for iter_25_0, iter_25_1 in ipairs(var_25_0) do
		if tabletool.indexOf(var_25_3, iter_25_1.heroId) then
			var_25_4 = var_25_4 + 1
		end
	end

	return var_25_2 <= var_25_4
end

function var_0_0.refreshBtn(arg_26_0)
	gohelper.setActive(arg_26_0._btnstartdispatch.gameObject, arg_26_0.status == VersionActivity1_5DungeonEnum.DispatchStatus.NotDispatch)
	gohelper.setActive(arg_26_0._btninterruptdispatch.gameObject, arg_26_0.status == VersionActivity1_5DungeonEnum.DispatchStatus.Dispatching)
	arg_26_0:refreshStartBtnGray()
end

function var_0_0.refreshStartBtnGray(arg_27_0)
	if arg_27_0.status == VersionActivity1_5DungeonEnum.DispatchStatus.NotDispatch then
		local var_27_0 = VersionActivity1_5HeroListModel.instance:getSelectedHeroCount()

		ZProj.UGUIHelper.SetGrayscale(arg_27_0._btnstartdispatch.gameObject, var_27_0 < arg_27_0.dispatchCo.minCount)
	end
end

function var_0_0.changeDispatchStatus(arg_28_0)
	arg_28_0.status = VersionActivity1_5DungeonModel.instance:getDispatchStatus(arg_28_0.dispatchId)
	arg_28_0.dispatchMo = VersionActivity1_5DungeonModel.instance:getDispatchMo(arg_28_0.dispatchId)

	VersionActivity1_5HeroListModel.instance:setDispatchViewStatus(arg_28_0.status)
end

function var_0_0.everySecondCall(arg_29_0)
	if arg_29_0.status == VersionActivity1_5DungeonEnum.DispatchStatus.Dispatching then
		arg_29_0:refreshCostTime()
	end
end

function var_0_0.onClose(arg_30_0)
	arg_30_0:removeEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.ChangeDispatchHeroContainerEvent, arg_30_0.changeHeroContainerVisible, arg_30_0)
	arg_30_0:removeEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.AddDispatchInfo, arg_30_0.onAddDispatchInfo, arg_30_0)
	arg_30_0:removeEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.RemoveDispatchInfo, arg_30_0.onRemoveDispatchInfo, arg_30_0)
	arg_30_0:removeEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnDispatchFinish, arg_30_0.onDispatchFinish, arg_30_0)
	arg_30_0:removeEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.ChangeSelectedHero, arg_30_0.onSelectHeroMoChange, arg_30_0)
	VersionActivity1_5HeroListModel.instance:onCloseDispatchView()
	TaskDispatcher.cancelTask(arg_30_0.everySecondCall, arg_30_0)
end

function var_0_0.onDestroyView(arg_31_0)
	arg_31_0.backClick:RemoveClickListener()
	arg_31_0.closeClick:RemoveClickListener()
	arg_31_0.heroCloseClick:RemoveClickListener()
	arg_31_0.simagebg:UnLoadImage()
	arg_31_0._simagemap:UnLoadImage()

	for iter_31_0, iter_31_1 in ipairs(arg_31_0.selectedHeroItemList) do
		iter_31_1:destroy()
	end

	arg_31_0.selectedHeroItemList = nil
end

return var_0_0
