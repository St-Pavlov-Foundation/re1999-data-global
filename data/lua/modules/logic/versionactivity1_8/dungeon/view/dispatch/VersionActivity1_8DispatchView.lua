module("modules.logic.versionactivity1_8.dungeon.view.dispatch.VersionActivity1_8DispatchView", package.seeall)

local var_0_0 = class("VersionActivity1_8DispatchView", BaseView)
local var_0_1 = 4
local var_0_2 = "#3d5a4a"
local var_0_3 = "#287B4D"

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goback = gohelper.findChild(arg_1_0.viewGO, "#go_back")
	arg_1_0.backClick = gohelper.getClick(arg_1_0._goback)
	arg_1_0._gomapcontainer = gohelper.findChild(arg_1_0.viewGO, "container/left/#go_mapcontainer")
	arg_1_0._simagemap = gohelper.findChildSingleImage(arg_1_0.viewGO, "container/left/#go_mapcontainer/#simage_map")
	arg_1_0._goherocontainer = gohelper.findChild(arg_1_0.viewGO, "container/left/#go_herocontainer")
	arg_1_0._goclosehero = gohelper.findChild(arg_1_0.viewGO, "container/left/#go_herocontainer/header/#go_closehero")
	arg_1_0.heroCloseClick = gohelper.getClickWithAudio(arg_1_0._goclosehero, AudioEnum.UI.play_ui_rolesopen)
	arg_1_0._goclose = gohelper.findChild(arg_1_0.viewGO, "container/right/#go_close")
	arg_1_0.closeClick = gohelper.getClickWithAudio(arg_1_0._goclose, AudioEnum.UI.play_ui_rolesopen)
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "container/right/Scroll View/Viewport/Content/#txt_desc")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "container/right/#txt_title")
	arg_1_0._txtcosttime = gohelper.findChildText(arg_1_0.viewGO, "container/right/#txt_costtime")
	arg_1_0._gotimelock = gohelper.findChild(arg_1_0.viewGO, "container/right/#txt_costtime/locked")
	arg_1_0._btninterruptdispatch = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "container/right/#btn_interruptdispatch")
	arg_1_0._btnstartdispatch = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "container/right/#btn_startdispatch")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0.backClick:AddClickListener(arg_2_0.closeThis, arg_2_0)
	arg_2_0.closeClick:AddClickListener(arg_2_0.closeThis, arg_2_0)
	arg_2_0.heroCloseClick:AddClickListener(arg_2_0.onClickHeroClose, arg_2_0)
	arg_2_0._btnstartdispatch:AddClickListener(arg_2_0._btnstartdispatchOnClick, arg_2_0)
	arg_2_0._btninterruptdispatch:AddClickListener(arg_2_0._btninterruptdispatchOnClick, arg_2_0)
	arg_2_0:addEventCb(DispatchController.instance, DispatchEvent.ChangeDispatchHeroContainerEvent, arg_2_0.changeHeroContainerVisible, arg_2_0)
	arg_2_0:addEventCb(DispatchController.instance, DispatchEvent.AddDispatchInfo, arg_2_0.onAddDispatchInfo, arg_2_0)
	arg_2_0:addEventCb(DispatchController.instance, DispatchEvent.RemoveDispatchInfo, arg_2_0.onRemoveDispatchInfo, arg_2_0)
	arg_2_0:addEventCb(DispatchController.instance, DispatchEvent.OnDispatchFinish, arg_2_0.onDispatchFinish, arg_2_0)
	arg_2_0:addEventCb(DispatchController.instance, DispatchEvent.ChangeSelectedHero, arg_2_0.onSelectHeroMoChange, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0.backClick:RemoveClickListener()
	arg_3_0.closeClick:RemoveClickListener()
	arg_3_0.heroCloseClick:RemoveClickListener()
	arg_3_0._btnstartdispatch:RemoveClickListener()
	arg_3_0._btninterruptdispatch:RemoveClickListener()
	arg_3_0:removeEventCb(DispatchController.instance, DispatchEvent.ChangeDispatchHeroContainerEvent, arg_3_0.changeHeroContainerVisible, arg_3_0)
	arg_3_0:removeEventCb(DispatchController.instance, DispatchEvent.AddDispatchInfo, arg_3_0.onAddDispatchInfo, arg_3_0)
	arg_3_0:removeEventCb(DispatchController.instance, DispatchEvent.RemoveDispatchInfo, arg_3_0.onRemoveDispatchInfo, arg_3_0)
	arg_3_0:removeEventCb(DispatchController.instance, DispatchEvent.OnDispatchFinish, arg_3_0.onDispatchFinish, arg_3_0)
	arg_3_0:removeEventCb(DispatchController.instance, DispatchEvent.ChangeSelectedHero, arg_3_0.onSelectHeroMoChange, arg_3_0)
end

function var_0_0.onClickHeroClose(arg_4_0)
	DispatchController.instance:dispatchEvent(DispatchEvent.ChangeDispatchHeroContainerEvent, false)
end

function var_0_0._btnstartdispatchOnClick(arg_5_0)
	if arg_5_0.status ~= DispatchEnum.DispatchStatus.NotDispatch then
		return
	end

	local var_5_0 = false

	if arg_5_0.dispatchCo then
		var_5_0 = DispatchHeroListModel.instance:getSelectedHeroCount() >= arg_5_0.dispatchCo.minCount
	end

	if not var_5_0 then
		GameFacade.showToast(ToastEnum.V1a5_DungeonDispatchLessMinHero)

		return
	end

	local var_5_1 = DispatchHeroListModel.instance:getSelectedHeroIdList()

	DispatchRpc.instance:sendDispatchRequest(arg_5_0.elementId, arg_5_0.dispatchId, var_5_1, arg_5_0.onDispatchSuccess, arg_5_0)
end

function var_0_0.onDispatchSuccess(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if arg_6_2 ~= 0 then
		return
	end

	GameFacade.showToast(ToastEnum.V1a5_DungeonDispatchSuccess)
	arg_6_0:updateAct157Info()
end

function var_0_0._btninterruptdispatchOnClick(arg_7_0)
	if arg_7_0.status ~= DispatchEnum.DispatchStatus.Dispatching then
		return
	end

	if arg_7_0.dispatchMo and arg_7_0.dispatchMo:isFinish() then
		return
	end

	DispatchRpc.instance:sendInterruptDispatchRequest(arg_7_0.elementId, arg_7_0.dispatchId, arg_7_0.updateAct157Info, arg_7_0)
end

function var_0_0.updateAct157Info(arg_8_0)
	Activity157Controller.instance:getAct157ActInfo()
end

function var_0_0.onAddDispatchInfo(arg_9_0, arg_9_1)
	if arg_9_1 ~= arg_9_0.dispatchId then
		return
	end

	arg_9_0:changeHeroContainerVisible(false)
	arg_9_0:onDispatchInfoChange()
end

function var_0_0.onRemoveDispatchInfo(arg_10_0, arg_10_1)
	if arg_10_1 ~= arg_10_0.dispatchId then
		return
	end

	DispatchHeroListModel.instance:resetSelectHeroList()
	arg_10_0:onDispatchInfoChange()
end

function var_0_0.onDispatchInfoChange(arg_11_0)
	arg_11_0:changeDispatchStatus()

	if arg_11_0.status == DispatchEnum.DispatchStatus.Finished then
		arg_11_0:closeThis()

		return
	end

	arg_11_0:refreshHeroContainer()
	arg_11_0:refreshSelectedHero()
	arg_11_0:refreshCostTime()
	arg_11_0:refreshBtn()
end

function var_0_0.onDispatchFinish(arg_12_0)
	arg_12_0:refreshHeroContainer()
end

function var_0_0.onSelectHeroMoChange(arg_13_0)
	arg_13_0:refreshStartBtnGray()
	arg_13_0:refreshCostTime()
end

function var_0_0._editableInitView(arg_14_0)
	arg_14_0.checkShortedTimeFuncDict = {
		[DispatchEnum.DispatchShortedType.Career] = arg_14_0.checkCareer,
		[DispatchEnum.DispatchShortedType.HeroId] = arg_14_0.checkHeroID
	}

	arg_14_0:changeHeroContainerVisible(false)
	TaskDispatcher.runRepeat(arg_14_0.everySecondCall, arg_14_0, 1)
end

function var_0_0.changeHeroContainerVisible(arg_15_0, arg_15_1)
	if arg_15_0.preIsShow == arg_15_1 then
		return
	end

	arg_15_0.preIsShow = arg_15_1

	if arg_15_0.preIsShow then
		AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_unlock)
	end

	gohelper.setActive(arg_15_0._goherocontainer, arg_15_1)
	gohelper.setActive(arg_15_0._gomapcontainer, not arg_15_1)
end

function var_0_0.onUpdateParam(arg_16_0)
	return
end

function var_0_0.onOpen(arg_17_0)
	arg_17_0.elementId = arg_17_0.viewParam.elementId
	arg_17_0.dispatchId = arg_17_0.viewParam.dispatchId
	arg_17_0.dispatchCo = DungeonConfig.instance:getDispatchCfg(arg_17_0.dispatchId)

	arg_17_0:changeDispatchStatus()

	if arg_17_0.status == DispatchEnum.DispatchStatus.Finished then
		arg_17_0:closeThis()

		return
	end

	DispatchHeroListModel.instance:onOpenDispatchView(arg_17_0.dispatchCo, arg_17_0.elementId)
	arg_17_0:initSelectedHeroItem()
	arg_17_0:refreshUI()
end

function var_0_0.changeDispatchStatus(arg_18_0)
	arg_18_0.status = DispatchModel.instance:getDispatchStatus(arg_18_0.elementId, arg_18_0.dispatchId)
	arg_18_0.dispatchMo = DispatchModel.instance:getDispatchMo(arg_18_0.elementId, arg_18_0.dispatchId)

	DispatchHeroListModel.instance:setDispatchViewStatus(arg_18_0.status)
end

function var_0_0.initSelectedHeroItem(arg_19_0)
	arg_19_0.selectedHeroItemList = {}

	local var_19_0 = arg_19_0.dispatchCo and arg_19_0.dispatchCo.maxCount or 0

	for iter_19_0 = 1, var_0_1 do
		local var_19_1 = gohelper.findChild(arg_19_0.viewGO, "container/right/selectedherocontainer/herocontainer/go_selectheroitem" .. iter_19_0)

		if iter_19_0 <= var_19_0 then
			local var_19_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_19_1, VersionActivity1_8DispatchSelectHeroItem, iter_19_0)

			table.insert(arg_19_0.selectedHeroItemList, var_19_2)
		else
			gohelper.setActive(var_19_1, false)
		end
	end
