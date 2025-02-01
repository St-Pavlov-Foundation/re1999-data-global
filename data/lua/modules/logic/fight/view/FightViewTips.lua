module("modules.logic.fight.view.FightViewTips", package.seeall)

slot0 = class("FightViewTips", BaseViewExtended)

function slot0.onInitView(slot0)
	slot0._tipsRoot = gohelper.findChild(slot0.viewGO, "root/tips")
	slot0._goglobalClick = gohelper.findChild(slot0.viewGO, "root/tips/#go_globalClick")
	slot0._gobufftip = gohelper.findChild(slot0.viewGO, "root/tips/#go_bufftip")
	slot0._passiveSkillPrefab = gohelper.findChild(slot0.viewGO, "root/tips/#go_bufftip/#scroll_buff/viewport/content/#go_buffitem")
	slot0._goskilltip = gohelper.findChild(slot0.viewGO, "root/tips/#go_skilltip")
	slot0._txtskillname = gohelper.findChildText(slot0.viewGO, "root/tips/#go_skilltip/skillbg/container/#txt_skillname")
	slot0._txtskilltype = gohelper.findChildText(slot0.viewGO, "root/tips/#go_skilltip/skillbg/container/bg/#txt_skilltype")
	slot0._txtskilldesc = gohelper.findChildText(slot0.viewGO, "root/tips/#go_skilltip/skillbg/#txt_skilldesc")
	slot0._skillTipsGO = slot0._txtskilldesc.gameObject
	slot0._goattrbg = gohelper.findChild(slot0.viewGO, "root/tips/#go_skilltip/#go_attrbg")
	slot0._gobuffinfocontainer = gohelper.findChild(slot0.viewGO, "root/#go_buffinfocontainer")
	slot0._gobuffinfowrapper = gohelper.findChild(slot0.viewGO, "root/#go_buffinfocontainer/buff")
	slot0._gobuffitem = gohelper.findChild(slot0.viewGO, "root/#go_buffinfocontainer/buff/#scroll_buff/viewport/content/#go_buffitem")
	slot0._scrollbuff = gohelper.findChildScrollRect(slot0.viewGO, "root/#go_buffinfocontainer/buff/#scroll_buff")
	slot0._btnclosebuffinfocontainer = gohelper.findChildButton(slot0.viewGO, "root/#go_buffinfocontainer/#btn_click")
	slot0._gofightspecialtip = gohelper.findChild(slot0.viewGO, "root/tips/#go_fightspecialtip")
	slot0._promptImage = gohelper.findChildImage(slot0.viewGO, "root/tips/#go_fightspecialtip/tipcontent/#image_specialtipbg")
	slot0._promptText = gohelper.findChildText(slot0.viewGO, "root/tips/#go_fightspecialtip/tipcontent/#image_specialtipbg/#txt_specialtipdesc")
	slot0._prompAni = gohelper.findChildComponent(slot0.viewGO, "root/tips/#go_fightspecialtip", typeof(UnityEngine.Animator))

	if slot0._editableInitView then
		slot0:_editableInitView()
	end

	slot0._passiveSkillGOs = slot0:getUserDataTb_()
	slot0._passiveSkillImgs = slot0:getUserDataTb_()
end

