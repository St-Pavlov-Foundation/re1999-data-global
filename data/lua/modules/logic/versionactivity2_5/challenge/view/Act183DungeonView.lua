module("modules.logic.versionactivity2_5.challenge.view.Act183DungeonView", package.seeall)

slot0 = class("Act183DungeonView", BaseView)
slot1 = 30
slot2 = 0.1

function slot0.onInitView(slot0)
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "root/#go_topleft")
	slot0._scrollgroups = gohelper.findChildScrollRect(slot0.viewGO, "root/left/#scroll_groups")
	slot0._gogroupitem = gohelper.findChild(slot0.viewGO, "root/left/#scroll_groups/Viewport/Content/#go_groupitem")
	slot0._btntask = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/left/#btn_task")
	slot0._gotaskreddot = gohelper.findChild(slot0.viewGO, "root/left/#btn_task/#go_taskreddot")
	slot0._goepisodecontainer = gohelper.findChild(slot0.viewGO, "root/middle/#go_episodecontainer")
	slot0._gonormalepisode = gohelper.findChild(slot0.viewGO, "root/middle/#go_episodecontainer/#go_normalepisode")
	slot0._gobossepisode = gohelper.findChild(slot0.viewGO, "root/middle/#go_episodecontainer/#go_bossepisode")
	slot0._godailyepisode = gohelper.findChild(slot0.viewGO, "root/middle/#go_episodecontainer/#go_dailyepisode")
	slot0._goprogresslist = gohelper.findChild(slot0.viewGO, "root/top/bar/#go_progresslist")
	slot0._goprogressitem = gohelper.findChild(slot0.viewGO, "root/top/bar/#go_progresslist/#go_progressitem")
	slot0._btnreset = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/top/bar/#go_progresslist/#btn_reset")
	slot0._gonormal = gohelper.findChild(slot0.viewGO, "root/right/#go_normal")
	slot0._gohard = gohelper.findChild(slot0.viewGO, "root/right/#go_hard")
	slot0._scrolldetail = gohelper.findChildScrollRect(slot0.viewGO, "root/right/#scroll_detail")
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "root/right/#go_detail/title/#txt_title")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/top/#txt_desc")
	slot0._txtadditionrule = gohelper.findChildText(slot0.viewGO, "root/right/#scroll_detail/Viewport/Content/#txt_additionrule")
	slot0._gobaserulecontainer = gohelper.findChild(slot0.viewGO, "root/right/#scroll_detail/Viewport/Content/baserules/#go_baserulecontainer")
	slot0._gobaseruleitem = gohelper.findChild(slot0.viewGO, "root/right/#scroll_detail/Viewport/Content/baserules/#go_baserulecontainer/#go_baseruleitem")
	slot0._goescaperulecontainer = gohelper.findChild(slot0.viewGO, "root/right/#scroll_detail/Viewport/Content/escaperules/#go_escaperulecontainer")
	slot0._goescaperuleitem = gohelper.findChild(slot0.viewGO, "root/right/#scroll_detail/Viewport/Content/escaperules/#go_escaperulecontainer/#go_escaperuleitem")
	slot0._btnstart = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/right/#go_detail/#btn_start")
	slot0._btnrestart = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/right/#go_detail/#btn_restart")
	slot0._simagehardbg = gohelper.findChildSingleImage(slot0.viewGO, "root/#simage_HardBG")
	slot0._gocompleted = gohelper.findChild(slot0.viewGO, "root/middle/#go_Completed")
	slot0._godailycompleted = gohelper.findChild(slot0.viewGO, "root/middle/#go_DailyCompleted")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btntask:AddClickListener(slot0._btntaskOnClick, slot0)
	slot0._btnreset:AddClickListener(slot0._btnresetOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btntask:RemoveClickListener()
	slot0._btnreset:RemoveClickListener()
end

function slot0._btntaskOnClick(slot0)
	Act183Controller.instance:openAct183TaskView({
		selectGroupType = slot0._groupMo and slot0._groupMo:getGroupType(),
		selectGroupId = slot0._groupMo and slot0._groupMo:getGroupId()
	})
end

function slot0._btnresetOnClick(slot0)
	GameFacade.showMessageBox(MessageBoxIdDefine.Act183ResetGroupEpisode, MsgBoxEnum.BoxType.Yes_No, slot0._resetConfirmCallBack, nil, , slot0)
end

function slot0._resetConfirmCallBack(slot0)
	Act183Controller.instance:resetGroupEpisode(slot0._actId, slot0._selectGroupId)
end

function slot0._onUpdateGroupInfo(slot0)
	slot0:refresh()
end

function slot0._onClickSwitchGroup(slot0, slot1)
	if slot0._selectGroupId == slot1 then
		return
	end

	slot0._selectGroupId = slot1

	slot0._animator:Play("modeswitch", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.UI.Act183_SwitchGroup)
	TaskDispatcher.cancelTask(slot0.refresh, slot0)
	TaskDispatcher.runDelay(slot0.refresh, slot0, uv0)
end

function slot0._onSelectEpisode(slot0, slot1)
	slot0._selectEpisodeId = slot1
end

function slot0._editableInitView(slot0)
	slot0._groupItemTab = slot0:getUserDataTb_()
	slot0._episodeItemTab = slot0:getUserDataTb_()
	slot0._progressItemTab = slot0:getUserDataTb_()
	slot0._actId = Act183Model.instance:getActivityId()
	slot0._actInfo = Act183Model.instance:getActInfo()
	slot0._gogroupcontent = gohelper.findChild(slot0.viewGO, "root/left/#scroll_groups/Viewport/Content")

	RedDotController.instance:addRedDot(slot0._gotaskreddot, RedDotEnum.DotNode.V2a5_Act183Task)
	slot0:addEventCb(Act183Controller.instance, Act183Event.OnUpdateGroupInfo, slot0._onUpdateGroupInfo, slot0)
	slot0:addEventCb(Act183Controller.instance, Act183Event.OnClickSwitchGroup, slot0._onClickSwitchGroup, slot0)
	slot0:addEventCb(Act183Controller.instance, Act183Event.OnClickEpisode, slot0._onSelectEpisode, slot0)

	slot0._animator = gohelper.onceAddComponent(slot0.viewGO, gohelper.Type_Animator)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Act183_SwitchGroup)
	slot0:init()