end

function var_0_0.refreshUI(arg_20_0)
	if arg_20_0.dispatchCo then
		local var_20_0 = string.format("paiqian/v1a8_dungeon_img_map%s", arg_20_0.dispatchCo.image)
		local var_20_1 = ResUrl.getV1a8DungeonSingleBg(var_20_0)

		arg_20_0._simagemap:LoadImage(var_20_1)
	end

	arg_20_0:refreshHeroContainer()

	arg_20_0._txttitle.text = arg_20_0.dispatchCo and arg_20_0.dispatchCo.title or ""
	arg_20_0._txtdesc.text = arg_20_0.dispatchCo and arg_20_0.dispatchCo.desc or ""

	arg_20_0:refreshSelectedHero()
	arg_20_0:refreshCostTime()
	arg_20_0:refreshBtn()
end

function var_0_0.refreshHeroContainer(arg_21_0)
	DispatchHeroListModel.instance:refreshHero()
end

function var_0_0.refreshSelectedHero(arg_22_0)
	for iter_22_0, iter_22_1 in ipairs(arg_22_0.selectedHeroItemList) do
		iter_22_1:refreshUI()
	end
end

function var_0_0.refreshCostTime(arg_23_0)
	if arg_23_0.status == DispatchEnum.DispatchStatus.Finished then
		logError("dispatch finished")

		return
	end

	if arg_23_0.status == DispatchEnum.DispatchStatus.Dispatching then
		if arg_23_0.dispatchMo and arg_23_0.dispatchMo:isFinish() then
			arg_23_0:closeThis()

			return
		end

		gohelper.setActive(arg_23_0._gotimelock, false)

		arg_23_0._txtcosttime.text = arg_23_0.dispatchMo:getRemainTimeStr()

		return
	end

	local var_23_0 = var_0_2
	local var_23_1 = ""

	if arg_23_0.dispatchCo then
		local var_23_2 = string.splitToNumber(arg_23_0.dispatchCo.time, "|")
		local var_23_3 = var_23_2[1]
		local var_23_4 = arg_23_0.checkShortedTimeFuncDict[arg_23_0.dispatchCo.shortType]

		if var_23_4 and var_23_4(arg_23_0) then
			var_23_0 = var_0_3
			var_23_3 = var_23_3 - var_23_2[2]

			gohelper.setActive(arg_23_0._gotimelock, false)
		else
			gohelper.setActive(arg_23_0._gotimelock, true)
		end

		local var_23_5 = Mathf.Floor(var_23_3 / TimeUtil.OneHourSecond)
		local var_23_6 = var_23_3 % TimeUtil.OneHourSecond
		local var_23_7 = Mathf.Floor(var_23_6 / TimeUtil.OneMinuteSecond)
		local var_23_8 = var_23_6 % TimeUtil.OneMinuteSecond

		var_23_1 = GameUtil.getSubPlaceholderLuaLang(luaLang("dispatch_total_cost_time"), {
			var_23_5,
			var_23_7,
			var_23_8
		})
	else
		gohelper.setActive(arg_23_0._gotimelock, true)
	end

	arg_23_0._txtcosttime.text = string.format("<color=%s>%s</color>", var_23_0, var_23_1)