function slot0.addEvents(slot0)
	slot0._btnclosebuffinfocontainer:AddClickListener(slot0._onCloseBuffInfoContainer, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.ShowFightPrompt, slot0._onShowFightPrompt, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.ShowSeasonGuardIntro, slot0._onShowSeasonGuardIntro, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.LongPressHandCard, slot0._onLongPressHandCard, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.HideFightViewTips, slot0._onGlobalTouch, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclosebuffinfocontainer:RemoveClickListener()

	if not gohelper.isNil(slot0._touchEventMgr) then
		TouchEventMgrHepler.remove(slot0._touchEventMgr)
	end

	TaskDispatcher.cancelTask(slot0._delayCheckHideTips, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.LongPressHandCard, slot0._onLongPressHandCard, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.HideFightViewTips, slot0._onGlobalTouch, slot0)
end

slot0.enemyBuffTipPosY = 80
slot0.OnKeyTipsPosY = 380

function slot0._editableInitView(slot0)
	slot0._touchEventMgr = TouchEventMgrHepler.getTouchEventMgr(slot0._goglobalClick)

	slot0._touchEventMgr:SetIgnoreUI(true)
	slot0._touchEventMgr:SetOnlyTouch(true)
	slot0._touchEventMgr:SetOnTouchDownCb(slot0._onGlobalTouch, slot0)

	slot0._originSkillPosX, slot0._originSkillPosY = recthelper.getAnchor(slot0._goskilltip.transform)

	gohelper.setActive(slot0._gobuffitem, false)

	slot0._buffItemList = {}
	slot0.rectTrScrollBuff = slot0._scrollbuff:GetComponent(gohelper.Type_RectTransform)
	slot0.rectTrBuffContent = gohelper.findChildComponent(slot0.viewGO, "root/#go_buffinfocontainer/buff/#scroll_buff/viewport/content", gohelper.Type_RectTransform)

	gohelper.setActive(slot0._goattrbg, false)
	gohelper.addUIClickAudio(slot0._btnclosebuffinfocontainer.gameObject, AudioEnum.UI.play_ui_checkpoint_click)
	gohelper.setActive(slot0._txtskilltype.gameObject, false)
	gohelper.setActive(slot0._gofightspecialtip, false)

	slot0.buffTipClick = gohelper.getClickWithDefaultAudio(slot0._gobufftip)

	slot0.buffTipClick:AddClickListener(slot0.onClickBuffTip, slot0)
	gohelper.setActive(slot0._gobufftip, false)
end

function slot0.onClickBuffTip(slot0)
	gohelper.setActive(slot0._gobufftip, false)
end

function slot0._onGlobalTouch(slot0)
	if slot0._guardTipsRoot then
		slot1 = GamepadController.instance:getMousePosition()

		if slot0._guardTipsContent == nil or recthelper.screenPosInRect(slot0._guardTipsContent, nil, slot1.x, slot1.y) == false then
			gohelper.setActive(slot0._guardTipsRoot, false)
		end
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightForbidCloseSkilltip) then
		return
	end

	if GuideViewMgr.instance:isGuidingGO(slot0._skillTipsGO) then
		slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)

		return
	end

	FightController.instance:dispatchEvent(FightEvent.TouchFightViewScreen)

	slot0._showingSkillTip = not gohelper.isNil(slot0._goskilltip) and slot0._goskilltip.activeInHierarchy

	if slot0._showingSkillTip then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_click)

		slot1 = 0.1 * Time.timeScale

		if ViewMgr.instance:isOpen(ViewName.GuideView) then
			slot1 = GuideBlockMgr.BlockTime
		end

		TaskDispatcher.runDelay(slot0._delayCheckHideTips, slot0, slot1)
	end
end

function slot0._onCloseView(slot0, slot1)
	if slot1 == ViewName.GuideView then
		slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
		FightController.instance:dispatchEvent(FightEvent.LongPressHandCardEnd)
		slot0:_hideTips()
	end
end

function slot0._onLongPressHandCard(slot0)
	TaskDispatcher.cancelTask(slot0._delayCheckHideTips, slot0)
end

function slot0._delayCheckHideTips(slot0)
	if slot0._showingSkillTip then
		FightController.instance:dispatchEvent(FightEvent.LongPressHandCardEnd)
	end

	if slot0._showingSkillTip then
		slot0:_hideTips()
	end
end

function slot0._onCloseBuffInfoContainer(slot0)
	gohelper.setActive(slot0._gobuffinfocontainer, false)
	ViewMgr.instance:closeView(ViewName.CommonBuffTipView)
	ViewMgr.instance:closeView(ViewName.FightBuffTipsView)
end

function slot0.onOpen(slot0)
	gohelper.setActive(gohelper.findChild(slot0.viewGO, "root/tips"), true)
	slot0:_hideTips()
	slot0:addEventCb(FightController.instance, FightEvent.OnBuffClick, slot0._onBuffClick, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnPassiveSkillClick, slot0._onPassiveSkillClick, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.ShowCardSkillTips, slot0._showCardSkillTips, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.HideCardSkillTips, slot0._hideCardSkillTips, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnSkillPlayStart, slot0._onCloseBuffInfoContainer, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.EnterOperateState, slot0._onEnterOperateState, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.EnterStage, slot0._onEnterStage, slot0)
end

function slot0._onEnterStage(slot0, slot1)
	if slot1 == FightStageMgr.StageType.Play then
		slot0:_hideTips()

		if slot0._guardTipsRoot then
			gohelper.setActive(slot0._guardTipsRoot, false)
		end
	end
end

function slot0._onEnterOperateState(slot0, slot1)
	if slot1 == FightStageMgr.OperateStateType.SeasonChangeHero then
		gohelper.setActive(slot0._gobuffinfocontainer, false)
		slot0:_hideTips()
	end
end

function slot0._setPassiveSkillTip(slot0, slot1, slot2, slot3)
	slot6 = lua_skill.configDict[slot2.skillId]
	gohelper.findChildText(slot1, "title/txt_name").text = slot6.name
	gohelper.findChildText(slot1, "txt_desc").text = HeroSkillModel.instance:skillDesToSpot(FightConfig.instance:getEntitySkillDesc(slot3, slot6), "#CC492F", "#485E92")
end

