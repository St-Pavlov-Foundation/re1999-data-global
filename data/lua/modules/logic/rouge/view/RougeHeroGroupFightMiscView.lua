module("modules.logic.rouge.view.RougeHeroGroupFightMiscView", package.seeall)

slot0 = class("RougeHeroGroupFightMiscView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnbag = gohelper.findChildButtonWithAudio(slot0.viewGO, "rouge/#btn_bag")
	slot0._btnliupai = gohelper.findChildButtonWithAudio(slot0.viewGO, "rouge/#btn_liupai")
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "rouge/#btn_liupai/liupai/#image_icon")
	slot0._godetail = gohelper.findChild(slot0.viewGO, "rouge/#btn_liupai/liupai/#go_detail")
	slot0._txtdec = gohelper.findChildText(slot0.viewGO, "rouge/#btn_liupai/liupai/#go_detail/#txt_dec")
	slot0._gozhouyu = gohelper.findChild(slot0.viewGO, "rouge/#btn_liupai/#go_zhouyu")
	slot0._goskillitem = gohelper.findChild(slot0.viewGO, "rouge/#btn_liupai/#go_zhouyu/#go_skillitem")
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "rouge/leftbg/#txt_title")
	slot0._txttitleen = gohelper.findChildText(slot0.viewGO, "rouge/leftbg/#txt_title/#txt_en")
	slot0._godetail2 = gohelper.findChild(slot0.viewGO, "rouge/#btn_liupai/#go_zhouyu/#go_detail2")
	slot0._txtdec2 = gohelper.findChildText(slot0.viewGO, "rouge/#btn_liupai/#go_zhouyu/#go_detail2/#txt_dec2")
	slot0._imageskillicon = gohelper.findChildImage(slot0.viewGO, "rouge/#btn_liupai/#go_zhouyu/#go_detail2/icon")
	slot0._gorouge = gohelper.findChild(slot0.viewGO, "rouge")
	slot0._aniamtor = gohelper.onceAddComponent(slot0._gorouge, gohelper.Type_Animator)
	slot0._skillItemList = slot0:getUserDataTb_()

	slot0:_initCapacity()
	slot0:_updateHeroList()
end

function slot0._initCapacity(slot0)
	slot0._rougeCapacityComp = RougeCapacityComp.Add(gohelper.findChild(slot0.viewGO, "rouge/bg/volume"), 0, RougeModel.instance:getTeamCapacity(), true, RougeCapacityComp.SpriteType2)
end

