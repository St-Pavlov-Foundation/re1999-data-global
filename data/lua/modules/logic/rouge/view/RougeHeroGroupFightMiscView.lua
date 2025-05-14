module("modules.logic.rouge.view.RougeHeroGroupFightMiscView", package.seeall)

local var_0_0 = class("RougeHeroGroupFightMiscView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnbag = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rouge/#btn_bag")
	arg_1_0._btnliupai = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rouge/#btn_liupai")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "rouge/#btn_liupai/liupai/#image_icon")
	arg_1_0._godetail = gohelper.findChild(arg_1_0.viewGO, "rouge/#btn_liupai/liupai/#go_detail")
	arg_1_0._txtdec = gohelper.findChildText(arg_1_0.viewGO, "rouge/#btn_liupai/liupai/#go_detail/#txt_dec")
	arg_1_0._gozhouyu = gohelper.findChild(arg_1_0.viewGO, "rouge/#btn_liupai/#go_zhouyu")
	arg_1_0._goskillitem = gohelper.findChild(arg_1_0.viewGO, "rouge/#btn_liupai/#go_zhouyu/#go_skillitem")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "rouge/leftbg/#txt_title")
	arg_1_0._txttitleen = gohelper.findChildText(arg_1_0.viewGO, "rouge/leftbg/#txt_title/#txt_en")
	arg_1_0._godetail2 = gohelper.findChild(arg_1_0.viewGO, "rouge/#btn_liupai/#go_zhouyu/#go_detail2")
	arg_1_0._txtdec2 = gohelper.findChildText(arg_1_0.viewGO, "rouge/#btn_liupai/#go_zhouyu/#go_detail2/#txt_dec2")
	arg_1_0._imageskillicon = gohelper.findChildImage(arg_1_0.viewGO, "rouge/#btn_liupai/#go_zhouyu/#go_detail2/icon")
	arg_1_0._gorouge = gohelper.findChild(arg_1_0.viewGO, "rouge")
	arg_1_0._aniamtor = gohelper.onceAddComponent(arg_1_0._gorouge, gohelper.Type_Animator)
	arg_1_0._skillItemList = arg_1_0:getUserDataTb_()

	arg_1_0:_initCapacity()
	arg_1_0:_updateHeroList()
end

function var_0_0._initCapacity(arg_2_0)
	local var_2_0 = gohelper.findChild(arg_2_0.viewGO, "rouge/bg/volume")
	local var_2_1 = RougeModel.instance:getTeamCapacity()

	arg_2_0._rougeCapacityComp = RougeCapacityComp.Add(var_2_0, 0, var_2_1, true, RougeCapacityComp.SpriteType2)
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0._btnbag:AddClickListener(arg_3_0._btnbagOnClick, arg_3_0)
	arg_3_0._btnliupai:AddClickListener(arg_3_0._btnliupaiOnClick, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	arg_4_0._btnbag:RemoveClickListener()
	arg_4_0._btnliupai:RemoveClickListener()
end

function var_0_0._setBtnStatus(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	gohelper.setActive(arg_5_2, not arg_5_1)
	gohelper.setActive(arg_5_3, arg_5_1)
end

function var_0_0._btnbagOnClick(arg_6_0)
	RougeController.instance:openRougeCollectionChessView()
end

function var_0_0._btnliupaiOnClick(arg_7_0)
	arg_7_0._showDetail = true

	gohelper.setActive(arg_7_0._godetail, true)
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0:addEventCb(RougeHeroGroupController.instance, HeroGroupEvent.OnClickHeroGroupItem, arg_8_0._onClickHeroGroupAssitItem, arg_8_0)
	arg_8_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnClickHeroGroupItem, arg_8_0._onClickHeroGroupItem, arg_8_0)
	arg_8_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, arg_8_0._updateHeroList, arg_8_0)
	GameStateMgr.instance:registerCallback(GameStateEvent.OnTouchScreenUp, arg_8_0._onTouchScreenUp, arg_8_0)

	arg_8_0._season = RougeConfig1.instance:season()
	arg_8_0._rougeInfo = RougeModel.instance:getRougeInfo()

	local var_8_0 = RougeModel.instance:getStyle()

	arg_8_0._styleConfig = RougeConfig1.instance:getStyleConfig(var_8_0)

	gohelper.setActive(arg_8_0._godetail, false)
	gohelper.setActive(arg_8_0._godetail2, false)
	arg_8_0:_initIcon()
	arg_8_0:_initSkill()
	arg_8_0:_initEpisodeName()
end