function slot0._setSkillTip(slot0, slot1, slot2)
	gohelper.setActive(slot0._goskilltip, GMFightShowState.playSkillDes)

	slot3 = lua_skill.configDict[slot1]
	slot0._txtskillname.text = slot3.name
	slot0._txtskilltype.text = slot0:_formatSkillType(slot3)
	slot0._txtskilldesc.text = HeroSkillModel.instance:skillDesToSpot(slot0:_buildLinkTag(FightConfig.instance:getEntitySkillDesc(slot2, slot3)), "#c56131", "#7c93ad")
end

function slot0._buildLinkTag(slot0, slot1)
	return string.gsub(string.gsub(slot1, "%[(.-)%]", "<link=\"%1\">[%1]</link>"), "%【(.-)%】", "<link=\"%1\">【%1】</link>")
end

function slot0.getCommonBuffTipScrollAnchor(slot0, slot1, slot2)
	slot3 = slot0.rectTrScrollBuff
	slot6 = CameraMgr.instance:getUICamera()
	slot2.pivot = CommonBuffTipEnum.Pivot.Right
	slot7, slot8 = recthelper.worldPosToAnchorPos2(slot3.position, slot1, slot6, slot6)

	recthelper.setAnchor(slot2, slot7 - recthelper.getWidth(slot3) / 2, slot8 + math.min(recthelper.getHeight(slot3), recthelper.getHeight(slot0.rectTrBuffContent)) / 2)
end

function slot0._updateBuffs(slot0, slot1)
	gohelper.setActive(slot0._gobuffinfocontainer, true)
	FightBuffTipsView.updateBuffDesc(slot1, slot0._buffItemList, slot0._gobuffitem, slot0, slot0.getCommonBuffTipScrollAnchor)
end

function slot0._hideTips(slot0)
	gohelper.setActive(slot0._goskilltip, false)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._correctPos, slot0)
	TaskDispatcher.cancelTask(slot0._hidePrompt, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnBuffClick, slot0._onBuffClick, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnPassiveSkillClick, slot0._onPassiveSkillClick, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.ShowCardSkillTips, slot0._showCardSkillTips, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.HideCardSkillTips, slot0._hideCardSkillTips, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnSkillPlayStart, slot0._onCloseBuffInfoContainer, slot0)
end

function slot0._showCardSkillTips(slot0, slot1, slot2)
	slot0:_hideTips()
	slot0:_setSkillTip(slot1, slot2)

	if PCInputController.instance:getIsUse() and PlayerPrefsHelper.getNumber("keyTips", 0) ~= 0 then
		recthelper.setAnchor(slot0._goskilltip.transform, slot0._originSkillPosX, uv0.OnKeyTipsPosY)
	else
		recthelper.setAnchor(slot3, slot0._originSkillPosX, slot0._originSkillPosY)
	end
end

function slot0._hideCardSkillTips(slot0)
	slot0:_hideTips()
end

