module("modules.logic.herogrouppreset.view.HeroGroupPresetTeamItem", package.seeall)

local var_0_0 = class("HeroGroupPresetTeamItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goinfo = gohelper.findChild(arg_1_0.viewGO, "#go_info")
	arg_1_0._btninfoclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_info/#btn_infoclick")
	arg_1_0._goherogrouplist = gohelper.findChild(arg_1_0.viewGO, "#go_info/#go_herogrouplist")
	arg_1_0._gobossitem = gohelper.findChild(arg_1_0.viewGO, "#go_info/#go_bossitem")
	arg_1_0._btnclickboss = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_info/#go_bossitem/#btn_clickboss")
	arg_1_0._gobossempty = gohelper.findChild(arg_1_0.viewGO, "#go_info/#go_bossitem/#go_bossempty")
	arg_1_0._gobosscontainer = gohelper.findChild(arg_1_0.viewGO, "#go_info/#go_bossitem/#go_bosscontainer")
	arg_1_0._simagebossicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_info/#go_bossitem/#go_bosscontainer/#simage_bossicon")
	arg_1_0._imagebosscareer = gohelper.findChildImage(arg_1_0.viewGO, "#go_info/#go_bossitem/#go_bosscontainer/#image_bosscareer")
	arg_1_0._simagecloth = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_info/#simage_cloth")
	arg_1_0._btnuse = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_info/#btn_use")
	arg_1_0._gousing = gohelper.findChild(arg_1_0.viewGO, "#go_info/#go_using")
	arg_1_0._btnreplace = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_info/#btn_replace")
	arg_1_0._goreplaced = gohelper.findChild(arg_1_0.viewGO, "#go_info/#go_replaced")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "#go_info/#txt_num")
	arg_1_0._btndelete = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_info/top/#btn_delete")
	arg_1_0._btntop = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_info/top/#btn_top")
	arg_1_0._btnrename = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_info/top/#btn_rename")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#go_info/top/#btn_rename/#txt_name")
	arg_1_0._btnadd = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_add")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btninfoclick:AddClickListener(arg_2_0._btninfoclickOnClick, arg_2_0)
	arg_2_0._btnclickboss:AddClickListener(arg_2_0._btnclickbossOnClick, arg_2_0)
	arg_2_0._btnuse:AddClickListener(arg_2_0._btnuseOnClick, arg_2_0)
	arg_2_0._btnreplace:AddClickListener(arg_2_0._btnreplaceOnClick, arg_2_0)
	arg_2_0._btndelete:AddClickListener(arg_2_0._btndeleteOnClick, arg_2_0)
	arg_2_0._btntop:AddClickListener(arg_2_0._btntopOnClick, arg_2_0)
	arg_2_0._btnrename:AddClickListener(arg_2_0._btnrenameOnClick, arg_2_0)
	arg_2_0._btnadd:AddClickListener(arg_2_0._btnaddOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btninfoclick:RemoveClickListener()
	arg_3_0._btnclickboss:RemoveClickListener()
	arg_3_0._btnuse:RemoveClickListener()
	arg_3_0._btnreplace:RemoveClickListener()
	arg_3_0._btndelete:RemoveClickListener()
	arg_3_0._btntop:RemoveClickListener()
	arg_3_0._btnrename:RemoveClickListener()
	arg_3_0._btnadd:RemoveClickListener()
end

function var_0_0._btnclickbossOnClick(arg_4_0)
	if HeroGroupPresetController.instance:isFightScene() then
		GameFacade.showToast(ToastEnum.HeroGroupPresetCannotEditTip)

		return
	end

	TowerController.instance:openAssistBossView(arg_4_0._mo.assistBossId, true, TowerEnum.TowerType.Normal, TowerEnum.PermanentTowerId, {
		towerAssistBossItemCls = HeroGroupPresetTowerAssistBossItem,
		heroGroupMO = arg_4_0._mo,
		saveGroup = function()
			HeroGroupPresetModel.instance:externalSaveCurGroupData(nil, nil, arg_4_0._mo, arg_4_0._groupId, arg_4_0._mo.id)
			arg_4_0:_showBossInfo()
		end
	})
end

function var_0_0._btnaddOnClick(arg_6_0)
	local var_6_0 = HeroGroupPresetHeroGroupChangeController.instance:getEmptyHeroGroupId(arg_6_0._groupId)

	if not var_6_0 then
		logError("HeroGroupPresetTeamItem addHeroGroup failed")

		return
	end

	arg_6_0._newSubId = var_6_0

	arg_6_0:_addNewHeroGroup(var_6_0)
end

function var_0_0._addNewHeroGroup(arg_7_0, arg_7_1)
	local var_7_0 = HeroGroupPresetHeroGroupNameController.instance:getName(arg_7_0._groupId, arg_7_1)

	HeroGroupPresetController.instance:openHeroGroupPresetModifyNameView({
		name = var_7_0,
		groupId = arg_7_0._groupId,
		subId = arg_7_1,
		addCallback = arg_7_0._addNewHeroGroupNameCallback,
		callbackObj = arg_7_0
	})
end

function var_0_0._addNewHeroGroupNameCallback(arg_8_0, arg_8_1)
	arg_8_0._newHeroGroupName = arg_8_1
	arg_8_0._newHeroGroupMo = HeroGroupMO.New()

	arg_8_0:_addHeroGroupMo(arg_8_0._addCallback, arg_8_0, arg_8_0._newHeroGroupMo, arg_8_0._groupId, arg_8_0._newSubId)
end

function var_0_0._addHeroGroupMo(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5)
	arg_9_3.groupId = arg_9_5
	arg_9_3.id = arg_9_5

	local var_9_0 = HeroGroupModule_pb.SetHeroGroupSnapshotRequest()
	local var_9_1 = arg_9_3:getMainList()
	local var_9_2 = arg_9_3:getSubList()

	FightParam.initFightGroup(var_9_0.fightGroup, arg_9_3.clothId, var_9_1, var_9_2)

	local var_9_3 = arg_9_4
	local var_9_4 = arg_9_5

	HeroGroupRpc.instance:sendSetHeroGroupSnapshotRequest(var_9_3, var_9_4, var_9_0, arg_9_1, arg_9_2)
end

function var_0_0._replaceHeroGroupMo(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	arg_10_0._mo:replaceHeroList(arg_10_1)

	local var_10_0 = arg_10_0._mo
	local var_10_1 = HeroGroupModule_pb.SetHeroGroupSnapshotRequest()

	FightParam.initFightGroup(var_10_1.fightGroup, var_10_0.clothId, var_10_0:getMainList(), var_10_0:getSubList(), var_10_0:getAllHeroEquips(), var_10_0:getAllHeroActivity104Equips(), var_10_0:getAssistBossId())

	local var_10_2 = arg_10_0._groupId
	local var_10_3 = arg_10_0._mo.id

	HeroGroupRpc.instance:sendSetHeroGroupSnapshotRequest(var_10_2, var_10_3, var_10_1, arg_10_2, arg_10_3)
end

function var_0_0._addCallback(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if arg_11_2 ~= 0 then
		return
	end

	HeroGroupPresetHeroGroupChangeController.instance:addHeroGroup(arg_11_0._groupId, arg_11_0._newHeroGroupMo.id, arg_11_0._newHeroGroupMo)
	HeroGroupPresetController.instance:addHeroGroupCopy(arg_11_0._groupId, arg_11_0._newHeroGroupMo.id, arg_11_0._newHeroGroupMo)
	HeroGroupPresetItemListModel.instance:updateList()
	HeroGroupRpc.instance:sendUpdateHeroGroupNameRequest(arg_11_0._groupId, arg_11_0._newSubId, arg_11_0._newHeroGroupName, HeroGroupPresetModifyNameView.UpdateHeroGroupNameRequest)

	if HeroGroupPresetController.instance:isFightScene() then
		arg_11_0:_useHeroGroup(arg_11_0._groupId, arg_11_0._newHeroGroupMo.id)

		return
	end

	HeroGroupPresetItemListModel.instance:setNewHeroGroupInfo(arg_11_0._groupId, arg_11_0._newHeroGroupMo.id)
	arg_11_0:_openHeroGroupPresetEditView(arg_11_0._newHeroGroupMo, arg_11_0._newHeroGroupMo.id, arg_11_0._newHeroGroupName, true)
end

function var_0_0._btninfoclickOnClick(arg_12_0)
	return
end

function var_0_0._openHeroGroupPresetEditView(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5)
	HeroGroupPresetSingleGroupModel.instance:setMaxHeroCount(HeroGroupPresetItemListModel.instance:getHeroNum())
	HeroGroupPresetModel.instance:setHeroGroupSnapshotType(arg_13_0._groupId)
	HeroGroupPresetModel.instance:setHeroGroupMo(arg_13_1)
	HeroGroupPresetModel.instance:setCurGroupId(arg_13_2)
	HeroGroupPresetItemListModel.instance:setHeroGroupSnapshotSubId(arg_13_2)

	arg_13_5 = arg_13_5 or 1

	local var_13_0 = arg_13_1:getPosEquips(arg_13_5 - 1).equipUid
	local var_13_1 = {
		singleGroupMOId = arg_13_5,
		originalHeroUid = HeroGroupPresetSingleGroupModel.instance:getHeroUid(arg_13_5),
		equips = var_13_0,
		onlyQuickEdit = arg_13_4,
		heroGroupName = arg_13_3
	}

	HeroGroupPresetController.instance:openHeroGroupPresetEditView(var_13_1)
end

function var_0_0._btnreplaceOnClick(arg_14_0)
	if not arg_14_0._view.viewParam then
		return
	end

	local var_14_0 = arg_14_0._view.viewParam.replaceTeamList

	if not var_14_0 then
		return
	end

	local var_14_1 = HeroGroupPresetItemListModel.instance:getReplaceTeamSubId(var_14_0)

	if not var_14_1 or var_14_1 > 0 then
		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.CharacterRecommedGroupReplaceTip, MsgBoxEnum.BoxType.Yes_No, function()
		arg_14_0:_replaceHeroGroupMo(var_14_0, arg_14_0._replaceTeamCallback, arg_14_0)
	end, nil, nil, arg_14_0)
end

function var_0_0._btnrenameOnClick(arg_16_0)
	HeroGroupPresetController.instance:openHeroGroupPresetModifyNameView({
		name = arg_16_0._name,
		groupId = arg_16_0._groupId,
		subId = arg_16_0._mo.id
	})
end

function var_0_0._btnuseOnClick(arg_17_0)
	arg_17_0:_useHeroGroup(arg_17_0._groupId, arg_17_0._mo.id)
end

function var_0_0._useHeroGroup(arg_18_0, arg_18_1, arg_18_2)
	HeroGroupPresetController.instance:revertCurHeroGroup()
	HeroGroupPresetController.instance:dispatchEvent(HeroGroupPresetEvent.UseHeroGroup, {
		groupId = arg_18_1,
		subId = arg_18_2
	})
	ViewMgr.instance:closeView(arg_18_0._view.viewName, nil, true)
end

function var_0_0._btndeleteOnClick(arg_19_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.HeroGroupDeleteTip, MsgBoxEnum.BoxType.Yes_No, function()
		HeroGroupRpc.instance:sendDeleteHeroGroupRequest(arg_19_0._groupId, arg_19_0._mo.id)
	end)
end

function var_0_0._btntopOnClick(arg_21_0)
	local var_21_0 = HeroGroupSnapshotModel.instance:getSortSubIds(arg_21_0._groupId)

	tabletool.removeValue(var_21_0, arg_21_0._mo.id)
	table.insert(var_21_0, 1, arg_21_0._mo.id)
	HeroGroupRpc.instance:sendUpdateHeroGroupSortRequest(arg_21_0._groupId, var_21_0)
end

function var_0_0._editableInitView(arg_22_0)
	arg_22_0._goclothbg = gohelper.findChild(arg_22_0.viewGO, "#go_info/clothbg")
	arg_22_0._goline = gohelper.findChild(arg_22_0.viewGO, "#go_info/top/line")

	gohelper.setActive(arg_22_0._gousing, false)

	arg_22_0._heroItemList = arg_22_0:getUserDataTb_()

	gohelper.setActive(arg_22_0._goheroitem, false)
	gohelper.setActive(arg_22_0._gobossitem, false)
	gohelper.setActive(arg_22_0._simagecloth, false)
	gohelper.setActive(arg_22_0._goclothbg, false)

	arg_22_0._animator = arg_22_0.viewGO:GetComponent("Animator")

	function arg_22_0._getAnimator()
		return arg_22_0._animator
	end

	arg_22_0.getAnimator = arg_22_0._getAnimator
end

function var_0_0._editableAddEvents(arg_24_0)
	arg_24_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, arg_24_0._modifyHeroGroup, arg_24_0)
	arg_24_0:addEventCb(HeroGroupPresetController.instance, HeroGroupPresetEvent.UpdateGroupName, arg_24_0._onUpdateGroupName, arg_24_0)
	arg_24_0:addEventCb(HeroGroupPresetController.instance, HeroGroupPresetEvent.ClickHero, arg_24_0._onClickHero, arg_24_0)
	arg_24_0:addEventCb(HeroGroupPresetController.instance, HeroGroupPresetEvent.ClickEquip, arg_24_0._onClickEquip, arg_24_0)
	arg_24_0:addEventCb(HeroGroupPresetController.instance, HeroGroupPresetEvent.ChangeEquip, arg_24_0._onChangeEquip, arg_24_0)
	arg_24_0:addEventCb(HeroGroupPresetController.instance, HeroGroupPresetEvent.UpdateHeroGroupSort, arg_24_0._onUpdateHeroGroupSort, arg_24_0)
	arg_24_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_24_0._onCloseViewCallBack, arg_24_0)
