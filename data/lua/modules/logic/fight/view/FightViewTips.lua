module("modules.logic.fight.view.FightViewTips", package.seeall)

local var_0_0 = class("FightViewTips", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._tipsRoot = gohelper.findChild(arg_1_0.viewGO, "root/tips")
	arg_1_0._goglobalClick = gohelper.findChild(arg_1_0.viewGO, "root/tips/#go_globalClick")
	arg_1_0._gobufftip = gohelper.findChild(arg_1_0.viewGO, "root/tips/#go_bufftip")
	arg_1_0._passiveSkillPrefab = gohelper.findChild(arg_1_0.viewGO, "root/tips/#go_bufftip/#scroll_buff/viewport/content/#go_buffitem")
	arg_1_0._goskilltip = gohelper.findChild(arg_1_0.viewGO, "root/tips/#go_skilltip")
	arg_1_0._goHeatTips = gohelper.findChild(arg_1_0.viewGO, "root/tips/#go_skilltip/#go_heat")
	arg_1_0._txtskillname = gohelper.findChildText(arg_1_0.viewGO, "root/tips/#go_skilltip/skillbg/container/#txt_skillname")
	arg_1_0._txtskilltype = gohelper.findChildText(arg_1_0.viewGO, "root/tips/#go_skilltip/skillbg/container/bg/#txt_skilltype")
	arg_1_0._txtskilldesc = gohelper.findChildText(arg_1_0.viewGO, "root/tips/#go_skilltip/skillbg/#txt_skilldesc")
	arg_1_0._skillTipsGO = arg_1_0._txtskilldesc.gameObject
	arg_1_0._goattrbg = gohelper.findChild(arg_1_0.viewGO, "root/tips/#go_skilltip/#go_attrbg")
	arg_1_0._gobuffinfocontainer = gohelper.findChild(arg_1_0.viewGO, "root/#go_buffinfocontainer")

	gohelper.setActive(arg_1_0._gobuffinfocontainer, false)

	arg_1_0._gobuffinfowrapper = gohelper.findChild(arg_1_0.viewGO, "root/#go_buffinfocontainer/buff")
	arg_1_0._gobuffitem = gohelper.findChild(arg_1_0.viewGO, "root/#go_buffinfocontainer/buff/#scroll_buff/viewport/content/#go_buffitem")
	arg_1_0._scrollbuff = gohelper.findChildScrollRect(arg_1_0.viewGO, "root/#go_buffinfocontainer/buff/#scroll_buff")
	arg_1_0._btnclosebuffinfocontainer = gohelper.findChildButton(arg_1_0.viewGO, "root/#go_buffinfocontainer/#btn_click")
	arg_1_0._gofightspecialtip = gohelper.findChild(arg_1_0.viewGO, "root/tips/#go_fightspecialtip")
	arg_1_0._promptImage = gohelper.findChildImage(arg_1_0.viewGO, "root/tips/#go_fightspecialtip/tipcontent/#image_specialtipbg")
	arg_1_0._promptText = gohelper.findChildText(arg_1_0.viewGO, "root/tips/#go_fightspecialtip/tipcontent/#image_specialtipbg/#txt_specialtipdesc")
	arg_1_0._prompAni = gohelper.findChildComponent(arg_1_0.viewGO, "root/tips/#go_fightspecialtip", typeof(UnityEngine.Animator))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end

	arg_1_0._passiveSkillGOs = arg_1_0:getUserDataTb_()
	arg_1_0._passiveSkillImgs = arg_1_0:getUserDataTb_()
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclosebuffinfocontainer:AddClickListener(arg_2_0._onCloseBuffInfoContainer, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.ShowFightPrompt, arg_2_0._onShowFightPrompt, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.ShowSeasonGuardIntro, arg_2_0._onShowSeasonGuardIntro, arg_2_0)

	arg_2_0._loader = arg_2_0._loader or FightLoaderComponent.New()

	arg_2_0:addEventCb(FightController.instance, FightEvent.LongPressHandCard, arg_2_0._onLongPressHandCard, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.HideFightViewTips, arg_2_0._onGlobalTouch, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclosebuffinfocontainer:RemoveClickListener()

	if not gohelper.isNil(arg_3_0._touchEventMgr) then
		TouchEventMgrHepler.remove(arg_3_0._touchEventMgr)
	end

	TaskDispatcher.cancelTask(arg_3_0._delayCheckHideTips, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_3_0._onCloseView, arg_3_0)

	if arg_3_0._loader then
		arg_3_0._loader:disposeSelf()

		arg_3_0._loader = nil
	end

	arg_3_0:removeEventCb(FightController.instance, FightEvent.LongPressHandCard, arg_3_0._onLongPressHandCard, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.HideFightViewTips, arg_3_0._onGlobalTouch, arg_3_0)
end

var_0_0.enemyBuffTipPosY = 80
var_0_0.OnKeyTipsPosY = 380
var_0_0.OnKeyTipsUniquePosY = 436

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._touchEventMgr = TouchEventMgrHepler.getTouchEventMgr(arg_4_0._goglobalClick)

	arg_4_0._touchEventMgr:SetIgnoreUI(true)
	arg_4_0._touchEventMgr:SetOnlyTouch(true)
	arg_4_0._touchEventMgr:SetOnTouchDownCb(arg_4_0._onGlobalTouch, arg_4_0)

	arg_4_0._originSkillPosX, arg_4_0._originSkillPosY = recthelper.getAnchor(arg_4_0._goskilltip.transform)

	gohelper.setActive(arg_4_0._gobuffitem, false)

	arg_4_0._buffItemList = {}
	arg_4_0.rectTrScrollBuff = arg_4_0._scrollbuff:GetComponent(gohelper.Type_RectTransform)
	arg_4_0.rectTrBuffContent = gohelper.findChildComponent(arg_4_0.viewGO, "root/#go_buffinfocontainer/buff/#scroll_buff/viewport/content", gohelper.Type_RectTransform)

	gohelper.setActive(arg_4_0._goattrbg, false)
	gohelper.addUIClickAudio(arg_4_0._btnclosebuffinfocontainer.gameObject, AudioEnum.UI.play_ui_checkpoint_click)
	gohelper.setActive(arg_4_0._txtskilltype.gameObject, false)
	gohelper.setActive(arg_4_0._gofightspecialtip, false)

	arg_4_0.buffTipClick = gohelper.getClickWithDefaultAudio(arg_4_0._gobufftip)

	arg_4_0.buffTipClick:AddClickListener(arg_4_0.onClickBuffTip, arg_4_0)
	gohelper.setActive(arg_4_0._gobufftip, false)
end

function var_0_0.onClickBuffTip(arg_5_0)
	gohelper.setActive(arg_5_0._gobufftip, false)
end

function var_0_0._onGlobalTouch(arg_6_0)
	if arg_6_0._guardTipsRoot then
		local var_6_0 = GamepadController.instance:getMousePosition()

		if arg_6_0._guardTipsContent == nil or recthelper.screenPosInRect(arg_6_0._guardTipsContent, nil, var_6_0.x, var_6_0.y) == false then
			gohelper.setActive(arg_6_0._guardTipsRoot, false)
		end
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightForbidCloseSkilltip) then
		return
	end

	if GuideViewMgr.instance:isGuidingGO(arg_6_0._skillTipsGO) then
		arg_6_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_6_0._onCloseView, arg_6_0)

		return
	end

	FightController.instance:dispatchEvent(FightEvent.TouchFightViewScreen)

	arg_6_0._showingSkillTip = not gohelper.isNil(arg_6_0._goskilltip) and arg_6_0._goskilltip.activeInHierarchy

	if arg_6_0._showingSkillTip then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_click)

		local var_6_1 = 0.1 * Time.timeScale

		if ViewMgr.instance:isOpen(ViewName.GuideView) then
			var_6_1 = GuideBlockMgr.BlockTime
		end

		TaskDispatcher.runDelay(arg_6_0._delayCheckHideTips, arg_6_0, var_6_1)
	end
