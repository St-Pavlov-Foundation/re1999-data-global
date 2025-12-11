module("modules.logic.tower.view.fight.TowerDeepTeamSaveView", package.seeall)

local var_0_0 = class("TowerDeepTeamSaveView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btncloseFullView = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_closeFullView")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "title/#txt_title")
	arg_1_0._scrolllist = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_list")
	arg_1_0._goteamContent = gohelper.findChild(arg_1_0.viewGO, "#scroll_list/Viewport/#go_teamContent")
	arg_1_0._goteamitem = gohelper.findChild(arg_1_0.viewGO, "#scroll_list/Viewport/#go_teamContent/#go_teamitem")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btncloseFullView:AddClickListener(arg_2_0._btncloseFullViewOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.OnSaveTeamSuccess, arg_2_0.onSaveTeamSuccess, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.OnLoadTeamSuccess, arg_2_0.onLoadTeamSuccess, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btncloseFullView:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.OnSaveTeamSuccess, arg_3_0.onSaveTeamSuccess, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.OnLoadTeamSuccess, arg_3_0.onLoadTeamSuccess, arg_3_0)
end

function var_0_0.onTeamItemCoverClick(arg_4_0, arg_4_1)
	if not arg_4_1.saveGroupMo then
		return
	end

	GameFacade.showOptionMessageBox(MessageBoxIdDefine.TowerDeepCoverCurSaveData, MsgBoxEnum.BoxType.Yes_No, MsgBoxEnum.optionType.Daily, function()
		TowerDeepRpc.instance:sendTowerDeepSaveArchiveRequest(arg_4_1.saveGroupMo.archiveId)
	end, nil, nil, arg_4_0)
end

function var_0_0.onTeamItembtnLoadClick(arg_6_0, arg_6_1)
	if not arg_6_1.saveGroupMo then
		return
	end

	GameFacade.showOptionMessageBox(MessageBoxIdDefine.TowerDeepLoadCurSaveData, MsgBoxEnum.BoxType.Yes_No, MsgBoxEnum.optionType.Daily, function()
		TowerDeepRpc.instance:sendTowerDeepLoadArchiveRequest(arg_6_1.saveGroupMo.archiveId)
	end)
end

function var_0_0.onTeamItembtnSaveClick(arg_8_0, arg_8_1)
	TowerDeepRpc.instance:sendTowerDeepSaveArchiveRequest(arg_8_1.index)
end

function var_0_0._btncloseFullViewOnClick(arg_9_0)
	arg_9_0:closeThis()
end

function var_0_0._btncloseOnClick(arg_10_0)
	arg_10_0:closeThis()
end

function var_0_0._editableInitView(arg_11_0)
	arg_11_0.teamItemMap = arg_11_0:getUserDataTb_()

	gohelper.setActive(arg_11_0._goteamitem, false)
end

function var_0_0.onUpdateParam(arg_12_0)
	return
end

function var_0_0.onOpen(arg_13_0)
	arg_13_0.curOperateType = arg_13_0.viewParam.teamOperateType
	arg_13_0.teamSaveCount = TowerDeepConfig.instance:getConstConfigValue(TowerDeepEnum.ConstId.HeroGroupSaveCount)

	arg_13_0:refreshUI()
end

function var_0_0.refreshUI(arg_14_0)
	arg_14_0._txttitle.text = arg_14_0.curOperateType == TowerDeepEnum.TeamOperateType.Save and luaLang("TowerDeep_teamSave_save") or luaLang("TowerDeep_teamSave_load")

	arg_14_0:createAndRefreshTeamsItem()
end

