module("modules.logic.rouge.map.view.map.RougeMapEliteFightView", package.seeall)

local var_0_0 = class("RougeMapEliteFightView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goboss = gohelper.findChild(arg_1_0.viewGO, "#go_boss")
	arg_1_0._txtbossdesc = gohelper.findChildText(arg_1_0.viewGO, "#go_boss/scroll_bossdesc/viewport/#txt_bossdec")
	arg_1_0._imageBossHead = gohelper.findChildImage(arg_1_0.viewGO, "#go_boss/#image_bosshead")
	arg_1_0._imagecareer = gohelper.findChildImage(arg_1_0.viewGO, "#go_boss/career")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0:addEventCb(RougeMapController.instance, RougeMapEvent.onChangeMapInfo, arg_4_0.refreshBoss, arg_4_0)
	arg_4_0:addEventCb(RougeMapController.instance, RougeMapEvent.onUpdateMapInfo, arg_4_0.refreshBoss, arg_4_0)
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0:refreshBoss()
end

function var_0_0.refreshBoss(arg_6_0)
	if not RougeMapModel.instance:isNormalLayer() then
		gohelper.setActive(arg_6_0._goboss, false)

		arg_6_0.eventId = nil

		return
	end

	if not RougeMapEffectHelper.checkHadEffect(RougeMapEnum.EffectType.UnlockShowPassFightMask, RougeMapEnum.EventType.EliteFight) then
		gohelper.setActive(arg_6_0._goboss, false)

		arg_6_0.eventId = nil

		return
	end

	local var_6_0 = arg_6_0:getShowBossEventId()

	if not var_6_0 then
		gohelper.setActive(arg_6_0._goboss, false)

		arg_6_0.eventId = nil

		return
	end

	if not RougeOutsideModel.instance:passedEventId(var_6_0) then
		gohelper.setActive(arg_6_0._goboss, false)

		arg_6_0.eventId = nil

		return
	end

	if var_6_0 == arg_6_0.eventId then
		return
	end

	gohelper.setActive(arg_6_0._goboss, true)

	arg_6_0.eventId = var_6_0

	arg_6_0:refreshUI()
end

function var_0_0.checkUnlockTalent(arg_7_0)
	local var_7_0 = RougeMapConfig.instance:getShowFightMonsterMaskTalentId(RougeMapEnum.EventType.EliteFight)

	return var_7_0 and RougeTalentModel.instance:checkNodeLight(var_7_0)
end

function var_0_0.getShowBossEventId(arg_8_0)
	local var_8_0 = RougeMapModel.instance:getNodeDict()

	for iter_8_0, iter_8_1 in pairs(var_8_0) do
		local var_8_1 = iter_8_1:getEventCo()

		if var_8_1 and var_8_1.type == RougeMapEnum.EventType.EliteFight then
			return var_8_1.id
		end
	end
end

function var_0_0.refreshUI(arg_9_0)
	local var_9_0 = RougeMapConfig.instance:getFightEvent(arg_9_0.eventId)

	if not var_9_0 then
		return
	end

	local var_9_1 = arg_9_0:getBossCareer(var_9_0)

	UISpriteSetMgr.instance:setRougeSprite(arg_9_0._imagecareer, "rouge_map_career_" .. var_9_1)

	arg_9_0._txtbossdesc.text = var_9_0.bossDesc

	local var_9_2 = var_9_0.bossMask

	if string.nilorempty(var_9_2) then
		logError(string.format("战斗事件表id ： %s， 没有配置Boss剪影", arg_9_0.eventId))

		return
	end

	UISpriteSetMgr.instance:setRouge3Sprite(arg_9_0._imageBossHead, var_9_2)
end

function var_0_0.getBossCareer(arg_10_0, arg_10_1)
	local var_10_0 = DungeonConfig.instance:getEpisodeCO(arg_10_1.episodeId)
	local var_10_1 = lua_battle.configDict[var_10_0.battleId]

	if not var_10_1 then
		logError("not found battle co, battle id : " .. tostring(var_10_0.battleId))

		return 1
	end

	local var_10_2 = string.splitToNumber(var_10_1.monsterGroupIds, "#")

	for iter_10_0, iter_10_1 in ipairs(var_10_2) do
		local var_10_3 = lua_monster_group.configDict[iter_10_1].bossId

		if not string.nilorempty(var_10_3) then
			local var_10_4 = string.splitToNumber(var_10_3, "#")[1]

			return lua_monster.configDict[var_10_4].career
		end
	end

	logError("not found boss career, battle id .. " .. var_10_1.id)

	return 1
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0
