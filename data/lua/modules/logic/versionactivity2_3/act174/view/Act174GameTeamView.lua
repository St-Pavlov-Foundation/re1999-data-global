module("modules.logic.versionactivity2_3.act174.view.Act174GameTeamView", package.seeall)

slot0 = class("Act174GameTeamView", BaseView)

function slot0.onInitView(slot0)
	slot0._goTeamRoot = gohelper.findChild(slot0.viewGO, "#go_EditTeam/go_TeamRoot")
	slot0._goHeroGroup = gohelper.findChild(slot0.viewGO, "#go_EditTeam/go_TeamRoot/go_HeroGroup")
	slot0._goEquipGroup = gohelper.findChild(slot0.viewGO, "#go_EditTeam/go_TeamRoot/go_EquipGroup")
	slot0._goHeroMask = gohelper.findChild(slot0.viewGO, "#go_EditTeam/go_TeamRoot/go_HeroMask")
	slot0._goLock1 = gohelper.findChild(slot0.viewGO, "#go_EditTeam/go_TeamRoot/go_Lock1")
	slot0._txtUnlock1 = gohelper.findChildText(slot0.viewGO, "#go_EditTeam/go_TeamRoot/go_Lock1/txt_Unlock1")
	slot0._goLock2 = gohelper.findChild(slot0.viewGO, "#go_EditTeam/go_TeamRoot/go_Lock2")
	slot0._txtUnlock2 = gohelper.findChildText(slot0.viewGO, "#go_EditTeam/go_TeamRoot/go_Lock2/txt_Unlock2")
	slot0._goLock3 = gohelper.findChild(slot0.viewGO, "#go_EditTeam/go_TeamRoot/go_Lock3")
	slot0._txtUnlock3 = gohelper.findChildText(slot0.viewGO, "#go_EditTeam/go_TeamRoot/go_Lock3/txt_Unlock3")
	slot0._goCharacterInfo = gohelper.findChild(slot0.viewGO, "go_characterinfo")
	slot0.animLock1 = slot0._goLock1:GetComponent(gohelper.Type_Animator)
	slot0.animLock2 = slot0._goLock2:GetComponent(gohelper.Type_Animator)
	slot0.animLock3 = slot0._goLock3:GetComponent(gohelper.Type_Animator)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addClickCb(slot0.btnCharacterBg, slot0.onClickCharacterBg, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeClickCb(slot0.btnCharacterBg)
end

function slot0.onClickCharacterBg(slot0)
	gohelper.setActive(slot0._goCharacterInfo, false)
end

function slot0._editableInitView(slot0)
	slot0.btnCharacterBg = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_characterinfo/btn_CloseCharacterInfo")
	slot0.characterInfo = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._goCharacterInfo, Act174CharacterInfo, slot0)

	gohelper.setActive(slot0._goHeroGroup, true)
	gohelper.setActive(slot0._goEquipGroup, false)

	slot0.wareType = Activity174Enum.WareType.Hero

	slot0:initFrame()
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.actId = Activity174Model.instance:getCurActId()
	slot0.unLockTeamCnt = Activity174Config.instance:getTurnCo(slot0.actId, Activity174Model.instance:getActInfo():getGameInfo().gameCount).groupNum

	slot0:creatHeroEquipItem()
	slot0:refreshTeamLock()
	slot0:refreshTeamGroup()
	slot0:caculateSelectIndex()
	slot0:addEventCb(Activity174Controller.instance, Activity174Event.WareHouseTypeChange, slot0.OnWareTypeChange, slot0)
	slot0:addEventCb(Activity174Controller.instance, Activity174Event.WareItemInstall, slot0.OnInstallItem, slot0)
	slot0:addEventCb(Activity174Controller.instance, Activity174Event.WareItemRemove, slot0.OnRemoveItem, slot0)
	slot0:addEventCb(Activity174Controller.instance, Activity174Event.UnEquipCollection, slot0.UnInstallCollection, slot0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0.unlockTeamAnimEnd, slot0)
end

function slot0.initFrame(slot0)
	slot0.frameTrList = {}

	for slot4 = 1, 12 do
		slot5 = gohelper.findChild(slot0.viewGO, "#go_EditTeam/go_TeamRoot/FrameRoot/frame" .. slot4)
		slot0["_goFrameSelect" .. slot4] = gohelper.findChild(slot5, "select")
		slot0.frameTrList[slot4] = slot5.transform
	end