end

function var_0_0.checkCareer(arg_24_0)
	local var_24_0 = DispatchHeroListModel.instance:getSelectedHeroList()

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
	local var_25_0 = DispatchHeroListModel.instance:getSelectedHeroList()

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
	gohelper.setActive(arg_26_0._btnstartdispatch.gameObject, arg_26_0.status == DispatchEnum.DispatchStatus.NotDispatch)
	gohelper.setActive(arg_26_0._btninterruptdispatch.gameObject, arg_26_0.status == DispatchEnum.DispatchStatus.Dispatching)
	arg_26_0:refreshStartBtnGray()
end

function var_0_0.refreshStartBtnGray(arg_27_0)
	if arg_27_0.status ~= DispatchEnum.DispatchStatus.NotDispatch then
		return
	end

	local var_27_0 = false

	if arg_27_0.dispatchCo then
		var_27_0 = DispatchHeroListModel.instance:getSelectedHeroCount() >= arg_27_0.dispatchCo.minCount
	end

	ZProj.UGUIHelper.SetGrayscale(arg_27_0._btnstartdispatch.gameObject, not var_27_0)
end

function var_0_0.everySecondCall(arg_28_0)
	if arg_28_0.status == DispatchEnum.DispatchStatus.Dispatching then
		arg_28_0:refreshCostTime()
	end
end

function var_0_0.onClose(arg_29_0)
	TaskDispatcher.cancelTask(arg_29_0.everySecondCall, arg_29_0)
end

function var_0_0.onDestroyView(arg_30_0)
	arg_30_0._simagemap:UnLoadImage()

	if arg_30_0.selectedHeroItemList then
		for iter_30_0, iter_30_1 in ipairs(arg_30_0.selectedHeroItemList) do
			iter_30_1:destroy()
		end

		arg_30_0.selectedHeroItemList = nil
	end

	DispatchHeroListModel.instance:clear()
end

return var_0_0
