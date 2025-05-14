module("modules.logic.rouge.controller.RougeHeroGroupController", package.seeall)

local var_0_0 = class("RougeHeroGroupController", BaseController)

function var_0_0.addConstEvents(arg_1_0)
	LoginController.instance:registerCallback(LoginEvent.OnGetInfoFinish, arg_1_0._onGetInfoFinish, arg_1_0)
end

function var_0_0.reInit(arg_2_0)
	FightController.instance:unregisterCallback(FightEvent.RespGetFightRecordGroupReply, arg_2_0._onGetFightRecordGroupReply, arg_2_0)
end

function var_0_0._onGetInfoFinish(arg_3_0)
	return
end

function var_0_0.openGroupFightView(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0._groupFightName = arg_4_0:_getGroupFightViewName(arg_4_2)

	RougeTeamListModel.addAssistHook()
	RougeHeroGroupModel.instance:clear()
	RougeHeroSingleGroupModel.instance:setMaxHeroCount(RougeEnum.FightTeamHeroNum)
	RougeHeroGroupModel.instance:onGetHeroGroupList(RougeModel.instance:getTeamInfo():getGroupInfos())
	RougeHeroGroupModel.instance:setReplayParam(nil)
	RougeHeroGroupModel.instance:setParam(arg_4_1, arg_4_2, arg_4_3)
	HeroGroupModel.instance:setReplayParam(nil)

	HeroGroupModel.instance.battleId = arg_4_1
	HeroGroupModel.instance.episodeId = arg_4_2
	HeroGroupModel.instance.adventure = arg_4_3

	local var_4_0 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightReplay)
	local var_4_1 = DungeonModel.instance:getEpisodeInfo(arg_4_2)
	local var_4_2 = var_4_1 and var_4_1.star == DungeonEnum.StarType.Advanced and var_4_1.hasRecord
	local var_4_3 = PlayerPrefsHelper.getString(FightModel.getPrefsKeyFightPassModel(), "")

	if var_4_0 and var_4_2 and not string.nilorempty(var_4_3) and cjson.decode(var_4_3)[tostring(arg_4_2)] then
		FightController.instance:registerCallback(FightEvent.RespGetFightRecordGroupReply, arg_4_0._onGetFightRecordGroupReply, arg_4_0)
		FightRpc.instance:sendGetFightRecordGroupRequest(arg_4_2)

		return
	end

	local var_4_4 = HeroGroupModel.instance:getCurGroupMO()

	if arg_4_0:changeToDefaultEquip() and not var_4_4.temp then
		HeroGroupModel.instance:saveCurGroupData(function()
			ViewMgr.instance:openView(arg_4_0._groupFightName)
		end)

		return
	end

	if HeroGroupModel.instance.heroGroupType == ModuleEnum.HeroGroupType.Trial then
		var_4_4:saveData()
	end

	ViewMgr.instance:openView(arg_4_0._groupFightName)
end

function var_0_0._getGroupFightViewName(arg_6_0, arg_6_1)
	local var_6_0 = DungeonConfig.instance:getEpisodeCO(arg_6_1)
	local var_6_1 = var_6_0 and DungeonConfig.instance:getChapterCO(var_6_0.chapterId)

	if var_6_1 then
		if var_6_1.actId == VersionActivity1_2Enum.ActivityId.Dungeon then
			return ViewName.VersionActivity_1_2_HeroGroupView
		end

		if var_6_1.type == DungeonEnum.ChapterType.RoleStoryChallenge then
			return ViewName.RoleStoryHeroGroupFightView
		end
	end

	return ViewName.RougeHeroGroupFightView
end

function var_0_0.changeToDefaultEquip(arg_7_0)
	local var_7_0 = HeroGroupModel.instance:getCurGroupMO()
	local var_7_1 = var_7_0.equips
	local var_7_2 = var_7_0.heroList
	local var_7_3
	local var_7_4
	local var_7_5 = false

	for iter_7_0, iter_7_1 in ipairs(var_7_2) do
		local var_7_6 = HeroModel.instance:getById(iter_7_1)
		local var_7_7 = iter_7_0 - 1

		if var_7_6 and var_7_6:hasDefaultEquip() and var_7_6.defaultEquipUid ~= var_7_1[var_7_7].equipUid[1] then
			if var_7_7 <= arg_7_0:_checkEquipInPreviousEquip(var_7_7 - 1, var_7_6.defaultEquipUid, var_7_1) then
				local var_7_8 = arg_7_0:_checkEquipInBehindEquip(var_7_7 + 1, var_7_6.defaultEquipUid, var_7_1)

				if var_7_8 > 0 then
					var_7_1[var_7_8].equipUid[1] = var_7_1[var_7_7].equipUid[1]
				end

				var_7_1[var_7_7].equipUid[1] = var_7_6.defaultEquipUid
			elseif var_7_1[var_7_7].equipUid[1] == var_7_6.defaultEquipUid then
				var_7_1[var_7_7].equipUid[1] = "0"
			end

			var_7_5 = true
		end
	end

	return var_7_5
end

