module("modules.logic.versionactivity2_3.act174.view.Act174GameTeamView", package.seeall)

local var_0_0 = class("Act174GameTeamView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goTeamRoot = gohelper.findChild(arg_1_0.viewGO, "#go_EditTeam/go_TeamRoot")
	arg_1_0._goHeroGroup = gohelper.findChild(arg_1_0.viewGO, "#go_EditTeam/go_TeamRoot/go_HeroGroup")
	arg_1_0._goEquipGroup = gohelper.findChild(arg_1_0.viewGO, "#go_EditTeam/go_TeamRoot/go_EquipGroup")
	arg_1_0._goHeroMask = gohelper.findChild(arg_1_0.viewGO, "#go_EditTeam/go_TeamRoot/go_HeroMask")
	arg_1_0._goLock1 = gohelper.findChild(arg_1_0.viewGO, "#go_EditTeam/go_TeamRoot/go_Lock1")
	arg_1_0._txtUnlock1 = gohelper.findChildText(arg_1_0.viewGO, "#go_EditTeam/go_TeamRoot/go_Lock1/txt_Unlock1")
	arg_1_0._goLock2 = gohelper.findChild(arg_1_0.viewGO, "#go_EditTeam/go_TeamRoot/go_Lock2")
	arg_1_0._txtUnlock2 = gohelper.findChildText(arg_1_0.viewGO, "#go_EditTeam/go_TeamRoot/go_Lock2/txt_Unlock2")
	arg_1_0._goLock3 = gohelper.findChild(arg_1_0.viewGO, "#go_EditTeam/go_TeamRoot/go_Lock3")
	arg_1_0._txtUnlock3 = gohelper.findChildText(arg_1_0.viewGO, "#go_EditTeam/go_TeamRoot/go_Lock3/txt_Unlock3")
	arg_1_0._goCharacterInfo = gohelper.findChild(arg_1_0.viewGO, "go_characterinfo")
	arg_1_0.animLock1 = arg_1_0._goLock1:GetComponent(gohelper.Type_Animator)
	arg_1_0.animLock2 = arg_1_0._goLock2:GetComponent(gohelper.Type_Animator)
	arg_1_0.animLock3 = arg_1_0._goLock3:GetComponent(gohelper.Type_Animator)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnCharacterBg, arg_2_0.onClickCharacterBg, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeClickCb(arg_3_0.btnCharacterBg)
end

function var_0_0.onClickCharacterBg(arg_4_0)
	gohelper.setActive(arg_4_0._goCharacterInfo, false)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0.btnCharacterBg = gohelper.findChildButtonWithAudio(arg_5_0.viewGO, "go_characterinfo/btn_CloseCharacterInfo")
	arg_5_0.characterInfo = MonoHelper.addNoUpdateLuaComOnceToGo(arg_5_0._goCharacterInfo, Act174CharacterInfo, arg_5_0)

	gohelper.setActive(arg_5_0._goHeroGroup, true)
	gohelper.setActive(arg_5_0._goEquipGroup, false)

	arg_5_0.wareType = Activity174Enum.WareType.Hero

	arg_5_0:initFrame()
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0.actId = Activity174Model.instance:getCurActId()

	local var_7_0 = Activity174Model.instance:getActInfo():getGameInfo().gameCount

	arg_7_0.unLockTeamCnt = Activity174Config.instance:getTurnCo(arg_7_0.actId, var_7_0).groupNum

	arg_7_0:creatHeroEquipItem()
	arg_7_0:refreshTeamLock()
	arg_7_0:refreshTeamGroup()
	arg_7_0:caculateSelectIndex()
	arg_7_0:addEventCb(Activity174Controller.instance, Activity174Event.WareHouseTypeChange, arg_7_0.OnWareTypeChange, arg_7_0)
	arg_7_0:addEventCb(Activity174Controller.instance, Activity174Event.WareItemInstall, arg_7_0.OnInstallItem, arg_7_0)
	arg_7_0:addEventCb(Activity174Controller.instance, Activity174Event.WareItemRemove, arg_7_0.OnRemoveItem, arg_7_0)
	arg_7_0:addEventCb(Activity174Controller.instance, Activity174Event.UnEquipCollection, arg_7_0.UnInstallCollection, arg_7_0)
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0.unlockTeamAnimEnd, arg_9_0)
end