function var_0_0._initEpisodeName(arg_9_0)
	arg_9_0._txttitle.text = ""
	arg_9_0._txttitleen.text = ""

	local var_9_0 = RougeHeroGroupModel.instance.episodeId
	local var_9_1 = DungeonConfig.instance:getEpisodeCO(var_9_0)

	if not var_9_1 then
		return
	end

	arg_9_0._txttitleen.text = var_9_1.name_En

	local var_9_2 = var_9_1.name
	local var_9_3 = utf8.len(var_9_2)

	if var_9_3 <= 0 then
		return
	end

	arg_9_0._txttitle.text = string.format("<size=77>%s</size>%s", utf8.sub(var_9_2, 1, 2), utf8.sub(var_9_2, 2, var_9_3 + 1))
end

function var_0_0._initIcon(arg_10_0)
	local var_10_0 = arg_10_0._rougeInfo.style
	local var_10_1 = arg_10_0._rougeInfo.season
	local var_10_2 = lua_rouge_style.configDict[var_10_1][var_10_0]

	arg_10_0._txtdec.text = var_10_2.desc

	UISpriteSetMgr.instance:setRouge2Sprite(arg_10_0._imageicon, string.format("%s_light", var_10_2.icon))
end

function var_0_0._initSkill(arg_11_0)
	local var_11_0 = RougeDLCHelper.getCurrentUseStyleFightSkills(arg_11_0._styleConfig.id)
	local var_11_1 = RougeOutsideModel.instance:config()
	local var_11_2 = {}

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		local var_11_3 = arg_11_0:_getOrCreateSkillItem(iter_11_0)
		local var_11_4 = var_11_1:getSkillCo(iter_11_1.type, iter_11_1.skillId)
		local var_11_5 = var_11_4 and var_11_4.icon

		if not string.nilorempty(var_11_5) then
			UISpriteSetMgr.instance:setRouge2Sprite(var_11_3.imagenormalicon, var_11_5, true)
			UISpriteSetMgr.instance:setRouge2Sprite(var_11_3.imagselecticon, var_11_5 .. "_light", true)
		else
			logError(string.format("未配置肉鸽流派技能图标, 技能类型 = %s, 技能id = %s", iter_11_1.type, iter_11_1.skillId))
		end

		arg_11_0["_skillDesc" .. iter_11_0] = var_11_4 and var_11_4.desc
		arg_11_0["_skillIcon" .. iter_11_0] = var_11_4 and var_11_4.icon

		gohelper.setActive(var_11_3.viewGO, true)

		var_11_2[var_11_3] = true
	end

	for iter_11_2, iter_11_3 in ipairs(arg_11_0._skillItemList) do
		if not var_11_2[iter_11_3] then
			gohelper.setActive(iter_11_3.viewGO, false)
		end
	end

	gohelper.setActive(arg_11_0._gozhouyu, var_11_0 and #var_11_0 > 0)
end

function var_0_0._getOrCreateSkillItem(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0._skillItemList and arg_12_0._skillItemList[arg_12_1]

	if not var_12_0 then
		var_12_0 = arg_12_0:getUserDataTb_()
		var_12_0.viewGO = gohelper.cloneInPlace(arg_12_0._goskillitem, "item_" .. arg_12_1)
		var_12_0.gonormal = gohelper.findChild(var_12_0.viewGO, "go_normal")
		var_12_0.imagenormalicon = gohelper.findChildImage(var_12_0.viewGO, "go_normal/image_icon")
		var_12_0.goselect = gohelper.findChild(var_12_0.viewGO, "go_select")
		var_12_0.imagselecticon = gohelper.findChildImage(var_12_0.viewGO, "go_select/image_icon")
		var_12_0.btnclick = gohelper.findChildButtonWithAudio(var_12_0.viewGO, "btn_click")

		var_12_0.btnclick:AddClickListener(arg_12_0._btnskillOnClick, arg_12_0, arg_12_1)
		table.insert(arg_12_0._skillItemList, var_12_0)
	end

	return var_12_0
end

function var_0_0._btnskillOnClick(arg_13_0, arg_13_1)
	arg_13_0._showTips = true
	arg_13_0._txtdec2.text = arg_13_0["_skillDesc" .. arg_13_1]

	UISpriteSetMgr.instance:setRouge2Sprite(arg_13_0._imageskillicon, arg_13_0["_skillIcon" .. arg_13_1], true)
	gohelper.setActive(arg_13_0._godetail2, false)
	gohelper.setActive(arg_13_0._godetail2, true)
	gohelper.setAsLastSibling(arg_13_0._godetail2)
	arg_13_0:_refreshAllBtnStatus(arg_13_1)
end

function var_0_0._refreshAllBtnStatus(arg_14_0, arg_14_1)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0._skillItemList) do
		local var_14_0 = arg_14_1 == iter_14_0

		arg_14_0:_setBtnStatus(var_14_0, iter_14_1.gonormal, iter_14_1.goselect)
	end
end

function var_0_0._removeAllSkillClickListener(arg_15_0)
	if arg_15_0._skillItemList then
		for iter_15_0, iter_15_1 in pairs(arg_15_0._skillItemList) do
			if iter_15_1.btnclick then
				iter_15_1.btnclick:RemoveClickListener()
			end
		end
	end
end

function var_0_0._onTouchScreenUp(arg_16_0)
	if arg_16_0._showDetail then
		arg_16_0._showDetail = false
	else
		gohelper.setActive(arg_16_0._godetail, false)
	end

	if arg_16_0._showTips then
		arg_16_0._showTips = false

		return
	end

	gohelper.setActive(arg_16_0._godetail2, false)
	arg_16_0:_refreshAllBtnStatus()
end

function var_0_0._onClickHeroGroupAssitItem(arg_17_0, arg_17_1)
	arg_17_0:_openRougeHeroGroupEditView(arg_17_1, RougeEnum.HeroGroupEditType.FightAssit)
end

function var_0_0._onClickHeroGroupItem(arg_18_0, arg_18_1)
	arg_18_0:_openRougeHeroGroupEditView(arg_18_1, RougeEnum.HeroGroupEditType.Fight)
end

function var_0_0._openRougeHeroGroupEditView(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = RougeHeroGroupModel.instance:getCurGroupMO():getPosEquips(arg_19_1 - 1).equipUid
	local var_19_1 = RougeHeroSingleGroupModel.instance:getById(arg_19_1)
	local var_19_2 = var_19_1 and var_19_1:getHeroMO()
	local var_19_3 = arg_19_0._rougeCapacityComp:getCurNum()
	local var_19_4 = arg_19_0._rougeCapacityComp:getMaxNum()
	local var_19_5 = var_19_2 and RougeConfig1.instance:getRoleCapacity(var_19_2.config.rare) or 0
	local var_19_6 = {
		singleGroupMOId = arg_19_1,
		originalHeroUid = RougeHeroSingleGroupModel.instance:getHeroUid(arg_19_1),
		equips = var_19_0,
		heroGroupEditType = arg_19_2,
		selectHeroCapacity = var_19_5,
		curCapacity = var_19_3,
		totalCapacity = var_19_4
	}

	ViewMgr.instance:openView(ViewName.RougeHeroGroupEditView, var_19_6)
end

function var_0_0._updateHeroList(arg_20_0)
	local var_20_0 = 0

	for iter_20_0 = 1, RougeEnum.FightTeamHeroNum do
		local var_20_1 = RougeHeroSingleGroupModel.instance:getById(iter_20_0)
		local var_20_2 = var_20_1 and var_20_1:getHeroMO()
		local var_20_3 = 0

		var_20_0 = var_20_0 + RougeController.instance:getRoleStyleCapacity(var_20_2, iter_20_0 > RougeEnum.FightTeamNormalHeroNum)
	end

	arg_20_0._rougeCapacityComp:updateCurNum(var_20_0)
end

function var_0_0.onOpenFinish(arg_21_0)
	if RougeController.instance:checkNeedContinueFight() then
		arg_21_0._canvasGroup = gohelper.onceAddComponent(arg_21_0.viewGO, typeof(UnityEngine.CanvasGroup))
		arg_21_0._canvasGroup.interactable = false
		arg_21_0._canvasGroup.blocksRaycasts = false

		TaskDispatcher.cancelTask(arg_21_0._delayModifyCanvasGroup, arg_21_0)
		TaskDispatcher.runDelay(arg_21_0._delayModifyCanvasGroup, arg_21_0, 5)
	end
end

function var_0_0._delayModifyCanvasGroup(arg_22_0)
	if not arg_22_0._canvasGroup then
		return
	end

	arg_22_0._canvasGroup.interactable = true
	arg_22_0._canvasGroup.blocksRaycasts = true
end

function var_0_0.onClose(arg_23_0)
	GameStateMgr.instance:unregisterCallback(GameStateEvent.OnTouchScreenUp, arg_23_0._onTouchScreenUp, arg_23_0)
	TaskDispatcher.cancelTask(arg_23_0._delayModifyCanvasGroup, arg_23_0)
	arg_23_0._aniamtor:Play("close", 0, 0)
	arg_23_0:_removeAllSkillClickListener()
end

return var_0_0