end

function slot0.onUpdateParam(slot0)
	slot0:destroyEpisodeItems()
	slot0:destroyGroupItems()

	slot0._groupItemTab = slot0:getUserDataTb_()
	slot0._episodeItemTab = slot0:getUserDataTb_()

	slot0:init()
end

function slot0.init(slot0)
	slot0:initViewParams()
	slot0:initGroupItems()
	slot0:refresh()
	slot0:tickRefreshGroupItems()
	slot0:addGuide()
end

function slot0.onOpenFinish(slot0)
	slot0:focusGroupCategory()
	Act183Controller.instance:dispatchEvent(Act183Event.OnInitDungeonDone)
end

function slot0.initViewParams(slot0)
	slot0._groupTypes = slot0.viewParam and slot0.viewParam.groupTypes or {
		Act183Enum.GroupType.NormalMain
	}
	slot0._groupList = {}

	for slot4, slot5 in ipairs(slot0._groupTypes) do
		tabletool.addValues(slot0._groupList, slot0._actInfo:getGroupEpisodeMos(slot5))
	end

	slot0._selectGroupId = slot0.viewParam and slot0.viewParam.selectGroupId

	if not slot0._selectGroupId then
		slot0._firstGroupMo = slot0._groupList and slot0._groupList[1]
		slot0._selectGroupId = slot0._firstGroupMo:getGroupId()
	end

	slot0._groupType = slot0._actInfo:getGroupEpisodeMo(slot0._selectGroupId):getGroupType()
	slot0._selectEpisodeId = slot0._selectEpisodeId or slot0.viewParam and slot0.viewParam.selectEpisodeId
end

function slot0.initGroupItems(slot0)
	if slot0._groupList then
		for slot4, slot5 in ipairs(slot0._groupList) do
			if slot0._groupType == Act183Enum.GroupType.Daily and slot5:getStatus() == Act183Enum.GroupStatus.Locked then
				break
			end

			slot8 = slot0:_getOrCreateGroupItem(slot4, slot5:getGroupType())

			slot8:onUpdateMO(slot5, slot4)
			slot8:onSelect(slot5:getGroupId() == slot0._selectGroupId)
		end
	end
end