end

function var_0_0._editableRemoveEvents(arg_25_0)
	return
end

function var_0_0._onCloseViewCallBack(arg_26_0, arg_26_1)
	if arg_26_1 == ViewName.HeroGroupPresetEditView then
		local var_26_0, var_26_1 = HeroGroupPresetItemListModel.instance:getNewHeroGroupInfo()

		if arg_26_0._groupId == var_26_0 and arg_26_0._mo.id == var_26_1 then
			HeroGroupPresetItemListModel.instance:setNewHeroGroupInfo()
			arg_26_0._animator:Play("add", 0, 0)
		end
	end
end

function var_0_0._onUpdateHeroGroupSort(arg_27_0)
	arg_27_0:_showSetTopAnim()
end

function var_0_0._onChangeEquip(arg_28_0, arg_28_1, arg_28_2)
	if arg_28_0._groupId == arg_28_1 and arg_28_0._mo and arg_28_0._mo.id == arg_28_2 then
		arg_28_0:_refreshHeroItem()
	end
end

function var_0_0._onClickHero(arg_29_0, arg_29_1, arg_29_2)
	if arg_29_0._mo ~= arg_29_1 then
		return
	end

	HeroGroupPresetItemListModel.instance:setEditHeroGroupSnapshotSubId(arg_29_0._mo.id)
	arg_29_0:_openHeroGroupPresetEditView(arg_29_0._mo, arg_29_0._mo.id, arg_29_0._name, nil, arg_29_2)
