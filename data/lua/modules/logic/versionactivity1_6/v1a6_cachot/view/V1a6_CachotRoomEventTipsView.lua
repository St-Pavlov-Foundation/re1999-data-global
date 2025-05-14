module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotRoomEventTipsView", package.seeall)

local var_0_0 = class("V1a6_CachotRoomEventTipsView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goheros = gohelper.findChild(arg_1_0.viewGO, "top/#go_herogroup")
	arg_1_0._goheroparent = gohelper.findChild(arg_1_0.viewGO, "top/#go_herogroup/layout")
	arg_1_0._gohero = gohelper.findChild(arg_1_0.viewGO, "top/#go_herogroup/heroitem")

	local var_1_0 = V1a6_CachotConfig.instance:getConstConfig(V1a6_CachotEnum.Const.RecoverEvent).value

	arg_1_0._recoverEventId = tonumber(var_1_0)
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onOpen(arg_4_0)
	arg_4_0._heroItems = arg_4_0:getUserDataTb_()

	gohelper.setActive(arg_4_0._goheros, false)

	arg_4_0._needShowCureEffect = V1a6_CachotController.instance.needShowCureEffect
	V1a6_CachotController.instance.needShowCureEffect = nil
	arg_4_0._cureAddHp = V1a6_CachotController.instance.cureAddHp
	V1a6_CachotController.instance.cureAddHp = nil

	if arg_4_0._needShowCureEffect then
		arg_4_0:_onRoomChangePlayAnim()
	end

	arg_4_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_4_0.onCloseViewFinishCall, arg_4_0, LuaEventSystem.High)
	arg_4_0:addEventCb(V1a6_CachotController.instance, V1a6_CachotEvent.SelectHero, arg_4_0._onSelectHero, arg_4_0)
	arg_4_0:addEventCb(V1a6_CachotController.instance, V1a6_CachotEvent.OnEventFinish, arg_4_0._onEventFinish, arg_4_0)
	arg_4_0:addEventCb(V1a6_CachotController.instance, V1a6_CachotEvent.RoomChangePlayAnim, arg_4_0._onRoomChangePlayAnim, arg_4_0)
end

function var_0_0._onRoomChangePlayAnim(arg_5_0)
	if arg_5_0._needShowCureEffect then
		arg_5_0._needShowCureEffect = false

		arg_5_0:_showCureEffect()
	end
end

function var_0_0._onEventFinish(arg_6_0, arg_6_1)
	local var_6_0 = lua_rogue_event.configDict[arg_6_1.eventId]

	if var_6_0.type == V1a6_CachotEnum.EventType.CharacterCure then
		local var_6_1 = lua_rogue_event_life.configDict[var_6_0.eventId]

		if var_6_1 then
			local var_6_2 = string.splitToNumber(var_6_1.num, "#")
			local var_6_3 = var_6_2[1]
			local var_6_4 = var_6_2[2]
			local var_6_5 = var_6_1.lifeAdd / 10

			arg_6_0._cureData = {
				var_6_3,
				var_6_4,
				var_6_5,
				arg_6_1.eventId
			}

			if arg_6_0:_showTipAtOnce() then
				arg_6_0:_checkCure()
			end
		end
	elseif var_6_0.type == V1a6_CachotEnum.EventType.CharacterRebirth then
		local var_6_6 = lua_rogue_event_revive.configDict[var_6_0.eventId]

		if var_6_6 then
			local var_6_7 = string.splitToNumber(var_6_6.num, "#")
			local var_6_8 = var_6_7[1]
			local var_6_9 = var_6_7[2]

			arg_6_0._reviveData = {
				var_6_8,
				var_6_9
			}

			if arg_6_0:_showTipAtOnce() then
				arg_6_0:_checkRevive()
			end
		end
	elseif var_6_0.type == V1a6_CachotEnum.EventType.Tip then
		local var_6_10 = lua_rogue_event_tips.configDict[var_6_0.eventId]

		if var_6_10 then
			V1a6_CachotEventController.instance:setPause(true, V1a6_CachotEnum.EventPauseType.Tips)
			PopupController.instance:addPopupView(PopupEnum.PriorityType.CachotTips, ViewName.V1a6_CachotTipsView, {
				str = var_6_10.desc,
				style = V1a6_CachotEnum.TipStyle.Normal
			})
		end
	end
end

function var_0_0._showTipAtOnce(arg_7_0)
	return ViewMgr.instance:isOpen(ViewName.V1a6_CachotRewardView)
end

function var_0_0._onSelectHero(arg_8_0, arg_8_1)
	arg_8_0._selectHeroMo = arg_8_1
end

