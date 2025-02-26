module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotRoomEventTipsView", package.seeall)

slot0 = class("V1a6_CachotRoomEventTipsView", BaseView)

function slot0.onInitView(slot0)
	slot0._goheros = gohelper.findChild(slot0.viewGO, "top/#go_herogroup")
	slot0._goheroparent = gohelper.findChild(slot0.viewGO, "top/#go_herogroup/layout")
	slot0._gohero = gohelper.findChild(slot0.viewGO, "top/#go_herogroup/heroitem")
	slot0._recoverEventId = tonumber(V1a6_CachotConfig.instance:getConstConfig(V1a6_CachotEnum.Const.RecoverEvent).value)
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onOpen(slot0)
	slot0._heroItems = slot0:getUserDataTb_()

	gohelper.setActive(slot0._goheros, false)

	slot0._needShowCureEffect = V1a6_CachotController.instance.needShowCureEffect
	V1a6_CachotController.instance.needShowCureEffect = nil
	slot0._cureAddHp = V1a6_CachotController.instance.cureAddHp
	V1a6_CachotController.instance.cureAddHp = nil

	if slot0._needShowCureEffect then
		slot0:_onRoomChangePlayAnim()
	end

	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0.onCloseViewFinishCall, slot0, LuaEventSystem.High)
	slot0:addEventCb(V1a6_CachotController.instance, V1a6_CachotEvent.SelectHero, slot0._onSelectHero, slot0)
	slot0:addEventCb(V1a6_CachotController.instance, V1a6_CachotEvent.OnEventFinish, slot0._onEventFinish, slot0)
	slot0:addEventCb(V1a6_CachotController.instance, V1a6_CachotEvent.RoomChangePlayAnim, slot0._onRoomChangePlayAnim, slot0)
end

function slot0._onRoomChangePlayAnim(slot0)
	if slot0._needShowCureEffect then
		slot0._needShowCureEffect = false

		slot0:_showCureEffect()
	end
end

function slot0._onEventFinish(slot0, slot1)
	if lua_rogue_event.configDict[slot1.eventId].type == V1a6_CachotEnum.EventType.CharacterCure then
		if lua_rogue_event_life.configDict[slot2.eventId] then
			slot4 = string.splitToNumber(slot3.num, "#")
			slot0._cureData = {
				slot4[1],
				slot4[2],
				slot3.lifeAdd / 10,
				slot1.eventId
			}

			if slot0:_showTipAtOnce() then
				slot0:_checkCure()
			end
		end
	elseif slot2.type == V1a6_CachotEnum.EventType.CharacterRebirth then
		if lua_rogue_event_revive.configDict[slot2.eventId] then
			slot4 = string.splitToNumber(slot3.num, "#")
			slot0._reviveData = {
				slot4[1],
				slot4[2]
			}

			if slot0:_showTipAtOnce() then
				slot0:_checkRevive()
			end
		end
	elseif slot2.type == V1a6_CachotEnum.EventType.Tip and lua_rogue_event_tips.configDict[slot2.eventId] then
		V1a6_CachotEventController.instance:setPause(true, V1a6_CachotEnum.EventPauseType.Tips)
		PopupController.instance:addPopupView(PopupEnum.PriorityType.CachotTips, ViewName.V1a6_CachotTipsView, {
			str = slot3.desc,
			style = V1a6_CachotEnum.TipStyle.Normal
		})
	end
end

function slot0._showTipAtOnce(slot0)
	return ViewMgr.instance:isOpen(ViewName.V1a6_CachotRewardView)
end

function slot0._onSelectHero(slot0, slot1)
	slot0._selectHeroMo = slot1
end

function slot0.onCloseViewFinishCall(slot0, slot1)
	if slot1 == ViewName.V1a6_CachotHeroGroupEditView and slot0._selectHeroMo then
		slot0._selectHeroMo = nil

		V1a6_CachotController.instance:openV1a6_CachotTipsView({
			str = formatLuaLang("cachot_recruit", slot0._selectHeroMo.config.name),
			style = V1a6_CachotEnum.TipStyle.Normal
		})
	elseif slot1 == ViewName.V1a6_CachotEpisodeView or slot1 == ViewName.V1a6_CachotNormalStoreGoodsView then
		slot0:_checkCure()
		slot0:_checkRevive()
	elseif slot1 == ViewName.V1a6_CachotRoleRecoverView then
		slot0:_checkCure()
	end
end

function slot0._checkRevive(slot0)
	slot0._reviveData = nil

	if not slot0._reviveData then
		return
	end

	if slot1[1] == 1 then
		-- Nothing
	end
end

function slot0._showRecoverFromReviveTip(slot0)
	V1a6_CachotController.instance:openV1a6_CachotTipsView({
		str = formatLuaLang("cachot_revival_nodead", tostring(lua_rogue_event_life.configDict[slot0._recoverEventId].lifeAdd / 10) .. "%"),
		style = V1a6_CachotEnum.TipStyle.Normal
	})
end

function slot0._markNeedShowCureEffect(slot0)
	slot0._needShowCureEffect = true

	if ViewMgr.instance:isOpen(ViewName.V1a6_CachotRewardView) and GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		V1a6_CachotController.instance.needShowCureEffect = true
		V1a6_CachotController.instance.cureAddHp = slot0._cureAddHp
	end
end