end

function var_0_0._onClickEquip(arg_30_0, arg_30_1, arg_30_2)
	if arg_30_0._mo ~= arg_30_1 then
		return
	end

	arg_30_2.presetGroupId = arg_30_0._groupId
	arg_30_2.presetSubId = arg_30_0._mo.id
	arg_30_2.heroGroupMo = arg_30_0._mo

	EquipController.instance:openEquipInfoTeamView(arg_30_2)
end

function var_0_0._modifyHeroGroup(arg_31_0)
	if not arg_31_0._mo or arg_31_0._mo.id ~= HeroGroupPresetItemListModel.instance:getHeroGroupSnapshotSubId() then
		return
	end

	arg_31_0:_refreshHeroItem()

	if arg_31_0._mo and arg_31_0._mo.id == HeroGroupPresetItemListModel.instance:getEditHeroGroupSnapshotSubId() then
		HeroGroupPresetItemListModel.instance:setEditHeroGroupSnapshotSubId()
		arg_31_0._animator:Play("refresh", 0, 0)
	end
end

function var_0_0._onUpdateGroupName(arg_32_0, arg_32_1)
	if arg_32_0._mo and arg_32_0._mo.id == arg_32_1 then
		arg_32_0:_updateName()
	end
end

function var_0_0.onUpdateMO(arg_33_0, arg_33_1)
	arg_33_0._groupId = HeroGroupPresetItemListModel.instance:getHeroGroupSnapshotType()

	local var_33_0 = arg_33_1.__isAdd

	gohelper.setActive(arg_33_0._goinfo, not var_33_0)
	gohelper.setActive(arg_33_0._btnadd, var_33_0)

	if var_33_0 then
		return
	end

	arg_33_0._mo = arg_33_1
	arg_33_0._singleGroupModel = arg_33_0._singleGroupModel or HeroGroupPresetSingleGroupModel.New()

	if arg_33_0._heroNum ~= HeroGroupPresetItemListModel.instance:getHeroNum() then
		arg_33_0._singleGroupModel:setMaxHeroCount(HeroGroupPresetItemListModel.instance:getHeroNum())

		arg_33_0._heroNum = HeroGroupPresetItemListModel.instance:getHeroNum()
	end

	local var_33_1 = HeroGroupPresetItemListModel.instance:showDeleteBtn()

	gohelper.setActive(arg_33_0._btndelete, var_33_1)
	gohelper.setActive(arg_33_0._goline, var_33_1)
	gohelper.setActive(arg_33_0._btntop, arg_33_0._index ~= 1)
	arg_33_0:_refreshHeroItem()
	arg_33_0:_updateName()
	arg_33_0:_showFightInfo()
	arg_33_0:_showBossInfo()
	arg_33_0:_showReplace()