function var_0_0.onCloseViewFinishCall(arg_9_0, arg_9_1)
	if arg_9_1 == ViewName.V1a6_CachotHeroGroupEditView and arg_9_0._selectHeroMo then
		local var_9_0 = formatLuaLang("cachot_recruit", arg_9_0._selectHeroMo.config.name)

		arg_9_0._selectHeroMo = nil

		V1a6_CachotController.instance:openV1a6_CachotTipsView({
			str = var_9_0,
			style = V1a6_CachotEnum.TipStyle.Normal
		})
	elseif arg_9_1 == ViewName.V1a6_CachotEpisodeView or arg_9_1 == ViewName.V1a6_CachotNormalStoreGoodsView then
		arg_9_0:_checkCure()
		arg_9_0:_checkRevive()
	elseif arg_9_1 == ViewName.V1a6_CachotRoleRecoverView then
		arg_9_0:_checkCure()
	end
end

function var_0_0._checkRevive(arg_10_0)
	local var_10_0 = arg_10_0._reviveData

	arg_10_0._reviveData = nil

	if not var_10_0 then
		return
	end

	if var_10_0[1] == 1 then
		-- block empty
	end
end

function var_0_0._showRecoverFromReviveTip(arg_11_0)
	local var_11_0 = lua_rogue_event_life.configDict[arg_11_0._recoverEventId].lifeAdd / 10
	local var_11_1 = formatLuaLang("cachot_revival_nodead", tostring(var_11_0) .. "%")

	V1a6_CachotController.instance:openV1a6_CachotTipsView({
		str = var_11_1,
		style = V1a6_CachotEnum.TipStyle.Normal
	})
end

function var_0_0._markNeedShowCureEffect(arg_12_0)
	arg_12_0._needShowCureEffect = true

	if ViewMgr.instance:isOpen(ViewName.V1a6_CachotRewardView) and GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		V1a6_CachotController.instance.needShowCureEffect = true
		V1a6_CachotController.instance.cureAddHp = arg_12_0._cureAddHp
	end
end

function var_0_0._checkCure(arg_13_0)
	local var_13_0 = arg_13_0._cureData

	arg_13_0._cureData = nil

	if not var_13_0 then
		return
	end

	local var_13_1 = var_13_0[1]
	local var_13_2 = var_13_0[3]
	local var_13_3 = var_13_0[4]

	arg_13_0._cureAddHp = var_13_2 > 0

	local var_13_4 = math.abs(var_13_2)

	if var_13_3 == arg_13_0._recoverEventId then
		arg_13_0:_markNeedShowCureEffect()
		arg_13_0:_showRecoverFromReviveTip()

		return
	end

	if var_13_1 == 1 then
		arg_13_0:_markNeedShowCureEffect()
	elseif var_13_1 == 2 then
		local var_13_5 = V1a6_CachotModel.instance:getChangeLifes()
		local var_13_6 = ""

		if var_13_5 then
			for iter_13_0, iter_13_1 in ipairs(var_13_5) do
				local var_13_7 = HeroModel.instance:getByHeroId(iter_13_1.heroId)

				if var_13_7 then
					if string.nilorempty(var_13_6) then
						var_13_6 = var_13_7.config.name
					else
						var_13_6 = var_13_6 .. "、" .. var_13_7.config.name
					end
				end
			end
		end

		local var_13_8 = tostring(var_13_4) .. "%%"

		if arg_13_0._cureAddHp then
			local var_13_9 = luaLang("cachot_multi_add_hp")

			V1a6_CachotController.instance:openV1a6_CachotTipsView({
				str = var_13_9,
				style = V1a6_CachotEnum.TipStyle.Normal,
				strExtra = {
					var_13_6,
					var_13_8
				}
			})
		else
			local var_13_10 = luaLang("cachot_multi_reduce_hp")

			V1a6_CachotController.instance:openV1a6_CachotTipsView({
				str = var_13_10,
				style = V1a6_CachotEnum.TipStyle.Normal,
				strExtra = {
					var_13_6,
					var_13_8
				}
			})
		end

		arg_13_0:_markNeedShowCureEffect()
	elseif var_13_1 == 3 then
		arg_13_0:_markNeedShowCureEffect()

		local var_13_11 = tostring(var_13_4) .. "%"

		if arg_13_0._cureAddHp then
			local var_13_12 = formatLuaLang("cachot_team_add_hp", var_13_11)

			V1a6_CachotController.instance:openV1a6_CachotTipsView({
				str = var_13_12,
				style = V1a6_CachotEnum.TipStyle.Normal
			})
		else
			local var_13_13 = formatLuaLang("cachot_team_reduce_hp", var_13_11)

			V1a6_CachotController.instance:openV1a6_CachotTipsView({
				str = var_13_13,
				style = V1a6_CachotEnum.TipStyle.Normal
			})
		end
	end
end