end

function slot0.refreshTeamLock(slot0)
	for slot4 = 1, 3 do
		gohelper.setActive(slot0["_goLock" .. slot4], slot0.unLockTeamCnt < slot4)

		slot0["_txtUnlock" .. slot4].text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("act174_team_unlocktip"), GameUtil.getNum2Chinese(Activity174Config.instance:getUnlockLevel(slot0.actId, slot4) - 1))
	end

	slot0:checkUnlockTeamAnim(slot0.unLockTeamCnt)
end

function slot0.creatHeroEquipItem(slot0)
	slot0.heroItemList = {}
	slot0.equipItemList = {}
	slot1 = gohelper.findChild(slot0._goHeroGroup, "HeroItem")
	slot2 = gohelper.findChild(slot0._goEquipGroup, "EquipItem")

	for slot7 = 1, 12 do
		slot8, slot9 = recthelper.getAnchor(slot0.frameTrList[slot7])
		slot10 = gohelper.cloneInPlace(slot1)

		recthelper.setAnchor(slot10.transform, slot8, slot9)

		slot11 = MonoHelper.addNoUpdateLuaComOnceToGo(slot10, Act174HeroItem, slot0)

		slot11:setIndex(slot7)
		slot11:activeEquip(true)

		slot0.heroItemList[slot7] = slot11
		slot12 = gohelper.cloneInPlace(slot2)

		recthelper.setAnchor(slot12.transform, slot8, slot9)

		slot13 = MonoHelper.addNoUpdateLuaComOnceToGo(slot12, Act174EquipItem, slot0)

		slot13:setIndex(slot7)

		slot0.equipItemList[slot7] = slot13

		recthelper.setAnchor(gohelper.cloneInPlace(gohelper.findChild(slot0._goHeroMask, "mask")).transform, slot8, slot9)
	end

	gohelper.setActive(slot1, false)
	gohelper.setActive(slot2, false)
end

function slot0.refreshTeamGroup(slot0)
	slot0.heroList = {}
	slot0.equipList = {}
	slot0.skillList = {}
	slot0.teamMoList = Activity174Model.instance:getActInfo():getGameInfo():getTeamMoList()

	for slot5, slot6 in ipairs(slot0.teamMoList) do
		for slot12 = 1, 4 do
			if slot6.battleHeroInfo[slot12] then
				if slot13.heroId ~= 0 then
					slot0.heroList[(slot6.index - 1) * 4 + slot13.index] = slot13.heroId
				end

				if slot13.itemId ~= 0 then
					slot0.equipList[slot14] = slot13.itemId
				end

				if slot13.priorSkill ~= 0 then
					slot0.skillList[slot14] = slot13.priorSkill
				end

				slot0:refreshHeroItem(slot14)
				slot0:refreshEquipItem(slot14)
			end
		end
	end
end

function slot0.refreshHeroItem(slot0, slot1)
	slot0.heroItemList[slot1]:setData(slot0.heroList[slot1], slot0.equipList[slot1], slot0.skillList[slot1])
end

function slot0.refreshEquipItem(slot0, slot1)
	slot0.equipItemList[slot1]:setData(slot0.equipList[slot1])
end

function slot0.OnWareTypeChange(slot0, slot1)
	slot0.wareType = slot1

	for slot5, slot6 in ipairs(slot0.heroItemList) do
		slot6:activeEquip(slot1 == Activity174Enum.WareType.Hero)
	end

	gohelper.setActive(slot0._goEquipGroup, slot1 == Activity174Enum.WareType.Collection)
	slot0:caculateSelectIndex()
end