end

function var_0_0._showSetTopAnim(arg_34_0)
	arg_34_0.getAnimator = nil

	arg_34_0._animator:Play("open", 0, 0)
	TaskDispatcher.cancelTask(arg_34_0._delayResetAnimator, arg_34_0)
	TaskDispatcher.runDelay(arg_34_0._delayResetAnimator, arg_34_0, 0)
end

function var_0_0._delayResetAnimator(arg_35_0)
	arg_35_0.getAnimator = arg_35_0._getAnimator
end

function var_0_0._showBossInfo(arg_36_0)
	local var_36_0 = HeroGroupPresetEnum.HeroGroupSnapshotTypeShowBoss[arg_36_0._groupId]

	gohelper.setActive(arg_36_0._gobossitem, var_36_0)

	if not var_36_0 then
		return
	end

	local var_36_1 = arg_36_0._mo.assistBossId
	local var_36_2 = var_36_1 and TowerConfig.instance:getAssistBossConfig(var_36_1)
	local var_36_3 = var_36_2 ~= nil

	gohelper.setActive(arg_36_0._gobossempty, not var_36_3)
	gohelper.setActive(arg_36_0._gobosscontainer, var_36_3)

	if var_36_3 then
		UISpriteSetMgr.instance:setCommonSprite(arg_36_0._imagebosscareer, string.format("lssx_%s", var_36_2.career))

		local var_36_4 = FightConfig.instance:getSkinCO(var_36_2.skinId)

		arg_36_0._simagebossicon:LoadImage(ResUrl.monsterHeadIcon(var_36_4 and var_36_4.headIcon))
	end
