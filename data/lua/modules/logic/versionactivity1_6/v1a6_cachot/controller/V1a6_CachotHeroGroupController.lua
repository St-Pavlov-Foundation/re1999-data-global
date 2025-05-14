module("modules.logic.versionactivity1_6.v1a6_cachot.controller.V1a6_CachotHeroGroupController", package.seeall)

local var_0_0 = class("V1a6_CachotHeroGroupController", BaseController)

function var_0_0.addConstEvents(arg_1_0)
	LoginController.instance:registerCallback(LoginEvent.OnGetInfoFinish, arg_1_0._onGetInfoFinish, arg_1_0)
end

function var_0_0.reInit(arg_2_0)
	FightController.instance:unregisterCallback(FightEvent.RespGetFightRecordGroupReply, arg_2_0._onGetFightRecordGroupReply, arg_2_0)
end

function var_0_0._onGetInfoFinish(arg_3_0)
	HeroGroupModel.instance:setParam()
end

function var_0_0.openGroupFightView(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0._groupFightName = arg_4_0:_getGroupFightViewName(arg_4_2)

	V1a6_CachotHeroGroupModel.instance:clear()
	V1a6_CachotHeroSingleGroupModel.instance:setMaxHeroCount(V1a6_CachotEnum.HeroCountInGroup)
	V1a6_CachotHeroGroupModel.instance:onGetHeroGroupList(V1a6_CachotModel.instance:getTeamInfo():getGroupInfos())
	V1a6_CachotHeroGroupModel.instance:setReplayParam(nil)
	V1a6_CachotHeroGroupModel.instance:setParam(arg_4_1, arg_4_2, arg_4_3)
	HeroGroupModel.instance:setReplayParam(nil)
	HeroGroupModel.instance:setParam(arg_4_1, arg_4_2, arg_4_3)
	ViewMgr.instance:openView(arg_4_0._groupFightName)

	local var_4_0 = V1a6_CachotModel.instance:getRogueInfo()

	if var_4_0 then
		V1a6_CachotController.instance.heartNum = var_4_0.heart
	end
end

function var_0_0._getGroupFightViewName(arg_5_0, arg_5_1)
	return ViewName.V1a6_CachotHeroGroupFightView
end

function var_0_0.changeToDefaultEquip(arg_6_0)
	local var_6_0 = HeroGroupModel.instance:getCurGroupMO()
	local var_6_1 = var_6_0.equips
	local var_6_2 = var_6_0.heroList
	local var_6_3
	local var_6_4
	local var_6_5 = false

	for iter_6_0, iter_6_1 in ipairs(var_6_2) do
		local var_6_6 = HeroModel.instance:getById(iter_6_1)
		local var_6_7 = iter_6_0 - 1

		if var_6_6 and var_6_6:hasDefaultEquip() and var_6_6.defaultEquipUid ~= var_6_1[var_6_7].equipUid[1] then
			if var_6_7 <= arg_6_0:_checkEquipInPreviousEquip(var_6_7 - 1, var_6_6.defaultEquipUid, var_6_1) then
				local var_6_8 = arg_6_0:_checkEquipInBehindEquip(var_6_7 + 1, var_6_6.defaultEquipUid, var_6_1)

				if var_6_8 > 0 then
					var_6_1[var_6_8].equipUid[1] = var_6_1[var_6_7].equipUid[1]
				end

				var_6_1[var_6_7].equipUid[1] = var_6_6.defaultEquipUid
			elseif var_6_1[var_6_7].equipUid[1] == var_6_6.defaultEquipUid then
				var_6_1[var_6_7].equipUid[1] = "0"
			end

			var_6_5 = true
		end
	end

	return var_6_5
end

function var_0_0._checkEquipInBehindEquip(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if not EquipModel.instance:getEquip(arg_7_2) then
		return -1
	end

	for iter_7_0 = arg_7_1, #arg_7_3 do
		if arg_7_2 == arg_7_3[iter_7_0].equipUid[1] then
			return iter_7_0
		end
	end

	return -1
end

function var_0_0._checkEquipInPreviousEquip(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if not EquipModel.instance:getEquip(arg_8_2) then
		return arg_8_1 + 1
	end

	for iter_8_0 = arg_8_1, 0, -1 do
		if arg_8_2 == arg_8_3[iter_8_0].equipUid[1] then
			return iter_8_0
		end
	end

	return arg_8_1 + 1
end

function var_0_0._onGetFightRecordGroupReply(arg_9_0, arg_9_1)
	FightController.instance:unregisterCallback(FightEvent.RespGetFightRecordGroupReply, arg_9_0._onGetFightRecordGroupReply, arg_9_0)
	HeroGroupModel.instance:setReplayParam(arg_9_1)
	ViewMgr.instance:openView(arg_9_0._groupFightName)
end

function var_0_0.onReceiveHeroGroupSnapshot(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1.snapshotId
	local var_10_1 = arg_10_1.snapshotSubId
end

function var_0_0.removeEquip(arg_11_0, arg_11_1)
	if HeroSingleGroupModel.instance:isTemp() or arg_11_1 then
		local var_11_0, var_11_1, var_11_2 = EquipTeamListModel.instance:_getRequestData(arg_11_0, "0")
		local var_11_3 = {
			index = var_11_1,
			equipUid = var_11_2
		}

		V1a6_CachotHeroGroupModel.instance:replaceEquips(var_11_3, EquipTeamListModel.instance:getCurGroupMo())

		if not arg_11_1 then
			HeroGroupController.instance:dispatchEvent(HeroGroupEvent.ChangeEquip, var_11_1)
		end
	else
		V1a6_CachotHeroGroupModel.instance:cachotSaveCurGroup()
	end
end

function var_0_0.replaceEquip(arg_12_0, arg_12_1, arg_12_2)
	if HeroSingleGroupModel.instance:isTemp() or arg_12_2 then
		local var_12_0, var_12_1, var_12_2 = EquipTeamListModel.instance:_getRequestData(arg_12_0, arg_12_1)
		local var_12_3 = {
			index = var_12_1,
			equipUid = var_12_2
		}

		V1a6_CachotHeroGroupModel.instance:replaceEquips(var_12_3, EquipTeamListModel.instance:getCurGroupMo())

		if not arg_12_2 then
			HeroGroupController.instance:dispatchEvent(HeroGroupEvent.ChangeEquip, var_12_1)
		end
	else
		V1a6_CachotHeroGroupModel.instance:cachotSaveCurGroup()
	end
end

function var_0_0.getFightFocusEquipInfo(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1.posIndex
	local var_13_1 = arg_13_1.equipMO
	local var_13_2 = V1a6_CachotTeamModel.instance:getSeatLevel(var_13_0)

	if not var_13_2 then
		return var_13_1
	end

	local var_13_3 = V1a6_CachotTeamModel.instance:getEquipMaxLevel(var_13_1, var_13_2)

	if var_13_3 == var_13_1.level then
		return var_13_1
	end

	local var_13_4 = EquipMO.New()

	var_13_4:initByConfig(nil, var_13_1.equipId, var_13_3, var_13_1.refineLv)

	return var_13_4
end

function var_0_0.getCharacterTipEquipInfo(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_1.seatLevel
	local var_14_1 = arg_14_1.equipMO
	local var_14_2 = V1a6_CachotTeamModel.instance:getEquipMaxLevel(var_14_1, var_14_0)

	if var_14_2 == var_14_1.level then
		return var_14_1
	end

	local var_14_3 = EquipMO.New()

	var_14_3:initByConfig(nil, var_14_1.equipId, var_14_2, var_14_1.refineLv)

	return var_14_3
end

var_0_0.instance = var_0_0.New()

return var_0_0