function slot0._getOrCreateGroupItem(slot0, slot1, slot2)
	if not slot0._groupItemTab[slot1] then
		slot0._groupItemTab[slot1] = MonoHelper.addLuaComOnceToGo(gohelper.cloneInPlace(slot0._gogroupitem, "groupitem_" .. slot1), slot0:_getGroupItemClsDefine(slot2))
	end

	return slot3
end

function slot0.destroyGroupItems(slot0, slot1)
	for slot5, slot6 in pairs(slot0._groupItemTab) do
		if not slot1 or not slot1[slot6] then
			gohelper.destroy(slot6.go)
		end
	end
end

function slot0._getGroupItemClsDefine(slot0, slot1)
	if not slot0._groupItemClsDefineMap then
		slot0._groupItemClsDefineMap = {
			[Act183Enum.GroupType.Daily] = Act183DungeonBaseGroupItem,
			[Act183Enum.GroupType.NormalMain] = Act183DungeonBaseGroupItem,
			[Act183Enum.GroupType.HardMain] = Act183DungeonHardMainGroupItem
		}
	end

	return slot0._groupItemClsDefineMap[slot1]
end

function slot0.tickRefreshGroupItems(slot0)
	if slot0._groupType ~= Act183Enum.GroupType.Daily then
		TaskDispatcher.cancelTask(slot0.checkRefreshGroupItems, slot0)

		return
	end

	TaskDispatcher.cancelTask(slot0.checkRefreshGroupItems, slot0)
	TaskDispatcher.runRepeat(slot0.checkRefreshGroupItems, slot0, uv0)
end

function slot0.checkRefreshGroupItems(slot0)
	slot0:initGroupItems()
end

function slot0.refresh(slot0)
	slot0:refreshInfo()
	slot0:refreshEpisodes()
	slot0:refreshProgress()
	slot0:refreshCompletedUI()
end

function slot0.refreshInfo(slot0)
	slot0._groupMo = slot0._actInfo and slot0._actInfo:getGroupEpisodeMo(slot0._selectGroupId)
	slot0._groupType = slot0._groupMo and slot0._groupMo:getGroupType()

	gohelper.setActive(slot0._simagehardbg.gameObject, slot0._groupType == Act183Enum.GroupType.HardMain)
end

function slot0.getGroupStatus(slot0, slot1)
	slot2 = slot0._actInfo and slot0._actInfo:getGroupEpisodeMo(slot1)

	return slot2 and slot2:getStatus()
end

function slot0.refreshEpisodes(slot0)
	if not slot0._groupMo then
		return
	end

	for slot6, slot7 in ipairs(slot0._groupMo:getEpisodeMos()) do
		slot9 = slot0:_getOrCreeateEpisodeItem(slot7)

		slot9:onUpdateMo(slot7)
		slot9:onSelect(slot7:getEpisodeId() == slot0._selectEpisodeId)
	end

	slot0:destroyEpisodeItems({
		[slot9] = true
	})
end

function slot0.destroyEpisodeItems(slot0, slot1)
	for slot5, slot6 in pairs(slot0._episodeItemTab) do
		if not slot1 or not slot1[slot6] then
			gohelper.destroy(slot6.go)
		end
	end
end

function slot0._getOrCreeateEpisodeItem(slot0, slot1)
	if not (slot0._episodeItemTab and slot0._episodeItemTab[slot1:getConfig().order]) then
		slot5 = slot1:getEpisodeType()
		slot7 = nil

		if slot1:getGroupType() == Act183Enum.GroupType.Daily then
			slot4 = MonoHelper.addLuaComOnceToGo(gohelper.clone(slot0._godailyepisode, slot0:_getEpisodeItemParent("root/middle/#go_episodecontainer/go_dailypoint" .. slot3), "episode_" .. slot3), Act183DailyEpisodeItem)
		elseif slot5 == Act183Enum.EpisodeType.Boss then
			slot4 = MonoHelper.addLuaComOnceToGo(gohelper.clone(slot0._gobossepisode, slot0:_getEpisodeItemParent("root/middle/#go_episodecontainer/go_pointboss"), "boss"), Act183MainBossEpisodeItem)
		elseif slot5 == Act183Enum.EpisodeType.Sub then
			slot4 = MonoHelper.addLuaComOnceToGo(gohelper.clone(slot0._gonormalepisode, slot0:_getEpisodeItemParent("root/middle/#go_episodecontainer/go_point" .. slot3), "episode_" .. slot3), Act183MainNormalEpisodeItem)
		else
			logError(string.format("未定义生成关卡方法 episodeType = %s", slot5))
		end

		slot0._episodeItemTab[slot3] = slot4
	end

	return slot4