function var_0_0._checkEquipInBehindEquip(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if not EquipModel.instance:getEquip(arg_8_2) then
		return -1
	end

	for iter_8_0 = arg_8_1, #arg_8_3 do
		if arg_8_2 == arg_8_3[iter_8_0].equipUid[1] then
			return iter_8_0
		end
	end

	return -1
end

function var_0_0._checkEquipInPreviousEquip(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if not EquipModel.instance:getEquip(arg_9_2) then
		return arg_9_1 + 1
	end

	for iter_9_0 = arg_9_1, 0, -1 do
		if arg_9_2 == arg_9_3[iter_9_0].equipUid[1] then
			return iter_9_0
		end
	end

	return arg_9_1 + 1
end

function var_0_0._onGetFightRecordGroupReply(arg_10_0, arg_10_1)
	FightController.instance:unregisterCallback(FightEvent.RespGetFightRecordGroupReply, arg_10_0._onGetFightRecordGroupReply, arg_10_0)
	HeroGroupModel.instance:setReplayParam(arg_10_1)
	ViewMgr.instance:openView(arg_10_0._groupFightName)
end

function var_0_0.onReceiveHeroGroupSnapshot(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1.snapshotId
	local var_11_1 = arg_11_1.snapshotSubId
end

function var_0_0.setFightHeroSingleGroup(arg_12_0)
	local var_12_0 = FightModel.instance:getFightParam()

	if not var_12_0 then
		return false
	end

	local var_12_1 = RougeHeroGroupModel.instance:getCurGroupMO()

	if not var_12_1 then
		GameFacade.showToast(ToastEnum.FightNoCurGroupMO)

		return false
	end

	local var_12_2 = RougeModel.instance:getTeamInfo()
	local var_12_3, var_12_4 = var_12_1:getMainList()
	local var_12_5, var_12_6 = var_12_1:getSubList()
	local var_12_7 = RougeHeroSingleGroupModel.instance:getList()
	local var_12_8, var_12_9 = var_12_1:getAllHeroEquips()

	for iter_12_0 = 1, #var_12_3 do
		if var_12_3[iter_12_0] ~= var_12_7[iter_12_0].heroUid then
			var_12_3[iter_12_0] = "0"
			var_12_4 = var_12_4 - 1

			if var_12_8[iter_12_0] then
				var_12_8[iter_12_0].heroUid = "0"
			end
		end
	end

	for iter_12_1 = #var_12_3 + 1, math.min(#var_12_3 + #var_12_5, #var_12_7) do
		if var_12_5[iter_12_1 - #var_12_3] ~= var_12_7[iter_12_1].heroUid then
			var_12_5[iter_12_1 - #var_12_3] = "0"
			var_12_6 = var_12_6 - 1

			if var_12_8[iter_12_1] then
				var_12_8[iter_12_1].heroUid = "0"
			end
		end
	end

	for iter_12_2, iter_12_3 in ipairs(var_12_7) do
		if var_12_2:getAssistHeroMoByUid(iter_12_3.heroUid) then
			var_12_0:setAssistHeroInfo(iter_12_3.heroUid)

			break
		end
	end

	for iter_12_4, iter_12_5 in ipairs(var_12_8) do
		if iter_12_4 > RougeEnum.FightTeamNormalHeroNum then
			rawset(var_12_8, iter_12_4, nil)
		end
	end

	if (not var_12_1.aidDict or #var_12_1.aidDict <= 0) and var_12_4 + var_12_6 == 0 then
		GameFacade.showToast(ToastEnum.FightNoCurGroupMO)

		return false
	end

	local var_12_10

	if Season123Controller.isEpisodeFromSeason123(var_12_0.episodeId) then
		var_12_10 = Season123HeroGroupUtils.getAllHeroActivity123Equips(var_12_1)
	else
		var_12_10 = var_12_1:getAllHeroActivity104Equips()
	end

	local var_12_11 = var_12_0.battleId
	local var_12_12 = var_12_11 and lua_battle.configDict[var_12_11]
	local var_12_13 = var_12_12 and var_12_12.noClothSkill == 0 and var_12_1.clothId or 0
	local var_12_14 = var_12_2:getSupportSkillStrList()

	var_12_0:setMySide(var_12_13, var_12_3, var_12_5, var_12_8, var_12_10, nil, var_12_14)

	if var_12_9 then
		RougeHeroGroupModel.instance:rougeSaveCurGroup()
	end

	return true
end

function var_0_0.removeEquip(arg_13_0, arg_13_1)
	if HeroSingleGroupModel.instance:isTemp() or arg_13_1 then
		local var_13_0, var_13_1, var_13_2 = EquipTeamListModel.instance:_getRequestData(arg_13_0, "0")
		local var_13_3 = {
			index = var_13_1,
			equipUid = var_13_2
		}

		HeroGroupModel.instance:replaceEquips(var_13_3, EquipTeamListModel.instance:getCurGroupMo())

		if not arg_13_1 then
			HeroGroupController.instance:dispatchEvent(HeroGroupEvent.ChangeEquip, var_13_1)
		end
	else
		RougeHeroGroupModel.instance:rougeSaveCurGroup()
	end
end

function var_0_0.replaceEquip(arg_14_0, arg_14_1, arg_14_2)
	if HeroSingleGroupModel.instance:isTemp() or arg_14_2 then
		local var_14_0, var_14_1, var_14_2 = EquipTeamListModel.instance:_getRequestData(arg_14_0, arg_14_1)
		local var_14_3 = {
			index = var_14_1,
			equipUid = var_14_2
		}

		HeroGroupModel.instance:replaceEquips(var_14_3, EquipTeamListModel.instance:getCurGroupMo())

		if not arg_14_2 then
			HeroGroupController.instance:dispatchEvent(HeroGroupEvent.ChangeEquip, var_14_1)
		end
	else
		RougeHeroGroupModel.instance:rougeSaveCurGroup()
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
