module("modules.logic.herogroup.rpc.HeroGroupRpc", package.seeall)

local var_0_0 = class("HeroGroupRpc", BaseRpc)

function var_0_0.sendGetHeroGroupListRequest(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = HeroGroupModule_pb.GetHeroGroupListRequest()

	return arg_1_0:sendMsg(var_1_0, arg_1_1, arg_1_2)
end

function var_0_0.onReceiveGetHeroGroupListReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == 0 then
		HeroGroupModel.instance:onGetHeroGroupList(arg_2_2.groupInfoList)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnGetHeroGroupList)
	end
end

function var_0_0.sendUpdateHeroGroupRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, arg_3_6, arg_3_7, arg_3_8)
	local var_3_0 = HeroGroupModule_pb.UpdateHeroGroupRequest()

	var_3_0.groupInfo.groupId = arg_3_1
	var_3_0.groupInfo.name = arg_3_3 or ""

	if arg_3_4 then
		var_3_0.groupInfo.clothId = arg_3_4
	end

	if arg_3_2 then
		for iter_3_0, iter_3_1 in ipairs(arg_3_2) do
			table.insert(var_3_0.groupInfo.heroList, iter_3_1)
		end
	end

	if arg_3_5 then
		for iter_3_2 = 0, 3 do
			local var_3_1 = arg_3_5[iter_3_2]

			if var_3_1 then
				local var_3_2 = HeroDef_pb.HeroGroupEquip()

				var_3_2.index = var_3_1.index

				for iter_3_3, iter_3_4 in ipairs(var_3_1.equipUid) do
					table.insert(var_3_2.equipUid, iter_3_4)
				end

				table.insert(var_3_0.groupInfo.equips, var_3_2)
			end
		end
	end

	arg_3_0:sendMsg(var_3_0, arg_3_7, arg_3_8)
end

function var_0_0.onReceiveUpdateHeroGroupReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == 0 then
		HeroGroupModel.instance:onModifyHeroGroup(arg_4_2.groupInfo)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
	end
end

function var_0_0.sendSetHeroGroupEquipRequest(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = HeroGroupModule_pb.SetHeroGroupEquipRequest()

	var_5_0.groupId = arg_5_1
	var_5_0.equip.index = arg_5_2

	for iter_5_0, iter_5_1 in ipairs(arg_5_3) do
		table.insert(var_5_0.equip.equipUid, iter_5_1)
	end

	if Activity104Model.instance:isSeasonChapter() then
		local var_5_1 = HeroGroupModel.instance:getCurGroupMO()

		var_5_1.equips[arg_5_2].equipUid = arg_5_3

		var_5_1:updatePosEquips(var_5_0.equip)
		HeroGroupModel.instance:saveCurGroupData()

		return
	end

	arg_5_0:sendMsg(var_5_0)
end

function var_0_0.onReceiveSetHeroGroupEquipReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 ~= 0 then
		return
	end

	local var_6_0 = arg_6_2.groupId
	local var_6_1 = arg_6_2.equip
	local var_6_2 = HeroGroupModel.instance:getById(var_6_0)

	if var_6_2 then
		var_6_2:updatePosEquips(var_6_1)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.ChangeEquip, var_6_1.index)

		if arg_6_0._showSetHeroGroupEquipTip then
			arg_6_0._showSetHeroGroupEquipTip()

			arg_6_0._showSetHeroGroupEquipTip = nil
		end
	end
end

function var_0_0.sendSetHeroGroupSnapshotRequest(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5)
	arg_7_3.snapshotId = arg_7_1
	arg_7_3.snapshotSubId = arg_7_2

	arg_7_0:sendMsg(arg_7_3, arg_7_4, arg_7_5)
end

function var_0_0.onReceiveSetHeroGroupSnapshotReply(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 ~= 0 then
		return
	end

	logNormal("编队快照保存成功")
	HeroGroupController.instance:onReceiveHeroGroupSnapshot(arg_8_2)

	if arg_8_0._showSetHeroGroupEquipTip then
		arg_8_0._showSetHeroGroupEquipTip()

		arg_8_0._showSetHeroGroupEquipTip = nil
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnSnapshotSaveSucc, arg_8_2.snapshotId, arg_8_2.snapshotSubId)
end

function var_0_0.onReceiveUpdateHeroGroupPush(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 == 0 then
		HeroGroupModel.instance:onModifyHeroGroup(arg_9_2.groupInfo)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
	end
end

function var_0_0.sendGetHeroGroupCommonListRequest(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = HeroGroupModule_pb.GetHeroGroupCommonListRequest()

	return arg_10_0:sendMsg(var_10_0, arg_10_1, arg_10_2)
end

function var_0_0.onReceiveGetHeroGroupCommonListReply(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_1 == 0 then
		HeroGroupModel.instance:onGetCommonGroupList(arg_11_2)
	end
end

function var_0_0.sendChangeHeroGroupSelectRequest(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = HeroGroupModule_pb.ChangeHeroGroupSelectRequest()

	var_12_0.id = arg_12_1
	var_12_0.currentSelect = arg_12_2

	arg_12_0:sendMsg(var_12_0)
end

function var_0_0.onReceiveChangeHeroGroupSelectReply(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_1 == 0 then
		-- block empty
	end
end

function var_0_0.sendUpdateHeroGroupNameRequest(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4, arg_14_5)
	local var_14_0 = HeroGroupModule_pb.UpdateHeroGroupNameRequest()

	var_14_0.id = arg_14_1
	var_14_0.currentSelect = arg_14_2
	var_14_0.name = arg_14_3

	arg_14_0:sendMsg(var_14_0, arg_14_4, arg_14_5)
end

function var_0_0.onReceiveUpdateHeroGroupNameReply(arg_15_0, arg_15_1, arg_15_2)
	return
end

function var_0_0.sendGetHeroGroupSnapshotListRequest(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = HeroGroupModule_pb.GetHeroGroupSnapshotListRequest()

	var_16_0.snapshotId = arg_16_1

	arg_16_0:sendMsg(var_16_0, arg_16_2, arg_16_3)
end

function var_0_0.onReceiveGetHeroGroupSnapshotListReply(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_1 == 0 then
		HeroGroupSnapshotModel.instance:onReceiveGetHeroGroupSnapshotListReply(arg_17_2)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