end

function slot0.getEpisodeItemTab(slot0)
	return slot0._episodeItemTab
end

function slot0._getEpisodeItemParent(slot0, slot1)
	if gohelper.isNil(gohelper.findChild(slot0.viewGO, slot1)) then
		logError(string.format("关卡挂点不存在, 挂点路径: %s", slot1))
	end

	return slot2
end

function slot0.refreshProgress(slot0)
	slot0._episodeCount = slot0._groupMo:getEpisodeMos() and #slot1 or 0
	slot0._episodeFinishCount = slot0._groupMo:getEpisodeFinishCount()
	slot2 = {}

	if slot1 then
		for slot6, slot7 in ipairs(slot1) do
			slot8 = slot0:_getOrCreateProgressItem(slot6)

			slot0:refreshEpisodeProgress(slot8, slot7, slot6)

			slot2[slot8] = true
		end
	end

	for slot6, slot7 in pairs(slot0._progressItemTab) do
		if not slot2[slot7] then
			gohelper.setActive(slot7.viewGO, false)
		end
	end

	gohelper.setAsLastSibling(slot0._btnreset.gameObject)
end

function slot0.refreshCompletedUI(slot0)
	slot2 = false

	if slot0._groupMo:isGroupFinished() then
		slot2 = Act183Model.instance:getNewFinishGroupId() == slot0._groupMo:getGroupId()
	end

	slot3 = slot0._groupMo and slot0._groupMo:getGroupType()

	gohelper.setActive(slot0._gocompleted, slot1 and slot3 ~= Act183Enum.GroupType.Daily and not slot2)
	gohelper.setActive(slot0._godailycompleted, slot1 and slot3 == Act183Enum.GroupType.Daily and not slot2)
end

function slot0._getOrCreateProgressItem(slot0, slot1)
	if not slot0._progressItemTab[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot2.viewGO = gohelper.cloneInPlace(slot0._goprogressitem, "item_" .. slot1)
		slot2.goicon1 = gohelper.findChild(slot2.viewGO, "icon")
		slot2.goicon2 = gohelper.findChild(slot2.viewGO, "icon2")
		slot2.goicon3 = gohelper.findChild(slot2.viewGO, "icon3")
		slot0._progressItemTab[slot1] = slot2
	end

	return slot2
end

function slot0.refreshEpisodeProgress(slot0, slot1, slot2, slot3)
	gohelper.setActive(slot1.viewGO, true)
	gohelper.setActive(slot1.goicon1, false)
	gohelper.setActive(slot1.goicon2, false)
	gohelper.setActive(slot1.goicon3, false)

	if slot3 <= slot0._episodeFinishCount then
		gohelper.setActive(slot1.goicon2, true)
	elseif slot3 == slot0._episodeFinishCount + 1 then
		gohelper.setActive(slot1.goicon3, true)
	else
		gohelper.setActive(slot1.goicon1, true)
	end
end

function slot0.focusGroupCategory(slot0)
	slot1 = 0
	slot2 = false

	if slot0._selectGroupId and slot0._groupList then
		for slot6, slot7 in ipairs(slot0._groupList) do
			if slot7:getGroupId() == slot0._selectGroupId then
				slot2 = true

				break
			end

			slot1 = slot1 + slot0:_getOrCreateGroupItem(slot6):getHeight()
		end
	end

	ZProj.UGUIHelper.RebuildLayout(slot0._gogroupcontent.transform)

	slot0._scrollgroups.verticalNormalizedPosition = 1 - (slot2 and slot1 or 0) / (recthelper.getHeight(slot0._gogroupcontent.transform) - recthelper.getHeight(slot0._scrollgroups.transform))
end

function slot0.addGuide(slot0)
	if slot0._groupType == Act183Enum.GroupType.NormalMain then
		slot1 = HelpShowView.New()

		slot1:setHelpId(HelpEnum.HelpId.Act183EnterDungeon)
		slot0:addChildView(slot1)
	end
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.refresh, slot0)
	TaskDispatcher.cancelTask(slot0.checkRefreshGroupItems, slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