end

function var_0_0._onCloseView(arg_7_0, arg_7_1)
	if arg_7_1 == ViewName.GuideView then
		arg_7_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_7_0._onCloseView, arg_7_0)
		FightController.instance:dispatchEvent(FightEvent.LongPressHandCardEnd)
		arg_7_0:_hideTips()
	end
end

function var_0_0._onLongPressHandCard(arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._delayCheckHideTips, arg_8_0)
end

function var_0_0._delayCheckHideTips(arg_9_0)
	if arg_9_0._showingSkillTip then
		FightController.instance:dispatchEvent(FightEvent.LongPressHandCardEnd)
	end

	if arg_9_0._showingSkillTip then
		arg_9_0:_hideTips()
	end
end

function var_0_0._onCloseBuffInfoContainer(arg_10_0)
	gohelper.setActive(arg_10_0._gobuffinfocontainer, false)
	ViewMgr.instance:closeView(ViewName.CommonBuffTipView)
	ViewMgr.instance:closeView(ViewName.FightBuffTipsView)
end

function var_0_0.onOpen(arg_11_0)
	gohelper.setActive(gohelper.findChild(arg_11_0.viewGO, "root/tips"), true)
	arg_11_0:_hideTips()
	arg_11_0:addEventCb(FightController.instance, FightEvent.OnBuffClick, arg_11_0._onBuffClick, arg_11_0)
	arg_11_0:addEventCb(FightController.instance, FightEvent.OnPassiveSkillClick, arg_11_0._onPassiveSkillClick, arg_11_0)
	arg_11_0:addEventCb(FightController.instance, FightEvent.ShowCardSkillTips, arg_11_0._showCardSkillTips, arg_11_0)
	arg_11_0:addEventCb(FightController.instance, FightEvent.HideCardSkillTips, arg_11_0._hideCardSkillTips, arg_11_0)
	arg_11_0:addEventCb(FightController.instance, FightEvent.OnSkillPlayStart, arg_11_0._onCloseBuffInfoContainer, arg_11_0)
	arg_11_0:addEventCb(FightController.instance, FightEvent.EnterOperateState, arg_11_0._onEnterOperateState, arg_11_0)
	arg_11_0:addEventCb(FightController.instance, FightEvent.EnterStage, arg_11_0._onEnterStage, arg_11_0)
