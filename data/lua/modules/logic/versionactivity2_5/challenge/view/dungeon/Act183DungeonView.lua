module("modules.logic.versionactivity2_5.challenge.view.dungeon.Act183DungeonView", package.seeall)

local var_0_0 = class("Act183DungeonView", BaseView)
local var_0_1 = 30
local var_0_2 = 0.1

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "root/#go_topleft")
	arg_1_0._scrollgroups = gohelper.findChildScrollRect(arg_1_0.viewGO, "root/left/#scroll_groups")
	arg_1_0._gogroupitem = gohelper.findChild(arg_1_0.viewGO, "root/left/#scroll_groups/Viewport/Content/#go_groupitem")
	arg_1_0._btntask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/left/#btn_task")
	arg_1_0._gotaskreddot = gohelper.findChild(arg_1_0.viewGO, "root/left/#btn_task/#go_taskreddot")
	arg_1_0._goepisodecontainer = gohelper.findChild(arg_1_0.viewGO, "root/middle/#go_episodecontainer")
	arg_1_0._gonormalepisode = gohelper.findChild(arg_1_0.viewGO, "root/middle/#go_episodecontainer/#go_normalepisode")
	arg_1_0._gobossepisode = gohelper.findChild(arg_1_0.viewGO, "root/middle/#go_episodecontainer/#go_bossepisode")
	arg_1_0._godailyepisode = gohelper.findChild(arg_1_0.viewGO, "root/middle/#go_episodecontainer/#go_dailyepisode")
	arg_1_0._goprogresslist = gohelper.findChild(arg_1_0.viewGO, "root/top/bar/#go_progresslist")
	arg_1_0._goprogressitem = gohelper.findChild(arg_1_0.viewGO, "root/top/bar/#go_progresslist/#go_progressitem")
	arg_1_0._btnreset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/top/bar/#go_progresslist/#btn_reset")
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "root/right/#go_normal")
	arg_1_0._gohard = gohelper.findChild(arg_1_0.viewGO, "root/right/#go_hard")
	arg_1_0._scrolldetail = gohelper.findChildScrollRect(arg_1_0.viewGO, "root/right/#scroll_detail")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "root/right/#go_detail/title/#txt_title")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/top/#txt_desc")
	arg_1_0._txtadditionrule = gohelper.findChildText(arg_1_0.viewGO, "root/right/#scroll_detail/Viewport/Content/#txt_additionrule")
	arg_1_0._gobaserulecontainer = gohelper.findChild(arg_1_0.viewGO, "root/right/#scroll_detail/Viewport/Content/baserules/#go_baserulecontainer")
	arg_1_0._gobaseruleitem = gohelper.findChild(arg_1_0.viewGO, "root/right/#scroll_detail/Viewport/Content/baserules/#go_baserulecontainer/#go_baseruleitem")
	arg_1_0._goescaperulecontainer = gohelper.findChild(arg_1_0.viewGO, "root/right/#scroll_detail/Viewport/Content/escaperules/#go_escaperulecontainer")
	arg_1_0._goescaperuleitem = gohelper.findChild(arg_1_0.viewGO, "root/right/#scroll_detail/Viewport/Content/escaperules/#go_escaperulecontainer/#go_escaperuleitem")
	arg_1_0._btnstart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/right/#go_detail/#btn_start")
	arg_1_0._btnrestart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/right/#go_detail/#btn_restart")
	arg_1_0._simagehardbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/#simage_HardBG")
	arg_1_0._gocompleted = gohelper.findChild(arg_1_0.viewGO, "root/middle/#go_Completed")
	arg_1_0._godailycompleted = gohelper.findChild(arg_1_0.viewGO, "root/middle/#go_DailyCompleted")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btntask:AddClickListener(arg_2_0._btntaskOnClick, arg_2_0)
	arg_2_0._btnreset:AddClickListener(arg_2_0._btnresetOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btntask:RemoveClickListener()
	arg_3_0._btnreset:RemoveClickListener()
end

function var_0_0._btntaskOnClick(arg_4_0)
	local var_4_0 = arg_4_0._groupMo and arg_4_0._groupMo:getGroupType()
	local var_4_1 = arg_4_0._groupMo and arg_4_0._groupMo:getGroupId()
	local var_4_2 = {
		selectGroupType = var_4_0,
		selectGroupId = var_4_1
	}

	Act183Controller.instance:openAct183TaskView(var_4_2)
end

function var_0_0._btnresetOnClick(arg_5_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.Act183ResetGroupEpisode, MsgBoxEnum.BoxType.Yes_No, arg_5_0._resetConfirmCallBack, nil, nil, arg_5_0)
end

function var_0_0._resetConfirmCallBack(arg_6_0)
	Act183Controller.instance:resetGroupEpisode(arg_6_0._actId, arg_6_0._selectGroupId)
end

function var_0_0._onUpdateGroupInfo(arg_7_0)
	arg_7_0:refresh()
end

function var_0_0._onClickSwitchGroup(arg_8_0, arg_8_1)
	if arg_8_0._selectGroupId == arg_8_1 then
		return
	end

	arg_8_0._selectGroupId = arg_8_1

	arg_8_0._animator:Play("modeswitch", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.UI.Act183_SwitchGroup)
	TaskDispatcher.cancelTask(arg_8_0.refresh, arg_8_0)
	TaskDispatcher.runDelay(arg_8_0.refresh, arg_8_0, var_0_2)
end

function var_0_0._onSelectEpisode(arg_9_0, arg_9_1)
	arg_9_0._selectEpisodeId = arg_9_1
end

function var_0_0._editableInitView(arg_10_0)
	arg_10_0._groupItemTab = arg_10_0:getUserDataTb_()
	arg_10_0._episodeItemTab = arg_10_0:getUserDataTb_()
	arg_10_0._progressItemTab = arg_10_0:getUserDataTb_()
	arg_10_0._actId = Act183Model.instance:getActivityId()
	arg_10_0._actInfo = Act183Model.instance:getActInfo()
	arg_10_0._gogroupcontent = gohelper.findChild(arg_10_0.viewGO, "root/left/#scroll_groups/Viewport/Content")

	RedDotController.instance:addRedDot(arg_10_0._gotaskreddot, RedDotEnum.DotNode.V2a5_Act183Task)
	arg_10_0:addEventCb(Act183Controller.instance, Act183Event.OnUpdateGroupInfo, arg_10_0._onUpdateGroupInfo, arg_10_0)
	arg_10_0:addEventCb(Act183Controller.instance, Act183Event.OnClickSwitchGroup, arg_10_0._onClickSwitchGroup, arg_10_0)
	arg_10_0:addEventCb(Act183Controller.instance, Act183Event.OnClickEpisode, arg_10_0._onSelectEpisode, arg_10_0)

	arg_10_0._animator = gohelper.onceAddComponent(arg_10_0.viewGO, gohelper.Type_Animator)
end

function var_0_0.onOpen(arg_11_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Act183_SwitchGroup)
	arg_11_0:init()
end

function var_0_0.onUpdateParam(arg_12_0)
	arg_12_0:destroyEpisodeItems()
	arg_12_0:destroyGroupItems()

	arg_12_0._groupItemTab = arg_12_0:getUserDataTb_()
	arg_12_0._episodeItemTab = arg_12_0:getUserDataTb_()

	arg_12_0:init()
end

function var_0_0.init(arg_13_0)
	arg_13_0:initViewParams()
	arg_13_0:initGroupItems()
	arg_13_0:refresh()
	arg_13_0:tickRefreshGroupItems()
	arg_13_0:addGuide()
end

function var_0_0.onOpenFinish(arg_14_0)
	arg_14_0:focusGroupCategory()
	Act183Controller.instance:dispatchEvent(Act183Event.OnInitDungeonDone)
end

function var_0_0.initViewParams(arg_15_0)
	arg_15_0._groupTypes = arg_15_0.viewParam and arg_15_0.viewParam.groupTypes or {
		Act183Enum.GroupType.NormalMain
	}
	arg_15_0._groupList = {}

	for iter_15_0, iter_15_1 in ipairs(arg_15_0._groupTypes) do
		local var_15_0 = arg_15_0._actInfo:getGroupEpisodeMos(iter_15_1)

		tabletool.addValues(arg_15_0._groupList, var_15_0)
	end

	arg_15_0._selectGroupId = arg_15_0.viewParam and arg_15_0.viewParam.selectGroupId

	if not arg_15_0._selectGroupId then
		arg_15_0._firstGroupMo = arg_15_0._groupList and arg_15_0._groupList[1]
		arg_15_0._selectGroupId = arg_15_0._firstGroupMo:getGroupId()
	end

	arg_15_0._groupType = arg_15_0._actInfo:getGroupEpisodeMo(arg_15_0._selectGroupId):getGroupType()

	local var_15_1 = arg_15_0.viewParam and arg_15_0.viewParam.selectEpisodeId

	arg_15_0._selectEpisodeId = arg_15_0._selectEpisodeId or var_15_1
end

function var_0_0.initGroupItems(arg_16_0)
	if arg_16_0._groupList then
		for iter_16_0, iter_16_1 in ipairs(arg_16_0._groupList) do
			local var_16_0 = iter_16_1:getStatus()

			if arg_16_0._groupType == Act183Enum.GroupType.Daily and var_16_0 == Act183Enum.GroupStatus.Locked then
				break
			end

			local var_16_1 = iter_16_1:getGroupType()
			local var_16_2 = arg_16_0:_getOrCreateGroupItem(iter_16_0, var_16_1)
			local var_16_3 = iter_16_1:getGroupId()

			var_16_2:onUpdateMO(iter_16_1, iter_16_0)
			var_16_2:onSelect(var_16_3 == arg_16_0._selectGroupId)
		end
	end
end

function var_0_0._getOrCreateGroupItem(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_0._groupItemTab[arg_17_1]

	if not var_17_0 then
		local var_17_1 = gohelper.cloneInPlace(arg_17_0._gogroupitem, "groupitem_" .. arg_17_1)
		local var_17_2 = Act183Enum.GroupCategoryClsType[arg_17_2]

		var_17_0 = MonoHelper.addLuaComOnceToGo(var_17_1, var_17_2)
		arg_17_0._groupItemTab[arg_17_1] = var_17_0
	end

	return var_17_0
end

function var_0_0.destroyGroupItems(arg_18_0, arg_18_1)
	for iter_18_0, iter_18_1 in pairs(arg_18_0._groupItemTab) do
		if not arg_18_1 or not arg_18_1[iter_18_1] then
			iter_18_1:destroySelf()
		end
	end
end

function var_0_0.tickRefreshGroupItems(arg_19_0)
	if arg_19_0._groupType ~= Act183Enum.GroupType.Daily then
		TaskDispatcher.cancelTask(arg_19_0.checkRefreshGroupItems, arg_19_0)

		return
	end

	TaskDispatcher.cancelTask(arg_19_0.checkRefreshGroupItems, arg_19_0)
	TaskDispatcher.runRepeat(arg_19_0.checkRefreshGroupItems, arg_19_0, var_0_1)
end

function var_0_0.checkRefreshGroupItems(arg_20_0)
	arg_20_0:initGroupItems()
end

function var_0_0.refresh(arg_21_0)
	arg_21_0:refreshInfo()
	arg_21_0:refreshEpisodes()
	arg_21_0:refreshProgress()
	arg_21_0:refreshCompletedUI()
end

function var_0_0.refreshInfo(arg_22_0)
	arg_22_0._groupMo = arg_22_0._actInfo and arg_22_0._actInfo:getGroupEpisodeMo(arg_22_0._selectGroupId)
	arg_22_0._groupType = arg_22_0._groupMo and arg_22_0._groupMo:getGroupType()

	gohelper.setActive(arg_22_0._simagehardbg.gameObject, arg_22_0._groupType == Act183Enum.GroupType.HardMain)
end

function var_0_0.getGroupStatus(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0._actInfo and arg_23_0._actInfo:getGroupEpisodeMo(arg_23_1)

	return var_23_0 and var_23_0:getStatus()
end

function var_0_0.refreshEpisodes(arg_24_0)
	if not arg_24_0._groupMo then
		return
	end

	local var_24_0 = {}
	local var_24_1 = arg_24_0._groupMo:getEpisodeMos()

	for iter_24_0, iter_24_1 in ipairs(var_24_1) do
		local var_24_2 = iter_24_1:getEpisodeId()
		local var_24_3 = arg_24_0:_getOrCreeateEpisodeItem(iter_24_1)

		var_24_3:onUpdateMo(iter_24_1)
		var_24_3:onSelect(var_24_2 == arg_24_0._selectEpisodeId)

		var_24_0[var_24_3] = true
	end

	arg_24_0:destroyEpisodeItems(var_24_0)
end

function var_0_0.destroyEpisodeItems(arg_25_0, arg_25_1)
	for iter_25_0, iter_25_1 in pairs(arg_25_0._episodeItemTab) do
		if not arg_25_1 or not arg_25_1[iter_25_1] then
			iter_25_1:destroySelf()
		end
	end
end

function var_0_0._getOrCreeateEpisodeItem(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_1:getConfig().order
	local var_26_1 = arg_26_0._episodeItemTab and arg_26_0._episodeItemTab[var_26_0]

	if not var_26_1 then
		var_26_1 = Act183BaseEpisodeItem.Get(arg_26_0.viewGO, arg_26_1)
		arg_26_0._episodeItemTab[var_26_0] = var_26_1
	end

	return var_26_1
end

function var_0_0.getEpisodeItemTab(arg_27_0)
	return arg_27_0._episodeItemTab
end

function var_0_0._getEpisodeItemParent(arg_28_0, arg_28_1)
	local var_28_0 = gohelper.findChild(arg_28_0.viewGO, arg_28_1)

	if gohelper.isNil(var_28_0) then
		logError(string.format("关卡挂点不存在, 挂点路径: %s", arg_28_1))
	end

	return var_28_0
end

function var_0_0.refreshProgress(arg_29_0)
	local var_29_0 = arg_29_0._groupMo:getEpisodeMos()

	arg_29_0._episodeCount = var_29_0 and #var_29_0 or 0
	arg_29_0._episodeFinishCount = arg_29_0._groupMo:getEpisodeFinishCount()

	local var_29_1 = {}

	if var_29_0 then
		for iter_29_0, iter_29_1 in ipairs(var_29_0) do
			local var_29_2 = arg_29_0:_getOrCreateProgressItem(iter_29_0)

			arg_29_0:refreshEpisodeProgress(var_29_2, iter_29_1, iter_29_0)

			var_29_1[var_29_2] = true
		end
	end

	for iter_29_2, iter_29_3 in pairs(arg_29_0._progressItemTab) do
		if not var_29_1[iter_29_3] then
			gohelper.setActive(iter_29_3.viewGO, false)
		end
	end

	gohelper.setAsLastSibling(arg_29_0._btnreset.gameObject)
end

function var_0_0.refreshCompletedUI(arg_30_0)
	local var_30_0 = arg_30_0._groupMo:isGroupFinished()
	local var_30_1 = false

	if var_30_0 then
		local var_30_2 = arg_30_0._groupMo:getGroupId()

		var_30_1 = Act183Model.instance:getNewFinishGroupId() == var_30_2
	end

	local var_30_3 = arg_30_0._groupMo and arg_30_0._groupMo:getGroupType()

	gohelper.setActive(arg_30_0._gocompleted, var_30_0 and var_30_3 ~= Act183Enum.GroupType.Daily and not var_30_1)
	gohelper.setActive(arg_30_0._godailycompleted, var_30_0 and var_30_3 == Act183Enum.GroupType.Daily and not var_30_1)
end

function var_0_0._getOrCreateProgressItem(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_0._progressItemTab[arg_31_1]

	if not var_31_0 then
		var_31_0 = arg_31_0:getUserDataTb_()
		var_31_0.viewGO = gohelper.cloneInPlace(arg_31_0._goprogressitem, "item_" .. arg_31_1)
		var_31_0.goicon1 = gohelper.findChild(var_31_0.viewGO, "icon")
		var_31_0.goicon2 = gohelper.findChild(var_31_0.viewGO, "icon2")
		var_31_0.goicon3 = gohelper.findChild(var_31_0.viewGO, "icon3")
		arg_31_0._progressItemTab[arg_31_1] = var_31_0
	end

	return var_31_0
end

function var_0_0.refreshEpisodeProgress(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	gohelper.setActive(arg_32_1.viewGO, true)
	gohelper.setActive(arg_32_1.goicon1, false)
	gohelper.setActive(arg_32_1.goicon2, false)
	gohelper.setActive(arg_32_1.goicon3, false)

	if arg_32_3 <= arg_32_0._episodeFinishCount then
		gohelper.setActive(arg_32_1.goicon2, true)
	elseif arg_32_3 == arg_32_0._episodeFinishCount + 1 then
		gohelper.setActive(arg_32_1.goicon3, true)
	else
		gohelper.setActive(arg_32_1.goicon1, true)
	end
end

function var_0_0.focusGroupCategory(arg_33_0)
	local var_33_0 = 0
	local var_33_1 = false

	if arg_33_0._selectGroupId and arg_33_0._groupList then
		for iter_33_0, iter_33_1 in ipairs(arg_33_0._groupList) do
			if iter_33_1:getGroupId() == arg_33_0._selectGroupId then
				var_33_1 = true

				break
			end

			var_33_0 = var_33_0 + arg_33_0:_getOrCreateGroupItem(iter_33_0):getHeight()
		end
	end

	ZProj.UGUIHelper.RebuildLayout(arg_33_0._gogroupcontent.transform)

	local var_33_2 = recthelper.getHeight(arg_33_0._scrollgroups.transform)
	local var_33_3 = recthelper.getHeight(arg_33_0._gogroupcontent.transform)
	local var_33_4 = var_33_1 and var_33_0 or 0

	arg_33_0._scrollgroups.verticalNormalizedPosition = 1 - var_33_4 / (var_33_3 - var_33_2)
end

function var_0_0.addGuide(arg_34_0)
	if arg_34_0._groupType == Act183Enum.GroupType.NormalMain then
		local var_34_0 = HelpShowView.New()

		var_34_0:setHelpId(HelpEnum.HelpId.Act183EnterDungeon)
		arg_34_0:addChildView(var_34_0)
	end
end

function var_0_0.onClose(arg_35_0)
	TaskDispatcher.cancelTask(arg_35_0.refresh, arg_35_0)
	TaskDispatcher.cancelTask(arg_35_0.checkRefreshGroupItems, arg_35_0)
end

function var_0_0.onDestroyView(arg_36_0)
	return
end

return var_0_0