function var_0_0._restrictChangeData(arg_14_0, arg_14_1)
	local var_14_0 = 4

	if var_14_0 >= #arg_14_1 then
		return arg_14_1
	end

	local var_14_1 = V1a6_CachotModel.instance:getTeamInfo()
	local var_14_2 = {}
	local var_14_3 = var_14_1:getCurGroupInfo()

	if var_14_3 then
		for iter_14_0, iter_14_1 in ipairs(var_14_3.heroList) do
			local var_14_4 = HeroModel.instance:getById(iter_14_1)

			if var_14_4 and var_14_1:getHeroHp(var_14_4.heroId).life > 0 then
				var_14_2[var_14_4.heroId] = true
			end
		end
	end

	local var_14_5 = {}

	for iter_14_2, iter_14_3 in ipairs(arg_14_1) do
		if var_14_2[iter_14_3.heroId] then
			table.insert(var_14_5, iter_14_3)
		end
	end

	if #var_14_5 == var_14_0 then
		return var_14_5
	end

	for iter_14_4 = 1, var_14_0 - #var_14_5 do
		for iter_14_5, iter_14_6 in ipairs(arg_14_1) do
			if not var_14_2[iter_14_6.heroId] then
				table.insert(var_14_5, iter_14_6)

				var_14_2[iter_14_6.heroId] = true

				break
			end
		end
	end

	return var_14_5
end

function var_0_0._showCureEffect(arg_15_0)
	local var_15_0 = V1a6_CachotModel.instance:getChangeLifes()

	if not var_15_0 then
		return
	end

	local var_15_1 = V1a6_CachotModel.instance:getTeamInfo()

	arg_15_0._hpChangeData = {}

	for iter_15_0, iter_15_1 in ipairs(var_15_0) do
		local var_15_2 = var_15_1:getHeroHp(iter_15_1.heroId)

		table.insert(arg_15_0._hpChangeData, {
			total = 1000,
			heroId = iter_15_1.heroId,
			preVal = iter_15_1.life,
			nowVal = var_15_2.life
		})
	end

	arg_15_0._hpChangeData = arg_15_0:_restrictChangeData(arg_15_0._hpChangeData)

	gohelper.setActive(arg_15_0._goheros, true)
	gohelper.CreateObjList(arg_15_0, arg_15_0._onItemLoad, arg_15_0._hpChangeData, arg_15_0._goheroparent, arg_15_0._gohero)

	if arg_15_0._tweenId then
		ZProj.TweenHelper.KillById(arg_15_0._tweenId)

		arg_15_0._tweenId = nil
	end

	arg_15_0._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.3, arg_15_0._tweenUpdate, arg_15_0._tweenEnd, arg_15_0, nil, EaseType.Linear)

	arg_15_0:_tweenUpdate(0)

	for iter_15_2 = #arg_15_0._hpChangeData + 1, #arg_15_0._heroItems do
		local var_15_3 = arg_15_0._heroItems[iter_15_2]

		gohelper.setActive(var_15_3 and var_15_3.go, false)
	end

	TaskDispatcher.cancelTask(arg_15_0._delayFinish, arg_15_0)
	TaskDispatcher.runDelay(arg_15_0._delayFinish, arg_15_0, 2.1)
end

function var_0_0._delayFinish(arg_16_0)
	gohelper.setActive(arg_16_0._goheros, false)
end

function var_0_0._onItemLoad(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = arg_17_0._heroItems[arg_17_3]

	if not var_17_0 then
		var_17_0 = arg_17_0:getUserDataTb_()
		var_17_0.go = arg_17_1
		var_17_0.animator = arg_17_1:GetComponent("Animator")
		var_17_0.slider = gohelper.findChildSlider(arg_17_1, "#slider_hp")
		var_17_0.icon = gohelper.findChildSingleImage(arg_17_1, "hero/#simage_rolehead")
		var_17_0.arrowred = gohelper.findChildImage(arg_17_1, "arrow_red")
		var_17_0.arrowgreen = gohelper.findChildImage(arg_17_1, "arrow_green")
		arg_17_0._heroItems[arg_17_3] = var_17_0
	end

	local var_17_1 = HeroModel.instance:getByHeroId(arg_17_2.heroId)
	local var_17_2 = lua_skin.configDict[var_17_1.skin]

	var_17_0.icon:LoadImage(ResUrl.getHeadIconSmall(var_17_2.headIcon))
	gohelper.setActive(var_17_0.arrowred, not arg_17_0._cureAddHp)
	gohelper.setActive(var_17_0.arrowgreen, arg_17_0._cureAddHp)
	gohelper.setActive(var_17_0.go, true)

	if arg_17_0._cureAddHp then
		var_17_0.animator:Play("healthy", 0, 0)
	else
		var_17_0.animator:Play(arg_17_2.nowVal <= 0 and "die" or "hit", 0, 0)
	end
end

function var_0_0._tweenUpdate(arg_18_0, arg_18_1)
	for iter_18_0, iter_18_1 in ipairs(arg_18_0._hpChangeData) do
		arg_18_0._heroItems[iter_18_0].slider:SetValue(Mathf.Lerp(iter_18_1.preVal, iter_18_1.nowVal, arg_18_1) / iter_18_1.total)
	end
end

function var_0_0._tweenEnd(arg_19_0)
	arg_19_0._tweenId = nil
end

function var_0_0.onClose(arg_20_0)
	if arg_20_0._tweenId then
		ZProj.TweenHelper.KillById(arg_20_0._tweenId)

		arg_20_0._tweenId = nil
	end

	TaskDispatcher.cancelTask(arg_20_0._delayFinish, arg_20_0)
end

return var_0_0