end

function var_0_0._onEnterStage(arg_12_0, arg_12_1)
	if arg_12_1 == FightStageMgr.StageType.Play then
		arg_12_0:_hideTips()

		if arg_12_0._guardTipsRoot then
			gohelper.setActive(arg_12_0._guardTipsRoot, false)
		end
	end
end

function var_0_0._onEnterOperateState(arg_13_0, arg_13_1)
	if arg_13_1 == FightStageMgr.OperateStateType.SeasonChangeHero then
		gohelper.setActive(arg_13_0._gobuffinfocontainer, false)
		arg_13_0:_hideTips()
	end
end

function var_0_0._setPassiveSkillTip(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = gohelper.findChildText(arg_14_1, "title/txt_name")
	local var_14_1 = gohelper.findChildText(arg_14_1, "txt_desc")
	local var_14_2 = lua_skill.configDict[arg_14_2.skillId]

	var_14_0.text = var_14_2.name

	local var_14_3 = FightConfig.instance:getEntitySkillDesc(arg_14_3, var_14_2)

	var_14_1.text = HeroSkillModel.instance:skillDesToSpot(var_14_3, "#CC492F", "#485E92")
end

function var_0_0._setSkillTip(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	gohelper.setActive(arg_15_0._goskilltip, GMFightShowState.playSkillDes)

	local var_15_0 = lua_skill.configDict[arg_15_1]

	arg_15_0._txtskillname.text = var_15_0.name
	arg_15_0._txtskilltype.text = arg_15_0:_formatSkillType(var_15_0)

	local var_15_1 = FightConfig.instance:getEntitySkillDesc(arg_15_2, var_15_0)
	local var_15_2 = arg_15_0:_buildLinkTag(var_15_1)

	arg_15_0._txtskilldesc.text = HeroSkillModel.instance:skillDesToSpot(var_15_2, "#c56131", "#7c93ad")

	gohelper.setActive(arg_15_0._goHeatTips, false)

	if arg_15_3 and arg_15_3.heatId ~= 0 then
		gohelper.setActive(arg_15_0._goHeatTips, true)

		arg_15_0._heatId = arg_15_3.heatId

		if lua_card_heat.configDict[arg_15_0._heatId] then
			if arg_15_0._heatTitle then
				arg_15_0:_refreshCardHeat()
			elseif not arg_15_0._loadHeatTips then
				arg_15_0._loadHeatTips = true

				arg_15_0._loader:loadAsset("ui/viewres/fight/fightheattipsview.prefab", arg_15_0._onHeatTipsLoadFinish, arg_15_0)
			end
		end
	end
end

function var_0_0._refreshCardHeat(arg_16_0)
	local var_16_0 = arg_16_0._heatId
	local var_16_1 = lua_card_heat.configDict[var_16_0]

	if not var_16_1 then
		return
	end

	local var_16_2 = FightDataHelper.teamDataMgr.myData.cardHeat.values[var_16_0]

	if var_16_2 then
		local var_16_3 = FightDataHelper.teamDataMgr.myCardHeatOffset[var_16_0] or 0
		local var_16_4 = {}

		if not string.nilorempty(var_16_1.descParam) then
			local var_16_5 = string.split(var_16_1.descParam, "#")

			for iter_16_0, iter_16_1 in ipairs(var_16_5) do
				if iter_16_1 == "curValue" then
					table.insert(var_16_4, var_16_2.value + var_16_3)
				elseif iter_16_1 == "upperLimit" then
					table.insert(var_16_4, var_16_2.upperLimit)
				elseif iter_16_1 == "lowerLimit" then
					table.insert(var_16_4, var_16_2.lowerLimit)
				elseif iter_16_1 == "changeValue" then
					table.insert(var_16_4, var_16_2.changeValue)
				end
			end
		end

		arg_16_0._heatTitle.text = ""
		arg_16_0._heatDesc.text = GameUtil.getSubPlaceholderLuaLang(var_16_1.desc, var_16_4)
	end
end

function var_0_0._onHeatTipsLoadFinish(arg_17_0, arg_17_1, arg_17_2)
	if not arg_17_1 then
		return
	end

	local var_17_0 = arg_17_2:GetResource()
	local var_17_1 = gohelper.clone(var_17_0, arg_17_0._goHeatTips)

	arg_17_0._heatTitle = gohelper.findChildText(var_17_1, "tips/heatbg/#txt_heatname")
	arg_17_0._heatDesc = gohelper.findChildText(var_17_1, "tips/heatbg/#txt_heatdesc")

	arg_17_0:_refreshCardHeat()
end

function var_0_0._buildLinkTag(arg_18_0, arg_18_1)
	local var_18_0 = string.gsub(arg_18_1, "%[(.-)%]", "<link=\"%1\">[%1]</link>")

	return (string.gsub(var_18_0, "%【(.-)%】", "<link=\"%1\">【%1】</link>"))
end

function var_0_0._updateBuffs(arg_19_0, arg_19_1)
	gohelper.setActive(arg_19_0._gobuffinfocontainer, false)
end

function var_0_0._hideTips(arg_20_0)
	gohelper.setActive(arg_20_0._goskilltip, false)
end

function var_0_0.onClose(arg_21_0)
	TaskDispatcher.cancelTask(arg_21_0._correctPos, arg_21_0)
	TaskDispatcher.cancelTask(arg_21_0._hidePrompt, arg_21_0)
	TaskDispatcher.cancelTask(arg_21_0._playPromptCloseAnim, arg_21_0)
	arg_21_0:removeEventCb(FightController.instance, FightEvent.OnBuffClick, arg_21_0._onBuffClick, arg_21_0)
	arg_21_0:removeEventCb(FightController.instance, FightEvent.OnPassiveSkillClick, arg_21_0._onPassiveSkillClick, arg_21_0)
	arg_21_0:removeEventCb(FightController.instance, FightEvent.ShowCardSkillTips, arg_21_0._showCardSkillTips, arg_21_0)
	arg_21_0:removeEventCb(FightController.instance, FightEvent.HideCardSkillTips, arg_21_0._hideCardSkillTips, arg_21_0)
	arg_21_0:removeEventCb(FightController.instance, FightEvent.OnSkillPlayStart, arg_21_0._onCloseBuffInfoContainer, arg_21_0)
end

function var_0_0._showCardSkillTips(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	arg_22_0:_hideTips()
	arg_22_0:_setSkillTip(arg_22_1, arg_22_2, arg_22_3)

	local var_22_0 = arg_22_0._goskilltip.transform

	if PCInputController.instance:getIsUse() and PlayerPrefsHelper.getNumber("keyTips", 0) ~= 0 then
		if FightConfig.instance:isUniqueSkill(arg_22_1) then
			recthelper.setAnchor(var_22_0, arg_22_0._originSkillPosX, var_0_0.OnKeyTipsUniquePosY)
		else
			recthelper.setAnchor(var_22_0, arg_22_0._originSkillPosX, var_0_0.OnKeyTipsPosY)
		end
	else
		recthelper.setAnchor(var_22_0, arg_22_0._originSkillPosX, arg_22_0._originSkillPosY)
	end
end

function var_0_0._hideCardSkillTips(arg_23_0)
	arg_23_0:_hideTips()
end

function var_0_0._onPassiveSkillClick(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4, arg_24_5)
	if arg_24_1 then
		for iter_24_0, iter_24_1 in ipairs(arg_24_1) do
			local var_24_0 = arg_24_0._passiveSkillGOs[iter_24_0]

			if not var_24_0 then
				var_24_0 = gohelper.cloneInPlace(arg_24_0._passiveSkillPrefab, "item" .. iter_24_0)

				table.insert(arg_24_0._passiveSkillGOs, var_24_0)

				local var_24_1 = gohelper.findChildImage(var_24_0, "title/simage_icon")

				table.insert(arg_24_0._passiveSkillImgs, var_24_1)
				arg_24_0:_setPassiveSkillTip(var_24_0, iter_24_1, arg_24_5)
				UISpriteSetMgr.instance:setFightPassiveSprite(var_24_1, iter_24_1.icon)
			end

			local var_24_2 = gohelper.findChild(arg_24_0._passiveSkillGOs[#arg_24_1], "txt_desc/image_line")

			gohelper.setActive(var_24_2, false)
			gohelper.setActive(var_24_0, true)
		end

		for iter_24_2 = #arg_24_1 + 1, #arg_24_0._passiveSkillGOs do
			gohelper.setActive(arg_24_0._passiveSkillGOs[iter_24_2], false)
		end

		gohelper.setActive(arg_24_0._gobufftip, true)
	end
end

function var_0_0._onBuffClick(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4)
	local var_25_0 = FightDataHelper.entityMgr:getById(arg_25_1)

	if not var_25_0 then
		logError("get EntityMo fail, entityId : " .. tostring(arg_25_1))

		return
	end

	if isDebugBuild then
		local var_25_1 = {}

		for iter_25_0, iter_25_1 in pairs(var_25_0:getBuffDic()) do
			local var_25_2 = lua_skill_buff.configDict[iter_25_1.buffId]
			local var_25_3 = var_25_2.isNoShow == 0 and "show" or "noShow"
			local var_25_4 = var_25_2.isGoodBuff == 1 and "good" or "bad"
			local var_25_5 = iter_25_1.buffId
			local var_25_6 = var_25_2.name
			local var_25_7 = iter_25_1.count
			local var_25_8 = iter_25_1.duration
			local var_25_9 = var_25_2.desc
			local var_25_10 = string.format("id=%d count=%d duration=%d name=%s desc=%s %s %s", var_25_5, var_25_7, var_25_8, var_25_6, var_25_9, var_25_4, var_25_3)

			table.insert(var_25_1, var_25_10)
		end

		logNormal(string.format("buff list %d :\n%s", #var_25_1, table.concat(var_25_1, "\n")))
	end

	local var_25_11 = true
	local var_25_12 = var_25_0:getBuffDic()

	for iter_25_2, iter_25_3 in pairs(var_25_12) do
		local var_25_13 = lua_skill_buff.configDict[iter_25_3.buffId]

		if var_25_13 and var_25_13.isNoShow == 0 then
			var_25_11 = false

			break
		end
	end

	if var_25_11 then
		return
	end

	ViewMgr.instance:openView(ViewName.FightBuffTipsView, {
		entityId = arg_25_1,
		iconPos = arg_25_2.position,
		offsetX = arg_25_3,
		offsetY = arg_25_4,
		viewname = arg_25_0.viewName
	})
	arg_25_0:_hideTips()

	local var_25_14 = arg_25_0._gobuffinfowrapper.transform
	local var_25_15 = recthelper.rectToRelativeAnchorPos(arg_25_2.position, var_25_14.parent)

	if var_25_0.side == FightEnum.EntitySide.MySide then
		recthelper.setAnchor(var_25_14, var_25_15.x - arg_25_3 + 100, var_25_15.y + arg_25_4)
	else
		recthelper.setAnchor(var_25_14, var_25_15.x + arg_25_3, var_0_0.enemyBuffTipPosY)
	end

	arg_25_0._buffinfoWrapperTr = var_25_14
	gohelper.onceAddComponent(arg_25_0._buffinfoWrapperTr.gameObject, gohelper.Type_CanvasGroup).alpha = 0

	TaskDispatcher.runDelay(arg_25_0._correctPos, arg_25_0, 0.01)
end

function var_0_0._correctPos(arg_26_0)
	if gohelper.fitScreenOffset(arg_26_0._buffinfoWrapperTr) then
		recthelper.setAnchor(arg_26_0._buffinfoWrapperTr, 0, 0)
	end

	gohelper.onceAddComponent(arg_26_0._buffinfoWrapperTr.gameObject, gohelper.Type_CanvasGroup).alpha = 1
end

function var_0_0._formatSkillType(arg_27_0, arg_27_1)
	if arg_27_1.effectTag == FightEnum.EffectTag.CounterSpell and FightEnum.EffectTagDesc[FightEnum.EffectTag.CounterSpell] then
		return FightEnum.EffectTagDesc[FightEnum.EffectTag.CounterSpell]
	end

	local var_27_0 = FightEnum.LogicTargetDesc[arg_27_1.logicTarget] or luaLang("logic_target_single")
	local var_27_1 = FightEnum.EffectTagDesc[arg_27_1.effectTag] or ""

	return var_27_0 .. var_27_1
end

function var_0_0._formatSkillDesc(arg_28_0, arg_28_1)
	return string.gsub(arg_28_1, "(%d+%%*)", "<color=#DC6262><size=26>%1</size></color>")
end

function var_0_0._formatPassiveSkillDesc(arg_29_0, arg_29_1)
	return
end

function var_0_0._onShowFightPrompt(arg_30_0, arg_30_1, arg_30_2)
	TaskDispatcher.cancelTask(arg_30_0._hidePrompt, arg_30_0)
	TaskDispatcher.cancelTask(arg_30_0._playPromptCloseAnim, arg_30_0)

	local var_30_0 = lua_fight_prompt.configDict[arg_30_1]

	gohelper.setActive(arg_30_0._gofightspecialtip, true)

	arg_30_0._promptText.text = var_30_0.content

	UISpriteSetMgr.instance:setFightSprite(arg_30_0._promptImage, "img_tsk_" .. var_30_0.color)
	arg_30_0._prompAni:Play("open", 0, 0)

	if arg_30_2 then
		TaskDispatcher.runDelay(arg_30_0._playPromptCloseAnim, arg_30_0, arg_30_2 / 1000)
	end
end

function var_0_0._playPromptCloseAnim(arg_31_0)
	arg_31_0._prompAni:Play("close", 0, 0)
	TaskDispatcher.runDelay(arg_31_0._hidePrompt, arg_31_0, 0.0005)
end

function var_0_0._hidePrompt(arg_32_0)
	gohelper.setActive(arg_32_0._gofightspecialtip, false)
end

function var_0_0._onShowSeasonGuardIntro(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	arg_33_0._guardTipsRoot = arg_33_0._guardTipsRoot

	if not arg_33_0._guardTipsRoot then
		arg_33_0._guardTipsRoot = gohelper.create2d(arg_33_0._tipsRoot, "guardTips")

		arg_33_0._loader:loadAsset("ui/viewres/fight/fightseasonguardtipsview.prefab", arg_33_0._onGuardTipsLoadFinish, arg_33_0)

		arg_33_0._guardTipsTran = arg_33_0._guardTipsRoot.transform
	end

	gohelper.setActive(arg_33_0._guardTipsRoot, true)

	arg_33_2 = arg_33_2 + 307

	recthelper.setAnchor(arg_33_0._guardTipsTran, arg_33_2, arg_33_3)
end

function var_0_0._onGuardTipsLoadFinish(arg_34_0, arg_34_1, arg_34_2)
	if not arg_34_1 then
		return
	end

	local var_34_0 = arg_34_2:GetResource()
	local var_34_1 = gohelper.clone(var_34_0, arg_34_0._guardTipsRoot)
	local var_34_2 = gohelper.findChildText(var_34_1, "#scroll_ShieldTips/viewport/content/#go_shieldtipsitem/layout/#txt_title")
	local var_34_3 = gohelper.findChildText(var_34_1, "#scroll_ShieldTips/viewport/content/#go_shieldtipsitem/layout/#txt_dec")
	local var_34_4 = lua_activity166_const_global.configDict[109]

	var_34_2.text = var_34_4 and var_34_4.value2 or ""

	local var_34_5 = lua_activity166_const_global.configDict[110]

	var_34_3.text = var_34_5 and var_34_5.value2 or ""
	arg_34_0._guardTipsContent = gohelper.findChild(var_34_1, "#scroll_ShieldTips/viewport/content").transform
end

function var_0_0.onDestroyView(arg_35_0)
	arg_35_0.buffTipClick:RemoveClickListener()

	arg_35_0.buffTipClick = nil
end

return var_0_0