function var_0_0.initFrame(arg_10_0)
	arg_10_0.frameTrList = {}

	for iter_10_0 = 1, 12 do
		local var_10_0 = gohelper.findChild(arg_10_0.viewGO, "#go_EditTeam/go_TeamRoot/FrameRoot/frame" .. iter_10_0)

		arg_10_0["_goFrameSelect" .. iter_10_0] = gohelper.findChild(var_10_0, "select")
		arg_10_0.frameTrList[iter_10_0] = var_10_0.transform
	end
end

function var_0_0.refreshTeamLock(arg_11_0)
	for iter_11_0 = 1, 3 do
		gohelper.setActive(arg_11_0["_goLock" .. iter_11_0], iter_11_0 > arg_11_0.unLockTeamCnt)

		local var_11_0 = Activity174Config.instance:getUnlockLevel(arg_11_0.actId, iter_11_0) - 1
		local var_11_1 = luaLang("act174_team_unlocktip")

		arg_11_0["_txtUnlock" .. iter_11_0].text = GameUtil.getSubPlaceholderLuaLangOneParam(var_11_1, GameUtil.getNum2Chinese(var_11_0))
	end

	arg_11_0:checkUnlockTeamAnim(arg_11_0.unLockTeamCnt)
end

function var_0_0.creatHeroEquipItem(arg_12_0)
	arg_12_0.heroItemList = {}
	arg_12_0.equipItemList = {}

	local var_12_0 = gohelper.findChild(arg_12_0._goHeroGroup, "HeroItem")
	local var_12_1 = gohelper.findChild(arg_12_0._goEquipGroup, "EquipItem")
	local var_12_2 = gohelper.findChild(arg_12_0._goHeroMask, "mask")

	for iter_12_0 = 1, 12 do
		local var_12_3, var_12_4 = recthelper.getAnchor(arg_12_0.frameTrList[iter_12_0])
		local var_12_5 = gohelper.cloneInPlace(var_12_0)

		recthelper.setAnchor(var_12_5.transform, var_12_3, var_12_4)

		local var_12_6 = MonoHelper.addNoUpdateLuaComOnceToGo(var_12_5, Act174HeroItem, arg_12_0)

		var_12_6:setIndex(iter_12_0)
		var_12_6:activeEquip(true)

		arg_12_0.heroItemList[iter_12_0] = var_12_6

		local var_12_7 = gohelper.cloneInPlace(var_12_1)

		recthelper.setAnchor(var_12_7.transform, var_12_3, var_12_4)

		local var_12_8 = MonoHelper.addNoUpdateLuaComOnceToGo(var_12_7, Act174EquipItem, arg_12_0)

		var_12_8:setIndex(iter_12_0)

		arg_12_0.equipItemList[iter_12_0] = var_12_8

		local var_12_9 = gohelper.cloneInPlace(var_12_2)

		recthelper.setAnchor(var_12_9.transform, var_12_3, var_12_4)
	end

	gohelper.setActive(var_12_0, false)
	gohelper.setActive(var_12_1, false)
end

function var_0_0.refreshTeamGroup(arg_13_0)
	arg_13_0.heroList = {}
	arg_13_0.equipList = {}
	arg_13_0.skillList = {}
	arg_13_0.teamMoList = Activity174Model.instance:getActInfo():getGameInfo():getTeamMoList()

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.teamMoList) do
		local var_13_0 = iter_13_1.battleHeroInfo
		local var_13_1 = iter_13_1.index

		for iter_13_2 = 1, 4 do
			local var_13_2 = var_13_0[iter_13_2]

			if var_13_2 then
				local var_13_3 = (var_13_1 - 1) * 4 + var_13_2.index

				if var_13_2.heroId ~= 0 then
					arg_13_0.heroList[var_13_3] = var_13_2.heroId
				end

				if var_13_2.itemId ~= 0 then
					arg_13_0.equipList[var_13_3] = var_13_2.itemId
				end

				if var_13_2.priorSkill ~= 0 then
					arg_13_0.skillList[var_13_3] = var_13_2.priorSkill
				end

				arg_13_0:refreshHeroItem(var_13_3)
				arg_13_0:refreshEquipItem(var_13_3)
			end
		end
	end