function slot0._checkCure(slot0)
	slot0._cureData = nil

	if not slot0._cureData then
		return
	end

	slot2 = slot1[1]
	slot0._cureAddHp = slot1[3] > 0
	slot3 = math.abs(slot3)

	if slot1[4] == slot0._recoverEventId then
		slot0:_markNeedShowCureEffect()
		slot0:_showRecoverFromReviveTip()

		return
	end

	if slot2 == 1 then
		slot0:_markNeedShowCureEffect()
	elseif slot2 == 2 then
		slot6 = ""

		if V1a6_CachotModel.instance:getChangeLifes() then
			for slot10, slot11 in ipairs(slot5) do
				if HeroModel.instance:getByHeroId(slot11.heroId) then
					slot6 = (not string.nilorempty(slot6) or slot12.config.name) and slot12.config.name .. "、" .. slot12.config.name
				end
			end
		end

		if slot0._cureAddHp then
			V1a6_CachotController.instance:openV1a6_CachotTipsView({
				str = luaLang("cachot_multi_add_hp"),
				style = V1a6_CachotEnum.TipStyle.Normal,
				strExtra = {
					slot6,
					tostring(slot3) .. "%%"
				}
			})
		else
			V1a6_CachotController.instance:openV1a6_CachotTipsView({
				str = luaLang("cachot_multi_reduce_hp"),
				style = V1a6_CachotEnum.TipStyle.Normal,
				strExtra = {
					slot6,
					slot7
				}
			})
		end

		slot0:_markNeedShowCureEffect()
	elseif slot2 == 3 then
		slot0:_markNeedShowCureEffect()

		if slot0._cureAddHp then
			V1a6_CachotController.instance:openV1a6_CachotTipsView({
				str = formatLuaLang("cachot_team_add_hp", tostring(slot3) .. "%"),
				style = V1a6_CachotEnum.TipStyle.Normal
			})
		else
			V1a6_CachotController.instance:openV1a6_CachotTipsView({
				str = formatLuaLang("cachot_team_reduce_hp", slot5),
				style = V1a6_CachotEnum.TipStyle.Normal
			})
		end
	end
end

function slot0._restrictChangeData(slot0, slot1)
	if 4 >= #slot1 then
		return slot1
	end

	slot4 = {}

	if V1a6_CachotModel.instance:getTeamInfo():getCurGroupInfo() then
		for slot9, slot10 in ipairs(slot5.heroList) do
			if HeroModel.instance:getById(slot10) and slot3:getHeroHp(slot11.heroId).life > 0 then
				slot4[slot11.heroId] = true
			end
		end
	end

	slot6 = {}

	for slot10, slot11 in ipairs(slot1) do
		if slot4[slot11.heroId] then
			table.insert(slot6, slot11)
		end
	end

	if #slot6 == slot2 then
		return slot6
	end

	for slot10 = 1, slot2 - #slot6 do
		for slot14, slot15 in ipairs(slot1) do
			if not slot4[slot15.heroId] then
				table.insert(slot6, slot15)

				slot4[slot15.heroId] = true

				break
			end
		end
	end

	return slot6
end

function slot0._showCureEffect(slot0)
	if not V1a6_CachotModel.instance:getChangeLifes() then
		return
	end

	slot0._hpChangeData = {}

	for slot6, slot7 in ipairs(slot1) do
		table.insert(slot0._hpChangeData, {
			total = 1000,
			heroId = slot7.heroId,
			preVal = slot7.life,
			nowVal = V1a6_CachotModel.instance:getTeamInfo():getHeroHp(slot7.heroId).life
		})
	end

	slot0._hpChangeData = slot0:_restrictChangeData(slot0._hpChangeData)

	gohelper.setActive(slot0._goheros, true)
	gohelper.CreateObjList(slot0, slot0._onItemLoad, slot0._hpChangeData, slot0._goheroparent, slot0._gohero)

	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end

	slot6 = 0.3
	slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, slot6, slot0._tweenUpdate, slot0._tweenEnd, slot0, nil, EaseType.Linear)

	slot0:_tweenUpdate(0)

	for slot6 = #slot0._hpChangeData + 1, #slot0._heroItems do
		gohelper.setActive(slot0._heroItems[slot6] and slot7.go, false)
	end

	TaskDispatcher.cancelTask(slot0._delayFinish, slot0)
	TaskDispatcher.runDelay(slot0._delayFinish, slot0, 2.1)
end

function slot0._delayFinish(slot0)
	gohelper.setActive(slot0._goheros, false)
end

function slot0._onItemLoad(slot0, slot1, slot2, slot3)
	if not slot0._heroItems[slot3] then
		slot4 = slot0:getUserDataTb_()
		slot4.go = slot1
		slot4.animator = slot1:GetComponent("Animator")
		slot4.slider = gohelper.findChildSlider(slot1, "#slider_hp")
		slot4.icon = gohelper.findChildSingleImage(slot1, "hero/#simage_rolehead")
		slot4.arrowred = gohelper.findChildImage(slot1, "arrow_red")
		slot4.arrowgreen = gohelper.findChildImage(slot1, "arrow_green")
		slot0._heroItems[slot3] = slot4
	end

	slot4.icon:LoadImage(ResUrl.getHeadIconSmall(lua_skin.configDict[HeroModel.instance:getByHeroId(slot2.heroId).skin].headIcon))
	gohelper.setActive(slot4.arrowred, not slot0._cureAddHp)
	gohelper.setActive(slot4.arrowgreen, slot0._cureAddHp)
	gohelper.setActive(slot4.go, true)

	if slot0._cureAddHp then
		slot4.animator:Play("healthy", 0, 0)
	else
		slot4.animator:Play(slot2.nowVal <= 0 and "die" or "hit", 0, 0)
	end
end

function slot0._tweenUpdate(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._hpChangeData) do
		slot0._heroItems[slot5].slider:SetValue(Mathf.Lerp(slot6.preVal, slot6.nowVal, slot1) / slot6.total)
	end
end

function slot0._tweenEnd(slot0)
	slot0._tweenId = nil
end

function slot0.onClose(slot0)
	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end

	TaskDispatcher.cancelTask(slot0._delayFinish, slot0)
end

return slot0
