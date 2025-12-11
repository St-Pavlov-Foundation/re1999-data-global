module("modules.logic.survival.view.shelter.SurvivalBossInvasionView", package.seeall)

local var_0_0 = class("SurvivalBossInvasionView", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.posType = arg_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.viewGO = arg_2_1
	arg_2_0.pos_mainview = gohelper.findChild(arg_2_0.viewGO, "pos_mainview")
	arg_2_0.pos_teamview = gohelper.findChild(arg_2_0.viewGO, "pos_teamview")
	arg_2_0.go_boss = gohelper.findChild(arg_2_0.viewGO, "#go_BossBuff")
	arg_2_0.go_monster = gohelper.findChildButtonWithAudio(arg_2_0.go_boss, "#go_monster")
	arg_2_0.go_monsterHeadIcon = gohelper.findChildSingleImage(arg_2_0.go_boss, "#go_monster/#go_monsterHeadIcon")
	arg_2_0.go_eff_weak = gohelper.findChild(arg_2_0.go_boss, "#go_monster/#go_eff_weak")
	arg_2_0.go_debuff = gohelper.findChild(arg_2_0.go_boss, "#go_monster/#go_eff_weak/#go_debuff")
	arg_2_0.txt_LimitTime = gohelper.findChildTextMesh(arg_2_0.go_boss, "#go_monster/#txt_LimitTime")
	arg_2_0.go_icon_Limit = gohelper.findChild(arg_2_0.go_boss, "#go_monster/#txt_LimitTime/icon")
	arg_2_0.txt_noIcon = gohelper.findChildTextMesh(arg_2_0.go_boss, "#go_monster/#txt_noIcon")
	arg_2_0.txt_score = gohelper.findChildTextMesh(arg_2_0.go_boss, "Content/score/#txt_score")
	arg_2_0.go_buff = gohelper.findChild(arg_2_0.go_boss, "Content/#go_buff")
	arg_2_0.go_Content = gohelper.findChild(arg_2_0.go_boss, "Content")
	arg_2_0.layoutContent = arg_2_0.go_Content:GetComponent(gohelper.Type_VerticalLayoutGroup)
	arg_2_0.scrollBar = gohelper.findChildScrollbar(arg_2_0.go_boss, "Content/Scrollbar")
	arg_2_0.image_progress = gohelper.findChildImage(arg_2_0.go_boss, "Content/#image_progress")
	arg_2_0.go_tips = gohelper.findChild(arg_2_0.viewGO, "#go_tips")
	arg_2_0.go_tips_layout = gohelper.findChild(arg_2_0.go_tips, "layout")
	arg_2_0.btn_close_tips = gohelper.findChildButton(arg_2_0.go_tips, "#btn_close")
	arg_2_0.txt_desc = gohelper.findChildTextMesh(arg_2_0.go_tips, "layout/#txt_desc")
	arg_2_0.txt_condition_tips = gohelper.findChildTextMesh(arg_2_0.go_tips, "layout/#txt_condition")

	gohelper.setActive(arg_2_0.go_buff, false)

	arg_2_0.customItems = {}
	arg_2_0.posType = arg_2_0.posType or 1

	if arg_2_0.posType == 2 then
		arg_2_0.go_boss.transform:SetParent(arg_2_0.pos_teamview.transform, false)
	else
		arg_2_0.go_boss.transform:SetParent(arg_2_0.pos_mainview.transform, false)
	end
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0:addClickCb(arg_3_0.go_monster, arg_3_0.onClickBoss, arg_3_0)
	arg_3_0:addClickCb(arg_3_0.btn_close_tips, arg_3_0.onCloseTip, arg_3_0)
	arg_3_0:addEventCb(SurvivalController.instance, SurvivalEvent.OnShelterBagUpdate, arg_3_0.onShelterBagUpdate, arg_3_0)
	arg_3_0:addEventCb(SurvivalController.instance, SurvivalEvent.AbandonFight, arg_3_0.onAbandonFight, arg_3_0)
	arg_3_0:addEventCb(SurvivalController.instance, SurvivalEvent.OnDelayPopupFinishEvent, arg_3_0.onDelayPopupFinishEvent, arg_3_0)
end

function var_0_0.onStart(arg_4_0)
	arg_4_0.weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	arg_4_0.clientMo = arg_4_0.weekInfo.clientData

	arg_4_0:refresh()
	arg_4_0:refreshDecoding(false)
	arg_4_0:refreshList(false)
end

function var_0_0.onDestroy(arg_5_0)
	if arg_5_0.textTweenId then
		ZProj.TweenHelper.KillById(arg_5_0.textTweenId)

		arg_5_0.textTweenId = nil
	end

	if arg_5_0.progressTweenId then
		ZProj.TweenHelper.KillById(arg_5_0.progressTweenId)

		arg_5_0.progressTweenId = nil
	end
end

function var_0_0.onShelterBagUpdate(arg_6_0)
	arg_6_0:refreshDecoding(true)
	arg_6_0.clientMo:saveDataToServer()
end

function var_0_0.onAbandonFight(arg_7_0)
	arg_7_0:refresh()
	arg_7_0:refreshDecoding(false)
	arg_7_0:refreshList(false)
end

function var_0_0.onDelayPopupFinishEvent(arg_8_0)
	arg_8_0:refreshDecoding(true)
	arg_8_0:refreshList(true)
end

function var_0_0.onCloseTip(arg_9_0)
	gohelper.setActive(arg_9_0.go_tips, false)
end

function var_0_0.refresh(arg_10_0)
	arg_10_0.intrudeBox = arg_10_0.weekInfo.intrudeBox
	arg_10_0.fight = arg_10_0.weekInfo:getMonsterFight()

	if arg_10_0.fight.fightId <= 0 then
		gohelper.setActive(arg_10_0.go_boss, false)

		return
	end

	gohelper.setActive(arg_10_0.go_boss, true)

	arg_10_0.cleanPoints = arg_10_0.fight.cleanPoints

	local var_10_0 = arg_10_0.fight.fightCo.smallheadicon

	if var_10_0 then
		arg_10_0.go_monsterHeadIcon:LoadImage(ResUrl.monsterHeadIcon(var_10_0))
	end

	local var_10_1 = arg_10_0.weekInfo.day
	local var_10_2 = arg_10_0.intrudeBox:getNextBossCreateDay(var_10_1) - var_10_1

	gohelper.setActive(arg_10_0.go_icon_Limit, var_10_2 > 0)

	if var_10_2 <= 0 then
		gohelper.setActive(arg_10_0.txt_noIcon.gameObject, true)
		gohelper.setActive(arg_10_0.txt_LimitTime.gameObject, false)

		arg_10_0.txt_noIcon.text = luaLang("survival_mainview_monster_fight")
	else
		gohelper.setActive(arg_10_0.txt_noIcon.gameObject, false)
		gohelper.setActive(arg_10_0.txt_LimitTime.gameObject, true)

		arg_10_0.txt_LimitTime.text = string.format("%s%s", var_10_2, luaLang("time_day"))
	end
end

function var_0_0.refreshDecoding(arg_11_0, arg_11_1)
	if arg_11_0.fight.fightId <= 0 then
		return
	end

	local var_11_0 = arg_11_0.clientMo.data

	arg_11_0.decodingCurNum = arg_11_0.weekInfo:getBag(SurvivalEnum.ItemSource.Shelter):getItemCountPlus(SurvivalEnum.CurrencyType.Decoding)

	local var_11_1 = var_11_0.decodingItemNum

	arg_11_0.txt_score.text = string.format("<#FF8640>%s</color>/%s", var_11_1, arg_11_0.fight:getMaxCleanPoint())

	if arg_11_1 then
		if var_11_1 < arg_11_0.decodingCurNum then
			arg_11_0.textTweenId = ZProj.TweenHelper.DOTweenFloat(var_11_1, arg_11_0.decodingCurNum, 1.5, arg_11_0.onTween, arg_11_0.onTweenFinish, arg_11_0, nil, EaseType.OutQuart)

			arg_11_0.clientMo:setDecodingItemNum(arg_11_0.decodingCurNum)
		elseif var_11_1 > arg_11_0.decodingCurNum then
			arg_11_0.txt_score.text = string.format("<#FF8640>%s</color>/%s", arg_11_0.decodingCurNum, arg_11_0.fight:getMaxCleanPoint())

			arg_11_0.clientMo:setDecodingItemNum(arg_11_0.decodingCurNum)
		end
	elseif not arg_11_1 and var_11_1 > arg_11_0.decodingCurNum then
		arg_11_0.txt_score.text = string.format("<#FF8640>%s</color>/%s", arg_11_0.decodingCurNum, arg_11_0.fight:getMaxCleanPoint())

		arg_11_0.clientMo:setDecodingItemNum(arg_11_0.decodingCurNum)
	end
end

function var_0_0.onTween(arg_12_0, arg_12_1)
	arg_12_0.txt_score.text = string.format("<#FF8640>%s</color>/%s", math.floor(arg_12_1), arg_12_0.fight:getMaxCleanPoint())
end

function var_0_0.onTweenFinish(arg_13_0)
	arg_13_0:onTween(arg_13_0.decodingCurNum)
end

function var_0_0.refreshList(arg_14_0, arg_14_1)
	if arg_14_0.fight.fightId <= 0 then
		return
	end

	local var_14_0 = arg_14_0.clientMo.data
	local var_14_1 = arg_14_0.fight.intrudeSchemeMos

	arg_14_0.survivalIntrudeSchemeMo = {}

	for iter_14_0 = #var_14_1, 1, -1 do
		table.insert(arg_14_0.survivalIntrudeSchemeMo, var_14_1[iter_14_0])
	end

	arg_14_0.repressNum = 0

	for iter_14_1, iter_14_2 in ipairs(var_14_1) do
		if iter_14_2.survivalIntrudeScheme.repress then
			arg_14_0.repressNum = arg_14_0.repressNum + 1
		end
	end

	local var_14_2 = arg_14_0.repressNum > 0

	gohelper.setActive(arg_14_0.go_eff_weak, var_14_2)

	if var_14_2 and arg_14_1 and var_14_2 and var_14_0.isBossWeak ~= var_14_2 then
		gohelper.setActive(arg_14_0.go_debuff, true)
		arg_14_0.clientMo:setIsBossWeak(var_14_2)
	end

	local var_14_3 = #arg_14_0.customItems
	local var_14_4 = #arg_14_0.survivalIntrudeSchemeMo

	for iter_14_3 = 1, var_14_4 do
		local var_14_5 = arg_14_0.survivalIntrudeSchemeMo[iter_14_3]

		if var_14_3 < iter_14_3 then
			local var_14_6 = gohelper.clone(arg_14_0.go_buff, arg_14_0.go_Content)

			gohelper.setActive(var_14_6, true)

			local var_14_7 = arg_14_0:getUserDataTb_()

			var_14_7.imgIcon = var_14_6:GetComponent(gohelper.Type_Image)
			var_14_7.btnClick = gohelper.findButtonWithAudio(var_14_6)
			var_14_7.anim = gohelper.findComponentAnim(var_14_6)

			arg_14_0:addClickCb(var_14_7.btnClick, arg_14_0.onClickCustomItem, arg_14_0, {
				mo = var_14_5,
				trans = var_14_7.imgIcon.transform
			})

			arg_14_0.customItems[iter_14_3] = var_14_7
		end

		arg_14_0:refreshCustomItems(arg_14_0.customItems[iter_14_3], var_14_5)

		local var_14_8 = var_14_5.survivalIntrudeScheme.repress
		local var_14_9 = arg_14_0.clientMo:getBossRepress(arg_14_0.fight.fightId, var_14_5.survivalIntrudeScheme.id)

		if arg_14_1 and var_14_8 ~= var_14_9 then
			if var_14_8 then
				arg_14_0.customItems[iter_14_3].anim:Play("open", 0, 0)
			end

			arg_14_0.clientMo:setBossRepress(arg_14_0.fight.fightId, var_14_5.survivalIntrudeScheme.id)
		end
	end

	for iter_14_4 = var_14_4 + 1, var_14_3 do
		arg_14_0.customItems[iter_14_4]:setData(nil)
	end

	local var_14_10 = 92
	local var_14_11 = arg_14_0.layoutContent.spacing
	local var_14_12 = 9
	local var_14_13 = #var_14_1
	local var_14_14 = var_14_10 * var_14_13 + (var_14_13 - 1) * var_14_11 + var_14_12
	local var_14_15 = var_14_12 / var_14_14
	local var_14_16 = arg_14_0.repressNum

	arg_14_0.curRepressProgress = var_14_15 + (var_14_10 * var_14_16 + (var_14_16 - 1) * var_14_11) / var_14_14

	local var_14_17 = var_14_0.bossRepressProgress

	arg_14_0.image_progress.fillAmount = var_14_17

	arg_14_0.scrollBar:SetValue(var_14_17)

	if arg_14_1 then
		if var_14_17 < arg_14_0.curRepressProgress then
			arg_14_0.progressTweenId = ZProj.TweenHelper.DOTweenFloat(var_14_17, arg_14_0.curRepressProgress, 1.5, arg_14_0.onProgressTween, arg_14_0.onProgressTweenFinish, arg_14_0, nil, EaseType.OutQuart)

			arg_14_0.clientMo:setBossRepressProgress(arg_14_0.curRepressProgress)
		elseif var_14_17 > arg_14_0.curRepressProgress then
			arg_14_0.image_progress.fillAmount = arg_14_0.curRepressProgress

			arg_14_0.clientMo:setBossRepressProgress(arg_14_0.curRepressProgress)
		end
	elseif not arg_14_1 and var_14_17 > arg_14_0.curRepressProgress then
		arg_14_0.image_progress.fillAmount = arg_14_0.curRepressProgress

		arg_14_0.clientMo:setBossRepressProgress(arg_14_0.curRepressProgress)
	end
end

function var_0_0.onProgressTween(arg_15_0, arg_15_1)
	arg_15_0.image_progress.fillAmount = arg_15_1

	arg_15_0.scrollBar:SetValue(arg_15_1)
end

function var_0_0.onProgressTweenFinish(arg_16_0)
	arg_16_0:onProgressTween(arg_16_0.curRepressProgress)
end

function var_0_0.refreshCustomItems(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_2:getDisplayIcon()

	UISpriteSetMgr.instance:setSurvivalSprite(arg_17_1.imgIcon, var_17_0)
end

function var_0_0.onClickCustomItem(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1.mo
	local var_18_1 = arg_18_1.trans.position
	local var_18_2 = recthelper.rectToRelativeAnchorPos(var_18_1, arg_18_0.go_tips.transform)
	local var_18_3 = var_18_2.x - 66

	if arg_18_0.posType == 2 then
		var_18_3 = var_18_2.x + 66 + recthelper.getWidth(arg_18_0.go_tips_layout.transform)
	end

	recthelper.setAnchor(arg_18_0.go_tips_layout.transform, var_18_3, var_18_2.y)
	gohelper.setActive(arg_18_0.go_tips, true)

	arg_18_0.txt_desc.text = var_18_0.intrudeSchemeCfg.desc

	if var_18_0.survivalIntrudeScheme.repress then
		arg_18_0.txt_condition_tips.text = luaLang("SurvivalBossInvasionView_1")
	else
		arg_18_0.txt_condition_tips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("SurvivalBossInvasionView_2"), {
			var_18_0.point
		})
	end
end

function var_0_0.onClickBoss(arg_19_0)
	SurvivalStatHelper.instance:statBtnClick("onClickBoss", "SurvivalBossInvasionView")
	ViewMgr.instance:openView(ViewName.SurvivalMonsterEventView, {
		showType = SurvivalEnum.SurvivalMonsterEventViewShowType.Normal
	})
end

return var_0_0