function slot0.OnInstallItem(slot0, slot1)
	if slot0.wareType == Activity174Enum.WareType.Hero then
		if slot0.selectHeroIndex == 0 then
			GameFacade.showToast(ToastEnum.Act174TeamGroupFull)
		else
			slot0.heroList[slot2] = slot1

			slot0:updateBattleHeroInfo(slot0.selectHeroIndex)

			slot3 = nil

			for slot7 = slot0.selectHeroIndex + 1, slot0.unLockTeamCnt * 4 do
				if not slot0.heroList[slot7] then
					slot3 = slot7

					break
				end
			end

			if slot3 then
				slot0.selectHeroIndex = slot3

				slot0:refreshSelect()
			else
				slot0:caculateSelectIndex()
			end
		end
	elseif slot2 == 0 then
		GameFacade.showToast(ToastEnum.Act174CollectionFull)
	else
		if lua_activity174_collection.configDict[slot1].unique == 1 and not slot0:checkOnlyCollection(Activity174Helper.CalculateRowColumn(slot2), slot1) then
			GameFacade.showToast(ToastEnum.Act174OnlyCollection)

			return
		end

		slot0.equipList[slot2] = slot1

		slot0:updateBattleHeroInfo(slot0.selectHeroIndex)

		slot4 = nil

		for slot8 = slot0.selectHeroIndex + 1, slot0.unLockTeamCnt * 4 do
			if not slot0.equipList[slot8] then
				slot4 = slot8

				break
			end
		end

		if slot4 then
			slot0.selectHeroIndex = slot4

			slot0:refreshSelect()
		else
			slot0:caculateSelectIndex()
		end
	end
end

function slot0.OnRemoveItem(slot0, slot1)
	slot2 = nil

	if slot0.wareType == Activity174Enum.WareType.Hero then
		for slot6, slot7 in pairs(slot0.heroList) do
			if slot7 == slot1 then
				slot0.heroList[slot6] = nil
				slot0.skillList[slot6] = nil

				slot0:updateBattleHeroInfo(slot6)
				slot0:caculateSelectIndex()

				break
			end
		end
	else
		for slot6, slot7 in pairs(slot0.equipList) do
			if slot7 == slot1 then
				slot0.equipList[slot6] = nil

				slot0:updateBattleHeroInfo(slot6)
				slot0:caculateSelectIndex()

				break
			end
		end
	end
end

function slot0.caculateSelectIndex(slot0)
	slot1 = nil

	for slot5 = 1, slot0.unLockTeamCnt * 4 do
		if slot5 == slot0.unLockTeamCnt * 4 then
			if ((slot0.wareType ~= Activity174Enum.WareType.Hero or slot0.heroList) and slot0.equipList)[slot5] then
				slot0.selectHeroIndex = 0
			else
				slot0.selectHeroIndex = slot5
			end
		elseif not slot1[slot5] then
			slot0.selectHeroIndex = slot5

			break
		end
	end

	slot0:refreshSelect()
end

function slot0.updateBattleHeroInfo(slot0, slot1)
	slot2, slot3 = Activity174Helper.CalculateRowColumn(slot1)

	Activity174Model.instance:getActInfo():getGameInfo():setBattleHeroInTeam(slot2, slot3, {
		index = slot3,
		heroId = slot0.heroList[slot1],
		itemId = slot0.equipList[slot1],
		priorSkill = slot0.skillList[slot1]
	})
	slot0:refreshHeroItem(slot1)
	slot0:refreshEquipItem(slot1)
end

function slot0.clickHero(slot0, slot1)
	if slot0.heroList[slot1] then
		if Activity174Config.instance:getRoleCo(slot2) then
			slot0.characterInfo:setData(slot3, slot0.equipList[slot1], slot1)
			gohelper.setActive(slot0._goCharacterInfo, true)
		end
	else
		slot0.selectHeroIndex = slot1

		slot0:refreshSelect()
	end
end

function slot0.clickCollection(slot0, slot1)
	if slot0.equipList[slot1] then
		Activity174Controller.instance:openItemTipView({
			type = Activity174Enum.ItemTipType.Collection,
			co = Activity174Config.instance:getCollectionCo(slot0.equipList[slot1]),
			showMask = true,
			needUninstall = true,
			index = slot1
		})
	else
		slot0.selectHeroIndex = slot1

		slot0:refreshSelect()
	end
end

function slot0.UnInstallHero(slot0, slot1)
	slot0.heroList[slot1] = nil
	slot0.skillList[slot1] = nil

	slot0:updateBattleHeroInfo(slot1)
	slot0:caculateSelectIndex()
end