end

function var_0_0.refreshHeroItem(arg_14_0, arg_14_1)
	arg_14_0.heroItemList[arg_14_1]:setData(arg_14_0.heroList[arg_14_1], arg_14_0.equipList[arg_14_1], arg_14_0.skillList[arg_14_1])
end

function var_0_0.refreshEquipItem(arg_15_0, arg_15_1)
	arg_15_0.equipItemList[arg_15_1]:setData(arg_15_0.equipList[arg_15_1])
end

function var_0_0.OnWareTypeChange(arg_16_0, arg_16_1)
	arg_16_0.wareType = arg_16_1

	for iter_16_0, iter_16_1 in ipairs(arg_16_0.heroItemList) do
		iter_16_1:activeEquip(arg_16_1 == Activity174Enum.WareType.Hero)
	end

	gohelper.setActive(arg_16_0._goEquipGroup, arg_16_1 == Activity174Enum.WareType.Collection)
	arg_16_0:caculateSelectIndex()
end

function var_0_0.OnInstallItem(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0.selectHeroIndex

	if arg_17_0.wareType == Activity174Enum.WareType.Hero then
		if var_17_0 == 0 then
			GameFacade.showToast(ToastEnum.Act174TeamGroupFull)
		else
			arg_17_0.heroList[var_17_0] = arg_17_1

			arg_17_0:updateBattleHeroInfo(arg_17_0.selectHeroIndex)

			local var_17_1

			for iter_17_0 = arg_17_0.selectHeroIndex + 1, arg_17_0.unLockTeamCnt * 4 do
				if not arg_17_0.heroList[iter_17_0] then
					var_17_1 = iter_17_0

					break
				end
			end

			if var_17_1 then
				arg_17_0.selectHeroIndex = var_17_1

				arg_17_0:refreshSelect()
			else
				arg_17_0:caculateSelectIndex()
			end
		end
	elseif var_17_0 == 0 then
		GameFacade.showToast(ToastEnum.Act174CollectionFull)
	else
		if lua_activity174_collection.configDict[arg_17_1].unique == 1 then
			local var_17_2 = Activity174Helper.CalculateRowColumn(var_17_0)

			if not arg_17_0:checkOnlyCollection(var_17_2, arg_17_1) then
				GameFacade.showToast(ToastEnum.Act174OnlyCollection)

				return
			end
		end

		arg_17_0.equipList[var_17_0] = arg_17_1

		arg_17_0:updateBattleHeroInfo(arg_17_0.selectHeroIndex)

		local var_17_3

		for iter_17_1 = arg_17_0.selectHeroIndex + 1, arg_17_0.unLockTeamCnt * 4 do
			if not arg_17_0.equipList[iter_17_1] then
				var_17_3 = iter_17_1

				break
			end
		end

		if var_17_3 then
			arg_17_0.selectHeroIndex = var_17_3

			arg_17_0:refreshSelect()
		else
			arg_17_0:caculateSelectIndex()
		end
	end
end

function var_0_0.OnRemoveItem(arg_18_0, arg_18_1)
	local var_18_0

	if arg_18_0.wareType == Activity174Enum.WareType.Hero then
		for iter_18_0, iter_18_1 in pairs(arg_18_0.heroList) do
			if iter_18_1 == arg_18_1 then
				arg_18_0.heroList[iter_18_0] = nil
				arg_18_0.skillList[iter_18_0] = nil

				arg_18_0:updateBattleHeroInfo(iter_18_0)
				arg_18_0:caculateSelectIndex()

				break
			end
		end
	else
		for iter_18_2, iter_18_3 in pairs(arg_18_0.equipList) do
			if iter_18_3 == arg_18_1 then
				arg_18_0.equipList[iter_18_2] = nil

				arg_18_0:updateBattleHeroInfo(iter_18_2)
				arg_18_0:caculateSelectIndex()

				break
			end
		end
	end
end

function var_0_0.caculateSelectIndex(arg_19_0)
	local var_19_0

	if arg_19_0.wareType == Activity174Enum.WareType.Hero then
		var_19_0 = arg_19_0.heroList
	else
		var_19_0 = arg_19_0.equipList
	end

	for iter_19_0 = 1, arg_19_0.unLockTeamCnt * 4 do
		if iter_19_0 == arg_19_0.unLockTeamCnt * 4 then
			if var_19_0[iter_19_0] then
				arg_19_0.selectHeroIndex = 0
			else
				arg_19_0.selectHeroIndex = iter_19_0
			end
		elseif not var_19_0[iter_19_0] then
			arg_19_0.selectHeroIndex = iter_19_0

			break
		end
	end

	arg_19_0:refreshSelect()
end

function var_0_0.updateBattleHeroInfo(arg_20_0, arg_20_1)
	local var_20_0, var_20_1 = Activity174Helper.CalculateRowColumn(arg_20_1)
	local var_20_2 = {
		index = var_20_1,
		heroId = arg_20_0.heroList[arg_20_1],
		itemId = arg_20_0.equipList[arg_20_1],
		priorSkill = arg_20_0.skillList[arg_20_1]
	}

	Activity174Model.instance:getActInfo():getGameInfo():setBattleHeroInTeam(var_20_0, var_20_1, var_20_2)
	arg_20_0:refreshHeroItem(arg_20_1)
	arg_20_0:refreshEquipItem(arg_20_1)
end

function var_0_0.clickHero(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0.heroList[arg_21_1]

	if var_21_0 then
		local var_21_1 = Activity174Config.instance:getRoleCo(var_21_0)
		local var_21_2 = arg_21_0.equipList[arg_21_1]

		if var_21_1 then
			arg_21_0.characterInfo:setData(var_21_1, var_21_2, arg_21_1)
			gohelper.setActive(arg_21_0._goCharacterInfo, true)
		end
	else
		arg_21_0.selectHeroIndex = arg_21_1

		arg_21_0:refreshSelect()
	end
end

function var_0_0.clickCollection(arg_22_0, arg_22_1)
	if arg_22_0.equipList[arg_22_1] then
		local var_22_0 = {
			type = Activity174Enum.ItemTipType.Collection,
			co = Activity174Config.instance:getCollectionCo(arg_22_0.equipList[arg_22_1])
		}

		var_22_0.showMask = true
		var_22_0.needUninstall = true
		var_22_0.index = arg_22_1

		Activity174Controller.instance:openItemTipView(var_22_0)
	else
		arg_22_0.selectHeroIndex = arg_22_1

		arg_22_0:refreshSelect()
	end
end

function var_0_0.UnInstallHero(arg_23_0, arg_23_1)
	arg_23_0.heroList[arg_23_1] = nil
	arg_23_0.skillList[arg_23_1] = nil

	arg_23_0:updateBattleHeroInfo(arg_23_1)
	arg_23_0:caculateSelectIndex()
end

function var_0_0.UnInstallCollection(arg_24_0, arg_24_1)
	arg_24_0.equipList[arg_24_1] = nil

	arg_24_0:updateBattleHeroInfo(arg_24_1)
	arg_24_0:caculateSelectIndex()
end

function var_0_0.exchangeHeroItem(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = arg_25_0.heroList[arg_25_1]

	arg_25_0.heroList[arg_25_1] = arg_25_0.heroList[arg_25_2]
	arg_25_0.heroList[arg_25_2] = var_25_0

	local var_25_1 = arg_25_0.skillList[arg_25_1]

	arg_25_0.skillList[arg_25_1] = arg_25_0.skillList[arg_25_2]
	arg_25_0.skillList[arg_25_2] = var_25_1

	local var_25_2 = arg_25_0.heroItemList[arg_25_1]

	arg_25_0.heroItemList[arg_25_1] = arg_25_0.heroItemList[arg_25_2]

	arg_25_0.heroItemList[arg_25_1]:setIndex(arg_25_1)

	arg_25_0.heroItemList[arg_25_2] = var_25_2

	arg_25_0.heroItemList[arg_25_2]:setIndex(arg_25_2)
	arg_25_0:caculateSelectIndex()
	arg_25_0:updateBattleHeroInfo(arg_25_1)
	arg_25_0:updateBattleHeroInfo(arg_25_2)
	arg_25_0:caculateSelectIndex()
end

function var_0_0.exchangeEquipItem(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = arg_26_0.equipList[arg_26_1]

	arg_26_0.equipList[arg_26_1] = arg_26_0.equipList[arg_26_2]
	arg_26_0.equipList[arg_26_2] = var_26_0

	local var_26_1 = arg_26_0.equipItemList[arg_26_1]

	arg_26_0.equipItemList[arg_26_1] = arg_26_0.equipItemList[arg_26_2]

	arg_26_0.equipItemList[arg_26_1]:setIndex(arg_26_1)

	arg_26_0.equipItemList[arg_26_2] = var_26_1

	arg_26_0.equipItemList[arg_26_2]:setIndex(arg_26_2)
	arg_26_0:caculateSelectIndex()
	arg_26_0:updateBattleHeroInfo(arg_26_1)
	arg_26_0:updateBattleHeroInfo(arg_26_2)
	arg_26_0:caculateSelectIndex()
end

function var_0_0.checkOnlyCollection(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = arg_27_1 * 4

	for iter_27_0 = var_27_0, var_27_0 - 3, -1 do
		if arg_27_0.equipList[iter_27_0] == arg_27_2 then
			return false
		end
	end

	return true
end

function var_0_0.refreshSelect(arg_28_0)
	for iter_28_0 = 1, 12 do
		gohelper.setActive(arg_28_0["_goFrameSelect" .. iter_28_0], iter_28_0 == arg_28_0.selectHeroIndex)
	end
end

function var_0_0.getPriorSkill(arg_29_0, arg_29_1)
	for iter_29_0, iter_29_1 in pairs(arg_29_0.heroList) do
		if iter_29_1 == arg_29_1 then
			return arg_29_0.skillList[iter_29_0]
		end
	end

	logError("dont exsit heroId" .. arg_29_1)
end

function var_0_0.setPriorSkill(arg_30_0, arg_30_1, arg_30_2)
	for iter_30_0, iter_30_1 in pairs(arg_30_0.heroList) do
		if iter_30_1 == arg_30_1 then
			arg_30_0.skillList[iter_30_0] = arg_30_2

			arg_30_0:updateBattleHeroInfo(iter_30_0)

			return
		end
	end

	logError("dont exsit heroId" .. arg_30_1)
end

function var_0_0.checkUnlockTeamAnim(arg_31_0, arg_31_1)
	local var_31_0 = GameUtil.playerPrefsGetNumberByUserId("Act174UnlockTeamCnt", 0)
	local var_31_1 = arg_31_1 - var_31_0

	if var_31_1 > 0 then
		for iter_31_0 = var_31_0 + 1, var_31_1 do
			gohelper.setActive(arg_31_0["_goLock" .. iter_31_0], true)
			arg_31_0["animLock" .. iter_31_0]:Play("unlock")
		end

		TaskDispatcher.runDelay(arg_31_0.unlockTeamAnimEnd, arg_31_0, 1)
		GameUtil.playerPrefsSetNumberByUserId("Act174UnlockTeamCnt", arg_31_1)
	end
end

function var_0_0.unlockTeamAnimEnd(arg_32_0)
	for iter_32_0 = 1, 3 do
		gohelper.setActive(arg_32_0["_goLock" .. iter_32_0], iter_32_0 > arg_32_0.unLockTeamCnt)
	end
end

function var_0_0.canEquipMove(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = true
	local var_33_1 = Activity174Helper.CalculateRowColumn(arg_33_2)
	local var_33_2 = Activity174Helper.CalculateRowColumn(arg_33_1)

	if var_33_1 ~= var_33_2 then
		local var_33_3 = arg_33_0.equipList[arg_33_1]
		local var_33_4 = arg_33_0.equipList[arg_33_2]

		if var_33_3 and Activity174Config.instance:getCollectionCo(var_33_3).unique == 1 and not arg_33_0:checkOnlyCollection(var_33_1, var_33_3) then
			var_33_0 = false
		end

		if var_33_4 and Activity174Config.instance:getCollectionCo(var_33_4).unique == 1 and not arg_33_0:checkOnlyCollection(var_33_2, var_33_4) then
			var_33_0 = false
		end
	end

	return var_33_0
end

return var_0_0