end

function var_0_0._showFightInfo(arg_37_0)
	if not HeroGroupPresetController.instance:isFightShowType() then
		return
	end

	local var_37_0 = HeroGroupPresetController.instance:getSelectedSubId() == arg_37_0._mo.id

	gohelper.setActive(arg_37_0._gousing, var_37_0)
	gohelper.setActive(arg_37_0._btnuse, not var_37_0)

	if var_37_0 then
		gohelper.setActive(arg_37_0._btndelete, false)
	end
end

function var_0_0._updateName(arg_38_0)
	arg_38_0._name = HeroGroupPresetHeroGroupNameController.instance:getName(arg_38_0._groupId, arg_38_0._mo.id)
	arg_38_0._txtname.text = arg_38_0._name
end

function var_0_0._refreshHeroItem(arg_39_0)
	if HeroGroupPresetController.instance:isFightScene() then
		HeroGroupPresetHeroGroupChangeController.instance:handleHeroListData(arg_39_0._groupId, arg_39_0._mo)
	end

	arg_39_0._singleGroupModel:setSingleGroup(arg_39_0._mo, HeroGroupPresetController.instance:isFightScene())

	local var_39_0 = arg_39_0._mo.heroList
	local var_39_1 = HeroGroupPresetItemListModel.instance:getHeroNum()

	for iter_39_0 = 1, var_39_1 do
		local var_39_2 = var_39_0 and HeroModel.instance:getById(var_39_0[iter_39_0])
		local var_39_3 = arg_39_0._heroItemList[iter_39_0]

		if not var_39_3 then
			local var_39_4 = arg_39_0._view.viewContainer:getSetting().otherRes[3]
			local var_39_5 = arg_39_0._view:getResInst(var_39_4, arg_39_0._goherogrouplist)

			var_39_3 = MonoHelper.addNoUpdateLuaComOnceToGo(var_39_5, HeroGroupPresetTeamHeroItem)

			table.insert(arg_39_0._heroItemList, var_39_3)
		end

		local var_39_6 = arg_39_0._singleGroupModel:getById(iter_39_0)

		var_39_3:onUpdateMO(var_39_6, var_39_2, arg_39_0._mo, iter_39_0)
	end