function slot0.addEvents(slot0)
	slot0._btnbag:AddClickListener(slot0._btnbagOnClick, slot0)
	slot0._btnliupai:AddClickListener(slot0._btnliupaiOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnbag:RemoveClickListener()
	slot0._btnliupai:RemoveClickListener()
end

function slot0._setBtnStatus(slot0, slot1, slot2, slot3)
	gohelper.setActive(slot2, not slot1)
	gohelper.setActive(slot3, slot1)
end

function slot0._btnbagOnClick(slot0)
	RougeController.instance:openRougeCollectionChessView()
end

function slot0._btnliupaiOnClick(slot0)
	slot0._showDetail = true

	gohelper.setActive(slot0._godetail, true)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(RougeHeroGroupController.instance, HeroGroupEvent.OnClickHeroGroupItem, slot0._onClickHeroGroupAssitItem, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnClickHeroGroupItem, slot0._onClickHeroGroupItem, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, slot0._updateHeroList, slot0)
	GameStateMgr.instance:registerCallback(GameStateEvent.OnTouchScreenUp, slot0._onTouchScreenUp, slot0)

	slot0._season = RougeConfig1.instance:season()
	slot0._rougeInfo = RougeModel.instance:getRougeInfo()
	slot0._styleConfig = RougeConfig1.instance:getStyleConfig(RougeModel.instance:getStyle())

	gohelper.setActive(slot0._godetail, false)
	gohelper.setActive(slot0._godetail2, false)
	slot0:_initIcon()
	slot0:_initSkill()
	slot0:_initEpisodeName()
end

function slot0._initEpisodeName(slot0)
	slot0._txttitle.text = ""
	slot0._txttitleen.text = ""

	if not DungeonConfig.instance:getEpisodeCO(RougeHeroGroupModel.instance.episodeId) then
		return
	end

	slot0._txttitleen.text = slot2.name_En

	if utf8.len(slot2.name) <= 0 then
		return
	end

	slot0._txttitle.text = string.format("<size=77>%s</size>%s", utf8.sub(slot3, 1, 2), utf8.sub(slot3, 2, slot4 + 1))
end

function slot0._initIcon(slot0)
	slot3 = lua_rouge_style.configDict[slot0._rougeInfo.season][slot0._rougeInfo.style]
	slot0._txtdec.text = slot3.desc

	UISpriteSetMgr.instance:setRouge2Sprite(slot0._imageicon, string.format("%s_light", slot3.icon))
end

function slot0._initSkill(slot0)
	slot3 = {}

	for slot7, slot8 in ipairs(RougeDLCHelper.getCurrentUseStyleFightSkills(slot0._styleConfig.id)) do
		slot9 = slot0:_getOrCreateSkillItem(slot7)

		if not string.nilorempty(RougeOutsideModel.instance:config():getSkillCo(slot8.type, slot8.skillId) and slot10.icon) then
			UISpriteSetMgr.instance:setRouge2Sprite(slot9.imagenormalicon, slot11, true)
			UISpriteSetMgr.instance:setRouge2Sprite(slot9.imagselecticon, slot11 .. "_light", true)
		else
			logError(string.format("未配置肉鸽流派技能图标, 技能类型 = %s, 技能id = %s", slot8.type, slot8.skillId))
		end

		slot0["_skillDesc" .. slot7] = slot10 and slot10.desc
		slot0["_skillIcon" .. slot7] = slot10 and slot10.icon

		gohelper.setActive(slot9.viewGO, true)

		slot3[slot9] = true
	end

	for slot7, slot8 in ipairs(slot0._skillItemList) do
		if not slot3[slot8] then
			gohelper.setActive(slot8.viewGO, false)
		end
	end

	gohelper.setActive(slot0._gozhouyu, slot1 and #slot1 > 0)
end

function slot0._getOrCreateSkillItem(slot0, slot1)
	if not (slot0._skillItemList and slot0._skillItemList[slot1]) then
		slot2 = slot0:getUserDataTb_()
		slot2.viewGO = gohelper.cloneInPlace(slot0._goskillitem, "item_" .. slot1)
		slot2.gonormal = gohelper.findChild(slot2.viewGO, "go_normal")
		slot2.imagenormalicon = gohelper.findChildImage(slot2.viewGO, "go_normal/image_icon")
		slot2.goselect = gohelper.findChild(slot2.viewGO, "go_select")
		slot2.imagselecticon = gohelper.findChildImage(slot2.viewGO, "go_select/image_icon")
		slot2.btnclick = gohelper.findChildButtonWithAudio(slot2.viewGO, "btn_click")

		slot2.btnclick:AddClickListener(slot0._btnskillOnClick, slot0, slot1)
		table.insert(slot0._skillItemList, slot2)
	end

	return slot2
end

function slot0._btnskillOnClick(slot0, slot1)
	slot0._showTips = true
	slot0._txtdec2.text = slot0["_skillDesc" .. slot1]

	UISpriteSetMgr.instance:setRouge2Sprite(slot0._imageskillicon, slot0["_skillIcon" .. slot1], true)
	gohelper.setActive(slot0._godetail2, false)
	gohelper.setActive(slot0._godetail2, true)
	gohelper.setAsLastSibling(slot0._godetail2)
	slot0:_refreshAllBtnStatus(slot1)
end

function slot0._refreshAllBtnStatus(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._skillItemList) do
		slot0:_setBtnStatus(slot1 == slot5, slot6.gonormal, slot6.goselect)
	end
end

function slot0._removeAllSkillClickListener(slot0)
	if slot0._skillItemList then
		for slot4, slot5 in pairs(slot0._skillItemList) do
			if slot5.btnclick then
				slot5.btnclick:RemoveClickListener()
			end
		end
	end
end

function slot0._onTouchScreenUp(slot0)
	if slot0._showDetail then
		slot0._showDetail = false
	else
		gohelper.setActive(slot0._godetail, false)
	end

	if slot0._showTips then
		slot0._showTips = false

		return
	end

	gohelper.setActive(slot0._godetail2, false)
	slot0:_refreshAllBtnStatus()
end

function slot0._onClickHeroGroupAssitItem(slot0, slot1)
	slot0:_openRougeHeroGroupEditView(slot1, RougeEnum.HeroGroupEditType.FightAssit)
end

function slot0._onClickHeroGroupItem(slot0, slot1)
	slot0:_openRougeHeroGroupEditView(slot1, RougeEnum.HeroGroupEditType.Fight)
end

function slot0._openRougeHeroGroupEditView(slot0, slot1, slot2)
	slot6 = RougeHeroSingleGroupModel.instance:getById(slot1) and slot5:getHeroMO()

	ViewMgr.instance:openView(ViewName.RougeHeroGroupEditView, {
		singleGroupMOId = slot1,
		originalHeroUid = RougeHeroSingleGroupModel.instance:getHeroUid(slot1),
		equips = RougeHeroGroupModel.instance:getCurGroupMO():getPosEquips(slot1 - 1).equipUid,
		heroGroupEditType = slot2,
		selectHeroCapacity = slot6 and RougeConfig1.instance:getRoleCapacity(slot6.config.rare) or 0,
		curCapacity = slot0._rougeCapacityComp:getCurNum(),
		totalCapacity = slot0._rougeCapacityComp:getMaxNum()
	})
end

function slot0._updateHeroList(slot0)
	for slot5 = 1, RougeEnum.FightTeamHeroNum do
		slot8 = 0
		slot1 = 0 + RougeController.instance:getRoleStyleCapacity(RougeHeroSingleGroupModel.instance:getById(slot5) and slot6:getHeroMO(), RougeEnum.FightTeamNormalHeroNum < slot5)
	end

	slot0._rougeCapacityComp:updateCurNum(slot1)
end

function slot0.onOpenFinish(slot0)
	if RougeController.instance:checkNeedContinueFight() then
		slot0._canvasGroup = gohelper.onceAddComponent(slot0.viewGO, typeof(UnityEngine.CanvasGroup))
		slot0._canvasGroup.interactable = false
		slot0._canvasGroup.blocksRaycasts = false

		TaskDispatcher.cancelTask(slot0._delayModifyCanvasGroup, slot0)
		TaskDispatcher.runDelay(slot0._delayModifyCanvasGroup, slot0, 5)
	end
end

function slot0._delayModifyCanvasGroup(slot0)
	if not slot0._canvasGroup then
		return
	end

	slot0._canvasGroup.interactable = true
	slot0._canvasGroup.blocksRaycasts = true
end

function slot0.onClose(slot0)
	GameStateMgr.instance:unregisterCallback(GameStateEvent.OnTouchScreenUp, slot0._onTouchScreenUp, slot0)
	TaskDispatcher.cancelTask(slot0._delayModifyCanvasGroup, slot0)
	slot0._aniamtor:Play("close", 0, 0)
	slot0:_removeAllSkillClickListener()
end

return slot0