function slot0.UnInstallCollection(slot0, slot1)
	slot0.equipList[slot1] = nil

	slot0:updateBattleHeroInfo(slot1)
	slot0:caculateSelectIndex()
end

function slot0.exchangeHeroItem(slot0, slot1, slot2)
	slot0.heroList[slot1] = slot0.heroList[slot2]
	slot0.heroList[slot2] = slot0.heroList[slot1]
	slot0.skillList[slot1] = slot0.skillList[slot2]
	slot0.skillList[slot2] = slot0.skillList[slot1]
	slot0.heroItemList[slot1] = slot0.heroItemList[slot2]

	slot0.heroItemList[slot1]:setIndex(slot1)

	slot0.heroItemList[slot2] = slot0.heroItemList[slot1]

	slot0.heroItemList[slot2]:setIndex(slot2)
	slot0:caculateSelectIndex()
	slot0:updateBattleHeroInfo(slot1)
	slot0:updateBattleHeroInfo(slot2)
	slot0:caculateSelectIndex()
end

function slot0.exchangeEquipItem(slot0, slot1, slot2)
	slot0.equipList[slot1] = slot0.equipList[slot2]
	slot0.equipList[slot2] = slot0.equipList[slot1]
	slot0.equipItemList[slot1] = slot0.equipItemList[slot2]

	slot0.equipItemList[slot1]:setIndex(slot1)

	slot0.equipItemList[slot2] = slot0.equipItemList[slot1]

	slot0.equipItemList[slot2]:setIndex(slot2)
	slot0:caculateSelectIndex()
	slot0:updateBattleHeroInfo(slot1)
	slot0:updateBattleHeroInfo(slot2)
	slot0:caculateSelectIndex()
end

function slot0.checkOnlyCollection(slot0, slot1, slot2)
	slot3 = slot1 * 4

	for slot7 = slot3, slot3 - 3, -1 do
		if slot0.equipList[slot7] == slot2 then
			return false
		end
	end

	return true
end

function slot0.refreshSelect(slot0)
	for slot4 = 1, 12 do
		gohelper.setActive(slot0["_goFrameSelect" .. slot4], slot4 == slot0.selectHeroIndex)
	end
end

function slot0.getPriorSkill(slot0, slot1)
	for slot5, slot6 in pairs(slot0.heroList) do
		if slot6 == slot1 then
			return slot0.skillList[slot5]
		end
	end

	logError("dont exsit heroId" .. slot1)
end

function slot0.setPriorSkill(slot0, slot1, slot2)
	for slot6, slot7 in pairs(slot0.heroList) do
		if slot7 == slot1 then
			slot0.skillList[slot6] = slot2

			slot0:updateBattleHeroInfo(slot6)

			return
		end
	end

	logError("dont exsit heroId" .. slot1)
end

function slot0.checkUnlockTeamAnim(slot0, slot1)
	if slot1 - GameUtil.playerPrefsGetNumberByUserId("Act174UnlockTeamCnt", 0) > 0 then
		for slot7 = slot2 + 1, slot3 do
			gohelper.setActive(slot0["_goLock" .. slot7], true)
			slot0["animLock" .. slot7]:Play("unlock")
		end

		TaskDispatcher.runDelay(slot0.unlockTeamAnimEnd, slot0, 1)
		GameUtil.playerPrefsSetNumberByUserId("Act174UnlockTeamCnt", slot1)
	end
end

function slot0.unlockTeamAnimEnd(slot0)
	for slot4 = 1, 3 do
		gohelper.setActive(slot0["_goLock" .. slot4], slot0.unLockTeamCnt < slot4)
	end
end

function slot0.canEquipMove(slot0, slot1, slot2)
	slot3 = true

	if Activity174Helper.CalculateRowColumn(slot2) ~= Activity174Helper.CalculateRowColumn(slot1) then
		slot7 = slot0.equipList[slot2]

		if slot0.equipList[slot1] and Activity174Config.instance:getCollectionCo(slot6).unique == 1 and not slot0:checkOnlyCollection(slot4, slot6) then
			slot3 = false
		end

		if slot7 and Activity174Config.instance:getCollectionCo(slot7).unique == 1 and not slot0:checkOnlyCollection(slot5, slot7) then
			slot3 = false
		end
	end

	return slot3
end

return slot0