function slot0._onPassiveSkillClick(slot0, slot1, slot2, slot3, slot4, slot5)
	if slot1 then
		for slot9, slot10 in ipairs(slot1) do
			if not slot0._passiveSkillGOs[slot9] then
				slot11 = gohelper.cloneInPlace(slot0._passiveSkillPrefab, "item" .. slot9)

				table.insert(slot0._passiveSkillGOs, slot11)

				slot12 = gohelper.findChildImage(slot11, "title/simage_icon")

				table.insert(slot0._passiveSkillImgs, slot12)
				slot0:_setPassiveSkillTip(slot11, slot10, slot5)
				UISpriteSetMgr.instance:setFightPassiveSprite(slot12, slot10.icon)
			end

			gohelper.setActive(gohelper.findChild(slot0._passiveSkillGOs[#slot1], "txt_desc/image_line"), false)
			gohelper.setActive(slot11, true)
		end

		for slot9 = #slot1 + 1, #slot0._passiveSkillGOs do
			gohelper.setActive(slot0._passiveSkillGOs[slot9], false)
		end

		gohelper.setActive(slot0._gobufftip, true)
	end
end

function slot0._onBuffClick(slot0, slot1, slot2, slot3, slot4)
	if not FightEntityModel.instance:getById(slot1) then
		logError("get EntityMo fail, entityId : " .. tostring(slot1))

		return
	end

	if isDebugBuild then
		slot7 = {}

		for slot11, slot12 in ipairs(slot5.buffModel and slot5.buffModel:getList()) do
			table.insert(slot7, string.format("id=%d count=%d duration=%d name=%s desc=%s %s %s", slot12.buffId, slot12.count, slot12.duration, slot13.name, slot13.desc, slot13.isGoodBuff == 1 and "good" or "bad", lua_skill_buff.configDict[slot12.buffId].isNoShow == 0 and "show" or "noShow"))
		end

		logNormal(string.format("buff list %d :\n%s", #slot7, table.concat(slot7, "\n")))
	end

	slot6 = true

	for slot11, slot12 in ipairs(slot5.buffModel and slot5.buffModel:getList()) do
		if lua_skill_buff.configDict[slot12.buffId] and slot13.isNoShow == 0 then
			slot6 = false

			break
		end
	end

	if slot6 then
		return
	end

	ViewMgr.instance:openView(ViewName.FightBuffTipsView, {
		entityId = slot1,
		iconPos = slot2.position,
		offsetX = slot3,
		offsetY = slot4,
		viewname = slot0.viewName
	})
	slot0:_hideTips()

	slot9 = recthelper.rectToRelativeAnchorPos(slot2.position, slot0._gobuffinfowrapper.transform.parent)

	if slot5.side == FightEnum.EntitySide.MySide then
		recthelper.setAnchor(slot8, slot9.x - slot3 + 100, slot9.y + slot4)
	else
		recthelper.setAnchor(slot8, slot9.x + slot3, uv0.enemyBuffTipPosY)
	end

	slot0._buffinfoWrapperTr = slot8
	gohelper.onceAddComponent(slot0._buffinfoWrapperTr.gameObject, gohelper.Type_CanvasGroup).alpha = 0

	TaskDispatcher.runDelay(slot0._correctPos, slot0, 0.01)
end

function slot0._correctPos(slot0)
	if gohelper.fitScreenOffset(slot0._buffinfoWrapperTr) then
		recthelper.setAnchor(slot0._buffinfoWrapperTr, 0, 0)
	end

	gohelper.onceAddComponent(slot0._buffinfoWrapperTr.gameObject, gohelper.Type_CanvasGroup).alpha = 1
end

function slot0._formatSkillType(slot0, slot1)
	if slot1.effectTag == FightEnum.EffectTag.CounterSpell and FightEnum.EffectTagDesc[FightEnum.EffectTag.CounterSpell] then
		return FightEnum.EffectTagDesc[FightEnum.EffectTag.CounterSpell]
	end

	return (FightEnum.LogicTargetDesc[slot1.logicTarget] or luaLang("logic_target_single")) .. (FightEnum.EffectTagDesc[slot1.effectTag] or "")
end

function slot0._formatSkillDesc(slot0, slot1)
	return string.gsub(slot1, "(%d+%%*)", "<color=#DC6262><size=26>%1</size></color>")
end

function slot0._formatPassiveSkillDesc(slot0, slot1)
end

function slot0._onShowFightPrompt(slot0, slot1, slot2)
	TaskDispatcher.cancelTask(slot0._hidePrompt, slot0)

	slot3 = lua_fight_prompt.configDict[slot1]

	gohelper.setActive(slot0._gofightspecialtip, true)

	slot0._promptText.text = slot3.content

	UISpriteSetMgr.instance:setFightSprite(slot0._promptImage, "img_tsk_" .. slot3.color)
	slot0._prompAni:Play("open", 0, 0)

	if slot2 then
		TaskDispatcher.runDelay(slot0._hidePrompt, slot0, slot2 / 1000)
	end
end

function slot0._hidePrompt(slot0)
	slot0._prompAni:Play("close", 0, 0)
end

function slot0._onShowSeasonGuardIntro(slot0, slot1, slot2, slot3)
	slot0._guardTipsRoot = slot0._guardTipsRoot

	if not slot0._guardTipsRoot then
		slot0._guardTipsRoot = gohelper.create2d(slot0._tipsRoot, "guardTips")

		slot0:com_loadAsset("ui/viewres/fight/fightseasonguardtipsview.prefab", slot0._onGuardTipsLoadFinish)

		slot0._guardTipsTran = slot0._guardTipsRoot.transform
	end

	gohelper.setActive(slot0._guardTipsRoot, true)
	recthelper.setAnchor(slot0._guardTipsTran, slot2 + 307, slot3)
end

function slot0._onGuardTipsLoadFinish(slot0, slot1)
	slot3 = gohelper.clone(slot1:GetResource(), slot0._guardTipsRoot)
	gohelper.findChildText(slot3, "#scroll_ShieldTips/viewport/content/#go_shieldtipsitem/layout/#txt_title").text = lua_activity166_const_global.configDict[109] and slot6.value2 or ""
	gohelper.findChildText(slot3, "#scroll_ShieldTips/viewport/content/#go_shieldtipsitem/layout/#txt_dec").text = lua_activity166_const_global.configDict[110] and slot6.value2 or ""
	slot0._guardTipsContent = gohelper.findChild(slot3, "#scroll_ShieldTips/viewport/content").transform
end

function slot0.onDestroyView(slot0)
	slot0.buffTipClick:RemoveClickListener()

	slot0.buffTipClick = nil
end

return slot0