end

function var_0_0._showReplace(arg_40_0)
	local var_40_0 = arg_40_0._view.viewParam and arg_40_0._view.viewParam.replaceTeamList
	local var_40_1 = HeroGroupPresetItemListModel.instance:getReplaceTeamSubId(var_40_0)

	if not var_40_0 or not var_40_1 then
		gohelper.setActive(arg_40_0._btnreplace.gameObject, false)
		gohelper.setActive(arg_40_0._goreplaced.gameObject, false)

		return
	end

	ZProj.UGUIHelper.SetGrayscale(arg_40_0._btnreplace.gameObject, var_40_1 > 0)
	gohelper.setActive(arg_40_0._btnreplace.gameObject, var_40_1 ~= arg_40_0._mo.id)
	gohelper.setActive(arg_40_0._goreplaced.gameObject, var_40_1 == arg_40_0._mo.id)
end

function var_0_0._replaceTeamCallback(arg_41_0)
	if HeroGroupPresetController.instance:isFightScene() then
		HeroGroupPresetController.instance:updateFightHeroGroup()
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
	end

	HeroGroupPresetController.instance:closeHeroGroupPresetEditView()
	ViewMgr.instance:closeView(ViewName.HeroGroupEditView)
	HeroGroupPresetItemListModel.instance:onModelUpdate()
	GameFacade.showToast(ToastEnum.CharacterRecommedGroupReplaceSuccess)
end

function var_0_0.onSelect(arg_42_0, arg_42_1)
	return
end

function var_0_0.onDestroyView(arg_43_0)
	TaskDispatcher.cancelTask(arg_43_0._delayResetAnimator, arg_43_0)

	arg_43_0._getAnimator = nil
	arg_43_0.getAnimator = nil
end

return var_0_0