function var_0_0.createAndRefreshTeamsItem(arg_15_0)
	arg_15_0.saveDeepGroupMoMap = TowerPermanentDeepModel.instance:getSaveDeepGroupMoMap()

	for iter_15_0 = 1, arg_15_0.teamSaveCount do
		local var_15_0 = arg_15_0.teamItemMap[iter_15_0]

		if not var_15_0 then
			var_15_0 = {
				index = iter_15_0,
				go = gohelper.clone(arg_15_0._goteamitem, arg_15_0._goteamContent, "teamItem" .. iter_15_0)
			}
			var_15_0.goTeamInfo = gohelper.findChild(var_15_0.go, "go_teamInfo")
			var_15_0.imageDeepBg = gohelper.findChildImage(var_15_0.goTeamInfo, "depth/image_deepBg")
			var_15_0.txtDepth = gohelper.findChildText(var_15_0.goTeamInfo, "depth/txt_depth")
			var_15_0.txtRound = gohelper.findChildText(var_15_0.goTeamInfo, "round/txt_round")
			var_15_0.txtSaveTime = gohelper.findChildText(var_15_0.goTeamInfo, "time/txt_saveTime")
			var_15_0.goHeroContent = gohelper.findChild(var_15_0.goTeamInfo, "go_heroContent")
			var_15_0.goHeroItem = gohelper.findChild(var_15_0.goTeamInfo, "go_heroContent/go_heroItem")
			var_15_0.btnCover = gohelper.findChildButtonWithAudio(var_15_0.goTeamInfo, "btn_cover")

			var_15_0.btnCover:AddClickListener(arg_15_0.onTeamItemCoverClick, arg_15_0, var_15_0)

			var_15_0.btnLoad = gohelper.findChildButtonWithAudio(var_15_0.goTeamInfo, "btn_load")

			var_15_0.btnLoad:AddClickListener(arg_15_0.onTeamItembtnLoadClick, arg_15_0, var_15_0)

			var_15_0.goEmptySave = gohelper.findChild(var_15_0.go, "go_emptySave")
			var_15_0.btnEmptySave = gohelper.findChildButtonWithAudio(var_15_0.goEmptySave, "btn_save")

			var_15_0.btnEmptySave:AddClickListener(arg_15_0.onTeamItembtnSaveClick, arg_15_0, var_15_0)

			var_15_0.goEmptyLoad = gohelper.findChild(var_15_0.go, "go_emptyLoad")
			var_15_0.gorefreshAnim = gohelper.findChild(var_15_0.go, "ani_refresh")
			var_15_0.heroItemList = {}
			arg_15_0.teamItemMap[iter_15_0] = var_15_0
		end

		gohelper.setActive(var_15_0.gorefreshAnim, false)
		gohelper.setActive(var_15_0.go, true)

		var_15_0.saveGroupMo = arg_15_0.saveDeepGroupMoMap[var_15_0.index]

		gohelper.setActive(var_15_0.goTeamInfo, var_15_0.saveGroupMo)
		gohelper.setActive(var_15_0.goEmptyLoad, not var_15_0.saveGroupMo and arg_15_0.curOperateType == TowerDeepEnum.TeamOperateType.Load)
		gohelper.setActive(var_15_0.goEmptySave, not var_15_0.saveGroupMo and arg_15_0.curOperateType == TowerDeepEnum.TeamOperateType.Save)
		gohelper.setActive(var_15_0.btnCover.gameObject, var_15_0.saveGroupMo and arg_15_0.curOperateType == TowerDeepEnum.TeamOperateType.Save)
		gohelper.setActive(var_15_0.btnLoad.gameObject, var_15_0.saveGroupMo and arg_15_0.curOperateType == TowerDeepEnum.TeamOperateType.Load)

		if var_15_0.saveGroupMo then
			local var_15_1 = TowerPermanentDeepModel.instance:getDeepRare(var_15_0.saveGroupMo.curDeep)

			UISpriteSetMgr.instance:setFightTowerSprite(var_15_0.imageDeepBg, "fight_tower_numbg_" .. var_15_1)

			var_15_0.txtDepth.text = string.format("%sM", var_15_0.saveGroupMo.curDeep)

			local var_15_2 = var_15_0.saveGroupMo:getTeamDataList()

			var_15_0.txtRound.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("TowerDeep_teamSave_round"), GameUtil.getNum2Chinese(#var_15_2))
			var_15_0.txtSaveTime.text = os.date("%Y.%m.%d %H:%M:%S", var_15_0.saveGroupMo.createTime)

			arg_15_0:createHeroItem(var_15_0)
		end
	end
end

function var_0_0.createHeroItem(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1.saveGroupMo:getAllHeroData()

	gohelper.setActive(arg_16_1.goHeroItem, false)

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		local var_16_1 = arg_16_1.heroItemList[iter_16_0]

		if not var_16_1 then
			var_16_1 = {
				go = gohelper.clone(arg_16_1.goHeroItem, arg_16_1.goHeroContent, "heroItem" .. iter_16_0)
			}
			var_16_1.simageRole = gohelper.findChildSingleImage(var_16_1.go, "simage_role")
			arg_16_1.heroItemList[iter_16_0] = var_16_1
		end

		gohelper.setActive(var_16_1.go, true)

		local var_16_2 = 0

		if iter_16_1.trialId and iter_16_1.trialId > 0 then
			var_16_2 = lua_hero_trial.configDict[iter_16_1.trialId][0].skin
		elseif iter_16_1.heroId and iter_16_1.heroId > 0 then
			var_16_2 = HeroConfig.instance:getHeroCO(iter_16_1.heroId).skinId
		end

		local var_16_3 = SkinConfig.instance:getSkinCo(var_16_2)

		var_16_1.simageRole:LoadImage(ResUrl.getHeadIconSmall(var_16_3.retangleIcon))
	end

	for iter_16_2 = #var_16_0 + 1, #arg_16_1.heroItemList do
		local var_16_4 = arg_16_1.heroItemList[iter_16_2]

		if var_16_4 then
			gohelper.setActive(var_16_4.go, false)
		end
	end
end

function var_0_0.onSaveTeamSuccess(arg_17_0, arg_17_1)
	arg_17_0:createAndRefreshTeamsItem()

	local var_17_0 = arg_17_1.archiveNo
	local var_17_1 = arg_17_0.teamItemMap[var_17_0]

	if var_17_1 then
		gohelper.setActive(var_17_1.gorefreshAnim, false)
		gohelper.setActive(var_17_1.gorefreshAnim, true)
	end
end

function var_0_0.onLoadTeamSuccess(arg_18_0, arg_18_1)
	arg_18_0:createAndRefreshTeamsItem()
	GameFacade.showToast(ToastEnum.TowerDeepLoadDataSuccess)
	arg_18_0:closeThis()
end

function var_0_0.onClose(arg_19_0)
	return
end

function var_0_0.onDestroyView(arg_20_0)
	for iter_20_0, iter_20_1 in pairs(arg_20_0.teamItemMap) do
		for iter_20_2, iter_20_3 in ipairs(iter_20_1.heroItemList) do
			iter_20_3.simageRole:UnLoadImage()
		end

		iter_20_1.btnCover:RemoveClickListener()
		iter_20_1.btnLoad:RemoveClickListener()
		iter_20_1.btnEmptySave:RemoveClickListener()
	end
end

return var_0_0
